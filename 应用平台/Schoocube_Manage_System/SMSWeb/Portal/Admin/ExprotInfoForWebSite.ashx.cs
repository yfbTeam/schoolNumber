using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace SMSWeb.Portal.Admin
{
    /// <summary>
    /// ExprotInfoForWebSite 的摘要说明
    /// </summary>
    public class ExprotInfoForWebSite : IHttpHandler
    {
        SMSBLL.AdminManagerService BllAMS = new SMSBLL.AdminManagerService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request["func"];
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "ExportCourse": ExportCourse(context); break;
                }
            }
            context.Response.Write("Hello World");
        }

        public void ExportCourse(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "Course");
                ht.Add("CourseType", context.Request["CourseType"]);
                DataTable dt = BllAMS.ExportExcelWebSite(ht);
                switch (context.Request["ExportType"].ToString())
                {
                    case "excel":
                        ExcelHelper.ExportByWeb(dt, "序号,课程名称,课程类型,课程价格,是否收费,年级", "培训课程", "Sheet1");
                        break;
                    case "word":
                        WordHelper.ExportByWeb(dt, "序号,课程名称,课程类型,课程价格,是否收费,年级", "培训课程", "Sheet1");
                        break;
                    case "pdf":
                        PDFHelper.ExportByWeb(dt, "序号,课程名称,课程类型,课程价格,是否收费,年级", "培训课程", "Sheet1");
                        break;
                    default:
                        break;
                }

            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
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