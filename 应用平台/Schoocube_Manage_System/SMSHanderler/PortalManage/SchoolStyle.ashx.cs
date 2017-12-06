using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SMSHanderler.PortalManage
{
    /// <summary>
    /// SchoolStyle 的摘要说明
    /// </summary>
    public class SchoolStyle : IHttpHandler
    {
        SMSBLL.SchoolStyleService BllSSS = new SMSBLL.SchoolStyleService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request["func"];
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "GetPageList": GetPageList(context); break;
                    case "UpdateSchoolStyle": UpdateSchoolStyle(context); break;
                    case "EditSchoolStyle": EditSchoolStyle(context); break;
                    case "GetDataInfo": GetDataInfo(context); break;
                }
            }
            else
            {
                context.Response.Write("System Error");
            }
        }

        public void GetPageList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                var isPage = true;
                if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) ht.Add("PageSize", context.Request["PageSize"].ToString());
                ht.Add("TableName", "SchoolStyle");
                string where = string.Empty;
                if (!string.IsNullOrWhiteSpace(context.Request["MenuId"])) where += " and MenuId=" + context.Request["MenuId"];
                if (!string.IsNullOrWhiteSpace(context.Request["isPage"])) isPage = Convert.ToBoolean(context.Request["isPage"]);
                where += " and IsDelete !=" + (int)SysStatus.删除;
                ht.Add("Order", "SortId desc,CreateTime desc");
                SMSModel.JsonModel Model = BllSSS.GetPage(ht, isPage, where);
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

        public void EditSchoolStyle(HttpContext context)
        {
            SMSModel.JsonModel jsonModel = new SMSModel.JsonModel();
            try
            {
                string Title = context.Request["Title"];
                string ShowImgUrl = context.Request["ImageUrl"];
                SMSModel.SchoolStyle sn = new SMSModel.SchoolStyle();
                sn.ImageUrl = ShowImgUrl;
                sn.Title = Title;
                sn.Description = HttpUtility.UrlDecode(context.Request["Description"]);
                sn.FileName = context.Request["FileName"];
                sn.FilePath = context.Request["FilePath"];
                if (!string.IsNullOrWhiteSpace(context.Request["SortId"])) sn.SortId = Convert.ToInt32(context.Request["SortId"]);
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    int Id = int.Parse(context.Request["Id"]);

                    sn.Id = Id;
                    jsonModel = BllSSS.Update(sn);
                }
                else
                {
                    DateTime CreateTime = DateTime.Now;
                    if (!string.IsNullOrWhiteSpace(context.Request["Creator"])) sn.Creator = context.Request["Creator"];
                    int IsDelete = Convert.ToInt16(SysStatus.正常);
                    sn.MenuId = int.Parse(context.Request["MenuId"]);
                    sn.CreateTime = CreateTime;
                    
                    sn.IsDelete = Convert.ToByte(IsDelete);
                    jsonModel = BllSSS.Add(sn);

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

        public void UpdateSchoolStyle(HttpContext context)
        {
            if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
            {
                System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
                try
                {
                    SMSModel.SchoolStyle sn = BllSSS.GetEntityById(int.Parse(context.Request["Id"])).retData as SMSModel.SchoolStyle;
                    if (sn != null)
                    {
                        if (!string.IsNullOrWhiteSpace(context.Request["IsDelete"]))
                            sn.IsDelete = Convert.ToByte(context.Request["IsDelete"]);
                        if (!string.IsNullOrWhiteSpace(context.Request["ShowImgUrl"]) && "delImg" == context.Request["ShowImgUrl"])
                            sn.ImageUrl = "";
                        SMSModel.JsonModel jsonModel = BllSSS.Update(sn);
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

        public void GetDataInfo(HttpContext context)
        {
            try
            {
                SMSModel.JsonModel Model = new SMSModel.JsonModel();
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    Model = BllSSS.GetEntityById(int.Parse(context.Request["Id"]));
                }
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

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}