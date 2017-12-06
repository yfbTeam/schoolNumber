using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SMSHanderler.PortalManage
{
    /// <summary>
    /// AdvertisingHandler 的摘要说明
    /// </summary>
    public class AdvertisingHandler : IHttpHandler
    {
        SMSBLL.AdvertisingService BllAdvert = new SMSBLL.AdvertisingService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request["func"];
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "GetPageList": GetPageList(context); break;
                    case "GetAdvertising": GetAdvertising(context); break;
                    case "GetAdvertisingForId": GetAdvertisingForId(context); break;
                    case "EditAdvertising": EditAdvertising(context); break;
                    case "UpdateAdvertising": UpdateAdvertising(context); break;
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
                if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) ht.Add("PageSize", context.Request["PageSize"].ToString());
                ht.Add("TableName", "Advertising");
                string where = string.Empty;
                if (!string.IsNullOrWhiteSpace(context.Request["MenuId"]))
                    where += " and [MenuId]=" + context.Request["MenuId"].ToString();
                where += " and IsDelete =" + (int)SMSUtility.SysStatus.正常;
                SMSModel.JsonModel Model = BllAdvert.GetPage(ht, true, where);
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

        public void GetAdvertising(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                SMSModel.JsonModel Model = new SMSModel.JsonModel();
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(context.Request["MenuId"]))
                {
                    Model = BllAdvert.GetEntityListByField("MenuId", context.Request["MenuId"]);
                }
                else
                {
                    if (!string.IsNullOrWhiteSpace(context.Request["MenuIds"]))
                    {
                        ht.Add("MenuIds", context.Request["MenuIds"]);
                    }
                    if (!string.IsNullOrWhiteSpace(context.Request["IsDelete"]))
                        ht.Add("IsDelete", context.Request["IsDelete"]);
                    Model = BllAdvert.GetDataInfo(ht);
                }
                context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");

            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    status = "no"
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }

        }

        public void GetAdvertisingForId(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                SMSModel.JsonModel Model = new SMSModel.JsonModel();
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(context.Request["AdvId"]))
                {
                    Model = BllAdvert.GetEntityById(int.Parse(context.Request["AdvId"]));
                }
                context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };

                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }


        public void EditAdvertising(HttpContext context)
        {
            SMSModel.JsonModel jsonModel = new SMSModel.JsonModel();
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                string Id = context.Request["Id"];
                string Description = context.Request["Description"];
                int MenuId = int.Parse(context.Request["MenuId"]);
                string CreativeHTML = HttpUtility.UrlDecode(context.Request["CreativeHTML"]);
                string Creator = context.Request["Creator"];
                SMSModel.Advertising advert = new SMSModel.Advertising();
                advert.Description = Description;
                advert.CreativeHTML = CreativeHTML;
                if (!string.IsNullOrWhiteSpace(Id))
                {
                    advert.Id = int.Parse(context.Request["Id"]);
                    jsonModel = BllAdvert.Update(advert);
                }
                else
                {
                    advert.CreateTime = DateTime.Now;
                    advert.Creator = Creator;
                    advert.MenuId = MenuId;
                    advert.IsDelete = (int)SMSUtility.SysStatus.正常;
                    jsonModel = BllAdvert.Add(advert);
                }

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
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void UpdateAdvertising(HttpContext context)
        {
            if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
            {
                System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
                try
                {
                    SMSModel.Advertising advert = BllAdvert.GetEntityById(int.Parse(context.Request["Id"])).retData as SMSModel.Advertising;
                    if (advert != null)
                    {
                        if (!string.IsNullOrWhiteSpace(context.Request["IsDelete"]))
                            advert.IsDelete = Convert.ToByte(context.Request["IsDelete"]);
                        SMSModel.JsonModel jsonModel = BllAdvert.Update(advert);
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