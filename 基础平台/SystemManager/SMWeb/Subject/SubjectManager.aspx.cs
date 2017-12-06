using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMWeb.Subject
{
    public partial class SubjectManager : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hid_UserIDCard.Value = UserIDCard;
            hid_LoginName.Value = UserLgoinName;
        }
    }
}