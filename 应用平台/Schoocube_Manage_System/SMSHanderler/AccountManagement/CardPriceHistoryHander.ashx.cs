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

namespace SMSHanderler.AccountManagement
{
    /// <summary>
    /// CardPriceHistoryHander 的摘要说明
    /// </summary>
    public class CardPriceHistoryHander : IHttpHandler
    {

        CardPriceHistoryService bll = new CardPriceHistoryService();
        PrepaidCardManagementService pcms = new PrepaidCardManagementService();
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JsonModel pcmsJsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
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

        #region 获取充值卡信息
        /// <summary>
        /// 获取课程信息
        /// </summary>
        /// <param name="context"></param>
        private void GetPageList(HttpContext context)
        {
            CommonHandler hander = new CommonHandler();
            try
            {
                string HistoryStatistics = context.Request["HistoryStatistics"].SafeToString();
                string TypeHistoryStatistics = context.Request["TypeHistoryStatistics"].SafeToString();
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("TableName", "CardPriceHistory");
                ht.Add("Id", context.Request["Id"].SafeToString());
                ht.Add("IdCard", context.Request["IdCard"].SafeToString());
                ht.Add("CardPriceUse", context.Request["CardPriceUse"].SafeToString());
                ht.Add("HistoryStatistics", HistoryStatistics);
                ht.Add("TypeHistoryStatistics", TypeHistoryStatistics);
                bool Ispage = true;
                if (context.Request["Ispage"].SafeToString().Length > 0)
                {
                    Ispage = Convert.ToBoolean(context.Request["Ispage"]);
                }
                if ((HistoryStatistics + TypeHistoryStatistics).Length > 0)
                {
                    jsonModel = bll.GetPage(ht, Ispage);
                }
                else
                {
                    JsonModel json1 = bll.GetPage(ht, Ispage);
                    jsonModel = hander.AddCreateNameForData(json1, 3, Ispage, "", "", "IdCard");
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