using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.Portal.SysSetting
{
    public partial class Setting : System.Web.UI.Page
    {
        protected int id = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            MenuId.Value = Request.QueryString["id"];
            if (!IsPostBack)
            {
                readXmlPage();
                readXmlUserAgreement();
                initQuartz();
            }
        }

        protected void btnChangeNum_Click(object sender, EventArgs e)
        {
            string xmlpath = "Portal\\SysData.xml";
            XmlHelper.SetValue(xmlpath, "NoticePages", this.PageNumber.Value);
        }

        protected void readXmlPage()
        {
            string xmlpath = "Portal\\SysData.xml";
            string val = XmlHelper.GetValue(xmlpath, "NoticePages");
            PageNumber.Value = val;
        }


        protected void readXmlUserAgreement()
        {
            string xmlpath = "Portal\\SysData.xml";
            string val = XmlHelper.GetValue(xmlpath, "UserAgreement");
            editor_id.Text = val;
        }

        protected void btnSaveUser_Click(object sender, EventArgs e)
        {
            string xmlpath = "Portal\\SysData.xml";
            XmlHelper.SetValue(xmlpath, "UserAgreement", this.editor_id.Text);
        }

        protected void initQuartz()
        {
            //DataTable dt = new DataTable();
            //dt.Columns.Add("id",typeof(string));
            //dt.Columns.Add("name",typeof(string));
            //dt.Columns.Add("num", typeof(string));
            //dt.Columns.Add("time", typeof(string));
            //dt.Columns.Add("desc", typeof(string));
            //Dictionary<string, string> dc = new Dictionary<string, string>();
            //dc.Add("提交作业通知", "每十五分钟通知一次");
            //dc.Add("调查问卷通知", "每十五分钟通知一次");
            //dc.Add("上课通知", "每十分钟通知一次");
            //dc.Add("待批试卷通知", "每十五分钟通知一次");
            //dc.Add("资源审核通知", "每十五分钟通知一次");
            //dc.Add("学生考试通知", "每十五分钟通知一次");
            //dc.Add("学生报名通知", "每十五分钟通知一次");
            //dc.Add("学生做任务通知", "每十五分钟通知一次");
            //dc.Add("数据备份通知", "每天23：59分备份一次");
            //dc.Add("系统通知", "每十五分钟通知一次");
            //dc.Add("待批该作业通知", "每十五分钟通知一次");
            //dc.Add("未提交作业通知", "每天00：01通知一次");
            //int num = 1;
            //foreach (KeyValuePair<string,string> kv in dc)
            //{
            //    DataRow dr = dt.NewRow();
            //    dr["id"] = num;
            //    dr["name"] = kv.Key;
            //    dr["num"] = 15;
            //    dr["time"] = "min";
            //    dr["desc"] = kv.Value;
            //    dt.Rows.Add(dr);
            //    num++;
            //}
            Hashtable ht = new Hashtable();
            ht.Add("TableName", "System_Timing");
            SMSBLL.System_TimingService BllSTS = new SMSBLL.System_TimingService();
            DataTable dt = BllSTS.GetData(ht, false, string.Empty);
            this.Repeater1.DataSource = dt;
            this.Repeater1.DataBind();
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                id = int.Parse(e.CommandArgument.ToString());
            }
            else if (e.CommandName == "Cancel")
            {
                id = -1;
            }
            else if (e.CommandName == "Update")
            {
                string name = ((TextBox)this.Repeater1.Items[e.Item.ItemIndex].FindControl("txtname")).Text.Trim();
                string num = ((TextBox)this.Repeater1.Items[e.Item.ItemIndex].FindControl("txtnum")).Text.Trim();
                string desc = ((TextBox)this.Repeater1.Items[e.Item.ItemIndex].FindControl("txtdesc")).Text.Trim();
                string id = ((HiddenField)this.Repeater1.Items[e.Item.ItemIndex].FindControl("hidid")).Value;
                SMSModel.System_Timing item = new SMSModel.System_Timing();
                item.id = int.Parse(id);
                item.name = name;
                item.tdesc = desc;
                item.num = int.Parse(num);
                SMSModel.JsonModel jsonModel = new SMSBLL.System_TimingService().Update(item);
                if (jsonModel.errNum == 0)
                {

                }
            }
            initQuartz();
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                //System.Data.Common.DbDataRecord record = (System.Data.Common.DbDataRecord)e.Item.DataItem;
                HiddenField hidControl = ((HiddenField)e.Item.FindControl("hidid"));
                if (hidControl != null)
                {
                    int hid = int.Parse(hidControl.Value);
                    if (hid != id)
                    {
                        ((Panel)e.Item.FindControl("plItem")).Visible = true;
                        ((Panel)e.Item.FindControl("plEdit")).Visible = false;
                    }
                    else
                    {
                        ((Panel)e.Item.FindControl("plItem")).Visible = false;
                        ((Panel)e.Item.FindControl("plEdit")).Visible = true;
                    }
                }
            }
        }



    }
}