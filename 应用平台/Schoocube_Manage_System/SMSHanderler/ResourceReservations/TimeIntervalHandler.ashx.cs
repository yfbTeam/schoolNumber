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
    /// TimeIntervalHandler 的摘要说明
    /// </summary>
    public class TimeIntervalHandler : IHttpHandler
    {

        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JsonModel jsonModelTimeManagement = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JsonModel jsonModelMapping = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        TimeIntervalService resourceService = new TimeIntervalService();
        TimeManagementService timeManagementService = new TimeManagementService();
        ResourceTimeMappingIdService resourceTimeMappingIdService = new ResourceTimeMappingIdService();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string func = context.Request["Func"];
            string result = string.Empty;
            try
            {
                switch (func)
                {
                    case "GetRadioData":
                        GetRadioData(context);
                        break;
                    case "GetLeftMenuData":
                        GetLeftMenuData(context);
                        break;
                    case "AddTimeInterval":
                        AddTimeInterval(context);
                        break;
                    case "DelTimeMenu":
                        DelTimeMenu(context);
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

        #region 获取右侧导航

        /// <summary>
        /// 获取右侧导航
        /// </summary>
        /// <param name="context"></param>
        private void GetRadioData(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "TimeInterval");
               // ht.Add("Type", "1");
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

        #region 获取左侧导航

        /// <summary>
        /// 获取左侧导航
        /// </summary>
        /// <param name="context"></param>
        private void GetLeftMenuData(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "TimeInterval");
               // ht.Add("Type", "2");
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

        private void DelTimeMenu(HttpContext context)
        {
            try
            {
                TimeManagement tm = new TimeManagement();
                string ids = context.Request["ID"] == null ? "" : context.Request["ID"].ToString();
                 int id = Convert.ToInt32(ids);
                jsonModel = resourceService.GetEntityById(id);
                if (jsonModel.errNum == 0)
                {
                    jsonModelTimeManagement = timeManagementService.GetEntityListByField("TimeIntervalId", ids);
                    if(jsonModel.errNum == 0)
                    {
                        List<TimeManagement> tmList =  (List<TimeManagement>)jsonModelTimeManagement.retData;
                        if (tmList.Count == 0)
                        {

                        }else
                        {
                            for(int i = 0; i < tmList.Count; i++)
                            {
                               
                                tm.Id = tmList[i].Id;
                                tm.IsDelete = 1;
                                tm.Editor = context.Request["UserName"];
                                tm.UpdateTime = DateTime.Now;
                                jsonModelTimeManagement = timeManagementService.Update(tm);
                            }
                            
                        }

                        jsonModelMapping = resourceTimeMappingIdService.GetEntityListByField("TimeIntervalId", ids);
                        if (jsonModelMapping.errNum == 0)
                        {
                            ResourceTimeMappingId mp = new ResourceTimeMappingId();
                            List<ResourceTimeMappingId> mappingList = (List<ResourceTimeMappingId>)jsonModelMapping.retData;
                            if (mappingList.Count > 0)
                            {
                                mp.Id = mappingList[0].Id;
                                mp.IsDelete = 1;
                                mp.Editor = context.Request["UserName"];
                                mp.UpdateTime = DateTime.Now;
                                jsonModelMapping = resourceTimeMappingIdService.Update(mp);
                            }

                        }

                        TimeInterval resourceInfo = jsonModel.retData as TimeInterval;
                            resourceInfo.Id = id;
                            resourceInfo.IsDelete = 1;
                            resourceInfo.Editor = context.Request["UserName"];
                            resourceInfo.UpdateTime = DateTime.Now;
                            jsonModel = resourceService.Update(resourceInfo);

                        

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

        #region 添加和更新时间段信息
        /// <summary>
        /// 添加和更新时间段信息
        /// </summary>
        /// <param name="context"></param>
        private void AddTimeInterval(HttpContext context)
        {
            try
            {

                TimeInterval resource = new TimeInterval();
                if (!string.IsNullOrEmpty(context.Request["TimeIntervalName"]))
                {
                    resource.TimeIntervalName = context.Request["TimeIntervalName"];
                }
                
                if (!string.IsNullOrEmpty(context.Request["Id"]))
                {
                    resource.Id = Convert.ToInt32(context.Request["Id"]);
                    resource.Editor = context.Request["UserName"];
                    resource.UpdateTime = DateTime.Now;
                    jsonModel = resourceService.Update(resource);
                }
                else
                {
                    resource.Creator = context.Request["UserName"];
                    resource.CreateTime = DateTime.Now;
                    jsonModel = resourceService.Add(resource);
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