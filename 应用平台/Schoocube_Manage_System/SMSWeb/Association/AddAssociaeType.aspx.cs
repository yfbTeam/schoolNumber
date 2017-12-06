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
    public partial class AddAssociaeType : System.Web.UI.Page
    {
       // LogCommon com = new LogCommon();
       // private SPList AssociaeList { get { return ListHelp.GetCureenWebList("社团信息", false); } }
        private AssoInfoService assoservice = new AssoInfoService();
        private AssoTypeService assotypeservice = new AssoTypeService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindType();
            }
        }

        private void BindType()
        {
            try
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("Type");
                //社团类型
                DataTable typedt= assotypeservice.GetData(null, null);

                LV_TermList.DataSource = typedt;
                LV_TermList.DataBind();
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "AddAssociaeType.Page_Load");
            }
        }

        protected void LV_TermList_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            try
            {
                     
                bool iscun= assoservice.CheckForeignKey("AssoType",e.CommandArgument.SafeToString("0"));
                if(iscun){

                    return;
                }
               bool result=  assotypeservice.Delete(int.Parse(e.CommandArgument.SafeToString("0")));
                    
              
                BindType();
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "AddAssociaeType.LV_TermList_ItemCommand");
            }
        }
        protected void btnOK_Click(object sender, EventArgs e)
        {
            try
            {
                string type = this.TB_Type.Text.Trim();
                bool iscun = assotypeservice.CheckForeignKey("Title", type);
                if (iscun)
                {
                    return;
                }
                AssoType typeinfo = new AssoType();

                typeinfo.Title = type;
                bool result = assotypeservice.Add(typeinfo);
                    
                BindType();
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "AddAssociaeType.btnOK_Click");
            }
        }
    }
}
