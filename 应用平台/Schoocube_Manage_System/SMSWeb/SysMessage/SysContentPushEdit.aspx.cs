using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.SysMessage
{
    public partial class SysContentPushEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.HUserName.Value = LoginName;
            NoticeId.Value = Request.QueryString["Id"];
        }
    }
}