using SMSModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SMSHanderler.Mobile
{
    /// <summary>
    /// MobileHandler 的摘要说明
    /// </summary>
    public class MobileHandler : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;
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
                        case "ImageRotation":
                            ImageRotation(context);
                            break;
                        case "ForumURL":
                            ForumURL(context);
                            break;
                        //case "GetListPageM_questionnaire":
                        //    GetListPageM_questionnaire(context);
                        //    break;
                        case "TeacherModuleURL":
                            TeacherModuleURL(context);
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

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        /// <summary>
        /// 登录
        /// </summary>
        /// <param name="context"></param>
        private void ImageRotation(HttpContext context)
        {
            try
            {
                Request(context);
                Hashtable ht = new Hashtable();
                ht.Add("Type", context.Request["Type"].ToString());

                //jsonModel = bll.GetListPageM(ht);
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

        private string Request(HttpContext context)
        {
            string result = "";
            string urlHeader = ConfigHelper.GetConfigString("HttpService").ToString();

            string HttpMethod = context.Request.HttpMethod;
            if (HttpMethod.ToUpper() == "POST")
            {
                int parmLen = context.Request.Form.AllKeys.Length;
                string FirstKey = context.Request.Form.AllKeys[0];
                string FirstParm = context.Request.Form[0];
                string parms = context.Request.Form.ToString();
                result = NetHelper.RequestPostUrl(urlHeader + FirstParm, parms.Substring(FirstParm.Length + FirstKey.Length + 2, parms.Length - FirstParm.Length - FirstKey.Length - 2));
                //result = NetHelper.RequestPostUrl(url, Content);
                return result;
            }
            else
            {
                string url = context.Request.Url.ToString();
                int index = url.IndexOf("PageName");
                url = urlHeader + url.Substring(index + 9, url.Length - index - 9).Replace("ashx&", "ashx?");
                result = NetHelper.RequestGetUrl(url);
                //result = NetHelper.RequestGetUrl(url);
                return result;
            }
            //context.Response.Write(result);
            //context.Response.End();
        }

        /// <summary>
        /// 论坛地址
        /// </summary>
        /// <param name="context"></param>
        private void ForumURL(HttpContext context)
        {
            try
            {
                //string type = context.Request["Type"] == null ? "" : context.Request["Type"].ToString();
                string IP = System.Configuration.ConfigurationManager.ConnectionStrings["ForumUrl"].ToString();
                string AppIP = System.Configuration.ConfigurationManager.ConnectionStrings["WebUrl"].ToString();
                Dictionary<string, object> dic = new Dictionary<string, object>();
                dic.Add("Community", IP + System.Configuration.ConfigurationManager.ConnectionStrings["Community"].ToString());//社区
                dic.Add("OnlineAnswer", IP + System.Configuration.ConfigurationManager.ConnectionStrings["OnlineAnswer"].ToString());//在线答疑
                dic.Add("ClassForum", IP + System.Configuration.ConfigurationManager.ConnectionStrings["ClassForum"].ToString());//班级论坛
                dic.Add("CourseForum", IP + System.Configuration.ConfigurationManager.ConnectionStrings["CourseForum"].ToString());//课程论坛
                dic.Add("DiscussArea", IP + System.Configuration.ConfigurationManager.ConnectionStrings["DiscussArea"].ToString());//综合讨论区
                dic.Add("ChatRoom", IP + System.Configuration.ConfigurationManager.ConnectionStrings["ChatRoom"].ToString());//聊天室
                dic.Add("StudySchedule", AppIP + System.Configuration.ConfigurationManager.ConnectionStrings["StudySchedule"].ToString());//个人学习进度分析
                dic.Add("Questionnaire", AppIP + System.Configuration.ConfigurationManager.ConnectionStrings["Questionnaire"].ToString());//调查问卷
                dic.Add("AccountManagement", AppIP + System.Configuration.ConfigurationManager.ConnectionStrings["AccountManagement"].ToString());//账户管理
                dic.Add("UpdatePassword", AppIP + System.Configuration.ConfigurationManager.ConnectionStrings["UpdatePassword"].ToString());//修改密码
                dic.Add("TeachingInteraction", AppIP + System.Configuration.ConfigurationManager.ConnectionStrings["TeachingInteraction"].ToString());//教学互动
                dic.Add("StudentExport", AppIP + System.Configuration.ConfigurationManager.ConnectionStrings["StudentExport"].ToString());//导出
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "",
                    retData = dic
                };
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

        /// <summary>
        /// 教师模块地址
        /// </summary>
        /// <param name="context"></param>
        private void TeacherModuleURL(HttpContext context)
        {
            try
            {
                //string type = context.Request["Type"] == null ? "" : context.Request["Type"].ToString();
                string ForumIP = System.Configuration.ConfigurationManager.ConnectionStrings["ForumUrl"].ToString();
                string AppIP = System.Configuration.ConfigurationManager.ConnectionStrings["WebUrl"].ToString();
                Dictionary<string, object> dic = new Dictionary<string, object>();
                dic.Add("TeachingActivity", AppIP + System.Configuration.ConfigurationManager.ConnectionStrings["TeachingActivity"].ToString());//教学活动
                dic.Add("TeachingStatistics", AppIP + System.Configuration.ConfigurationManager.ConnectionStrings["TeachingStatistics"].ToString());//教学统计
                dic.Add("AccessRateAnalysis", AppIP + System.Configuration.ConfigurationManager.ConnectionStrings["AccessRateAnalysis"].ToString());//访问率分析
                dic.Add("ActivityAnalysis", AppIP + System.Configuration.ConfigurationManager.ConnectionStrings["ActivityAnalysis"].ToString());//活动分析
                dic.Add("StudyEffect", AppIP + System.Configuration.ConfigurationManager.ConnectionStrings["StudyEffect"].ToString());//学习效果
                dic.Add("TeacherStudentList", AppIP + System.Configuration.ConfigurationManager.ConnectionStrings["TeacherStudentList"].ToString());//师生名单
                dic.Add("KnowledgeStatistics", AppIP + System.Configuration.ConfigurationManager.ConnectionStrings["KnowledgeStatistics"].ToString());//知识点统计
                dic.Add("JobCheck", AppIP + System.Configuration.ConfigurationManager.ConnectionStrings["JobCheck"].ToString());//作业检查
                dic.Add("WebsiteStatistics", AppIP + System.Configuration.ConfigurationManager.ConnectionStrings["WebsiteStatistics"].ToString());//网站统计
                dic.Add("DataBackup", AppIP + System.Configuration.ConfigurationManager.ConnectionStrings["DataBackup"].ToString());//数据备份
                dic.Add("UpdatePassword", AppIP + System.Configuration.ConfigurationManager.ConnectionStrings["UpdatePassword"].ToString());//修改密码
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "",
                    retData = dic
                };
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