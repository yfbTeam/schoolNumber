using SMSUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Portal.Admin
{
    public partial class WebTemplete : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string xmlpath = "Portal\\SysData.xml";
                string val = XmlHelper.GetValue(xmlpath, "TemplateCss");
                foreach (Control ctl in this.form1.Controls)
                {
                    if (ctl.GetType().ToString() == "System.Web.UI.HtmlControls.HtmlInputRadioButton")
                    {
                        System.Web.UI.HtmlControls.HtmlInputRadioButton rb = this.FindControl(ctl.ID) as System.Web.UI.HtmlControls.HtmlInputRadioButton;
                        if (rb.Value == val)
                        {
                            rb.Checked = true;
                        }
                    }
                }
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            foreach (Control ctl in this.form1.Controls)
            {
                if (ctl.GetType().ToString() == "System.Web.UI.HtmlControls.HtmlInputRadioButton")
                {
                    System.Web.UI.HtmlControls.HtmlInputRadioButton rb = this.FindControl(ctl.ID) as System.Web.UI.HtmlControls.HtmlInputRadioButton;
                    if (rb.Checked)
                    {
                        string xmlpath = "Portal\\SysData.xml";
                        XmlHelper.SetValue(xmlpath, "TemplateCss", rb.Value);
                    }
                }
            }
        }
    }
}