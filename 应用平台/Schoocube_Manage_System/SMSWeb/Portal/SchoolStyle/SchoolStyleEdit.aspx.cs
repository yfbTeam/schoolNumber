using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Portal.SchoolStyle
{
    public partial class SchoolStyleEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HUserName.Value = "admin";
            //HUserIdCard.Value = IDCard;
            SchoolId.Value = Request.QueryString["Id"];
        }
    }
}