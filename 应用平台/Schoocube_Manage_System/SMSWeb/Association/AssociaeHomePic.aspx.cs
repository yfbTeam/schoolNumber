using SMSUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSBLL;
using SMSModel;
using System.Data;
using System.IO;

namespace SMSWeb.Association
{
    public partial class AssociaeHomePic : System.Web.UI.Page
    {
        // LogCommon com = new LogCommon();
        AssoInfoService assoservice = new AssoInfoService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Page.Form.Attributes.Add("enctype", "multipart/form-data");
                string itemId = Request.QueryString["itemid"];
                if (!string.IsNullOrEmpty(itemId))
                {
                    ViewState["itemid"] = itemId;
                    BindHomePic(itemId);
                }
            }
        }
        private void BindHomePic(string itemId)
        {
            try
            {
                DataTable items = assoservice.GetData(" id=" + itemId, "");
                if (items != null && items.Rows.Count > 0)
                {
                    this.Imgshow.Src = items.Rows[0]["AssoBackPicUrl"].SafeToString().Trim() == "" ? "/Stu_images/sushetu.jpg" : items.Rows[0]["AssoBackPicUrl"].SafeToString();
                }

            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "BindHomePic_社团背景照片绑定");
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string script = "parent.window.location.href=parent.window.location.href;";
            try
            {
                AssoInfo asso = assoservice.GetEntityById(int.Parse(ViewState["itemid"].SafeToString()));

                HttpPostedFile hpimage = this.fimg_Asso.PostedFile;
                if (hpimage != null && hpimage.FileName.Trim() != "" && asso != null)
                {
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
                    asso.AssoBackPicUrl = url;

                    bool result = assoservice.Update(asso);
                    if (result)
                    {
                        script = "alert('保存成功！')";
                    }
                }

            }
            catch (Exception ex)
            {
                script = "alert('保存失败，请重试...')";
                ErrorLog.writeLogMessage(ex.Message, "AddAssociae_btnAdd_Click");
            }
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), script, true);
        }
    }
}
