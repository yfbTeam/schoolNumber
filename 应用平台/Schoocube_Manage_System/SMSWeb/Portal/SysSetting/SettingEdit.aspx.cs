using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Portal.SysSetting
{
    public partial class SettingEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SchoolId.Value = Request.QueryString["Id"];
            HMenuId.Value = Request.QueryString["MenuId"];
        }
    }
}