using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Portal.Course
{
    public partial class details : BaseCss
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HCourseId.Value = Request.QueryString["cid"];
            HMenuId.Value = Request.QueryString["id"];
            mystylesheet.Attributes.Remove("href");
            mystylesheet.Attributes.Add("href", this.css);
            myskin.Attributes.Remove("href");
            myskin.Attributes.Add("href", this.skin);
        }

        protected void Unnamed_ServerClick(object sender, EventArgs e)
        {
            string url = ConfigurationManager.AppSettings["BBSUrl"];
            Response.Redirect(url);
            //单点登录
            //if (Request.Cookies["dnt"] == null)
            //{
            //    ds = DiscuzSessionHelper.GetSession();
            //    if (Request.Cookies["LoginCookie_Cube"] != null) 
            //    {
            //        string loginCookie = System.Web.HttpUtility.UrlDecode(Request.Cookies["LoginCookie_Cube"].Value);
            //        string[] userArray = loginCookie.Split(',');
            //        Hashtable hashtable = new Hashtable();
            //        foreach (string str in userArray)
            //        {
            //            string key = str.Split(':')[0].Trim('"');
            //            string value = str.Replace(str.Split(':')[0], "").Trim('"');
            //            if (value.Length > 2)
            //            {
            //                if (value.IndexOf("}") > 0)
            //                {
            //                    value = value.Substring(2, value.Length - 4);
            //                }
            //                else
            //                {
            //                    value = value.Substring(2, value.Length - 2);
            //                }
            //            }
            //            hashtable.Add(key, value);
            //        }

            //        ds.Login(ds.GetUserID(hashtable["LoginName"].ToString()), hashtable["PwdCookie_Cube"].ToString(), false, 100, "");
            //        Response.Redirect("SessionCreater.aspx?next=default");
            //    }

            //}
        }
    }
}