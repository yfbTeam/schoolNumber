using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb
{
    public partial class _event : System.Web.UI.Page
    {
        public string Date { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            Date = Request["date"];
            //HUserIdCard.Value = IDCard;
            EventID.Value = Request["id"];
        }
    }
}