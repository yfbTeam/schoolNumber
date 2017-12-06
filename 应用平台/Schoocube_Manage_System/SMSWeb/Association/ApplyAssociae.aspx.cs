using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSBLL;
using SMSUtility;
using SMSModel;
using System.Data;

namespace SMSWeb.Association
{
    public partial class ApplyAssociae : System.Web.UI.Page
    {
        //LogCommon com = new LogCommon();
        public AssoApplyService assoapplyservice = new AssoApplyService();
        public AssoInfoService assoservice = new AssoInfoService();
        protected void Page_Load(object sender, EventArgs e)
        {
            UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                string itemId = Request.QueryString["itemid"];
                if (!string.IsNullOrEmpty(itemId))
                {
                    this.A_Id.Value = itemId;
                    if (Request.QueryString["flag"].SafeToString() == "1")
                    {
                        this.Lit_ConWord.Text = "退团原因：";
                        this.Btn_InfoSave.Text = "确认退团";
                    }
                    BindFormData(Convert.ToInt32(itemId));
                }
            }
        }
        private void BindFormData(int itemId)
        {
            try
            {

                AssoInfo item = assoservice.GetEntityById(itemId);
                this.Lit_Title.Text = item.AssoName;
                this.Lit_Slogans.Text = item.AssoSlogan;

                this.A_Pic.ImageUrl = item.AssoPicURL;



            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "ApplyAssociae.aspx");
            }
        }

        protected void Btn_InfoSave_Click(object sender, EventArgs e)
        {
            string script = "alert('申请成功，请等待审批...');parent.closePages();";
            try
            {
                if (Request.Cookies["UserId"] != null)
                {
                    bool isQuit = Request.QueryString["flag"].SafeToString() == "1";
                    bool ckadd = true;
                    string userid = Request.Cookies["UserId"].Value;
                    if (isQuit)
                    {
                        //判断报名权限（人数上限、性别、年级）
                        AssoInfoService assoservice = new AssoInfoService();
                        AssoInfo asso = assoservice.GetEntityById(int.Parse(this.A_Id.Value));
                        AssoMemberService memberservice = new AssoMemberService();
                        DataTable mdt = memberservice.GetData(" AssoId=" + this.A_Id.Value, null);
                        UserInfoService userservice = new UserInfoService();
                        UserInfo user = userservice.GetEntityById(int.Parse(userid));
                        AssoMemberDelService memberdservice = new AssoMemberDelService();
                       DataTable mddt= memberdservice.GetData("AssoId=" + this.A_Id.Value + " and UserId=" + userid, null);
                       if (mddt.Rows.Count > 0) {
                           ckadd = false;
                           script = "alert('申请失败，你暂时不符合要求！')";
                       }
                        if (asso.SexLimit != null && asso.SexLimit != user.Sex)
                        {
                            ckadd = false;
                            script = "alert('申请失败，性别不符合要求！')";
                        }
                        if (asso.GradeLimit != null)
                        {
                            int gradeLimit = int.Parse(asso.GradeLimit.ToString());
                            GradeClassService gradeservice = new GradeClassService();
                            DataTable gclassdt = gradeservice.GetData(" id=" + gradeLimit + " or pid=" + gradeLimit, null);
                            foreach (DataRow item in gclassdt.Rows)
                            {
                                if (item["Pid"].SafeToString() == "0")
                                {
                                    if (gradeLimit != user.ClassId)
                                    {
                                        ckadd = false;
                                        script = "alert('申请失败，年级不符合要求！')";
                                    }

                                }
                                else {
                                    if (item["Id"].SafeToString() != user.ClassId.SafeToString())
                                    {
                                        ckadd = false;
                                        script = "alert('申请失败，年级不符合要求！')";
                                    }
                                }
                            }

                        }
                        if (mdt != null && asso.PersonLimit > mdt.Rows.Count)
                        {
                            ckadd = false;
                            script = "alert('申请失败，人员已满！')";
                        }
                    }
                    if (ckadd)
                    {

                        string type = isQuit ? "退团申请" : "入团申请";
                        AssoApply item = new AssoApply();
                        item.AssoId = int.Parse(this.A_Id.Value);
                        item.Introduce = TB_Content.Text;
                        item.ApplyUserId = int.Parse(userid);
                        item.ApplyStatus = "待审核";
                        item.ApplyType = type;
                        item.ApplyTime = DateTime.Now;
                        item.ApplySuggest = TB_Content.Text;

                        bool result = assoapplyservice.Add(item);

                    }
                   
                }

            }
            catch (Exception ex)
            {
                script = "alert('操作失败，请重试...')";
                ErrorLog.writeLogMessage(ex.Message, "ApplyAssociae.aspx");
            }
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), script, true);
        }
    }
}
