using SMSBLL;
using SMSModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using SMSUtility;

namespace SMSHanderler.ResourceReservations
{
    /// <summary>
    /// ViewData 的摘要说明
    /// </summary>
    public class ViewData : IHttpHandler
    {

        JavaScriptSerializer jss = new JavaScriptSerializer();
        ResourceReservationService bll = new ResourceReservationService();
        JsonModel jsonModel = null;
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string FuncName = context.Request["Func"].ToString();
            if (FuncName != null && FuncName != "")
            {
                switch (FuncName)
                {
                    case "GetDate":
                        GetDate(context);
                        break;
                    case "AddResourceReservation":
                        AddResourceReservation(context);
                        break;
                    case "GetResourceReservation":
                        GetResourceReservation(context);
                        break;
                    case "DelResourceReservation":
                        DelResourceReservation(context);
                        break;

                    default:
                        break;
                }
            }
            context.Response.End();
        }
        #region 获取日程数据
        /// <summary>
        /// 获取日程数据
        /// </summary>
        /// <param name="context"></param>
        private void GetDate(HttpContext context)
        {
            Hashtable ht = new Hashtable();
            ht.Add("TableName", "ResourceReservation");
            //ht.Add("ReSourceInfoId", context.Request["ReSourceInfoId"] ?? "");
            JsonModel jsonmodel = bll.GetPage(ht, false);

            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            if (jsonmodel.retData.ToString() != "")
            {

            
            List<Dictionary<string, object>> gas = (List<Dictionary<string, object>>)jsonmodel.retData;// new List<Dictionary<string, object>>();

            for (int i = 0; i < gas.Count; i++)
            {
                string ID = gas[i]["Id"].ToString();
                string Name = gas[i]["Name"].ToString();
                string TimeInterval = gas[i]["TimeInterval"].ToString();
                DateTime StartDate = Convert.ToDateTime(gas[i]["AppoIntmentBeginTime"]);
                DateTime EndDate = Convert.ToDateTime(gas[i]["AppoIntmentEndTime"]);

                Dictionary<string, object> drow = new Dictionary<string, object>();
                drow.Add("id", ID);
                drow.Add("title", Name);
                drow.Add("start", ReturnDate(StartDate));
                drow.Add("end", ReturnDate(EndDate));    //鼠标悬浮上展现的是这个属性信息，可以自己设置
                drow.Add("TimeInterval", TimeInterval);
                drow.Add("fullname", string.Format("任务名称：{0}", Name));
                drow.Add("allDay", false);
                list.Add(drow);
            }
            }
            context.Response.Write(jss.Serialize(list));
        }
        #region 时间输出格式
        /// <summary>
        /// 时间按照此格式传输
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        private string ReturnDate(DateTime? date)
        {
            string str = string.Empty;
            string time = Convert.ToString(date);
            string[] split = time.Split(' ');
            string viewDate = split[0].Split('/')[0] + "-" + AddZero(split[0].Split('/')[1]) + "-" + AddZero(split[0].Split('/')[2]);
            string viewTime = AddZero(split[1].Split(':')[0]) + ":" + AddZero(split[1].Split(':')[1]) + ":" + AddZero(split[1].Split(':')[2]);
            str = viewDate + "T" + viewTime;
            return str;
        }
        /// <summary>
        /// 判断数字前面是否加0
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        private string AddZero(string str)
        {
            if (str.Length == 1)
                return "0" + str;
            else
                return str;
        }
        #endregion
        #endregion 添加日程数据

        #region 添加日程
        /// <summary>
        /// 添加日程
        /// </summary>
        /// <param name="context"></param>
        private void AddResourceReservation(HttpContext context)
        {
            string result = "";

            string id = context.Request.Form["id"].SafeToString();

            ResourceReservation model = new ResourceReservation();
            string Reason = context.Request.Form["Content"].SafeToString();
            DateTime StartDate = Convert.ToDateTime(context.Request.Form["StartDate"].SafeToString());
            DateTime EndDate = Convert.ToDateTime(context.Request.Form["EndDate"].SafeToString());
            string TimeInterval = context.Request.Form["TimeInterval"].SafeToString();
            string EndTime = context.Request.Form["EndTime"].SafeToString();
            string IdCard = context.Request.Form["IdCard"].SafeToString();
            model.Reason = Reason;
            model.Name = Reason;
            model.AppoIntmentBeginTime = StartDate;
            model.AppoIntmentEndTime = EndDate;
            model.Creator = "11";//IdCard;
            model.TimeInterval = TimeInterval;
            if (id != "")
            {
                model.Id = Convert.ToInt32(id);
                jsonModel = bll.Update(model);
            }
            else
            {
                jsonModel = bll.Add(model);
            }
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
        }
        #endregion


        private void GetResourceReservation(HttpContext context)
        {
            string result = "";
            string id = context.Request.Form["EditID"];
            Hashtable ht = new Hashtable();
            ht.Add("TableName", "ResourceReservation");
            jsonModel = bll.GetPage(ht, false, " and id=" + id);
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
        }
        /// <summary>
        /// 删除日程
        /// </summary>
        /// <param name="context"></param>
        private void DelResourceReservation(HttpContext context)
        {
            string result = "";
            string id = context.Request.Form["id"];
            if (id.Length > 0)
            {
                jsonModel = bll.DeleteFalse(Convert.ToInt32(id));
                result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            }
            context.Response.Write(result);
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