using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace SMSWeb
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            Application["user_sessions"] = 0; 
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Application["user_sessions"] = (int)Application["user_sessions"] + 1;
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {
            if ((int)Application["user_sessions"] > 0) Application["user_sessions"] = (int)Application["user_sessions"] - 1;
        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}