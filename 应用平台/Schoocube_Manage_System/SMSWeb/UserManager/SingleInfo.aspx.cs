using SMSBLL;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.UserManager
{
    public partial class SingleInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetUserById();
            }
        }
        private void GetUserById()
        {
            try
            {
                HttpCookie userInfo = Request.Cookies["UserId"];
                if (userInfo != null)
                {
                    string uid = userInfo.Value;
                    this.Hid_Uid.Value = uid;
                    UserInfoService service = new UserInfoService();
                    SMSModel.UserInfo u = service.GetEntityById(Convert.ToInt32(uid));
                    if (u != null)
                    {
                        this.TB_UserName.Text = u.UserName;
                        this.TB_LoginName.Text = u.LoginName;
                        this.TB_Password.Attributes.Add("value", u.Password);
                        this.TB_Password2.Attributes.Add("value", u.Password);
                        this.TB_Email.Text = u.Email;
                        this.TB_Sex.Text = u.Sex;
                    }
                    else
                    {
                        Response.Redirect("~/Login.aspx");
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "SingleInfo_GetUserById");
            }

        }

        protected void Btn_Save_Click(object sender, EventArgs e)
        {

            try
            {
                UserInfoService service = new UserInfoService();
                SMSModel.UserInfo u = new SMSModel.UserInfo();
                u.Id = Convert.ToInt32(this.Hid_Uid.Value);
                u.UserName = this.TB_UserName.Text;
                u.LoginName = this.TB_LoginName.Text;
                u.Password = this.TB_Password.Text;

                u.Email = this.TB_Email.Text;
                u.Sex = this.TB_Sex.Text;
                if (this.file_activity.PostedFile.FileName != null && this.file_activity.PostedFile.FileName.Trim() != "")
                {
                    HttpPostedFile hpimage = this.file_activity.PostedFile;
                    string photoName = hpimage.FileName;//获取初始文件名
                    string photoExt = photoName.Substring(photoName.LastIndexOf(".")); //通过最后一个"."的索引获取文件扩展名
                    if (photoExt.ToLower() != ".gif" && photoExt.ToLower() != ".jpg" && photoExt.ToLower() != ".jpeg" && photoExt.ToLower() != ".bmp" && photoExt.ToLower() != ".png")
                    {
                        this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "alert('请选择图片文件！');", true);
                        return;
                    }
                    if (!Directory.Exists("/UploadImgFile"))
                    {
                        Directory.CreateDirectory("/UploadImgFile");
                    }
                    if (!Directory.Exists("/UploadImgFile/UserImg"))
                    {
                        Directory.CreateDirectory("/UploadImgFile/UserImg");
                    }
                    string url = "/UploadImgFile/UserImg/" + DateTime.Now.ToFileTime().ToString() + photoExt;
                    string fullPath = Context.Server.MapPath(url);
                    hpimage.SaveAs(fullPath);
                    //为列表添加活动封面图片
                    u.ImgUrl = url;
                }
                if (service.Update(u))
                {
                    this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "alert('更新成功');", true);

                }
                else
                {
                    this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "alert('更新失败，请重试');", true);
                    GetUserById();
                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "SingleInfo_Btn_Save_Click");
            }
        }
    }
}