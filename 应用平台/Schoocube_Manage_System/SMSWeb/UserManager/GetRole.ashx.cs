using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SMSUtility;
using System.Text;
using SMSBLL;
using System.Data;

namespace SMSWeb.UserManager
{
    /// <summary>
    /// GetRole 的摘要说明
    /// </summary>
    public class GetRole : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/text";

            string itemid = context.Request.QueryString["itemid"].SafeToString();

            BindJson(context, itemid);

        }

        private void BindJson(HttpContext context, string itemid)
        {
            try
            {
                StringBuilder treeSB = new StringBuilder();
                treeSB.Append("[");
                AssoMenuService service = new AssoMenuService();
                RoleMenuService roleservice = new RoleMenuService();
                DataTable dt = service.GetData("Pid=0", "");

                for (int i = 0; i < dt.Rows.Count; i++)
                {


                    treeSB.Append("{\"id\":\"" + dt.Rows[i]["Id"].SafeToString() + "\"");
                    treeSB.Append(",\"text\":\"" + dt.Rows[i]["MenuTitle"].SafeToString() + "\"");
                    DataTable subdt = service.GetData("Pid=" + dt.Rows[i]["Id"], "");
                    if (subdt.Rows.Count <= 0)
                    {
                        bool result = roleservice.ValidateChecked(itemid, dt.Rows[i]["Id"].SafeToString());
                        if (result)
                        {
                            treeSB.Append(",\"checked\":\"true\"");
                        }
                    }
                    else
                    {
                        treeSB.Append(",\"children\":[");

                        for (int j = 0; j < subdt.Rows.Count; j++)
                        {

                            treeSB.Append("{\"id\":\"" + subdt.Rows[j]["Id"].SafeToString() + "\"");
                            treeSB.Append(",\"text\":\"" + subdt.Rows[j]["MenuTitle"].SafeToString() + "\"");

                            bool result = roleservice.ValidateChecked(itemid, subdt.Rows[j]["Id"].SafeToString());
                            if (result)
                            {
                                treeSB.Append(",\"checked\":\"true\"");
                            }
                            treeSB.Append("}");
                            if (j != subdt.Rows.Count - 1)
                            {
                                treeSB.Append(",");
                            }

                        }
                        treeSB.Append("]");
                    }
                    
                    treeSB.Append("}");
                    if (i != dt.Rows.Count - 1)
                    {
                        treeSB.Append(",");
                    }

                }

                treeSB.Append("]");

                context.Response.Write(treeSB.SafeToString());
                context.Response.Flush();
                context.Response.End();
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "EditRoleGetRole_BindJson");
            }
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