﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.CourseManage
{
    public partial class CourceCheck : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HUserIdCard.Value = IDCard;
            HUserName.Value = Name;
            
            HClassID.Value = ClassID;
        }
    }
}