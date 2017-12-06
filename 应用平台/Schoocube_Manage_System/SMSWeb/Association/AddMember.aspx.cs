using SMSBLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSUtility;
using SMSModel;

namespace SMSWeb.Association
{
    public partial class AddMember : System.Web.UI.Page
    {
        //LogCommon com = new LogCommon();
        public RoleService roleservice = new RoleService();
        public AssoMemberService memeberservice = new AssoMemberService();
        public string userid { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string itemId = Request.QueryString["itemid"];
                if (!string.IsNullOrEmpty(itemId))
                {
                    HttpCookie userId = Request.Cookies["UserId"];
                    if (userId != null)
                    {
                        userid = Request.Cookies["UserId"].Value.SafeToString();
                        userId.Expires = DateTime.Now.AddSeconds(10000);
                        Response.Cookies.Add(userId);
                    }
                    ViewState["itemid"] = itemId;
                    BindType();
                    btnSearch_Click(null, null);
                }
            }
        }


        private void BindType()
        {
            try
            {

                DataTable roledt = roleservice.GetData(null, null);
                this.DDL_Type.Items.Add(new ListItem("-请选择-", "0"));
                foreach (DataRow role in roledt.Rows)
                {
                    DDL_Type.Items.Add(new ListItem(role["RoleName"].SafeToString(), role["Id"].SafeToString()));
                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "AddMember.DDL_Type_SelectedIndexChanged");
            }
        }

        protected void lvRow_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            DataPager.SetPageProperties(DataPager.StartRowIndex, e.MaximumRows, false);
            this.btnSearch_Click(null, null);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {

                DataTable data = new DataTable();
                UserInfoService userservice = new UserInfoService();
                RoleUserService roleuserservcie = new RoleUserService();
                string rquery = "1=1";
                string uquery = "1=1";
             
                if (!string.IsNullOrEmpty(this.Tb_searchTitle.Text.Trim()))
                {
                    uquery += " and UserName like '%" + this.Tb_searchTitle.Text.Trim() + "%'";
                }
                DataTable roleudata = roleuserservcie.GetData(rquery, null);
                data = userservice.GetData(uquery, null);

                DataTable dtReturn = new DataTable();
                string[] arrs = new string[] { "ID", "Name", "Role", "IsCun" };// "Sex", 
                foreach (string colmunName in arrs)
                {
                    dtReturn.Columns.Add(colmunName);
                }
                string itemid = ViewState["itemid"].SafeToString();
                DataTable memberdt = memeberservice.GetData("AssoId=" + itemid, null);
                string memberstring = ",";
                foreach (DataRow mitem in memberdt.Rows)
                {
                    memberstring += mitem["UserId"] + ",";
                }
                memberstring += ",";
                foreach (DataRow dr in data.Rows)
                {
                    rquery = "UserId=" + dr["ID"];
                    bool isneed = true;
                    string rolename = "";
                        DataTable croleudata = roleuserservcie.GetData(rquery, null); 
                    //角色判断
                    if (this.DDL_Type.SelectedValue != "0")
                    {
                        isneed = false; 
                        foreach (DataRow croleu in croleudata.Rows)
                        {
                            if (croleu["RoleId"].SafeToString().Equals(this.DDL_Type.SelectedValue))
                            {
                                isneed = true;
                                break;
                            }
                        }
                    }
                    if (isneed)
                    {
                        DataRow row = dtReturn.NewRow();
                        row["ID"] = dr["ID"];
                        row["Name"] = dr["UserName"];
                        row["IsCun"] = "";
                        foreach (DataRow croleu in croleudata.Rows)
                        { 
                            Role crole = roleservice.GetEntityById(int.Parse(croleu["RoleId"].SafeToString("0")));
                            rolename += crole.RoleName+",";
                        }
                        row["Role"] = rolename.TrimEnd(',');
                        if (memberstring.Contains("," + dr["ID"] + ","))
                        {
                            row["IsCun"] = "checked='checked'";
                        }
                        dtReturn.Rows.Add(row);
                    }

                }
                this.lvRow.DataSource = dtReturn;
                this.lvRow.DataBind();

            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "AddMember.btnSearch_Click");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string script = "parent.window.location.href=parent.window.location.href;";
            try
            {
                if (!string.IsNullOrEmpty(this.MemberID.Value))
                {
                    int associaeID = Convert.ToInt32(ViewState["itemid"]);
                    AssoInfoService assoservice = new AssoInfoService();
                    AssoMemberDelService memberdelservice = new AssoMemberDelService();



                    string[] mids = this.MemberID.Value.Split(',');
                    foreach (string mid in mids)
                    {
                        if (mid != "")
                        {
                            //根据loginname找user
                            //SPClaimProviderManager cpm = SPClaimProviderManager.Local;
                            //SPClaim userClaim = cpm.ConvertIdentifierToClaim("bjyqyz\\" + login, SPIdentifierTypes.WindowsSamAccountName);
                            //userClaim.ToEncodedString()

                            string Query = "AssoId=" + associaeID + "and UserId=" + mid;
                            DataTable mitems = memeberservice.GetData(Query, null);
                            if (mitems.Rows.Count == 0)
                            {
                                AssoMember memItem = new AssoMember();
                                memItem.UserId = int.Parse(mid);
                                memItem.AssoId = associaeID;
                                memeberservice.Add(memItem);
                            }
                            else {
                                AssoMemberDel memdelitem = new AssoMemberDel();
                                memdelitem.UserId = int.Parse(mid);
                                memdelitem.AssoId = associaeID;
                                memdelitem.CreateUserId = int.Parse( userid);
                                memdelitem.CreatedTime = DateTime.Now;
                                memberdelservice.Add(memdelitem);
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                script = "alert('成员保存失败，请稍后重试...')";
                ErrorLog.writeLogMessage(ex.Message, "AddMember.btnSave_Click");
            }
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), script, true);
        }
    }
}