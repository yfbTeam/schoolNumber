using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Portal.Advertising
{
    public partial class AdvertisingEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HUserName.Value = "admin";
            HAdvertId.Value = Request.QueryString["Id"];
        }
    }
}