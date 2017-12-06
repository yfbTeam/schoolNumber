using SMSBLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSUtility;
using SMSModel;

namespace SMSWeb.Association
{
    public partial class AssociationShow : System.Web.UI.Page
    {

        // LogCommon com = new LogCommon();
        public string Associae_ID { get; set; }
        public string Limit { get; set; }
        public static string Userid { get; set; }
        public string userName = "";
        public string role = "";
        public AssoInfoService assservice = new AssoInfoService();
        public AssoMemberService assomemService = new AssoMemberService();
        public UserInfoService assoUserService = new UserInfoService();
        public AssoActivityService assoactivityService = new AssoActivityService();
        public AssoAlbumService albumnservice = new AssoAlbumService();
        public AlbumPicService picservice = new AlbumPicService();
        public AssoNewsService assonewservice = new AssoNewsService();
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Associae_ID = Request.QueryString["itemid"];
            if (!string.IsNullOrEmpty(Associae_ID))
            {
                HttpCookie userId = Request.Cookies["UserId"];
                HttpCookie UserName = Request.Cookies["UserName"];
                if (userId != null)
                {
                    Userid = Request.Cookies["UserId"].Value.SafeToString();
                    userId.Expires = DateTime.Now.AddSeconds(10000);
                    Response.Cookies.Add(userId);
                    RoleUserService ruserservice = new RoleUserService();
                    DataTable userroledt = ruserservice.GetData("Userid=" + Userid, null);
                    RoleService roleservice = new RoleService();
                    foreach (DataRow item in userroledt.Rows)
                    {

                        Role roleitem = roleservice.GetEntityById(int.Parse(item["RoleId"].SafeToString()));
                        role += role == "" ? roleitem.RoleName : "," + roleitem.RoleName;
                    }

                }
                if (UserName != null)
                {
                    userName = Request.Cookies["UserName"].Value.SafeToString();
                    UserName.Expires = DateTime.Now.AddSeconds(10000);

                    Response.Cookies.Add(UserName);
                }


                if (!IsPostBack)
                {
                    this.Limit = "none";
                    BindAssociaeData(Associae_ID);
                    BindActivityData(Associae_ID);
                    BindNewsData(Associae_ID);
                    BindPhotoData(Associae_ID);
                }
            }
        }

        #region 社团相册
        private void BindPhotoData(string itemId)
        {
            try
            {
                DataTable dt_Album = GetAlbumInfo(itemId);
                DataTable dt_Photo = dt_Album.Clone();
                if (dt_Album.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt_Album.Rows)
                    {
                        string photos = dr["Photo"].ToString();
                        if (!string.IsNullOrEmpty(photos))//默认取最新一张做封面
                        {
                            dt_Photo.Rows.Add(dr.ItemArray);
                            dr["Photo"] = photos;
                        }
                        else //相册下面没有照片
                        {
                            dr["Photo"] = @"../Stu_images/nopic.png";
                        }
                    }
                    while (dt_Photo.Rows.Count > 2)
                    {
                        dt_Photo.Rows.RemoveAt(dt_Photo.Rows.Count - 1);
                    }
                    foreach (DataRow dr in dt_Photo.Rows)
                    {
                        string photos = dr["Photo"].ToString();
                        if (!string.IsNullOrEmpty(photos))
                        {
                            StringBuilder sbPhoto = new StringBuilder();
                            string[] arr = photos.Split('#');
                            foreach (string pstr in arr)
                            {
                                if (!string.IsNullOrEmpty(pstr))
                                {
                                    sbPhoto.Append("<a href='#'><img src='" + pstr + "' /></a>");
                                }
                            }
                            dr["Photo"] = sbPhoto.ToString();
                        }
                    }
                    Photo_TermList.DataSource = dt_Photo;
                    Photo_TermList.DataBind();
                }

                Album_TermList.DataSource = dt_Album;
                Album_TermList.DataBind();
            }
            catch (Exception ex)
            {
                //com.writeLogMessage(ex.Message, "TA_wp_AssociationShowUserControl_BindPhotoData.ascx");
            }
        }
        private DataTable GetAlbumInfo(string itemId)
        {
            DataTable dt = new DataTable();
            string[] arrs = new string[] { "AssoId", "Album_ID", "Title", "Date", "Count", "Photo", "Editor" };
            foreach (string column in arrs)
            {
                dt.Columns.Add(column);
            }
            try
            {

                string query = @" AssoId=" + itemId;
                DataTable items = albumnservice.GetData(query, " CreateTime desc");
                if (items != null && items.Rows.Count > 0)
                {

                    for (int i = 0; i < items.Rows.Count; i++)
                    {
                        DataRow dr = dt.NewRow();
                        dr["AssoId"] = itemId;
                        dr["Album_ID"] = items.Rows[i]["Id"];
                        dr["Title"] = items.Rows[i]["AlbumName"];
                        dr["Date"] = items.Rows[i]["CreateTime"].SafeToString();
                        DataTable picdt = picservice.GetData("AlbumId=" + items.Rows[i]["Id"], null);
                        dr["Count"] = picdt.Rows.Count;
                        string sbPhoto = items.Rows[i]["FirstPicUrl"].SafeToString();
                        dr["Editor"] = assoUserService.GetEntityById(int.Parse(items.Rows[i]["CreateUserId"].SafeToString("0"))).UserName;
                        if (picdt.Rows.Count > 0)
                        {
                            if (string.IsNullOrEmpty(sbPhoto))
                            {
                                dr["Photo"] = picdt.Rows[0]["PicUrl"];
                            }
                        }
                        dt.Rows.Add(dr);
                    }
                }

            }
            catch (Exception ex)
            {
                //com.writeLogMessage(ex.Message, "TA_wp_AssociationShowUserControl_GetAlbumInfo.ascx");
            }
            return dt;
        }
        protected void btnDelAlbum_Click(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrEmpty(this.hfAlbum.Value))
                {
                    bool result = albumnservice.Delete(int.Parse(this.hfAlbum.Value));


                }
                BindPhotoData(Associae_ID);
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "AssociationShow.btnDelAlbum_Click");
            }
        }
        #endregion

        #region 社团动态
        private void BindNewsData(string itemId)
        {
            try
            {
                DataTable items = assonewservice.GetData("AssoId=" + itemId, " CreateTime desc");

                if (items != null && items.Rows.Count > 0)
                {
                    DataTable dt = new DataTable();
                    string[] arrs = new string[] { "ID", "Title", "Content", "Date", "New_Pic" };
                    foreach (string column in arrs)
                    {
                        dt.Columns.Add(column);
                    }
                    int count = items.Rows.Count > 1 ? 2 : items.Rows.Count;
                    for (int i = 0; i < count; i++)
                    {
                        DataRow dr = dt.NewRow();
                        dr["ID"] = items.Rows[i]["Id"];
                        dr["Title"] = items.Rows[i]["Title"];
                        string content = items.Rows[i]["NewsContent"].SafeToString();
                        dr["Content"] = content.Length > 386 ? content.Substring(0, 386) + "..." : content;
                        dr["Date"] = items.Rows[i]["CreateTime"].SafeToString();
                        dr["New_Pic"] = "/Stu_images/zs11.jpg";
                        //if(true)
                        //      dr["New_Pic"] = items.Rows[i][""];
                        //  }
                        //  else
                        //  {
                        //      dr["New_Pic"] = "/_layouts/15/Stu_images/nopic.png";
                        //  }
                        dt.Rows.Add(dr);
                    }
                    News_TermList.DataSource = dt;
                    News_TermList.DataBind();
                }


            }
            catch (Exception ex)
            {

                ErrorLog.writeLogMessage(ex.Message, "AssociationSho.aspx");
            }
        }
        #endregion

        #region 社团活动
        private void BindActivityData(string itemId)
        {
            try
            {
                //若现在的时间在活动开始和活动结束时间之间，说明活动正在进行。
                string queryStr = @"AssoID=" + itemId + @" and EndTime>='" + DateTime.Today + "'";
                string order = "StartTime desc";
                lv_Activeing.DataSource = BindDataByQuery(queryStr, order);
                lv_Activeing.DataBind();

                //若现在的时间大于结束时间说明活动已结束。
                string overqueryStr = @"AssoId=" + itemId + @"and EndTime<'" + DateTime.Today + "'";
                lv_ActiveOver.DataSource = BindDataByQuery(overqueryStr, order);
                lv_ActiveOver.DataBind();
                string allquery = @"AssoId=" + itemId;
                DataTable dt = BindDataByQuery(allquery, order);
                while (dt.Rows.Count > 5)
                {
                    dt.Rows.RemoveAt(dt.Rows.Count - 1);
                }
                SB_TermList.DataSource = dt;
                SB_TermList.DataBind();


            }
            catch (Exception ex)
            {

                ErrorLog.writeLogMessage(ex.Message, "AssociationShow.aspx_BindActivityData");
            }
        }

        private DataTable BindDataByQuery(string queryStr, string order)
        {
            string[] columnArr = new string[] { "ID", "Title", "Associae", "Date", "Address", "Count", "Activity_Pic" };
            DataTable dt = CreateDataTable(columnArr);//创建新表
            DataTable items = assoactivityService.GetData(queryStr, order);

            if (items != null && items.Rows.Count > 0)
            {
                int count = items.Rows.Count > 6 ? 6 : items.Rows.Count;
                for (int i = 0; i < count; i++)
                {
                    DataRow dr = dt.NewRow();
                    dr["ID"] = items.Rows[i]["Id"];
                    string title = items.Rows[i]["ActivityTitle"].SafeToString();
                    dr["Title"] = title.Length > 11 ? title.Substring(0, 11) + "..." : title;
                    dr["Associae"] = assservice.GetEntityById(Convert.ToInt32(items.Rows[i]["AssoId"])).AssoName;
                    dr["Date"] = string.Format("{0:MM月dd日}", items.Rows[i]["StartTime"]) + "-" + string.Format("{0:MM月dd日}", items.Rows[i]["EndTime"]);
                    dr["Address"] = items.Rows[i]["ActivityAddress"].SafeToString();
                    ActivityMemService activitymemservice = new ActivityMemService();
                    DataTable amemcount = activitymemservice.GetData("ActivityId=" + items.Rows[i]["Id"], null);
                    dr["Count"] = amemcount.Rows.Count;
                    dr["Activity_Pic"] = items.Rows[i]["ActivityImg"] != null ? items.Rows[i]["ActivityImg"] : @"/_layouts/15/Stu_images/nopic.png";

                    dt.Rows.Add(dr);
                }
            }
            return dt;
        }
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
        #endregion

        #region 社团信息
        private void BindAssociaeData(string Aid)
        {
            try
            {
                this.Lit_User.Text = userName;
                int itemId = Convert.ToInt32(Aid);

                #region 顶部图片
                string query = @" AssoId=" + itemId;
                DataTable itemPics = albumnservice.GetData(query, " CreateTime desc");
                if (itemPics != null && itemPics.Rows.Count > 0)
                {
                    this.headerPic.Src = itemPics.Rows[0]["FirstPicUrl"].SafeToString() == "" ? "../Stu_images/homepic.jpeg" : itemPics.Rows[0]["FirstPicUrl"].SafeToString();
                }
                #endregion

                #region 右侧社团信息
                AssoInfo item = assservice.GetEntityById(itemId);
                this.Lit_Title.Text = item.AssoName;
                this.Literal1.Text = this.Lit_Slogans.Text = item.AssoSlogan;
                this.Literal2.Text = item.AssoIntroduce;
                this.Lit_Introduce.Text = Literal2.Text.Length > 100 ? Literal2.Text.Substring(0, 100) + "..." : Literal2.Text;
                UserInfo Leader = assoUserService.GetEntityById(int.Parse(item.AssoLeaderId.SafeToString("0")));
                if (Leader != null)
                {


                    this.Lit_Leader.Text = Leader.UserName;
                    this.Leader_pic.Src = string.IsNullOrEmpty(Leader.ImgUrl) ? "/images/student.jpg" : Leader.ImgUrl;
                    if (Leader.Id.SafeToString() == Userid)
                    {
                        this.Limit = "block";
                    }
                    else
                    {
                        if (role.Split(',').Contains("学生"))
                        {
                            if (ValidateSign(DateTime.Now))//判断是否在开放的报名时间内
                            {
                                this.btn_apply.Visible = true;
                            }
                            // this.btn_apply.Visible = true; 
                        }
                    }
                }
                else
                {
                    this.Lit_Leader.Text = "无";
                }
                //社团图片
                headerPic.Src = item.AssoBackPicUrl.SafeToString().Trim() == "" ? @"../Stu_images/homepic.jpeg" : item.AssoBackPicUrl;
                this.Associae_Pic.Src = item.AssoPicURL.SafeToString().Trim() == "" ? @"../Stu_images/zs11.jpg" : item.AssoPicURL;

                //副团长
                DataTable dt = new DataTable();
                dt = CreateDataTable(new string[] { "U_Pic", "Name" });
                UserInfo Sec_Leader = assoUserService.GetEntityById(int.Parse(item.AssoLeaderSecondId.SafeToString("0")));
                if (Sec_Leader != null)
                {
                    DataRow dr = dt.NewRow();
                    dr["U_Pic"] = Sec_Leader.ImgUrl;
                    dr["Name"] = Sec_Leader.UserName;
                    dt.Rows.Add(dr);
                    if (Sec_Leader.Id.SafeToString() == Userid)
                    {
                        this.Limit = "block";
                    }

                }
                LV_TermList.DataSource = dt;
                LV_TermList.DataBind();
                #endregion

                #region 社团成员
                string Query = @"AssoId=" + itemId;
                DataTable items = assomemService.GetData(Query, null);
                this.Literal3.Text = items.Rows.Count.ToString();//成员人数
                if (items != null && items.Rows.Count > 0)
                {
                    DataTable medt = new DataTable();
                    string[] arrs = new string[] { "ID", "Name", "Introduction", "Photo" };
                    foreach (string column in arrs)
                    {
                        medt.Columns.Add(column);
                    }
                    foreach (DataRow meitem in items.Rows)
                    {

                        int cuserId = Convert.ToInt32(meitem["UserId"].SafeToString());
                        UserInfo user = assoUserService.GetEntityById(cuserId);
                        DataRow medr = medt.NewRow();
                        medr["ID"] = meitem["ID"];
                        medr["Name"] = user.UserName;
                        medr["Introduction"] = "";
                        medr["Photo"] = string.IsNullOrEmpty(user.ImgUrl) ? "/images/student.jpg" : user.ImgUrl;
                        medt.Rows.Add(medr);
                        if (this.btn_apply.Visible && cuserId.SafeToString() == Userid)
                        {
                            this.btn_apply.InnerHtml = "申请退团";
                        }
                    }
                    LV_MemberList.DataSource = medt;
                    LV_MemberList.DataBind();
                }
                #endregion


            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "AssociationShow.aspx_绑定社团信息");
            }
        }
        #endregion
        /// <summary>
        /// 判断是否在开放的报名时间内
        /// </summary>
        /// <param name="date">传入时间</param>
        /// <returns></returns>
        private bool ValidateSign(DateTime date)
        {
            bool isOK = false;
            try
            {

                AssoSetService assoservice = new AssoSetService();
                DataTable items = assoservice.GetData(null, null);

                if (items != null && items.Rows.Count > 0)
                {
                    DateTime start = DateTime.Parse(items.Rows[0]["StartDate"].ToString());
                    DateTime end = DateTime.Parse(items.Rows[0]["EndDate"].ToString());
                    if (start < date && date < end.AddDays(1))
                    {
                        isOK = true;
                    }
                }

            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "TA_wp_AssociationShow.ValidateSign");
            }
            return isOK;
        }
    }
}