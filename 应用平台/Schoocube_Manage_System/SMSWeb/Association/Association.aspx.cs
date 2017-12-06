using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSBLL;
using SMSModel;
using System.Text;
using SMSUtility;

namespace SMSWeb.Association
{
    public partial class Association : System.Web.UI.Page
    {
        private int[] MyAssociations { get; set; }
        private int[] LeaderIds { get; set; }
        public string UserId = "";
        public string username = "";
        public string role = "";
        public AssoInfoService assservice = new AssoInfoService();
        public UserInfoService assoUserService = new UserInfoService();
        public AssoMemberService assomemberService = new AssoMemberService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HttpCookie userId = Request.Cookies["UserId"];
                HttpCookie UserName = Request.Cookies["UserName"];
                if (userId != null)
                {
                    UserId = Request.Cookies["UserId"].Value.SafeToString();
                    userId.Expires = DateTime.Now.AddSeconds(10000);
                    Response.Cookies.Add(userId);
                }
                if (UserName != null)
                {
                    username = Request.Cookies["UserName"].Value.SafeToString();
                    UserName.Expires = DateTime.Now.AddSeconds(10000);

                    Response.Cookies.Add(UserName);
                }
                if (role == "管理教师")
                {
                    Response.Redirect("AssociationMgr.aspx");
                }
                else
                {
                    BindListView();
                    SBBindListView();
                    BindAllActivity(); //绑定全部活动选项卡处列表数据
                    if (!string.IsNullOrEmpty(UserId))
                    {
                        GetAssociaeIdByLeader();
                        if (this.LeaderIds != null && this.LeaderIds.Length > 0)
                        {
                            BindUnAudit(); //绑定未审核选项卡处列表数据
                            BindRefuse(); //绑定审核拒绝选项卡处列表数据
                        }
                    }
                }
            }
        }
        private void BindListView()
        {
            try
            {
                string[] arrs = new string[] { "ID", "Title", "Attachment" };
                DataTable dt = CreateDataTable(arrs);
                string where = "AssoStatus='开放'";
                DataTable assodt = assservice.GetData(where, "CreateTime desc");

                foreach (DataRow item in assodt.Rows)
                {
                    DataRow dr = dt.NewRow();
                    dr["ID"] = item["Id"];
                    dr["Title"] = item["AssoName"];
                    dr["Attachment"] = item["AssoPicURL"];
                    dt.Rows.Add(dr);
                }

                LV_TermList.DataSource = dt;
                LV_TermList.DataBind();
                if (dt.Rows.Count < DPTeacher.PageSize)
                {
                    this.DPTeacher.Visible = false;
                }

            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "Association.aspx_BindListView");
            }
        }
        private void SBBindListView()
        {
            try
            {
                string[] arrs = new string[] { "ID", "Title", "Attachment" };
                DataTable dt = CreateDataTable(arrs);
                DataTable assomemdt = assomemberService.GetData("UserId=" + UserId, null);
                #region 获取当前人所在社团

                List<int> ids = new List<int>();
                foreach (DataRow item in assomemdt.Rows)
                {
                    ids.Add(Convert.ToInt32(item["AssoId"]));
                }
                this.MyAssociations = ids.ToArray();
                #endregion
                #region 获取所在社团信息
                foreach (int assid in ids)
                {
                    AssoInfo asso = assservice.GetEntityById(assid);
                    DataRow dr = dt.NewRow();
                    dr["ID"] = asso.Id;
                    dr["Title"] = asso.AssoName;

                    dr["Attachment"] = asso.AssoPicURL;

                    dt.Rows.Add(dr);
                }
                #endregion

                SB_TermList.DataSource = dt;
                SB_TermList.DataBind();
                if (dt.Rows.Count < SBDPTeacher.PageSize)
                {
                    this.SBDPTeacher.Visible = false;
                }


            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "Association_SBBindListView");
            }
        }
        protected void LV_TermList_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            DPTeacher.SetPageProperties(DPTeacher.StartRowIndex, e.MaximumRows, false);
            BindListView();
        }

        #region 社团活动
        private void BindAllActivity()
        {
            try
            {

                string[] columnArr = { "ID", "Title", "AssoName", "inMembers", "noMembers" };
                DataTable dt = CreateDataTable(columnArr);
                AssoActivityService assoactivity = new AssoActivityService();

                string idsQuery = string.Empty;
                if (this.MyAssociations.Length > 0)
                {
                    
                    for (int i = 0; i < this.MyAssociations.Length; i++)
                    {
                        if (i == 0)
                        {
                            idsQuery = "AssoId=" + this.MyAssociations[i];
                        }
                        else
                        {

                            idsQuery += " or AssoId=" + this.MyAssociations[i];
                        }
                    }
                    //strQuery = string.Format(" {0} and " + idsQuery, strQuery);
                }
                DataTable qdt = assoactivity.GetData(idsQuery, " CreateTime desc");
                //spActiveCount.InnerHtml = "(" + items.Count + ")"; //为前台span控件赋值
                if (qdt != null)
                {
                    foreach (DataRow item in qdt.Rows)  //遍历列表项
                    {
                        DataRow row = dt.NewRow();
                        row["ID"] = item["Id"].ToString();
                        row["Title"] = item["ActivityTitle"].ToString();
                        row["AssoName"] = assservice.GetEntityById(Convert.ToInt32(item["AssoId"].ToString())).AssoName;
                        ActivityMemService activitymemservice = new ActivityMemService();
                        DataTable actimemdt = activitymemservice.GetData("ActivityId=" + item["Id"].ToString(), null);
                        List<string> inmemNames = new List<string>(); //参加活动的人
                        for (int i = 0; i < actimemdt.Rows.Count; i++)
                        {
                            UserInfo user = assoUserService.GetEntityById(int.Parse(actimemdt.Rows[i]["UserId"].SafeToString()));
                            inmemNames.Add(user.UserName);
                        }
                        //社团成员
                        AssoMemberService memberservice = new AssoMemberService();
                        DataTable memberdt = memberservice.GetData(" AssoId=" + item["AssoId"], null);

                        List<string> memberNames = new List<string>(); //社团内全部成员
                        foreach (DataRow mitem in memberdt.Rows)
                        {
                            string uid = mitem["UserId"].ToString();
                            UserInfo userdt = assoUserService.GetEntityById(int.Parse(uid));

                            memberNames.Add(userdt.UserName);

                        }
                        List<string> nomenNames = memberNames.Except(inmemNames).ToList();//未参加活动的人
                        string inNamesStr = string.Join("  ", inmemNames.ToArray());
                        string noNamesStr = string.Join("  ", nomenNames.ToArray());
                        string inmemWords = "<span style='color:#28a907'>( " + inmemNames.Count + "个人 )</span> " + inNamesStr;
                        if (inNamesStr.Length > 45)
                        {
                            inmemWords = "<div class='expandheight dlHeight'>" + inmemWords + "<i class='more'>展开</i></div>";
                        }
                        row["inMembers"] = inmemNames.Count == 0 ? "暂无" : inmemWords;
                        string nomenWords = "<span style='color:#ed0908'>( " + nomenNames.Count + "个人 )</span> " + noNamesStr;
                        if (noNamesStr.Length > 45)
                        {
                            nomenWords = "<div class='expandheight dlHeight'>" + nomenWords + "<i class='more'>展开</i></div>";
                        }
                        row["noMembers"] = nomenNames.Count == 0 ? "无" : nomenWords;
                        dt.Rows.Add(row);
                    }
                }
                lvAllActivity.DataSource = dt;
                lvAllActivity.DataBind();
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "Association.ascx_BindAllActivity");
            }
        }
        protected void lvAllActivity_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            ActivityPager.SetPageProperties(ActivityPager.StartRowIndex, e.MaximumRows, false);
            BindAllActivity();
        }
        #endregion

        #region 入退团申请
        //待审核
        private void BindUnAudit()
        {
            TempListView.DataSource = this.GetApplyData("待审核");
            TempListView.DataBind();
        }
        protected void TempListView_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            DPApply.SetPageProperties(DPApply.StartRowIndex, e.MaximumRows, false);
            BindUnAudit();
        }
        //审核拒绝
        private void BindRefuse()
        {
            LV_RefuseApply.DataSource = this.GetApplyData("审核拒绝");
            LV_RefuseApply.DataBind();
        }
        protected void LV_RefuseApply_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            DP_RefuseApply.SetPageProperties(DP_RefuseApply.StartRowIndex, e.MaximumRows, false);
            BindRefuse();
        }

        private DataTable GetApplyData(string status)
        {
            DataTable dt = new DataTable();
            string[] arrs = new string[] { "ID", "Type", "Title", "Name", "Sex", "Class", "Created" };
            foreach (string column in arrs)
            {
                dt.Columns.Add(column);
            }
            try
            {

                StringBuilder sbCAML = new StringBuilder();
                string strQuery = string.Format("ApplyStatus ='" + status + "'");
                if (this.LeaderIds.Length > 0)
                {
                    string idsQuery = string.Empty;
                    for (int i = 0; i < LeaderIds.Length; i++)
                    {
                        if (i == 0)
                        {
                            idsQuery = "AssoId = '" + LeaderIds[i] + "'";
                        }
                        else
                        {
                            idsQuery = string.Format("{0} or {1}", "AssoId =" + LeaderIds[i], idsQuery);
                        }
                    }
                    strQuery = string.Format("{0} and (" + idsQuery + ")", strQuery);
                }
                AssoApplyService applicationservice = new AssoApplyService();
                DataTable applicationdt = applicationservice.GetData(strQuery, " ApplyTime desc");
                UserInfoService assouserservice = new UserInfoService();
                AssoInfoService assoser = new AssoInfoService();


                foreach (DataRow item in applicationdt.Rows)
                {
                    DataRow dr = dt.NewRow();
                    dr["ID"] = item["Id"];
                    dr["Title"] = assoser.GetEntityById(Convert.ToInt32(item["AssoId"])).AssoName;
                    dr["Type"] = item["ApplyType"].SafeToString() == "1" ? "入团申请" : "退团申请";
                    dr["Created"] = item["ApplyTime"];

                    if (item["ApplyUserId"] != null && !string.IsNullOrEmpty(item["ApplyUserId"].ToString()))
                    {
                        int userId = Convert.ToInt32(item["ApplyUserId"].ToString());

                        UserInfo user = assouserservice.GetEntityById(userId);
                        dr["Name"] = user.UserName;

                        dr["Sex"] = user.Sex;
                        //dr["Age"] = dtInfo.Rows[0]["Age"].SafeToString();
                        // dr["Class"] = dtInfo.Rows[0]["Class"].SafeToString();

                    }
                    dt.Rows.Add(dr);
                }

            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "Association_GetApplyData_" + status);
            }
            return dt;
        }
        #endregion
        #region
        private void GetAssociaeIdByLeader()
        {
            List<int> ids = new List<int>();
            try
            {

                DataTable dt = assservice.GetData(" AssoLeaderId = " + UserId + " or AssoLeaderSecondId =" + UserId, null);

                foreach (DataRow item in dt.Rows)
                {
                    ids.Add(int.Parse(item["Id"].ToString()));

                }
                this.LeaderIds = ids.ToArray();

            }
            catch (Exception ex)
            {
                //com.writeLogMessage(ex.Message, "TA_wp_Association_GetAssociaeId");
            }
        }
        #endregion
        //创建新表
        private DataTable CreateDataTable(string[] columnArr)
        {
            DataTable dt = new DataTable();
            foreach (string colmunName in columnArr)
            {
                dt.Columns.Add(colmunName);
            }
            return dt;
        }
    }
}
