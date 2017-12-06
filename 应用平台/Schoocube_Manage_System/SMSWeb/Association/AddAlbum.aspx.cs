using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSBLL;
using SMSUtility;
using SMSModel;

namespace SMSWeb.Association
{
    public partial class AddAlbum : System.Web.UI.Page
    {
        //LogCommon com = new LogCommon();
        protected void Page_Load(object sender, EventArgs e)
        {
            UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                string itemId = Request.QueryString["itemid"];
                ViewState["NewsItemId"] = itemId;
            }
        }
        protected void Btn_InfoSave_Click(object sender, EventArgs e)
        {
            string script = string.Empty;
            try
            {
                string Userid = "";
                HttpCookie userId = Request.Cookies["UserId"];
                Userid = Request.Cookies["UserId"].Value.SafeToString();
                userId.Expires = DateTime.Now.AddSeconds(10000);
                Response.Cookies.Add(userId);
                if (!string.IsNullOrEmpty(this.TB_Title.Text.Trim()) && !string.IsNullOrEmpty(Userid))
                {
                    AssoAlbumService albumservice = new AssoAlbumService();
                    bool result = albumservice.CheckForeignKey("AlbumName", this.TB_Title.Text.Trim());

                    if (!result)
                    {
                        AssoAlbum albumn = new AssoAlbum();
                        albumn.AssoId = int.Parse(ViewState["NewsItemId"].ToString());
                        albumn.AlbumName = this.TB_Title.Text.Trim();
                        albumn.AlbumDescription = txt_Remark.Text;
                        albumn.CreateTime = DateTime.Now;
                        albumn.CreateUserId = int.Parse(Userid);
                        int itemid = albumservice.Insert(albumn);
                        if (itemid > 0)
                        {
                            script = "parent.closePages();parent.reloadAlbum();";
                        }
                    }
                    else
                    {
                        script = "alert('相册已经存在');";
                    }

                }
            }
            catch (Exception ex)
            {
                script = "alert('创建相册失败，请重试...');";
                ErrorLog.writeLogMessage(ex.Message, "AddAlbum.aspx_Btn_InfoSave_Click");
            }
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), script, true);
        }
    }
}