using Newtonsoft.Json.Linq;
using SMSBLL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb.CourseManage
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string result = "0Byte";
            long fileSize = FileHelper.GetDirectoryLength(Server.MapPath(TextBox1.Text));
            if (fileSize > 1024 * 1024 && fileSize < 1024 * 1024 * 1024)
            {
                result = Convert.ToDouble(fileSize / 1024 / 1024).ToString() + "MB";
            }
            else if (fileSize > 1024 && fileSize < 1024 * 1024)
            {
                result = Convert.ToDouble(fileSize / 1024).ToString() + "KB";
            }
            else if (fileSize < 1024)
            {
                result = fileSize.ToString() + "Byte";
            }
            Label1.Text = result;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            try
            {
                UPload();
            }
            catch (Exception ex)
            {
                string message = ex.Message;
            }
            //    HttpPostedFile file = FileUpload1.PostedFile;
            //    string fileName = Path.GetFileName(file.FileName);

            //    string p = Server.MapPath("/Attatchment/" + fileName);
            //    FileHelper.CreateDirectory(Server.MapPath("/Attatchment/"));

            //    file.SaveAs(p);
            //    FileHelper.CopyTo(p, Server.MapPath("/Attatchment/test.htm"));
            //TextBox2.Text = fileData;
        }

        private void UPload()
        {
            string url = "http://sp:9001/ImportByWord.ashx?Path=" + Server.UrlEncode("C:\\Import\\2012年北京市夏季会考化学试卷.doc");
            string result = NetHelper.RequestPostUrl(url, "");
            if (result != "0")
            {
                JObject rtnObj = JObject.Parse(result);
                JObject resultObj = JsonTool.GetObjVal(rtnObj, "result");
                if (JsonTool.GetStringVal(resultObj, "errNum") == "0")
                {
                    JArray retData = JsonTool.GetArryVal(resultObj, "retData");
                    foreach (JObject obj in retData)
                    {
                        string Content = JsonTool.GetObjVal(obj, "Content").SafeToString();
                    }

                }
            }

            #region
            /*
            Exam_ObjQuestionService bll1 = new Exam_ObjQuestionService();
            Exam_ExamPaperSubQService bll2 = new Exam_ExamPaperSubQService();
            //筛选合法文件
            string fileName = this.FileUpload1.FileName;
            string fileType = ".doc,.docx";
            int dian = fileName.LastIndexOf('.');
            string exten = fileName.Substring(dian);//得到后缀名
            int IsHas = fileType.IndexOf(exten);//根据后缀名查找对比
            if (IsHas == -1)//没有找到对应的后缀名称时
            {

                //this.lblText.Text = "不允许上传非法图片！";
                this.FileUpload1.Focus();
                return;

            }
            else
            {
                object oMissing = System.Reflection.Missing.Value.SafeToString();
                //打开文档
                Microsoft.Office.Interop.Word._Application oWord = null;
                Microsoft.Office.Interop.Word._Document oDoc = null;//记录word打开的文档

                oWord = new Microsoft.Office.Interop.Word.Application();
                oWord.Visible = false;

                //得到绝对的路径
                //string path = this.FileUpload1.PostedFile.FileName;//IE问题，现只有IE6能得到全路径
                object path = @"C:\数字校园\应用平台\Schoocube_Manage_System\SMSWeb\Attatchment\2012年北京市夏季会考化学试卷.doc";// +FileUpload1.FileName; //暂时取的死路径
                //打开文档
                oDoc = oWord.Documents.Open(ref path,
                ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing,
                ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing,
                ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing);
                object unknow = Type.Missing;
                object saveChanges = Microsoft.Office.Interop.Word.WdSaveOptions.wdPromptToSaveChanges;
                Exam_ObjQuestion model1 = new Exam_ObjQuestion();
                Exam_ExamPaperSubQ model2 = new Exam_ExamPaperSubQ();
                List<OnlineExam> list = new List<OnlineExam>();
                for (int i = 1; i < oDoc.Paragraphs.Count; i++)
                {
                    string content = oDoc.Paragraphs[i].Range.Text.Trim().Replace("．", ".");
                    model1.Klpoint = 2;
                    model1.Book = "2";
                    model1.Difficulty = 1;
                    model1.Status = 1;
                    model1.IsShowAnalysis = 2;
                    model1.Author = "421002199011239361";
                    model1.Score = 2;
                    model1.Major = "10|1|1|2";
                    //int k = 0;
                    //int j = 0;

                    if (content == "单选题")
                    {
                        model1.Type = 1;
                        model2.Type = 0;
                    }
                    else if (content == "多选题")
                    {
                        model1.Type = 2; model2.Type = 0;
                    }
                    else if (content == "判断题")
                    {
                        model1.Type = 6; model2.Type = 0;
                    }
                    else if (content == "简答题")
                    {
                        model2.Type = 4; model1.Type = 0;
                    }
                    else if (model1.Type + model2.Type > 0)
                    {
                        if (model2.Type == 0)
                        {
                            if (content.IndexOf(".") == 1 && content.IndexOf("A") != 0)
                            {
                                model1.Title = content.Substring(2, content.Length - 2);
                                model1.Content = content.Substring(2, content.Length - 2);
                                //if (k > 0)
                                //{
                                //    bll1.Add(model1);
                                //}
                                //k++;
                            }
                            if (content.IndexOf("A.") == 0)
                            {

                                model1.OptionA = Sub("A.", "B.", content);// content.Substring(content.IndexOf("A.") + 2, content.IndexOf("B.") - content.IndexOf("A.") - 2).Trim();
                                model1.OptionB = Sub("B.", "C.", content);//content.Substring(content.IndexOf("B.") + 2, content.IndexOf("C.") - content.IndexOf("B.") - 2).Trim();
                                model1.OptionC = Sub("C.", "D.", content);//content.Substring(content.IndexOf("C.") + 2, content.IndexOf("D.") - content.IndexOf("C.") - 2).Trim();
                                model1.OptionD = Sub("D.", "E.", content);//content.Substring(content.IndexOf("D.") + 2, content.IndexOf("E.") - content.IndexOf("D.") - 2).Trim();
                                model1.OptionE = Sub("E.", "F.", content);//content.Substring(content.IndexOf("E.") + 2, content.IndexOf("F.") - content.IndexOf("E.") - 2).Trim();
                                model1.OptionF = Sub("F.", "", content);//content.Substring(content.IndexOf("F.") + 2, content.Length - content.IndexOf("F.") - 2).Trim();
                            }
                            if (content.IndexOf("答案：") == 0)
                            {
                                model1.Answer = content.Substring(content.IndexOf("答案：")+3, content.Length-3);
                            }
                            if (content.IndexOf("解析：") == 0)
                            {
                                model1.Analysis = content.Substring(content.IndexOf("解析：")+3, content.Length-3);
                                bll1.Add(model1);
                            }
                        }
                    }
                    #region 注释
                    //if (i == 1 || i % 6 == 1)//题目
                    //{
                    //    exam = new OnlineExam();
                    //    exam.Content = Convert.ToString(oDoc.Paragraphs[i].Range.Text.Trim());
                    //}
                    //if (i == 2 || i % 6 == 2)//答案A
                    //{
                    //    exam.Ques_key_a = Convert.ToString(oDoc.Paragraphs[i].Range.Text.Trim().Replace("A.", ""));
                    //}
                    //if (i == 3 || i % 6 == 3)//答案B
                    //{
                    //    exam.Ques_key_b = Convert.ToString(oDoc.Paragraphs[i].Range.Text.Trim().Replace("B.", ""));
                    //}
                    //if (i == 4 || i % 6 == 4)//答案C
                    //{
                    //    exam.Ques_key_c = Convert.ToString(oDoc.Paragraphs[i].Range.Text.Trim().Replace("C.", ""));
                    //}
                    //if (i == 5 || i % 6 == 5)//答案D
                    //{
                    //    exam.Ques_key_d = Convert.ToString(oDoc.Paragraphs[i].Range.Text.Trim().Replace("D.", ""));
                    //}
                    //if (i == 6 || i % 6 == 0)//正确答案
                    //{
                    //    string correctKey = Convert.ToString(oDoc.Paragraphs[i].Range.Text.Trim());
                    //    int indexof = correctKey.IndexOf("：");
                    //    if (indexof < 0)
                    //    {
                    //        //关闭word文档
                    //        oWord.ActiveDocument.Close(ref saveChanges, ref unknow, ref unknow);
                    //        //关闭word程序
                    //        oWord.Quit(ref saveChanges, ref unknow, ref unknow);
                    //        //this.lblText.Text = "第" + i / 6 + "题附近，试题文档标准格式有误，请检查！";
                    //        return;
                    //    }
                    //    string correctKey2 = correctKey.Substring(indexof + 1, correctKey.Length - (indexof + 1));
                    //    exam.Ques_correctKey = correctKey2;
                    //    if (correctKey2.Split(',').Length > 1)
                    //    {
                    //        exam.Ques_check_type = 1;//多选
                    //    }
                    //    else
                    //    {
                    //        exam.Ques_check_type = 0;//单选
                    //    }
                    //    list.Add(exam);
                    //}
                    #endregion
                }
                #region
                //if (list.Count > 0)
                //{
                //    questions_info questions = null;
                //    for (int i = 0; i < list.Count; i++)
                //    {
                //        questions = new questions_info();
                //        //questions.ques_typeId = Convert.ToInt32(ddlques_type.SelectedValue);
                //        questions.ques_check_type = Convert.ToInt32(list[i].Ques_check_type);
                //        questions.ques_registTime = DateTime.Now;
                //        questions.content = list[i].Content;
                //        questions.ques_key_a = list[i].Ques_key_a;
                //        questions.ques_key_b = list[i].Ques_key_b;
                //        questions.ques_key_c = list[i].Ques_key_c;
                //        questions.ques_key_d = list[i].Ques_key_d;
                //        //questions.ques_correctKey = list[i].Ques_correctKey;
                //        //examManageBll.InsertIntoQuestions(questions);
                //    }
                //    //this.lblText.Text = "上传成功！";
                //}
                //if (list.Count == 0)
                //{
                //    // this.lblText.Text = "文档格式标准有误，请检查！";
                //}
                //TextBox1.Text = str;
                #endregion
                //关闭word文档
                oWord.ActiveDocument.Close(ref saveChanges, ref unknow, ref unknow);
                //关闭word程序
                oWord.Quit(ref saveChanges, ref unknow, ref unknow);
            }
            */
            #endregion
        }

        public string Sub(string Section1, string Section2, string Content)
        {
            int StartLen = Content.IndexOf(Section1) + 2;
            int Len = Content.IndexOf(Section2) - StartLen;
            if (Section2 == "" || Len < 0)
            {
                Len = Content.Length - StartLen;
            }
            if (Len > 0 && StartLen > 1)
            {
                return Content.Substring(StartLen, Len);
            }
            else
                return "";
        }

    }
}