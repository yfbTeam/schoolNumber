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
    public class StudySectionHandler : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        SMBLL.Plat_LogInfoService log = new SMBLL.Plat_LogInfoService();
        JsonModel jsonModel = null;
        BLLCommon com = new SMBLL.BLLCommon();
        SMBLL.Plat_StudySectionService BLL = new Plat_StudySectionService();
        public void ProcessRequest(HttpContext context)
        {
            string func = context.Request["func"] ?? "";
            try
            {
                switch (func)
                {
                    case "GetStudySectionData":
                        GetStudySectionData(context);
                        break;
                    case "GetStudySectionPageData":
                        GetStudySectionPageData(context);
                        break;
                    case "AddStudySection":
                        AddStudySection(context);
                        break;
                    case "GetStudySectionById":
                        GetStudySectionById(context);
                        break;
                    case "UpdateStudySection":
                        UpdateStudySection(context);
                        break;
                    case "DeleteStudySection":
                        DeleteStudySection(context);
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
        /// 获得学期数据
        /// </summary>
        /// <param name="context"></param>
        public void GetStudySectionData(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();
                //获取参数值
                if (context.Request["SystemKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                    sb.Append(" and b.SystemKey='" + context.Request["SystemKey"].ToString() + "'");
                }
                if (context.Request["InfKey"] != null)
                {
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["IsDelete"]))
                {
                    ht.Add("IsDelete", context.Request["IsDelete"].ToString());
                    sb.Append(" and a.IsDelete=" + context.Request["IsDelete"].ToString());
                }
                else
                {
                    sb.Append(" and a.IsDelete=0");
                }
                ht.Add("func", "GetStudySectionData");
                ht.Add("Columns", "a.*");
                ht.Add("TableName", "Plat_StudySection a left join Plat_SystemInfo b on a.SchoolID=b.SchoolId");
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
        /// 获得学期分页数据
        /// </summary>
        /// <param name="context"></param>
        public void GetStudySectionPageData(HttpContext context)
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
                if (!string.IsNullOrWhiteSpace(context.Request["Academic"]))
                {
                    //ht.Add("Module", context.Request["Module"].ToString());
                    sb.Append(" and a.Academic like '%" + context.Request["Academic"].ToString() + "%'");
                }
                if (!string.IsNullOrWhiteSpace(context.Request["Semester"]))
                {
                    sb.Append(" and a.Semester like '%" + context.Request["Semester"].ToString() + "%'");
                }
                if (!string.IsNullOrWhiteSpace(context.Request["SchoolName"]))
                {
                    sb.Append(" and b.Name like '%" + context.Request["SchoolName"].ToString() + "%'");
                }
                //if (context.Request["IsDelete"] != null)
                //{
                //    if (context.Request["IsDelete"].ToString() != "")
                //    {
                //        ht.Add("IsDelete", context.Request["IsDelete"].ToString());
                //        sb.Append(" and a.IsDelete=" + context.Request["IsDelete"].ToString());
                //    }
                //    else
                //    {
                //        sb.Append(" and a.IsDelete=0");
                //    }
                //}
                sb.Append(" and a.IsDelete=0");
                ht.Add("func", "GetStudySectionPageData");
                ht.Add("Columns", "a.*,b.Name as SchoolName");
                ht.Add("TableName", "Plat_StudySection a left join Plat_School b on a.SchoolID=b.Id");
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
        /// 获得学期分页数据
        /// </summary>
        /// <param name="context"></param>
        public void AddStudySection(HttpContext context)
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
                if (!string.IsNullOrWhiteSpace(context.Request["Academic"]))
                {
                    ht.Add("Academic", context.Request["Academic"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["Semester"]))
                {
                    ht.Add("Semester", context.Request["Semester"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["SStartDate"]))
                {
                    ht.Add("SStartDate", context.Request["SStartDate"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["SEndDate"]))
                {
                    ht.Add("SEndDate", context.Request["SEndDate"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["SchoolID"]))
                {
                    ht.Add("SchoolID", context.Request["SchoolID"].ToString());
                }

                ht.Add("func", "AddStudySection");
                jsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jsonModel.errNum != 0)
                {
                    return;
                }
                //jsonModel = com.GetData3(ht);
                jsonModel = BLL.AddStudySection(ht);
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
        /// 修改学期
        /// </summary>
        /// <param name="context"></param>
        public void UpdateStudySection(HttpContext context)
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
                if (!string.IsNullOrWhiteSpace(context.Request["Academic"]))
                {
                    ht.Add("Academic", context.Request["Academic"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["Semester"]))
                {
                    ht.Add("Semester", context.Request["Semester"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["SStartDate"]))
                {
                    ht.Add("SStartDate", context.Request["SStartDate"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["SEndDate"]))
                {
                    ht.Add("SEndDate", context.Request["SEndDate"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["SchoolID"]))
                {
                    ht.Add("SchoolID", context.Request["SchoolID"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    ht.Add("Id", context.Request["Id"].ToString());
                }

                ht.Add("func", "UpdateStudySection");
                jsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jsonModel.errNum != 0)
                {
                    return;
                }
                //jsonModel = com.GetData3(ht);
                jsonModel = BLL.UpdateStudySection(ht);
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
        /// 获得学期分页数据
        /// </summary>
        /// <param name="context"></param>
        public void GetStudySectionById(HttpContext context)
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

                ht.Add("func", "GetStudySectionById");
                jsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jsonModel.errNum != 0)
                {
                    return;
                }
                //jsonModel = com.GetData3(ht);
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
        /// 修改删除状态
        /// </summary>
        /// <param name="context"></param>
        public void DeleteStudySection(HttpContext context)
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

                ht.Add("func", "DeleteStudySection");
                jsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jsonModel.errNum != 0)
                {
                    return;
                }
                //jsonModel = com.GetData3(ht);
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
    }
}