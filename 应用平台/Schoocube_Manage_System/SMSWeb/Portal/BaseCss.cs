using SMSUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SMSWeb.Portal
{
    public class BaseCss : System.Web.UI.Page
    {
        public string css { get; set; }
        public string skin { get; set; }

        public BaseCss()
        {
            
        }
        protected override void OnInit(EventArgs e)
        {
            string xmlpath = "Portal\\SysData.xml";
            string val = XmlHelper.GetValue(xmlpath, "BaseCss");
            switch (val)
            {
                case "left": this.css = "/PortalCss/left.css"; break;
                case "right": this.css = "/PortalCss/right.css"; break;
                default:
                    this.css = "/PortalCss/left.css";
                    break;
            }
            string valsk = XmlHelper.GetValue(xmlpath, "TemplateCss");
            switch (valsk)
            {
                case "layout": this.skin = "/PortalCss/layout.css"; break;
                case "layout_copy": this.skin = "/PortalCss/layout_copy.css"; break;
                default:
                    this.skin = "/PortalCss/layout.css";
                    break;
            }
        }
    }
}