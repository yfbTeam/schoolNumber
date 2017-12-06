using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSBLL;
using SMSModel;
using SMSUtility;

namespace SMSWeb.Association
{
    public partial class ActivityList : System.Web.UI.Page
    {
        // LogCommon com = new LogCommon();
        public AssoInfoService assoservice = new AssoInfoService();
        public AssoActivityService activityservice = new AssoActivityService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindAssociae();
                BindActivityList();
            }
        }
        private void BindAssociae()
        {
            try
            {   //获取所有社团
                this.DDL_Associae.Items.Add(new ListItem("不限", ""));
                string Query = "AssoStatus='开放'";
                DataTable items = assoservice.GetData(Query, null);
                foreach (DataRow item in items.Rows)
                {
                    this.DDL_Associae.Items.Add(new ListItem(item["AssoName"].SafeToString(), item["Id"].ToString()));
                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "ActivityList.BindAssociae_绑定社团信息");
            }
        }
        private void BindActivityList()
        {
            try
            {
                DataTable data = new DataTable();
                string[] arrs = new string[] { "ID", "Title", "Associae", "StartTime", "EndTime", "Address", "Count", "Activity_Pic" };
                foreach (string column in arrs)
                {
                    data.Columns.Add(column);
                }
                string whereQuery = "1=1";
                if (!string.IsNullOrEmpty(this.DDL_Associae.SelectedValue))
                {
                    whereQuery = " and AssoId=" + this.DDL_Associae.SelectedValue;
                }
                if (!string.IsNullOrEmpty(this.Tb_searchTitle.Text.Trim()))
                {
                    whereQuery = " and ActivityTitle='%" + this.Tb_searchTitle.Text.Trim() + "%'";
                }

                DataTable items = activityservice.GetData(whereQuery, " StartTime desc");
                foreach (DataRow item in items.Rows)  //遍历列表项
                {
                    DataRow row = data.NewRow();
                    row["ID"] = item["Id"];
                    string title = item["ActivityTitle"].SafeToString();
                    row["Title"] = title.Length > 11 ? title.Substring(0, 11) + "..." : title;
                    row["Associae"] = assoservice.GetEntityById(Convert.ToInt32(item["AssoId"])).AssoName;
                    row["StartTime"] = item["StartTime"].SafeToDataTime();
                    row["EndTime"] = item["EndTime"].SafeToDataTime();
                    row["Address"] = item["ActivityAddress"].SafeToString();
                    ActivityMemService memservice = new ActivityMemService();
                    DataTable memdt = memservice.GetData("ActivityId=" + item["Id"], null);
                    row["Count"] = memdt.Rows.Count;

                    row["Activity_Pic"] = string.IsNullOrEmpty(item["ActivityImg"].SafeToString()) ? "/_layouts/15/Stu_images/nopic.png" : item["ActivityImg"];

                    data.Rows.Add(row);
                }
                lvActivity.DataSource = data;
                lvActivity.DataBind();
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "ActivityList.BindActivityList_绑定社团活动");
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindActivityList();
        }

        protected void lvActivity_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            DP_Activity.SetPageProperties(DP_Activity.StartRowIndex, e.MaximumRows, false);
            BindActivityList();
        }
    }
}