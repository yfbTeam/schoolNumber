using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Questionnaire
{
    public partial class OptionEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                QID.Value = Request["Id"];
                qtype.Value = Request["type"];
                qldtype.Value = Request["TypeID"];
            }
        }
    }
}