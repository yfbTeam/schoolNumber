using SMSBLL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Association
{
    public partial class AssociationMgr : System.Web.UI.Page
    {
        //LogCommon com = new LogCommon();
        public AssoInfoService assservice = new AssoInfoService();
        public AssoMemberService assomemService = new AssoMemberService();
        public UserInfoService assoUserService = new UserInfoService();
        public AssoActivityService assoactivityService = new AssoActivityService();
        Stopwatch watch = new Stopwatch();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //BindAssociae();//绑定全部社团
                //BindAllActivity(); //绑定全部活动选项卡处列表数据
                //BindApplyListView();//待审核活动审核
                //BindRefuseApplyListView();//审核拒绝活动审核
                BindTop();//绑定上次开放报名时间
                BindAssociae();//绑定全部社团
            }
        }
        private void BindTop()
        {
            //watch.Restart();
            //try
            //{
            //    SPListItemCollection items = SignList.GetItems(new SPQuery()
            //    {
            //        Query = @"<OrderBy><FieldRef Name='Created' Ascending='False' /></OrderBy>",
            //        RowLimit = 1
            //    });
            //    if (items != null && items.Count > 0)
            //    {
            //        this.dtStartDate.Value = items[0]["StartDate"].SafeToDataTime();
            //        this.dtEndDate.Value = items[0]["EndDate"].SafeToDataTime();
            //    }
            //}
            //catch (Exception ex)
            //{
            //    //com.writeLogMessage(ex.Message, "AssociationMgr.BindTop");
            //}
            //watch.Stop();
            //com.writeLogMessage(watch.ElapsedMilliseconds.ToString(), "AssociationMgr.BindTop");
        }
        private void BindAssociae()
        {
            try
            {
                DataTable dt = new DataTable();
                string[] arrs = new string[] { "ID", "Title", "Attachment" };
                foreach (string colmunName in arrs)
                {
                    dt.Columns.Add(colmunName);
                }
                string where = "AssoStatus='开放'";
                DataTable items = assservice.GetData(where, "CreateTime desc");

                foreach (DataRow item in items.Rows)
                {
                    DataRow dr = dt.NewRow();
                    dr["ID"] = item["Id"];
                    dr["Title"] = item["AssoName"];
                    dr["Attachment"] = item["AssoPicURL"];
                    dt.Rows.Add(dr);
                    //this.DDL_Associae.Items.Add(new ListItem(item["AssoName"].ToString(), item["Id"].SafeToString()));
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
                ErrorLog.writeLogMessage(ex.Message, "AssociationMgr.BindAssociae");
            }
        }
        //private void BindAllActivity()
        //{
        //    DataTable dt = new DataTable();
        //    string[] arrs = new string[] { "ID", "Title", "AssoName", "inMembers", "noMembers" };
        //    foreach (string colmunName in arrs)
        //    {
        //        dt.Columns.Add(colmunName);
        //    }
        //    try
        //    {
        //        string whereQuery = "AssociaeID=" + this.DDL_Associae.SelectedValue + " and ExamineStatus='审核通过'";
        //        if (!string.IsNullOrEmpty(this.Tb_searchTitle.Text.Trim()))
        //        {
        //            whereQuery = "<And><Contains><FieldRef Name='Title' /><Value Type='Text'>" + this.Tb_searchTitle.Text.Trim() + "</Value></Contains>" + whereQuery + "</And>";
        //        }
        //        DataTable items = assoactivityService.GetData(whereQuery, " StartTime desc");

        //        foreach (DataRow item in items.Rows)  //遍历列表项
        //        {
        //            DataRow row = dt.NewRow();
        //            row["ID"] = item["Id"].ToString();
        //            row["Title"] = item["ActivityTitle"].ToString();
        //            row["AssoName"] = this.DDL_Associae.SelectedItem.Text;
        //            List<string> inmemNames = new List<string>(); //参加活动的人
        //            string members = item["AssociaeMember"].SafeToString();
        //            if (members != null)
        //            {
        //                foreach (string userid in members.Split(','))
        //                {
        //                    UserInfo user = assoUserService.GetEntityById(int.Parse(userid));
        //                    inmemNames.Add(user.UserName);
        //                }
        //            }
        //            string Query = " AssoId=" + this.DDL_Associae.SelectedValue;
        //            DataTable memitems = assomemService.GetData(Query, null);
        //            List<string> memberNames = new List<string>(); //社团内全部成员
        //            foreach (DataRow mitem in memitems.Rows)
        //            {
        //                UserInfo user = assoUserService.GetEntityById(int.Parse(mitem["UserId"].SafeToString()));
        //                inmemNames.Add(user.UserName);
        //            }
        //            List<string> nomenNames = memberNames.Except(inmemNames).ToList();//未参加活动的人
        //            string inNamesStr = string.Join("  ", inmemNames.ToArray());
        //            string noNamesStr = string.Join("  ", nomenNames.ToArray());
        //            string inmemWords = "<span style='color:#28a907'>( " + inmemNames.Count + "个人 )</span> " + inNamesStr;
        //            if (inNamesStr.Length > 45)
        //            {
        //                inmemWords = "<div class='expandheight dlHeight'>" + inmemWords + "<i class='more'>展开</i></div>";
        //            }
        //            row["inMembers"] = inmemNames.Count == 0 ? "暂无" : inmemWords;
        //            string nomenWords = "<span style='color:#ed0908'>( " + nomenNames.Count + "个人 )</span> " + noNamesStr;
        //            if (noNamesStr.Length > 45)
        //            {
        //                nomenWords = "<div class='expandheight dlHeight'>" + nomenWords + "<i class='more'>展开</i></div>";
        //            }
        //            row["noMembers"] = nomenNames.Count == 0 ? "无" : nomenWords;
        //            dt.Rows.Add(row);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        // com.writeLogMessage(ex.Message, "AssociationMgr.BindAllActivity");
        //    }
        //    lvAllActivity.DataSource = dt;
        //    lvAllActivity.DataBind();
        //}
        //private void BindApplyListView()
        //{
        //    DataTable dt = this.GetApplyData("待审核");
        //    this.TempListView.DataSource = dt;
        //    this.TempListView.DataBind();
        //}
        //private void BindRefuseApplyListView()
        //{
        //    DataTable dt = this.GetApplyData("审核拒绝");
        //    this.LV_RefuseApply.DataSource = dt;
        //    this.LV_RefuseApply.DataBind();
        //}
        //private DataTable GetApplyData(string status)
        //{
        //    DataTable dt = new DataTable();
        //    string[] arrs = new string[] { "ID", "Title", "Associae", "StartTime", "EndTime", "Address", "Created" };
        //    foreach (string column in arrs)
        //    {
        //        dt.Columns.Add(column);
        //    }
        //    try
        //    {
        //        StringBuilder sbCAML = new StringBuilder();
        //        string strQuery = "ID !=0";
        //        strQuery = string.Format("{0}", " and Auditstatus =" + status, strQuery);
        //        AssoApplyService applicationservice = new AssoApplyService();
        //        DataTable applicationdt = assoactivityService.GetData(strQuery, " ApplyTime desc");
        //        foreach (DataRow item in applicationdt.Rows)
        //        {
        //            DataRow dr = dt.NewRow();
        //            dr["ID"] = item["Id"];
        //            dr["Title"] = item["ActivityTitle"];
        //            dr["Type"] = item["ApplyType"];
        //            dr["StartTime"] = item["StartTime"].SafeToDataTime();
        //            dr["EndTime"] = item["EndTime"].SafeToDataTime();
        //            dr["Address"] = item["ActivityAddress"];
        //            //  dr["Created"] = item["CreateUserId"].SafeToDataTime();
        //            if (item["CreateUserId"] != null && !string.IsNullOrEmpty(item["CreateUserId"].ToString()))
        //            {
        //                int userId = Convert.ToInt32(item["CreateUserId"].ToString());
        //                UserInfoService assouserservice = new UserInfoService();
        //                UserInfo user = assouserservice.GetEntityById(userId);
        //                dr["Created"] = user.UserName;
        //            }
        //            dr["Associae"] = assservice.GetEntityById(Convert.ToInt32(item["AssoId"])).AssoName;
        //            dt.Rows.Add(dr);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        //com.writeLogMessage(ex.Message, "AssociationMgr.GetApplyData" + status);
        //    }
        //    return dt;
        //}
        protected void LV_TermList_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            DPTeacher.SetPageProperties(DPTeacher.StartRowIndex, e.MaximumRows, false);
            BindAssociae();
        }
        //protected void lvAllActivity_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        //{
        //    ActivityPager.SetPageProperties(ActivityPager.StartRowIndex, e.MaximumRows, false);
        //    BindAllActivity();
        //}
        //protected void Btn_Search_Click(object sender, EventArgs e)
        //{
        //    BindAllActivity();
        //}

        //protected void TempListView_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        //{
        //    DPApply.SetPageProperties(DPApply.StartRowIndex, e.MaximumRows, false);
        //    BindApplyListView();
        //}

        //protected void LV_RefuseApply_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        //{
        //    DP_RefuseApply.SetPageProperties(DP_RefuseApply.StartRowIndex, e.MaximumRows, false);
        //    BindRefuseApplyListView();
        //}

        //protected void Sign_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        //社团开放报名
        //        SPList sign = oWeb.Lists.TryGetList("社团报名");
        //        SPListItem signItem = sign.AddItem();
        //        signItem["Title"] = SPContext.Current.Web.CurrentUser.Name + "开放社团报名";
        //        signItem["StartDate"] = dtStartDate.Value;
        //        signItem["EndDate"] = dtEndDate.Value;
        //        signItem.Update();

        //    }
        //    catch (Exception ex)
        //    {
        //        com.writeLogMessage(ex.Message, "AssociationMgr.Sign_Click");
        //    }
        //    this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "alert('设置成功！')", true);
        //}
    }
}