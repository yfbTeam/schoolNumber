using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Portal.SchoolStyle
{
    public partial class SchoolStyleManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //HUserIdCard.Value = IDCard;
            HUserName.Value = "admin";
        }
    }
}