﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Exam
{
    public partial class onlineanswer : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hIDCard.Value = IDCard;
            hName.Value = Name;
            //hnamee.Value = Request["name"];
            hid.Value = Request["id"];
        }
    }
}