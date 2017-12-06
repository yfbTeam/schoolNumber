using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;

namespace SMSWeb.SysMessage
{
    /// <summary>
    /// StaticPage 的摘要说明
    /// </summary>
    public class StaticPage : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //string postUrl = System.Configuration.ConfigurationManager.AppSettings["StaticPath"];
            string postUrl = "http://localhost:37227/StaticPage/HtmlPage1.html";
            string surl = "http://" + System.Configuration.ConfigurationManager.AppSettings["services"];
            //string surl = "http://localhost:37227";
            string url = context.Request["url"];
            string cid = context.Request["cid"];
            string uname = context.Request["uname"];
            Hashtable ht = new Hashtable();
            if (!string.IsNullOrWhiteSpace(url)) { 
                ht.Add("url", url);
                //postUrl = postUrl + url.Substring(url.LastIndexOf("?"));
            }
            if (!string.IsNullOrWhiteSpace(cid)) ht.Add("cid", cid);
            if (!string.IsNullOrWhiteSpace(uname)) ht.Add("uname", uname);
            if (!string.IsNullOrWhiteSpace(surl)) ht.Add("surl", surl);
            string purl=context.Server.MapPath("~/StaticPage/CourseDetail.html");
            ht.Add("purl", purl);
            string returnData = HttpHelper.PostUrl(postUrl,null ,ht);
            string filename = "";
            if (!string.IsNullOrWhiteSpace(returnData))
            {
                string htmlpath = context.Server.MapPath("~/StaticPage/HtmlFile/");
                if (!Directory.Exists(htmlpath))
                {
                    Directory.CreateDirectory(htmlpath);
                }
                filename=DateTime.Now.ToString("yyyyMMddHHmmddss")+".html";
                string paths = htmlpath + filename;
                using (StreamWriter sw = new StreamWriter(paths, false, System.Text.Encoding.GetEncoding("utf-8"))) 
                {
                    sw.Write(returnData);
                    sw.Flush();
                    sw.Close();
                }
                context.Response.Write("{\"name\":\"" + filename + "\",\"path\":\"/StaticPage/HtmlFile/" + filename + "\",\"result\":\"ok\"}");
            }
            else
            {
                context.Response.Write("{\"result\":\"error\"}");
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