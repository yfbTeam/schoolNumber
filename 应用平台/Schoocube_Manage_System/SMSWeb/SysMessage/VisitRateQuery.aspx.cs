using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.SysMessage
{
    public partial class VisitRateQuery : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HType.Value = Request.QueryString["type"];
        }
    }
}