using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.SysMessage
{
    public partial class RequestQuery : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HCourseId.Value = Request.QueryString["courseId"];
            HDate.Value = Request.QueryString["date"];
        }
    }
}