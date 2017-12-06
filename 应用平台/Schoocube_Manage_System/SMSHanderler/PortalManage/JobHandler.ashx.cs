using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SMSHanderler.PortalManage
{
    /// <summary>
    /// JobHandler 的摘要说明
    /// </summary>
    public class JobHandler : IHttpHandler
    {
        SMSBLL.EnterpriseJobService BllEJS = new SMSBLL.EnterpriseJobService();
        SMSBLL.AdminManagerService BllAMS = new SMSBLL.AdminManagerService();
        SMSBLL.JobClassService BllJCS = new SMSBLL.JobClassService();
        
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request["func"];
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "GetPageList": GetPageList(context); break;
                    case "GetPageItemList": GetPageItemList(context); break;
                    case "GetCourseListByJobIds": GetCourseListByJobIds(context); break;
                    case "GetPageJobGuide": GetPageJobGuide(context); break;
                    case "GetPageCourseList": GetPageCourseList(context); break;
                    case "EditCourseForJob": EditCourseForJob(context); break;
                    case "MoreEditCourseForJob": MoreEditCourseForJob(context); break;
                }
            }
            else
            {
                context.Response.Write("System Error");
            }
        }

        public void GetPageList(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                bool isPage = true;
                if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) ht.Add("PageSize", context.Request["PageSize"].ToString());
                ht.Add("TableName", "EnterpriseJob");
                string where = string.Empty;
                if (!string.IsNullOrWhiteSpace(context.Request["isPage"])) isPage = Convert.ToBoolean(context.Request["isPage"]);
                where += " and IsDelete =" + (int)SMSUtility.SysStatus.正常;
                where += " and CreateTime<=" + DateTime.Now;
                SMSModel.JsonModel Model = BllEJS.GetPage(ht, isPage, where);
                ht.Add("Order", " CreateTime desc");

                context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    retData = "",
                    status = "no"
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void GetPageItemList(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) ht.Add("PageIndex", context.Request["PageIndex"]);
                if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) ht.Add("PageSize", context.Request["PageSize"]);
                if (!string.IsNullOrWhiteSpace(context.Request["NameIntro"])) ht.Add("NameIntro", context.Request["NameIntro"]);
                if (!string.IsNullOrWhiteSpace(context.Request["CreateTime"])) ht.Add("CreateTime", context.Request["CreateTime"]);
                if (!string.IsNullOrWhiteSpace(context.Request["StarMoney"])) ht.Add("StarMoney", context.Request["StarMoney"]);
                if (!string.IsNullOrWhiteSpace(context.Request["EndMoney"])) ht.Add("EndMoney", context.Request["EndMoney"]);
                if (!string.IsNullOrWhiteSpace(context.Request["ID"])) ht.Add("ID", context.Request["ID"]);
                SMSModel.JsonModel Model = BllAMS.GetPageItemList(ht);
                context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    retData = "",
                    status = "no"
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void GetCourseListByJobIds(HttpContext context) 
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(context.Request["JobIDs"])) ht.Add("JobIDs", context.Request["JobIDs"]);
                SMSModel.JsonModel Model = BllAMS.GetCourseListByJobIds(ht);
                context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {

                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                  {
                      errMsg = ex.Message,
                      retData = "",
                      status = "no"
                  };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void GetPageJobGuide(HttpContext context) 
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            SMSModel.JsonModel jsonModel = null;
            try
            {
                Hashtable ht = new Hashtable();
                bool isPage = true;
                if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) ht.Add("PageIndex", context.Request["PageIndex"]);
                if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) ht.Add("PageSize", context.Request["PageSize"]);
                string where = string.Empty;
                if (!string.IsNullOrWhiteSpace(context.Request["isPage"])) isPage = Convert.ToBoolean(context.Request["isPage"]);
                //where += " and IsDelete =" + (int)SMSUtility.SysStatus.正常;
                ht.Add("IsDelete", ((int)SMSUtility.SysStatus.正常).ToString());
                if (!string.IsNullOrWhiteSpace(context.Request["StarDate"]) && !string.IsNullOrWhiteSpace(context.Request["EndDate"]))
                    ht.Add("CreateDate", "and ([CreateTime]>='" + context.Request["StarDate"].ToString() + " 00:00:00' and [CreateTime]<='" + context.Request["EndDate"].ToString() + " 23:59:59')");
                    //where += " and ([CreateTime]>='" + context.Request["StarDate"].ToString() + " 00:00:00' and [CreateTime]<='" + context.Request["EndDate"].ToString() + " 23:59:59')";
                if (!string.IsNullOrWhiteSpace(context.Request["keyWord"]))
                    ht.Add("keyWord", "and (Name+Introduction+Company like '%" + context.Request["keyWord"] + "%') ");
                    //where += " and (Name+Introduction+Company like '%" + context.Request["keyWord"] + "%') ";
                //ht.Add("Order", " CreateTime desc");
                ht.Add("TableName", "EnterpriseJob");
                jsonModel = BllEJS.GetPage(ht, isPage, where);
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    status = "no",
                    errNum=400
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void GetPageCourseList(HttpContext context) 
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            SMSModel.JsonModel jsonModel = null;
            try
            {
                bool isPage = true;
                string where = string.Empty;
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) ht.Add("PageIndex", context.Request["PageIndex"]);
                if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) ht.Add("PageSize", context.Request["PageSize"]);
                if (!string.IsNullOrWhiteSpace(context.Request["isPage"])) isPage = Convert.ToBoolean(context.Request["isPage"]);
                if (!string.IsNullOrWhiteSpace(context.Request["CatagoryID"])) ht.Add("CatagoryID", context.Request["CatagoryID"]);
                if (!string.IsNullOrWhiteSpace(context.Request["inIDs"])) ht.Add("inIDs", context.Request["inIDs"]);
                ht.Add("IsDelete", ((int)SMSUtility.SysStatus.正常).ToString());
                ht.Add("TableName", "Course");
                jsonModel = BllEJS.GetPage(ht, isPage, where);
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {

                jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    status = "no",
                    errNum = 400
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void EditCourseForJob(HttpContext context) 
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            SMSModel.JsonModel jsonModel = null;
            try
            {
                string operation = context.Request["Operation"];
                SMSModel.JobClass jc=null;
                if (operation == "add")
                {
                    jc = new SMSModel.JobClass
                    {
                        CourseID = Convert.ToInt32(context.Request["CourseID"]),
                        JobID = Convert.ToInt32(context.Request["JobID"])
                    };
                    jsonModel = BllJCS.Add(jc);
                }
                else if (operation=="del")
                {
                    Hashtable ht=new Hashtable();
                    ht.Add("TableName","JobClass");
                    string where=string.Empty;
                    if (!string.IsNullOrWhiteSpace(context.Request["CourseID"])) where+=" and CourseID="+context.Request["CourseID"];
                    if (!string.IsNullOrWhiteSpace(context.Request["JobID"])) where+=" and JobID="+context.Request["JobID"];
                    System.Data.DataTable dt = BllJCS.GetData(ht, false, where);
                    if (dt!=null && dt.Rows.Count>0)
                    {
                        int ID = Convert.ToInt32(dt.Rows[0]["ID"]);
                        jsonModel = BllJCS.Delete(ID);
                    }
                    else
                    {
                        jsonModel = new SMSModel.JsonModel()
                        {
                            errMsg = "fail",
                            status = "no",
                            errNum = 400
                        };
                    }
                    
                }
            }
            catch (Exception ex)
            {
                jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    status = "no",
                    errNum = 400
                };
            }
            context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
        }

        public void MoreEditCourseForJob(HttpContext context) 
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            SMSModel.JsonModel jsonModel = null;
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("Operation", context.Request["Operation"]);
                ht.Add("CourseIds", context.Request["CourseIds"]);
                if (!string.IsNullOrWhiteSpace(Convert.ToString(context.Request["JobID"]))) ht.Add("JobID", context.Request["JobID"]);
                jsonModel = BllEJS.MoreEditCourseForJob(ht);
            }
            catch (Exception ex)
            {
                jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    status = "no",
                    errNum = 400
                };
            }
            context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
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