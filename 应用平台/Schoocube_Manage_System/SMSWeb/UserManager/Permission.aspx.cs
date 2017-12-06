using SMSBLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSUtility;

namespace SMSWeb.UserManager
{
    public partial class Permission : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {
                if (!IsPostBack)
                {
                    BindRole();
                    GetUserByRole("");

                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "Permission_PageLoad");
            }
        }

        private void BindRole()
        {
            try
            {
                RoleService service = new RoleService();
                DataTable dt = service.GetData(null, null);
                this.Rpt_Perssion.DataSource = dt;
                this.Rpt_Perssion.DataBind();
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "Permission_BindRole");
            }
        }

        private void GetUserByRole(string where)
        {

            try
            {
                UserInfoService service = new UserInfoService();
                DataTable dt = service.GetAllRoleUser(where);
                LV_PermissionManager.DataSource = dt;
                LV_PermissionManager.DataBind();
            }
            catch (Exception ex)
            {

                ErrorLog.writeLogMessage(ex.Message, "Permission_BindRole");
            }

        }
        protected void LV_PermissionManager_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            DP_PermissionManager.SetPageProperties(DP_PermissionManager.StartRowIndex, e.MaximumRows, false);
            GetUserByRole("");
        }

        protected void Btn_RoleName_Click(object sender, EventArgs e)
        {

            try
            {
                ControlCollection colls = Rpt_Perssion.Controls;
                foreach (Control coll in colls)
                {
                    Button other = coll.FindControl("Btn_RoleName") as Button;
                    if (other != null)
                    {
                        other.CssClass = "";
                    }

                }
                Button btn = sender as Button;
                Hid_BtnClint.Value = btn.ClientID;
                btn.CssClass += "selectinp";
                string roleId = btn.CommandArgument;
                this.Hid_RoleFlag.Value = roleId;
                GetUserByRole("RoleId=" + roleId);
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "Permission_Btn_RoleName_Click");
            }
        }

        protected void Btn_Del_Click(object sender, EventArgs e)
        {
            try
            {
                Button btn = sender as Button;
                if (btn.CommandName == "Del")
                {
                    string userId = btn.CommandArgument.SafeToString();
                    string roleId = Hid_RoleFlag.Value;
                    RoleUserService service = new RoleUserService();
                    if (service.DeleteByRoleAndUser(roleId, userId))
                    {
                        GetUserByRole("RoleId=" + roleId);
                        this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "alert('移除成功');", true);
                    }
                    else
                    {
                        this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "alert('移除失败');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "Permission_Btn_Del_Click");
            }

        }


    }
}