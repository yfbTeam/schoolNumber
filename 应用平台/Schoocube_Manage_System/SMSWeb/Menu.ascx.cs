using SMSBLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSUtility;
using System.Text;

namespace SMSWeb
{
    public partial class Menu : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    string itemid = Request.QueryString["itemid"].SafeToString();
                    string pid = Request.QueryString["pid"].SafeToString();
                    if (!string.IsNullOrEmpty(itemid) && !string.IsNullOrEmpty(pid))
                    {
                        HttpCookie cookie = new HttpCookie("itemid");
                        cookie.Value = itemid;
                        cookie.Expires = DateTime.Now.AddSeconds(100000);
                        Response.Cookies.Add(cookie);


                        HttpCookie pidcookie = new HttpCookie("pid");
                        pidcookie.Value = pid;
                        pidcookie.Expires = DateTime.Now.AddSeconds(10000);
                        //这句很重要，不能丢
                        Response.Cookies.Add(cookie);
                        Response.Cookies.Add(pidcookie);
                    }
                    BindMenu();
                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "Menu.ascx_PageLoad");
            }
        }

        public void BindMenu()
        {
            try
            {
                string where = GetRoleByUid();
                AssoMenuService service = new AssoMenuService();
                DataTable dt = service.GetData("Pid=0 and id in (" + where + ")", "");

                HttpCookie cookie = Request.Cookies["itemid"];
                HttpCookie pidcookie = Request.Cookies["pid"];

                DataTable newdt = BuildDataTable();


                string itemid = Request.QueryString["itemid"].SafeToString();
                string pid = Request.QueryString["pid"].SafeToString();
                if (string.IsNullOrEmpty(itemid) && string.IsNullOrEmpty(pid))
                {
                    if (cookie != null && pidcookie != null)
                    {
                        itemid = cookie.Value;
                        pid = pidcookie.Value;
                    }
                    else
                    {
                        itemid = "0";
                        pid = "0";
                    }

                }
                foreach (DataRow item in dt.Rows)
                {
                    int childCount = GetMenusById(item["Id"].SafeToString());
                    DataRow dr = newdt.NewRow();
                    dr["Id"] = item["Id"];
                    dr["MenuUrl"] = item["MenuUrl"];
                    if (childCount > 0)
                    {
                        dr["MenuTitle"] = item["MenuTitle"];
                    }
                    else
                    {
                        dr["MenuTitle"] = "<a href=\"" + item["MenuUrl"].SafeToString() + "\">" + item["MenuTitle"] + "</a>";
                    }

                    dr["Pid"] = item["Pid"];
                    dr["ImgUrl"] = item["ImgUrl"];
                    if (cookie != null && pidcookie != null)
                    {

                        if (item["Id"].SafeToString() == itemid)
                        {
                            dr["background"] = "background-color:#A6A6A6;";
                        }
                        if (item["Id"].SafeToString() == pid)
                        {
                            dr["display"] = "display:block;";
                        }
                    }
                    else
                    {
                        dr["background"] = "";
                        dr["display"] = "";
                    }
                    newdt.Rows.Add(dr);
                }




                //查出这个人的角色，可能有多个。
                //然后根据角色去角色菜单表中查出所有的菜单Id，

                Rpt_Menu.DataSource = newdt;
                Rpt_Menu.DataBind();
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "Menu.ascx_BindMenu");
            }
        }
        private int GetMenusById(string id)
        {
            try
            {
                AssoMenuService am = new AssoMenuService();
                return am.GetEntityListByField("Pid", id).Count;
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "Menu.ascx_GetMenusById");
                return 0;
            }
        }
        public static DataTable BuildDataTable()
        {
            DataTable dataTable = new DataTable();
            string[] arrs = new string[] { "Id", "MenuUrl", "MenuTitle", "Pid", "ImgUrl", "display", "background" };
            foreach (string column in arrs)
            {
                dataTable.Columns.Add(column);
            }
            return dataTable;
        }

        private string GetRoleByUid()
        {
            try
            {
                List<string> ls = new List<string>();
                HttpCookie userInfo = Request.Cookies["UserId"];
                if (userInfo != null)
                {
                    RoleUserService service = new RoleUserService();
                    string uid = userInfo.Value;
                    DataTable dtrole = service.GetData("UserId=" + uid, "");
                    System.Text.StringBuilder sbText = new System.Text.StringBuilder();
                    foreach (DataRow dr in dtrole.Rows)
                    {
                        sbText.Append(dr["RoleId"].SafeToString());
                        sbText.Append(",");
                    }
                    if (!string.IsNullOrEmpty(sbText.ToString().TrimEnd(',')))
                    {
                        ls = GetMenuIdByRole(sbText.ToString().TrimEnd(','));
                    }

                }
                StringBuilder result = new StringBuilder();
                foreach (string s in ls)
                {
                    result.Append(s);
                    result.Append(",");
                }
                return result.ToString().TrimEnd(',') == "" ? "0" : result.ToString().TrimEnd(',');
            }
            catch (Exception ex)
            {
               ErrorLog.writeLogMessage(ex.Message, "Menu.ascx_GetMenusById");
               return "0";
            }
        }

        private List<string> GetMenuIdByRole(string where)
        {
            List<string> ls = new List<string>();
            try
            {
                RoleMenuService service = new RoleMenuService();
                DataTable dt = service.GetData("RoleId in (" + where + ")", "");
                foreach (DataRow dr in dt.Rows)
                {
                    if (!ls.Contains(dr["MenuId"].SafeToString()))
                    {
                        ls.Add(dr["MenuId"].SafeToString());
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "Menu.ascx_GetMenuIdByRole");
               
            }

            return ls;
        }

        protected void Rpt_Menu_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            try
            {
                if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
                {
                    Repeater rpt = e.Item.FindControl("Rpt_SubMenu") as Repeater;

                    int pid = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "Id"));
                    AssoMenuService service = new AssoMenuService();
                    string where = GetRoleByUid();
                    DataTable dt = service.GetData("Pid=" + pid + " and id in (" + where + ")", "");
                    //取出Cookie
                    HttpCookie cookie = Request.Cookies["itemid"];
                    HttpCookie pidcookie = Request.Cookies["pid"];
                    //dt.Columns.Add("display");

                    DataTable newdt = BuildDataTable();

                    string itemid = Request.QueryString["itemid"].SafeToString();
                    string pidco = Request.QueryString["pid"].SafeToString();
                    if (string.IsNullOrEmpty(itemid) && string.IsNullOrEmpty(pidco))
                    {
                        if (cookie != null && pidcookie != null)
                        {
                            itemid = cookie.Value;
                            pidco = pidcookie.Value;
                        }
                        else
                        {
                            itemid = "0";
                            pidco = "0";
                        }
                    }

                    foreach (DataRow item in dt.Rows)
                    {
                        DataRow dr = newdt.NewRow();
                        dr["Id"] = item["Id"];
                        dr["MenuUrl"] = item["MenuUrl"];
                        dr["MenuTitle"] = item["MenuTitle"];
                        dr["Pid"] = item["Pid"];
                        dr["ImgUrl"] = item["ImgUrl"];

                        if (cookie != null && pidcookie != null)
                        {
                            if (item["Id"].SafeToString() == itemid)
                            {
                                dr["background"] = "background-color:#A6A6A6;";
                            }
                        }
                        else
                        {
                            dr["background"] = "";
                        }
                        newdt.Rows.Add(dr);
                    }


                    rpt.DataSource = newdt;
                    rpt.DataBind();


                }
            }
            catch (Exception ex)
            {
               ErrorLog.writeLogMessage(ex.Message, "Menu.ascx_Rpt_Menu_ItemDataBound");
            }

        }
    }
}