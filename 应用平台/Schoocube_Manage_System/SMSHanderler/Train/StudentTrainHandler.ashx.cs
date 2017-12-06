using SMSBLL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SMSHanderler.Train
{
    /// <summary>
    /// TrainHandler 的摘要说明
    /// </summary>
    public class StudentTrainHandler : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;

        StudentTrainService bll = new StudentTrainService();
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
                        case "GetListPage":
                            GetListPage(context);
                            break;
                        //case "Add":
                        //    Add(context);
                        //    break;
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
        /// 获得学生培训信息
        /// </summary>
        /// <param name="context"></param>
        private void GetListPage(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                if (context.Request["ID"] != null)
                {
                    ht.Add("ID", context.Request["ID"].ToString());
                }
                if (context.Request["StuIDCard"] != null)
                {
                    ht.Add("StuIDCard", context.Request["StuIDCard"].ToString());
                }
                if (context.Request["PageIndex"] != null && context.Request["PageSize"] != null)
                {
                    ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                    ht.Add("PageSize", context.Request["PageSize"].ToString());
                }
                else
                {
                    ht.Add("PageIndex", "1");
                    ht.Add("PageSize", "10");
                }

                jsonModel = bll.GetListByPage(ht);
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
        /// 添加学生培训信息
        /// </summary>
        /// <param name="context"></param>
        private void Add(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                SMSModel.StudentTrain model = new StudentTrain();
                if (context.Request["Name"] != null)
                {
                    model.Name = context.Request["Name"].ToString();
                }
                if (context.Request["StuIDCard"] != null)
                {
                    model.StuIDCard = context.Request["StuIDCard"].ToString();
                }
                if (context.Request["StartSchoolDatatime"] != null && !string.IsNullOrWhiteSpace(context.Request["StartSchoolDatatime"].ToString()))
                {
                    model.StartSchoolDatatime = Convert.ToDateTime(context.Request["StartSchoolDatatime"].ToString());
                }
                if (context.Request["GraduationDatatime"] != null && !string.IsNullOrWhiteSpace(context.Request["GraduationDatatime"].ToString()))
                {
                    model.GraduationDatatime = Convert.ToDateTime(context.Request["GraduationDatatime"].ToString());
                }
                if (context.Request["Major"] != null)
                {
                    model.Major = context.Request["Major"].ToString();
                }
                if (context.Request["Degree"] != null)
                {
                    model.Degree = context.Request["Degree"].ToString(); 
                }
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