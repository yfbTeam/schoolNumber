using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.OnlineLearning
{
    public partial class PlayerStudy : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HUserIdCard.Value = IDCard;
            HStuIDCard.Value = IDCard;
            HUserName.Value = Name;
        }
    }
}