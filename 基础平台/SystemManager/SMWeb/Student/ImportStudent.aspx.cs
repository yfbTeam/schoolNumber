using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMWeb.Student
{
    public partial class ImportStudent : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HUserIdCard.Value = UserIDCard;
            HUserName.Value = UserName;

            HClassID.Value = "1";
        }

    }
}