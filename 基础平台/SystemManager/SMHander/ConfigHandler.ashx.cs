using SMBLL;
using SMModel;
using SMSUtility;
using System;
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
    public class ConfigHandler : IHttpHandler
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
                    case "ImageRotation":
                        ImageRotation(context);
                        break;
                    //case "PlatLogin":
                    //    PlatLogin(context);
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

        public void ImageRotation(HttpContext context)
        {
            try
            {
                #region 判断参数全不全

                //if (context.Request["LoginName"] == null || context.Request["Password"] == null
                //    || context.Request["SystemKey"] == null || context.Request["InfKey"] == null)
                //{
                //    jsonModel = new JsonModel()
                //    {
                //        errNum = 3,//参数不对
                //        errMsg = "参数不对",
                //        retData = ""
                //    };
                //    return;
                //}

                #endregion

                //获取参数值
                //string LoginName = context.Request["LoginName"].ToString();
                //string Password = context.Request["Password"].ToString();
                //Password = EncryptHelper.Md5By32(Password);
                //string SystemKey = context.Request["SystemKey"].ToString();
                //string Key = context.Request["InfKey"].ToString();

                #region 验证Key
                //BLLCommon com = new BLLCommon();
                //JsonModel YanZheng = com.IsHasAuthority(SystemKey, Key, "Login");
                //if (YanZheng.errNum != 0)
                //{
                //    jsonModel = new JsonModel()
                //    {
                //        errNum = YanZheng.errNum,
                //        errMsg = YanZheng.errMsg,
                //        retData = ""
                //    };
                //    return;
                //}

                #endregion

                #region 验证账号密码
                //string PhotoURL = System.Configuration.ConfigurationManager.ConnectionStrings["PhotoURL"].ToString();
                string PhotoURL1 = System.Configuration.ConfigurationManager.ConnectionStrings["PhotoURL1"].ToString();
                string PhotoConnectURL1 = System.Configuration.ConfigurationManager.ConnectionStrings["PhotoConnectURL1"].ToString();
                string PhotoURL2 = System.Configuration.ConfigurationManager.ConnectionStrings["PhotoURL2"].ToString();
                string PhotoConnectURL2 = System.Configuration.ConfigurationManager.ConnectionStrings["PhotoConnectURL2"].ToString();
                string PhotoURL3 = System.Configuration.ConfigurationManager.ConnectionStrings["PhotoURL3"].ToString();
                string PhotoConnectURL3 = System.Configuration.ConfigurationManager.ConnectionStrings["PhotoConnectURL3"].ToString();

                string PhotoURL4 = System.Configuration.ConfigurationManager.ConnectionStrings["PhotoURL4"].ToString();
                string PhotoConnectURL4 = System.Configuration.ConfigurationManager.ConnectionStrings["PhotoConnectURL4"].ToString();
                string PhotoURL5 = System.Configuration.ConfigurationManager.ConnectionStrings["PhotoURL5"].ToString();
                string PhotoConnectURL5 = System.Configuration.ConfigurationManager.ConnectionStrings["PhotoConnectURL5"].ToString();
                string PhotoURL6 = System.Configuration.ConfigurationManager.ConnectionStrings["PhotoURL6"].ToString();
                string PhotoConnectURL6 = System.Configuration.ConfigurationManager.ConnectionStrings["PhotoConnectURL6"].ToString();
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                
                Dictionary<string, object> dic1 = new Dictionary<string, object>();
                dic1.Add("PhotoURL", PhotoURL1);
                dic1.Add("PhotoConnectURL", PhotoConnectURL1);
                dic1.Add("Type", "首页");
                list.Add(dic1);

                Dictionary<string, object> dic2 = new Dictionary<string, object>();
                dic2.Add("PhotoURL", PhotoURL2);
                dic2.Add("PhotoConnectURL", PhotoConnectURL2);
                dic2.Add("Type", "首页");
                list.Add(dic2);

                Dictionary<string, object> dic3 = new Dictionary<string, object>();
                dic3.Add("PhotoURL", PhotoURL3);
                dic3.Add("PhotoConnectURL", PhotoConnectURL3);
                dic3.Add("Type", "首页");
                list.Add(dic3);

                Dictionary<string, object> dic4 = new Dictionary<string, object>();
                dic4.Add("PhotoURL", PhotoURL4);
                dic4.Add("PhotoConnectURL", PhotoConnectURL4);
                dic4.Add("Type", "班级");
                list.Add(dic4);

                Dictionary<string, object> dic5 = new Dictionary<string, object>();
                dic5.Add("PhotoURL", PhotoURL5);
                dic5.Add("PhotoConnectURL", PhotoConnectURL5);
                dic5.Add("Type", "班级");
                list.Add(dic5);

                Dictionary<string, object> dic6 = new Dictionary<string, object>();
                dic6.Add("PhotoURL", PhotoURL6);
                dic6.Add("PhotoConnectURL", PhotoConnectURL6);
                dic6.Add("Type", "班级");
                list.Add(dic6);

                jsonModel = new JsonModel();
                jsonModel.errNum = 0;
                jsonModel.errMsg = "获取成功";
                jsonModel.retData = list;
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