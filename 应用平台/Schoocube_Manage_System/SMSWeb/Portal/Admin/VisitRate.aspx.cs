using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Portal.Admin
{
    public partial class VisitRate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            StarDate.Value = DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd");
            EndDate.Value = DateTime.Now.ToString("yyyy-MM-dd");
        }

        
        
    }
}