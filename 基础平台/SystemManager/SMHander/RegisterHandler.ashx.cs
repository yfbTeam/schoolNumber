using SMBLL;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SMHander
{
    /// <summary>
    /// RegisterHandler 的摘要说明
    /// </summary>
    public class RegisterHandler : IHttpHandler
    {
        Plat_TeacherService BllTeacher = new SMBLL.Plat_TeacherService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request["func"];
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "ValidataIsExist": ValidataIsExist(context); break;
                    case "register": Register(context); break;
                    case "GetGradeAndClassById": GetGradeAndClassById(context); break;
                    default:
                        context.Response.Write("System Error");
                        break;
                }
            }
            context.Response.Write("System Error");
        }

        public void ValidataIsExist(HttpContext context)
        {
            Hashtable ht = new Hashtable();
            if (!string.IsNullOrWhiteSpace(context.Request["LoginName"]))
                ht.Add("LoginName", context.Request["LoginName"]);
            if (!string.IsNullOrWhiteSpace(context.Request["UserType"]))
                ht.Add("UserType", context.Request["UserType"]);
            if (!string.IsNullOrWhiteSpace(context.Request["IDCard"]))
                ht.Add("IDCard", context.Request["IDCard"]);
            if (!string.IsNullOrWhiteSpace(context.Request["Name"]))
                ht.Add("Name", context.Request["Name"]);
            if (!string.IsNullOrWhiteSpace(context.Request["reader"]))
                ht.Add("reader", context.Request["reader"]);
            SMModel.JsonModel Model = BllTeacher.ValidataIsExist(ht);
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            //输出Json
            HttpContext.Current.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
            HttpContext.Current.Response.End();
        }

        public void Register(HttpContext context) 
        {
            string callback = context.Request["jsoncallback"];
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(context.Request["UserType"]))
                    ht.Add("UserType", context.Request["UserType"]);
                if (!string.IsNullOrWhiteSpace(context.Request["LoginName"]))
                    ht.Add("LoginName", context.Request["LoginName"]);
                if (!string.IsNullOrWhiteSpace(context.Request["Password"]))
                    ht.Add("Password", context.Request["Password"]);
                if (!string.IsNullOrWhiteSpace(context.Request["Name"]))
                    ht.Add("Name", context.Request["Name"]);
                if (!string.IsNullOrWhiteSpace(context.Request["IDCard"]))
                    ht.Add("IDCard", context.Request["IDCard"]);
                if (!string.IsNullOrWhiteSpace(context.Request["SchoolID"]))
                    ht.Add("SchoolID", context.Request["SchoolID"]);
                if (!string.IsNullOrWhiteSpace(context.Request["Sex"]))
                    ht.Add("Sex", context.Request["Sex"]);
                if (!string.IsNullOrWhiteSpace(context.Request["SystemKey"]))
                    ht.Add("SystemKey", context.Request["SystemKey"]);

                if (!string.IsNullOrWhiteSpace(context.Request["SchoolNO"]))
                    ht.Add("SchoolNO", context.Request["SchoolNO"]);
                if (!string.IsNullOrWhiteSpace(context.Request["GradeID"]))
                    ht.Add("GradeID", context.Request["GradeID"]);
                if (!string.IsNullOrWhiteSpace(context.Request["ClassID"]))
                    ht.Add("ClassID", context.Request["ClassID"]);

                ht.Add("Phone", context.Request["Phone"]);
                ht.Add("JobNumber", context.Request["JobNumber"]);
                 
                System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
                SMModel.JsonModel Model = BllTeacher.Register(ht);
                context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");

                HttpContext.Current.Response.End();
            }
            catch (Exception ex)
            {

                HttpContext.Current.Response.End();
            }
        }

        public void GetGradeAndClassById(HttpContext context)
        {
            Hashtable ht = new Hashtable();
            if (!string.IsNullOrWhiteSpace(context.Request["GradeID"]))
                ht.Add("GradeID", context.Request["GradeID"]);
            if (!string.IsNullOrWhiteSpace(context.Request["SchoolID"]))
                ht.Add("SchoolID", context.Request["SchoolID"]);
            SMModel.JsonModel Model = BllTeacher.GetGradeAndClassById(ht);
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();

            HttpContext.Current.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
            HttpContext.Current.Response.End();
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