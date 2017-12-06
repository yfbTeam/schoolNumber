using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace SMSWeb.Portal.Admin
{
    /// <summary>
    /// Upload 的摘要说明
    /// </summary>
    public class Upload : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request["action"];
            if (!string.IsNullOrEmpty(action))
            {
                UploadFileForImg(context, action);
            }
        }

        public void UploadFileForImg(HttpContext context, string action) 
        {
            try
            {
                HttpFileCollection files = context.Request.Files;
                if (files == null || files.Count == 0)
                    context.Response.Write("{ result :false, desc : '附件不能为空！' }");
                //1.获取文件信息
                var fileToUpload = files[0];
                if (fileToUpload.ContentLength > 2999999)
                    context.Response.Write("( result :false, desc: '文件过大！' }");
                string path = "/PortalImages";
                string serverPath = context.Server.MapPath("~" + path);
                //2.判断文件目录是否存在
                if (!Directory.Exists(serverPath))
                {
                    Directory.CreateDirectory(serverPath);
                }
                string newFileName = "";
                switch (action)
                {
                    case "before": newFileName = "logo.png "; break;
                    case "after": newFileName = "logoBefore.png"; break;
                }
                string filePath = Path.Combine(serverPath, newFileName);
                fileToUpload.SaveAs(filePath);
                string saveUrl = path + "/" + newFileName;
                context.Response.Write("{ result : true, name : '" + fileToUpload.FileName + "', path : '" + saveUrl + "' }");
            }
            catch (Exception ex)
            {
                context.Response.Write("{ result : false, error: '" + ex.Message + "'}");
            }
            
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}