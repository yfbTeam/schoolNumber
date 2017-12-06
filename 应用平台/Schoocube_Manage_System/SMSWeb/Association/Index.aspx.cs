using SMSBLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSModel;
using SMSUtility;


namespace SMSWeb.Association
{
    public partial class Index : System.Web.UI.Page
    {
        //LogCommon com = new LogCommon();
        Stopwatch watch = new Stopwatch();
        public AssoInfoService assoservice = new AssoInfoService();
        public UserInfoService assoUserService = new UserInfoService();
        public AssoActivityService activityservice = new AssoActivityService();
        public AssoMemberService assomemberService = new AssoMemberService();
        public AssoNewsService newsservice = new AssoNewsService();
        public ActivityDataService dataservice = new ActivityDataService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindActivityData();
                BindListView();
                BindNewsData(); //绑定社团资讯
                BindActivityDoc();//绑定活动资料
            }
        }

        private void BindActivityData()
        {
            watch.Restart();
            try
            {
                int pagecount = 0;
                int recordcount = 0;
                DataTable items = activityservice.GetData("", "  StartTime desc");
                DataTable activityList = new DataTable();
                string[] columnstr = new string[] { "ID", "Address", "Associae", "Attachment", "StartTime", "MemberCount", "EndTime", "Title" };
                foreach (string column in columnstr)
                {
                    activityList.Columns.Add(column);
                }
                int count = 0;
                foreach (DataRow item in items.Rows)  //遍历列表项
                {
                    count++;
                    if (count < 4)
                    {
                        DataRow activity = activityList.NewRow();
                        activity["ID"] = int.Parse(item["Id"].SafeToString("0"));
                        string title = item["ActivityTitle"].SafeToString();
                        activity["Title"] = title.Length > 11 ? title.Substring(0, 11) + "..." : title;
                        string assoTitle = "--";
                        try
                        {
                            AssoInfo associae = assoservice.GetEntityById(Convert.ToInt32(item["AssoId"]));
                            assoTitle = associae.AssoName;
                        }
                        catch (Exception ex) { }
                        activity["ID"] = item["Id"];
                        activity["Associae"] = assoTitle;
                        activity["Address"] = item["ActivityAddress"].SafeToString();
                        activity["StartTime"] = item["StartTime"].SafeToString();
                        activity["EndTime"] = item["EndTime"].SafeToDataTime();
                        ActivityMemService memservice = new ActivityMemService();
                        DataTable memdt = memservice.GetData("ActivityId=" + item["Id"], null);
                        activity["MemberCount"] = memdt == null ? 0 : memdt.Rows.Count;

                        activity["Attachment"] = string.IsNullOrEmpty(item["ActivityImg"].SafeToString()) ? "/_layouts/15/Stu_images/zs11.jpg" : item["ActivityImg"];


                        activityList.Rows.Add(activity);

                    }
                }
                LV_TermList.DataSource = activityList;
                LV_TermList.DataBind();

            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "Indx.aspx_BindActivityData");
            }
            watch.Stop();
            //com.writeLogMessage(watch.ElapsedMilliseconds.ToString(), "AssociaeIndx.BindActivityData");
        }

        private void BindListView()
        {
            watch.Restart();
            try
            {

                DataTable associaeList = new DataTable();
                string[] columnstr = new string[] { "ID", "Title", "Attachment", "MemberCount", "Introduce" };
                foreach (string column in columnstr)
                {
                    associaeList.Columns.Add(column);
                }
                int pagecount = 0;
                int recordcount = 0;

                DataTable items = assoservice.GetData("1=1", " CreateTime desc");

                int count = 0;
                foreach (DataRow item in items.Rows)
                {
                    count++;
                    if (count <= 5)
                    {
                        DataRow associae = associaeList.NewRow();
                        associae["ID"] = item["Id"];
                        associae["Title"] = item["AssoName"];
                        associae["Attachment"] = item["AssoPicURL"];

                        DataTable memdt = assomemberService.GetData("AssoId=" + item["Id"], null);
                        associae["Introduce"] = item["AssoIntroduce"];
                        associae["MemberCount"] = memdt != null ? memdt.Rows.Count : 0;

                        associaeList.Rows.Add(associae);
                    }
                }


                SB_TermList.DataSource = associaeList;
                SB_TermList.DataBind();

            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "Indx.aspx_BindListView");
            }
            watch.Stop();
            // com.writeLogMessage(watch.ElapsedMilliseconds.ToString(), "AssociaeIndx.BindListView");
        }

        private void BindNewsData()
        {
            watch.Restart();
            try
            {
                int pagecount = 0;
                int recordcount = 0;

                DataTable items = newsservice.GetData("1=1", " CreateTime desc");
                if (items != null && items.Rows.Count > 0)
                {
                    DataTable dt = new DataTable();
                    string[] arrs = new string[] { "ID", "Title", "Date", "New_Pic", "num", "numclass" };
                    foreach (string column in arrs)
                    {
                        dt.Columns.Add(column);
                    }

                    for (int i = 0; i < items.Rows.Count && i < 6; i++)
                    {
                        DataRow item = items.Rows[i];
                        DataRow dr = dt.NewRow();
                        dr["ID"] = item["Id"];
                        string assoTitle = "--";
                        int assid = Convert.ToInt32(item["AssoId"]);
                        if (assid == 0)
                        {
                            assoTitle = "社团管理员";
                        }
                        else
                        {
                            try
                            {
                                AssoInfo associae = assoservice.GetEntityById(Convert.ToInt32(item["AssoId"]));
                                assoTitle = associae.AssoName;
                            }
                            catch (Exception ex) { }
                        }
                        dr["Title"] = "[" + assoTitle + "]" + item["Title"];
                        dr["Date"] = string.Format("{0:MM-dd}", item["CreateTime"]);

                        dr["New_Pic"] = "../Stu_images/zs11.jpg";

                        dr["num"] = i + 1;
                        if (i == 0) { dr["numclass"] = "numone"; }
                        else if (i == 1) { dr["numclass"] = "numtwo"; }
                        else if (i == 2) { dr["numclass"] = "numthree"; }
                        dt.Rows.Add(dr);
                    }
                    lv_PictureShow.DataSource = dt;
                    lv_PictureShow.DataBind();
                    lv_AssociNews.DataSource = dt;
                    lv_AssociNews.DataBind();
                }


            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "Indx.aspx_BindNewsData");
            }
            watch.Stop();
            //com.writeLogMessage(watch.ElapsedMilliseconds.ToString(), "AssociaeIndx.BindNewsData");
        }

        private void BindActivityDoc()
        {
            watch.Restart();
            try
            {

                DataTable docList = new DataTable();
                string[] columnstr = new string[] { "ID", "Title", "Associae", "Attachment", "CreateTime", "TypeImg" };
                foreach (string column in columnstr)
                {
                    docList.Columns.Add(column);
                }
                DataTable items = dataservice.GetData("1=1", " CreatedTime desc");
                if (items != null && items.Rows.Count > 0)
                {
                    for (int i = 0; i < items.Rows.Count && i < 6; i++)
                    {
                        DataRow item = items.Rows[i];
                        int activeid = Convert.ToInt32(item["ActivityId"]);
                        int assoid = Convert.ToInt32(item["AssoId"]);
                        int cuserid = Convert.ToInt32(item["CreatedUserId"]);
                        AssoInfo asso = assoservice.GetEntityById(assoid);
                        UserInfo user = assoUserService.GetEntityById(cuserid);

                        string att_url = item["DataUrl"].SafeToString();

                        DataRow row = docList.NewRow();
                        string title = item["DataTitle"].SafeToString();
                        row["TypeImg"] = GetIconCode(item["DataType"].SafeToString());
                        row["Title"] = title.Length > 20 ? title.Substring(0, 20) + "..." : title;
                        row["ID"] = item["Id"];
                        row["Attachment"] = att_url;
                        row["CreateTime"] = item["CreatedTime"].SafeToDataTime();
                        docList.Rows.Add(row);

                        //if (i > 6)
                        //{
                        //    break;
                        //}
                    }
                }
                lv_ActivityDoc.DataSource = docList;
                lv_ActivityDoc.DataBind();

            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog("AssociaeIndx.BindActivityDoc|||" + ex.Message);
                ErrorLog.writeLogMessage(ex.Message, "Indx.aspx_BindActivityDoc");
            }
            watch.Stop();
            //com.writeLogMessage(watch.ElapsedMilliseconds.ToString(), "AssociaeIndx.BindActivityDoc");
        }

        private string GetIconCode(string exten)
        {
            string code = string.Empty;
            switch (exten)
            {
                case "doc":
                case "docx":
                    code = "&#xe647;";
                    break;
                case "xls":
                case "xlsx":
                    code = "&#xe648;";
                    break;
                case "ppt":
                case "pptx":
                    code = "&#xe64f;";
                    break;
                case "txt":
                    code = "&#xe642;";
                    break;
                case "pdf":
                    code = "&#xe649;";
                    break;
                case "jpg":
                    code = "&#xe63e;";
                    break;
                case "png":
                    code = "&#xe640;";
                    break;
                case "psd":
                    code = "&#xe641;";
                    break;
                case "zip":
                    code = "&#xe657;";
                    break;
                case "mp3":
                    code = "&#xe651;";
                    break;
                default:
                    code = "&#xe625;";
                    break;
            }
            return code;
        }
    }
}