using Newtonsoft.Json.Linq;
using SMSIDAL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;


namespace SMSWeb
{
    /// <summary>
    /// CommonHandler 的摘要说明
    /// </summary>
    public class CommonHandler : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        public void ProcessRequest(HttpContext context)
        {

        }
        #region 为返回的数据添加CreateName列
        /// <summary>
        /// 为返回的数据添加CreateName列
        /// </summary>
        /// <param name="jsonModel">数据</param>
        /// <param name="type">type 0获取所有学生；1获取所有教师；2 根据班级ids获取学生；3 获取所有教师和学生信息</param>
        /// <param name="ispage">数据是否是分页的</param>
        /// <param name="classids">班级ids</param>
        /// <param name="classField">需要解析的班级字符串字段，默认为空</param>
        /// <returns></returns>
        public JsonModel AddCreateNameForData(JsonModel jsonModel, int type = 0, bool ispage = false, string classids = "", string classField = "", string CreateUID = "CreateUID")
        {
            if (jsonModel.errNum == 0)
            {
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                List<Dictionary<string, object>> classList = new List<Dictionary<string, object>>();
                PagedDataModel<Dictionary<string, object>> pageModel = null;
                if (ispage)
                {
                    pageModel = jsonModel.retData as PagedDataModel<Dictionary<string, object>>;
                    list = pageModel.PagedData as List<Dictionary<string, object>>;
                }
                else
                {
                    list = jsonModel.retData as List<Dictionary<string, object>>;
                }
                List<Dictionary<string, object>> allList = new List<Dictionary<string, object>>();
                if (type == 0)
                {
                    allList = GetStudentData();
                }
                else if (type == 1)
                {
                    allList = GetTeacherData();
                }
                else if (type == 2)
                {
                    if (!string.IsNullOrEmpty(classids))
                    {
                        allList = GetStudentData(classids);
                    }
                }
                else if (type == 3)
                {
                    List<Dictionary<string, object>> teaList = (from dic in GetTeacherData()
                                                                select new Dictionary<string, object>() { { "IDCard", dic["IDCard"].ToString() }, { "Name", dic["Name"].ToString() }, { "PhotoURL", dic["PhotoURL"].ToString() } }).ToList<Dictionary<string, object>>();
                    List<Dictionary<string, object>> stuList = (from dic in GetStudentData()
                                                                select new Dictionary<string, object>() { { "IDCard", dic["IDCard"].ToString() }, { "Name", dic["Name"].ToString() }, { "PhotoURL", dic["PhotoURL"].ToString() } }).ToList<Dictionary<string, object>>();
                    allList = teaList.Union(stuList).ToList<Dictionary<string, object>>();
                }
                if (!string.IsNullOrEmpty(classField))
                {
                    classList = GetClassInfoData();
                }
                foreach (Dictionary<string, object> item in list)
                {
                    try
                    {
                        Dictionary<string, object> dicItem = (from dic in allList
                                                              where dic["IDCard"].ToString() == item[CreateUID].ToString()
                                                              select dic).FirstOrDefault();
                        item.Add("CreateName", dicItem["Name"].ToString());
                        item.Add("PhotoURL", dicItem["PhotoURL"].ToString());
                        if (dicItem.ContainsKey("ClassName"))
                        {
                            item.Add("ClassName", dicItem["ClassName"].ToString());
                        }
                        if (dicItem.ContainsKey("GradeName"))
                        {
                            item.Add("GradeName", dicItem["GradeName"].ToString());
                        }
                        if (!string.IsNullOrEmpty(classField) && !string.IsNullOrEmpty(item[classField].ToString()))
                        {
                            List<string> claArr = item[classField].ToString().Split(',').ToList();
                            string classStr = string.Join(",", (from dic in classList
                                                                where claArr.Contains(dic["Id"].ToString())
                                                                select dic["GradeName"].ToString() + dic["ClassName"].ToString()).ToArray());
                            item.Add("ClassStrName", classStr);
                        }
                    }
                    catch (Exception ex)
                    {

                    }

                }
                if (ispage)
                {
                    pageModel.PagedData = list;
                    jsonModel.retData = pageModel;
                }
                else { jsonModel.retData = list; }
            }
            return jsonModel;
        }
        #endregion

        #region 获取教师信息
        public List<Dictionary<string, object>> GetTeacherData()
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/TeacherHandler.ashx?";
            string urlbady = "func=GetTeacherData&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            string PageUrl = urlHead + urlbady;
            return AnalyticalReturnData(NetHelper.RequestPostUrl(PageUrl, urlbady));
        }
        #endregion

        #region 获取全部学生信息、根据班级id获取学生信息
        public List<Dictionary<string, object>> GetStudentData(string classids = "")
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string urlbady = "func=GetStudentData&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            if (!string.IsNullOrEmpty(classids))
            {
                urlbady += "&ClassID=" + classids;
            }
            string PageUrl = urlHead + urlbady;
            return AnalyticalReturnData(NetHelper.RequestPostUrl(PageUrl, urlbady));
        }
        #endregion

        #region 获取班级信息
        private List<Dictionary<string, object>> GetClassInfoData()
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/ClassInfoHandler.ashx?";
            string urlbady = "func=GetClassInfoData&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            string PageUrl = urlHead + urlbady;
            return AnalyticalReturnData(NetHelper.RequestPostUrl(PageUrl, urlbady));
        }
        #endregion

        #region 将接口返回的信息解析为List
        public List<Dictionary<string, object>> AnalyticalReturnData(string result)
        {
            JObject rtnObj = JObject.Parse(result);
            JObject resultObj = JsonTool.GetObjVal(rtnObj, "result");
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            if (JsonTool.GetStringVal(resultObj, "errNum") == "0")
            {
                list = jss.Deserialize<List<Dictionary<string, object>>>(resultObj["retData"].ToString());
            }
            return list;
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