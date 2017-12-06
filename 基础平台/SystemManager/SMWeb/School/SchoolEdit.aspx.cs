using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMWeb.School
{
    public partial class SchoolEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hid_UserIDCard.Value = UserIDCard;
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