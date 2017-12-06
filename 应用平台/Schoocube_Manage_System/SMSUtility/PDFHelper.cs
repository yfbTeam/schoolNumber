using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Aspose.Pdf;
using System.IO;
using System.Data;
using System.Web;

namespace SMSUtility
{
    public class PDFHelper
    {
        public static void ExportByWeb(DataTable dtSource, string strHeaderText, string strFileName, string sheetName)
        {
            try
            {
                HttpContext curContext = HttpContext.Current;
                curContext.Response.ContentType = "application/pdf";
                curContext.Response.ContentEncoding = Encoding.UTF8;
                curContext.Response.Charset = "";
                curContext.Response.AppendHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(strFileName, Encoding.UTF8) + ".pdf");
                curContext.Response.BinaryWrite(Export(dtSource, strHeaderText, sheetName).ToArray());
                curContext.ApplicationInstance.CompleteRequest();
            }
            catch (Exception)
            {

                throw;
            }

        }
        public static MemoryStream Export(DataTable tbl, string strHeaderText, string sheetName)
        {
            try
            {
                //string dataDir = RunExamples.GetDataDir_AsposePdfGenerator_AdvanceFeatures();
                Aspose.Pdf.Generator.Pdf pdf1 = new Aspose.Pdf.Generator.Pdf();
                // Load source PDF document
                Aspose.Pdf.Document doc = new Aspose.Pdf.Document();
                // Initializes a new instance of the Table
                doc.Pages.Add();
                Aspose.Pdf.Table table = new Aspose.Pdf.Table();
                //table.ColumnWidths = "40 100 100 100";
                // Set the table border color as LightGray
                table.Border = new Aspose.Pdf.BorderInfo(Aspose.Pdf.BorderSide.All, .5f, System.Drawing.Color.LightGray);
                // Set the border for table cells
                table.DefaultCellBorder = new Aspose.Pdf.BorderInfo(Aspose.Pdf.BorderSide.All, .5f, System.Drawing.Color.LightGray);
                // Create a loop to add 10 rows
                string[] header = strHeaderText.Split(',');
                if (header.Length > 0)
                {
                    Aspose.Pdf.Row row = table.Rows.Add();
                    for (int i = 0; i < header.Length; i++)
                    {
                        row.Cells.Add(header[i]);
                    }
                }


                foreach (DataRow r in tbl.Rows)
                {
                    Aspose.Pdf.Row row = table.Rows.Add();
                    for (int i = 0; i < header.Length; i++)
                    {
                        row.Cells.Add((r[header[i]]).SafeToString());
                    }
                }
                // Add table object to first page of input document
                doc.Pages[1].Paragraphs.Add(table);
                using (MemoryStream ms = new MemoryStream())
                {

                    doc.Save(ms);
                    return ms;
                }


            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
