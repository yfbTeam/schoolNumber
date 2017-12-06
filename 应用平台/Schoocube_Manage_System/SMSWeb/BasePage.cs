using Newtonsoft.Json.Linq;
using SMSUtility;
using SMSWeb.SystemSettings;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
//using System.Net;
using System.Text;
namespace SMSWeb
{
    public class BasePage : System.Web.UI.Page
    {
        #region 登陆用户信息
        /// <summary>
        /// 用户名
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 用户登陆名
        /// </summary>
        public string LoginName { get; set; }
        /// <summary>
        /// 用户身份证号
        /// </summary>
        public string IDCard { get; set; }
        public string SchoolID { get; set; }
        public string SchoolName { get; set; } //学校名称
        /// <summary>
        /// 学生所属班级
        /// </summary>
        public string ClassID { get; set; }
        public string ClassName { get; set; }//班级名称
        public string SF { get; set; }
        public string PhotoURL { get; set; }
        #endregion

        #region  验证用户是否登录
        protected override void OnInit(EventArgs e)
        {
            try
            {
                string loginCookie = "";
                //登陆页地址 从Web.config 读取
                string LoginPage = ConfigHelper.GetConfigString("LoginPage"); ;
                string action = Request["action"];
                if (!string.IsNullOrEmpty(action) && action == "loginOut")   //退出登录
                {
                    Response.Cookies["LoginCookie_Cube"].Expires = DateTime.Now.AddDays(-3);
                    Response.Cookies["ClassID"].Expires = DateTime.Now.AddDays(-3);
                    //跳转登陆页面
                    Response.Redirect("/Login_hz.aspx");
                }
                else
                {
                    if (Request.Cookies["LoginCookie_Cube"] != null)
                    {
                        loginCookie = System.Web.HttpUtility.UrlDecode(Request.Cookies["LoginCookie_Cube"].Value);
                        string[] userArray = loginCookie.Split(',');
                        Hashtable hashtable = new Hashtable();
                        foreach (string str in userArray)
                        {
                            string key = str.Split(':')[0].Trim('"');
                            string value = str.Replace(str.Split(':')[0], "").Trim('"');
                            if (value.Length > 2)
                            {
                                if (value.IndexOf("}") > 0)
                                {
                                    value = value.Substring(2, value.Length - 4);
                                }
                                else
                                {
                                    value = value.Substring(2, value.Length - 2);
                                }
                            }
                            hashtable.Add(key, value);
                        }
                        IDCard = hashtable["IDCard"].SafeToString();
                        SF = hashtable["SF"].SafeToString();
                        PhotoURL = hashtable["PhotoURL"].SafeToString();
                        JObject rtnObj = JObject.Parse(GetLoginUserData(IDCard, SF));
                        JObject resultObj = JsonTool.GetObjVal(rtnObj, "result");
                        if (JsonTool.GetStringVal(resultObj, "errNum") == "0")
                        {
                            JArray retData = JsonTool.GetArryVal(resultObj, "retData");
                            JObject curUser = retData[0] as JObject;
                            Name = JsonTool.GetStringVal(curUser, "Name");
                            LoginName = JsonTool.GetStringVal(curUser, "LoginName");
                            SchoolID = JsonTool.GetStringVal(curUser, "SchoolID");
                            if (SF == "教师")
                            {

                            }
                            else
                            {
                                ClassName = JsonTool.GetStringVal(curUser, "ClassName");
                                ClassID = JsonTool.GetStringVal(curUser, "ClassID");
                            }
                        }
                    }
                    else
                    {
                        //跳转登陆页面
                        Response.Redirect(LoginPage);
                    }
                    //IDCard = "130498199111072736";
                    //LgoinName = "测试账号";
                    //Name = "小七";
                    //ClassID = "1";
                    //SF = "老师";
                    //PhotoURL = "/images/teacher_img.png";
                }
                base.OnInit(e);
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }
        }

        #endregion
        #region 获取登录用户信息
        private string GetLoginUserData(string userIDCard, string type)
        {
            string handler = type == "教师" ? "/TeacherHandler.ashx?" : "/StudentHandler.ashx?";
            string func = type == "教师" ? "GetTeacherData" : "GetStudentData";
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + handler;
            string urlbady = "func=" + func + "&SystemKey=" + SystemKey + "&InfKey=lhsfrz" + "&IDCard=" + userIDCard;
            string PageUrl = urlHead + urlbady;
            return NetHelper.RequestPostUrl(PageUrl, urlbady);
        }
        #endregion
      
    }
}
