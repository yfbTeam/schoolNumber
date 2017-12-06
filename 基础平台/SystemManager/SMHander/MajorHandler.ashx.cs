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
    public class MajorHandler : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        SMBLL.Plat_LogInfoService log = new SMBLL.Plat_LogInfoService();
        JsonModel jsonModel = null;
        BLLCommon com = new SMBLL.BLLCommon();
        SMBLL.Plat_ClassInfoService BLL = new Plat_ClassInfoService();
        public void ProcessRequest(HttpContext context)
        {
            string func = context.Request["func"] ?? "";
            try
            {
                switch (func)
                {
                    case "GetMajorData":
                        GetMajorData(context);
                        break;
                    case "GetMajorPageData":
                        GetMajorPageData(context);
                        break;
                    //case "DeleteClassInfo":
                    //    DeleteClassInfo(context);
                    //    break;
                    //case "AddClassInfo":
                    //    AddClassInfo(context);
                    //    break;
                    //case "GetClassInfoById":
                    //    GetClassInfoById(context);
                    //    break;
                    //case "UpdateClassInfo":
                    //    UpdateClassInfo(context);
                    //    break;
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
        /// 获得专业数据
        /// </summary>
        /// <param name="context"></param>
        public void GetMajorData(HttpContext context)
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
                sb.Append(" and a.IsDelete=0");
                ht.Add("func", "GetMajorData");
                ht.Add("Columns", "a.*");
                ht.Add("TableName", "Plat_Major a left join Plat_SystemInfo b on a.SchoolID=b.SchoolId");
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
        /// 获得专业数据--分页
        /// </summary>
        /// <param name="context"></param>
        public void GetMajorPageData(HttpContext context)
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
                    sb.Append(" and a.Name like '%" + context.Request["Name"].ToString() + "%'");
                }
                sb.Append(" and a.IsDelete=0");
                ht.Add("func", "GetMajorPageData");
                ht.Add("Columns", "a.*");
                ht.Add("TableName", "Plat_Major a left join Plat_SystemInfo b on a.SchoolID=b.SchoolId");
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
        public void DeleteClassInfo(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();

                //获取参数值
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
        /// 新增教材
        /// </summary>
        /// <param name="context"></param>
        public void AddClassInfo(HttpContext context)
        {
            try
            {

                //获取参数值
                SMModel.Plat_ClassInfo model = new Plat_ClassInfo();
                if (context.Request["Name"] != null)
                {
                    model.ClassName = context.Request["Name"].ToString();
                }
                if (context.Request["ClassNO"] != null)
                {
                    model.ClassNO = context.Request["ClassNO"].ToString();
                }
                if (context.Request["HeadteacherNO"] != null)
                {
                    model.HeadteacherNO = context.Request["HeadteacherNO"].ToString();
                }
                if (context.Request["MonitorNO"] != null)
                {
                    model.MonitorNO = context.Request["MonitorNO"].ToString();
                }
                if (context.Request["CultureScienceType"] != null)
                {
                    model.CultureScienceType = Convert.ToByte(context.Request["CultureScienceType"].ToString());
                }
                if (context.Request["SchoolID"] != null)
                {
                    model.SchoolID = Convert.ToInt32(context.Request["SchoolID"].ToString());
                }
                if (context.Request["GradeID"] != null)
                {
                    model.GradeID = Convert.ToInt32(context.Request["GradeID"].ToString());
                }
                if (context.Request["Remarks"] != null)
                {
                    model.Remarks = context.Request["Remarks"].ToString();
                }
                //if (context.Request["CreateClassDate"] != null)
                //{
                //    model.CreateClassDate = Convert.ToDateTime(context.Request["CreateClassDate"].ToString());
                //}
                //if (context.Request["GraduationDate"] != null)
                //{
                //    model.GraduationDate = Convert.ToDateTime(context.Request["GraduationDate"].ToString());
                //}
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
        /// 获得教材数据
        /// </summary>
        /// <param name="context"></param>
        public void GetClassInfoById(HttpContext context)
        {
            try
            {
                //Hashtable ht = new Hashtable();
                //StringBuilder sb = new StringBuilder();
                string ID = "";
                //获取参数值
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    ID = context.Request["Id"].ToString();
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
                jsonModel = BLL.GetEntityById(Convert.ToInt32(ID));
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
        /// 修改班级
        /// </summary>
        /// <param name="context"></param>
        public void UpdateClassInfo(HttpContext context)
        {
            try
            {
                //Hashtable ht = new Hashtable();
                //StringBuilder sb = new StringBuilder();

                //获取参数值
                string ID = "";
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    ID = context.Request["Id"].ToString();
                }
                SMModel.Plat_ClassInfo model = new Plat_ClassInfo();
                JsonModel JsonModel1 = BLL.GetEntityById(Convert.ToInt32(ID));
                if (JsonModel1.errNum != 0)
                {
                    jsonModel = JsonModel1;
                    return;
                }
                model = (Plat_ClassInfo)(JsonModel1.retData);
                if (context.Request["Name"] != null)
                {
                    model.ClassName = context.Request["Name"].ToString();
                }
                if (context.Request["ClassNO"] != null)
                {
                    model.ClassNO = context.Request["ClassNO"].ToString();
                }
                if (context.Request["HeadteacherNO"] != null)
                {
                    model.HeadteacherNO = context.Request["HeadteacherNO"].ToString();
                }
                if (context.Request["MonitorNO"] != null)
                {
                    model.MonitorNO = context.Request["MonitorNO"].ToString();
                }
                if (context.Request["CultureScienceType"] != null)
                {
                    model.CultureScienceType = Convert.ToByte(context.Request["CultureScienceType"].ToString());
                }
                if (context.Request["SchoolID"] != null)
                {
                    model.SchoolID = Convert.ToInt32(context.Request["SchoolID"].ToString());
                }
                if (context.Request["GradeID"] != null)
                {
                    model.GradeID = Convert.ToInt32(context.Request["GradeID"].ToString());
                }
                if (context.Request["Remarks"] != null)
                {
                    model.Remarks = context.Request["Remarks"].ToString();
                }
                //if (context.Request["CreateClassDate"] != null)
                //{
                //    model.CreateClassDate = Convert.ToDateTime(context.Request["CreateClassDate"].ToString());
                //}
                //if (context.Request["GraduationDate"] != null)
                //{
                //    model.GraduationDate = Convert.ToDateTime(context.Request["GraduationDate"].ToString());
                //}
                model.EditTime = DateTime.Now;
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