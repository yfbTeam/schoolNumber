using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSUtility;
using SMSModel;
using SMSBLL;
using System.Data;

namespace SMSWeb.Association
{
    public partial class ApplyQuitAuditing : System.Web.UI.Page
    {
        //LogCommon com = new LogCommon();
        public AssoApplyService applyservice = new AssoApplyService();
        public AssoMemberService memeberservice = new AssoMemberService();
        public static string Userid { get; set; }
        public static string UserName { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                HttpCookie userId = Request.Cookies["UserId"];
                HttpCookie userName = Request.Cookies["UserName"];
                if (userId != null)
                {
                    Userid = Request.Cookies["UserId"].Value.SafeToString();
                    userId.Expires = DateTime.Now.AddSeconds(10000);
                    Response.Cookies.Add(userId);
                }
                if (userName != null)
                {
                    UserName = Request.Cookies["UserName"].Value.SafeToString();
                    userName.Expires = DateTime.Now.AddSeconds(10000);
                    Response.Cookies.Add(userName);
                }
                string itemId = Request.QueryString["itemid"];
                string flag = Request.QueryString["flag"];
                if (!string.IsNullOrEmpty(itemId))
                {
                    ViewState["itemid"] = itemId;
                    BindAuditingData(Convert.ToInt32(itemId));
                    if (flag == "0")
                    {
                        this.Btn_Sure.Visible = false;
                        this.txtExamineSuggest.ReadOnly = true;
                        this.RB_Pass.Visible = false;
                        this.RB_Refuse.Visible = false;
                        this.lbStatus.Visible = true;
                    }
                }
            }
        }
        private void BindAuditingData(int itemId)
        {
            try
            {

                AssoApply item = applyservice.GetEntityById(itemId);
                this.lbDate.Text = item.ApplyTime.SafeToDataTime();
                this.lbContent.Text = item.Introduce;
                //this.txtExamineSuggest.Text = item.ApplySuggest;
                this.lbStatus.Text = item.ApplyStatus;
                string applyUser = item.ApplyUserId.SafeToString();
                if (!string.IsNullOrEmpty(applyUser))
                {
                    int userId = Convert.ToInt32(applyUser);
                    UserInfo user = new UserInfoService().GetEntityById(userId);
                    if (user != null)
                    {
                        this.lbName.Text = user.UserName;
                    }
                }
                string flag = Request.QueryString["flag"];
                if (flag == "0")
                {
                    object examer = item.ExamUserId;
                    if (examer != null)
                    {
                        int userId = Convert.ToInt32(applyUser);
                        UserInfo user = new UserInfoService().GetEntityById(userId);
                        if (user != null)
                        {
                            this.lbExamer.Text = user.UserName;
                        }
                    }
                }
                else
                {
                    this.lbExamer.Text = UserName;
                }

            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "ApplyQuitAuditing.aspx");
            }
        }

        protected void Btn_Sure_Click(object sender, EventArgs e)
        {
            string script = "parent.window.location.href=parent.window.location.href;";
            try
            {
                AssoApply item = applyservice.GetEntityById(Convert.ToInt32(ViewState["itemid"]));



                string status = RB_Pass.Checked ? "审核通过" : "审核拒绝";
                item.ApplyStatus = status;
                item.ExamUserId = int.Parse(Userid);
                item.ApplySuggest = this.txtExamineSuggest.Text.Trim();
                applyservice.Update(item);
                //添加社团成员

                string associaeID = item.AssoId.SafeToString();
                if (status == "审核通过")
                {
                    string Query = @"AssoId=" + associaeID + @" and UserId=" + item.ApplyUserId;

                    DataTable memItems = memeberservice.GetData(Query, null);
                    string type = item.ApplyType.SafeToString();
                    if (type == "1" && memItems.Rows.Count == 0)  //入团申请审核通过时，若在"社团成员"列表内未找到等于社团id和申请人姓名的项目，则添加新项目
                    {
                        AssoMember memItem = new AssoMember();
                        memItem.UserId = item.ApplyUserId;
                        memItem.AssoId = item.AssoId;
                        memeberservice.Add(memItem);

                    }
                    if (type == "2" && memItems != null && memItems.Rows.Count > 0)//退团申请审核通过时，根据社团id和申请人姓名找到"社团成员"中申请退团学生的项目，并删除。
                    {
                        memeberservice.Delete(int.Parse(ViewState["itemid"].SafeToString()));
                    }
                }

            }
            catch (Exception ex)
            {
                script = "alert('审核失败')";
                ErrorLog.writeLogMessage(ex.Message, "ApplyQuitAuditing_Btn_Sure_Click");
            }
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), script, true);
        }
    }
}
