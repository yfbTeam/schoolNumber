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
    /// ResourceReservationHandler 的摘要说明
    /// </summary>
    public class ResourceReservationHandler : IHttpHandler
    {

        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        ResourceReservationService resourceService = new ResourceReservationService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string func = context.Request["Func"];
            string result = string.Empty;
            try
            {
                switch (func)
                {
                    case "GetPageList":
                        GetPageList(context);
                        break;
                    case "AddResourceReservation":
                        AddResourceReservation(context);
                        break;
                    case "DelResourceReservation":
                        DelResourceReservation(context);
                        break;
                    case "ChangeStatus":
                        ChangeStatus(context);
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

        #region 获取资源表的分页数据
        private void GetPageList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ID", context.Request["ID"] ?? "");
                ht.Add("ResourceTypeName", context.Request["ResourceTypeName"] ?? "");
                ht.Add("AppoIntmentTime", context.Request["AppoIntmentTime"] ?? "");
                ht.Add("TimeInterval", context.Request["TimeInterval"] ?? "");
                ht.Add("ReservationTimeInterval", context.Request["ReservationTimeInterval"] ?? "");
                ht.Add("ReservationAppoIntmentTime", context.Request["ReservationAppoIntmentTime"] ?? "");
                ht.Add("ReSourceInfoId", context.Request["ReSourceInfoId"] ?? "");
                ht.Add("ReSourceClassId", context.Request["ReSourceClassId"] ?? "");
                ht.Add("IDCard", context.Request["IDCard"] ?? "");
                ht.Add("ApprovalStutus", context.Request["ApprovalStutus"] ?? "");
                ht.Add("TableName", "ResourceReservation");
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

        private void AddResourceReservation(HttpContext context)
        {
            try
            {
                ResourceReservation resource = new ResourceReservation();
                if (!string.IsNullOrEmpty(context.Request["ReSourceInfoId"]))
                {
                    resource.ReSourceInfoId = Convert.ToInt32(context.Request["ReSourceInfoId"]);
                }
                if (!string.IsNullOrEmpty(context.Request["ReSourceClassId"]))
                {
                    resource.ReSourceClassId = Convert.ToInt32(context.Request["ReSourceClassId"]);
                }
                if (!string.IsNullOrEmpty(context.Request["TimeInterval"]))
                {
                    resource.TimeInterval = context.Request["TimeInterval"];
                }
                if (!string.IsNullOrEmpty(context.Request["AppoIntmentTime"]))
                {
                    resource.AppoIntmentTime =Convert.ToDateTime(context.Request["AppoIntmentTime"]);
                }
                if (!string.IsNullOrEmpty(context.Request["Name"]))
                {
                    resource.Name = context.Request["Name"];
                }

                if (!string.IsNullOrEmpty(context.Request["School"]))
                {
                    resource.School = context.Request["School"];
                }

                if (!string.IsNullOrEmpty(context.Request["Address"]))
                {
                    resource.Address = context.Request["Address"];
                }

                if (!string.IsNullOrEmpty(context.Request["Telephone"]))
                {
                    resource.Telephone = context.Request["Telephone"];
                }

                if (!string.IsNullOrEmpty(context.Request["Remark"]))
                {
                    resource.Remark = context.Request["Remark"];
                }
                if (!string.IsNullOrEmpty(context.Request["ApprovalStutus"]))
                {
                    resource.ApprovalStutus =Convert.ToByte(context.Request["ApprovalStutus"]);
                }
                if (!string.IsNullOrEmpty(context.Request["ApprovalOpinion"]))
                {
                    resource.ApprovalOpinion = context.Request["ApprovalOpinion"];
                }
                
                if (!string.IsNullOrEmpty(context.Request["UserIdCard"]))
                {
                    resource.IDCard = context.Request["UserIdCard"];
                }

                if (!string.IsNullOrEmpty(context.Request["ApprovalPeople"]))
                {
                    resource.ApprovalPeople = context.Request["ApprovalPeople"];
                }

                if (!string.IsNullOrEmpty(context.Request["ID"]))
                {
                    resource.Id = Convert.ToInt32(context.Request["ID"]);
                    //if (!string.IsNullOrEmpty(context.Request["status"]))
                    //{
                    //    if ("0".Equals(context.Request["status"]))
                    //    {
                    //        resource.ApprovalStutus = 1;
                    //    }
                    //}
                    resource.Editor = context.Request["UserName"]; ;
                    resource.UpdateTime = DateTime.Now;
                    jsonModel = resourceService.Update(resource);
                }
                else
                {
                    resource.Applicant = context.Request["UserName"]; ;
                    resource.Creator = context.Request["UserName"]; ;
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

        private void DelResourceReservation(HttpContext context)
        {
            int id = 0;
            if (context.Request["ID"] == null || !string.IsNullOrEmpty(context.Request["ID"].ToString()))
            {
                id = Convert.ToInt32(context.Request["ID"]);
            }
            jsonModel = resourceService.GetEntityById(id);
            if (jsonModel.errNum == 0)
            {
                ResourceReservation resource = jsonModel.retData as ResourceReservation;
                resource.Id = id;
                resource.IsDelete = 1;
                resource.Editor= context.Request["UserName"];
                resource.UpdateTime = DateTime.Now;
                jsonModel = resourceService.Update(resource);
            }
        }

        #endregion

        #region 更改状态
        public void ChangeStatus(HttpContext context)
        {
            ResourceReservation resource = new ResourceReservation();
            resource.Id = Convert.ToInt32(context.Request["Id"]);
            resource.UseStatus = Convert.ToByte(context.Request["Status"]);
            resource.IsDelete = 1;
            resource.Editor = context.Request["UserName"];
            resource.UpdateTime = DateTime.Now;
            jsonModel = resourceService.Update(resource);
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