using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.CourseManage
{
    public partial class TestWeb : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           // this.DownUrltoFile("http://www.baidu.com", "html/baidu.htm", "GB2312");
            test();
        }
        public static bool CreatHtmlPage(string[] strNewsHtml, string[] strOldHtml, string strModeFilePath, string strPageFilePath)
        {
            bool Flage = false;
            StreamReader ReaderFile = null;
            StreamWriter WrirteFile = null;
            //修改mode.htm到inc目录下
            strModeFilePath = "/inc/" + strModeFilePath;
            string FilePath = HttpContext.Current.Server.MapPath(strModeFilePath);
            Encoding Code = Encoding.GetEncoding("gb2312");
            string strFile = string.Empty;
            try
            {
                ReaderFile = new StreamReader(FilePath, Code);
                strFile = ReaderFile.ReadToEnd();

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                ReaderFile.Close();
            }
            try
            {
                int intLengTh = strNewsHtml.Length;
                for (int i = 0; i < intLengTh; i++)
                {
                    strFile = strFile.Replace(strOldHtml[i], strNewsHtml[i]);
                }
                WrirteFile = new StreamWriter(HttpContext.Current.Server.MapPath(strPageFilePath), false, Code);
                WrirteFile.Write(strFile);
                Flage = true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

                WrirteFile.Flush();
                WrirteFile.Close();
            }
            return Flage;
        }
        public static bool UpdateHtmlPage(string[] strNewsHtml, string[] strStartHtml, string[] strEndHtml, string strHtml)
        {
            bool Flage = false;
            StreamReader ReaderFile = null;
            StreamWriter WrirteFile = null;
            string FilePath = HttpContext.Current.Server.MapPath(strHtml);
            Encoding Code = Encoding.GetEncoding("gb2312");
            string strFile = string.Empty;
            try
            {
                ReaderFile = new StreamReader(FilePath, Code);
                strFile = ReaderFile.ReadToEnd();

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                ReaderFile.Close();
            }
            try
            {
                int intLengTh = strNewsHtml.Length;
                for (int i = 0; i < intLengTh; i++)
                {
                    int intStart = strFile.IndexOf(strStartHtml[i]) + strStartHtml[i].Length;
                    int intEnd = strFile.IndexOf(strEndHtml[i]);
                    string strOldHtml = strFile.Substring(intStart, intEnd - intStart);
                    strFile = strFile.Replace(strOldHtml, strNewsHtml[i]);
                }
                WrirteFile = new StreamWriter(FilePath, false, Code);
                WrirteFile.Write(strFile);
                Flage = true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

                WrirteFile.Flush();
                WrirteFile.Close();
            }
            return Flage;
        }
        private void test()
        {
            string[] format = new string[4];//定义和htmlyem标记数目一致的数组 
            StringBuilder htmltext = new StringBuilder();
            try
            {
                using (StreamReader sr = new StreamReader("http://www.baidu.com"))
                {
                    String line;
                    while ((line = sr.ReadLine()) != null)
                    {
                        htmltext.Append(line);
                    }
                    sr.Close();
                }
            }
            catch
            {
                Response.Write("<Script>alert('读取文件错误')</Script>");
            }
            //---------------------给标记数组赋值------------ 
            format[0] = "background=bg.jpg";//背景图片 
            format[1] = "#990099";//字体颜色 
            format[2] = "150px";//字体大小 
            format[3] = "<marquee>生成的模板html页面</marquee>";//文字说明 
            //----------替换htm里的标记为你想加的内容 
            for (int i = 0; i < 4; i++)
            {
                htmltext.Replace("$htmlformat[" + i + "]", format[i]);
            }
            //----------生成htm文件------------------―― 
            try
            {
                using (StreamWriter sw = new StreamWriter("http://www.baidu.com", false, System.Text.Encoding.GetEncoding("GB2312")))
                {
                    sw.WriteLine(htmltext);
                    sw.Flush();
                    sw.Close();
                }
            }
            catch
            {
                Response.Write("The file could not be wirte:");
            }
        }
        /// <summary>   

        /// 生成网页文件   
        /// </summary>   
        /// <param name="url">远程URL</param>   
        /// <param name="filename">生成文件名路径</param>   
        /// <param name="pagecode">目标URL页面编码</param>    
        protected void DownUrltoFile(string url, string filename, string pagecode)
        {

            try
            { //编码 Encoding encode = Encoding.GetEncoding(pagecode); //请求URL   
                HttpWebRequest req = (HttpWebRequest)WebRequest.Create(url); //设置超时(10秒)   
                req.Timeout = 10000;

                this.NotFolderIsCreate(filename); //获取Response   
                HttpWebResponse rep = (HttpWebResponse)req.GetResponse(); //创建StreamReader与StreamWriter文件流对象   

                StreamReader sr = new StreamReader(rep.GetResponseStream(), System.Text.Encoding.Default);
                StreamWriter sw = new StreamWriter(Server.MapPath(filename), false, System.Text.Encoding.Default); //写入内容   
                sw.Write(sr.ReadToEnd()); //清理当前缓存区，并将缓存写入文件 sw.Flush();   
                //释放相关对象资源   

                sw.Close();
                sw.Dispose();
                sr.Close();
                sr.Dispose();
                Response.Write("生成文件" + filename + "成功");
            }
            catch (Exception ex) { Response.Write("生成文件" + filename + "失败，原因：" + ex.Message); }
        }
        /// <summary>   
        /// 文件夹不存在则创建   
        /// </summary>   
        /// <param name="filename">文件名所在路径</param>    
        protected void NotFolderIsCreate(string filename)
        {
            string fileAtDir = Server.MapPath(Path.GetDirectoryName(filename));
            if (!Directory.Exists(fileAtDir)) Directory.CreateDirectory(fileAtDir);
        }

    }
}