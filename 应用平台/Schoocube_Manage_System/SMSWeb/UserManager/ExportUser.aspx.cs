using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using SMSUtility;
using SMSBLL;

namespace SMSWeb.UserManager
{
    public partial class ExportUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Btn_Export_Click(object sender, EventArgs e)
        {
            try
            {
                if (this.Up_Upload.HasFile)
                {
                    if (Request.Files[0].ContentLength == 0)
                    {
                        return;
                    }
                    //byte[] upBytes = new Byte[Request.Files[i].ContentLength];
                    Stream upstream = Request.Files[0].InputStream;
                    HSSFWorkbook wk = new HSSFWorkbook(upstream);   //把xls文件中的数据写入wk中
                    int success = 0;
                    int fail = 0;
                    ISheet sheet = wk.GetSheetAt(0);   //读取当前表数据
                    for (int j = 1; j <= sheet.LastRowNum; j++)  //LastRowNum 是当前表的总行数
                    {
                        IRow row = sheet.GetRow(j);  //读取当前行数据
                        if (row != null)
                        {
                            SMSModel.UserInfo user = new SMSModel.UserInfo();
                            user.UserName = row.GetCell(0).StringCellValue;
                            HanziShiftPhoneticize hanzi = new HanziShiftPhoneticize();
                            user.LoginName = hanzi.GetAllPYLetters(user.UserName);
                            user.Password = "123456";
                            user.Sex = row.GetCell(1).StringCellValue;
                            user.Email = row.GetCell(2).StringCellValue;
                            user.ClassId = 0;

                            UserInfoService service = new UserInfoService();
                            bool result = service.Add(user);
                            if (result)
                            {
                                success += 1;
                            }
                            else
                            {
                                fail += 1;
                            }
                        }
                    }
                    Lit_Result.Text = "<font style='color:green;'>成功导入 " + success.ToString() + "条数据</font><font style='color:red'>失败" + fail.ToString() + "条</font>";
                }
            }
            catch (Exception ex)
            {
                ErrorLog.writeLogMessage(ex.Message, "EditRole_Btn_Export_Click");
            }

        }
    }
}