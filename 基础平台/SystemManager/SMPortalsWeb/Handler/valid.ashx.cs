using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SMPortalsWeb.Handler
{
    /// <summary>
    /// valid 的摘要说明
    /// </summary>
    public class valid : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            var loginName = context.Request.Params["param"];
            Hashtable ht = new Hashtable();
            ht.Add("LoginName", loginName);
            SMModel.JsonModel jm = new SMBLL.Plat_TeacherService().ValidataIsExist(ht);
            if (jm.status == "ok")
                context.Response.Write("n");
            else
                context.Response.Write("y");
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}