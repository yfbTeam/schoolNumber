using SMSUtility;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;

namespace SMSWeb
{
    /// <summary>
    /// phone 的摘要说明
    /// </summary>
    public class phone : IHttpHandler
    {
        string result = "";
        public void ProcessRequest(HttpContext context)
        {
            string urlHeader = ConfigHelper.GetConfigString("HttpPhone").ToString();

            string HttpMethod = context.Request.HttpMethod;
            if (HttpMethod.ToUpper() == "POST")
            {
                int parmLen = context.Request.Form.AllKeys.Length;
                string FirstKey = context.Request.Form.AllKeys[0];
                string FirstParm = context.Request.Form[0];
                string sig = EncryptHelper.Md5By32(HttpUtility.UrlDecode(context.Request["sig"]));
                string parms = HttpUtility.UrlDecode(context.Request.Form.ToString());
                parms = parms.Substring(0, parms.IndexOf("sig") + 4) + sig;
                PostResult(urlHeader, parms);
            }
            context.Response.Write(result);
            context.Response.End();
        }

        private void PostResult(string url, string Content)
        {
            result = RequestPostUrl(url, Content);
        }
        private void GetResult(string url)
        {
            result = NetHelper.RequestGetUrl(url);
        }

        public static string RequestPostUrl(string url, string content)//post方式向页面提交 
        {
            byte[] bs = Encoding.UTF8.GetBytes(content);
            string resultStream = null;
            HttpWebRequest req = (HttpWebRequest)HttpWebRequest.Create(url);
            req.Method = "POST";
            req.ContentType = "application/x-www-form-urlencoded;charset=utf-8";
            req.ContentLength = bs.Length;

            req.Timeout = 20000;
            //设置发送内容
            try
            {
                using (Stream reqStream = req.GetRequestStream())
                {
                    reqStream.Write(bs, 0, bs.Length);
                    reqStream.Close();
                    reqStream.Dispose();
                }
            }
            catch
            {
               
            }
            try
            {
                WebResponse wr = req.GetResponse();
                using (wr)
                {

                    //在这里对接收到的页面内容进行处理
                    Stream stream = wr.GetResponseStream();
                    StreamReader sr = new StreamReader(stream, Encoding.UTF8);
                    resultStream = @sr.ReadToEnd();
                }
            }
            catch (Exception e)
            {
                resultStream = "0";

            }
            return resultStream;

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