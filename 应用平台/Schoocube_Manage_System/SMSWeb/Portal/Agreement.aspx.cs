using SMSUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Portal
{
    public partial class Agreement : BaseCss
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myskin.Attributes.Remove("href");
            myskin.Attributes.Add("href", this.skin);
            string xmlpath = "Portal\\SysData.xml";
            string val = XmlHelper.GetValue(xmlpath, "UserAgreement");
            this.Agreediv.InnerHtml = val;
        }
    }
}