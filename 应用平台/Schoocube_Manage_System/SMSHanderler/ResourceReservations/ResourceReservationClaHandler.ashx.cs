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
    /// ResourceReservationCla 的摘要说明
    /// </summary>
    public class ResourceReservationClaHandler : IHttpHandler
    {
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        ResourceReservationClaService courcebll = new ResourceReservationClaService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string func = context.Request["Func"];
            string result = string.Empty;
            try
            {
                switch (func)
                {
                    case "GetLeftMenu":
                        GetLeftMenu(context);
                        break;

                    case "AddNewResourceMenu":
                        AddNewResourceMenu(context);
                        break;
                    case "DelResourceMenu":
                        DelResourceMenu(context);
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
        /// 获取左侧导航
        /// </summary>
        /// <param name="context"></param>
        private void GetLeftMenu(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "ResourceReservationCla");
                ht.Add("ID", context.Request["ID"] ?? "");
                ht.Add("PID", context.Request["PID"] ?? "");
                ht.Add("CPID", context.Request["CPID"] ?? "");


                jsonModel = courcebll.GetPage(ht, false);
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
        /// <summary>
        /// 添加左侧导航
        /// </summary>
        /// <param name="context"></param>
        private void AddNewResourceMenu(HttpContext context)
        {
            try
            {
                ResourceReservationCla resource = new ResourceReservationCla();
                if (!string.IsNullOrEmpty(context.Request["Name"]))
                {
                    resource.Name = context.Request["Name"];
                }
                if (!string.IsNullOrEmpty(context.Request["PId"]))
                {
                    resource.PId = Convert.ToInt32(context.Request["PId"]);
                }
                if (!string.IsNullOrEmpty(context.Request["Id"]))
                {
                    resource.Id = Convert.ToInt32(context.Request["Id"]);
                    resource.Editor = context.Request["UserName"]; ;
                    resource.UpdateTime = DateTime.Now;
                    jsonModel = courcebll.Update(resource);
                    
                }
                else
                {
                    resource.Creator = context.Request["UserName"]; ;
                    resource.CreateTime = DateTime.Now;
                    jsonModel = courcebll.Add(resource);
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

        /// <summary>
        /// 删除左侧导航
        /// </summary>
        /// <param name="context"></param>
        private void DelResourceMenu(HttpContext context)
        {
            try
            {
                
                string ids = context.Request["ID"] == null ? "" : context.Request["ID"].ToString();
                if (ids.Contains(","))
                {
                    string[] idarry = ids.TrimEnd(',').Split(',');
                    int length = idarry.Length;
                    int[] intids = new int[length];
                    for (int i = 0; i < ids.Length; i++)
                    {
                        string item = idarry[i];
                        intids[i] = int.Parse(item);
                        jsonModel = courcebll.GetEntityById(intids[i]);
                        if (jsonModel.errNum == 0)
                        {
                            ResourceReservationCla resourceInfo = jsonModel.retData as ResourceReservationCla;
                            resourceInfo.Id = intids[i];
                            resourceInfo.IsDelete = 1;
                            resourceInfo.Editor= context.Request["UserName"];
                            resourceInfo.UpdateTime = DateTime.Now;
                            jsonModel = courcebll.Update(resourceInfo);
                        }
                    }

                }
                else
                {
                    int id = Convert.ToInt32(context.Request["ID"]);
                    jsonModel = courcebll.GetEntityById(id);
                    if (jsonModel.errNum == 0)
                    {
                        ResourceReservationCla resourceInfo = jsonModel.retData as ResourceReservationCla;
                        resourceInfo.Id = id;
                        resourceInfo.IsDelete = 1;
                        resourceInfo.Editor = context.Request["UserName"];
                        resourceInfo.UpdateTime = DateTime.Now;
                        jsonModel = courcebll.Update(resourceInfo);
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