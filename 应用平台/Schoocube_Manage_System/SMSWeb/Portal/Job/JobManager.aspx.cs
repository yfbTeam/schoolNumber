using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Portal.Job
{
    public partial class JobManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hId.Value = Request.QueryString["id"];
        }
    }
}