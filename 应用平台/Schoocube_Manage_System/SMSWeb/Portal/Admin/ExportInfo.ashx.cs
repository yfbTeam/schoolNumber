using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;

namespace SMSWeb.Portal.Admin
{
    /// <summary>
    /// ExportInfo 的摘要说明
    /// </summary>
    public class ExportInfo : IHttpHandler
    {
        SMSBLL.AdminManagerService BllAMS = new SMSBLL.AdminManagerService();
        SMSBLL.MonitorRecordService BllMRS = new SMSBLL.MonitorRecordService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request["func"];
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "ExportCourse": ExportCourse(context); break;
                    case "ExportVisitRate": ExportVisitRate(context); break;
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
                DataTable dt = BllAMS.ExportExcel(ht);
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

        public void ExportVisitRate(HttpContext context) 
        {
            try
            {
                context.Response.ContentType = "text/plain";
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", 1);
                ht.Add("PageSize", 100);
                if (!string.IsNullOrWhiteSpace(context.Request["RequestType"]))
                    ht.Add("RequestType", context.Request["RequestType"]);
                if (!string.IsNullOrWhiteSpace(context.Request["StarDate"]))
                    ht.Add("StarDate", context.Request["StarDate"]);
                if (!string.IsNullOrWhiteSpace(context.Request["EndDate"]))
                    ht.Add("EndDate", context.Request["EndDate"]);
                int rows = 0;
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                DataTable dt = BllMRS.GetNewRecordForOrder(ht, ref rows);
                Hashtable header = new Hashtable();
                header.Add("RequestType", "类型");
                header.Add("RequestDate", "日期");
                header.Add("RequestSourceID", "关联ID");
                //foreach (DataColumn dc in dt.Columns)
                //{
                //    if (header.ContainsKey(dc.ColumnName))
                //    {
                //        dc.Caption = header[dc.ColumnName].ToString();
                //    }
                //}
                for (int i = 0; i < 7; i++)
                {
                    if (header.ContainsKey(dt.Columns[i].ColumnName)) 
                    {
                        dt.Columns[i].ColumnName = header[dt.Columns[i].ColumnName].ToString();
                    }
                }
                DataTable dtResult = new DataTable();
                dtResult = dt.Clone();
                foreach (DataColumn col in dtResult.Columns)
                {
                    if (col.ColumnName == "类型")
                    {
                        //修改列类型
                        col.DataType = typeof(String);
                    }
                }
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dtResult.Rows.Add(dt.Rows[i].ItemArray);
                }

                foreach (DataRow dr in dtResult.Rows)
                {
                    string type = dr["类型"].ToString();
                    string msg = string.Empty;
                    switch (type)
                    {
                        case "0": msg = "课程"; break;
                        case "1": msg = "知识点"; break;
                        case "2": msg = "资源"; break;
                        case "3": msg = "新闻通知"; break;
                        case "4": msg = "知识库"; break;
                        case "5": msg = "登录"; break;
                    }
                    dr.BeginEdit();
                    dr["类型"] = msg;
                    dr.EndEdit();
                }
                switch (context.Request["ExportType"].ToString())
                {
                    case "excel":
                        ExcelHelper.ExportByWeb(dtResult, "名称,总记录数,类型,日期,外部学员,内部学员,关联ID", "访问率分析", "Sheet1");
                        break;
                    case "word":
                        WordHelper.ExportByWeb(dtResult, "名称,总记录数,类型,日期,外部学员,内部学员,关联ID", "访问率分析", "Sheet1");
                        break;
                    case "pdf":
                        PDFHelper.ExportByWeb(dtResult, "名称,总记录数,类型,日期,外部学员,内部学员,关联ID", "访问率分析", "Sheet1");
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