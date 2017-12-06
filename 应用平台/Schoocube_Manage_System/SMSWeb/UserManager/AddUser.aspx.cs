using SMSBLL;
using SMSModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.UserManager
{
    public partial class AddUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Btn_Save_Click(object sender, EventArgs e)
        {

            try
            {
                SMSModel.UserInfo user = new SMSModel.UserInfo();

                user.LoginName = TB_LoginName.Text.Trim();
                user.UserName = TB_UserName.Text.Trim();
                user.Password = TB_Password.Text.Trim();
                user.Email = TB_Email.Text.Trim();
                user.Sex = TB_Sex.Text.Trim();
                UserInfoService service = new UserInfoService();
                bool result = service.Add(user);
                if (result)
                {
                    //closeFrame('0');
                    this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "closeFrame('1');", true);
                }
                else
                {
                    this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "alert('添加失败')", true);
                }
            }
            catch (Exception ex)
            {
               ErrorLog.writeLogMessage(ex.Message, "AddUser_Btn_Save_Click");
            }
        }
    }
}