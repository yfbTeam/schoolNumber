using SMSUtility;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Portal.TimingBackup
{
    public partial class DataBackUp : System.Web.UI.Page
    {
        public static DataTable g_dt = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //BindData();
            }
        }
        protected void BindData(string id = "")
        {
            string path = System.Configuration.ConfigurationManager.AppSettings["backUpDataPath"] + "//";
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            DataTable dt = new DataTable();
            dt.Columns.Add("id", typeof(string));
            dt.Columns.Add("title", typeof(string));
            dt.Columns.Add("path", typeof(string));
            dt.Columns.Add("size", typeof(string));
            dt.Columns.Add("LastWriteTime", typeof(string));
            GetAllFiles(path, ref dt);
            g_dt = dt;
            //if (dt != null && dt.Rows.Count > 0)
            //{
            //    this.GridView1.DataSource = dt;
            //    GridView1.DataBind();
            //}
            //else
            //{
            //    GridView1.DataSource = null;
            //    GridView1.DataBind();
            //}

        }

        /// <summary>
        /// 遍历 rootdir目录下的所有文件
        /// </summary>
        /// <param name="rootdir">目录名称</param>
        /// <returns>该目录下的所有文件</returns>
        public void GetAllFiles(string rootdir, ref DataTable dt)
        {
            DirectoryInfo di = new DirectoryInfo(rootdir);
            int num = 0;
            foreach (FileInfo fi in di.GetFiles())
            {
                DataRow dr = dt.NewRow();
                num++;
                dr["id"] = num;
                dr["title"] = fi.Name;
                dr["path"] = fi.FullName;
                dr["size"] = fi.Length;
                dr["LastWriteTime"] = fi.LastWriteTime.ToString();//最后修改时间
                dt.Rows.Add(dr);
            }
            DataView dv = dt.DefaultView;
            dv.Sort = "LastWriteTime desc";
            dt = dv.ToTable();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //GridView1.PageIndex = e.NewPageIndex;
            //BindData();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

            //GridView1.EditIndex = -1;
            //BindData();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //如果是绑定数据行 
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    //鼠标经过时，行背景色变 
            //    e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#E6F5FA'");
            //    //鼠标移出时，行背景色变 
            //    e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='#FFFFFF'");
            //    if (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate)
            //    {
            //        ((LinkButton)e.Row.Cells[5].Controls[0]).Attributes.Add("onclick", "javascript:return confirm('你确认还原此项数据吗?')");
            //    }
            //}
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //string number = GridView1.DataKeys[e.RowIndex].Value.ToString();
            //if (g_dt != null)
            //{
            //    var items = g_dt.AsEnumerable().Where(p => p.Field<string>("id") == number).ToList();
            //    try
            //    {
            //        foreach (DataRow row in items)
            //        {
            //            SysDataBaseBackUp sdbb = new SysDataBaseBackUp();
            //            sdbb.RestoreFile = row["path"].ToString();
            //            string result = sdbb.DbRestore();
            //            Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('" + result + "！');</script>");
            //        }
            //    }
            //    catch (Exception ex)
            //    {

            //    }

            //}
            //BindData();
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