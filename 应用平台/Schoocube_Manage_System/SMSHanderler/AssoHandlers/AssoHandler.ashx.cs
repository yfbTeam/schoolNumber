using LitJson;
using SMSBLL;
using SMSModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;

namespace SMSHanderler.AssoHandlers
{
    /// <summary>
    /// AssoHandler 的摘要说明
    /// </summary>
    public class AssoHandler : IHttpHandler
    {

        HttpContext Context;
        public void ProcessRequest(HttpContext context)
        {
            Context = context;
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            if (!string.IsNullOrEmpty(context.Request["action"]))
            {
                string action = context.Request["action"];
                switch (action)
                {
                    case "Upload_json":
                        Uploadjson();
                        break;
                    case "addactive":
                        addactive();
                        break;
                }
            }
            context.Response.End();
        }

        private void addactive()
        {
            try
            {
                AssoActiveService activeservice = new AssoActiveService();
                AssoActive active = new AssoActive();
                active.Title = "上传照片";
                int resultcount = activeservice.Insert(active);

                Context.Response.Write(resultcount);

            }
            catch (Exception ex)
            {

                throw;
            }
        }

        /// <summary>
        /// 上传文件
        /// </summary>
        private void Uploadjson()
        {
            try
            {
                String aspxUrl = Context.Request.Path.Substring(0, Context.Request.Path.LastIndexOf("/") + 1);

                //文件保存目录路径
                String savePath = "../attached/";

                //文件保存目录URL
                String saveUrl = aspxUrl + "../attached/";

                //定义允许上传的文件扩展名
                Hashtable extTable = new Hashtable();
                extTable.Add("image", "gif,jpg,jpeg,png,bmp");
                extTable.Add("flash", "swf,flv");
                extTable.Add("media", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb");
                extTable.Add("file", "doc,docx,xls,xlsx,ppt,htm,html,txt,zip,rar,gz,bz2");

                //最大文件大小
                int maxSize = 1000000;
                //this.context = context;

                HttpPostedFile imgFile = Context.Request.Files["imgFile"];
                if (imgFile == null)
                {
                    showError("请选择文件。");
                }

                String dirPath = Context.Server.MapPath(savePath);
                if (!Directory.Exists(dirPath))
                {
                    Directory.CreateDirectory(dirPath);
                    //showError("上传目录不存在。");
                }
                String dirName = Context.Request.QueryString["dir"];
                if (String.IsNullOrEmpty(dirName))
                {
                    dirName = "image";
                }
                if (!extTable.ContainsKey(dirName))
                {
                    showError("目录名不正确。");
                }

                String fileName = imgFile.FileName;
                String fileExt = Path.GetExtension(fileName).ToLower();

                if (imgFile.InputStream == null || imgFile.InputStream.Length > maxSize)
                {
                    showError("上传文件大小超过限制。");
                }

                if (String.IsNullOrEmpty(fileExt) || Array.IndexOf(((String)extTable[dirName]).Split(','), fileExt.Substring(1).ToLower()) == -1)
                {
                    showError("上传文件扩展名是不允许的扩展名。\n只允许" + ((String)extTable[dirName]) + "格式。");
                }

                //创建文件夹
                dirPath += dirName + "/";
                saveUrl += dirName + "/";
                if (!Directory.Exists(dirPath))
                {
                    Directory.CreateDirectory(dirPath);
                }
                String ymd = DateTime.Now.ToString("yyyyMMdd", DateTimeFormatInfo.InvariantInfo);
                dirPath += ymd + "/";
                saveUrl += ymd + "/";
                if (!Directory.Exists(dirPath))
                {
                    Directory.CreateDirectory(dirPath);
                }

                String newFileName = DateTime.Now.ToString("yyyyMMddHHmmss_ffff", DateTimeFormatInfo.InvariantInfo) + fileExt;

                String filePath = dirPath + newFileName;
                //string filePath = string.Empty;

                string msg = string.Empty;

                imgFile.SaveAs(filePath);

                String fileUrl = saveUrl + newFileName;
                Hashtable hash = new Hashtable();
                hash["error"] = 0;
                hash["url"] = filePath;
                Context.Response.AddHeader("Content-Type", "text/html; charset=UTF-8");
                Context.Response.Write(JsonMapper.ToJson(hash));
                Context.Response.End();


            }
            catch (Exception ex)
            {

                //log.writeLogMessage(ex.Message, "ES_wp_AddExamQuestion_ES_wp_EditExamQuestion_保存试题时图片文件保存");
            }
        }
        private void showError(string message)
        {
            Hashtable hash = new Hashtable();
            hash["error"] = 1;
            hash["message"] = message;
            Context.Response.AddHeader("Content-Type", "text/html; charset=UTF-8");
            Context.Response.Write(JsonMapper.ToJson(hash));
            Context.Response.End();
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