using SMSBLL;
using SMSModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSUtility;

namespace SMSWeb.Association
{
    public partial class AddAssociaeNews : System.Web.UI.Page
    {
        public static string userid { get; set; }
        public static string username { get; set; }
        // LogCommon com = new LogCommon();
        protected void Page_Load(object sender, EventArgs e)
        {
            UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                HttpCookie userIdcook = Request.Cookies["UserId"];
                HttpCookie UserName = Request.Cookies["UserName"];
                if (userIdcook != null)
                {
                    userid = Request.Cookies["UserId"].Value.SafeToString();
                    userIdcook.Expires = DateTime.Now.AddSeconds(10000);
                    Response.Cookies.Add(userIdcook);
                }
                if (UserName != null)
                {
                    username = Request.Cookies["UserName"].Value.SafeToString();
                    UserName.Expires = DateTime.Now.AddSeconds(10000);

                    Response.Cookies.Add(UserName);
                }
                Page.Form.Attributes.Add("enctype", "multipart/form-data");
                string itemId = Request.QueryString["itemid"];
                if (!string.IsNullOrEmpty(itemId))//社团管理员发布的新闻动态，itemid=0;
                {
                    ViewState["itemid"] = itemId;
                }
            }
        }
        protected void Btn_InfoSave_Click(object sender, EventArgs e)
        {
            string script = "parent.window.location.href=parent.window.location.href;";
            try
            {
                AssoNewsService assonewservice = new AssoNewsService();
                AssoNews item = new AssoNews();
                AssoActive active = new AssoActive();
                AssoActiveService activeservice = new AssoActiveService();
                active.Title = "发布动态";
                active.ActiveUrl = "";
                int activeid= activeservice.Insert(active);
                item.CreateUserId = int.Parse(userid);
                item.Title = TB_Title.Text;
                item.NewsContent = TB_Content.Text;
                item.AssoId = int.Parse(ViewState["itemid"].SafeToString());
                item.ClickNumber = 0;
                item.CreateTime = DateTime.Now;
                item.ActiveId = activeid;
                ////判断是否上传图片
                //if (this.fimg_Asso.PostedFile.FileName != null && this.fimg_Asso.PostedFile.FileName.Trim() != "")
                //{
                //    HttpPostedFile hpimage = this.fimg_Asso.PostedFile;
                //    string photoName = hpimage.FileName;//获取初始文件名
                //    string photoExt = photoName.Substring(photoName.LastIndexOf(".")); //通过最后一个"."的索引获取文件扩展名
                //    if (photoExt.ToLower() != ".gif" && photoExt.ToLower() != ".jpg" && photoExt.ToLower() != ".jpeg" && photoExt.ToLower() != ".bmp" && photoExt.ToLower() != ".png")
                //    {
                //        this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "alert('请选择图片文件！');", true);
                //        return;
                //    }
                //    System.IO.Stream stream = hpimage.InputStream;
                //    byte[] bytPhoto = new byte[Convert.ToInt32(hpimage.ContentLength)];
                //    stream.Read(bytPhoto, 0, Convert.ToInt32(hpimage.ContentLength));
                //    stream.Close();
                //    if (item.Attachments.Count > 0)
                //    {
                //        item.Attachments.Delete(item.Attachments[0]);
                //    }
                //    item.Attachments.Add(photoName, bytPhoto); //为列表添加附件
                //}
              bool result=  assonewservice.Add(item);



            }
            catch (Exception ex)
            {
                script = "alert('保存失败，请重试...');";
                ErrorLog.writeLogMessage(ex.Message, "AddAssociaeNews.aspx");
            }
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), script, true);
        }
    }
}
