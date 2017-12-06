using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSModel;
using SMSBLL;
using SMSUtility;

namespace SMSWeb.Association
{
    public partial class MyApplyLog : System.Web.UI.Page
    {
        //LogCommon com = new LogCommon();
        public AssoApplyService applyservice = new AssoApplyService();
        public AssoInfoService assoservice = new AssoInfoService();
        public AssoActivityService activityservcie = new AssoActivityService();
        private static string Userid { get; set; }
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
                BindApplyListView();//社团申请审核
                //BindAllActivity(); //绑定活动审核
            }
        }
        //private void BindAllActivity()
        //{
        //    try
        //    {
        //        DataTable dt = new DataTable();
        //        string[] arrs = new string[] { "ID", "Title", "Associae", "StartTime", "EndTime", "Address", "Created" };
        //        foreach (string column in arrs)
        //        {
        //            dt.Columns.Add(column);
        //        }
        //        SPListItemCollection items = ActivityList.GetItems(new SPQuery() { Query = "<Where><Eq><FieldRef Name='Author' LookupId='TRUE' /><Value Type='User'>" + SPContext.Current.Web.CurrentUser.ID + "</Value></Eq></Where><OrderBy><FieldRef Name='Created' Ascending='False' /></OrderBy>" });
        //        foreach (SPListItem item in items)
        //        {
        //            DataRow dr = dt.NewRow();
        //            dr["ID"] = item.ID;
        //            dr["Title"] = item.Title;
        //            dr["StartTime"] = item["StartTime"].SafeToDataTime();
        //            dr["EndTime"] = item["EndTime"].SafeToDataTime();
        //            dr["Address"] = item["Address"];
        //            dr["Created"] = item["Created"].SafeToDataTime();
        //            dr["Associae"] = AssociaeList.GetItemById(Convert.ToInt32(item["AssociaeID"])).Title;
        //            dt.Rows.Add(dr);
        //        }
        //        this.lvAllActivity.DataSource = dt;
        //        this.lvAllActivity.DataBind();
        //    }
        //    catch (Exception ex)
        //    {
        //        com.writeLogMessage(ex.Message, "MyApplyLog.BindAllActivity");
        //    }
        //}
        private void BindApplyListView()
        {
            try
            {
                DataTable dt = new DataTable();
                string[] arrs = new string[] { "ID", "Type", "Title", "Created", "Status" };
                foreach (string column in arrs)
                {
                    dt.Columns.Add(column);
                }
                string Query = "ApplyUserId=" + Userid;
                DataTable items = applyservice.GetData(Query,null);
                foreach (DataRow item in items.Rows)
                {
                   AssoInfo casso=assoservice.GetEntityById(int.Parse( item["AssoId"].SafeToString("0")));
                    AssoType type = new AssoTypeService().GetEntityById(int.Parse( casso.AssoType));
                    DataRow dr = dt.NewRow();
                    dr["ID"] = casso.Id.SafeToString();
                    dr["Title"] = casso.AssoName;
                    dr["Type"] = type.Title;
                    dr["Created"] = casso.CreateTime;
                    dr["Status"] = item["ApplyStatus"];
                    dt.Rows.Add(dr);
                }
                this.lvAssociae.DataSource = dt;
                this.lvAssociae.DataBind();
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "MyApplyLog.BindApplyListView");
            }
        }

        //protected void lvAllActivity_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        //{
        //    ActivityPager.SetPageProperties(ActivityPager.StartRowIndex, e.MaximumRows, false);
        //    BindAllActivity();
        //}

        protected void lvAssociae_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            AssociaePager.SetPageProperties(AssociaePager.StartRowIndex, e.MaximumRows, false);
            BindApplyListView();
        }
    }
}
