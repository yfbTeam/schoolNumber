using SMSBLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSUtility;
using SMSModel;

namespace SMSWeb.UserManager
{
    public partial class AddRoleMember : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    string roleId = Request.QueryString["roleId"].SafeToString();
                    if (!string.IsNullOrEmpty(roleId))
                    {
                        string where = GetUserIdByRoleId(roleId);
                        if (!string.IsNullOrEmpty(where))
                        {
                            ViewState["Where"] = "id not in (" + where + ")";
                        }
                    }

                    GetAllUser(ViewState["Where"].SafeToString());
                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "AddRoleMember_Page_Load");
            }
        }

        private string GetUserIdByRoleId(string roleId)
        {
            try
            {
                RoleUserService service = new RoleUserService();
                DataTable dt = service.GetData("RoleId=" + roleId, "");
                StringBuilder sb = new StringBuilder();
                if (dt != null)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        sb.Append(dt.Rows[i]["UserId"]);
                        sb.Append(",");
                    }
                }

                return sb.SafeToString().TrimEnd(',');
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "AddRoleMember_GetUserIdByRoleId");
                return "";
            }
        }

        protected void Btn_Search_Click(object sender, EventArgs e)
        {
            try
            {
                string userName = TB_Search.Text.Trim();
                string where = "";
                if (!string.IsNullOrEmpty(ViewState["Where"].SafeToString()))
                {
                    where = ViewState["Where"].SafeToString() + " and UserName like " + userName;
                }
                else
                {
                    where = "UserName like '%" + userName + "%'";
                }
                GetAllUser(where);
            }
            catch (Exception ex)
            {
               ErrorLog.writeLogMessage(ex.Message, "AddRoleMember_Btn_Search_Click");
            }
        }

        protected void LV_UserManager_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            DP_UserManager.SetPageProperties(DP_UserManager.StartRowIndex, e.MaximumRows, false);
            GetAllUser(ViewState["Where"].SafeToString());
        }

        private void GetAllUser(string where)
        {
            try
            {
                UserInfoService service = new UserInfoService();
                DataTable dt = service.GetAllUser(where);
                LV_UserManager.DataSource = dt;
                LV_UserManager.DataBind();
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "AddRoleMember_GetAllUser");
            }
        }

        protected void Btn_Ok_Click(object sender, EventArgs e)
        {
            try
            {
                string[] ids = this.Hid_UserIds.Value.Split(new char[] { '_' }, StringSplitOptions.RemoveEmptyEntries);
                string roleId = Request.QueryString["roleId"].SafeToString();
                RoleUserService service = new RoleUserService();
                foreach (string item in ids)
                {
                    RoleUser roleUser = new RoleUser();
                    roleUser.UserId = Convert.ToInt32(item);
                    roleUser.RoleId = Convert.ToInt32(roleId);
                    service.Add(roleUser);
                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "AddRoleMember_Btn_Ok_Click");
            }
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "btnOk();", true);
        }
    }
}