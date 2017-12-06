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
using System.IO;

namespace SMSWeb.Association
{
    public partial class AddAssociae : System.Web.UI.Page
    {
        //LogCommon com = new LogCommon();
        private string Role { get; set; }//ListHelp.GetCurrentUserRole(); } }
        public AssoInfoService assservice = new AssoInfoService();
        public UserInfoService userservice = new UserInfoService();
        public AssoMemberService memberservice = new AssoMemberService();

        protected void Page_Load(object sender, EventArgs e)
        {
            UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                try
                {

                    //获取角色
                    HttpCookie user = Request.Cookies["UserId"];
                    if (user != null)
                    {
                        string Userid = Request.Cookies["UserId"].Value.SafeToString();
                        user.Expires = DateTime.Now.AddSeconds(10000);
                        Response.Cookies.Add(user);
                        RoleUserService roleuserservice = new RoleUserService();
                        List<RoleUser> roleusers = roleuserservice.GetEntityListByField("UserId", Userid);
                        if (roleusers.Count > 0)
                        {
                            int roleid = int.Parse(roleusers[0].RoleId.SafeToString("0"));
                            RoleService roleservice = new RoleService();
                            Role role = roleservice.GetEntityById(roleid);
                            Role = role.RoleName;
                        }

                    }
                }
                catch (Exception ex)
                {
                }
                Page.Form.Attributes.Add("enctype", "multipart/form-data");
                //绑定社团数据
                string itemId = Request.QueryString["itemid"];
                if (!string.IsNullOrEmpty(itemId))
                {
                    BindType(itemId);
                    ViewState["itemid"] = itemId;
                    BindAssociaeData(itemId);
                }
            }
        }
        private void BindType(string itemId)
        {
            try
            {
                AssoTypeService assotype = new AssoTypeService();
                DataTable typedt = assotype.GetData(null, null);
                string[] types = new string[] { "体育活动", "休闲娱乐", "业余爱好" };
                foreach (DataRow type in typedt.Rows)
                {
                    DDL_Type.Items.Add(new ListItem(type["Title"].SafeToString(), type["Id"].SafeToString()));
                }
                //社团成员
                this.DDL_SecLeader.Items.Add(new ListItem("--请选择副团长--", ""));
                string Query = "AssoId=" + itemId;
                DataTable items = memberservice.GetData(Query, null);
                foreach (DataRow item in items.Rows)
                {
                    int UserId = int.Parse(item["UserId"].SafeToString("0"));
                    UserInfo cuser = userservice.GetEntityById(UserId);
                    this.DDL_SecLeader.Items.Add(new ListItem(cuser.UserName, cuser.Id.SafeToString()));

                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "AddAssociae.BindType");
            }
        }
        private void BindAssociaeData(string Aid)
        {
            try
            {
                int itemId = Convert.ToInt32(Aid);

                #region 社团信息
                AssoInfo item = assservice.GetEntityById(itemId);
                this.TB_Title.Text = item.AssoName;
                this.TB_Slogans.Text = item.AssoSlogan;
                this.TB_Content.Text = item.AssoIntroduce;
                this.DDL_Type.SelectedItem.Value = item.AssoType;

                this.img_Pic.ImageUrl = item.AssoPicURL;

                string secleader = userservice.GetEntityById(int.Parse(item.AssoLeaderSecondId.SafeToString("0"))).UserName;
                if (!string.IsNullOrEmpty(secleader))
                {

                    this.DDL_SecLeader.Items.Add(new ListItem(secleader, item.AssoLeaderSecondId.SafeToString("0")));
                    this.DDL_SecLeader.SelectedValue = item.AssoLeaderSecondId.SafeToString("0");
                }

                #endregion

            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "AddAssociae.BindAssociaeData");
            }
        }
        protected void Btn_InfoSave_Click(object sender, EventArgs e)
        {
            string script = "parent.window.location.reload();";
            try
            {

                #region 创建社团信息
                //SPList list = oWeb.Lists.TryGetList("社团信息");
                //SPListItem item;
                AssoInfo item = new AssoInfo();

                if (!string.IsNullOrEmpty(ViewState["itemid"].SafeToString()))//社团资料修改
                {
                    int intItemId = Convert.ToInt32(ViewState["itemid"]);
                    item = assservice.GetEntityById(intItemId);
                }
                else //第一次创建
                {
                    string Query = "AssoName='" + TB_Title.Text + "'";
                    DataTable iscundt = assservice.GetData(Query, null);
                    if (iscundt != null && iscundt.Rows.Count > 0)
                    {
                        this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "alert('创建社团失败，已存在同名社团！');", true);
                        return;
                    }
                    item.AssoStatus = "开放";
                }
                item.AssoName = TB_Title.Text;
                item.AssoSlogan = TB_Slogans.Text;
                item.AssoType = DDL_Type.SelectedValue;
                item.AssoIntroduce = TB_Content.Text;
                if (!string.IsNullOrEmpty(DDL_SecLeader.SelectedValue))
                {
                    item.AssoLeaderSecondId = Convert.ToInt32(DDL_SecLeader.SelectedItem.Value);
                }
                //判断是否上传图片
                if (this.fimg_Asso.PostedFile.FileName != null && this.fimg_Asso.PostedFile.FileName.Trim() != "")
                {
                    HttpPostedFile hpimage = this.fimg_Asso.PostedFile;
                    string photoName = hpimage.FileName;//获取初始文件名
                    string fileExtension = System.IO.Path.GetExtension(hpimage.FileName).ToLower(); ;
                    if (fileExtension.ToLower() != ".gif" && fileExtension.ToLower() != ".jpg" && fileExtension.ToLower() != ".jpeg" && fileExtension.ToLower() != ".bmp" && fileExtension.ToLower() != ".png")
                    {
                        this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "alert('请选择图片文件！');", true);
                        return;
                    }
                    if (!Directory.Exists("/UploadImgFile"))
                    {
                        Directory.CreateDirectory("/UploadImgFile");
                    }
                    if (!Directory.Exists("/UploadImgFile/AssoPic"))
                    {
                        Directory.CreateDirectory("/UploadImgFile/AssoPic");
                    }
                    string url = "/UploadImgFile/AssoPic/" + DateTime.Now.ToFileTime().ToString() + fileExtension;
                    string fullPath = Context.Server.MapPath(url);
                    hpimage.SaveAs(fullPath);

                    item.AssoPicURL = fullPath;
                }
                assservice.Update(item);
                #endregion

            }
            catch (Exception ex)
            {
                script = "alert('提交失败，请重试...')";
                ErrorLog.writeLogMessage(ex.Message, "AddAssociae.aspx");
            }
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), script, true);
        }
    }
}