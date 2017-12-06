using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSBLL;
using SMSModel;
using SMSUtility;
using System.Data;
using System.IO;
using System.Text;

namespace SMSWeb.Association
{
    public partial class ActivityShow : System.Web.UI.Page
    {
        // LogCommon com = new LogCommon();
        private AssoActivityService activityservice = new AssoActivityService();
        public UserInfoService assoUserService = new UserInfoService();
        public ActivityMemService memservice = new ActivityMemService();
        public string Userid { get { return ViewState["userid"].SafeToString(); } set { ViewState["userid"] = value; } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HttpCookie userId = Request.Cookies["UserId"];
                if (userId != null)
                {
                    Userid = Request.Cookies["UserId"].Value.SafeToString();
                    userId.Expires = DateTime.Now.AddSeconds(10000);
                    Response.Cookies.Add(userId);
                }
                string itemId = Request.QueryString["itemid"];
                if (!string.IsNullOrEmpty(itemId))
                {
                    ViewState["itemid"] = itemId;
                    BindAssociaeData(itemId);
                    BindMember(itemId);
                }
            }
        }
        private void BindAssociaeData(string Aid)
        {
            try
            {
                int itemId = Convert.ToInt32(Aid);

                AssoActivity item = activityservice.GetEntityById(itemId);

                this.img_Pic.Src = string.IsNullOrEmpty(item.ActivityImg) ? @"../Stu_images/nopic.png" : item.ActivityImg;


                this.Lit_Title.Text = item.ActivityTitle;
                this.Lit_Date.Text = item.StartTime.SafeToDataTime() + "至" + item.EndTime.SafeToDataTime();
                this.Lit_Address.Text = item.ActivityAddress;
                this.Lit_Content.Text = item.ActivityContent;
                if (DateTime.Now > item.EndTime)
                {
                    this.Join.Text = "已结束报名";
                    this.Join.Enabled = false;
                }
                //活动资料
                ActivityDataService adataservice = new ActivityDataService();
                DataTable adatadt = adataservice.GetData("ActivityId=" + item.Id, null);
                StringBuilder sbFile = new StringBuilder();
                sbFile.Append("暂无活动资料！");
                if (adatadt != null)
                {
                    sbFile = new StringBuilder();
                    foreach (DataRow data in adatadt.Rows)
                    {
                        string filename = data["DataTitle"].SafeToString();
                        sbFile.Append("<a target='_blank' style='color:blue' href='" + data["DataUrl"].SafeToString() + "'>");
                        sbFile.Append(filename);
                        sbFile.Append("</a>&nbsp;&nbsp;");
                    }
                }
                this.Lit_Attachment.Text = sbFile.SafeToString();

            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "ActivityShow.aspx_绑定社团活动信息");
            }
        }

        private void BindMember(string Aid)
        {
            try
            {

                DataTable items = memservice.GetData("ActivityId=" + Aid, null);

                DataTable dt = new DataTable();
                dt.Columns.Add("U_Pic");
                dt.Columns.Add("Name");
                if (items.Rows.Count > 0)
                {
                    for (int i = 0; i < items.Rows.Count; i = i + 2)
                    {
                        int cuserId = Convert.ToInt32(items.Rows[i]["UserId"].SafeToString());
                        UserInfo user = assoUserService.GetEntityById(cuserId);
                        DataRow dr = dt.NewRow();
                        dr["U_Pic"] = string.IsNullOrEmpty(user.ImgUrl) ? "/images/student.jpg" : user.ImgUrl;
                        dr["Name"] = user.UserName;
                        dt.Rows.Add(dr);

                        if (user.Id.SafeToString() == Userid)
                        {
                            this.Join.Text = "已参加";
                            this.Join.Enabled = false;
                        }
                    }
                }
                this.Lit_Count.Text = dt.Rows.Count.ToString();
                LV_TermList.DataSource = dt;
                LV_TermList.DataBind();

            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "ActivityShow_BindMember");
            }
        }

        protected void Join_Click(object sender, EventArgs e)
        {
            string script = "alert('报名成功');";
            try
            {
                string itemId = ViewState["itemid"].ToString();
                if (!string.IsNullOrEmpty(Userid) && !string.IsNullOrEmpty(itemId))
                {
                    ActivityMem newmem = new ActivityMem();
                    newmem.ActivityId = int.Parse(itemId);
                    newmem.UserId = int.Parse(Userid);
                    memservice.Add(newmem);
                    BindMember(itemId);
                }
            }
            catch (Exception ex)
            {
                script = "alert('报名失败，请重试...')";
                ErrorLog.writeLogMessage(ex.Message, "ActivityShow_Join_Click");
            }
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), script, true);
        }
    }
}
