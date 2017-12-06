using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using SMSUtility;
namespace SMSWeb.CourseManage
{
    /// <summary>
    /// test 的摘要说明
    /// </summary>
    public class test : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
             string result = "";
            HttpPostedFile file = HttpContext.Current.Request.Files[0];
            string Fpath = "/test/";
            FileHelper.CreateDirectory(context.Server.MapPath(Fpath));

            string ext = System.IO.Path.GetExtension(file.FileName);
            string fileName = Path.GetFileName(file.FileName);// DateTime.Now.Ticks + ext;


            //string fileName = System.IO.Path.GetExtension(file.FileName); DateTime.Now.Ticks + ext;
            string p = Fpath + "/" + fileName;
            string path = context.Server.MapPath(p);
            #region 处理文件同名问题
            if (FileHelper.IsExistFile(path))
            {
                int i = 0;
                while (true)
                {
                    i++;
                    if (!FileHelper.IsExistDirectory(context.Server.MapPath(Fpath + "/" + fileName.Split('.')[0] + "(" + i + ")" + "." + fileName.Split('.')[1])))
                    {
                        fileName = fileName.Split('.')[0] + "(" + i + ")" + "." + fileName.Split('.')[1];
                        p = Fpath + "/" + fileName;
                        path = context.Server.MapPath(p);

                        break;
                    }
                }
            }
            #endregion

            file.SaveAs(path);

            result = "{\"error\":0,\"url\":\"" + context.Server.UrlEncode(p) + "\"}";
            context.Response.Write(result);
            context.Response.End();
            //context.Response.Write("Hello World");
            /*try
            {
                //tb_MyCource.InnerHtml;
                //设置文件名
                //string filename = lblApplyTime.Text.Replace("/", "-") + "-" + lblName.Text + ".html";
                //获取当前文件路径(服务器端)
                string path = context.Server.MapPath("/CourseManage/StaticCous/coursedetail.html");
                //通过路径获取模板文件内容
                using (StreamReader r = new StreamReader(path))
                {
                    String line = null;
                    //大量字符串拼接或频繁对某一字符串进行操作时最好使用 StringBuilder
                    StringBuilder str = new StringBuilder();
                    //开始读取模板文件内容
                    while ((line = r.ReadLine()) != null)
                    {
                        str.AppendLine(line);//这里就是一行一行的拼接字符串
                    }
                    r.Close();
                    string strCouse=context.Server.UrlDecode(context.Request["tb_MyCource"].SafeToString());
                    string header = context.Server.UrlDecode(context.Request["header"].SafeToString());
                    string menu_side = context.Server.UrlDecode(context.Request["menu_side"].SafeToString());
                    string coursedetail = context.Server.UrlDecode(context.Request["coursedetail"].SafeToString());
                    string taolun = context.Server.UrlDecode(context.Request["taolun"].SafeToString());
                    string biji = context.Server.UrlDecode(context.Request["biji"].SafeToString());
                    string renwu = context.Server.UrlDecode(context.Request["renwu"].SafeToString());
                    string pingjia = context.Server.UrlDecode(context.Request["pingjia"].SafeToString());
                    string zuoye = context.Server.UrlDecode(context.Request["zuoye"].SafeToString());

                    str.Replace("$Department$", strCouse);//开始替换文本
                    str.Replace("$header$", header);
                    str.Replace("$menu_side$", menu_side);
                    str.Replace("$coursedetail$", coursedetail);
                    str.Replace("$taolun$", taolun);
                    str.Replace("$biji$", biji);
                    str.Replace("$renwu$", renwu);
                    str.Replace("$pingjia$", pingjia);
                    str.Replace("$zuoye$", zuoye);
                    //设置文件路径
                    string htmlpath = context.Server.MapPath("/HtmlFile/").Replace(@"\\", @"\");
                    string paths = htmlpath + "123.htm";
                    //实例化，并制定文件名称规则和生成文件路径
                    StreamWriter w = new StreamWriter(paths, false, Encoding.GetEncoding("utf-8"));
                    w.Write(str);//这里才真正开始创建文件
                    w.Close();//关闭
                    w.Dispose();
                }
            }
            catch (Exception ex)
            {
                context.Response.Write("<script>alert('" + ex.Message + "');</script>");
            }*/

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