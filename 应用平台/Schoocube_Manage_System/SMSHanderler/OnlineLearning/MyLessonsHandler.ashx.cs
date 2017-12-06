using SMSBLL;
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
    /// MyLessonsHandler 的摘要说明
    /// </summary>
    public class MyLessonsHandler : IHttpHandler
    {
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        Couse_SelstuinfoService selstuinfoService = new Couse_SelstuinfoService();
        SomeTableClickService clickService = new SomeTableClickService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string func = context.Request["Func"];
            string loginname = HttpContext.Current.Request["loginname"] ?? "";
            string idcard = context.Request["useridcard"];
            string result = string.Empty;
            try
            {
                switch (func)
                {
                    case "GetMyLessonsDataPage":
                        GetMyLessonsDataPage(context);
                        break;
                    case "GetClassCourses":
                        GetClassCourses(context);
                        break;
                    case "OperSomeTableClick":
                        OperSomeTableClick(context);
                        break;
                    case "StudyTheCourseStu":
                        result = StudyTheCourseStu(context);
                        break;
                    case "GetClassOrStuByCourceID":
                        GetClassOrStuByCourceID(context);
                        break;
                    case "Evalue":
                        Evalue(context);
                        break;
                    case "GetMyLessonsByType":
                        GetMyLessonsByType(context);
                        break;
                    case "BatchAddClassCourse":
                        BatchAddClassCourse(context);
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
            result = string.IsNullOrEmpty(result) ? "{\"result\":" + jss.Serialize(jsonModel) + "}" : result;
            context.Response.Write(result);
            context.Response.End();
        }
        #region 课程评价
        /// <summary>
        /// 课程评价
        /// </summary>
        /// <param name="context"></param>
        private void Evalue(HttpContext context)
        {
            Course_EvalueService evaluedll = new Course_EvalueService();
            try
            {
                Course_Evalue modol = new Course_Evalue();
                modol.CouseID = Convert.ToInt32(context.Request["ID"]);
                modol.CreateUID = context.Request["IDCard"].SafeToString();
                modol.Evalue = Convert.ToByte(context.Request["Evalue"]);
                modol.EvalueCountent = context.Request["Content"].SafeToString();
                string mes = evaluedll.CourceEvalue(modol);
                if (mes == "0")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "评价成功",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 200,
                        errMsg = mes,
                        retData = ""
                    };
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
            }

        }
        #endregion

        #region 获取我的课程的分页数据
        private void GetMyLessonsDataPage(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("StuNo", context.Request["StuNo"] ?? "");
                ht.Add("ClassID", context.Request["ClassID"] ?? "");
                ht.Add("OperSymbol", context.Request["OperSymbol"] ?? "");
                ht.Add("CourseID", context.Request["CourseID"] ?? "");
                ht.Add("Name", context.Request["Name"] ?? "");
                ht.Add("StudyTerm", context.Request["StudyTerm"] ?? "");
                if (!string.IsNullOrWhiteSpace(context.Request["IsCharge"])) ht.Add("IsCharge", context.Request["IsCharge"]);
                if (!string.IsNullOrWhiteSpace(context.Request["CourceType"])) ht.Add("CourceType", context.Request["CourceType"]);
                bool ispage = true;
                if (!string.IsNullOrEmpty(context.Request["ispage"]))
                {
                    ispage = Convert.ToBoolean(context.Request["ispage"]);
                }
                ht.Add("PageIndex", HttpContext.Current.Request["PageIndex"] ?? "1");
                ht.Add("PageSize", HttpContext.Current.Request["PageSize"] ?? "10");
                jsonModel = selstuinfoService.GetPage(ht, ispage);
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

        #region 获取班级课程
        private void GetClassCourses(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ClassID", context.Request["ClassID"] ?? "");
                ht.Add("OperSymbol", context.Request["OperSymbol"] ?? "");
                ht.Add("CourseID", context.Request["CourseID"] ?? "");
                ht.Add("Name", context.Request["Name"] ?? "");
                ht.Add("ShowClassID", context.Request["ShowClassID"] ?? "");
                ht.Add("GradeID", context.Request["GradeID"] ?? "");
                ht.Add("CourseType", context.Request["CourseType"] ?? "");
                jsonModel = selstuinfoService.GetClassCourses(ht);
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

        #region 添加或编辑视频查看记录
        private void OperSomeTableClick(HttpContext context)
        {
            SomeTableClick click = new SomeTableClick();
            int clickid = Convert.ToInt32(context.Request["Clickid"] ?? "0");
            click.Id = clickid;
            click.RelationId = Convert.ToInt32(context.Request["RelationId"]);
            click.Type = Convert.ToByte(context.Request["Type"] ?? "0");
            click.WatchTime = float.Parse(context.Request["WatchTime"]);
            if (clickid == 0)
            {
                click.ClickTime = Convert.ToDateTime(context.Request["ClickTime"]);
                click.LastTime = DateTime.Now;
            }
            else
            {
                click.ClickTime = DateTime.Now;
                click.LastTime = Convert.ToDateTime(context.Request["LastTime"]);
            }
            click.ClickNum = Convert.ToInt32(context.Request["ClickNum"]) + 1;
            click.IsLookEnd = Convert.ToByte(context.Request["IsLookEnd"] ?? "0");
            click.CreateUID = context.Request["UserIdCard"];
            Hashtable ht = new Hashtable();
            ht.Add("ClassID", context.Request["ClassID"] ?? "");
            ht.Add("DownTime", context.Request["DownTime"]);
            ht.Add("TotalTime", context.Request["TotalTime"]);
            jsonModel = clickService.OperSomeTableClick(click, ht);
        }
        #endregion

        #region 正在学习该课程的同学
        private string StudyTheCourseStu(HttpContext context)
        {
            string result = string.Empty;
            string courseID = context.Request["CourseID"].SafeToString();
            string courseType = context.Request["CourceType"] ?? "1";
            jsonModel = selstuinfoService.GetClassOrStuByCourceID(courseID, courseType);
            if (jsonModel.errNum == 0)
            {
                DataTable dt = jsonModel.retData as DataTable;
                string ids = string.Join(",", dt.AsEnumerable().Select(row => row["IDS"].ToString()).ToArray());
                if (!string.IsNullOrEmpty(ids))
                {
                  result = GetStudentData(context, ids, courseType);
                }else
                {
                    result = "{\"result\":{\"retData\":\"\",\"errMsg\":\"success\",\"errNum\":0,\"status\":null}}";
                }                
            }
            return result;
        }
        #endregion

        #region 根据课程id和类型查找班级
        private void GetClassOrStuByCourceID(HttpContext context)
        {
            string courseID = context.Request["CourseID"].SafeToString();
            string courseType = context.Request["CourceType"] ?? "1";
            jsonModel = selstuinfoService.GetClassOrStuByCourceID(courseID, courseType);
            string ids = string.Empty;
            if (jsonModel.errNum == 0)
            {
                DataTable dt = jsonModel.retData as DataTable;
                ids = string.Join(",", dt.AsEnumerable().Select(row => row["IDS"].ToString()).ToArray());
            }
            jsonModel.retData = ids;
        }
        #endregion

        #region 获取学生信息
        private string GetStudentData(HttpContext context, string ids, string courseType)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string idsParms = courseType == "1" ? "&ClassID=" : "&IDCard=";
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string urlbady = "func=GetStudentData&SystemKey=" + SystemKey + "&InfKey=lhsfrz" + idsParms + ids;
            string PageUrl = urlHead + urlbady;
            return NetHelper.RequestPostUrl(PageUrl, urlbady);
        }
        #endregion

        #region 获取我的课程的分页数据
        private void GetMyLessonsByType(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("StuNo", context.Request["StuNo"] ?? "");
                ht.Add("ClassID", context.Request["ClassID"] ?? "");
                ht.Add("PageIndex", context.Request["PageIndex"] ?? "1");
                ht.Add("PageSize", context.Request["PageSize"] ?? "10");
                ht.Add("CourseType", context.Request["CourseType"].SafeToString());
                ht.Add("ID", context.Request["ID"].SafeToString());
                ht.Add("Name", context.Request["Name"].SafeToString());
                bool IsPage = true;
                if (context.Request["IsPage"].SafeToString().Length>0)
                {
                    IsPage = Convert.ToBoolean(context.Request["IsPage"]);
                }
                jsonModel = selstuinfoService.GetMyLessonsByType(ht, IsPage);
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

        #region 批量添加班级课程
        private void BatchAddClassCourse(HttpContext context)
        {
            ClassCourse clac = new ClassCourse();
            clac.ClassID=Convert.ToInt32(context.Request["ClassID"].SafeToString());
            clac.CreateUID=context.Request["IDCard"].SafeToString();            
            string courseids= context.Request["CourseIDs"].SafeToString();
            jsonModel = selstuinfoService.BatchAddClassCourse(clac, courseids);
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