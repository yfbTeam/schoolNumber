using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Exam
{
    public partial class MarkExamPaper : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hIDCard.Value = IDCard;
                hname.Value = Name;
                HPeriodid.Value = Request["Period"];
                HSubjectid.Value = Request["Subject"];
                HTextbooxid.Value = Request["Textboox"];
                bookVersionid.Value = Request["bookVersion"];
                HChapterIDid.Value = Request["Chapter"];
                srcurl.Value = Request["url"];
                
            }
            
        }
    }
}