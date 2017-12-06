using SMSBLL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SMSHanderler.ResourceReservations
{
    /// <summary>
    /// ResourceTimeMappingIdHandler 的摘要说明
    /// </summary>
    public class ResourceTimeMappingIdHandler : IHttpHandler
    {

        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        ResourceTimeMappingIdService resourceService = new ResourceTimeMappingIdService();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string func = context.Request["Func"];
            string result = string.Empty;
            try
            {
                switch (func)
                {
                    case "GetResourceTimeMapping":
                        GetResourceTimeMapping(context);
                        break;
                    case "AddResourceTimeMapping":
                        AddResourceTimeMapping(context);
                        break;
                    default:
                        jsonModel = new JsonModel()
                        {
                            errNum = 5,
                            errMsg = "没有此方法",
                            retData = ""
                        };
                        break;
                }
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();
        }

        #region 获取左侧导航

        /// <summary>
        /// 获取当前选中树对应的时间段
        /// </summary>
        /// <param name="context"></param>
        private void GetResourceTimeMapping(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "ResourceTimeMappingId");
                ht.Add("ResourceId", context.Request["ResourceId"] ?? "");
                ht.Add("TimeIntervalId", context.Request["TimeIntervalId"] ?? "");
                jsonModel = resourceService.GetPage(ht, false);
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
        }
        #endregion

        #region 添加和更新时间段信息
        /// <summary>
        /// 添加和更新时间段信息
        /// </summary>
        /// <param name="context"></param>
        private void AddResourceTimeMapping(HttpContext context)
        {
            try
            {

                ResourceTimeMappingId resource = new ResourceTimeMappingId();
                if (!string.IsNullOrEmpty(context.Request["TimeIntervalId"]))
                {
                    resource.TimeIntervalId = Convert.ToInt32(context.Request["TimeIntervalId"]);
                }
                if (!string.IsNullOrEmpty(context.Request["ResourceId"]))
                {
                    resource.ResourceId = Convert.ToInt32(context.Request["ResourceId"]);
                }

                if (!string.IsNullOrEmpty(context.Request["Id"]))
                {
                    resource.Id = Convert.ToInt32(context.Request["Id"]);

                    jsonModel = resourceService.Update(resource);
                }
                else
                {
                    jsonModel = resourceService.GetEntityListByField("ResourceId", context.Request["ResourceId"]);
                    if (jsonModel.errNum == 0)
                    {
                        List<ResourceTimeMappingId> list = (List<ResourceTimeMappingId>)jsonModel.retData;
                        if(list.Count == 0)
                        {
                            resource.Creator = context.Request["UserName"];
                            resource.CreateTime = DateTime.Now;
                            jsonModel = resourceService.Add(resource);
                        }else
                        {
                            resource.Id = list[0].Id;
                            jsonModel = resourceService.Update(resource);

                        }
                        
                    }
                }

            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
        }

        #endregion

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}