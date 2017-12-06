using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SMSUtility;
using SMSBLL;
using SMSModel;

namespace SMSWeb.Association
{
    public partial class AssociaeMember : System.Web.UI.Page
    {
        LogCommon com = new LogCommon();
        private AssoInfoService assoservice = new AssoInfoService();
        private AssoMemberService memberservice = new AssoMemberService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               // btnReload_Click();
            }
        }

        //private void BindAssociaeData()
        //{
        //    try
        //    {
        //        //左侧社团
        //        DataTable data = new DataTable();
        //        string[] arrCol = new string[] { "ID", "Associae" };
        //        foreach (string column in arrCol)
        //        {
        //            data.Columns.Add(column);
        //        }
        //        DataTable items = assoservice.GetData( "AssoStatus='开放'",null);
        //        foreach (DataRow item in items.Rows)
        //        {
        //            DataRow dr = data.NewRow(); 
        //            dr["ID"] = item["ID"];
        //            dr["Associae"] = item["Title"];
        //            data.Rows.Add(dr);
        //        }
        //        this.lvGroup.DataSource = data;
        //        this.lvGroup.DataBind();
        //    }
        //    catch (Exception ex)
        //    {
        //        com.writeLogMessage(ex.Message, "AssociaeMember.BindAssociaeData");
        //    }
        //}

        //protected void btnRem_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        if (!string.IsNullOrEmpty(this.AssociaeId.Value))
        //        {
        //            DataTable members = memberservice.GetData("AssoId=" + this.AssociaeId.Value, null);
        //            foreach (DataRow item in members.Rows)
        //            {
        //                string name = item["Member"].SafeLookUpToString();
        //                item.Delete();
        //                //更改社团长或副团长
        //                SPList asslist = oWeb.Lists.TryGetList("社团信息");
        //                if (name == this.lb_Leader.Text) //社团长
        //                {
        //                    SPListItem assitem = asslist.GetItemById(Convert.ToInt32(this.AssociaeId.Value));
        //                    assitem["Leader"] = null;
        //                    assitem.SystemUpdate();
        //                }
        //                if (name == this.lb_SecLeader.Text) //副团长
        //                {
        //                    SPListItem assitem = asslist.GetItemById(Convert.ToInt32(this.AssociaeId.Value));
        //                    assitem["SecondLeader"] = null;
        //                    assitem.SystemUpdate();
        //                }

        //            }

        //            this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "alert('移除成功');", true);
        //            this.btnReload_Click(null, null);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        com.writeLogMessage(ex.Message, "AssociaeMember.btnRem_Click");
        //    }
        //}

        //protected void btnReload_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        DataTable data = new DataTable();
        //        string[] arrCol = new string[] { "ID", "Name", "Sex", "Class", "OP" };
        //        foreach (string column in arrCol)
        //        {
        //            data.Columns.Add(column);
        //        }
        //        if (!string.IsNullOrEmpty(this.AssociaeId.Value))
        //        {
        //            SPListItem item = AssociaeList.GetItemById(Convert.ToInt32(this.AssociaeId.Value));
        //            //社团长
        //            string leader = string.Empty;
        //            object objleader = item["Leader"];
        //            if (objleader != null)
        //            {
        //                this.lb_Leader.Text = objleader.SafeLookUpToString();
        //                leader = objleader.SafeToString().Split(';')[0];
        //                SPUser user = MemeberList.ParentWeb.AllUsers.GetByID(Convert.ToInt32(leader));
        //                string loginname = ListHelp.GetLoginname(user);
        //                DataTable dtstu = HelpXML.LoadClassByLoginID(loginname);
        //                if (dtstu.Rows.Count > 0)
        //                {
        //                    DataRow dr = data.NewRow();
        //                    dr["Name"] = this.lb_Leader.Text;
        //                    dr["Class"] = dtstu.Rows[0]["Class"];
        //                    dr["Sex"] = dtstu.Rows[0]["Sex"];
        //                    dr["OP"] = "社团长";
        //                    data.Rows.Add(dr);
        //                }
        //            }
        //            else
        //            {
        //                this.lb_Leader.Text = "--";
        //            }
        //            //副团长
        //            string secleader = string.Empty;
        //            object objsecleader = item["SecondLeader"];
        //            if (objsecleader != null)
        //            {
        //                this.lb_SecLeader.Text = objsecleader.SafeLookUpToString();
        //                secleader = objsecleader.SafeToString().Split(';')[0];
        //                SPUser secuser = MemeberList.ParentWeb.AllUsers.GetByID(Convert.ToInt32(secleader));
        //                string seclogin = ListHelp.GetLoginname(secuser);
        //                DataTable dtsecstu = HelpXML.LoadClassByLoginID(seclogin);
        //                if (dtsecstu.Rows.Count > 0)
        //                {
        //                    DataRow dr = data.NewRow();
        //                    dr["Name"] = this.lb_SecLeader.Text;
        //                    dr["Class"] = dtsecstu.Rows[0]["Class"];
        //                    dr["Sex"] = dtsecstu.Rows[0]["Sex"];
        //                    dr["OP"] = "副团长";
        //                    data.Rows.Add(dr);
        //                }
        //            }
        //            else
        //            {
        //                this.lb_SecLeader.Text = "--";
        //            }
        //            //社团成员
        //            SPListItemCollection items = MemeberList.GetItems(new SPQuery() { Query = "<Where><Eq><FieldRef Name='AssociaeID' /><Value Type='Number'>" + this.AssociaeId.Value + "</Value></Eq></Where>" });
        //            foreach (SPListItem mItem in items)
        //            {
        //                string memid = mItem["Member"].SafeToString().Split(';')[0];
        //                if (memid != leader && memid != secleader)
        //                {
        //                    DataRow dr = data.NewRow();
        //                    dr["ID"] = mItem.ID;
        //                    dr["Name"] = mItem["Member"].SafeLookUpToString();
        //                    SPUser comuser = MemeberList.ParentWeb.AllUsers.GetByID(Convert.ToInt32(memid));
        //                    string comlogin = ListHelp.GetLoginname(comuser);
        //                    DataTable dtcomstu = HelpXML.LoadClassByLoginID(comlogin);
        //                    if (dtcomstu.Rows.Count > 0)
        //                    {
        //                        dr["Class"] = dtcomstu.Rows[0]["Class"];
        //                        dr["Sex"] = dtcomstu.Rows[0]["Sex"];
        //                        dr["OP"] = "<input type=\"button\" class=\"btn\" onclick=\"editItem(0," + memid + ")\" value=\"任命团长\" /><input type=\"button\" class=\"btn\" onclick=\"editItem(1," + memid + ")\" value=\"任命副团\" />";
        //                    }
        //                    data.Rows.Add(dr);
        //                }
        //                else
        //                {
        //                    int i = 0;
        //                    if (leader != "" && secleader != "")
        //                    {
        //                        if (memid == secleader)
        //                        {
        //                            i = 1;
        //                        }
        //                    }
        //                    data.Rows[i]["ID"] = mItem.ID;
        //                }
        //            }
        //        }
        //        this.lvRow.DataSource = data;
        //        this.lvRow.DataBind();
        //    }
        //    catch (Exception ex)
        //    {
        //        com.writeLogMessage(ex.Message, "AssociaeMember.btnReload_Click");
        //    }
        //}

        //protected void btnManage_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        if (!string.IsNullOrEmpty(this.Manager.Value))
        //        {
        //            string[] mager = this.Manager.Value.Split(',');

        //            SPList list = oWeb.Lists.TryGetList("社团信息");
        //            if (!string.IsNullOrEmpty(this.AssociaeId.Value))
        //            {
        //                SPListItem item = list.GetItemById(Convert.ToInt32(this.AssociaeId.Value));
        //                int memid = Convert.ToInt32(mager[1]);
        //                SPUser user = oWeb.AllUsers.GetByID(memid);
        //                if (mager[0] == "0")
        //                {
        //                    item["Leader"] = new SPFieldUserValue(oWeb, memid, user.Name);
        //                }
        //                if (mager[0] == "1")
        //                {
        //                    item["SecondLeader"] = new SPFieldUserValue(oWeb, memid, user.Name);
        //                }
        //                item.Update();
        //            }

        //            this.Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "alert('任命成功！');", true);
        //            this.btnReload_Click(null, null);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        com.writeLogMessage(ex.Message, "AssociaeMember.btnManage_Click");
        //    }
        //}

        protected void lvRow_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            DataPager.SetPageProperties(DataPager.StartRowIndex, e.MaximumRows, false);
            //this.btnReload_Click(null, null);
        }
    }
}