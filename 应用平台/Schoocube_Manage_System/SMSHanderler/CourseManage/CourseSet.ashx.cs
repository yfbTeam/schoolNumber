using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SMSBLL;
using SMSModel;
using SMSUtility;
using System.Web.Script.Serialization;
using System.Collections;

namespace SMSWeb.CourseManage
{
    /// <summary>
    /// CourseSet 的摘要说明
    /// </summary>
    public class CourseSet : IHttpHandler
    {
        Couse_SelsettingService bll = new Couse_SelsettingService();
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;
        Course_ChapterService courcebll = new Course_ChapterService();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpPostedFile hpf = HttpContext.Current.Request.Files["imgfile"];//HttpPostedFile提供对客户端已上载的单独文件的访问        string savepath = context.Server.MapPath("." + hpf.FileName);//路径,相对于服务器当前的路径        hpf.SaveAs(savepath);//保存        context.Response.Write("保存成功"+hpf.FileName);
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
                        case "Add":
                            Add(context);
                            break;
                        case "GetWeekList":
                            GetWeekList(context);
                            break;
                        case "DelWeek":
                            DelWeek(context);
                            break;
                        case "AddWeekSet":
                            AddWeekSet(context);
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
        #region 添加周设置信息
        /// <summary>
        /// 添加周设置信息
        /// 
        /// </summary>
        /// <param name="context"></param>
        private void AddWeekSet(HttpContext context)
        {
            Couse_SelWeekService week = new Couse_SelWeekService();
            try
            {
                int SetID = 0;
                if (context.Request["SetID"].SafeToString().Length > 0)
                {
                    SetID = Convert.ToInt32(context.Request["SetID"]);
                }
                string WeekName = context.Request["WeekName"].SafeToString();
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "Couse_SelWeek");

                jsonModel = week.GetPage(ht, false, " and SetID=" + SetID + " and WeekName='" + WeekName + "'");
                if (jsonModel.errNum != 0)
                {

                    Couse_SelWeek SelWeek = new Couse_SelWeek();
                    string ExcWeek = context.Request["ExcWeek"].SafeToString();
                    SelWeek.ExcWeek = ExcWeek == "请选择" ? "" : ExcWeek;
                    SelWeek.SetID = SetID;
                    SelWeek.WeekName = WeekName;
                    SelWeek.CreateUID = context.Request["UserIdCard"].SafeToString();
                    SelWeek.Status = 0;
                    jsonModel = week.Add(SelWeek);
                }
                else
                {
                    jsonModel = new JsonModel
                    {
                        errNum = 401,
                        errMsg = "数据重复",
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
        }
        #endregion

        #region 删除周设置信息
        /// <summary>
        /// 删除周设置信息
        /// 
        /// </summary>
        /// <param name="context"></param>
        private void DelWeek(HttpContext context)
        {
            Couse_SelWeekService week = new Couse_SelWeekService();
            try
            {
                string ID = context.Request["ID"].SafeToString();
                jsonModel = week.Delete(int.Parse(ID));
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

        #region 获取课程周设置信息
        /// <summary>
        /// 获取课程设置信息
        /// </summary>
        /// <param name="context"></param>
        private void GetWeekList(HttpContext context)
        {
            Couse_SelWeekService week = new Couse_SelWeekService();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());
                ht.Add("TableName", "Couse_SelWeek");
                string ID = context.Request["ID"].SafeToString();
                string Where = " and SetID=" + ID;

                jsonModel = week.GetPage(ht, true, Where);
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

        #region 获取课程设置信息
        /// <summary>
        /// 获取课程设置信息
        /// </summary>
        /// <param name="context"></param>
        private void GetPageList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());
                ht.Add("TableName", "Couse_Selsetting");
                string ID = context.Request["ID"].SafeToString();
                string StudyTerm = context.Request["StudyTerm"].SafeToString();
                string Where = "";
                if (ID.Length > 0)
                {
                    Where += " and ID=" + ID;
                }
                if (StudyTerm.Length > 0)
                {
                    Where += " and TermID=" + StudyTerm;
                }
                jsonModel = bll.GetPage(ht, true, Where);
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

        #region 添加设置信息
        /// <summary>
        /// 添加设置信息
        /// </summary>
        /// <param name="context"></param>
        private void Add(HttpContext context)
        {
            try
            {
                Couse_Selsetting set = new Couse_Selsetting();
                set.TermID = int.Parse(context.Request["TermID"]);
                set.TermName = context.Request.Form["TermName"].SafeToString();
                set.SelMaxNum = Convert.ToByte(context.Request["SelMaxNum"]);
                set.SelMinNum = Convert.ToByte(context.Request["SelMinNum"]);
                //set.SelTime = Convert.ToByte(context.Request["SelTime"]);
                set.SelType = Convert.ToByte(context.Request["SelType"]);
                set.WeekSet = Convert.ToByte(context.Request["WeekSet"]);
                if (context.Request["ID"].SafeToString().Length > 0)
                {
                    set.EditUID = context.Request["UserIdCard"].SafeToString();
                    set.Status = Convert.ToByte(context.Request["Status"]);
                    set.ID = Convert.ToInt32(context.Request["ID"]);
                    jsonModel = bll.Update(set);
                }
                else
                {
                    set.CreateUID = context.Request["UserIdCard"].SafeToString();
                    set.Status = 0;
                    jsonModel = bll.Add(set);
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