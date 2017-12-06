using SMSUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.SysMessage
{
    public partial class DataBackUp : System.Web.UI.Page
    {
        public static DataTable g_dt = null;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnBackUp_Click(object sender, EventArgs e)
        {
            SysDataBaseBackUp sdbb = new SysDataBaseBackUp();
            string CurrTime = System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            CurrTime = CurrTime.Replace("-", "");
            CurrTime = CurrTime.Replace(":", "");
            CurrTime = CurrTime.Replace(" ", "");
            CurrTime = CurrTime.Substring(0, 12);
            sdbb.restoreFile = "C:\\_db_Schoo_Cube_" + CurrTime + ".BAK";
            bool result = sdbb.Operate(true);
            if (result)
            {
                SMSBLL.DBBackUpLogService dls = new SMSBLL.DBBackUpLogService();
                SMSModel.DBBackUpLog item = new SMSModel.DBBackUpLog();
                item.Path = sdbb.restoreFile;
                item.CreateTime = DateTime.Now;
                item.Type = 1;//手动备份
                dls.Add(item);
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('备份成功！');</script>");
            }
            //BindData();
        }

    }
}