using Newtonsoft.Json.Linq;
using SMSModel;
using SMSUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SMSWeb.SystemSettings
{
    /// <summary>
    /// UserInfo 的摘要说明
    /// </summary>
    public class UserInfo : IHttpHandler
    {
        JavaScriptSerializer jss = new JavaScriptSerializer();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";            
            string FuncName = context.Request["Func"].ToString();
            if (FuncName != null && FuncName != "")
            {
                switch (FuncName)
                {
                    case "Login":
                        Login(context);
                        break;
                    case "GetClassID":
                        GetClassID(context);
                        break;
                    case "StudentInfo":
                        GetStudentInfo(context);
                        break;
                    case "GetTeacherData":
                        GetTeacherInfo(context);
                        break;
                    case "MyExamination":
                        MyExamination(context);
                        break;
                    case "GetGradeInfo":
                        GetGradeInfo(context);
                        break;
                    case "GetClassStudentInfo":
                        GetClassStudentInfo(context);
                        break;
                    case "StudentImage":
                        StudentImage(context);
                        break;
                    case "UpdateStudent":
                        UpdateStudent(context);
                        break;
                    case "GetHistoryClassInfo":
                        GetHistoryClassInfo(context);
                        break;
                    case "GetHistoryStudySection":
                        GetHistoryStudySection(context);
                        break;
                    case "GetTeaAndStu_List":
                        GetTeaAndStu_List(context);
                        break;
                    default:
                        break;
                }
            }
        }
        #region 根据身份证号获取教师基本信息
        /// <summary>
        /// 根据身份证号获取教师基本信息
        /// </summary>
        /// <param name="context"></param>
        private void GetTeacherInfo(HttpContext context)
        {

            string IDCard = context.Request["IDCard"].SafeToString();
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/TeacherHandler.ashx?";
            string urlbady = "func=GetTeacherData&IDCard=" + IDCard + "&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 根据身份证号获取学生基本信息
        /// <summary>
        /// 根据身份证号获取学生基本信息
        /// </summary>
        /// <param name="context"></param>
        private void GetStudentInfo(HttpContext context)
        {
            string IDCard = context.Request["IDCard"].SafeToString();
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string urlbady = "func=GetStudentData&IDCard=" + IDCard + "&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion
        #region 获取所有学生信息
        /// <summary>
        /// 获取所有学生信息
        /// </summary>
        /// <param name="context"></param>
        private void MyExamination(HttpContext context)
        {
            string IDCard = context.Request["IDCard"].SafeToString();
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string urlbady = "func=GetStudentData&SystemKey=" + SystemKey + "&InfKey=lhsfrh";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 文件目录结构
        /// <summary>
        /// 文件目录结构
        /// </summary>
        /// <param name="pid"></param>
        private void Login(HttpContext context)
        {
            string loginName = context.Request["loginName"].SafeToString();
            string passWord = context.Request["passWord"].SafeToString();
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/UserHandler.ashx?";
            string urlbady = "func=Login&LoginName=" + loginName + "&Password=" + passWord + "&SystemKey=" + SystemKey + "&InfKey=lhsfrz&parm="+DateTime.Now.Ticks;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 学生所属班级
        /// <summary>
        /// 文件目录结构
        /// </summary>
        /// <param name="pid"></param>
        private void GetClassID(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string IDCard = context.Request["IDCard"].SafeToString();

            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string urlbady = "func=GetStudentData&IDCard=" + IDCard + "&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 获取所有的年级
        /// <summary>
        /// 获取所有的年级
        /// </summary>
        /// <param name="context"></param>
        private void GetGradeInfo(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/GradeHandler.ashx?";
            string urlbady = "func=GetGradeData&SystemKey=" + SystemKey + "&InfKey=ssmdwod";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 获取指定的班级的教师和学生
        /// <summary>
        /// 获取指定的班级的教师和学生
        /// </summary>
        /// <param name="context"></param>
        private void GetClassStudentInfo(HttpContext context)
        {
            string GradeID = context.Request["GradeID"].SafeToString();
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/ClassInfoHandler.ashx?";
            string urlbady = "func=GetNameList&SystemKey=" + SystemKey + "&InfKey=ssmdwod&GradeID=" + GradeID;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion


        #region 更改学生头像
        /// <summary>
        /// 更改学生头像
        /// </summary>
        /// <param name="context"></param>
        private void StudentImage(HttpContext context)
        {
            string Func = context.Request["Func"];
            string ImageName = context.Request["Func"];
            string urlHead = ConfigHelper.GetConfigString("BaseWebUrl").SafeToString() + "/ImageUpLoadHandler.ashx?";
            string urlbady = "func=" + Func + "&ImageName=" + ImageName;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 修改个人基本信息
        /// <summary>
        /// 修改个人基本信息
        /// </summary>
        /// <param name="context"></param>
        private void UpdateStudent(HttpContext context)
        {
            string ID = context.Request["ID"].SafeToString();
            string Name = context.Request["Name"].SafeToString();
            string Sex = context.Request["Sex"].SafeToString();
            string Birthday = context.Request["Birthday"].SafeToString();
            string fixPhone = context.Request["fixPhone"].SafeToString();
            string Email = context.Request["Email"].SafeToString();
            string Address = context.Request["Address"].SafeToString();
            string Phone = context.Request["Phone"].SafeToString();
            string LoginName = context.Request["LoginName"].SafeToString();
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string urlbady = "func=UpdateStudent&SystemKey=" + SystemKey + "&InfKey=grzxzd&ID=" + ID;
            if (Name.Length > 0)
            {
                urlbady += "&Name=" + Name;
            }
            if (Sex.Length > 0)
            {
                urlbady += "&Sex=" + Sex;
            }
            if (Birthday.Length > 0)
            {
                urlbady += "&Birthday=" + Birthday;
            } if (fixPhone.Length > 0)
            {
                urlbady += "&fixPhone=" + fixPhone;
            } if (Email.Length > 0)
            {
                urlbady += "&Email=" + Email;
            } 
            if (Address.Length > 0)
            {
                urlbady += "&Address=" + Address;
            }
            if (Phone.Length>0)
            {
                urlbady += "&Phone=" + Phone;
            }
            if (LoginName.Length > 0)
            {
                urlbady += "&LoginName=" + LoginName;
            }
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 获取历史班级信息        
        private void GetHistoryClassInfo(HttpContext context)
        {
            string result = RtnHistoryClassResult(context);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 获取班级历史表的学年 
        private void GetHistoryStudySection(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/ClassInfoHandler.ashx?";
            string urlbady = "func=GetHistoryStudySection&SystemKey=" + SystemKey + "&InfKey=lhsfrz";            
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 获取班级教师及学生信息        
        private void GetTeaAndStu_List(HttpContext context)
        {
            JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
            try
            {
                string result = RtnHistoryClassResult(context);
                List<Dictionary<string, object>> list = AnalyticalReturnData(result);
                if (list.Count > 0)
                {
                    string[] headteacherIDCard = list[0]["HeadteacherIDCard"].SafeToString().Split(',');
                    string[] CourseTeacherIDCard = list[0]["CourseTeacherIDCard"].SafeToString().Split(',');
                    string[] headStudentIDCard = list[0]["HeadStudentIDCard"].SafeToString().Split(',');
                    string[] studentsIDCard = list[0]["StudentsIDCard"].SafeToString().Split(',');
                    List<Dictionary<string, object>> teaList = (from dic in GetTeacherData()
                                                                select new Dictionary<string, object>() { { "IDCard", dic["IDCard"].ToString() }, { "Name", dic["Name"].ToString() }, { "PhotoURL", dic["PhotoURL"].ToString() } }).ToList<Dictionary<string, object>>();
                    List<Dictionary<string, object>> stuList = (from dic in GetStudentData()
                                                                select new Dictionary<string, object>() { { "IDCard", dic["IDCard"].ToString() }, { "Name", dic["Name"].ToString() }, { "PhotoURL", dic["PhotoURL"].ToString() } }).ToList<Dictionary<string, object>>();
                    List<Dictionary<string, object>> allList = teaList.Union(stuList).ToList<Dictionary<string, object>>();
                    List<Dictionary<string, object>> rtnList = new List<Dictionary<string, object>>();
                    rtnList.Add(new Dictionary<string, object> { { "HeadteacherIDCard", GetUserByIDCards(allList, headteacherIDCard) },
                                                {"CourseTeacherIDCard", GetUserByIDCards(allList, CourseTeacherIDCard)},
                                                {"HeadStudentIDCard", GetUserByIDCards(allList, headStudentIDCard)},
                                                {"StudentsIDCard",GetUserByIDCards(allList, studentsIDCard) }});
                    jsonModel.retData = rtnList;
                }else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
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
                LogService.WriteErrorLog(ex.Message);
            }

            context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            context.Response.End();
        }
        #endregion

        #region 根据身份证从用户列表中获取数据
        private List<Dictionary<string, object>> GetUserByIDCards(List<Dictionary<string, object>> list,string[] idcards)
        {
            return (from dic in list
                    where idcards.Contains(dic["IDCard"].ToString())
                    select dic).ToList<Dictionary<string, object>>();
        }
        #endregion

        #region 返回历史班级信息        
        private string RtnHistoryClassResult(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/ClassInfoHandler.ashx?";
            string urlbady = "func=GetHistoryClassInfo&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            if (!string.IsNullOrEmpty(context.Request["StudySection"]))
            {
                urlbady += "&StudySection=" + context.Request["StudySection"].ToString();
            }
            if (!string.IsNullOrEmpty(context.Request["GradeID"]))
            {
                urlbady += "&GradeID=" + context.Request["GradeID"].ToString();
            }
            if (!string.IsNullOrEmpty(context.Request["Id"]))
            {
                urlbady += "&Id=" + context.Request["Id"].ToString();
            }
            string PageUrl = urlHead + urlbady;
            return NetHelper.RequestPostUrl(PageUrl, urlbady);
        }
        #endregion
        #region 获取教师信息
        public List<Dictionary<string, object>> GetTeacherData()
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/TeacherHandler.ashx?";
            string urlbady = "func=GetTeacherData&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            string PageUrl = urlHead + urlbady;
            return AnalyticalReturnData(NetHelper.RequestPostUrl(PageUrl, urlbady));
        }
        #endregion

        #region 获取全部学生信息、根据班级id获取学生信息
        public List<Dictionary<string, object>> GetStudentData(string classids = "")
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string urlbady = "func=GetStudentData&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            if (!string.IsNullOrEmpty(classids))
            {
                urlbady += "&ClassID=" + classids;
            }
            string PageUrl = urlHead + urlbady;
            return AnalyticalReturnData(NetHelper.RequestPostUrl(PageUrl, urlbady));
        }
        #endregion  
        #region 将接口返回的信息解析为List
        public List<Dictionary<string, object>> AnalyticalReturnData(string result)
        {            
            JObject rtnObj = JObject.Parse(result);
            JObject resultObj = JsonTool.GetObjVal(rtnObj, "result");
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            if (JsonTool.GetStringVal(resultObj, "errNum") == "0")
            {
                list = jss.Deserialize<List<Dictionary<string, object>>>(resultObj["retData"].ToString());
            }
            return list;
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