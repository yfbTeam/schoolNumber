using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSBLL;

namespace SMSWeb
{
    public partial class MyInfo : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                ReadCook();
            }
        }
        private void ReadCook()
        {
            try
            {
                HttpCookie userInfo = Request.Cookies["UserName"];
                HttpCookie uidcookie = Request.Cookies["UserId"];

                if (userInfo != null && uidcookie != null)
                {
                    SMSBLL.UserInfoService service = new SMSBLL.UserInfoService();
                    SMSModel.UserInfo u = service.GetEntityById(Convert.ToInt32(uidcookie.Value));
                    //读取出cookies中的值
                    if (u != null)
                    {
                        Literal1.Text = u.UserName;
                        if (!string.IsNullOrEmpty(u.ImgUrl))
                        {
                            this.Img_MyImg.ImageUrl = u.ImgUrl;
                        }
                        userInfo.Expires = DateTime.Now.AddSeconds(10000);
                        Response.Cookies.Add(userInfo);

                        uidcookie.Expires = DateTime.Now.AddSeconds(10000);
                        Response.Cookies.Add(uidcookie);
                    }
                    else
                    {
                        Response.Redirect("~/Login.aspx");
                    }
                }
                else
                {
                    Response.Redirect("~/Login.aspx");
                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "Menu.ascx_Rpt_Menu_ItemDataBound");
            }
        }
    }
}