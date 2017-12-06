using SMBLL;
using SMModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;

namespace SMHander
{
    /// <summary>
    /// StudySection 的摘要说明
    /// </summary>
    public class GradeHandler : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        SMBLL.Plat_LogInfoService log = new SMBLL.Plat_LogInfoService();
        JsonModel jsonModel = null;
        BLLCommon com = new SMBLL.BLLCommon();
        SMBLL.Plat_GradeService BLL = new Plat_GradeService();
        public void ProcessRequest(HttpContext context)
        {
            string func = context.Request["func"] ?? "";
            try
            {
                switch (func)
                {
                    case "GetGradeData":
                        GetGradeData(context);
                        break;
                    case "GetGradePageData":
                        GetGradePageData(context);
                        break;
                    case "DeleteGrade":
                        DeleteGrade(context);
                        break;
                    case "AddGrade":
                        AddGrade(context);
                        break;
                    case "GetGradeById":
                        GetGradeById(context);
                        break;
                    case "UpdateGrade":
                        UpdateGrade(context);
                        break;
                    case "Plat_GetGradeData":
                        Plat_GetGradeData(context);
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
            string result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        /// <summary>
        /// 获得年级数据
        /// </summary>
        /// <param name="context"></param>
        public void GetGradeData(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();
                string SystemKey = "";
                //获取参数值
                if (context.Request["SystemKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                    SystemKey = context.Request["SystemKey"].ToString();
                }
                if (context.Request["InfKey"] != null)
                {
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                sb.Append(" and IsDelete=0");
                sb.Append(" and periodid in (select periodid from Plat_SchoolOfPeriod a left join Plat_SystemInfo b on a.SchoolID=b.SchoolId where b.SystemKey='" + SystemKey + "' )");
                ht.Add("func", "GetGradeData");
                ht.Add("Columns", "*");
                ht.Add("TableName", "Plat_Grade");
                ht.Add("Where", sb.ToString());
                
                jsonModel = com.GetData(ht);
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
                return;
            }
        }
        /// <summary>
        /// 获得年级数据
        /// </summary>
        /// <param name="context"></param>
        public void Plat_GetGradeData(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();
                string SystemKey = "";
                //获取参数值
                //if (context.Request["SystemKey"] != null)
                //{
                //    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                //    SystemKey = context.Request["SystemKey"].ToString();
                //}
                //if (context.Request["InfKey"] != null)
                //{
                //    ht.Add("InfKey", context.Request["InfKey"].ToString());
                //}
                if (context.Request["SchoolID"] != null)
                {
                    sb.Append(" and b.SchoolID=" + context.Request["SchoolID"].ToString());
                }
                sb.Append(" and a.IsDelete=0");
                //ht.Add("func", "GetGradeData");
                ht.Add("Columns", "a.*");
                ht.Add("TableName", "Plat_Grade a left join Plat_SchoolOfPeriod b on a.PeriodID=b.PeriodID");
                ht.Add("Where", sb.ToString());

                //jsonModel = com.GetData(ht);
                jsonModel = com.GetData_NoVerification(ht);
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
                return;
            }
        }
        /// <summary>
        /// 获得年级分页数据
        /// </summary>
        /// <param name="context"></param>
        public void GetGradePageData(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();

                //获取参数值
                if (context.Request["SystemKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                }
                if (context.Request["InfKey"] != null)
                {
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                if (context.Request["PageIndex"] != null)
                {
                    ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                }
                if (context.Request["PageSize"] != null)
                {
                    ht.Add("PageSize", context.Request["PageSize"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["Name"]))
                {
                    sb.Append(" and a.GradeName like '%" + context.Request["Name"].ToString() + "%'");
                }
                sb.Append(" and a.IsDelete=0");
                ht.Add("func", "GetGradePageData");
                ht.Add("Columns", "a.*,b.Name as PeriodName");
                ht.Add("TableName", "Plat_Grade a left join Plat_Period b on a.PeriodID=b.Id");
                ht.Add("Where", sb.ToString());

                jsonModel = com.GetPagingData(ht);
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
                return;
            }
        }

        /// <summary>
        /// 修改删除状态
        /// </summary>
        /// <param name="context"></param>
        public void DeleteGrade(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();

                //获取参数值
                if (context.Request["SystemKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                }
                if (context.Request["InfKey"] != null)
                {
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    ht.Add("Id", context.Request["Id"].ToString());
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 3,
                        errMsg = "loss",
                        retData = ""
                    };
                    return;
                }

                ht.Add("func", "DeleteGrade");
                jsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jsonModel.errNum != 0)
                {
                    return;
                }
                jsonModel = BLL.DeleteFalse(Convert.ToInt32(ht["Id"].ToString()));
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
                return;
            }
        }

        /// <summary>
        /// 新增年级
        /// </summary>
        /// <param name="context"></param>
        public void AddGrade(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();

                //获取参数值
                if (context.Request["SystemKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                }
                if (context.Request["InfKey"] != null)
                {
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                ht.Add("func", "AddGrade");
                jsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jsonModel.errNum != 0)
                {
                    return;
                }
                SMModel.Plat_Grade model = new Plat_Grade();
                if (context.Request["Name"] != null)
                {
                    model.GradeName = context.Request["Name"].ToString();
                }
                if (context.Request["PeriodID"] != null)
                {
                    model.PeriodID = Convert.ToInt32(context.Request["PeriodID"].ToString());
                }
                if (context.Request["Remarks"] != null)
                {
                    model.Remarks = context.Request["Remarks"].ToString();
                }
                model.IsDelete = 0;
                jsonModel = BLL.Add(model);

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
                return;
            }
        }
        /// <summary>
        /// 获得年级数据
        /// </summary>
        /// <param name="context"></param>
        public void GetGradeById(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();

                //获取参数值
                if (context.Request["SystemKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                }
                if (context.Request["InfKey"] != null)
                {
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    ht.Add("Id", context.Request["Id"].ToString());
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 3,
                        errMsg = "loss",
                        retData = ""
                    };
                    return;
                }

                ht.Add("func", "GetGradeById");
                jsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jsonModel.errNum != 0)
                {
                    return;
                }
                jsonModel = BLL.GetEntityById(Convert.ToInt32(ht["Id"].ToString()));
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
                return;
            }
        }

        /// <summary>
        /// 修改年级
        /// </summary>
        /// <param name="context"></param>
        public void UpdateGrade(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();

                //获取参数值
                if (context.Request["SystemKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                }
                if (context.Request["InfKey"] != null)
                {
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                ht.Add("func", "UpdateGrade");
                jsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jsonModel.errNum != 0)
                {
                    return;
                }
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    ht.Add("Id", context.Request["Id"].ToString());
                }
                SMModel.Plat_Grade model = new Plat_Grade();
                JsonModel JsonModel1 = BLL.GetEntityById(Convert.ToInt32(ht["Id"].ToString()));
                if (JsonModel1.errNum != 0)
                {
                    jsonModel = JsonModel1;
                    return;
                }
                model = (Plat_Grade)(JsonModel1.retData);
                if (context.Request["Name"] != null)
                {
                    model.GradeName = context.Request["Name"].ToString();
                }
                if (context.Request["PeriodID"] != null)
                {
                    model.PeriodID = Convert.ToInt32(context.Request["PeriodID"].ToString());
                }
                if (context.Request["Remarks"] != null)
                {
                    model.Remarks = context.Request["Remarks"].ToString();
                }
                model.UpdateTime = DateTime.Now;
                jsonModel = BLL.Update(model);
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
                return;
            }
        }
    }
}