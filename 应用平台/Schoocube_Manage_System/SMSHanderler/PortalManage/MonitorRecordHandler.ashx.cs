using SMSUtility;
using SMSUtility.FusionChart;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace SMSHanderler.PortalManage
{
    /// <summary>
    /// MonitorRecordHandler 的摘要说明
    /// </summary>
    public class MonitorRecordHandler : IHttpHandler
    {
        SMSBLL.MonitorRecordService BllMRS = new SMSBLL.MonitorRecordService();
        SMSBLL.BLLCommon common = new SMSBLL.BLLCommon();
        FusionCharPublicClass fusionCharPulic = new FusionCharPublicClass();
        SMSBLL.System_VisitRateService BllSVRS = new SMSBLL.System_VisitRateService();
        SMSBLL.System_UserOnLineService BllSUOLS = new SMSBLL.System_UserOnLineService();
        SMSBLL.CourseService BllCS = new SMSBLL.CourseService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            string action = context.Request["func"];
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "AddRecord": AddRecord(context); break;
                    case "GetPageList": GetPageList(context); break;
                    case "QueryChart": QueryChart(context); break;
                    case "EditVisitRest": EditVisitRest(context); break;
                    case "GetVisitRatePageList": GetVisitRatePageList(context); break;
                    case "QueryNetworkflowChart": QueryNetworkflowChart(context); break;
                    case "QueryNetworkflowEChart": QueryNetworkflowEChart(context); break;
                    case "GetLookPersonPageList": GetLookPersonPageList(context); break;
                    case "UpdateUserOnLine": UpdateUserOnLine(context); break;
                    case "GetUserOnLineList": GetUserOnLineList(context); break;
                    case "GetCourseRecordList": GetCourseRecordList(context); break;
                    case "QeuryChartForRequest": QeuryChartForRequest(context); break;
                }
            }
            else
            {
                context.Response.Write("System Error");
            }
        }

        public void AddRecord(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                //Hashtable ht = new Hashtable();
                //if (!string.IsNullOrWhiteSpace(context.Request["RequestType"]))
                //    ht.Add("RequestType", context.Request["RequestType"]);
                //if (!string.IsNullOrWhiteSpace(context.Request["RequestSourceID"]))
                //    ht.Add("RequestSourceID", context.Request["RequestSourceID"]);
                //if (!string.IsNullOrWhiteSpace(context.Request["RequestUrl"]))
                //    ht.Add("RequestUrl", context.Request["RequestUrl"]);
                //if (!string.IsNullOrWhiteSpace(context.Request["RequestUserType"]))
                //    ht.Add("RequestUserType", context.Request["RequestUserType"]);
                //if (!string.IsNullOrWhiteSpace(context.Request["Creator"]))
                //    ht.Add("Creator", context.Request["Creator"]);

                SMSModel.MonitorRecord mr = new SMSModel.MonitorRecord();
                mr.RequestDate = DateTime.Now;
                mr.RequestType = string.IsNullOrWhiteSpace(context.Request["RequestType"]) ? (int)RecordType.登录 : int.Parse(context.Request["RequestType"]);
                mr.RequestSourceID = string.IsNullOrWhiteSpace(context.Request["RequestSourceID"]) ? "-1" : context.Request["RequestSourceID"];
                if (!string.IsNullOrWhiteSpace(context.Request["RequestType"]) && Convert.ToInt32(context.Request["RequestType"]) == (int)RecordType.课程)
                {
                    if (mr.RequestSourceID != "-1") UpdateCourseClickNum(Convert.ToInt32(mr.RequestSourceID));
                }
                mr.RequestSourceName = context.Request["RequestSourceName"];
                mr.RequestCount = 1;
                mr.RequestUrl = context.Request["RequestUrl"];
                mr.RequestUserType = string.IsNullOrWhiteSpace(context.Request["RequestUserType"]) ? (int)RequestUserType.内部学员 : Convert.ToInt32(context.Request["RequestUserType"]);
                mr.IP = IPHelper.GetIP();
                mr.Creator = string.IsNullOrWhiteSpace(context.Request["Creator"]) ? "-1" : context.Request["Creator"];
                mr.IDCard = string.IsNullOrWhiteSpace(context.Request["IDCard"]) ? "-1" : context.Request["IDCard"];
                mr.RequestAddress = IPHelper.GetAddressFromCurrentIP();
                SMSModel.JsonModel Model = BllMRS.Add(mr);
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

        public void GetPageList(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());
                if (!string.IsNullOrWhiteSpace(context.Request["RequestType"]))
                    ht.Add("RequestType", context.Request["RequestType"]);
                if (!string.IsNullOrWhiteSpace(context.Request["RequestSourceName"]))
                    ht.Add("RequestSourceName", context.Request["RequestSourceName"]);

                if (!string.IsNullOrWhiteSpace(context.Request["StarDate"]))
                    ht.Add("StarDate", context.Request["StarDate"]);
                if (!string.IsNullOrWhiteSpace(context.Request["EndDate"]))
                    ht.Add("EndDate", context.Request["EndDate"]);
                int rows = 0;
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                DataTable dt = BllMRS.GetNewRecordForOrder(ht, ref rows);
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
            SMSModel.JsonModel jsonModel = null;
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                string isload = context.Request["FirstLoad"];
                if (!string.IsNullOrWhiteSpace(context.Request["RequestType"]))
                    ht.Add("RequestType", context.Request["RequestType"]);
                if (!string.IsNullOrWhiteSpace(context.Request["RequestSourceName"]))
                    ht.Add("RequestSourceName", context.Request["RequestSourceName"]);

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
                if (!string.IsNullOrWhiteSpace(context.Request["RequestSourceName"]))
                    ht.Add("RequestSourceName", context.Request["RequestSourceName"]);

                if (!string.IsNullOrWhiteSpace(context.Request["StarDate"]))
                    ht.Add("StarDate", context.Request["StarDate"]);
                if (!string.IsNullOrWhiteSpace(context.Request["EndDate"]))
                    ht.Add("EndDate", context.Request["EndDate"]);

                int rows = 0;
                DataTable dt = BllMRS.GetRecordForStatisc(ht, ref rows);
                chart c = new chart();
                c.Caption = "访问率分析图";
                c.YAxisName = "数量";
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


        public void GetVisitRatePageList(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                string where = string.Empty;
                bool isPage = true;
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());
                if (!string.IsNullOrWhiteSpace(context.Request["StarDate"]) && !string.IsNullOrWhiteSpace(context.Request["EndDate"]))
                    where += " and ([CreateTime]>='" + context.Request["StarDate"].ToString() + " 00:00:00' and [CreateTime]<='" + context.Request["EndDate"].ToString() + " 23:59:59')";
                if (!string.IsNullOrWhiteSpace(context.Request["UserName"]))
                {
                    if (Convert.ToInt32(context.Request["UserName"]) == (int)VisitUserType.普通用户)
                        where += " and UserName!='-1'";
                    else
                        where += " and UserName='-1'";
                }
                if (!string.IsNullOrWhiteSpace(context.Request["isPage"])) isPage = Convert.ToBoolean(context.Request["isPage"]);
                ht.Add("TableName", "System_VisitRate");
                ht.Add("Order", " ICookie,CreateTime desc");
                SMSModel.JsonModel Model = BllSVRS.GetPage(ht, isPage, where);
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

        public void EditVisitRest(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                SMSModel.System_VisitRate model = new SMSModel.System_VisitRate();
                model.IP = IPHelper.GetIP();
                model.Address = IPHelper.GetAddressFromCurrentIP();
                model.UserName = !string.IsNullOrWhiteSpace(context.Request["UserName"]) ? context.Request["UserName"] : "-1";
                model.refer = context.Request["user_agent"];
                model.ICookie = context.Request["icookie"];
                model.CreateTime = DateTime.Now;
                model.Url = context.Request["Url"];
                SMSModel.JsonModel jsonModel = BllSVRS.Add(model);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        public void QueryNetworkflowChart(HttpContext context) 
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                string isload = context.Request["FirstLoad"];
                if (!string.IsNullOrWhiteSpace(context.Request["StarDate"]))
                    ht.Add("StarDate", context.Request["StarDate"]);
                if(!string.IsNullOrWhiteSpace(context.Request["EndDate"]))
                    ht.Add("EndDate", context.Request["EndDate"]);
                if (!string.IsNullOrWhiteSpace(context.Request["UserName"]))
                    ht.Add("UserName", context.Request["UserName"]);
                int rows = 0;
                DataTable dt = BllMRS.GetNetworkflowForOrder(ht, ref rows);
                chart c = new chart();
                c.Caption = "网站流量统计";
                c.YAxisName = "数量";
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
                FusionChartType chartType = FusionChartType.Line2;

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

        public void QueryNetworkflowEChart(HttpContext context) 
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                string isload = context.Request["FirstLoad"];
                if (!string.IsNullOrWhiteSpace(context.Request["StarDate"]))
                    ht.Add("StarDate", context.Request["StarDate"]);
                if (!string.IsNullOrWhiteSpace(context.Request["EndDate"]))
                    ht.Add("EndDate", context.Request["EndDate"]);
                if (!string.IsNullOrWhiteSpace(context.Request["UserName"]))
                    ht.Add("UserName", context.Request["UserName"]);
                SMSModel.JsonModel jsonModel = BllMRS.QueryNetworkflowEChart(ht);
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

        public void GetLookPersonPageList(HttpContext context) 
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                    ht.Add("RequestSourceID", context.Request["Id"]);
                if (!string.IsNullOrWhiteSpace(context.Request["Date"]))
                    ht.Add("RequestDate", context.Request["Date"]);
                SMSModel.JsonModel jsonModel = BllMRS.GetRecordForResouceID(ht);
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {

                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errNum=400,
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void UpdateUserOnLine(HttpContext context) 
        {
            SMSModel.JsonModel jsonModel =null;
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {

                Hashtable ht = new Hashtable();
                SMSModel.System_UserOnLine model=new SMSModel.System_UserOnLine();
                string icookie=string.Empty;
                if (!string.IsNullOrWhiteSpace(context.Request["icookie"]) && !string.IsNullOrWhiteSpace(context.Request["icookie"])) 
                {
                    icookie = context.Request["icookie"];
                    ht.Add("ICookie", icookie);
                }
                if (!string.IsNullOrWhiteSpace(context.Request["logOut"]) && !string.IsNullOrWhiteSpace(context.Request["logOut"])) 
                {
                    ht.Add("logOut", "logOut");
                }
                BllMRS.RemoveUserOnLine(ht);
                string userName = context.Request["UserName"] == "-1" ? "游客" : context.Request["UserName"];
                jsonModel = BllSUOLS.GetEntityListByField("ICookie", icookie);
                if (jsonModel.errNum!=0)
                {
                    
                    DateTime CreateDate = DateTime.Now;
                    model.UserName=userName;
                    model.IP = IPHelper.GetIP();
                    model.CreateDate=CreateDate;
                    model.ICookie=icookie;
                    model.Photo = context.Request["Photo"];
                    jsonModel = BllSUOLS.Add(model);
                }
                else if (jsonModel.errNum==0)
                {
                    List<SMSModel.System_UserOnLine> list= jsonModel.retData as List<SMSModel.System_UserOnLine>;
                    if (list != null && list.Count > 0)
                    {
                        model = list[0];
                        model.CreateDate = DateTime.Now;
                        model.UserName = userName;
                        model.Photo = context.Request["Photo"];
                        jsonModel = BllSUOLS.Update(model);
                    }
                }
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                jsonModel = new SMSModel.JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void GetUserOnLineList(HttpContext context) 
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            SMSModel.JsonModel jsonModel = null;
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "System_UserOnLine");
                ht.Add("Order", " CreateDate desc");
                jsonModel = BllSUOLS.GetPage(ht, false, string.Empty);
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                jsonModel = new SMSModel.JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void UpdateCourseClickNum(int courseId) 
        {
            try
            {
                SMSModel.Course course = BllCS.GetEntityById(courseId).retData as SMSModel.Course;
                if (course!=null)
                {
                    course.ClickNum += 1;
                    BllCS.Update(course);
                }
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        public void GetCourseRecordList(HttpContext context) 
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            SMSModel.JsonModel jsonModel = null;
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());
                string where = string.Empty;
                if (!string.IsNullOrWhiteSpace(context.Request["RequestSourceID"]))
                    where += "and  RequestSourceID=" + context.Request["RequestSourceID"];
                ht.Add("TableName", "MonitorRecord");
                ht.Add("Order", " RequestDate,RequestSourceName desc");
                jsonModel = BllSVRS.GetPage(ht, true, where);
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                jsonModel.errMsg = ex.Message;
                jsonModel.errNum = 400;
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