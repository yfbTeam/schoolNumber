using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.MenuInfo
{
    public partial class FMenuInfoEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                //hid_Id.Value = Request.QueryString["id"];
                //hid_Name.Value = Request.QueryString["Name"];
            }
        }
    }
}