using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMWeb.InterfaceConfig
{
    public partial class InterfaceEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hid_UserIDCard.Value = UserIDCard;
            hid_LoginName.Value = UserLgoinName;
            if (!IsPostBack)
            {
                string itemid = HttpContext.Current.Request.QueryString["itemid"];
                if (!string.IsNullOrEmpty(itemid))
                {
                    hid_Id.Value = itemid;
                }
            }
        }
    }
}