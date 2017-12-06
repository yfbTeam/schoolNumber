using SMSModel;
using SMSUtility;
using SMSUtility.FusionChart;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Portal.Message
{
    public partial class MessageManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HUserName.Value = "admin";
        }
    }
}