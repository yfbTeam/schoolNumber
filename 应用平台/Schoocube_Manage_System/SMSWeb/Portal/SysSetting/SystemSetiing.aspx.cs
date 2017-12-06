using SMSUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Xml;

namespace SMSWeb.Portal.SysSetting
{
    public partial class SystemSetiing : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                initData();
                initHandData();
            }
            
        }

        public void initData()
        {
            string filename = Server.MapPath("/") + @"\web.config";
            XmlDocument xmldoc = new XmlDocument();
            xmldoc.Load(filename);
            XmlNodeList topM = xmldoc.DocumentElement.ChildNodes;
            foreach (XmlElement element in topM)
            {
                if (element.Name.ToLower() == "appsettings")
                {
                    XmlNodeList _node = element.ChildNodes;
                    if (_node.Count > 0)
                    {
                        foreach (XmlElement el in _node)
                        {
                            HtmlTableRow r = new HtmlTableRow();
                            HtmlTableCell c1 = new HtmlTableCell();
                            HtmlTableCell c2 = new HtmlTableCell();
                            var key = el.Attributes["key"].InnerXml;
                            var val = el.Attributes["value"].InnerXml;
                            c1.Controls.Add(new LiteralControl(key));
                            c2.Controls.Add(new LiteralControl("<input type=\"text\" id=\"appsettings_" + key + "\" value=\"" + val + "\" key=\"" + key + "\">"));
                            r.Cells.Add(c1);
                            r.Cells.Add(c2);
                            tabConfig.Rows.Add(r);
                        }
                    }
                }
                else if (element.Name.ToLower() == "connectionstrings")
                {
                    XmlNodeList _node = element.ChildNodes;
                    if (_node.Count > 0)
                    {
                        foreach (XmlNode el in _node)
                        {
                            XmlElement xe = el as XmlElement;
                            if (xe != null)
                            {
                                HtmlTableRow r = new HtmlTableRow();
                                HtmlTableCell c1 = new HtmlTableCell();
                                HtmlTableCell c2 = new HtmlTableCell();
                                var key = xe.Attributes["name"].InnerXml;
                                var val = xe.Attributes["connectionString"].InnerXml;
                                c1.Controls.Add(new LiteralControl(key));
                                c2.Controls.Add(new LiteralControl("<input type=\"text\" id=\"connectionstrings_" + key + "\" value=\"" + val + "\" key=\"" + key + "\">"));
                                r.Cells.Add(c1);
                                r.Cells.Add(c2);
                                tabConnectConfig.Rows.Add(r);
                            }
                        }
                    }
                }
            }

        }

        public void initHandData() 
        {
            string prePath = Request.PhysicalApplicationPath.ToString();
            prePath = prePath.Substring(0, prePath.LastIndexOf("\\"));
            prePath = prePath.Substring(0, prePath.LastIndexOf("\\"));
            string filename = prePath + @"\SMSHanderler\web.config";
            XmlDocument xmldoc = new XmlDocument();
            xmldoc.Load(filename);
            XmlNodeList topM = xmldoc.DocumentElement.ChildNodes;
            foreach (XmlElement element in topM) 
            {
                if (element.Name.ToLower() == "connectionstrings")
                {
                    XmlNodeList _node = element.ChildNodes;
                    if (_node.Count > 0)
                    {
                        foreach (XmlNode el in _node)
                        {
                            XmlElement xe = el as XmlElement;
                            if (xe != null)
                            {
                                HtmlTableRow r = new HtmlTableRow();
                                HtmlTableCell c1 = new HtmlTableCell();
                                HtmlTableCell c2 = new HtmlTableCell();
                                var key = xe.Attributes["name"].InnerXml;
                                var val = xe.Attributes["connectionString"].InnerXml;
                                c1.Controls.Add(new LiteralControl(key));
                                c2.Controls.Add(new LiteralControl("<input type=\"text\" id=\"hand_" + key + "\" value=\"" + val + "\" key=\"" + key + "\">"));
                                r.Cells.Add(c1);
                                r.Cells.Add(c2);
                                tabHandConfig.Rows.Add(r);
                            }
                        }
                    }
                }
            }
        }

        protected void btnApp_Click(object sender, EventArgs e)
        {
            string hidValue = hidApp.Value;
            try
            {
                if (!string.IsNullOrWhiteSpace(hidValue))
                {
                    string filename = Server.MapPath("/") + @"\web.config";
                    XmlDocument xmldoc = new XmlDocument();
                    xmldoc.Load(filename);
                    XmlNodeList topM = xmldoc.DocumentElement.ChildNodes;
                    string[] arry = hidValue.Split(',');
                    if (arry.Length > 0)
                    {
                        foreach (XmlElement element in topM)
                        {
                            if (element.Name.ToLower() == "appsettings")
                            {
                                XmlNodeList _node = element.ChildNodes;
                                if (_node.Count > 0)
                                {
                                    for (int i = 0; i < arry.Length; i++)
                                    {
                                        string[] item = arry[i].Split(':');
                                        if (item != null && item.Length == 2)
                                        {
                                            foreach (XmlElement el in _node)
                                            {
                                                var key = el.Attributes["key"].InnerXml;
                                                if (item[0] == key)
                                                {
                                                    if (item[1] != el.Attributes["value"].Value) LogHelper.Info("修改系统参数appsettings中key=" + key + ",原值value=" + el.Attributes["value"].Value + "新值value=" + item[1]);
                                                    el.Attributes["value"].Value = item[1];
                                                }
                                            }
                                        }
                                    }
                                    break;
                                }
                            }
                        }
                        xmldoc.Save(filename);
                    }
                }
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('修改成功！');window.location.href=window.location.href;</script>");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
            }
            
        }

        protected void btnConn_Click(object sender, EventArgs e)
        {
            try
            {
                string hidValue = hidConn.Value;
                if (!string.IsNullOrWhiteSpace(hidValue))
                {
                    string filename = Server.MapPath("/") + @"\web.config";
                    XmlDocument xmldoc = new XmlDocument();
                    xmldoc.Load(filename);
                    XmlNodeList topM = xmldoc.DocumentElement.ChildNodes;
                    string[] arry = hidValue.Split(',');
                    if (arry.Length > 0)
                    {
                        foreach (XmlElement element in topM)
                        {
                            if (element.Name.ToLower() == "connectionstrings")
                            {
                                XmlNodeList _node = element.ChildNodes;
                                if (_node.Count > 0)
                                {
                                    for (int i = 0; i < arry.Length; i++)
                                    {
                                        string[] item = arry[i].Split(':');
                                        if (item != null && item.Length == 2)
                                        {
                                            foreach (XmlNode el in _node)
                                            {
                                                XmlElement xe = el as XmlElement;
                                                if (xe != null)
                                                {
                                                    var key = xe.Attributes["name"].InnerXml;
                                                    var val = xe.Attributes["connectionString"].InnerXml;
                                                    if (item[0] == key)
                                                    {
                                                        if (item[1] != el.Attributes["connectionString"].Value) LogHelper.Info("修改系统参数connectionstrings中name=" + key + ",原值connectionString=" + el.Attributes["connectionString"].Value + "新值connectionString=" + item[1]);
                                                        xe.Attributes["connectionString"].Value = item[1];
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    break;
                                }
                            }
                        }
                        xmldoc.Save(filename);
                    }
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('修改成功！');window.location.href=window.location.href;</script>");
                }
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
            }
            
        }

        protected void btnHand_Click(object sender, EventArgs e)
        {
            try
            {
                string hidValue = hidHand.Value;
                if (!string.IsNullOrWhiteSpace(hidValue))
                {
                    string prePath = Request.PhysicalApplicationPath.ToString();
                    prePath = prePath.Substring(0, prePath.LastIndexOf("\\"));
                    prePath = prePath.Substring(0, prePath.LastIndexOf("\\"));
                    string filename = prePath + @"\SMSHanderler\web.config";
                    XmlDocument xmldoc = new XmlDocument();
                    xmldoc.Load(filename);
                    XmlNodeList topM = xmldoc.DocumentElement.ChildNodes;
                    string[] arry = hidValue.Split(',');
                    if (arry.Length > 0)
                    {
                        foreach (XmlElement element in topM)
                        {
                            if (element.Name.ToLower() == "connectionstrings")
                            {
                                XmlNodeList _node = element.ChildNodes;
                                if (_node.Count > 0)
                                {
                                    for (int i = 0; i < arry.Length; i++)
                                    {
                                        string[] item = arry[i].Split(':');
                                        if (item != null && item.Length == 2)
                                        {
                                            foreach (XmlNode el in _node)
                                            {
                                                XmlElement xe = el as XmlElement;
                                                if (xe != null)
                                                {
                                                    var key = xe.Attributes["name"].InnerXml;
                                                    var val = xe.Attributes["connectionString"].InnerXml;
                                                    if (item[0] == key)
                                                    {
                                                        if (item[1] != el.Attributes["connectionString"].Value) LogHelper.Info("修改系统参数Handler下connectionstrings中name=" + key + ",原值connectionString=" + el.Attributes["connectionString"].Value + "新值connectionString=" + item[1]);
                                                        xe.Attributes["connectionString"].Value = item[1];
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    break;
                                }
                            }
                        }
                        xmldoc.Save(filename);
                    }
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('修改成功！');window.location.href=window.location.href;</script>");
                }
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
            }
        }
    }
}