using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Portal.Admin
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.Cookies["LoginCookie_Cube"] == null || Convert.ToString(Request.Cookies["LoginCookie_Cube"].Value) == "" || Convert.ToString(Request.Cookies["LoginCookie_Cube"].Value) == "null") 
                {
                    Response.Redirect("/Portal/index.aspx");
                }
            }
        }
    }
}