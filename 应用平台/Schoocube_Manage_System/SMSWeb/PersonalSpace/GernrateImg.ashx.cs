using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SMSUtility;
using System.Text;
using System.IO;
using System.Web.Script.Serialization;
using SMSModel;
namespace SMSWeb.PersonalSpace
{
    /// <summary>
    /// GernrateImg 的摘要说明
    /// </summary>
    public class GernrateImg : IHttpHandler
    {

        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //"/Attatchment/Certificates/"

            string FuncName = context.Request["Func"].ToString();
            string result = string.Empty;

            context.Response.ContentType = "text/plain";
            if (FuncName != null && FuncName != "")
            {
                try
                {
                    switch (FuncName)
                    {
                        case "UplodImage":
                            UplodImage(context);
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
            }
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();
        }

        #region 上传证书图片
        /// <summary>
        /// 上传证书图片
        /// </summary>
        /// <param name="context"></param>    
        private void UplodImage(HttpContext context)
        {
            string UserIdCard = context.Request["UserIdCard"].SafeToString();
            HttpPostedFile file = HttpContext.Current.Request.Files[0];
            string Fpath = "/Attatchment/Certificates/";
            FileHelper.CreateDirectory(context.Server.MapPath(Fpath));

            string ext = System.IO.Path.GetExtension(file.FileName);

            string fileName = DateTime.Now.Ticks + ext;

            string p = Fpath + "/" + fileName;

            string path = context.Server.MapPath(p);

            file.SaveAs(path);
           
        }       
        #endregion

        #region

        //byte[] html_canvas = Encoding.UTF8.GetBytes(context.Request["dataUrl"].ToString().Substring(22));

        //string image = Convert.ToBase64String(html_canvas).Substring(22);

        //string filePath = context.Server.MapPath("/Attatchment/GernrateImg/图片.png");
        //FileHelper.CreateDirectory(context.Server.MapPath("/Attatchment/GernrateImg/"));
        //获取文件目录路径
        // string directoryPath = GetDirectoryFromFilePath(filePath);

        //如果文件的目录不存在，则创建目录
        //CreateDirectory(directoryPath);

        //创建一个FileInfo对象
        //var file = new FileInfo(filePath);

        ////创建文件
        //using (FileStream fs = file.Create())
        //{
        //    //写入二进制流
        //    fs.Write(buffer, 0, buffer.Length);
        //}


        //FileHelper.CreateFile(filePath, html_canvas);
        //context.Response.Write("/Attatchment/GernrateImg/图片.png");
        //context.Response.End();




        //string image = Convert.ToBase64String(html_canvas).Substring(22);
        //context.Response.AddHeader("Content-Type", "image/png");

        ////$fp = fopen($filename, 'w');
        ////fwrite($fp, $image);
        ////fclose($fp);
        //// 文件读取
        //StreamReader objReader = new StreamReader(filePath);
        //// 文件写入
        //FileStream fs = new FileStream(filePath, FileMode.Create);
        //StreamWriter sw = new StreamWriter(fs);
        ////开始写入
        //sw.Write(image, "w");
        ////关闭流
        //sw.Close();
        //fs.Close();
        //context.Response.Write("/Attatchment/GernrateImg/图片.png");
        //context.Response.End();
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