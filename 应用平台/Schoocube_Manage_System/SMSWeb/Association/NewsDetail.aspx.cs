using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSModel;
using SMSUtility;
using SMSBLL;

namespace SMSWeb.Association
{
    public partial class NewsDetail : System.Web.UI.Page
    {

       // LogCommon com = new LogCommon();
        //private SPList AssociaeList { get { return ListHelp.GetCureenWebList("社团信息", false); } }
        //private SPList NewsList { get { return ListHelp.GetCureenWebList("社团资讯", false); } }
        public AssoInfoService assoservice = new AssoInfoService();
        public AssoNewsService newservice = new AssoNewsService();
        public UserInfoService userservice = new UserInfoService();
        public static string Userid { get; set; }
        public string userName = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HttpCookie userId = Request.Cookies["UserId"];
                HttpCookie UserName = Request.Cookies["UserName"];
                if (userId != null)
                {
                    Userid = Request.Cookies["UserId"].Value.SafeToString();
                    userId.Expires = DateTime.Now.AddSeconds(10000);
                    Response.Cookies.Add(userId);
                }
                if (UserName != null)
                {
                    userName = Request.Cookies["UserName"].Value.SafeToString();
                    UserName.Expires = DateTime.Now.AddSeconds(10000);

                    Response.Cookies.Add(UserName);
                }
               // Lit_CurrentName.Text = userName;
                Page.Form.Attributes.Add("enctype", "multipart/form-data");
                string itemid = Request.QueryString["itemid"];
                if (!string.IsNullOrEmpty(itemid))
                {
                    ViewState["itemid"] = itemid;
                    this.BindNews(itemid);
                    //this.BindListView(itemid);
                }
            }
        }
        private void BindNews(string itemid)
        {
            try
            {
                AssoNews item = newservice.GetEntityById(Convert.ToInt32(itemid));
                this.Lit_Title.Text = item.Title;
                int assid = Convert.ToInt32(item.AssoId);
                if (assid == 0)
                {
                    this.Lit_Associae.Text = "社团管理员";
                }
                else
                {
                    string assoTitle = "--";
                    try
                    {
                        AssoInfo associae = assoservice.GetEntityById(assid);
                        assoTitle = associae.AssoName;
                    }
                    catch (Exception ex) { }
                    this.Lit_Associae.Text = assoTitle;
                }
                UserInfo user = userservice.GetEntityById(Convert.ToInt32(item.CreateUserId));
                this.Lit_CreateUser.Text = user.UserName;
                this.Lit_CreateTime.Text =item.CreateTime.SafeToDataTime();
                this.Lit_Content.Text = item.NewsContent.SafeToString();
            
                   // this.Img_News.ImageUrl = item.NewsContent;
                
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog("TA_wp_Details.BindNews|||" + ex.Message);
                ErrorLog.writeLogMessage(ex.Message, "NewsDetail.BindNews");
            }
        }
        protected void LB_Publish_Click(object sender, EventArgs e)
        {
            try
            {
                //if (!string.IsNullOrEmpty(this.Hid_content.Value))
                {
                  
                        
                            //SPList list = oWeb.Lists.TryGetList("资讯评论");
                            //SPListItem item = list.AddItem();
                            //item["Content"] = this.Hid_content.Value;
                            //item["NewsID"] = ViewState["itemid"].SafeToString();
                            //item["ParentID"] = 0;
                            //SPFieldUserValue sfvalue = new SPFieldUserValue(oWeb, user.ID, user.Name);
                            //item["Author"] = sfvalue;
                            //item.Update();
                            //BindListView(ViewState["itemid"].SafeToString());
                     
                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "NewsDetail_LB_Publish_Click");
            }
        }

        //private void BindListView(string itemId)
        //{
        //    this.LV_FirstReply.DataSource = GetNewsReplyByPid(itemId);
        //    this.LV_FirstReply.DataBind();
        //}
        private DataTable GetNewsReplyByPid(string itemId, string pid = "0")
        {
            DataTable firstdt = new DataTable();
            string[] arrs = new string[] { "ID", "PictUrl", "Content", "GoodCount", "Author", "Created", "Attachment" };
            foreach (string column in arrs)
            {
                firstdt.Columns.Add(column);
            }
            try
            {
                
                        //SPList list = oWeb.Lists.TryGetList("资讯评论");
                        //SPListItemCollection items = list.GetItems(new SPQuery()
                        //{
                        //    Query = CAML.Where(
                        //       CAML.And(
                        //           CAML.Eq(CAML.FieldRef("NewsID"), CAML.Value(itemId)),
                        //           CAML.Eq(CAML.FieldRef("ParentID"), CAML.Value(pid))
                        //       )) + CAML.OrderBy(CAML.OrderByField("Created", CAML.SortType.Descending))
                        //});
                        //foreach (SPListItem item in items)
                        //{
                        //    DataRow dr = firstdt.NewRow();
                        //    dr["ID"] = item.ID;
                        //    dr["Author"] = item["Author"].SafeLookUpToString();
                        //    string replayUser = item["Author"].SafeToString();
                        //    int userId = Convert.ToInt32(replayUser.Substring(0, replayUser.IndexOf(";#")));
                        //    string loginName = oWeb.AllUsers.GetByID(userId).LoginName;
                        //    dr["PictUrl"] = ListHelp.LoadPicture(loginName, false, "/_layouts/15/Stu_images/studentdefault.jpg");
                        //    dr["Content"] = item["Content"].SafeToString();
                        //    dr["Created"] = Convert.ToDateTime(item["Created"]).ToString("yyyy-MM-dd HH:mm:ss");
                        //    dr["GoodCount"] = item["GoodCount"].SafeToString("0");
                        //    firstdt.Rows.Add(dr);
                        //}
                  
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "NewsDetail_GetNewsReplyByPid");
            }
            return firstdt;
        }
        protected void LV_FirstReply_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            try
            {
                        //SPUser user = SPContext.Current.Web.CurrentUser;
                        //TextBox secondVal = e.Item.FindControl("TB_SecondVal") as TextBox;
                        //SPList list = oWeb.Lists.TryGetList("资讯评论");
                        //if (e.CommandName == "Publish")
                        //{
                        //    SPListItem item = list.AddItem();
                        //    item["Content"] = secondVal.Text;
                        //    item["NewsID"] = ViewState["itemid"].SafeToString();
                        //    item["ParentID"] = e.CommandArgument.ToString();
                        //    SPFieldUserValue sfvalue = new SPFieldUserValue(oWeb, user.ID, user.Name);
                        //    item["Author"] = sfvalue;
                        //    item.Update();
                        //}
                        //else
                        //{
                        //    SPListItem item = list.GetItemById(Convert.ToInt32(e.CommandArgument.ToString()));
                        //    item["GoodCount"] = Convert.ToInt32(item["GoodCount"]) + 1;
                        //    item.Update();
                        //}
                        //BindListView(ViewState["itemid"].SafeToString());
                  
            }
            catch (Exception ex)
            {
               // com.writeLogMessage(ex.Message, "SA_wp_ActivityNewsShow_LV_FirstReply_ItemCommand");
            }
        }

        protected void LV_FirstReply_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                Literal lit = e.Item.FindControl("Lit_Count") as Literal;
                ListView lv = e.Item.FindControl("LV_SecondReply") as ListView;
                HiddenField hf = e.Item.FindControl("Hid_ItemId") as HiddenField;
                DataTable secondDt = GetNewsReplyByPid(ViewState["itemid"].SafeToString(), hf.Value);
                lit.Text = secondDt.Rows.Count.SafeToString();
                lv.DataSource = secondDt;
                lv.DataBind();
            }
        }

        protected void LV_FirstReply_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            //DPProject.SetPageProperties(DPProject.StartRowIndex, e.MaximumRows, false);
            //BindListView(ViewState["itemid"].SafeToString());
        }
    }
}
