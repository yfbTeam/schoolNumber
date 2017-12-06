using SMSBLL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SMSHanderler.OnlineLearning
{
    /// <summary>
    /// TopicHandler 的摘要说明
    /// </summary>
    public class TopicHandler : IHttpHandler
    {
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        CommonHandler common = new CommonHandler();
        TopicService topicService = new TopicService();
        Topic_CommentService commentService = new Topic_CommentService();
        Couse_TaskInfoService taskService = new Couse_TaskInfoService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string func = context.Request["Func"];
            string result = string.Empty;
            try
            {
                switch (func)
                {
                    case "GetTopicDataPage":
                        GetTopicDataPage(context);
                        break;
                    case "AddTopic":
                        AddTopic(context);
                        break;
                    case "EditTopic":
                        EditTopic(context);
                        break;
                    case "DeleteTopic":
                        DeleteTopic(context);
                        break;
                    case "ClickGood": //论题点赞
                        ClickGood(context);
                        break;
                    case "ChangeShareStatus": //改变共享状态
                        ChangeShareStatus(context);
                        break;
                    case "GetTopic_CommentDataPage":
                        GetTopic_CommentDataPage(context);
                        break;
                    case "AddTopic_Comment":
                        AddTopic_Comment(context);
                        break;
                    case "EditTopic_Comment":
                        EditTopic_Comment(context);
                        break;
                    case "DeleteTopic_Comment":
                        DeleteTopic_Comment(context);
                        break;
                    default:
                        jsonModel = new JsonModel()
                        {
                            errNum = 5,
                            errMsg = "没有此方法",
                            retData = ""
                        };
                        break;
                }
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();
        }
        #region 获取论题表的分页数据
        private void GetTopicDataPage(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("CouseID", context.Request["CouseID"] ?? "");
                ht.Add("ChapterID", context.Request["ChapterID"] ?? "");
                ht.Add("TopicId", context.Request["TopicId"] ?? "");
                ht.Add("Type", context.Request["Type"] ?? "0");
                ht.Add("Name", context.Request["Name"] ?? "");
                ht.Add("StuIDCard", context.Request["StuIDCard"] ?? "");
                ht.Add("UserIdCard", context.Request["UserIdCard"] ?? "");
                ht.Add("ClassID", context.Request["ClassID"] ?? "");
                bool ispage = true;
                if (!string.IsNullOrEmpty(context.Request["ispage"]))
                {
                    ispage = Convert.ToBoolean(context.Request["ispage"]);
                }
                ht.Add("PageIndex", context.Request["PageIndex"] ?? "1");
                ht.Add("PageSize", context.Request["PageSize"] ?? "10");
                jsonModel = common.AddCreateNameForData(topicService.GetPage(ht, ispage), 3, ispage);
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
        }
        #endregion

        #region 添加论题
        private void AddTopic(HttpContext context)
        {
            string name = context.Request["Name"];
            string type = context.Request["Type"] ?? "0";
            Topic tpc = new Topic();
            tpc.CouseID = Convert.ToInt32(context.Request["CouseID"]);
            tpc.ChapterID = context.Request["ChapterID"];
            tpc.Name = name;
            tpc.Contents = context.Request["Contents"];
            tpc.Type = Convert.ToByte(type);
            tpc.IsShare = Convert.ToByte(type == "0" ? 1 : 0);
            tpc.CreateUID = context.Request["UserIdCard"];
            tpc.CreateTime = DateTime.Now;
            tpc.IsDelete = 0;
            jsonModel = topicService.Add(tpc);
        }
        #endregion

        #region 编辑论题
        private void EditTopic(HttpContext context)
        {
            string name = context.Request["Name"];
            int itemid = Convert.ToInt32(context.Request["ItemId"]);
            jsonModel = topicService.GetEntityById(itemid);
            if (jsonModel.errNum == 0)
            {
                Topic tpc = jsonModel.retData as Topic;
                tpc.Id = itemid;
                tpc.Name = name;
                tpc.Contents = context.Request["Contents"] ?? "";
                tpc.EditUID = context.Request["UserIdCard"];
                tpc.EidtTime = DateTime.Now;
                jsonModel = topicService.Update(tpc);
            }
        }
        #endregion

        #region 删除论题
        private void DeleteTopic(HttpContext context)
        {
            int itemid = Convert.ToInt32(context.Request["DelId"]);
            jsonModel = topicService.GetEntityById(itemid);
            if (jsonModel.errNum == 0)
            {
                Topic tpc = jsonModel.retData as Topic;
                tpc.Id = itemid;
                tpc.IsDelete = 1;
                jsonModel = topicService.Update(tpc);
            }
        }
        #endregion

        #region 论题点赞
        private void ClickGood(HttpContext context)
        {
            int itemid = Convert.ToInt32(context.Request["ItemId"]);
            Topic_GoodClick gdc = new Topic_GoodClick();
            gdc.RelationId = itemid;
            gdc.Type = Convert.ToByte(context.Request["Type"] ?? "0");
            gdc.CreateUID = context.Request["UserIdCard"];
            Hashtable ht = new Hashtable();
            ht.Add("GoodType", context.Request["GoodType"]);
            jsonModel = new Topic_GoodClickService().AddGoodClick(gdc, ht);
        }
        #endregion

        #region 改变共享状态
        private void ChangeShareStatus(HttpContext context)
        {
            int itemid = Convert.ToInt32(context.Request["ItemId"]);
            jsonModel = topicService.GetEntityById(itemid);
            if (jsonModel.errNum == 0)
            {
                Topic tpc = jsonModel.retData as Topic;
                tpc.Id = itemid;
                tpc.IsShare = Convert.ToByte(context.Request["IsShare"] ?? "0");
                jsonModel = topicService.Update(tpc);
            }
        }
        #endregion

        #region 获取评论表的数据
        private void GetTopic_CommentDataPage(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("CouseID", context.Request["CouseID"] ?? "");
                ht.Add("ChapterID", context.Request["ChapterID"] ?? "");
                ht.Add("TopicId", context.Request["TopicId"] ?? "");
                ht.Add("Name", context.Request["Name"] ?? "");
                ht.Add("StuIDCard", context.Request["StuIDCard"] ?? "");
                ht.Add("UserIdCard", context.Request["UserIdCard"] ?? "");
                bool ispage = true;
                if (!string.IsNullOrEmpty(context.Request["ispage"]))
                {
                    ispage = Convert.ToBoolean(context.Request["ispage"]);
                }
                ht.Add("PageIndex", context.Request["PageIndex"] ?? "1");
                ht.Add("PageSize", context.Request["PageSize"] ?? "10");
                jsonModel = common.AddCreateNameForData(commentService.GetPage(ht, ispage), 3, ispage);
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
        }
        #endregion

        #region 添加评论
        private void AddTopic_Comment(HttpContext context)
        {
            Topic_Comment comm = new Topic_Comment();
            comm.TopicId = Convert.ToInt32(context.Request["TopicId"]);
            comm.Pid = 0;
            comm.Contents = HttpUtility.UrlDecode(context.Request["Contents"]);
            comm.CreateUID = context.Request["UserIdCard"];
            jsonModel = taskService.AddTopic_Comment(comm, context.Request["ClassID"] ?? "");
        }
        #endregion

        #region 编辑评论
        private void EditTopic_Comment(HttpContext context)
        {
            string name = context.Request["Name"];
            int itemid = Convert.ToInt32(context.Request["ItemId"]);
            jsonModel = commentService.GetEntityById(itemid);
            if (jsonModel.errNum == 0)
            {
                Topic_Comment comm = jsonModel.retData as Topic_Comment;
                comm.Id = itemid;
                comm.Contents = context.Request["Contents"];
                comm.EditUID = context.Request["UserIdCard"];
                comm.EidtTime = DateTime.Now;
                jsonModel = commentService.Update(comm);
            }
        }
        #endregion

        #region 删除评论
        private void DeleteTopic_Comment(HttpContext context)
        {
            int itemid = Convert.ToInt32(context.Request["DelId"]);
            jsonModel = commentService.GetEntityById(itemid);
            if (jsonModel.errNum == 0)
            {
                Topic_Comment comm = jsonModel.retData as Topic_Comment;
                comm.Id = itemid;
                comm.IsDelete = 1;
                jsonModel = commentService.Update(comm);
            }
        }
        #endregion

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}