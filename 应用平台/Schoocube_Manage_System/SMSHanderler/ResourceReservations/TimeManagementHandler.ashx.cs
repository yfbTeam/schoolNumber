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
    /// TimeIntervaManagementHandler 的摘要说明
    /// </summary>
    public class TimeManagementHandler : IHttpHandler
    {
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JsonModel jsonModelTime = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        TimeManagementService resourceService = new TimeManagementService();
        ResourceReservationService rrService = new ResourceReservationService();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string func = context.Request["Func"];
            string result = string.Empty;
            try
            {
                switch (func)
                {
                    case "GetTimeManagementList":
                        GetTimeManagementList(context);
                        break;
                    case "AddTime":
                        AddTime(context);
                        break;
                    case "DelTime":
                        DelTime(context);
                        break;
                    case "GetDataByID":
                        GetDataByID(context);
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
        #region 获取数据

        /// <summary>
        /// 获取数据
        /// </summary>
        /// <param name="context"></param>
        private void GetDataByID(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "TimeManagement");

                jsonModel = resourceService.GetPage(ht, false, " and ID=" + context.Request["ID"].SafeToString());
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
        #region 获取数据

        /// <summary>
        /// 获取数据
        /// </summary>
        /// <param name="context"></param>
        private void GetTimeManagementList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "TimeManagement");
                ht.Add("TimeIntervalId", context.Request["TimeIntervalId"] ?? "");
                ht.Add("GetTime", context.Request["GetTime"] ?? "");
                ht.Add("Name", context.Request["Name"] ?? "");
                ht.Add("ResourceId", context.Request["ResourceId"] ?? "");
                ht.Add("ValidateTime", context.Request["ValidateTime"] ?? "");
                bool ispage = true;
                if (!string.IsNullOrEmpty(context.Request["ispage"]))
                {
                    ispage = Convert.ToBoolean(context.Request["ispage"]);
                }
                if (ispage)
                {
                    ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                    ht.Add("PageSize", context.Request["pageSize"].SafeToString());
                }
                jsonModel = resourceService.GetPage(ht, ispage);
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
        private void AddTime(HttpContext context)
        {
            try
            {

                TimeManagement resource = new TimeManagement();
                if (!string.IsNullOrEmpty(context.Request["BeginTime"]))
                {
                    resource.BeginTime = context.Request["BeginTime"];
                }
                if (!string.IsNullOrEmpty(context.Request["EndTime"]))
                {
                    resource.EndTime = context.Request["EndTime"];
                }
                if (!string.IsNullOrEmpty(context.Request["TimeIntervalId"]))
                {
                    resource.TimeIntervalId = Convert.ToInt32(context.Request["TimeIntervalId"]);
                }

                if (!string.IsNullOrEmpty(context.Request["jsonAddTimeDate"]))
                {
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    var arrAdd = (Dictionary<string, string>[])js.Deserialize<Dictionary<string, string>[]>(context.Request["jsonAddTimeDate"]);
                    for (var j = 0; j < arrAdd.Length; j++)
                    {
                        foreach (KeyValuePair<string, string> dic in arrAdd[j])
                        {
                            if (dic.Key == "startTimeDate")
                            {
                                resource.BeginTime = dic.Value;
                            }
                            if (dic.Key == "endTimeDate")
                            {
                                resource.EndTime = dic.Value;
                            }

                        }
                        resource.Creator = context.Request["UserName"];
                        resource.CreateTime = DateTime.Now;
                        jsonModel = resourceService.Add(resource);
                    }
                    //for (var i = 0; i < arr.Length; i++)
                    //{
                    //    foreach (var strKey in arr[i].Keys)
                    //    {
                    //        if (strKey == "startTimeDate")
                    //        {
                    //            resource.BeginTime = arr[i].Values.SafeToString();
                    //        }
                    //        if (strKey == "endTimeDate")
                    //        {
                    //            resource.EndTime = arr[i].Values.SafeToString();
                    //        }
                    //        resource.Creator = context.Request["UserName"];
                    //        resource.CreateTime = DateTime.Now;
                    //        jsonModel = resourceService.Add(resource);
                    //    }
                    //}


                }

                if (!string.IsNullOrEmpty(context.Request["jsonUpdateTimeDate"]))
                {
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    var dic = (Dictionary<string, string>[])js.Deserialize<Dictionary<string, string>[]>(context.Request["jsonUpdateTimeDate"]);
                    for (var j = 0; j < dic.Length; j++)
                    {
                        foreach (KeyValuePair<string, string> kv in dic[j])
                        {
                            if (kv.Key == "startTimeDate")
                            {
                                resource.BeginTime = kv.Value;
                            }
                            if (kv.Key == "endTimeDate")
                            {
                                resource.EndTime = kv.Value;
                            }
                            if (kv.Key == "Id")
                            {
                                resource.Id = Convert.ToInt32(kv.Value);
                            }

                        }
                        //resource.Id = Convert.ToInt32(context.Request["Id"]);
                        resource.Editor = context.Request["UserName"];
                        resource.UpdateTime = DateTime.Now;
                        jsonModel = resourceService.Update(resource);
                    }
                }
                if (string.IsNullOrEmpty(context.Request["arrValue"]))
                {
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

        private void DelTime(HttpContext context)
        {
            try
            {

                string ids = context.Request["ID"] == null ? "" : context.Request["ID"].ToString();
                int id = Convert.ToInt32(ids);
                jsonModel = resourceService.GetEntityById(id);
                if (jsonModel.errNum == 0)
                {
                    TimeManagement tm = new TimeManagement();
                    tm.Id = id;
                    tm.IsDelete = 1;
                    tm.Editor = context.Request["UserName"];
                    tm.UpdateTime = DateTime.Now;
                    jsonModel = resourceService.Update(tm);
                    //if (jsonModel.errNum == 0)
                    //{
                    //    jsonModelTime = rrService.GetEntityListByField("TimeInterval", ids);
                    //    if (jsonModelTime.errNum == 0)
                    //    {
                    //        ResourceReservation rr = new ResourceReservation();
                    //        List<ResourceReservation> rrList = (List<ResourceReservation>)jsonModelTime.retData;
                    //        for (var i = 0; i < rrList.Count; i++)
                    //        {
                    //            rr.Id = rrList[i].Id;
                    //            rr.IsDelete = 1;
                    //            rr.Editor = context.Request["UserName"];
                    //            rr.UpdateTime = DateTime.Now;
                    //            jsonModelTime = rrService.Update(rr);
                    //        }
                    //    }

                    //}


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