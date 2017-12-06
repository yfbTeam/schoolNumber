using SMSBLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMSModel;
using System.Data;
using SMSUtility;

namespace SMSWeb.Association
{
    public partial class AddAssociaeSet : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                AssoSetService assoservice = new AssoSetService();
                DataTable assodt = assoservice.GetData(null, null);
                DataRow dr = assodt.Rows[0];
                if (dr["IsOnly"].SafeToString() == "1")
                {
                    this.ckIsOnly.Checked = true;
                }
                else { this.ckIsOnly.Checked = false; }
                this.dtStartDate.Value = dr["StartDate"].SafeToString();
                this.dtEndDate.Value = dr["EndDate"].SafeToString();
            }
        }
        protected void Btn_InfoSave_Click(object sender, EventArgs e)
        {
            string script = "parent.window.location.href='AssociationMgr.aspx';";
            try
            {
                AssoSetService assoservice = new AssoSetService();
               List<AssoSet> assosetlist=  assoservice.GetEntityListByField("1","1");
                AssoSet asso = assosetlist[0];
                asso.IsOnly = this.ckIsOnly.Checked ? 2 : 1;
                asso.StartDate = DateTime.Parse(this.dtStartDate.Value);
                asso.EndDate = DateTime.Parse(this.dtEndDate.Value);
                
                assoservice.Update(asso);
            }
            catch (Exception ex)
            {
                script = "alert('保存失败，请重试...');";
                ErrorLog.writeLogMessage(ex.Message, "AddAssociaeSet.Btn_InfoSave_Click");
            }
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), script, true);
        }
    }
}