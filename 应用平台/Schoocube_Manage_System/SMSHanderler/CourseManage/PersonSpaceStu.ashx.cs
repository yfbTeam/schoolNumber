using SMSBLL;
using SMSHanderler.OnlineLearning;
using SMSModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace SMSHanderler.CourseManage
{
    /// <summary>
    /// PersonSpaceStu 的摘要说明
    /// </summary>
    public class PersonSpaceStu : IHttpHandler
    {
        TrainingFilesService bll = new TrainingFilesService();
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;
        Course_ChapterService courcebll = new Course_ChapterService();

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
                        case "GetPageList":
                            GetPageList(context);
                            break;
                        case "ExportTrain":
                            ExportTrain(context);
                            break;
                        case "AddTrain":
                            AddTrain(context);
                            break;
                        case "GetEmailList":
                            GetEmailList(context);
                            break;
                        case "AddEmail":
                            AddEmail(context);
                            break;
                        case "UpdateEmail":
                            UpdateEmail(context);
                            break;
                        case "GetTrainCourse":
                            GetTrainCourse(context);
                            break;
                        case "GetTrainExam":
                            GetTrainExam(context);
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

            }
            context.Response.End();
        }
        #region 获取培训考试
        /// <summary>
        /// 获取培训考试
        /// </summary>
        /// <param name="context"></param>
        private void GetTrainExam(HttpContext context)
        {
            BLLCommon common = new BLLCommon();
            string result = "";
            try
            {
                string trainID = context.Request["trainID"].SafeToString();
                DataTable dt = bll.GetTrainExam(trainID);
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                list = common.DataTableToList(dt);

                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "",
                    retData = list
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
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
        }
        #endregion
        #region 获取培训课程
        /// <summary>
        /// 获取培训信息
        /// </summary>
        /// <param name="context"></param>
        private void GetTrainCourse(HttpContext context)
        {
            BLLCommon common = new BLLCommon();
            string result = "";
            try
            {
                string trainID = context.Request["trainID"].SafeToString();
                DataTable dt = bll.GetTrainCourse(trainID);
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                list = common.DataTableToList(dt);

                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "",
                    retData = list
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
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
        }
        #endregion

        #region 添加发送记录

        private void AddEmail(HttpContext context)
        {
            string result = "";
            try
            {
                UpEmailListService ubll = new UpEmailListService();
                UpEmailList train = new UpEmailList();
                string CreateUID = context.Request["TrainingFiles"].SafeToString();
                train.RelationMsg = context.Request["Content"].SafeToString();
                train.RelationID = int.Parse(context.Request["RelationID"]);
                jsonModel = ubll.Add(train);
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 404,
                    errMsg = ex.Message,
                    retData = ""
                };
            }
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);

        }
        #endregion

        #region 获取发送记录
        /// <summary>
        /// 获取培训信息
        /// </summary>
        /// <param name="context"></param>
        private void GetEmailList(HttpContext context)
        {
            string result = "";
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "UpEmailList");
                string ID = context.Request["ID"].SafeToString();
                jsonModel = bll.GetPage(ht, false, " and ID=" + ID);
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

        #region 修改邮件记录
        /// <summary>
        /// 修改邮件记录
        /// </summary>
        /// <param name="context"></param>
        private void UpdateEmail(HttpContext context)
        {
            UpEmailListService ubll = new UpEmailListService();

            string result = "";
            try
            {
                UpEmailList train = new UpEmailList();
                train.ID = int.Parse(context.Request["ID"]);
                train.Isdelete = 1;
                jsonModel = ubll.Update(train);
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

        #region 添加培训档案

        private void AddTrain(HttpContext context)
        {
            string result = "";
            try
            {
                TrainingFiles train = new TrainingFiles();
                string CreateUID = context.Request["CreateUID"].SafeToString();
                train.CreateUID = CreateUID;
                train.TrainName = context.Request["TrainName"].SafeToString();
                train.GroupName = context.Request["GroupName"].SafeToString();
                train.BeginTime = Convert.ToDateTime(context.Request["BeginTime"]);
                train.EndTime = Convert.ToDateTime(context.Request["EndTime"]);
                train.ClassHour = Convert.ToByte(context.Request["ClassHour"]);
                train.TrainFee = Convert.ToSingle(context.Request["TrainFee"]);
                train.TrainMan = context.Request["TrainMan"].SafeToString();
                train.TrainResult = context.Request["TrainResult"].SafeToString();
                string Course = context.Request.Form[11];//["CourseIDs"].SafeToString();
                string Exam = context.Request.Form[12];//["ExamIDs"].SafeToString();

                if (context.Request["ID"].SafeToString().Length > 0)
                {
                    train.ID = Convert.ToInt32(context.Request["ID"]);
                    jsonModel = bll.Update(train);
                }
                else
                {
                    string Msg = bll.TrainAdd(train, Course, Exam);
                    if (Msg == "")
                    {
                        jsonModel = new JsonModel()
                        {
                            errNum = 0,
                            errMsg = "添加成功",
                            retData = ""
                        };
                    }
                    else
                    {
                        jsonModel = new JsonModel()
                        {
                            errNum = 999,
                            errMsg = "添加失败",
                            retData = ""
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 404,
                    errMsg = ex.Message,
                    retData = ""
                };
            }
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);

        }
        #endregion

        #region 获取培训信息
        /// <summary>
        /// 获取培训信息
        /// </summary>
        /// <param name="context"></param>
        private void GetPageList(HttpContext context)
        {
            string result = "";
            try
            {
                CommonHandler common = new CommonHandler();
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("TableName", "TrainingFiles");
                bool Ispage = false;
                if (context.Request["Ispage"].SafeToString().Length > 0)
                {
                    Ispage = Convert.ToBoolean(context.Request["Ispage"]);
                }
                jsonModel = common.AddCreateNameForData(bll.GetPage(ht, Ispage), 0, Ispage);
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
        #endregion

        #region 导出培训档案

        private void ExportTrain(HttpContext context)
        {
            try
            {
                DataTable dt = new DataTable();
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "TrainingFiles");
                dt = bll.GetData(ht, false);
                ExcelHelper.ExportByWeb(dt, "1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7", "培训档案", "Sheet1");
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "导出成功",
                    retData = ""
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