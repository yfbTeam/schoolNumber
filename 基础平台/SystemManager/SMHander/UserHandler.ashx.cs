using SMBLL;
using SMModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SMHander
{
    /// <summary>
    /// UserHandler 的摘要说明
    /// </summary>
    public class UserHandler : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        
        SMBLL.Plat_SystemInfoService BLLSystem = new SMBLL.Plat_SystemInfoService();
        SMBLL.Plat_TeacherService BLLTeacher = new SMBLL.Plat_TeacherService();
        SMBLL.Plat_StudentService BLLStudent = new SMBLL.Plat_StudentService();
        SMBLL.Plat_LogInfoService log = new SMBLL.Plat_LogInfoService();
        JsonModel jsonModel = null;
        public void ProcessRequest(HttpContext context)
        {
            string func = context.Request["func"] ?? "";
            try
            {
                switch (func)
                {
                    case "Login":
                        Login(context);
                        break;
                    case "PlatLogin":
                        PlatLogin(context);
                        break;
                    case "Register":
                        Register(context);
                        break;
                    case "UpdatePassword":
                        UpdatePassword(context);
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

        public void Login(HttpContext context)
        {
            try
            {
                #region 判断参数全不全

                if (context.Request["LoginName"] == null || context.Request["Password"] == null
                    || context.Request["SystemKey"] == null || context.Request["InfKey"] == null)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 3,//参数不对
                        errMsg = "参数不对",
                        retData = ""
                    };
                    return;
                }

                #endregion

                //获取参数值
                string LoginName = context.Request["LoginName"].ToString();
                string Password = context.Request["Password"].ToString();
                Password = EncryptHelper.Md5By32(Password);
                string SystemKey = context.Request["SystemKey"].ToString();
                string Key = context.Request["InfKey"].ToString();

                #region 验证Key
                BLLCommon com = new BLLCommon();
                JsonModel YanZheng = com.IsHasAuthority(SystemKey, Key, "Login");
                if (YanZheng.errNum != 0)
                {
                    jsonModel = YanZheng;
                    return;
                }

                #endregion

                #region 验证账号密码
                string PhotoURL = System.Configuration.ConfigurationManager.ConnectionStrings["PhotoURL"].ToString();
                DataTable dtTeacher = BLLTeacher.ValidationUser(LoginName, Password);
                DataTable dtStudent = BLLStudent.ValidationUser(LoginName, Password);
                if (dtTeacher.Rows.Count==1 || dtStudent.Rows.Count==1)
                {
                    
                    if (dtTeacher.Rows.Count == 1)
                    {
                        if (dtTeacher.Rows[0]["State"].ToString() == "1")
                        {
                            jsonModel = new JsonModel();
                            jsonModel.errNum = 1;
                            jsonModel.errMsg = "账号已禁用";
                            return;
                        }
                    }
                    else
                    {
                        if (dtStudent.Rows[0]["State"].ToString() == "1")
                        {
                            jsonModel = new JsonModel();
                            jsonModel.errNum = 1;
                            jsonModel.errMsg = "账号已禁用";
                            return;
                        }
                    }

                    List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                    SMBLL.Plat_UserOfSystemService BLLUOS = new Plat_UserOfSystemService();
                    if (dtTeacher.Rows.Count == 1)
                    {
                        DataTable dtUOS = BLLUOS.GetSystemUser(dtTeacher.Rows[0]["LoginName"].ToString(), SystemKey);
                        if (dtUOS.Rows.Count == 0)
                        {
                            jsonModel = new JsonModel();
                            jsonModel.errNum = 1;
                            jsonModel.errMsg = "没有系统登录权限";
                            return;
                        }
                        else if (dtUOS.Rows[0]["UserStatus"].ToString() == "1")
                        {
                            jsonModel = new JsonModel();
                            jsonModel.errNum = 1;
                            jsonModel.errMsg = "账号已被禁止登录系统";
                            return;
                        }
                        list = com.DataTableToList(dtTeacher);
                    }
                    else
                    {
                        DataTable dtUOS = BLLUOS.GetSystemUser(dtStudent.Rows[0]["LoginName"].ToString(), SystemKey);
                        if (dtUOS.Rows.Count == 0)
                        {
                            jsonModel = new JsonModel();
                            jsonModel.errNum = 1;
                            jsonModel.errMsg = "没有系统登录权限";
                            return;
                        }
                        else if (dtUOS.Rows[0]["UserStatus"].ToString() == "1")
                        {
                            jsonModel = new JsonModel();
                            jsonModel.errNum = 1;
                            jsonModel.errMsg = "账号已被禁止登录系统";
                            return;
                        }
                        list = com.DataTableToList(dtStudent);
                    }
                    //添加头像的完整访问路径
                    list[0].Add("PhotoURL", PhotoURL + list[0]["Photo"].ToString());
                    //添加图片的访问路径
                    list[0].Add("URL", PhotoURL);
                    list[0].Remove("Password");
                    list[0].Remove("IsDelete");
                    list[0].Remove("LatelyLoginTime");
                    list[0].Remove("LoginIP");
                    list[0].Remove("LoginKey");

                    jsonModel = new JsonModel();
                    jsonModel.errNum = 0;
                    jsonModel.errMsg = "登录成功";
                    jsonModel.retData = list;
                    //记入操作日志
                    log.WriteLog(LogConstants.login, ActionConstants.Actionlogin, "", LoginName, "登录[Login]");
                    return;
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 4,
                        errMsg = "账号密码不正确",
                        retData = new string[0]
                    };
                    return;
                }

                #endregion
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

        public void PlatLogin(HttpContext context)
        {
            try
            {
                #region 判断参数全不全

                if (context.Request["LoginName"] == null || context.Request["Password"] == null)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 3,//参数不对
                        errMsg = "参数不对",
                        retData = ""
                    };
                    return;
                }

                #endregion

                //获取参数值
                string LoginName = context.Request["LoginName"].ToString();
                string Password = context.Request["Password"].ToString();
                Password = EncryptHelper.Md5By32(Password);
                BLLCommon com = new BLLCommon();
                #region 验证账号密码

                DataTable dtTeacher = BLLTeacher.ValidationUser(LoginName, Password);
                //DataTable dtStudent = BLLStudent.ValidationUser(LoginName, Password);

                //if (dtTeacher.Rows.Count == 1 || dtStudent.Rows.Count == 1)
                if (dtTeacher.Rows.Count == 1)
                {

                    jsonModel = new JsonModel();
                    jsonModel.errNum = 0;
                    jsonModel.errMsg = "登录成功";

                    //List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                    string ReturnString = "";
                    if (dtTeacher.Rows.Count == 1)
                    {
                        //list = com.DataTableToList(dtTeacher);
                        DataRow dr=dtTeacher.Rows[0];
                        ReturnString += dr["Id"].ToString();
                        ReturnString += "," + dr["Name"].ToString();
                        ReturnString += "," + dr["LoginName"].ToString();
                        ReturnString += "," + dr["IDCard"].ToString();
                        ReturnString += "," + dr["SchoolID"].ToString();
                        ReturnString += "," + dr["SystemKey"].ToString();
                        //ReturnString += "," + dr["SystemName"].ToString();
                        ReturnString += "," + "基础数据建设平台";
                        //ReturnString += "," + dr[""].ToString();
                        //ReturnString += "," + dr[""].ToString();
                        //ReturnString += "," + dr[""].ToString();
                        //ReturnString += "," + dr[""].ToString();
                        //ReturnString += "," + dr[""].ToString();

                    }
                    //else
                    //{
                    //    //list = com.DataTableToList(dtStudent);
                    //    DataRow dr = dtTeacher.Rows[0];
                    //    ReturnString += dr["Name"].ToString();
                    //    ReturnString += "," + dr["LoginName"].ToString();
                    //    ReturnString += "," + dr["IDCard"].ToString();
                    //    ReturnString += "," + dr["SchoolID"].ToString();
                    //    ReturnString += "," + dr["SystemKey"].ToString();
                    //    ReturnString += "," + dr["SystemName"].ToString();
                    //    //ReturnString += "," + dr[""].ToString();
                    //    //ReturnString += "," + dr[""].ToString();
                    //    //ReturnString += "," + dr[""].ToString();
                    //    //ReturnString += "," + dr[""].ToString();
                    //    //ReturnString += "," + dr[""].ToString();
                    //}
                    //jsonModel.retData = list;
                    jsonModel.retData = ReturnString;
                    //记入操作日志
                    log.WriteLog(LogConstants.login, ActionConstants.Actionlogin, "", LoginName, "登录[PlatLogin]");
                    return;
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 4,
                        errMsg = "账号密码不正确",
                        retData = ""
                    };
                    return;
                }

                #endregion
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
        /// 注册
        /// </summary>
        /// <param name="context"></param>
        public void Register(HttpContext context)
        {
            try
            {
                #region 判断参数全不全

                if (context.Request["IDCard"] == null || context.Request["Password"] == null || context.Request["LoginName"] == null
                    || context.Request["SystemKey"] == null)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 3,//参数不对
                        errMsg = "参数不对",
                        retData = ""
                    };
                    return;
                }

                #endregion

                //获取参数值
                Hashtable ht = new Hashtable();
                ht.Add("IDCard", context.Request["IDCard"] == null ? "" : context.Request["IDCard"].ToString());
                ht.Add("LoginName", context.Request["LoginName"] == null ? "" : context.Request["LoginName"].ToString());
                ht.Add("Password", context.Request["Password"] == null ? "" : context.Request["Password"].ToString());
                ht.Add("SystemKey", context.Request["SystemKey"] == null ? "" : context.Request["SystemKey"].ToString());
                ht.Add("Name", context.Request["Name"] == null ? "" : context.Request["Name"].ToString());
                ht.Add("Nickname", context.Request["Nickname"] == null ? "" : context.Request["Nickname"].ToString());
                ht.Add("Sex", context.Request["Sex"] == null ? "" : context.Request["Sex"].ToString());
                ht.Add("Email", context.Request["Email"] == null ? "" : context.Request["Email"].ToString());
                ht.Add("Address", context.Request["Address"] == null ? "" : context.Request["Address"].ToString());
                ht.Add("Phone", context.Request["Phone"] == null ? "" : context.Request["Phone"].ToString());
                SMBLL.Plat_StudentService bllStudent = new Plat_StudentService();
                jsonModel = bllStudent.Register(ht);
                return;

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
        /// 修改密码
        /// </summary>
        /// <param name="context"></param>
        public void UpdatePassword(HttpContext context)
        {
            try
            {
                #region 判断参数全不全

                if (context.Request["LoginName"] == null || context.Request["OldPassword"] == null
                    || context.Request["NewPassword"] == null)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 3,//参数不对
                        errMsg = "参数不对",
                        retData = ""
                    };
                    return;
                }

                #endregion

                //获取参数值
                string LoginName = context.Request["LoginName"].ToString();
                string OldPassword = context.Request["OldPassword"].ToString();
                string NewPassword = context.Request["NewPassword"].ToString();
                OldPassword = EncryptHelper.Md5By32(OldPassword);
                NewPassword = EncryptHelper.Md5By32(NewPassword);
                BLLCommon com = new BLLCommon();
                #region 验证账号密码

                DataTable dtTeacher = BLLTeacher.ValidationUser(LoginName, OldPassword);
                DataTable dtStudent = BLLStudent.ValidationUser(LoginName, OldPassword);

                if (dtTeacher.Rows.Count == 1 || dtStudent.Rows.Count == 1)
                //if (dtTeacher.Rows.Count == 1)
                {


                    if (dtTeacher.Rows.Count == 1)
                    {
                        bool Result = BLLTeacher.UpdatePassword(LoginName, NewPassword);
                        if (Result)
                        {
                            jsonModel = new JsonModel()
                            {
                                errNum = 0,
                                errMsg = "修改成功",
                                retData = ""
                            };
                        }
                        else
                        {
                            jsonModel = new JsonModel()
                            {
                                errNum = 1,
                                errMsg = "修改失败",
                                retData = ""
                            };
                        }
                    }
                    else
                    {
                        bool Result = BLLStudent.UpdatePassword(LoginName, NewPassword);
                        if (Result)
                        {
                            jsonModel = new JsonModel()
                            {
                                errNum = 0,
                                errMsg = "修改成功",
                                retData = ""
                            };
                        }
                        else
                        {
                            jsonModel = new JsonModel()
                            {
                                errNum = 1,
                                errMsg = "修改失败",
                                retData = ""
                            };
                        }
                    }
                    //记入操作日志
                    log.WriteLog(LogConstants.xgmmgl, ActionConstants.xgpwd, "", LoginName, "修改[UpdatePassword]");
                    return;
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 4,
                        errMsg = "账号密码不正确",
                        retData = ""
                    };
                    return;
                }

                #endregion
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