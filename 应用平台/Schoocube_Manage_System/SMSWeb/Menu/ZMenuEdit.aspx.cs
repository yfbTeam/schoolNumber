using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Menu
{
    public partial class ZMenuEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
          
                hid_id.Value = Request.QueryString["id"];
                hid_Name.Value = Request.QueryString["Name"];
                hid_MenuCode.Value = Request.QueryString["MenuCode"];
                hid_Pid.Value = Request.QueryString["Pid"];
                hid_Url.Value = Request.QueryString["Url"];

            }
        }
    }
}