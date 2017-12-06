using SMBLL;
using SMBLL;
using SMModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SMSWeb.CourseManage
{
    /// <summary>
    /// MyResource1 的摘要说明
    /// </summary>
    public class MyResource1 : IHttpHandler
    {

        Plat_RoleService Bll = new Plat_RoleService();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string FuncName = context.Request["Func"].ToString();
            if (FuncName != null && FuncName != "")
            {
                switch (FuncName)
                {
                    case "GetPageList":
                        GetPage(context);
                        break;
                    case "AddFolder":
                        AddFolder(context);
                        break;
                    default:
                        break;
                }
            }
        }
        #region 新增文件夹
        /// <summary>
        /// 新增文件夹
        /// </summary>
        /// <returns></returns>

        private string AddFolder(HttpContext context)
        {
            string FoldUrl = context.Request.Form["FoldUrl"] == null ? "" : context.Request.Form["FoldUrl"].ToString();

            string result = "0";
            try
            {
                try
                {
                    string folderurl = context.Server.MapPath(FoldUrl) + "/";
                    if (Directory.Exists(folderurl))
                    {
                        AddFolder(folderurl + context.Request.Form["FileName"].ToString().Trim());
                    }
                }
                catch (Exception ex)
                {
                    //com.writeLogMessage(ex.Message, "PersonDrive.AddFolder");
                }
            }
            catch (Exception ex)
            {
                //com.writeLogMessage(ex.Message, "PersonDrive.AddFolder");
            }
            return result;
        }
        #endregion
        private void AddFolder(string path)
        {
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
        }
        #region
        private void GetPage(HttpContext context)
        {
            string result = "";
            JsonModel jsonModel = null;
            JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();

            try
            {
                MyResource resource = new MyResource();
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());
                ht.Add("TableName", "MyResource");
                jsonModel = Bll.GetPage(ht,null);
                result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
                context.Response.Write(result);
                context.Response.End();
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