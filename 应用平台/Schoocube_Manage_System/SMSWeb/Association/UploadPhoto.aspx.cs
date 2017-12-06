using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSModel;
using SMSBLL;
using SMSUtility;
using System.Data;

namespace SMSWeb.Association
{
    public partial class UploadPhoto : System.Web.UI.Page
    {
        //LogCommon com = new LogCommon();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string assid = Request.QueryString["itemid"];
                if (!string.IsNullOrEmpty(assid))
                {
                    BindAlbum(assid);
                }
            }
        }
        public void BindAlbum(string assid)
        {
            try
            {
                AssoAlbumService albumnservice = new AssoAlbumService();
                DataTable albumdt = albumnservice.GetData("AssoId=" + assid, " CreateTime desc");
                if (albumdt.Rows.Count > 0)
                {
                    foreach (DataRow item in albumdt.Rows)
                    {

                        DDP_Album.Items.Add(new ListItem(item["AlbumName"].SafeToString(), item["Id"].SafeToString()));

                    }
                    this.hid_Album.Value = this.DDP_Album.SelectedItem.Value;
                }

            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "UploadPhoto_BindAlbum");
            }
        }

        protected void DDP_Album_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.hid_Album.Value = this.DDP_Album.SelectedValue;
        }
    }
}
