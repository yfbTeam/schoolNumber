using SMSBLL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SMSHanderler.PortalManage
{
    /// <summary>
    /// MessageHandler 的摘要说明
    /// </summary>
    public class MessageHandler : IHttpHandler
    {
        SMSBLL.System_MessageService BllSMS = new SMSBLL.System_MessageService();
        SMSBLL.SysMessageService BllMS = new SMSBLL.SysMessageService();
        SMSBLL.CourseService BllCS = new SMSBLL.CourseService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request["func"];
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "GetPageList": GetPageList(context); break;
                    case "UpdateMessage": UpdateMessage(context); break;
                    case "EditMessage": EditMessage(context); break;
                    case "ReaderMessage": ReaderMessage(context); break;
                    case "GetMessage": GetMessage(context); break;
                    case "MoreSendMessage": MoreSendMessage(context); break;
                    case "AdminSendMessage": AdminSendMessage(context); break;
                    case "WebMessage": WebMessage(context); break;
                    case "SendMessageForCourse": SendMessageForCourse(context); break;

                }
            }
            else
            {
                context.Response.Write("System Error");
            }
        }

        public void GetPageList(HttpContext context)
        {
            try
            {
                bool Ispage = true;
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("TableName", "System_Message");
                if (!string.IsNullOrWhiteSpace(context.Request["Ispage"]))
                {
                    Ispage = Convert.ToBoolean(context.Request["Ispage"]);
                }
                string where = string.Empty;
                if (!string.IsNullOrWhiteSpace(context.Request["type"]))
                    where += " and [type]=" + context.Request["type"].ToString();
                if (!string.IsNullOrWhiteSpace(context.Request["Status"]))
                    where += " and [Status]=" + context.Request["Status"].ToString();
                if (!string.IsNullOrWhiteSpace(context.Request["Creator"]))
                    where += " and [Creator]='" + context.Request["Creator"].ToString() + "'";
                if (!string.IsNullOrWhiteSpace(context.Request["Receiver"]))
                    where += " and [Receiver]='" + context.Request["Receiver"].ToString() + "'";
                if (!string.IsNullOrWhiteSpace(context.Request["StarDate"]) && !string.IsNullOrWhiteSpace(context.Request["EndDate"]))
                    where += " and (CreateTime<='" + context.Request["EndDate"] + " 23:59:59' and CreateTime>='" + context.Request["StarDate"] + " 00:00:01')";
                where += " and IsDelete !=" + (int)SysStatus.删除;
                ht.Add("Order", "CreateTime desc");
                SMSModel.JsonModel Model = BllSMS.GetPage(ht, Ispage, where);
                System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
                context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    retData = "",
                    status = "no"
                };
                System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void UpdateMessage(HttpContext context)
        {
            if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
            {
                System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
                try
                {
                    SMSModel.System_Message sn = BllSMS.GetEntityById(int.Parse(context.Request["Id"])).retData as SMSModel.System_Message;
                    if (sn != null)
                    {
                        if (!string.IsNullOrWhiteSpace(context.Request["Status"]))
                            sn.Status = Convert.ToByte(context.Request["Status"]);
                        if (!string.IsNullOrWhiteSpace(context.Request["IsDelete"]))
                            sn.IsDelete = Convert.ToByte(context.Request["IsDelete"]);
                        sn.Id = int.Parse(context.Request["id"]);
                        SMSModel.JsonModel jsonModel = BllSMS.Update(sn);
                        jsonModel.errMsg = sn.Href;
                        context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
                    }
                }
                catch (Exception ex)
                {
                    SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                    {
                        errMsg = ex.Message,
                        retData = "",
                        status = "no"
                    };
                    context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
                }
            }
        }

        public void EditMessage(HttpContext context)
        {
            SMSModel.JsonModel jsonModel = new SMSModel.JsonModel();
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                SMSModel.System_Message sm = new SMSModel.System_Message();
                sm.Contents = context.Request["Contents"];//内容
                sm.Title = context.Request["Title"];//标题
                sm.Type = int.Parse(context.Request["Type"]);
                sm.Status = Convert.ToByte((int)MessageStatus.未读);
                sm.CreateTime = DateTime.Now;
                sm.Creator = context.Request["Creator"];//发送人
                sm.Receiver = context.Request["Receiver"];//接受人
                sm.Href = context.Request["Href"];//链接地址（可不提供）
                sm.ReceiverEmail = context.Request["ReceiverEmail"];//收件邮箱
                sm.IsDelete = Convert.ToByte((int)SysStatus.正常);
                sm.isSend = Convert.ToByte((int)isSend.未发送);
                sm.CreatorName = context.Request["CreatorName"];
                sm.ReceiverName = context.Request["ReceiverName"];
                sm.FilePath = context.Request["FilePath"];
                sm.Timing = string.IsNullOrWhiteSpace(context.Request["Timing"]) ? Convert.ToByte((int)MessageTiming.立即发送) : Convert.ToByte((int)MessageTiming.定时发送);
                jsonModel = BllSMS.Add(sm);
                jsonModel.status = "ok";
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    retData = "",
                    status = "no"
                };

                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void ReaderMessage(HttpContext context)
        {
            SMSModel.JsonModel jsonModel = new SMSModel.JsonModel();
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ids", context.Request["ids"]);
                if (!string.IsNullOrWhiteSpace(context.Request["Status"]))
                    ht.Add("Status", context.Request["Status"]);
                if (!string.IsNullOrWhiteSpace(context.Request["IsDelete"]))
                    ht.Add("IsDelete", context.Request["IsDelete"]);
                if (!string.IsNullOrWhiteSpace(context.Request["Receiver"]))
                    ht.Add("Receiver", context.Request["Receiver"]);
                jsonModel = BllMS.ReaderMessage(ht);
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    retData = "",
                };

                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void GetMessage(HttpContext context)
        {
            SMSModel.JsonModel jsonModel = new SMSModel.JsonModel();
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    jsonModel = BllSMS.GetEntityById(int.Parse(context.Request["Id"]));
                }
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    retData = "",
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }
        private void WebMessage(HttpContext context)
        {
            System_MessageService bll = new System_MessageService();
            System_Message model = new System_Message();
            SMSModel.JsonModel jsonModel = new SMSModel.JsonModel();
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                if (!string.IsNullOrWhiteSpace(context.Request["Receivers"]))
                {
                    List<SMSModel.System_Message> list = jss.Deserialize<List<SMSModel.System_Message>>(context.Request["Receivers"]);
                    Hashtable ht = new Hashtable();
                    string Creator = context.Request["Creator"].SafeToString();
                    string CreatorName = context.Request["CreatorName"].SafeToString();
                    string Title = context.Request["Title"].SafeToString();
                    string Contents = HttpUtility.UrlDecode(context.Request["Contents"]).SafeToString();
                    string Type = context.Request["Type"].SafeToString();

                    string date = string.IsNullOrWhiteSpace(context.Request["CreateTime"]) ? DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") : context.Request["CreateTime"];
                    for (int i = 0; i < list.Count; i++)
                    {
                        model.CreateTime = Convert.ToDateTime(date);
                        model.Creator = Creator;
                        model.CreatorName = CreatorName;
                        model.Title = Title;
                        model.Contents = Contents;
                        model.Type = int.Parse(Type);
                        model.Receiver = list[i].Receiver;
                       jsonModel= bll.Add(model);
                    }
                    //jsonModel = BllMS.SendMessage(ht, list);
                    context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
                }
            }
            catch (Exception ex)
            {
                jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }
        public void MoreSendMessage(HttpContext context)
        {
            SMSModel.JsonModel jsonModel = new SMSModel.JsonModel();
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                if (!string.IsNullOrWhiteSpace(context.Request["Receivers"]))
                {
                    List<SMSModel.System_Message> list = jss.Deserialize<List<SMSModel.System_Message>>(context.Request["Receivers"]);
                    bool isend = string.IsNullOrWhiteSpace(context.Request["isSendEmail"]) ? false : Convert.ToBoolean(context.Request["isSendEmail"]);
                    Hashtable ht = new Hashtable();
                    ht.Add("Creator", context.Request["Creator"]);
                    ht.Add("CreatorName", context.Request["CreatorName"]);
                    ht.Add("Title", context.Request["Title"]);
                    ht.Add("Contents", HttpUtility.UrlDecode(context.Request["Contents"]));
                    ht.Add("Timing", context.Request["Timing"]);
                    ht.Add("FilePath", context.Request["FilePath"]);
                    ht.Add("isSendEmail", isend);
                    ht.Add("Type", context.Request["Type"]);
                    if (!string.IsNullOrWhiteSpace(context.Request["FilePath"]))
                    {
                        string path = context.Server.MapPath("/");
                        string preth = path.Substring(0, path.LastIndexOf("\\"));
                        preth = preth.Substring(0, preth.LastIndexOf("\\"));
                        string newpath = preth + "\\SMSWeb" + context.Request["FilePath"].ToString().Replace("/", "\\");
                        ht.Add("FileEmailPath", newpath);
                    }
                    string date = string.IsNullOrWhiteSpace(context.Request["CreateTime"]) ? DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") : context.Request["CreateTime"];
                    ht.Add("CreateTime", date);
                    jsonModel = BllMS.SendMessage(ht, list);
                    context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
                }
            }
            catch (Exception ex)
            {
                jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void AdminSendMessage(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            SMSModel.JsonModel jsonModel = new SMSModel.JsonModel();
            try
            {
                string Subject = context.Request["Title"];
                string Body = context.Request["Contents"];
                string Email = context.Request["Email"];
                SMSUtility.Mail.SendMailMessage.SendMessage(Subject, Body, Email);
                jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = "success",
                    errNum = 0
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    errNum = 400
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }

        }

        public void SendMessageForCourse(HttpContext context) 
        {
            SMSModel.JsonModel jsonModel = new SMSModel.JsonModel();
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                if (!string.IsNullOrWhiteSpace(context.Request["courseID"])) 
                {
                    int id = int.Parse(context.Request["courseID"]);
                   SMSModel.Course items = BllCS.GetEntityById(id).retData as SMSModel.Course;
                    if (items!=null)
                    {
                        var course = items;
                        SMSModel.System_Message sm = new SMSModel.System_Message();
                        string img = string.IsNullOrWhiteSpace(course.ImageUrl) ? "http://" + System.Configuration.ConfigurationManager.AppSettings["services"].ToString() + "/PortalImages/defaultimg.jpg" : ("http://" + System.Configuration.ConfigurationManager.AppSettings["services"].ToString() + course.ImageUrl);
                        string isCharge = Convert.ToInt32(course.IsCharge) == 0 ? "免费" : "收费";
                        sm.Contents = "<ul style=\"padding:0px 10px\"><li style=\"padding-bottom:10px;margin-bottom:10px;overflow:hidden;vertical-align:bottom;border-bottom:1px dashed #c1c1c1;zoom:1;\"><li>"
                        + "<div style=\"width:238px;height:175px;position:relative;float: left;\"> \"><a><img src=\"" + img + "\" />"
                        + "</a>"
                        + "<div style=\"background:#19c857;width:70px;height:70px;color:#fff;font-size:14px;position:absolute;line-height:120px;text-align:center;\"> " + isCharge + " </div>"
                        + "</div>"
                        + "<div style=\"height:175px;overflow:hidden;margin-left:25px;width:515px;display: inline;line-height: 22px;color: #6d6d6d;float: left;\">"
                        + " <h3>" + course.Name + "</h3>"
                        + " <p>" + course.CourseIntro + "</p>"
                        + "</div>"
                        + "</li></ul>";//内容
                        sm.Title = "系统推送课程-" + course.Name;//标题
                        sm.Type = int.Parse(context.Request["Type"]);
                        sm.Status = Convert.ToByte((int)MessageStatus.未读);
                        sm.CreateTime = DateTime.Now;
                        sm.Creator = "00000000000000000X";//发送人
                        sm.Receiver = context.Request["Receiver"];//接受人
                        sm.Href = context.Request["Href"];//链接地址（可不提供）
                        sm.ReceiverEmail = context.Request["ReceiverEmail"];//收件邮箱
                        sm.IsDelete = Convert.ToByte((int)SysStatus.正常);
                        sm.isSend = Convert.ToByte((int)isSend.未发送);
                        sm.CreatorName = "超级管理员";
                        sm.ReceiverName = context.Request["ReceiverName"];
                        sm.FilePath = context.Request["FilePath"];
                        sm.Timing = string.IsNullOrWhiteSpace(context.Request["Timing"]) ? Convert.ToByte((int)MessageTiming.立即发送) : Convert.ToByte((int)MessageTiming.定时发送);
                        jsonModel = BllSMS.Add(sm);
                        context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
                    }
                }
            }
            catch (Exception ex)
            {
                jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    errNum = 400
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}