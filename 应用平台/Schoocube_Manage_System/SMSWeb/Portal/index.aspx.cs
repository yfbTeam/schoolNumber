using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Portal
{
    public partial class index : BaseCss
    {
        //public string List = "";
        //public string userName = "";
        //DiscuzSession ds;
        protected void Page_Load(object sender, EventArgs e)
        {
            mystylesheet.Attributes.Remove("href");
            mystylesheet.Attributes.Add("href", this.css);
            myskin.Attributes.Remove("href");
            myskin.Attributes.Add("href", this.skin);
            //HUserIdCard.Value = this.IDCard;
            //HUserName.Value = this.LoginName;
            //Hid_ClassID.Value = this.ClassID;
            //HRoleType.Value = this.SF;
            //if (Request.Cookies["dnt"] == null)
            //{
            //    ds = DiscuzSessionHelper.GetSession();
            //}
            //else
            //{
            //    ds = DiscuzSessionHelper.GetSession();
            //    try
            //    {
            //        ds.session_info = ds.GetSessionFromToken(Session["AuthToken"].ToString());
            //    }
            //    catch
            //    {
            //        Response.Redirect("SessionCreater.aspx?next=default");
            //    }
            //    userName = ds.GetUserInfo(ds.GetLoggedInUser().UId).UserName;
            //}
        }
        protected void Unnamed_ServerClick(object sender, EventArgs e)
        {
            //string url = ConfigurationManager.AppSettings["BBSUrl"];
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "redirect", "windowOpend('" + url + "')", true);
            //Response.Redirect(url);
            //单点登录
            //try
            //{
            //    if (Request.Cookies["dnt"] == null)
            //    {
            //        ds = DiscuzSessionHelper.GetSession();
            //        if (Request.Cookies["LoginCookie_Cube"] != null && Convert.ToString(Request.Cookies["LoginCookie_Cube"])!="")
            //        {
            //            string loginCookie = System.Web.HttpUtility.UrlDecode(Request.Cookies["LoginCookie_Cube"].Value);
            //            string[] userArray = loginCookie.Split(',');
            //            Hashtable hashtable = new Hashtable();
            //            foreach (string str in userArray)
            //            {
            //                string key = str.Split(':')[0].Trim('"');
            //                string value = str.Replace(str.Split(':')[0], "").Trim('"');
            //                if (value.Length > 2)
            //                {
            //                    if (value.IndexOf("}") > 0)
            //                    {
            //                        value = value.Substring(2, value.Length - 4);
            //                    }
            //                    else
            //                    {
            //                        value = value.Substring(2, value.Length - 2);
            //                    }
            //                }
            //                hashtable.Add(key, value);
            //            }
            //            string pwd = System.Web.HttpUtility.UrlDecode(Request.Cookies["PwdCookie_Cube"].Value);
            //            ds.Login(ds.GetUserID(hashtable["LoginName"].ToString()), pwd, false, 100, "");
            //            Response.Redirect("SessionCreater.aspx?next=default");
            //        }
            //    }
            //}
            //catch (Exception ex)
            //{
                
            //}
            
        }
    }
}