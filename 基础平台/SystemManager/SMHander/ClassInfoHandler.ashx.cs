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
    public class ClassInfoHandler : IHttpHandler
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
                    case "GetClassInfoData":
                        GetClassInfoData(context);
                        break;
                    case "GetClassInfoPageData":
                        GetClassInfoPageData(context);
                        break;
                    case "DeleteClassInfo":
                        DeleteClassInfo(context);
                        break;
                    case "AddClassInfo":
                        AddClassInfo(context);
                        break;
                    case "GetClassInfoById":
                        GetClassInfoById(context);
                        break;
                    case "UpdateClassInfo":
                        UpdateClassInfo(context);
                        break;
                    case "GetNameList":
                        GetNameList(context);
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
        /// 获得班级数据
        /// </summary>
        /// <param name="context"></param>
        public void GetClassInfoData(HttpContext context)
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
                ht.Add("func", "GetClassInfoData");
                ht.Add("Columns", "a.*,c.GradeName");
                ht.Add("TableName", "Plat_ClassInfo a left join Plat_SystemInfo b on a.SchoolID=b.SchoolId left join Plat_Grade c on a.GradeID=c.Id");
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
        /// 获得班级分页数据
        /// </summary>
        /// <param name="context"></param>
        public void GetClassInfoPageData(HttpContext context)
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
                    sb.Append(" and Name like '%" + context.Request["Name"].ToString() + "%'");
                }
                if (!string.IsNullOrWhiteSpace(context.Request["SchoolID"]))
                {
                    sb.Append(" and SchoolID = '" + context.Request["SchoolID"].ToString() + "'");
                }
                if (!string.IsNullOrWhiteSpace(context.Request["GradeID"]))
                {
                    sb.Append(" and GradeID = '" + context.Request["GradeID"].ToString() + "'");
                }
                sb.Append(" and IsDelete=0");
                ht.Add("func", "GetClassInfoPageData");
                ht.Add("Columns", "*");
                ht.Add("TableName", "Plat_ClassInfo");
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
        /// 新增班级
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
                if (!string.IsNullOrWhiteSpace(context.Request["HeadteacherNO"]))
                {
                    model.HeadteacherNO = context.Request["HeadteacherNO"].ToString();
                }
                if (!string.IsNullOrWhiteSpace(context.Request["MonitorNO"]))
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
                if (context.Request["CreateClassDate"] != null)
                {
                    model.CreateClassDate = Convert.ToDateTime(context.Request["CreateClassDate"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["GraduationDate"]))
                {
                    model.GraduationDate = Convert.ToDateTime(context.Request["GraduationDate"].ToString());
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
        /// 获得班级数据--根据ID
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
                if (!string.IsNullOrWhiteSpace(context.Request["HeadteacherNO"]))
                {
                    model.HeadteacherNO = context.Request["HeadteacherNO"].ToString();
                }
                if (!string.IsNullOrWhiteSpace(context.Request["MonitorNO"]))
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
                if (!string.IsNullOrWhiteSpace(context.Request["CreateClassDate"]))
                {
                    model.CreateClassDate = Convert.ToDateTime(context.Request["CreateClassDate"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["GraduationDate"]))
                {
                    model.GraduationDate = Convert.ToDateTime(context.Request["GraduationDate"].ToString());
                }
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

        /// <summary>
        /// 获得师生名单
        /// </summary>
        /// <param name="context"></param>
        public void GetNameList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                //获取参数值
                if (context.Request["SystemKey"] != null && context.Request["InfKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 3,
                        errMsg = "缺少key",
                        retData = ""
                    };
                    return;
                }
                if (context.Request["GradeID"] != null)
                {
                    ht.Add("GradeID", context.Request["GradeID"].ToString());
                }
                ht.Add("func", "GetNameList");

                jsonModel = BLL.GetNameList(ht);
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