using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SMWeb
{
    public class BasePage : System.Web.UI.Page
    {
        #region  // 当前登陆用户信息
        /// <summary>
        /// 用户名
        /// </summary>
        public string UserName { get; set; }
        /// <summary>
        /// 用户登陆名
        /// </summary>
        public string UserLgoinName { get; set; }
        /// <summary>
        /// 用户身份证号
        /// </summary>
        public string UserIDCard { get; set; }
        /// <summary>
        /// 用户角色Id,以'㊣'连接
        /// </summary>
        public string UserRoleId { get; set; }
        /// <summary>
        /// 用户角色名称,以'㊣'连接
        /// </summary>
        public string UserRoleName { get; set; }
        /// <summary>
        /// 用户库房Id,以'㊣'连接
        /// </summary>
        public string UserWareId { get; set; }
        /// <summary>
        /// 用户库房名称,以'㊣'连接
        /// </summary>
        public string UserWareName { get; set; }
        /// <summary>
        /// 管理员角色名
        /// </summary>
        public string IsAdmin { get; set; }
        /// <summary>
        /// 账号所属学校
        /// </summary>
        public string SchoolID { get; set; }
        /// <summary>
        /// 账号系统Key
        /// </summary>
        public string SystemKey { get; set; }
        /// <summary>
        /// 账号系统Name
        /// </summary>
        public string SystemName { get; set; }
        #endregion

        #region  // 验证用户是否登录
        protected override void OnInit(EventArgs e)
        {
            string loginCookie = "";
            //登陆页地址 从Web.config 读取
            string LoginPage = System.Configuration.ConfigurationManager.ConnectionStrings["LoginPage"].ConnectionString;
            string action = Request["action"];
            if (!string.IsNullOrEmpty(action) && action == "loginOut")   //退出登录
            {
                Session.Clear();
                Session.Abandon();
                Response.Cookies["LoginCookie"].Expires = DateTime.Now.AddDays(-3);
                //跳转登陆页面
                Response.Redirect(LoginPage);
                Response.Redirect("/Login.aspx");
            }
            else
            {
                if (Request.Cookies["LoginCookie"] != null)
                {
                    loginCookie = System.Web.HttpUtility.UrlDecode(Request.Cookies["LoginCookie"].Value);
                    string[] userArray = loginCookie.Split(',');

                    //UserLgoinName = userArray[1].ToString();
                    //UserName = userArray[2].ToString();
                    //UserIDCard = userArray[5].ToString();
                    //UserRoleId = userArray[8].ToString();
                    //UserRoleName = userArray[9].ToString();
                    //UserWareId = userArray[10].ToString();
                    //UserWareName = userArray[11].ToString();

                    UserName = userArray[1].ToString();
                    UserLgoinName = userArray[2].ToString();
                    UserIDCard = userArray[3].ToString();
                    SchoolID = userArray[4].ToString();
                    SystemKey = userArray[5].ToString();
                    SystemName = userArray[6].ToString();
                }
                else
                {
                    //跳转登陆页面
                    Response.Redirect(LoginPage);
                }
                #region 注释的代码
                //string Url = "http://localhost:11027/Login.aspx";
                //HttpWebRequest req = (HttpWebRequest)WebRequest.Create(Url);
                //req.CookieContainer = new CookieContainer();
                //HttpWebResponse response = (HttpWebResponse)req.GetResponse();
                //string cookie = response.Headers["set-cookie"];
                //if (response.Cookies["LoginCookie"] != null)
                //{
                //    loginCookie = Request.Cookies["LoginCookie"].Value;
                //    string[] userArray = loginCookie.Split(',');
                //    UserLgoinName = userArray[1].ToString();
                //    UserName = userArray[2].ToString();
                //}


                //开发 跳过登陆操作 模拟管理员已经登陆了
                //UserLgoinName = "admin";
                //UserName = "超级管理员";
                //SchoolID = "1111";
                //UserRole = "管理员";

                ////获取登陆状态
                //if (Session["UserLgoinName"] != null)
                //{
                //    UserLgoinName = Session["UserLgoinName"].ToString();
                //}
                //if (UserLgoinName == null)
                //{//无登陆名
                //    //跳转登陆页面
                //    Response.Redirect(LoginPage);
                //}
                //else
                //{
                //    UserName = Session["UserName"].ToString();
                //    //UserRole = Session["UserRole"].ToString();
                //}
                #endregion
            }
            base.OnInit(e);
        }

        #endregion
    }
}