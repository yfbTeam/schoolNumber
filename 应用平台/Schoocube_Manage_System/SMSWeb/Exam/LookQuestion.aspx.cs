using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Exam
{
    public partial class LookQuestion : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                QID.Value = Request["Id"];
                qtype.Value = Request["type"];
            }
        }
    }
}