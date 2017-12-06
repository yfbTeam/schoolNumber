using SMSModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using SMSUtility;
using SMSBLL;
using SMSHanderler.OnlineLearning;
using System.Text;
using System.Data;
namespace SMSHanderler.Recommended
{
    /// <summary>
    /// Recommended 的摘要说明
    /// </summary>
    public class Recommended : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();

        EnterpriseService ebll = new EnterpriseService();
        EnterpriseJobService jbll = new EnterpriseJobService();
        JsonModel jsonModel = null;
        #region ProcessRequest
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string FuncName = context.Request["Func"].ToString();
            if (FuncName != null && FuncName != "")
            {
                try
                {
                    switch (FuncName)
                    {
                        case "GetEnterList":
                            GetEnterList(context);
                            break;
                        case "GetJobList":
                            GetJobList(context);
                            break;
                        case "AddEnter":
                            AddEnter(context);
                            break;
                        case "AddJob":
                            AddJob(context);
                            break;
                        case "GetJobTopic":
                            GetJobTopic(context);
                            break;
                        case "GetJobTopic_Comment":
                            GetJobTopic_Comment(context);
                            break;
                        case "DelJob":
                            DelJob(context);
                            break;
                        case "DelEnterprise":
                            DelEnterprise(context);
                            break;
                        case "BindNav":
                            BindNav(context);
                            break;
                        case "GetJobLibrary":
                            GetJobLibrary(context);
                            break;
                        case"RecommendJob":
                            RecommendJob(context);
                            break;
                        case "AddQuestion":
                            AddQuestion(context);
                            break;
                        case "AddAnswer":
                            AddAnswer(context);
                            break;
                        default:
                            break;
                    }
                }
                catch (Exception ex)
                {
                    string result = "";
                    jsonModel = new JsonModel()
                    {
                        errNum = 400,
                        errMsg = ex.Message,
                        retData = ""
                    };
                    LogService.WriteErrorLog(ex.Message);
                    result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
                    context.Response.Write(result);

                }
            }
            context.Response.End();
        }
        #endregion
        

        #region 推荐岗位
        /// <summary>
        /// 推荐岗位
        /// </summary>
        /// <param name="context"></param>
        private void RecommendJob(HttpContext context)
        {
            string result = "";

            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("JobName", context.Request["JobName"].SafeToString());
                ht.Add("Sort", context.Request["Sort"].SafeToString());
                ht.Add("ClassID", context.Request["ClassID"].SafeToString());
                ht.Add("StuNo", context.Request["StuNo"].SafeToString());

                jsonModel = ebll.GetJob(ht, true, "");
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
        }
        #endregion

        #region 学生端问题库
        private void GetJobLibrary(HttpContext context)
        {
            string result = "";

            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("ID", context.Request["ID"].SafeToString());
                ht.Add("Type", context.Request["Type"].SafeToString());

                jsonModel = ebll.GetJobLibrary(ht);
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
        }

        private void BindNav(HttpContext context)
        {
            context.Response.Write("[" + ebll.BindtvNodes().TrimEnd(',') + "]");
        }
        #endregion

        #region 企业信息
        #region 获取企业信息
        /// <summary>
        /// 获取企业信息
        /// </summary>
        /// <param name="context"></param>
        private void GetEnterList(HttpContext context)
        {
            string result = "";

            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("TableName", "Enterprise");
                ht.Add("ID", context.Request["ID"].SafeToString());
                ht.Add("Name", context.Request["Name"].SafeToString());

                jsonModel = ebll.GetPage(ht);
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

        }

        #endregion

        #region 添加企业信息
        /// <summary>
        /// 添加企业信息
        /// </summary>
        /// <param name="context"></param>
        private void AddEnter(HttpContext context)
        {
            string result = "";
            Enterprise model = new Enterprise();
            try
            {
                model.Name = context.Request["Name"].SafeToString();
                model.RelationName = context.Request["RelationName"].SafeToString();
                model.RelationEmail = context.Request["RelationEmail"].SafeToString();
                model.RelationPhone = context.Request["RelationPhone"].SafeToString();
                model.CreateUID = context.Request["CreateUID"].SafeToString();
                model.Introduction = context.Request["Introduction"].SafeToString();
                model.Address = context.Request["Address"].SafeToString();
                if (context.Request["RecruitNum"].SafeToString().Length>0)
                {

                }
                model.RecruitNum = Convert.ToInt32(context.Request["RecruitNum"]);
                jsonModel = ebll.Add(model);
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
        }
        #endregion

        #region 删除企业信息
        /// <summary>
        /// 删除企业信息
        /// </summary>
        /// <param name="context"></param>
        private void DelEnterprise(HttpContext context)
        {
            string result = "";
            try
            {
                string ID = context.Request["EnterID"].SafeToString();
                string Message = ebll.DelEnterprise(int.Parse(ID));
                if (Message == "")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "删除成功",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = Message,
                        retData = ""
                    };
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
        }
        #endregion

        #endregion

        #region 岗位信息
        #region 获取岗位信息
        /// <summary>
        /// 获取岗位信息
        /// </summary>
        /// <param name="context"></param>
        private void GetJobList(HttpContext context)
        {
            string result = "";

            try
            {
                Hashtable ht = new Hashtable();
                bool Ispage = true;
                if (context.Request["Ispage"].SafeToString().Length > 0)
                { Ispage = Convert.ToBoolean(context.Request["Ispage"]); }
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("TableName", "EnterpriseJob");
                ht.Add("ID", context.Request["ID"].SafeToString());
                ht.Add("Name", context.Request["Name"].SafeToString());
                ht.Add("EnterID", context.Request["EnterID"].SafeToString());

                jsonModel = jbll.GetPage(ht, Ispage);
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
        }

        #endregion

        #region 删除岗位信息
        /// <summary>
        /// 删除岗位信息
        /// </summary>
        /// <param name="context"></param>
        private void DelJob(HttpContext context)
        {
            string result = "";
            try
            {
                string ID = context.Request["JobID"].SafeToString();
                jsonModel = jbll.Delete(Convert.ToInt32(ID));
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
        }
        #endregion

        #region 添加岗位信息
        /// <summary>
        /// 添加岗位信息
        /// </summary>
        /// <param name="context"></param>
        private void AddJob(HttpContext context)
        {
            string result = "";
            EnterpriseJob model = new EnterpriseJob();
            try
            {
                model.Name = context.Request["Name"].SafeToString();
                model.EnterID = int.Parse(context.Request["EnterID"]);
                model.MajorIDs = context.Request["MajorIDs"].SafeToString();
                model.CourseIDs = context.Request["CourseIDs"].SafeToString();
                model.Introduction = context.Request["Introduction"].SafeToString();
                model.CreateUID = context.Request["CreateUID"].SafeToString();
                string returnResult = ebll.AddJob(model);
                if (returnResult == "添加成功")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "",
                        retData = "添加成功"
                    };

                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "",
                        retData = "添加失败"
                    };
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
        }
        #endregion
        #endregion

        #region 问答
        #region 新增岗位讨论
        /// <summary>
        /// 新增岗位讨论
        /// </summary>
        /// <param name="context"></param>
        private void AddQuestion(HttpContext context)
        {
            JobTopicService bll = new JobTopicService();

            string result = "";
            JobTopic model = new JobTopic();
            try
            {
                model.Contents = context.Request["Question"].SafeToString();
                model.EnID = int.Parse(context.Request["EnID"].SafeToString());
                model.JobID = int.Parse(context.Request["JobID"].SafeToString());
                model.CreateUID = context.Request["CreateUID"].SafeToString();
                jsonModel = bll.Add(model);
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
        }
        #endregion

        #region 获取岗位讨论信息

        /// <summary>
        /// 获取岗位讨论信息
        /// </summary>
        /// <param name="context"></param>
        private void GetJobTopic(HttpContext context)
        {
            JobTopicService bll = new JobTopicService();
            string result = "";

            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("TableName", "JobTopic");
                bool IsPage = true;
                if (context.Request["IsPage"].SafeToString().Length > 0)
                {
                    IsPage = Convert.ToBoolean(context.Request["IsPage"]);
                }
                jsonModel = bll.GetPage(ht, IsPage, " and JobID=" + context.Request["JobID"].SafeToString());
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
        }

        #endregion

        #region 获取岗位讨论回复信息
        /// <summary>
        /// 获取岗位信息
        /// </summary>
        /// <param name="context"></param>
        private void GetJobTopic_Comment(HttpContext context)
        {
            CommonHandler common = new CommonHandler();
            string result = "";
            JobTopic_CommentService bll = new JobTopic_CommentService();

            try
            {
                Hashtable ht = new Hashtable();
                bool Ispage = true;
                if (context.Request["Ispage"].SafeToString().Length > 0)
                { Ispage = Convert.ToBoolean(context.Request["Ispage"]); }
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("TableName", "JobTopic_Comment");
                ht.Add("ID", context.Request["ID"].SafeToString());
                ht.Add("Name", context.Request["Name"].SafeToString());
                ht.Add("EnterID", context.Request["EnterID"].SafeToString());

                JsonModel thisModel = bll.GetPage(ht, Ispage, " and TopicId=" + context.Request["TopicId"].SafeToString());
                jsonModel = common.AddCreateNameForData(thisModel, 3, Ispage);

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
        }

        #endregion
        #region 新增问题回复
        /// <summary>
        /// 新增问题回复
        /// </summary>
        /// <param name="context"></param>
        private void AddAnswer(HttpContext context)
        {
            JobTopic_CommentService bll = new JobTopic_CommentService();

            string result = "";
            JobTopic_Comment model = new JobTopic_Comment();
            try
            {
                model.Contents = context.Request["Contents"].SafeToString();
                model.TopicId = int.Parse(context.Request["TopicId"].SafeToString());
                model.CreateUID = context.Request["CreateUID"].SafeToString();
                jsonModel = bll.Add(model);
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
        }
        #endregion
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