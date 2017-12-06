using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.OnlineLearning
{
    public partial class MyExam : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hClassID.Value = ClassID;
            hName.Value = Name;
            hSF.Value = SF;
            hIDCard.Value = IDCard;
        }
    }
}