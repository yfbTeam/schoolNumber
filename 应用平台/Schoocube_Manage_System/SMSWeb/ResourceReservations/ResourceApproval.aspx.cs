﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.ResourceReservations
{
    public partial class ResourceApproval :BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HUserName.Value = Name;
            HUserIdCard.Value = IDCard;
        }
    }
}