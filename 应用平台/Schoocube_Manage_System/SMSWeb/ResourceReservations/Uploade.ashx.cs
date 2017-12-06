using SMSBLL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SMSWeb.ResourceReservations
{
    /// <summary>
    /// Uploade 的摘要说明
    /// </summary>
    public class Uploade : IHttpHandler
    {

        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        ResourceReservationInfoService resourceService = new ResourceReservationInfoService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string func = context.Request["Func"];
            string result = string.Empty;
            try
            {
                switch (func)
                {
                    case "Uplod_Image":
                        Uplod_Image(context);
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
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();
        }
        #region 上传图片
        private void Uplod_Image(HttpContext context)
        {
            HttpPostedFile file = HttpContext.Current.Request.Files[0];
            string Fpath = "/ResourceReservationImage";
            FileHelper.CreateDirectory(context.Server.MapPath(Fpath));

            string ext = System.IO.Path.GetExtension(file.FileName);

            string fileName = DateTime.Now.Ticks + ext;

            string p = Fpath + "/" + fileName;

            string path = context.Server.MapPath(p);

            file.SaveAs(path);
            jsonModel = new JsonModel()
            {
                errNum = 0,
                errMsg = "",
                retData = p
            };

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