﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Exam
{
    public partial class ExamManager :BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hName.Value = Name;
        }
    }
}