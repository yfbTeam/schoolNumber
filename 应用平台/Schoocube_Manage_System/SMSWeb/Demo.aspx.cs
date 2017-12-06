using SMSBLL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Add_Click(object sender, EventArgs e)
    {

    }

    protected void Update_Click(object sender, EventArgs e)
    {

    }

    protected void Delete_Click(object sender, EventArgs e)
    {

    }


    protected void Button2_Click(object sender, EventArgs e)
    {
        FileHelper.CopyFolder(@"C:\Users\Administrator\Desktop\中职", ConfigHelper.GetConfigString("ZipUrl"));

        //ZipHelper zip = new ZipHelper();
        ////SharpZip zip = new SharpZip();

        //zip.EnZip("压缩文件",@"C:\Users\Administrator\Desktop\教材封面", @"C:\Users\Administrator\Desktop\教材封面");

    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        FileHelper.OpenFile("http://192.168.1.229:8071/DriveFolder/421002199011239361/新建文本文档.txt");
    }
   
}