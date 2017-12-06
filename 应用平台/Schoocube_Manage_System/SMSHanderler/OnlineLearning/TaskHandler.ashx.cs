using Newtonsoft.Json.Linq;
using SMSBLL;
using SMSIDAL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SMSHanderler.OnlineLearning
{
    /// <summary>
    /// TaskHandler 的摘要说明
    /// </summary>
    public class TaskHandler : IHttpHandler
    {
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        CommonHandler common = new CommonHandler();
        Couse_TaskInfoService taskService = new Couse_TaskInfoService();
        Course_TaskRelService relService = new Course_TaskRelService();
        Couse_SelstuinfoService selstuinfoService = new Couse_SelstuinfoService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string func = context.Request["Func"];
            string result = string.Empty;
            try
            {
                switch (func)
                {
                    case "GetCourseProgressInfo":
                        GetCourseProgressInfo(context);
                        break;
                    case "GetStuTaskCompleteInfo":
                        GetStuTaskCompleteInfo(context);
                        break;
                    case "GetTaskDataPage":                       
                        GetTaskDataPage(context);
                        break;
                    case "GetTaskByID":
                        GetTaskByID(context);
                        break;
                    case "AddTask":
                        AddTask(context);
                        break;
                    case "EditTask":
                        EditTask(context);
                        break;
                    case "DeleteTask":
                        DeleteTask(context);
                        break;
                    case "GetComCountByTaskID":
                        GetComCountByTaskID(context);
                        break;
                    default:
                        jsonModel = new JsonModel()
                        {
                            errNum = 5,
                            errMsg = "没有此方法",
                            retData = ""
                        };
                        break;
                }
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();
        }
        #region 获取课程的进度信息
        private void GetCourseProgressInfo(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("CourseID", context.Request["CourceID"].ToString());
                ht.Add("ChapterID", context.Request["ChapterID"].ToString());
                ht.Add("StuIDCard", context.Request["StuIDCard"] ?? "");
                jsonModel = taskService.GetCourseProgressInfo(ht);
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
        }
        #endregion        

        #region 获取任务表的分页数据
        private void GetTaskDataPage(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("CourseID", context.Request["CourceID"] ?? "");
                ht.Add("ChapterID", context.Request["ChapterID"] ?? "");
                ht.Add("Name", context.Request["Name"] ?? "");
                ht.Add("StuIDCard", context.Request["StuIDCard"] ?? "");
                ht.Add("UserIdCard", context.Request["UserIdCard"] ?? "");
                ht.Add("ClassID", context.Request["ClassID"] ?? "");
                bool ispage = true;
                if (!string.IsNullOrEmpty(context.Request["ispage"]))
                {
                    ispage = Convert.ToBoolean(context.Request["ispage"]);
                }
                ht.Add("PageIndex", context.Request["PageIndex"]??"1");
                ht.Add("PageSize", context.Request["PageSize"]??"10");
                jsonModel = common.AddCreateNameForData(taskService.GetPage(ht, ispage),1, ispage,"","StuRange");                
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
        }
        #endregion

        #region 根据Id获取任务
        private void GetTaskByID(HttpContext context)
        {
            int itemid = Convert.ToInt32(context.Request["ItemId"]);
            jsonModel = taskService.GetEntityById(itemid);
        }
        #endregion  

        #region 获取某课程学生任务完成信息
        private void GetCourseStuTaskInfo(HttpContext context)
        {
            try
            {
                int taskid = Convert.ToInt32(context.Request["TaskID"]??"");
                jsonModel = taskService.GetEntityById(taskid);
                if (jsonModel.errNum == 0)
                {
                    Couse_TaskInfo task = jsonModel.retData as Couse_TaskInfo;
                    List<Dictionary<string, object>> list =!string.IsNullOrEmpty(task.StuRange)?common.GetStudentData(task.StuRange):new List<Dictionary<string, object>>();
                    foreach (Dictionary<string, object> item in list)
                    {

                    }
                    
                }
                Hashtable ht = new Hashtable();
                ht.Add("TaskID", taskid);              
                
                ht.Add("CourseID", context.Request["CourceID"].ToString());
                ht.Add("ChapterID", context.Request["ChapterID"].ToString());
               
                ht.Add("Name", context.Request["Name"] ?? "");
                ht.Add("StuIDCard", context.Request["StuIDCard"] ?? "");
                ht.Add("UserIdCard", context.Request["UserIdCard"] ?? "");
                jsonModel = taskService.GetStuTaskCompleteInfo(ht);
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
        }
        #endregion

        #region 获取某个任务的统计
        private void GetComCountByTaskID(HttpContext context)
        {
            try
            {
                int allCount = 0, comCount = 0;
                int taskid = Convert.ToInt32(context.Request["TaskID"] ?? "");
                string courseType = context.Request["CourseType"] ?? "1"; 
                jsonModel = taskService.GetEntityById(taskid);
                if (jsonModel.errNum == 0)
                {
                    Couse_TaskInfo task = jsonModel.retData as Couse_TaskInfo;
                    List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                    if (courseType == "1")
                    {
                        list=common.GetStudentData(task.StuRange);
                    }
                    else
                    {
                        list = GetTheTaskStu(context, task.CourseID.ToString(), task.StuRange);
                    }
                    if (list != null)
                    {
                         allCount = list.Count;
                    }                   
                }
                jsonModel = taskService.GetComCountByTaskID(taskid);
                if (jsonModel.errNum == 0)
                {
                    comCount =Convert.ToInt32(jsonModel.retData);
                }
                List<object> rtnList = new List<object>();
                rtnList.Add(new { name = "完成任务", value = comCount });
                rtnList.Add(new { name = "未完成任务", value = allCount - comCount });
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = rtnList
                };
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
        }
        #endregion

        #region 获取学生任务完成信息
        private void GetStuTaskCompleteInfo(HttpContext context)
        {
            try
            {
                int taskid = Convert.ToInt32(context.Request["TaskID"]);
                int iscom = Convert.ToInt32(context.Request["IsCom"] ?? "0");
                string courseType = context.Request["CourseType"] ?? "1"; 
                jsonModel = taskService.GetEntityById(taskid);
                if (jsonModel.errNum == 0)
                {
                    Couse_TaskInfo task = jsonModel.retData as Couse_TaskInfo;
                    List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                    if (courseType == "1")
                    {
                        list=common.GetStudentData(task.StuRange);//获取需要完成任务的所有学生
                    }
                    else
                    {
                        list = GetTheTaskStu(context,task.CourseID.ToString(),task.StuRange);
                    } 
                    Hashtable ht = new Hashtable();
                    ht.Add("TaskID", taskid);                   
                    ht.Add("IsGroupIDCard", context.Request["IsGroupIDCard"] ?? "1");
                    jsonModel = taskService.GetStuTaskCompleteInfo(ht);//获取完成任务的学生
                    if (jsonModel.errNum == 0)
                    {
                        List<Dictionary<string, object>> comList = jsonModel.retData as List<Dictionary<string, object>>;
                        List<string> stuCard = (from dic in comList select dic["CreateUID"].ToString()).ToList();
                        List<Dictionary<string, object>> rtnList = (from dic in list
                                         where stuCard.Contains(dic["IDCard"].ToString())
                                         select dic).ToList();
                        if (iscom == 0)
                        {
                            rtnList = list.Except(rtnList).ToList();
                        }
                        //string stuNames = stuNames = string.Join(",", (from dic in rtnList select dic["ClassName"].ToString() + dic["Name"].ToString()).ToList());
                        jsonModel = new JsonModel()
                        {
                            errNum = rtnList.Count > 0 ? 0 : 999,
                            errMsg = rtnList.Count > 0?"success":"无数据！",
                            retData = rtnList
                        };
                    }                 
                }               
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
        }
        #endregion   
     
        #region 获取选修课中，需要完成任务的所有学生
        private List<Dictionary<string, object>> GetTheTaskStu(HttpContext context, string courseid, string classids)
        {
            List<Dictionary<string, object>> list=new List<Dictionary<string, object>>();
            jsonModel = selstuinfoService.GetClassOrStuByCourceID(courseid, "2");
            if (jsonModel.errNum == 0)
            {
                DataTable dt = jsonModel.retData as DataTable;
                string ids = string.Join(",", dt.AsEnumerable().Select(row => row["IDS"].ToString()).ToArray());
                if (!string.IsNullOrEmpty(ids))
                {
                    list = common.AnalyticalReturnData(GetStudentData(context, ids, classids));
                }                
            }
            return list;
        }
        #endregion

        #region 获取学生信息
        private string GetStudentData(HttpContext context, string idcards, string classids)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string urlbady = "func=GetStudentData&SystemKey=" + SystemKey + "&InfKey=lhsfrz&ClassID="+classids+"&IDCard="+idcards;
            string PageUrl = urlHead + urlbady;
            return NetHelper.RequestPostUrl(PageUrl, urlbady);
        }
        #endregion

        #region 添加任务
        private void AddTask(HttpContext context)
        {
            string name = context.Request["Name"];
            string type = context.Request["Type"] ?? "0";
            Couse_TaskInfo task = new Couse_TaskInfo();
            task.Name= context.Request["Name"].SafeToString();
            task.CourseID = Convert.ToInt32(context.Request["CourseID"]);
            task.ChapterID = context.Request["ChapterID"];
            task.RelationID =Convert.ToInt32(context.Request["RelationID"]);
            task.Type = Convert.ToByte(type);
            task.StuRange = context.Request["StuRange"].SafeToString();
            task.StartTime =Convert.ToDateTime(context.Request["StartTime"]);
            task.EndTime = Convert.ToDateTime(context.Request["EndTime"]);
            task.Weight = Convert.ToInt32(context.Request["Weight"]);
            task.CreateUID = context.Request["UserIdCard"];
            task.CreateTime = DateTime.Now;
            jsonModel = taskService.Add(task);
        }
        #endregion

        #region 编辑任务
        private void EditTask(HttpContext context)
        {
            string name = context.Request["Name"];
            string type = context.Request["Type"] ?? "0";
            int itemid = Convert.ToInt32(context.Request["ItemId"]);
            jsonModel = taskService.GetEntityById(itemid);
            if (jsonModel.errNum == 0)
            {
                Couse_TaskInfo task = jsonModel.retData as Couse_TaskInfo;
                task.ID = itemid;
                task.Name = name;
                task.RelationID = Convert.ToInt32(context.Request["RelationID"]);
                task.Type = Convert.ToByte(type);
                task.StuRange = context.Request["StuRange"].SafeToString();
                task.StartTime = Convert.ToDateTime(context.Request["StartTime"]);
                task.EndTime = Convert.ToDateTime(context.Request["EndTime"]);
                task.Weight = Convert.ToInt32(context.Request["Weight"]);
                task.EditUID = context.Request["UserIdCard"];
                task.EditTime = DateTime.Now;
                jsonModel = taskService.Update(task);
            }
        }
        #endregion

        #region 删除任务
        private void DeleteTask(HttpContext context)
        {
            int itemid = Convert.ToInt32(context.Request["DelId"]);
            jsonModel = taskService.GetEntityById(itemid);
            if (jsonModel.errNum == 0)
            {
                Couse_TaskInfo task = jsonModel.retData as Couse_TaskInfo;
                task.ID = itemid;
                task.IsDelete = 1;
                jsonModel = taskService.Update(task);
            }
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