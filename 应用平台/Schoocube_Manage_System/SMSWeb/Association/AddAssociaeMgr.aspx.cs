using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSBLL;
using SMSModel;
using System.Data;
using SMSUtility;
using System.IO;

namespace SMSWeb.Association
{
    public partial class AddAssociaeMgr : System.Web.UI.Page
    {
        //LogCommon com = new LogCommon();
        //Stopwatch watch = new Stopwatch();
        public AssoInfoService assoinfoservice = new AssoInfoService();
        public string userid { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            Page.Form.Attributes.Add("enctype", "multipart/form-data");
            HttpCookie UserId = Request.Cookies["UserId"];

            if (UserId != null)
            {
                userid = Request.Cookies["UserId"].Value.SafeToString();
                UserId.Expires = DateTime.Now.AddSeconds(10000);
                Response.Cookies.Add(UserId);
                userid = UserId.Value;
            }
            if (!IsPostBack)
            {



                BindType();
                //绑定社团数据
                string itemId = Request.QueryString["itemid"];
                if (!string.IsNullOrEmpty(itemId))
                {
                    ViewState["itemid"] = itemId;
                    BindAssociaeData(itemId);
                }
                else
                {
                    this.Btn_Delete.Visible = false;
                }
            }
        }
        private void BindType()
        {
            try
            {
                //社团类型
                AssoTypeService assotypeservice = new AssoTypeService();
                DataTable typedt = assotypeservice.GetData(null, null);
                foreach (DataRow type in typedt.Rows)
                {
                    DDL_Type0.Items.Add(new ListItem(type["Title"].SafeToString(), type["Id"].SafeToString()));
                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "AddAssociaeMgr.BindType");
            }
            RoleService roleservice = new RoleService();
            DataTable roledt = roleservice.GetData(null, null);
            this.DDL_Type.Items.Add(new ListItem("-请选择-", ""));
            foreach (DataRow role in roledt.Rows)
            {
                DDL_Type.Items.Add(new ListItem(role["RoleName"].SafeToString(), role["Id"].SafeToString()));
            }
            //this.DDL_Type.Items.Add(new ListItem("教师", "0"));
            //this.DDL_Type.Items.Add(new ListItem("学生", "1"));
        }
        protected void DDL_Type_SelectedIndexChanged(object sender, EventArgs e)
        {
            //watch.Restart();
            try
            {
                if (!string.IsNullOrEmpty(this.DDL_Type.SelectedValue))
                {
                    DataTable dt = new DataTable();
                    dt.Columns.Add("ID");
                    dt.Columns.Add("Name");
                    string role = "";

                    role = this.DDL_Type.SelectedValue;


                    //RoleService roleservice = new RoleService();
                    //DataTable roledt = roleservice.GetData("RoleName='" + role + "'", null);
                    RoleUserService roleuserservice = new RoleUserService();
                    DataTable roleuserdt = roleuserservice.GetData("RoleId=" + role, null);
                    DataTable studentdt = new DataTable();
                    if (roleuserdt != null && roleuserdt.Rows.Count > 0)
                    {
                        UserInfoService userservice = new UserInfoService();
                        foreach (DataRow item in roleuserdt.Rows)
                        {
                            DataRow newdr = dt.NewRow();
                            UserInfo user = userservice.GetEntityById(int.Parse(item["UserId"].SafeToString("0")));
                            newdr["ID"] = user.Id;
                            newdr["Name"] = user.UserName;
                            dt.Rows.Add(newdr);
                        }
                    }
                    if (dt.Rows.Count > 0)
                    {
                        this.DDL_Leader.Items.Clear();

                        foreach (DataRow dr in dt.Rows)
                        {
                            this.DDL_Leader.Items.Add(new ListItem(dr["Name"].ToString(), dr["ID"].ToString()));
                        }

                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "AddAssociaeMgr.DDL_Type_SelectedIndexChanged");
            }
            //watch.Stop();
            //com.writeLogMessage(DDL_Type.SelectedItem.Text + ":" + watch.ElapsedMilliseconds, "AddAssociationMgr.SelectedChanged");
        }
        private void BindAssociaeData(string itemId)
        {
            //watch.Restart();
            try
            {
                int itemid = Convert.ToInt32(itemId);
                AssoInfo item = assoinfoservice.GetEntityById(itemid);
                if (item != null)
                {
                    this.TB_Title.Text = item.AssoName;

                    UserInfo leader = new UserInfoService().GetEntityById(int.Parse(item.AssoLeaderId.SafeToString("0")));
                    this.DDL_Leader.Items.Add(new ListItem(leader.UserName, item.AssoLeaderId.SafeToString()));
                    this.DDL_Leader.SelectedValue = item.AssoLeaderId.SafeToString();

                    this.img_Pic.ImageUrl = item.AssoPicURL;

                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "AddAssociaeMgr.BindAssociaeData");
            }
            //watch.Stop();
            //com.writeLogMessage(watch.ElapsedMilliseconds.ToString(), "AddAssociaeMgr.BindAssociaeData");
        }
        protected void Btn_InfoSave_Click(object sender, EventArgs e)
        {
            string script = "parent.window.location.href='AssociationMgr.aspx';";
            try
            {
                if (!string.IsNullOrEmpty(userid))
                {

                    #region 创建社团信息

                    //watch.Restart();
                    AssoInfo item = new AssoInfo();
                    string leaderid = "";
                    if (!string.IsNullOrEmpty(ViewState["itemid"].SafeToString()))//社团资料修改
                    {
                        int intItemId = Convert.ToInt32(ViewState["itemid"]);
                        item = assoinfoservice.GetEntityById(intItemId);
                        leaderid = item.AssoLeaderId.SafeToString();
                    }
                    else //创建
                    {
                        string Query = "AssoName='" + TB_Title.Text + "'";
                        DataTable assolist = assoinfoservice.GetData(Query, null);
                        if (assolist != null && assolist.Rows.Count > 0)
                        {
                            this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "alert('创建社团失败，已存在同名社团！');", true);
                            return;
                        }
                        item.AssoStatus = "开放";
                    }
                    item.AssoName = TB_Title.Text;
                    item.AssoType = DDL_Type0.SelectedValue;
                    int selectId = int.Parse(DDL_Leader.SelectedItem.Value);
                    if (leaderid != selectId.SafeToString())
                    {
                        int intLeader = Convert.ToInt32(selectId);
                        item.AssoLeaderId = selectId;
                    }
                    //watch.Stop();
                    // com.writeLogMessage("收集数据：" + watch.ElapsedMilliseconds, "AddAssociaeMgr.Save");
                    //watch.Restart();
                    if (this.fimg_Asso.PostedFile.FileName != null && this.fimg_Asso.PostedFile.FileName.Trim() != "")//判断是否上传图片
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
                        if (!Directory.Exists("/UploadImgFile/AssoPic"))
                        {
                            Directory.CreateDirectory("/UploadImgFile/AssoPic");
                        }
                        string url = "/UploadImgFile/AssoPic/" + DateTime.Now.ToFileTime().ToString() + "." + photoExt;
                        string fullPath = Context.Server.MapPath(url);
                        hpimage.SaveAs(fullPath);

                        item.AssoPicURL = url; //为列表添加附件
                    }
                    item.CreateUserId = int.Parse(userid);
                    item.CreateTime = DateTime.Now;
                    bool result = false;
                    if (!string.IsNullOrEmpty(ViewState["itemid"].SafeToString()))//社团资料修改
                    {
                        result = assoinfoservice.Update(item);
                    }
                    else
                    {
                        result = assoinfoservice.Add(item);
                    }
                    //watch.Stop();
                    // com.writeLogMessage("保存图片：" + watch.ElapsedMilliseconds, "AddAssociaeMgr.Save");
                    // watch.Restart();
                    if (result && leaderid != selectId.SafeToString())//社团长添加到成员
                    {
                        string cQuery = "AssoName='" + TB_Title.Text + "'";
                        DataTable cassolist = assoinfoservice.GetData(cQuery, null);
                        if (cassolist.Rows.Count > 0)
                        {
                            string itemid = cassolist.Rows[0]["Id"].SafeToString("0");
                            AssoMemberService assomemservice = new AssoMemberService();
                            string Query = " AssoId=" + itemid + " and UserId=" + selectId;
                            DataTable mitems = assomemservice.GetData(Query, null);
                            if (mitems.Rows.Count == 0)//社团长不在成员列表
                            {
                                AssoMember memItem = new AssoMember();
                                memItem.UserId = item.AssoLeaderId;

                                memItem.AssoId = int.Parse(itemid);
                                //memItem["Title"] = TB_Title.Text;
                                bool mresult = assomemservice.Add(memItem);
                                script = "alert('添加成功！');";
                            }
                            //添加到团长历任
                            //SPList mgrsList = oWeb.Lists.TryGetList("社团历任");
                            //SPListItem mgrItem = mgrsList.AddItem();
                            //mgrItem["Title"] = item.ID;
                            //mgrItem["Leader"] = item["Leader"];
                            //mgrItem.Update();
                        }
                    }
                    // watch.Stop();
                    //com.writeLogMessage("查询成员：" + watch.ElapsedMilliseconds, "AddAssociaeMgr.Save");
                    #endregion
                }
                else { script = "alert('创建失败，请重试...');"; }
            }
            catch (Exception ex)
            {
                script = "alert('创建失败，请重试...');";
                ErrorLog.writeLogMessage(ex.Message, "AddAssociaeMgr.Btn_InfoSave_Click");
            }
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), script, true);
        }

        protected void Btn_Delete_Click(object sender, EventArgs e)
        {
            string script = "parent.window.location.href=parent.window.location.href;";
            try
            {


                #region 删除社团
                int intItemId = Convert.ToInt32(ViewState["itemid"]);
                //判断是否有社团成员外键引用
                AssoMemberService assomemservice = new AssoMemberService();
                string Query = " AssoId=" + intItemId;
                DataTable mitems = assomemservice.GetData(Query, null);
                if (mitems.Rows.Count != 0)//社团长不在成员列表
                {
                    foreach (DataRow mitem in mitems.Rows)
                    {
                        assomemservice.Delete(int.Parse(mitem["Id"].SafeToString("0")));
                    }
                }
                assoinfoservice.Delete(intItemId);
                #endregion

            }
            catch (Exception ex)
            {
                script = "alert('删除失败，请重试...')";
                ErrorLog.writeLogMessage(ex.Message, "AddAssociaeMgr.Btn_Delete_Click");
            }
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), script, true);
        }
    }
}
