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
    public class SchoolHandler : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        SMBLL.Plat_LogInfoService log = new SMBLL.Plat_LogInfoService();
        JsonModel jsonModel = null;
        BLLCommon com = new SMBLL.BLLCommon();
        SMBLL.Plat_SchoolService BLL = new Plat_SchoolService();
        public void ProcessRequest(HttpContext context)
        {
            string func = context.Request["func"] ?? "";
            try
            {
                switch (func)
                {
                    case "GetSchoolAll":
                        GetSchoolAll(context);
                        break;
                    case "GetSchoolPageData":
                        GetSchoolPageData(context);
                        break;
                    case "DeleteSchool":
                        DeleteSchool(context);
                        break;
                    case "AddSchool":
                        AddSchool(context);
                        break;
                    case "GetSchoolById":
                        GetSchoolById(context);
                        break;
                    case "UpdateSchool":
                        UpdateSchool(context);
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
        /// 获得学校数据
        /// </summary>
        /// <param name="context"></param>
        public void GetSchoolAll(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();
                sb.Append(" and IsDelete=0");
                //获取参数值
                ht.Add("Columns", "*");
                ht.Add("TableName", "Plat_School");
                ht.Add("Where", sb.ToString());

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
        /// 获得学校分页数据
        /// </summary>
        /// <param name="context"></param>
        public void GetSchoolPageData(HttpContext context)
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
                if (!string.IsNullOrWhiteSpace(context.Request["SchoolName"]))
                {
                    sb.Append(" and Name like '%" + context.Request["SchoolName"].ToString() + "%'");
                }
                sb.Append(" and IsDelete=0");
                ht.Add("func", "GetSchoolPageData");
                ht.Add("Columns", "*");
                ht.Add("TableName", "Plat_School");
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
        public void DeleteSchool(HttpContext context)
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

                ht.Add("func", "DeleteSchool");
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

        /// <summary>
        /// 新增学校
        /// </summary>
        /// <param name="context"></param>
        public void AddSchool(HttpContext context)
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
                ht.Add("func", "AddSchool");
                jsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jsonModel.errNum != 0)
                {
                    return;
                }
                SMModel.Plat_School model = new Plat_School();
                if (context.Request["Name"] != null)
                {
                    model.Name = context.Request["Name"].ToString();
                }
                if (context.Request["Address"] != null)
                {
                    model.Address = context.Request["Address"].ToString();
                }
                if (context.Request["PrincipalNumber"] != null)
                {
                    model.PrincipalNumber = context.Request["PrincipalNumber"].ToString();
                }
                if (context.Request["PrincipalName"] != null)
                {
                    model.PrincipalName = context.Request["PrincipalName"].ToString();
                }
                if (context.Request["Phone"] != null)
                {
                    model.Phone = context.Request["Phone"].ToString();
                }
                if (context.Request["Fax"] != null)
                {
                    model.Fax = context.Request["Fax"].ToString();
                }
                if (context.Request["Email"] != null)
                {
                    model.Email = context.Request["Email"].ToString();
                }
                if (context.Request["Homepage"] != null)
                {
                    model.Homepage = context.Request["Homepage"].ToString();
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
        /// 修改学校
        /// </summary>
        /// <param name="context"></param>
        public void UpdateSchool(HttpContext context)
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
                ht.Add("func", "UpdateSchool");
                jsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jsonModel.errNum != 0)
                {
                    return;
                }
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    ht.Add("Id", context.Request["Id"].ToString());
                }
                SMModel.Plat_School model = new Plat_School();
                JsonModel JsonModel1 = BLL.GetEntityById(Convert.ToInt32(ht["Id"].ToString()));
                if (JsonModel1.errNum != 0)
                {
                    jsonModel = JsonModel1;
                    return;
                }
                model = (Plat_School)(JsonModel1.retData);
                if (context.Request["Name"] != null)
                {
                    model.Name = context.Request["Name"].ToString();
                }
                if (context.Request["Address"] != null)
                {
                    model.Address = context.Request["Address"].ToString();
                }
                if (context.Request["PrincipalNumber"] != null)
                {
                    model.PrincipalNumber = context.Request["PrincipalNumber"].ToString();
                }
                if (context.Request["PrincipalName"] != null)
                {
                    model.PrincipalName = context.Request["PrincipalName"].ToString();
                }
                if (context.Request["Phone"] != null)
                {
                    model.Phone = context.Request["Phone"].ToString();
                }
                if (context.Request["Fax"] != null)
                {
                    model.Fax = context.Request["Fax"].ToString();
                }
                if (context.Request["Email"] != null)
                {
                    model.Email = context.Request["Email"].ToString();
                }
                if (context.Request["Homepage"] != null)
                {
                    model.Homepage = context.Request["Homepage"].ToString();
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

        /// <summary>
        /// 获得学校数据
        /// </summary>
        /// <param name="context"></param>
        public void GetSchoolById(HttpContext context)
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

                ht.Add("func", "GetSchoolById");
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
    }
}