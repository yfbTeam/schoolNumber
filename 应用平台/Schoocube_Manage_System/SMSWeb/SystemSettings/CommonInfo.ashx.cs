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
    /// CommonInfo 的摘要说明
    /// </summary>
    public class CommonInfo : IHttpHandler
    {
        JsonModel jsonModel = null;

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            string FuncName = context.Request["Func"].ToString();
            if (FuncName != null && FuncName != "")
            {
                try
                {
                    switch (FuncName)
                    {
                        case "GetTerm":
                            GetTerm(context);
                            break;
                        case "GetGrade":
                            GetGrade(context);
                            break;
                        case "GetClass":
                            GetClass(context);
                            break;
                        case "Period":
                            Period(context);
                            break;
                        case "Chapator":
                            Chapator(context);
                            break;
                        case "GetLeftNavigationMenu":
                            GetLeftNavigationMenu(context);
                            break;
                        case "GetTeacherPower":
                            GetTeacherPower(context);
                            break;
                        case "MyExamination":
                            MyExamination(context);
                            break;
                        case "GetAllTeacherInfo":
                            GetAllTeacherInfo(context);
                            break;
                        case "GetSchoolAll":
                            GetSchoolAll(context);
                            break;
                        case "AddStudent":
                            AddStudent(context);
                            break;
                        case "GetTeacherData":
                            GetTeacherData(context);
                            break;
                        case "GetTeacherPageData":
                            GetTeacherPageData(context);
                            break;
                        case "GetStudentPageData":
                            GetStudentPageData(context);
                            break;
                        case "GetClassStudent":
                            GetClassStudent(context);
                            break;
                        case "GetStudentByTeacher":
                            GetStudentByTeacher(context);
                            break;
                        case "EditMenuCode":
                            EditMenuCode(context);
                            break;
                        case "GetMajor":
                            GetMajor(context);
                            break;
                        case "UpStuPass":
                            UpStuPass(context);
                            break;
                        case "StuMessage":
                            StuMessage(context);
                            break;
                        case "NoticesForKeyWord":
                            NoticesForKeyWord(context);
                            break;
                        case "UpdatePassword": 
                            UpdatePassword(context); 
                            break;
                        case "SavePassword": 
                            SavePassword(context); 
                            break;
                        case "ValidationUserByIDCardAndName": 
                            ValidationUserByIDCardAndName(context); 
                            break;
                        case "ExportStu": 
                            ExportStu(context); 
                            break;
                        case "RegisterCount":
                            RegisterCount(context);
                            break;
                        case "GetUserInfoByIDCard":
                            GetUserInfoByIDCard(context);
                            break;
                        case "RegisterUpdateStudent":
                            RegisterUpdateStudent(context);
                            break;
                        default:
                            break;
                    }
                }
                catch (Exception ex)
                {
                    jsonModel = new JsonModel
                    {
                        errNum = 404,
                        errMsg = "无此方法",
                        retData = ""
                    };
                }

            }
        }
        private void ExportStu(HttpContext context)
        {
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string SystemKey = context.Request["SystemKey"].SafeToString();
            string InfKey = context.Request["InfKey"].SafeToString();
            string FilePath = context.Request["FilePath"].SafeToString();

            string urlbady = "func=ImportStudent&SystemKey=" + SystemKey + "&InfKey=" + InfKey + "&FilePath=" + FilePath;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #region 学生修改密码
        /// <summary>
        /// 学生修改密码
        /// </summary>
        /// <param name="context"></param>
        private void UpStuPass(HttpContext context)
        {
            //http://192.168.1.101:8085/UserHandler.ashx?func=UpdatePassword&LoginName=fangxiao&OldPassword=yfb%40123&NewPassword=pwd%40123
            string LoginName = context.Request["LoginName"].SafeToString();
            string OldPassword = context.Request["OldPassword"].SafeToString();
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/UserHandler.ashx?";
            string NewPassword = context.Request["NewPassword"].SafeToString();
            string urlbady = "func=UpdatePassword&LoginName=" + LoginName + "&OldPassword=" + OldPassword + "&NewPassword="+NewPassword;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion
        #region 学生班级动态
       /// <summary>
        /// ClassID班级id；Type 0通知;1动态
       /// </summary>
       /// <param name="context"></param>
        private void StuMessage(HttpContext context)
        {
            string ClassID = context.Request["ClassID"].SafeToString();
            string Type = context.Request["Type"].SafeToString();
            string Id = context.Request["Id"].SafeToString();
            string urlbady = "Func=GetClassNewsData&ClassID=" + ClassID + "&Type=" + Type + "&Id=" + Id;
            string urlHead = ConfigHelper.GetConfigString("ClassWebUrl").SafeToString() + "/SystemSettings/ClassNewsHandler.ashx?";
            string result = NetHelper.RequestPostUrl(urlHead, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion
        #region 专业信息
        /// <summary>
        /// 专业信息
        /// </summary>
        /// <param name="context"></param>
        private void GetMajor(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/MajorHandler.ashx?";
            string Pid = context.Request["Pid"].SafeToString();
            string urlbady = "func=GetMajorData&SystemKey=" + SystemKey + "&InfKey=tjjyse";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion
        #region 获取权限码
        /// <summary>
        /// 获取权限码
        /// </summary>
        /// <param name="context"></param>
        private void GetLeftNavigationMenu(HttpContext context)
        {
            string useridcard = context.Request["useridcard"].SafeToString();
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/SystemSettings/MenuHandler.ashx?";
            string Pid = context.Request["Pid"].SafeToString();
            string urlbady = "func=GetMenuByPidAndIDCard&SystemKey=" + SystemKey + "&InfKey=lhsfrz&useridcard=" + useridcard + "&pid=" + Pid;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion
        #region 学年学期
        /// <summary>
        /// 学年学期
        /// </summary>
        /// <param name="context"></param>
        private void GetTerm(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudySectionHandler.ashx?";
            string urlbady = "func=GetStudySectionData&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 年级
        /// <summary>
        /// 年级
        /// </summary>
        /// <param name="context"></param>
        private void GetGrade(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/GradeHandler.ashx?";
            string urlbady = "func=GetGradeData&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 班级
        /// <summary>
        /// 班级
        /// </summary>
        /// <param name="context"></param>
        private void GetClass(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/ClassInfoHandler.ashx?";
            string urlbady = "func=GetClassInfoData&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
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
        private void Period(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/InitialDataHandler.ashx?";
            string urlbady = "func=GetPSTVData&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        private void Chapator(HttpContext context)
        {

            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/TextbookCatalogHandler.ashx?";
            string urlbady = "func=GetTextbookCatalogData&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 师资力量数据
        /// <summary>
        /// 师资力量数据
        /// </summary>
        /// <param name="context"></param>
        protected void GetTeacherPower(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("PortalSystemKey");
            string MK = ConfigHelper.GetConfigString("PortalInfKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/TeacherHandler.ashx?";
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) param += "&PageIndex=" + context.Request["PageIndex"];
            if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) param += "&PageSize=" + context.Request["PageSize"];
            if (!string.IsNullOrWhiteSpace(context.Request["TeacherIDCard"])) param += "&TeacherIDCard=" + context.Request["TeacherIDCard"];
            if (!string.IsNullOrWhiteSpace(context.Request["Pageing"])) param += "&Pageing=" + context.Request["Pageing"];
            string urlbady = "func=GetTeacherByStudent&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 我的试卷
        /// <summary>
        /// 我的试卷
        /// </summary>
        /// <param name="context"></param>
        private void MyExamination(HttpContext context)
        {
            string userid = context.Request["userid"].SafeToString();
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/TeacherHandler.ashx?";
            string urlbady = "func=GetTeacherClassSubject&SystemKey=" + SystemKey + "&InfKey=kaoshifq&TeacherIDCard" + userid;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 获取所有教师

        /// <summary>
        /// 所有教师
        /// </summary>
        /// <param name="context"></param>
        private void GetAllTeacherInfo(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/TeacherHandler.ashx?";
            string urlbady = "func=GetTeacherData&SystemKey=qg_xcjx_1&InfKey=sxskwid";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }

        #endregion

        #region 获取学校
        /// <summary>
        /// 获取学校
        /// </summary>
        /// <param name="context"></param>
        protected void GetSchoolAll(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/SchoolHandler.ashx?";
            string urlbady = "func=GetSchoolAll&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 新增学生
        /// <summary>
        /// 新增学生
        /// </summary>
        /// <param name="context"></param>
        protected void AddStudent(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("PortalSystemKey");
            string MK = ConfigHelper.GetConfigString("PortalInfKey");
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["Name"])) param += "&Name=" + context.Request["Name"];
            if (!string.IsNullOrWhiteSpace(context.Request["Nickname"])) param += "&Nickname=" + context.Request["Nickname"];
            if (!string.IsNullOrWhiteSpace(context.Request["IDCard"])) param += "&IDCard=" + context.Request["IDCard"];
            if (!string.IsNullOrWhiteSpace(context.Request["LoginName"])) param += "&LoginName=" + context.Request["LoginName"];
            //if (!string.IsNullOrWhiteSpace(context.Request["SchoolID"])) param += "&SchoolID=" + context.Request["SchoolID"];
            //if (!string.IsNullOrWhiteSpace(context.Request["State"])) param += "&State=" + context.Request["State"];
            //if (!string.IsNullOrWhiteSpace(context.Request["SchoolNO"])) param += "&SchoolNO=" + context.Request["SchoolNO"];
            if (!string.IsNullOrWhiteSpace(context.Request["Sex"])) param += "&Sex=" + context.Request["Sex"];
            if (!string.IsNullOrWhiteSpace(context.Request["Birthday"])) param += "&Birthday=" + context.Request["Birthday"];
            if (!string.IsNullOrWhiteSpace(context.Request["Phone"])) param += "&Phone=" + context.Request["Phone"];
            if (!string.IsNullOrWhiteSpace(context.Request["Address"])) param += "&Address=" + context.Request["Address"];
            if (!string.IsNullOrWhiteSpace(context.Request["Password"])) param += "&Password=" + context.Request["Password"];
            if (!string.IsNullOrWhiteSpace(context.Request["Email"])) param += "&Email=" + context.Request["Email"];
            //if (!string.IsNullOrWhiteSpace(context.Request["Remarks"])) param += "&Remarks=" + context.Request["Remarks"];
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/UserHandler.ashx?";
            string urlbady = "func=Register&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region  查询教室个人或多人信息（门户）
        /// <summary>
        /// 查询教室个人或多人信息（门户）
        /// </summary>
        /// <param name="context"></param>
        protected void GetTeacherData(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("PortalSystemKey");
            string MK = ConfigHelper.GetConfigString("PortalInfKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/TeacherHandler.ashx?";
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["IDCard"])) param += "&IDCard=" + context.Request["IDCard"];
            string urlbady = "func=GetTeacherData&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }
        protected void GetTeacherPageData(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("PortalSystemKey");
            string MK = ConfigHelper.GetConfigString("PortalInfKey_qx");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/TeacherHandler.ashx?";
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) param += "&PageIndex=" + context.Request["PageIndex"];
            if (!string.IsNullOrWhiteSpace(context.Request["pageSize"])) param += "&pageSize=" + context.Request["pageSize"];
            string urlbady = "func=GetTeacherPageData&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }

        /// <summary>
        /// 查询学生（门户权限）
        /// </summary>
        /// <param name="context"></param>
        protected void GetStudentPageData(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("PortalSystemKey");
            string MK = ConfigHelper.GetConfigString("PortalInfKey_qx");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) param += "&PageIndex=" + context.Request["PageIndex"];
            if (!string.IsNullOrWhiteSpace(context.Request["pageSize"])) param += "&pageSize=" + context.Request["pageSize"];
            string urlbady = "func=GetStudentPageData&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }

        /// <summary>
        /// 根据学生查询本班所有同学
        /// </summary>
        /// <param name="context"></param>
        protected void GetClassStudent(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string MK = ConfigHelper.GetConfigString("EmailInfKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["IDCard"])) param += "&IDCard=" + context.Request["IDCard"];
            string urlbady = "func=GetClassStudent&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }

        public void GetStudentByTeacher(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string MK = ConfigHelper.GetConfigString("EmailInfKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["TeacherIDCard"])) param += "&TeacherIDCard=" + context.Request["TeacherIDCard"];
            string urlbady = "func=GetStudentByTeacher&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }


        private void EditMenuCode(HttpContext context)
        {
            string MenuID = context.Request["MenuID"].SafeToString();
            string MenuCode = context.Request["MenuCode"].SafeToString();
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/SystemSettings/MenuHandler.ashx?";
            string urlbady = "func=EditMenuCode&SystemKey=xlf_self&InfKey=lhsfrz&MenuID=" + MenuID + "&MenuCode=" + MenuCode;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }



        #endregion

        public void NoticesForKeyWord(HttpContext context) 
        {
            string urlHead = System.Configuration.ConfigurationManager.AppSettings["KeyWord"] + "/Handler/QueryKeyWord.ashx?";
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) param += "&PageIndex=" + context.Request["PageIndex"];
            if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) param += "&PageSize=" + context.Request["PageSize"];
            string urlbady = "SearchKey=" + context.Request["SearchKey"];
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }

        public void UpdatePassword(HttpContext context)
        {
            string urlHead = System.Configuration.ConfigurationManager.AppSettings["KeyWord"] + "/Handler/UserHandler.ashx?";
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["LoginName"])) param += "&LoginName=" + context.Request["LoginName"];
            if (!string.IsNullOrWhiteSpace(context.Request["OldPassword"])) param += "&OldPassword=" + context.Request["OldPassword"];
            if (!string.IsNullOrWhiteSpace(context.Request["NewPassword"])) param += "&NewPassword=" + context.Request["NewPassword"];
            string urlbady = "func=UpdatePassword";
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }

        public void SavePassword(HttpContext context)
        {
            string SystemKey = "wewefw";
            string MK = "ewfsss";
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/UserHandler.ashx?";
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["IDCard"])) param += "&IDCard=" + context.Request["IDCard"];
            if (!string.IsNullOrWhiteSpace(context.Request["Password"])) param += "&Password=" + context.Request["Password"];
            if (!string.IsNullOrWhiteSpace(context.Request["SF"])) param += "&SF=" + context.Request["SF"];
            string urlbady = "func=SavePassword&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }

        public void ValidationUserByIDCardAndName(HttpContext context)
        {
            string SystemKey = "wewefw";
            string MK = "ewfsss";
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/UserHandler.ashx?";
            string param = string.Empty;
            param += "&IDCard=" + context.Request["IDCard"];
            param += "&Name=" + context.Request["Name"];
            string urlbady = "func=ValidationUserByIDCardAndName&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }

        public void RegisterCount(HttpContext context) 
        {
            string SystemKey = "";
            string MK = "";
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/UserHandler.ashx?";
            string urlbady = "func=RegisterCount&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }

        public void GetUserInfoByIDCard(HttpContext context) 
        {
            string SystemKey = "";
            string MK = "";
            string IDCard = "";
            if (!string.IsNullOrWhiteSpace(context.Request["IDCard"])) IDCard = context.Request["IDCard"];
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/UserHandler.ashx?";
            string urlbady = "func=GetUserInfo&SystemKey=" + SystemKey + "&InfKey=" + MK + "&IDCard=" + IDCard;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }

        public void RegisterUpdateStudent(HttpContext context) 
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string MK = "lhsfrz";
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string urlbady = "func=RegisterUpdateStudent&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["IDCard"])) param += "&IDCard=" + context.Request["IDCard"];
            if (!string.IsNullOrWhiteSpace(context.Request["LoginName"])) param += "&LoginName=" + context.Request["LoginName"];
            if (!string.IsNullOrWhiteSpace(context.Request["Sex"])) param += "&Sex=" + context.Request["Sex"];
            if (!string.IsNullOrWhiteSpace(context.Request["Phone"])) param += "&Phone=" + context.Request["Phone"];
            if (!string.IsNullOrWhiteSpace(context.Request["Address"])) param += "&Address=" + context.Request["Address"];
            if (!string.IsNullOrWhiteSpace(context.Request["Password"])) param += "&Password=" + context.Request["Password"];
            if (!string.IsNullOrWhiteSpace(context.Request["Nickname"])) param += "&Nickname=" + context.Request["Nickname"];
            if (!string.IsNullOrWhiteSpace(context.Request["Email"])) param += "&Email=" + context.Request["Email"];
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
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