//using SMSWeb.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Portal
{
    public partial class bottom : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //PersonCount.Text = Application["user_sessions"].ToString();
            if (Application["user_sessions"] != null)
            {
                //List<PersonInfo> list = Application["user_sessions"] as List<PersonInfo>;
                //PersonCount.Text = list.Count.ToString();
                //PersonCount.Text = new StatisticsOnline().getUserList().ToString();
            }
            else
            {
               // PersonCount.Text = "0";
            }
        }
    }
}