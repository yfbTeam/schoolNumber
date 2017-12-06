using SMModel;
using SMSUtility;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SMWeb
{
    /// <summary>
    /// ImageUpLoadHandler 的摘要说明
    /// </summary>
    public class ImageUpLoadHandler : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;
        public void ProcessRequest(HttpContext context)
        {
            string func = context.Request["func"] ?? "";
            try
            {
                switch (func)
                {
                    case "StudentImage":
                        StudentImage(context);
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
        /// 上传学生图片
        /// </summary>
        /// <param name="Context"></param>
        public void StudentImage(HttpContext context)
        {
            try
            {
                //string name = context.Request.Files[0].FileName;
                //Stream filestream = context.Request.Files[0].InputStream;
                string UploadPath = context.Server.MapPath(System.Configuration.ConfigurationManager.ConnectionStrings["ImagePath"].ToString());
                string ImageName = context.Request["ImageName"].ToString();
                HttpFileCollection files = context.Request.Files;
                if (files == null || files.Count == 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "没有图片！",
                        retData = ""
                    };
                    return;
                }
                //1.获取文件信息
                var fileToUpload = files[0];
                if (fileToUpload.ContentLength > 2097152)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "大小不成超过2M！",
                        retData = ""
                    };
                    return;
                }
                //判断文件目录是否存在
                if (!Directory.Exists(UploadPath))
                {
                    Directory.CreateDirectory(UploadPath);
                }
                fileToUpload.SaveAs(UploadPath + ImageName);
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "上传成功",
                    retData = ""
                };
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