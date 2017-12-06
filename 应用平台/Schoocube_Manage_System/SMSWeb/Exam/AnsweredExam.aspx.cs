using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Exam
{
    public partial class AnsweredExam : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                QID.Value = Request["id"];
                name.Value = Request["name"];
                hSF.Value = SF;
            }
        }
    }
}