using SMSBLL;
using SMSModel;
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
    public partial class UserInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetAllUser(null);

            }
        }

        protected void LV_UserInfo_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            DP_UserInfo.SetPageProperties(DP_UserInfo.StartRowIndex, e.MaximumRows, false);
            GetAllUser(ViewState["Where"].SafeToString());
        }

        protected void Btn_Search_Click(object sender, EventArgs e)
        {
            try
            {
                string userName = TB_Search.Text.Trim();
                if (userName != "")
                {
                    ViewState["Where"] = "UserName like '%" + userName + "%'";
                }
                else
                {
                    ViewState["Where"] = "";
                }
                GetAllUser(ViewState["Where"].SafeToString());
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "UserInfo_Btn_Save_Click");
            }
        }

        private void GetAllUser(string condition)
        {
            try
            {
                UserInfoService service = new UserInfoService();
                DataTable dt = service.GetAllUser(condition);
                LV_UserInfo.DataSource = dt;
                LV_UserInfo.DataBind();
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "UserInfo_GetAllUser");
            }
        }

        protected void Btn_Del_Click(object sender, EventArgs e)
        {
            try
            {
                Button btn = sender as Button;
                string userId = btn.CommandArgument;
                if (GetUserById(userId))
                {
                    this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "alert('请先将用户从角色中移除');", true);
                }
                else
                {
                    UserInfoService service = new UserInfoService();
                    if (service.Delete(Convert.ToInt32(userId)))
                    {
                        this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "alert('删除成功');", true);
                        GetAllUser(ViewState["Where"].SafeToString());
                    }
                    else
                    {
                        this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "alert('删除失败，请重试');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "UserInfo_Btn_Del_Click");
            }
        }

        private bool GetUserById(string userId)
        {
            bool flag = false;
            try
            {
                RoleUserService service = new RoleUserService();
                List<RoleUser> ls = service.GetEntityListByField("RoleId", userId);
                if (ls.Count > 0)
                {
                    flag = true;
                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "UserInfo_GetUserById");
            }
            return flag;
        }
    }
}