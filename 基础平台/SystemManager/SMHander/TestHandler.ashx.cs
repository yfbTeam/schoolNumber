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
    public class TestHandler : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        SMBLL.Plat_LogInfoService log = new SMBLL.Plat_LogInfoService();
        JsonModel jsonModel = null;
        BLLCommon com = new SMBLL.BLLCommon();
        SMBLL.Plat_ClassInfoService BLL = new Plat_ClassInfoService();
        public void ProcessRequest(HttpContext context)
        {
            string func = context.Request["func"] ?? "";
            try
            {
                switch (func)
                {
                    case "TestFunction1":
                        TestFunction1(context);
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
                LogService.WriteErrorLog(ex.Message);
            }
            string result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
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
        /// 测试方法1
        /// </summary>
        /// <param name="context"></param>
        public void TestFunction1(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();
                //获取参数值
                if (context.Request["Name"] == null || context.Request["Age"] == null)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 3,
                        errMsg = "参数不完整",
                        retData = ""
                    };
                    return;
                }
                Dictionary<string, object> d = new Dictionary<string, object>();
                d.Add("Name", context.Request["Name"].ToString());
                d.Add("Age", context.Request["Age"].ToString());
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "获取成功",
                    retData = d
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
                return;
            }
        }

        
    }
}