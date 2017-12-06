using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Portal.Notice
{
    public partial class NoticeDetails : BaseCss
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            NoticeId.Value = Request.QueryString["Id"];
            HType.Value = Request.QueryString["Type"];
            mystylesheet.Attributes.Remove("href");
            mystylesheet.Attributes.Add("href", this.css);
            myskin.Attributes.Remove("href");
            myskin.Attributes.Add("href", this.skin);
        }
    }
}