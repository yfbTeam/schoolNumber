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
    public partial class AssociaeList : System.Web.UI.Page
    {
        // LogCommon com = new LogCommon();
        public string newCol { get; set; }
        public AssoInfoService assoservice = new AssoInfoService();
        public AssoNewsService newservice = new AssoNewsService();
        public AssoActivityService activityservcie = new AssoActivityService();
        public ActivityDataService dataservice = new ActivityDataService();
        public UserInfoService userservice = new UserInfoService();
        //private SPList AssociaeList { get { return ListHelp.GetCureenWebList("社团信息", false); } }
        //private SPList NewsList { get { return ListHelp.GetCureenWebList("社团资讯", false); } }
        //private SPList ActivityList { get { return ListHelp.GetCureenWebList("社团活动", false); } }
        //private SPList DocList { get { return ListHelp.GetCureenWebList("活动资料", false); } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string type = Request.QueryString["type"];
                this.GetCurrentListAndSetColumn(type);
                this.btnSearch_Click(null, null);
            }
        }
        private void GetCurrentListAndSetColumn(string type)
        {
            try
            {
                //设置当前用到的列表
                string[] fieldarr = null;
                switch (type)
                {
                    case "news":
                        this.lb_Title.Text = "社团资讯";
                        fieldarr = new string[] { "标题", "社团名", "发布者", "发布时间" };
                        break;
                    case "doc":
                        this.lb_Title.Text = "活动资料";
                        fieldarr = new string[] { "资料名", "活动名", "社团名", "上传者", "上传时间" };
                        break;
                }
                //设置显示的字段
                DataTable dtCol = new DataTable();
                dtCol.Columns.Add("Title");
                foreach (string str in fieldarr)
                {
                    dtCol.Rows.Add(str);
                }
                this.lvColumn.DataSource = dtCol;
                this.lvColumn.DataBind();
                //获取所有社团
                this.DDL_Associae.Items.Add(new ListItem("不限", ""));
                string Query = "AssoStatus='开放'";
                DataTable items = assoservice.GetData(Query, null);
                foreach (DataRow item in items.Rows)
                {
                    this.DDL_Associae.Items.Add(new ListItem(item["AssoName"].SafeToString(), item["ID"].SafeToString()));
                }
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog("AssociaeList.GetCurrentListAndSetColumn|||" + ex.Message);
                ErrorLog.writeLogMessage(ex.Message, "AssociaeList.GetCurrentListAndSetColumn");
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                string type = Request.QueryString["type"];
                switch (type)
                {
                    case "news":
                        this.BindNews();
                        break;
                    case "doc":
                        this.BindDocment();
                        break;
                }
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog("AssociaeList.btnSearch_Click|||" + ex.Message);
                ErrorLog.writeLogMessage(ex.Message, "AssociaeList.btnSearch_Click");
            }
        }
        private void BindNews()
        {
            try
            {
                this.newCol = "none";
                DataTable data = new DataTable();
                string[] arrCol = new string[] { "Activity", "Associae", "Url", "Title", "Author", "Created" };
                foreach (string column in arrCol)
                {
                    data.Columns.Add(column);
                }
                string whereQuery = "AssoId is not null ";
                if (!string.IsNullOrEmpty(this.DDL_Associae.SelectedValue))
                {
                    whereQuery += " and AssoId=" + this.DDL_Associae.SelectedValue;
                }
                if (!string.IsNullOrEmpty(this.Tb_searchTitle.Text.Trim()))
                {
                    whereQuery += " and Title like '%" + this.Tb_searchTitle.Text.Trim() + "%'";
                }
                DataTable items = newservice.GetData(whereQuery, "CreateTime desc");
                UserInfoService userservice = new UserInfoService();
                foreach (DataRow item in items.Rows)  //遍历列表项
                {
                    DataRow row = data.NewRow();
                    string title = item["Title"].SafeToString();
                    row["Title"] = title.Length > 20 ? title.Substring(0, 20) + "..." : title;
                    row["Associae"] = assoservice.GetEntityById(Convert.ToInt32(item["AssoId"])).AssoName;
                    row["Url"] = "NewsDetail.aspx?itemid=" + item["Id"];
                    row["Author"] = userservice.GetEntityById(Convert.ToInt32(item["CreateUserId"].SafeToString("0"))).UserName;
                    row["Created"] = item["CreateTime"].SafeToDataTime();
                    data.Rows.Add(row);
                }
                this.lvRow.DataSource = data;
                this.lvRow.DataBind();
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog("AssociaeList.BindNews|||" + ex.Message);
            }
        }
        private void BindDocment()
        {
            try
            {
                this.newCol = "block";
                DataTable data = new DataTable();
                string[] arrCol = new string[] { "Activity", "Associae", "Url", "Title", "Author", "Created" };
                foreach (string column in arrCol)
                {
                    data.Columns.Add(column);
                }
                string query = "1=1 ";
                if (!string.IsNullOrEmpty(this.DDL_Associae.SelectedValue))
                {
                    query += "and AssoId=" + this.DDL_Associae.SelectedValue;
                }
                //docQuery.Query = "<OrderBy><FieldRef Name='Created' Ascending='False' /></OrderBy>";
                if (!string.IsNullOrEmpty(this.Tb_searchTitle.Text.Trim()))
                {
                    query += "DataTitle like '%" + this.Tb_searchTitle.Text.Trim() + "%'";
                }
                DataTable docItems = dataservice.GetData(query, "CreatedTime desc");
                foreach (DataRow item in docItems.Rows)  //遍历列表项
                {
                    int activeid = Convert.ToInt32(item["ActivityId"]);
                    int assoid = Convert.ToInt32(item["AssoId"]);
                    int cuserid = Convert.ToInt32(item["CreatedUserId"]);
                    AssoActivity activity = activityservcie.GetEntityById(activeid);
                    AssoInfo asso = assoservice.GetEntityById(assoid);
                    UserInfo user = userservice.GetEntityById(cuserid);
                    if (activity.ExamStatus.SafeToString() == "审核通过")
                    {
                        string att_url = item["DataUrl"].SafeToString();

                        DataRow row = data.NewRow();
                        string title = item["DataTitle"].SafeToString();
                        row["Title"] = title.Length > 20 ? title.Substring(0, 20) + "..." : title;
                        row["Activity"] = activity.ActivityTitle.Length > 12 ? activity.ActivityTitle.Substring(0, 12) + "..." : activity.ActivityTitle;
                        row["Associae"] = asso.AssoName;
                        row["Url"] = att_url;
                        row["Author"] = user.UserName;
                        row["Created"] = item["CreatedTime"].SafeToDataTime();
                        data.Rows.Add(row);
                    }
                }
                this.lvRow.DataSource = data;
                this.lvRow.DataBind();
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog("AssociaeList.BindDocment|||" + ex.Message);
                ErrorLog.writeLogMessage(ex.Message, "AssociaeList.BindDocment");
            }
        }
        protected void lvRow_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            DataPager.SetPageProperties(DataPager.StartRowIndex, e.MaximumRows, false);
            btnSearch_Click(null, null);
        }
    }
}