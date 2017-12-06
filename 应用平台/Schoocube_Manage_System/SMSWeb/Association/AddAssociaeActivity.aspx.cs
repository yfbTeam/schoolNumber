using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSBLL;
using SMSModel;
using SMSUtility;
using System.IO;

namespace SMSWeb.Association
{
    public partial class AddAssociaeActivity : System.Web.UI.Page
    {
        // LogCommon com = new LogCommon();
        public AssoActivityService activityservice = new AssoActivityService();
        public string Associae_ID { get { return ViewState["Associae_ID"].SafeToString(""); } set { ViewState["Associae_ID"] = value; } }
        public string Userid { get { return ViewState["userid"].SafeToString(""); } set { ViewState["userid"] = value; } }
        protected void Page_Load(object sender, EventArgs e)
        {
            UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                this.Associae_ID = Request.QueryString["itemid"];
                HttpCookie userId = Request.Cookies["UserId"];
                if (userId != null)
                {
                    Userid = Request.Cookies["UserId"].Value.SafeToString();
                    userId.Expires = DateTime.Now.AddSeconds(10000);
                    Response.Cookies.Add(userId);
                }

            }
        }

        //添加按钮的单击事件
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string script = "parent.window.location.href=parent.window.location.href;";
            try
            {
                if (!string.IsNullOrEmpty(Userid) &&! string.IsNullOrEmpty(Associae_ID))
                {

                    AssoActivity item = new AssoActivity();

                    item.ActivityTitle = this.txtTitle.Value.Trim();
                    item.StartTime = DateTime.Parse(this.dtStartTime.Value);
                    item.EndTime = DateTime.Parse(this.dtEndTime.Value);
                    item.AssoId = int.Parse(Associae_ID);
                    item.ActivityAddress = this.txtAddress.Value.Trim();
                    item.ActivityContent = this.txtContent.Value;
                    item.CreateUserId = int.Parse(Userid.SafeToString("0"));
                    item.CreateTime = DateTime.Now;
                    item.ExamStatus = "审核通过";
                    //判断是否上传图片
                    if (this.fimg_Asso.PostedFile.FileName != null && this.fimg_Asso.PostedFile.FileName.Trim() != "")
                    {
                        HttpPostedFile hpimage = this.fimg_Asso.PostedFile;
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
                        if (!Directory.Exists("/UploadImgFile/AssoActivityPic"))
                        {
                            Directory.CreateDirectory("/UploadImgFile/AssoActivityPic");
                        }
                        string url = "/UploadImgFile/AssoActivityPic/" + DateTime.Now.ToFileTime().ToString() + photoExt;
                        string fullPath = Context.Server.MapPath(url);
                        hpimage.SaveAs(fullPath);
                        //为列表添加活动封面图片
                        item.ActivityImg = url;
                    }
                 
                    int itemid = activityservice.Insert(item);

                    if (itemid > 0)
                    {
                        if (this.file_activity.PostedFile.FileName != null && this.file_activity.PostedFile.FileName.Trim() != "")
                        {
                            //添加附件
                            HttpPostedFile faimage = this.file_activity.PostedFile;
                            string fileExt = Path.GetExtension(faimage.FileName);
                            if (!Directory.Exists("/UploadFile"))
                            {
                                Directory.CreateDirectory("/UploadFile");
                            }
                            if (!Directory.Exists("/UploadFile/AssoActivity"))
                            {
                                Directory.CreateDirectory("/UploadFile/AssoActivity");
                            }
                            string url = "/UploadFile/AssoActivity/" + DateTime.Now.ToFileTime().ToString() + fileExt;
                            string fullPath = Context.Server.MapPath(url);
                            faimage.SaveAs(fullPath);
                          
                            ActivityData newdata = new ActivityData();
                            ActivityDataService dataservice = new ActivityDataService();
                            newdata.ActivityId = itemid;
                            newdata.AssoId = int.Parse(Associae_ID);
                            newdata.CreatedTime = DateTime.Now;
                            newdata.CreatedUserId = int.Parse(Userid.SafeToString("0"));
                            newdata.DataTitle = Path.GetFileName(faimage.FileName);
                            newdata.DataType = fileExt.Replace(".","");
                            newdata.DataUrl = url;
                           bool result= dataservice.Add(newdata);
                        }
                        
                    }
                }
                else {

                    script = "alert('发布活动失败！');";
                }

            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "AddAssociaeActivity.aspx");
                //this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "alert('" + ex.Message + "');", true);
            }
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), script, true);
        }


    }
}