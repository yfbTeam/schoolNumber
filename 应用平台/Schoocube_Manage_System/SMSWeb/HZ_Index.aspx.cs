using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb
{
    public partial class HZ_Index : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HUserIdCard.Value = IDCard;
            HUserName.Value = LoginName;
            if (SF=="学生")
            {
                Response.Redirect("/PersonalSpace/Learning_center_portal.aspx");
            }
        }
    }
}