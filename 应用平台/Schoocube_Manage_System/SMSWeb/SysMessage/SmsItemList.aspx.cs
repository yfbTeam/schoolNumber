using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.SysMessage
{
    public partial class SmsItemList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HUserIdCard.Value = this.IDCard;
            HUserName.Value = this.Name;
            HRoleType.Value = this.SF;
        }
    }
}