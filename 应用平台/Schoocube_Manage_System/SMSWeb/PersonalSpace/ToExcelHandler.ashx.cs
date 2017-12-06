using Newtonsoft.Json.Linq;
using SMSBLL;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;

namespace SMSWeb.PersonalSpace
{
    /// <summary>
    /// ToExcelHandler 的摘要说明
    /// </summary>
    public class ToExcelHandler : IHttpHandler
    {

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
                        case "TrainDoc":
                            TrainDoc(context);
                            break;
                        case "MyDoc":
                            MyDoc(context);
                            break;
                        case "CourseDoc":
                            CourseDoc(context);
                            break;
                        case "ExamDoc":
                            ExamDoc(context);
                            break;
                        case "StuDoc":
                            StuDoc(context);
                            break;

                    }
                }
                catch (Exception ex)
                {
                    LogService.WriteErrorLog(ex.Message);
                }
            }

        }
        #region 培训档案
        /// <summary>
        /// 培训档案
        /// </summary>
        /// <param name="context"></param>
        private void TrainDoc(HttpContext context)
        {
            TrainingFilesService bll = new TrainingFilesService();

            DataTable dt = new DataTable();
            Hashtable ht = new Hashtable();
            ht.Add("TableName", "TrainingFiles");
            dt = bll.GetData(ht, false);
            ExcelHelper.ExportByWeb(dt, "序号,ID,姓名,培训机构,培训课程,相关课程,相关考试,培训开始时间,培训结束时间,培训学时,授课人,培训结果,培训费用,创建人,创建时间,修改人,修改时间,是否删除", "培训档案", "Sheet1");
        }
        #endregion

        #region 个人档案
        /// <summary>
        /// 个人档案
        /// </summary>
        /// <param name="context"></param>
        private void MyDoc(HttpContext context)
        {
            TrainingFilesService bll = new TrainingFilesService();

            DataTable dt = new DataTable();
            Hashtable ht = new Hashtable();
            ht.Add("TableName", "PersonDocument");
            dt = bll.GetData(ht, false, " and IDCart='" + context.Request["IDCarD"] + "'");
            ExcelHelper.ExportByWeb(dt, "序号,档案编号,姓名,性别,头像,民族,籍贯,生日,婚姻状况,参加工作时间,学历,专业,公司类型,身份,当前工作,工作职级,参加工作时间,工作年限", "个人档案", "Sheet1");
        }
        #endregion

        #region 培训课程
        /// <summary>
        /// 培训课程
        /// </summary>
        /// <param name="context"></param>
        private void CourseDoc(HttpContext context)
        {
            TrainingFilesService bll = new TrainingFilesService();
            string trainID = context.Request["trainID"].SafeToString();
            DataTable dt = bll.GetTrainCourse(trainID);

            ExcelHelper.ExportByWeb(dt, "课程名称,课程类型,学年学期,班级名称,上课时间,课程状态,创建时间", "培训课程档案", "Sheet1");
        }
        #endregion

        #region 培训考试
        /// <summary>
        /// 培训考试
        /// </summary>
        /// <param name="context"></param>
        private void ExamDoc(HttpContext context)
        {
            TrainingFilesService bll = new TrainingFilesService();
            string trainID = context.Request["trainID"].SafeToString();
            DataTable dt = bll.GetTrainExam(trainID);
            ExcelHelper.ExportByWeb(dt, "试卷名称,考试成绩,开始时间,结束时间", "培训考试档案", "Sheet1");
        }
        #endregion

        #region 学生信息
        /// <summary>
        /// 学生信息
        /// </summary>
        /// <param name="context"></param>
        private void StuDoc(HttpContext context)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("IDCard");
            dt.Columns.Add("LoginName");
            dt.Columns.Add("SchoolID");
            dt.Columns.Add("State");
            dt.Columns.Add("Name");
            dt.Columns.Add("Sex");
            dt.Columns.Add("Address");
            dt.Columns.Add("Phone");
            string IDCard = context.Request["IDCard"].SafeToString();
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string urlbady = "func=GetStudentData&IDCard=" + IDCard + "&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);


            JObject rtnObj = JObject.Parse(result);
            JObject resultObj = JsonTool.GetObjVal(rtnObj, "result");
            if (JsonTool.GetStringVal(resultObj, "errNum") == "0")
            {
                JArray retData = JsonTool.GetArryVal(resultObj, "retData");
                JObject curUser = retData[0] as JObject;

                DataRow dr = dt.NewRow();
                dr["IDCard"] = JsonTool.GetStringVal(curUser, "IDCard");
                dr["LoginName"] = JsonTool.GetStringVal(curUser, "LoginName");
                dr["SchoolID"] = JsonTool.GetStringVal(curUser, "SchoolID");
                dr["State"] = JsonTool.GetStringVal(curUser, "State");
                dr["Name"] = JsonTool.GetStringVal(curUser, "Name");
                dr["Sex"] = JsonTool.GetStringVal(curUser, "Sex");
                dr["Address"] = JsonTool.GetStringVal(curUser, "Address");
                dr["Phone"] = JsonTool.GetStringVal(curUser, "Phone");
                dt.Rows.Add(dr);
            }

            ExcelHelper.ExportByWeb(dt, "身份证号,登录账号,学校ID,状态,姓名,性别,家庭住址,电话", "学生信息", "Sheet1");
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