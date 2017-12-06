using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SMSHanderler.PortalManage
{
    /// <summary>
    /// NoticesHandler 的摘要说明
    /// </summary>
    public class NoticesHandler : IHttpHandler
    {
        SMSBLL.NoticesService BllNotice = new SMSBLL.NoticesService();
        SMSBLL.System_NoticeService BllSNS = new SMSBLL.System_NoticeService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request["func"];
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "GetNoticeAll": GetNoticeAll(context); break;
                    case "GetNewsAll": GetNewsAll(context); break;
                    case "GetPageList": GetPageList(context); break;
                    case "UpdateNotice": UpdateNotice(context); break;
                    case "EditNotice": EditNotice(context); break;
                }
            }
            else
            {
                context.Response.Write("System Error");
            }
        }

        public void GetNoticeAll(HttpContext context)
        {
            Hashtable ht = new Hashtable();
            if (!string.IsNullOrWhiteSpace(context.Request["top"]))
                ht.Add("top", context.Request["top"]);
            if (!string.IsNullOrWhiteSpace(context.Request["type"]))
                ht.Add("type", context.Request["type"]);
            if (!string.IsNullOrWhiteSpace(context.Request["tys"]))
                ht.Add("tys", context.Request["tys"]);
            if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                ht.Add("Id", context.Request["Id"]);
            if (!string.IsNullOrWhiteSpace(context.Request["Root"]))
                ht.Add("Root", context.Request["Root"]);
            if (!string.IsNullOrWhiteSpace(context.Request["isPush"]))
                ht.Add("isPush", context.Request["isPush"]);
            SMSModel.JsonModel Model = BllNotice.GetNoticeAll(ht);
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
        }

        public void GetNewsAll(HttpContext context)
        {
            Hashtable ht = new Hashtable();
            if (!string.IsNullOrWhiteSpace(context.Request["top"]))
                ht.Add("top", context.Request["top"]);
            if (!string.IsNullOrWhiteSpace(context.Request["tys"]))
                ht.Add("tys", context.Request["tys"]);
            if (!string.IsNullOrWhiteSpace(context.Request["Root"]))
                ht.Add("Root", context.Request["Root"]);
            if (!string.IsNullOrWhiteSpace(context.Request["isPush"]))
                ht.Add("isPush", context.Request["isPush"]);
            SMSModel.JsonModel Model = BllNotice.GetNewsAll(ht);
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
        }

        public void GetPageList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());
                ht.Add("TableName", "System_Notice");
                string where = string.Empty;
                if (!string.IsNullOrWhiteSpace(context.Request["type"]))
                    where += " and [type]=" + context.Request["type"].ToString();
                if (!string.IsNullOrWhiteSpace(context.Request["Root"]))
                    where += " and ([Root]=0 or [Root]=" + context.Request["Root"]+")";
                if (!string.IsNullOrWhiteSpace(context.Request["isPush"]))
                    where += " and isPush=" + context.Request["isPush"];
                if (!string.IsNullOrWhiteSpace(context.Request["StarDate"]) && !string.IsNullOrWhiteSpace(context.Request["EndDate"]))
                    where += " and ([CreateTime]>='" + context.Request["StarDate"].ToString() + " 00:00:00' and [CreateTime]<='" + context.Request["EndDate"].ToString() + " 23:59:59')";
                if (!string.IsNullOrWhiteSpace(context.Request["keyWord"]))
                    where += " and (Title+Contents like '%" + context.Request["keyWord"].ToString()+"%')";
                where += " and IsDelete !=" + (int)SysStatus.删除;
                ht.Add("Order", "Hot desc,T.SortId desc,T.CreateTime desc,T.ClickNum asc");
                SMSModel.JsonModel Model = BllSNS.GetPage(ht, true, where);
                System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
                context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    retData = "",
                    status = "no"
                };
                System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void EditNotice(HttpContext context)
        {
            SMSModel.JsonModel jsonModel = new SMSModel.JsonModel();
            try
            {
                string Title = context.Request["Title"];
                string Contents = HttpUtility.UrlDecode(context.Request["Contents"]);
                int Hot = int.Parse(context.Request["Hot"]);
                int SortId = context.Request["SortId"] == "" ? 0 : int.Parse(context.Request["SortId"]);
                int ClickNum = context.Request["ClickNum"] == "" ? 0 : int.Parse(context.Request["ClickNum"]);

                int Type = context.Request["Type"]==""?0:int.Parse(context.Request["Type"]);
                int root = context.Request["Root"] == "" ? 0 : int.Parse(context.Request["Root"]);
                int isPush=context.Request["isPush"] == "" ? 0 : int.Parse(context.Request["isPush"]);
                string ShowImgUrl = context.Request["ShowImgUrl"];
                string FileName = context.Request["FileName"];
                string FilePath = context.Request["FilePath"];
                SMSModel.System_Notice sn = new SMSModel.System_Notice();
                sn.ClickNum = ClickNum;
                sn.Contents = Contents;
                sn.Hot = Hot;
                sn.ShowImgUrl = ShowImgUrl;
                sn.SortId = SortId;
                sn.Title = Title;
                sn.Type = Type;
                sn.FileName = FileName;
                sn.FilePath = FilePath;
                sn.Root = root;
                sn.isPush = isPush;
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    int Id = int.Parse(context.Request["Id"]);

                    sn.Id = Id;
                    jsonModel = BllSNS.Update(sn);
                }
                else
                {
                    DateTime CreateTime = DateTime.Now;
                    string Creator = context.Request["Creator"];
                    int IsDelete = Convert.ToInt16(SysStatus.正常);
                    sn.CreateTime = CreateTime;
                    sn.Creator = Creator;
                    sn.IsDelete = Convert.ToByte(IsDelete);
                    jsonModel = BllSNS.Add(sn);

                }
                System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
                jsonModel.status = "ok";
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    retData = "",
                    status = "no"
                };
                System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void UpdateNotice(HttpContext context)
        {
            if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
            {
                System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
                try
                {
                    SMSModel.System_Notice sn = BllSNS.GetEntityById(int.Parse(context.Request["Id"])).retData as SMSModel.System_Notice;
                    if (sn != null)
                    {
                        if (!string.IsNullOrWhiteSpace(context.Request["Hot"]))
                            sn.Hot = int.Parse(context.Request["Hot"]);
                        if (!string.IsNullOrWhiteSpace(context.Request["IsDelete"]))
                            sn.IsDelete = Convert.ToByte(context.Request["IsDelete"]);
                        if (!string.IsNullOrWhiteSpace(context.Request["ClickNum"]))
                            sn.ClickNum = sn.ClickNum + 1;
                        if (!string.IsNullOrWhiteSpace(context.Request["isPush"]))
                            sn.isPush = int.Parse(context.Request["isPush"]);
                        SMSModel.JsonModel jsonModel = BllSNS.Update(sn);
                        jsonModel.status = "yes";
                        context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
                    }
                }
                catch (Exception ex)
                {
                    SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                    {
                        errMsg = ex.Message,
                        retData = "",
                        status = "no"
                    };
                    context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
                }
            }
        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}