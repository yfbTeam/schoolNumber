﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.TeacherStudentList
{
    public partial class TeacherInfo_Show :BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HUserIdCard.Value = IDCard;
            HUserName.Value = Name;
        }
    }
}