using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SMSBLL;
using SMSModel;
using System.Collections;
using SMSUtility;

namespace SMSHanderler.BaseHandlers
{
    /// <summary>
    /// BookCatagory 的摘要说明
    /// </summary>
    public class BookCatagory : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("Hello World");
        }
        #region 文件目录结构
        /// <summary>
        /// 文件目录结构
        /// </summary>
        /// <param name="pid"></param>
        private void Period(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = "http://192.168.1.47:8090/InitialDataHandler.ashx?";
            string urlbady = "func=GetPSTVData&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        private void Chapator(HttpContext context)
        {

            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = "http://192.168.1.47:8090/TextbookCatalogHandler.ashx?";
            string urlbady = "func=GetTextbookCatalogData&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
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