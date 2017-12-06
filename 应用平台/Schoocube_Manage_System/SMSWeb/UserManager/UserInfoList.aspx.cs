using SMSBLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.UserManager
{
    public partial class UserInfoList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                GetAllUser(null);
                
            }
        }

        protected void Btn_Search_Click(object sender, EventArgs e)
        {
            
        }

        protected void LV_UserManager_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            
            //DP_UserManager.SetPageProperties(DP_UserManager.StartRowIndex, e.MaximumRows, false);
            //GetAllUser(null);
        }
        

        private void GetAllUser(string condition)
        {
            //UserInfoService service = new UserInfoService();
            //DataTable dt = service.GetAllUser(condition);
            //LV_UserManager.DataSource = dt;
            //LV_UserManager.DataBind();
        }
    }
}