using SMSModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SMSHanderler.Exam
{
    /// <summary>
    /// Exam_ExamPaperHandler 的摘要说明
    /// </summary>
    public class ExamPaperHandler : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;

        SMSBLL.Exam_ExamPaperService bll = new SMSBLL.Exam_ExamPaperService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string FuncName = context.Request["Func"].ToString();
            string result = string.Empty;

            if (FuncName != null && FuncName != "")
            {
                try
                {
                    switch (FuncName)
                    {
                        case "GetListPageM":
                            GetListPageM(context);
                            break;
                        case "GetListPageM_questionnaire":
                            GetListPageM_questionnaire(context);
                            break;
                        default:
                            jsonModel = new JsonModel()
                            {
                                errNum = 404,
                                errMsg = "无此方法",
                                retData = ""
                            };
                            break;
                    }
                    LogService.WriteLog("");
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
        }
        /// <summary>
        /// 获取试卷列表
        /// 移动端
        /// </summary>
        /// <param name="context"></param>
        private void GetListPageM(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ClassID", context.Request["ClassID"].SafeToString());
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());

                jsonModel = bll.GetListPageM(ht);
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
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        /// <summary>
        /// 获取问卷列表
        /// 移动端
        /// </summary>
        /// <param name="context"></param>
        private void GetListPageM_questionnaire(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ClassID", context.Request["ClassID"].ToString());
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());

                jsonModel = bll.GetListPageM_questionnaire(ht);
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
    }
}