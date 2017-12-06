using SMSBLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSUtility;
using SMSModel;
using System.Data;
using System.Text;
using System.IO;

namespace SMSWeb.Association
{
    public partial class ShowAssociaePhoto : System.Web.UI.Page
    {
        // LogCommon com = new LogCommon();
        public AlbumPicService picservice = new AlbumPicService();
        public AssoAlbumService alumnservice = new AssoAlbumService();
        public AssoInfoService assservice = new AssoInfoService();
        public string Limit { get; set; }
        private static string Associae_ID { get; set; }
        private static string Album { get; set; }
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
                Associae_ID = Request.QueryString["itemid"];
                string albumid = Request.QueryString["albumid"];
                if (!string.IsNullOrEmpty(Associae_ID))
                {
                    this.Limit = "none";
                    BindLimit(Associae_ID);
                    BindAlbumPhotos(Associae_ID, albumid);
                }
            }
        }
        private void BindLimit(string assid)
        {
            try
            {

                AssoInfo item = assservice.GetEntityById(Convert.ToInt32(assid));
                string Leader = item.AssoLeaderId.SafeToString("0");


                if (Leader == Userid)
                {
                    this.Limit = "block";
                }
                string Sec_Leader = item.AssoLeaderSecondId.SafeToString();
                if (!string.IsNullOrEmpty(Sec_Leader))
                {

                    if (Sec_Leader == Userid)
                    {
                        this.Limit = "block";
                    }
                }
                if (Request.QueryString["flag"].SafeToString() == "show")
                {
                    this.Limit = "none";
                }

            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "ShowAssociaePhoto.aspx_BindAlbumPhotos");
            }
        }
        private void BindAlbumPhotos(string assid, string albumid)
        {
            try
            {
                string[] arrs = new string[] { "Photo_ID", "Title", "PhotoUrl" };
                DataTable dt = CreateDataTable(arrs);


                DataTable photoCollection = picservice.GetData("AlbumId=" + albumid, null);

                StringBuilder sbPhoto = new StringBuilder();

                foreach (DataRow item in photoCollection.Rows)
                {
                    DataRow row = dt.NewRow();
                    row["Photo_ID"] = item["ID"];
                    string filename = Path.GetFileName(item["PicUrl"].SafeToString());
                    row["Title"] = filename;
                    row["PhotoUrl"] = item["PicUrl"];
                    dt.Rows.Add(row);
                }
                PhotosList.DataSource = dt;
                PhotosList.DataBind();

            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "ShowAssociaePhoto.aspx_BindAlbumPhotos");
            }
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
        protected void btnDelPhoto_Click(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrEmpty(this.hfPhoto.Value))
                {

                    int photoId = Convert.ToInt32(this.hfPhoto.Value);
                    bool result = picservice.Delete(photoId);
                    if (result)
                    {

                        string albumid = Request.QueryString["albumid"];
                        BindAlbumPhotos(Associae_ID, albumid);
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "ShowAssociaePhoto.aspx_BindAlbumPhotos");
            }
        }
    }
}
