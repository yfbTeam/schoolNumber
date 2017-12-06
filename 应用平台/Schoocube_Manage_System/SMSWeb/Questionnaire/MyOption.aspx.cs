using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Questionnaire
{
    public partial class MyOption : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ////string name = Request["Name"] ?? "";
            ////if (name == "")
            ////{
            ////    BasePage bp = new BasePage();
            //    hClassID.Value = bp.ClassID;
            //    hName.Value = bp.Name;
            //    hSF.Value = bp.SF;
            //    hIDCard.Value = bp.IDCard;
            ////}
            ////else
            ////{
            hClassID.Value = ClassID;
            hName.Value = Name;   
            hSF.Value = SF;
            hIDCard.Value = IDCard;
            //}






        }
    }
}