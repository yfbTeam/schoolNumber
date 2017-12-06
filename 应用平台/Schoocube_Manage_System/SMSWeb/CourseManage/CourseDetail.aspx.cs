using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.CourseManage
{
    public partial class CourseDetail : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HUserIdCard.Value = IDCard;
            HUserName.Value = Name;

            HClassID.Value = ClassID;
        }

        private void CreateHtml()
        {


        }
        /*
        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                //tb_MyCource.InnerHtml;
                //设置文件名
                //string filename = lblApplyTime.Text.Replace("/", "-") + "-" + lblName.Text + ".html";
                //获取当前文件路径(服务器端)
                string path = Server.MapPath("/CourseManage/StaticCous/coursedetail.html");
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
                    str.Replace("$Department$", tb_MyCource.InnerHtml);//开始替换文本
                    //str.Replace("$ApplyTime$", lblApplyTime.Text);
                    //str.Replace("$Name$", lblName.Text);
                    //str.Replace("$WorkDate$", lblWorkTime.Text);
                    //str.Replace("$WorkTime$", lblWorkTime.Text);
                    //str.Replace("$Reason$", lblReason.Text);
                    //设置文件路径
                    string htmlpath = Server.MapPath("/HtmlFile/").Replace(@"\\",@"\");
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
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }*/

    }
}