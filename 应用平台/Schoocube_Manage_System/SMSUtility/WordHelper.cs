using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Aspose.Words;
using Aspose.Words.Drawing;
using Aspose.Words.Saving;
using System.Data;
using System.IO;
using System.Web;

namespace SMSUtility
{
    public class WordHelper
    {
        public static void ExportByWeb(DataTable dtSource, string strHeaderText, string strFileName, string sheetName)
        {
            try
            {
                //HttpContext curContext = HttpContext.Current;
                //curContext.Response.ContentType = "application/msword";
                //curContext.Response.ContentEncoding = Encoding.UTF8;
                //curContext.Response.Charset = "";
                //curContext.Response.AppendHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(strFileName, Encoding.UTF8) + ".doc");
                //curContext.Response.BinaryWrite(Export(dtSource, strHeaderText, sheetName).GetBuffer());
                //curContext.ApplicationInstance.CompleteRequest();
                //Export(dtSource, strHeaderText, sheetName);
                Export(dtSource, strHeaderText, strFileName);
            }
            catch (Exception)
            {

                throw;
            }

        }
        public static void Export(DataTable tbl, string strHeaderText, string sheetName)
        {
            try
            {
                string[] headerArry = strHeaderText.Split(',');
                //此path指向你设计好的Word模板路径
                Aspose.Words.Document doc = new Aspose.Words.Document();
                DocumentBuilder builder = new DocumentBuilder(doc);
                //设置单元格内容对齐方式
                builder.ParagraphFormat.Alignment = ParagraphAlignment.Left;

                //清除设置
                builder.PageSetup.ClearFormatting();
                List<string> list = new List<string>();

                if (tbl != null && headerArry.Length > 0)
                {

                    double cellwidth = 165;
                    double cellheight = 18.5;

                    //匹配小组中的学员
                    builder.StartTable();//开始画Table             
                    builder.ParagraphFormat.Alignment = ParagraphAlignment.Center; // RowAlignment.Center;                 

                    string xz = string.Empty;
                    int count = 0;
                    int rowcount = 0;
                    //DataRow[] rows = tbl.Select("ID='" + xz + "'");
                    //加载小组
                    for (int i = 0; i < headerArry.Length; i++)
                    {
                        builder.Bold = true;
                        builder.InsertCell();
                        builder.RowFormat.Height = cellheight;
                        builder.CellFormat.VerticalMerge = Aspose.Words.Tables.CellMerge.None;
                        builder.CellFormat.Borders.LineStyle = LineStyle.Single;
                        builder.CellFormat.Width = cellwidth;
                        builder.Write(headerArry[i].SafeToString());
                    }
                    builder.EndRow();
                    foreach (DataRow row in tbl.Rows)
                    {
                        builder.Bold = false;
                        for (int j = 0; j < headerArry.Length; j++)
                        {
                            builder.InsertCell();
                            builder.RowFormat.Height = cellheight;
                            builder.CellFormat.VerticalMerge = Aspose.Words.Tables.CellMerge.None;
                            builder.CellFormat.Borders.LineStyle = LineStyle.Single;
                            builder.CellFormat.Width = cellwidth;
                            builder.Write(row[headerArry[j]].SafeToString());
                        }
                        builder.EndRow();
                    }
                    builder.EndTable();
                }
                string name = sheetName + ".doc";
                //以下载Word的形式打开Wrod
                Aspose.Words.Saving.HtmlSaveOptions options = new Aspose.Words.Saving.HtmlSaveOptions(SaveFormat.Html);
                Aspose.Words.Saving.DocSaveOptions docoptions = new Aspose.Words.Saving.DocSaveOptions(SaveFormat.Doc);
                //如图所示：Aspose.Words导出带图片人员信息到Word中
                //doc.Save(name, Aspose.Words.SaveFormat.Doc, Aspose.Words.SaveType.OpenInWord, Response);
                doc.Save(HttpContext.Current.Response, name, ContentDisposition.Attachment, docoptions);//13.3.1
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
