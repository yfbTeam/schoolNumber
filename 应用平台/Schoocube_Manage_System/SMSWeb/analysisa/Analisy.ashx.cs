using Newtonsoft.Json.Linq;
using SMSBLL;
using SMSIDAL;
using SMSModel;
using SMSUtility;
using SMSUtility.FusionChart;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace SMSWeb.analysisa
{
    /// <summary>
    /// Analisy 的摘要说明
    /// </summary>
    public class Analisy : IHttpHandler
    {
        Exam_ExaminationService BllMRS = new Exam_ExaminationService();
        BLLCommon common = new BLLCommon();
        FusionCharPublicClass fusionCharPulic = new FusionCharPublicClass();
        System_VisitRateService BllSVRS = new System_VisitRateService();
        System_UserOnLineService BllSUOLS = new System_UserOnLineService();
        CourseService BllCS = new CourseService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            string action = context.Request["func"];
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "GetExamList": GetExamList(context); break;
                    case "QueryChart": QueryChart(context); break;
                    case "QeuryChartForRequest": QeuryChartForRequest(context); break;
                    case "CouseTaskAnalis": CouseTaskAnalis(context); break;
                    case "CouseCompleteAnalis": CouseCompleteAnalis(context); break;
                    case "CouseCompleteChart": CouseCompleteChart(context); break;
                    case "CouseCompleteChartOfStu": CouseCompleteChartOfStu(context); break;
                    case "CouseEvalue": CouseEvalue(context); break;

                }
            }
            else
            {
                context.Response.Write("System Error");
            }
        }
        private void CouseEvalue(HttpContext context)
        {
            CommonHandler commonHander = new CommonHandler();
            Course_EvalueService bll = new Course_EvalueService();
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                bool IsPage = true;
                if (context.Request["IsPage"].SafeToString().Length > 0)
                {
                    IsPage = Convert.ToBoolean(context.Request["IsPage"]);
                }
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("CourseName", context.Request["CourseName"].SafeToString());
                ht.Add("CourseID", context.Request["CourseID"].SafeToString());
                int rows = 0;
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                DataTable dt = bll.CourseEvalueStatas(ht, out rows, IsPage);
                list = common.DataTableToList(dt);
                int RowCount = rows;
                JsonModel Model = null;
                if (IsPage == true)
                {
                    //总页数
                    int PageCount = (int)Math.Ceiling(RowCount * 1.0 / int.Parse(context.Request["PageSize"]));
                    //将数据封装到PagedDataModel分页数据实体中
                    PagedDataModel<Dictionary<string, object>> pagedDataModel = new PagedDataModel<Dictionary<string, object>>()
                    {
                        PageCount = PageCount,
                        PagedData = list,
                        PageIndex = int.Parse(context.Request["PageIndex"]),
                        PageSize = int.Parse(context.Request["PageSize"]),
                        RowCount = RowCount
                    };
                    Model = new JsonModel()
                   {
                       errMsg = "success",
                       errNum = 0,
                       retData = pagedDataModel
                   };
                }
                else
                {
                    Model = new JsonModel()
                   {
                       errMsg = "success",
                       errNum = 0,
                       retData = list
                   };
                }
                Model = commonHander.AddCreateNameForData(Model, 0, IsPage);
                context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                JsonModel jsonModel = new JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }
        public void CouseCompleteChartOfStu(HttpContext context)
        {
            CommonHandler commonHander = new CommonHandler();
            CourseService bll = new CourseService();
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                string isload = context.Request["FirstLoad"];
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());
                ht.Add("CreateUID", context.Request["CreateUID"].SafeToString());
                int rows = 0;
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                DataTable dt = bll.CouseTaskAnalis(ht, out rows, false);
                list = common.DataTableToList(dt);

                JsonModel Model = new JsonModel()
                {
                    errMsg = "success",
                    errNum = 0,
                    retData = list
                };
                Model = commonHander.AddCreateNameForData(Model, 0, false);
                DataTable dtnew = new DataTable();
                dtnew.Columns.Add("Title");
                dtnew.Columns.Add("Weight");

                foreach (Dictionary<string, object> dicItem in (List<Dictionary<string, object>>)Model.retData)
                {
                    DataRow dr = dtnew.NewRow();
                    dr["Title"] = dicItem["CourseName"] + "-" + dicItem["TaskName"];
                    dr["Weight"] = dicItem["Weight"];
                    dtnew.Rows.Add(dr);
                }
                chart c = new chart();
                c.Caption = "学生任务完成情况";
                c.YAxisName = "完成比重";
                c.Bgcolor = "F7F7F7, E9E9E9";
                c.NumVDivlines = "10";
                c.DivLineAlpha = "30";
                c.LabelPadding = "10";
                c.YAxisValuesPadding = "1";
                c.ShowValues = "1";
                c.RotateValues = "1";
                c.ValuePosition = "auto";
                c.FormatNumberScale = "0";
                c.LimitsDecimalPrecision = "3";
                FusionChartType chartType = FusionChartType.Line;
                string chartString = fusionCharPulic.GetXMLData(dtnew, c, null, null, chartType, null, "VisitRate", "866", "300", isload);
                JsonModel jsonModel = new JsonModel()
                {
                    errMsg = "success",
                    errNum = 0,
                    retData = chartString
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");

            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }
        public void CouseCompleteChart(HttpContext context)
        {
            CommonHandler commonHander = new CommonHandler();
            CourseService bll = new CourseService();
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                string isload = context.Request["FirstLoad"];
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());

                int rows = 0;
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                DataTable dt = bll.CouseCompleteAnalis(ht, out rows, false);
                list = common.DataTableToList(dt);

                JsonModel Model = new JsonModel()
                {
                    errMsg = "success",
                    errNum = 0,
                    retData = list
                };
                Model = commonHander.AddCreateNameForData(Model, 0, false);
                DataTable dtnew = new DataTable();
                dtnew.Columns.Add("Title");
                dtnew.Columns.Add("Score");

                foreach (Dictionary<string, object> dicItem in (List<Dictionary<string, object>>)Model.retData)
                {
                    double CompleteWeight = Convert.ToDouble(dicItem["CompleteWeight"]);
                    double AllWeigth = Convert.ToDouble(dicItem["AllWeigth"]);
                    DataRow dr = dtnew.NewRow();
                    dr["Title"] = dicItem["CreateName"] + "-" + dicItem["Name"];
                    dr["Score"] = (float)(Math.Round(CompleteWeight * 100) / 100) / (float)(Math.Round(AllWeigth * 100) / 100);
                    dtnew.Rows.Add(dr);
                }
                chart c = new chart();
                c.Caption = "考试成绩分布图";
                c.YAxisName = "分数";
                c.Bgcolor = "F7F7F7, E9E9E9";
                c.NumVDivlines = "10";
                c.DivLineAlpha = "30";
                c.LabelPadding = "10";
                c.YAxisValuesPadding = "1";
                c.ShowValues = "1";
                c.RotateValues = "1";
                c.ValuePosition = "auto";
                c.FormatNumberScale = "0";
                c.LimitsDecimalPrecision = "3";
                FusionChartType chartType = FusionChartType.Line;
                string chartString = fusionCharPulic.GetXMLData(dtnew, c, null, null, chartType, null, "VisitRate", "866", "300", isload);
                JsonModel jsonModel = new JsonModel()
                {
                    errMsg = "success",
                    errNum = 0,
                    retData = chartString
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");

            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }
        public void CouseCompleteAnalis(HttpContext context)
        {
            CommonHandler commonHander = new CommonHandler();
            CourseService bll = new CourseService();
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());

                int rows = 0;
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                DataTable dt = bll.CouseCompleteAnalis(ht, out rows);
                list = common.DataTableToList(dt);
                int RowCount = rows;
                //总页数
                int PageCount = (int)Math.Ceiling(RowCount * 1.0 / int.Parse(context.Request["PageSize"]));
                //将数据封装到PagedDataModel分页数据实体中
                PagedDataModel<Dictionary<string, object>> pagedDataModel = new PagedDataModel<Dictionary<string, object>>()
                {
                    PageCount = PageCount,
                    PagedData = list,
                    PageIndex = int.Parse(context.Request["PageIndex"]),
                    PageSize = int.Parse(context.Request["PageSize"]),
                    RowCount = RowCount
                };
                JsonModel Model = new JsonModel()
                {
                    errMsg = "success",
                    errNum = 0,
                    retData = pagedDataModel
                };
                Model = commonHander.AddCreateNameForData(Model, 0, true);
                context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }
        public void CouseTaskAnalis(HttpContext context)
        {
            CommonHandler commonHander = new CommonHandler();
            CourseService bll = new CourseService();
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());
                ht.Add("CreateUID", context.Request["CreateUID"].SafeToString());
                int rows = 0;
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                DataTable dt = bll.CouseTaskAnalis(ht, out rows);
                list = common.DataTableToList(dt);
                int RowCount = rows;
                //总页数
                int PageCount = (int)Math.Ceiling(RowCount * 1.0 / int.Parse(context.Request["PageSize"]));
                //将数据封装到PagedDataModel分页数据实体中
                PagedDataModel<Dictionary<string, object>> pagedDataModel = new PagedDataModel<Dictionary<string, object>>()
                {
                    PageCount = PageCount,
                    PagedData = list,
                    PageIndex = int.Parse(context.Request["PageIndex"]),
                    PageSize = int.Parse(context.Request["PageSize"]),
                    RowCount = RowCount
                };
                JsonModel Model = new JsonModel()
                {
                    errMsg = "success",
                    errNum = 0,
                    retData = pagedDataModel
                };
                Model = commonHander.AddCreateNameForData(Model, 0, true);
                context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }
        public void GetExamList(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());
                if (!string.IsNullOrWhiteSpace(context.Request["RequestType"]))
                    ht.Add("RequestType", context.Request["RequestType"]);
                if (!string.IsNullOrWhiteSpace(context.Request["RequestCourseName"]))
                    ht.Add("RequestCourseName", context.Request["RequestCourseName"]);

                if (!string.IsNullOrWhiteSpace(context.Request["StarDate"]))
                    ht.Add("StarDate", context.Request["StarDate"]);
                if (!string.IsNullOrWhiteSpace(context.Request["EndDate"]))
                    ht.Add("EndDate", context.Request["EndDate"]);
                int rows = 0;
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                DataTable dt = BllMRS.GetStuScore(ht, out rows);
                list = common.DataTableToList(dt);
                int RowCount = rows;
                //总页数
                int PageCount = (int)Math.Ceiling(RowCount * 1.0 / int.Parse(context.Request["PageSize"]));
                //将数据封装到PagedDataModel分页数据实体中
                SMSIDAL.PagedDataModel<Dictionary<string, object>> pagedDataModel = new SMSIDAL.PagedDataModel<Dictionary<string, object>>()
                {
                    PageCount = PageCount,
                    PagedData = list,
                    PageIndex = int.Parse(context.Request["PageIndex"]),
                    PageSize = int.Parse(context.Request["PageSize"]),
                    RowCount = RowCount
                };
                SMSModel.JsonModel Model = new SMSModel.JsonModel()
                {
                    errMsg = "success",
                    errNum = 0,
                    retData = pagedDataModel
                };
                context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }
        public void QeuryChartForRequest(HttpContext context)
        {
            JsonModel jsonModel = null;
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                string isload = context.Request["FirstLoad"];
                if (!string.IsNullOrWhiteSpace(context.Request["RequestType"]))
                    ht.Add("RequestType", context.Request["RequestType"]);
                if (!string.IsNullOrWhiteSpace(context.Request["RequestCourseName"]))
                    ht.Add("RequestCourseName", context.Request["RequestCourseName"]);

                if (!string.IsNullOrWhiteSpace(context.Request["StarDate"]))
                    ht.Add("StarDate", context.Request["StarDate"]);
                if (!string.IsNullOrWhiteSpace(context.Request["EndDate"]))
                    ht.Add("EndDate", context.Request["EndDate"]);

                int rows = 0;
                DataTable dt = BllMRS.GetRecordForStatisc(ht, ref rows);
                if (dt != null)
                {
                    jsonModel = new SMSModel.JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = common.DataTableToList(dt)
                    };
                }
                else
                {
                    jsonModel = new SMSModel.JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                }
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                jsonModel = new SMSModel.JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        protected void QueryChart(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                string isload = context.Request["FirstLoad"];
                if (!string.IsNullOrWhiteSpace(context.Request["RequestType"]))
                    ht.Add("RequestType", context.Request["RequestType"]);
                if (!string.IsNullOrWhiteSpace(context.Request["RequestCourseName"]))
                    ht.Add("RequestCourseName", context.Request["RequestCourseName"]);

                if (!string.IsNullOrWhiteSpace(context.Request["StarDate"]))
                    ht.Add("StarDate", context.Request["StarDate"]);
                if (!string.IsNullOrWhiteSpace(context.Request["EndDate"]))
                    ht.Add("EndDate", context.Request["EndDate"]);

                int rows = 0;
                DataTable dt = BllMRS.GetRecordForStatisc(ht, ref rows);
                chart c = new chart();
                c.Caption = "考试成绩分布图";
                c.YAxisName = "分数";
                c.Bgcolor = "F7F7F7, E9E9E9";
                c.NumVDivlines = "10";
                c.DivLineAlpha = "30";
                c.LabelPadding = "10";
                c.YAxisValuesPadding = "1";
                c.ShowValues = "1";
                c.RotateValues = "1";
                c.ValuePosition = "auto";
                c.FormatNumberScale = "0";
                c.LimitsDecimalPrecision = "3";
                FusionChartType chartType = FusionChartType.Line;
                string chartString = fusionCharPulic.GetXMLData(dt, c, null, null, chartType, null, "VisitRate", "866", "300", isload);
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = "success",
                    errNum = 0,
                    retData = chartString
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
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