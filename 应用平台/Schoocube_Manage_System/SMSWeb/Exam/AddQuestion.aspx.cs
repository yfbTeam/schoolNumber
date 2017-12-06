using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Exam
{
    public partial class AddQuestion : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hIDCard.Value = IDCard;
            HPeriod.Value = Request["HPeriod"];
            HSubject.Value = Request["HSubject"];
            bookVersion.Value = Request["bookVersion"];
            HTextboox.Value = Request["HTextboox"];
            HChapterID.Value = Request["HChapterID"];
        }
    }
}