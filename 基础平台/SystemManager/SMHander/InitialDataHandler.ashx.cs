using SMBLL;
using SMModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;

namespace SMHander
{
    /// <summary>
    /// StudySection 的摘要说明
    /// </summary>
    public class InitialDataHandler : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        SMBLL.Plat_LogInfoService log = new SMBLL.Plat_LogInfoService();
        JsonModel jsonModel = null;
        Dictionary<string, JsonModel> dic;
        BLLCommon com = new SMBLL.BLLCommon();
        string result = "";
        public void ProcessRequest(HttpContext context)
        {
            string func = context.Request["func"] ?? "";
            try
            {
                switch (func)
                {
                    case "GetPSTVData":
                        //获得学段、科目、教材、教材版本
                        GetPSTVData(context);
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
                result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
                LogService.WriteErrorLog(ex.Message);
            }
            //string result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        /// <summary>
        /// 获得学段、科目、教材、教材版本
        /// </summary>
        /// <param name="context"></param>
        public void GetPSTVData(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                //获取参数值
                if (context.Request["SystemKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                }
                if (context.Request["InfKey"] != null)
                {
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                ht.Add("func", "GetPSTVData");
                JsonModel YanZheng = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (YanZheng.errNum != 0)
                {
                    result = "{\"result\":" + jss.Serialize(YanZheng) + "}";
                }

                //学段、科目
                ht.Add("Columns", "a.Id,b.Id as PeriodID,b.Name as PeriodName,c.Id as SubjectID,c.Name as SubjectName");
                ht.Add("TableName", "Plat_PeriodOfSubject a left join Plat_Period b on a.PeriodID=b.Id left join Plat_Subject c on a.SubjectID=c.Id left join Plat_SchoolOfPeriod d on a.PeriodID=d.PeriodID left join Plat_SystemInfo si on d.SchoolID=si.SchoolId");
                if (context.Request["SystemKey"] != null)
                {
                    ht.Add("Where", " and si.SystemKey='" + context.Request["SystemKey"].ToString() + "'");
                }
                else
                {
                    ht.Add("Where", "");
                }
                result = "{";
                JsonModel PeriodOfSubject = com.GetData_NoVerification(ht);
                result += "\"PeriodOfSubject\":" + jss.Serialize(PeriodOfSubject);

                //年级、科目
                ht["Columns"]= "a.Id,b.Id as GradeID,b.GradeName,c.Id as SubjectID,c.Name as SubjectName";
                ht["TableName"]= "Plat_GradeOfSubject a left join Plat_Grade b on a.GradeID=b.Id left join Plat_Subject c on a.SubjectID=c.Id left join Plat_SystemInfo si on a.SchoolID=si.SchoolId";
                if (context.Request["SystemKey"] != null)
                {
                    ht["Where"]=" and si.SystemKey='" + context.Request["SystemKey"].ToString() + "'";
                }
                else
                {
                    ht["Where"] = "";
                }
                result += ",";
                JsonModel GradeOfSubject = com.GetData_NoVerification(ht);
                result += "\"GradeOfSubject\":" + jss.Serialize(GradeOfSubject);
                //教材版本
                ht["Columns"] = "*";
                ht["TableName"] = "Plat_TextbookVersion";
                ht["Where"] = "";
                JsonModel TextbookVersion = com.GetData_NoVerification(ht);
                result += ",";
                result += "\"TextbookVersion\":" + jss.Serialize(TextbookVersion);
                //教材
                ht["Columns"] = "a.*,b.Name as VersionName";
                ht["TableName"] = "Plat_Textbook a left join Plat_TextbookVersion b on a.VersionID=b.Id";
                ht["Where"] = "";
                JsonModel Textbook = com.GetData_NoVerification(ht);
                result += ",";
                result += "\"Textbook\":" + jss.Serialize(Textbook);
                //学段
                ht["Columns"] = "a.*,b.SchoolID";
                ht["TableName"] = "Plat_Period a left join Plat_SchoolOfPeriod b on a.Id=b.PeriodID left join Plat_SystemInfo si on b.SchoolID=si.SchoolID";
                if (context.Request["SystemKey"] != null)
                {
                    ht["Where"] =" and si.SystemKey='" + context.Request["SystemKey"].ToString() + "'";
                }
                else
                {
                    ht["Where"] = "";
                }
                JsonModel Period = com.GetData_NoVerification(ht);
                result += ",";
                result += "\"Period\":" + jss.Serialize(Period);
                result += "}";
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
                return;
            }
        }
    }
}