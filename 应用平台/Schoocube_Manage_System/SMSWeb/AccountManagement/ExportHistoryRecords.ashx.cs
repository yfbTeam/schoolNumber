using SMSBLL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SMSWeb.AccountManagement
{
    /// <summary>
    /// ExportHistoryRecords 的摘要说明
    /// </summary>
    public class ExportHistoryRecords : IHttpHandler
    {
        CardPriceHistoryService bll = new CardPriceHistoryService();
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };

        public void ProcessRequest(HttpContext context)
        {
            DataTable dt = new DataTable();
            Hashtable ht = new Hashtable();
            ht.Add("TableName", "CardPriceHistory");
            ht.Add("IdCard", context.Request["IdCard"].SafeToString());
            dt = bll.GetData(ht, false);
            if (string.IsNullOrEmpty(context.Request["IdCard"]))
            {
                ExcelHelper.ExportByWeb(dt, "序号,ID,姓名,,课程类别,账户金额,消费金额,创建人,创建时间,修改人,修改时间,是否删除,使用状态,身份证号,消费时间", "消费记录", "Sheet1");
            }
            else
            {
                ExcelHelper.ExportByWeb(dt, "序号,ID,姓名,,课程类别,账户金额,消费金额,创建人,创建时间,修改人,修改时间,是否删除,使用状态,身份证号,消费时间", "消费记录", "Sheet1");
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