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
    /// NoticeHandler 的摘要说明
    /// </summary>
    public class NoticeHandler : IHttpHandler
    {
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        Notice_CourseService noticeService = new Notice_CourseService();
        Notice_CourseSeeRelService seeRelService = new Notice_CourseSeeRelService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string func = context.Request["Func"];
            string result = string.Empty;
            try
            {
                switch (func)
                {
                    case "GetNotice_CourseDataPage":
                        GetNotice_CourseDataPage(context);
                        break;
                    case "GetNotice_CourseById":
                        GetNotice_CourseById(context);
                        break;
                    case "AddNotice_Course":
                        AddNotice_Course(context);
                        break;
                    case "EditNotice_Course":
                        EditNotice_Course(context);
                        break;
                    case "DeleteNotice_Course":
                        DeleteNotice_Course(context);
                        break;
                    case "OperNotice_CourseSeeRel":
                        OperNotice_CourseSeeRel(context);
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
        #region 获取课程通知表的分页数据
        private void GetNotice_CourseDataPage(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("StuIDCard", context.Request["StuIDCard"] ?? "");
                bool ispage = true;
                if (!string.IsNullOrEmpty(context.Request["ispage"]))
                {
                    ispage = Convert.ToBoolean(context.Request["ispage"]);
                }
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());
                jsonModel = noticeService.GetPage(ht, ispage);
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

        #region 根据Id获取课程通知
        private void GetNotice_CourseById(HttpContext context)
        {
            int itemid = Convert.ToInt32(context.Request["ItemId"]);
            jsonModel = noticeService.GetEntityById(itemid);
        }
        #endregion        

        #region 添加课程通知
        private void AddNotice_Course(HttpContext context)
        {
            string title = context.Request["Title"];
            Notice_Course notice = new Notice_Course();
            notice.Title = title;
            notice.Contents = context.Request["Contents"];
            notice.IsTop = Convert.ToByte(context.Request["IsTop"]??"0");
            notice.CreateUID = context.Request["UserIdCard"];
            notice.CreateTime = DateTime.Now;
            jsonModel = noticeService.Add(notice);
        }
        #endregion

        #region 编辑课程通知
        private void EditNotice_Course(HttpContext context)
        {
            string title = context.Request["Title"];
            int itemid = Convert.ToInt32(context.Request["ItemId"]);
            jsonModel = noticeService.GetEntityById(itemid);
            if (jsonModel.errNum == 0)
            {
                Notice_Course notice = jsonModel.retData as Notice_Course;
                notice.Id = itemid;
                notice.Title = title;
                notice.Contents = context.Request["Contents"];
                notice.IsTop = Convert.ToByte(context.Request["IsTop"]??"0");
                notice.EditUID = context.Request["UserIdCard"];
                notice.EidtTime = DateTime.Now;
                jsonModel = noticeService.Update(notice);
            }
        }
        #endregion

        #region 删除课程通知
        private void DeleteNotice_Course(HttpContext context)
        {
            int itemid = Convert.ToInt32(context.Request["DelId"]);
            jsonModel = noticeService.GetEntityById(itemid);
            if (jsonModel.errNum == 0)
            {
                Notice_Course notice = jsonModel.retData as Notice_Course;
                notice.Id = itemid;
                notice.IsDelete = 1;
                jsonModel = noticeService.Update(notice);
            }
        }
        #endregion

        #region 课程通知查看操作
        private void OperNotice_CourseSeeRel(HttpContext context)
        {
            int itemid = Convert.ToInt32(context.Request["ItemId"]??"0");
            Notice_CourseSeeRel rel = new Notice_CourseSeeRel();
            rel.Id = itemid;
            rel.NoticeId = Convert.ToInt32(context.Request["NoticeId"]);
            rel.CreateUID = context.Request["UserIdCard"];
            jsonModel = seeRelService.OperNotice_CourseSeeRel(rel);
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