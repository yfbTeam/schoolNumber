using SMSBLL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.UserManager
{
    public partial class EditRole : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            try
            {
                if (!IsPostBack)
                {
                    string roleId = Request.QueryString["itemId"];
                    ViewState["roleId"] = roleId;
                    BindRole(roleId);
                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "EditRole_PageLoad");
            }

        }

        private void BindRole(string roleId)
        {
            try
            {
                RoleService service = new RoleService();
                Role r = service.GetEntityById(Convert.ToInt32(roleId));
                if (r != null)
                {
                    this.TB_RoleName.Text = r.RoleName;
                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "EditRole_BindRole");
            }

        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(ViewState["roleId"].SafeToString()))
                {
                    return;
                }
                //获取当前角色对应的所有的菜单Id集合
                List<string> ls = GetMenusByRole(ViewState["roleId"].SafeToString());
                string position = this.PositionName.Value;
                string[] arr = position.Split(',');
                AssoMenuService amservice = new AssoMenuService();
                RoleMenuService roservice = new RoleMenuService();
                foreach (string item in arr)
                {
                    AssoMenu am = amservice.GetEntityById(Convert.ToInt32(item));
                    //前台打勾了，后台权限没有
                    if (!ls.Contains(item))
                    {
                        RoleMenu ro = new RoleMenu() { RoleId = Convert.ToInt32(ViewState["roleId"]), MenuId = am.Id };
                        roservice.Add(ro);
                    }
                    else
                    {
                        //前台打勾了，但是后台包含。把包含的从集合中移除。
                        ls.Remove(item);
                    }
                    if (am.Pid != 0 && !ls.Contains(am.Pid.ToString()))
                    {
                        RoleMenu paro = new RoleMenu() { RoleId = Convert.ToInt32(ViewState["roleId"]), MenuId = am.Pid };
                        roservice.Add(paro);
                    }
                    else if (am.Pid != 0 && ls.Contains(am.Pid.ToString()))
                    {
                        ls.Remove(am.Pid.ToString());
                    }
                }
                foreach (string move in ls)
                {
                    roservice.DeleteByRoleAndMenu(ViewState["roleId"].SafeToString(), move);
                }
            }
            catch (Exception ex)
            {
               ErrorLog.writeLogMessage(ex.Message, "EditRole_btnAdd_Click");
            }
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "btnOk();", true);

        }

        private List<string> GetMenusByRole(string roleId)
        {
            List<string> ls = new List<string>();
            try
            {
                RoleMenuService roservice = new RoleMenuService();
                DataTable dt = roservice.GetData("RoleId=" + roleId, "");

                foreach (DataRow item in dt.Rows)
                {
                    if (!ls.Contains(item["MenuId"].SafeToString()))
                    {
                        ls.Add(item["MenuId"].SafeToString());
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "EditRole_GetMenusByRole");
            }
            return ls;
        }
    }
}