using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.SysMessage
{
    public partial class EmailtemList :BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HUserIdCard.Value = this.IDCard;
                HUserName.Value = this.Name;
                HRoleType.Value = this.SF;
            }
        }


    }
}