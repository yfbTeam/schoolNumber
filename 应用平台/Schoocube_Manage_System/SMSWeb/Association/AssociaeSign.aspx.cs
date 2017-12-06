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
    public partial class AssociaeSign : System.Web.UI.Page
    {
        //  LogCommon com = new LogCommon();
        public AssoInfoService assoservice = new AssoInfoService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindAssociae();//绑定全部社团
            }
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
                string Query = "AssoStatus='开放'";
                DataTable items = assoservice.GetData(Query, null);
                foreach (DataRow item in items.Rows)
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
                LogService.WriteErrorLog("AssociationMgr.BindAssociae|||" + ex.Message);
                ErrorLog.writeLogMessage(ex.Message, "AssociationMgr.BindAssociae");
            }
        }
        protected void LV_TermList_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            DPTeacher.SetPageProperties(DPTeacher.StartRowIndex, e.MaximumRows, false);
            BindAssociae();
        }
    }
}