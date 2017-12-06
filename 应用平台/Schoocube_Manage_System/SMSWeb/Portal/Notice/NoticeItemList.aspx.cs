using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Portal.Notice
{
    public partial class NoticeItemList : BaseCss
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HType.Value = Request.QueryString["Type"];
            if (!IsPostBack)
            {
                readXml();
            }
            mystylesheet.Attributes.Remove("href");
            mystylesheet.Attributes.Add("href", this.css);
            myskin.Attributes.Remove("href");
            myskin.Attributes.Add("href", this.skin);
        }
        protected void readXml()
        {
            try
            {
                string xmlpath = "/Portal/SysData.xml";
                string val = SMSUtility.XmlHelper.GetValue(xmlpath, "NoticePages");
                PageNumber.Value = val;
            }
            catch (Exception)
            {

                PageNumber.Value = "10";
            }
            
        }
    }
}