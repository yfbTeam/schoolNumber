using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SMSBLL;
using SMSModel;
using SMSUtility;
using System.Web.Script.Serialization;
using System.Collections;
using System.IO;
using Newtonsoft.Json.Linq;
namespace SMSWeb.CourseManage
{
    /// <summary>
    /// Uploade 的摘要说明
    /// </summary>
    public class Uploade : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;
        Couse_ResourceService bll = new Couse_ResourceService();

        public void ProcessRequest(HttpContext context)
        {
            string FuncName = context.Request["Func"].SafeToString();
            string result = string.Empty;

            context.Response.ContentType = "text/plain";
            if (FuncName != null && FuncName != "")
            {
                try
                {
                    switch (FuncName)
                    {
                        case "UplodWeik"://微课
                            UplodWeik(context);
                            break;
                        case "AddWeike"://更新上传文件数据
                            AddWeike(context, "");
                            break;
                        case "Uplod"://普通资源
                            Uplod(context);
                            break;
                        case "UploadTopic_Comment_Image":
                            UploadTopic_Comment_Image(context);
                            break;
                        case "DelWeike":
                            DelWeike(context);
                            break;
                        case "UplodeCourse_Work":
                            UplodeCourse_Work(context);
                            break;
                        case "UplodExcel":
                            UplodExcel(context);
                            break;
                        case "SetImage":
                            SetImage(context);
                            break;
                        case "UplodCert":
                            UplodCert(context);
                            break;
                        case "UplodLogo":
                            UplodLogo(context);
                            break;
                        case "UploadSubJect":
                            UploadSubJect(context);
                            break;

                        case "ImportSubJect":
                            ImportSubJect(context);
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
            //result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            //context.Response.Write(result);
            //context.Response.End();
        }
        private void UplodLogo(HttpContext context)
        {
            string Name = context.Request["Name"].SafeToString();

            string result = "";
            HttpPostedFile file = HttpContext.Current.Request.Files[0];
            string Fpath = "/images/";

            string ext = System.IO.Path.GetExtension(file.FileName);
            string fileName = Path.GetFileName(file.FileName);// DateTime.Now.Ticks + ext;
            string p = Fpath + "/" + fileName;
            string path = context.Server.MapPath(p);
            #region 处理文件同名问题
            if (FileHelper.IsExistFile(path))
            {
                FileHelper.DeleteFile(path);
            }
            #endregion

            file.SaveAs(path);
            if (Name != fileName)
            {
                FileHelper.Move(path, context.Server.MapPath("/images/" + Name));
            }
            result = "{\"error\":0,\"url\":\"" + context.Server.UrlEncode(p) + "\"}";
            context.Response.Write(result);
            context.Response.End();
        }
        private void UploadSubJect(HttpContext context)
        {
            Exam_ObjQuestionService bll = new Exam_ObjQuestionService();

            string Name = context.Request["Name"].SafeToString();

            string result = "";
            HttpPostedFile file = HttpContext.Current.Request.Files[0];
            string Fpath = ConfigHelper.GetConfigString("FileManageName") + "/Exam/Word/";

            string ext = System.IO.Path.GetExtension(file.FileName);
            string fileName = Path.GetFileName(file.FileName);// DateTime.Now.Ticks + ext;
            string p = Fpath + "/" + fileName;
            string path = context.Server.MapPath(p);
            #region 处理文件同名问题
            if (FileHelper.IsExistFile(path))
            {
                FileHelper.DeleteFile(path);
            }
            #endregion

            file.SaveAs(path);


            jsonModel = new JsonModel
            {
                errNum = 0,
                errMsg = "",
                retData = p
            };
            result = string.IsNullOrEmpty(result) ? "{\"result\":" + jss.Serialize(jsonModel) + "}" : result;

            context.Response.Write(result);
            context.Response.End();
        }
        public void ImportSubJect(HttpContext context)
        {
            string result = "";
            string path = context.Request["Path"];
            string url = "http://sp:9001/ImportByWord.ashx?Path=" + path;// context.Server.UrlEncode("C:\\Import\\2012年北京市夏季会考化学试卷.doc");
            result = NetHelper.RequestPostUrl(url, "");
            context.Response.Write(result);
            context.Response.End();

            /*if (result != "0")
            {
                JObject rtnObj = JObject.Parse(result);
                JObject resultObj = JsonTool.GetObjVal(rtnObj, "result");
                if (JsonTool.GetStringVal(resultObj, "errNum") == "0")
                {
                    JArray retData = JsonTool.GetArryVal(resultObj, "retData");
                    foreach (JObject obj in retData)
                    {
                        #region Exam_ObjQuestion赋值
                        Exam_ObjQuestion model = new Exam_ObjQuestion();
                        model.Klpoint = 2;
                        model.Book = "2";
                        model.Difficulty = 1;
                        model.Status = 1;
                        model.IsShowAnalysis = 2;
                        model.Author = "421002199011239361";
                        model.Score = 2;
                        model.Major = "10|1|1|2";

                        string content = JsonTool.GetStringVal(obj, "Content");
                        model.Title = content;
                        model.Content = content;
                        string Type = JsonTool.GetStringVal(obj, "Type");
                        switch (Type)
                        {
                            case "单选题":
                                model.Type = 1;
                                break;
                            case "多选题":
                                model.Type = 2;
                                break;
                            case "判断题":
                                model.Type = 6;
                                break;
                            case "简答题":
                                model.Type = 4;
                                break;
                            default:
                                break;
                        }

                        string Options = JsonTool.GetStringVal(obj, "Options");
                        string Analysis = JsonTool.GetStringVal(obj, "Analysis");
                        string Answer = JsonTool.GetStringVal(obj, "Answer");
                        if (Options.Length > 0)
                        {
                            model.OptionA = Sub("A.", "B.", content);// content.Substring(content.IndexOf("A.") + 2, content.IndexOf("B.") - content.IndexOf("A.") - 2).Trim();
                            model.OptionB = Sub("B.", "C.", content);//content.Substring(content.IndexOf("B.") + 2, content.IndexOf("C.") - content.IndexOf("B.") - 2).Trim();
                            model.OptionC = Sub("C.", "D.", content);//content.Substring(content.IndexOf("C.") + 2, content.IndexOf("D.") - content.IndexOf("C.") - 2).Trim();
                            model.OptionD = Sub("D.", "E.", content);//content.Substring(content.IndexOf("D.") + 2, content.IndexOf("E.") - content.IndexOf("D.") - 2).Trim();
                            model.OptionE = Sub("E.", "F.", content);//content.Substring(content.IndexOf("E.") + 2, content.IndexOf("F.") - content.IndexOf("E.") - 2).Trim();
                            model.OptionF = Sub("F.", "", content);//content.Substring(content.IndexOf("F.") + 2, content.Length - content.IndexOf("F.") - 2).Trim();
                        }
                        model.Answer = Answer;
                        model.Analysis = Analysis;
                        #endregion
                        bll.Add(model);
                    }
                }*/
            //}
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
        private void UplodCert(HttpContext context)
        {
            string result = "";
            HttpPostedFile file = HttpContext.Current.Request.Files[0];
            string Fpath = ConfigHelper.GetConfigString("FileManageName") + "/Attatchment/Certificates/";
            FileHelper.CreateDirectory(context.Server.MapPath(Fpath));

            string ext = System.IO.Path.GetExtension(file.FileName);
            string fileName = Path.GetFileName(file.FileName);// DateTime.Now.Ticks + ext;
            string p = Fpath + "/" + fileName;
            string path = context.Server.MapPath(p);
            #region 处理文件同名问题
            if (FileHelper.IsExistFile(path))
            {
                int i = 0;
                while (true)
                {
                    i++;
                    if (!FileHelper.IsExistFile(context.Server.MapPath(Fpath + "/" + fileName.Split('.')[0] + "(" + i + ")" + "." + fileName.Split('.')[1])))
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
        }

        #region 导入Excel
        /// <summary>
        /// 导入Excel
        /// </summary>
        /// <param name="context"></param>
        private void UplodExcel(HttpContext context)
        {
            string result = "";
            string ExportMessage = "";
            HttpPostedFile file = HttpContext.Current.Request.Files[0];
            int fileLen = file.ContentLength;

            byte[] fileBytes = new byte[fileLen - 1];// FileUpload1.FileBytes;
            if (ExcelRender.HasData(new MemoryStream(fileBytes)))
            {
                int rowAffected = ExcelRender.RenderToDb(new MemoryStream(fileBytes), "insert into test(aa,bb,cc)", SqlHelper.ExecuteNonQuery);
                ExportMessage = "成功导入数据，共：" + rowAffected.ToString() + "条";
            }
            jsonModel = new JsonModel()
            {
                errNum = 0,
                errMsg = "",
                retData = ExportMessage
            };
            result = string.IsNullOrEmpty(result) ? "{\"result\":" + jss.Serialize(jsonModel) + "}" : result;
            context.Response.Write(result);
            context.Response.End();

        }
        #endregion

        #region 上传资源
        /// <summary>
        /// 上传微课资源
        /// </summary>
        /// <param name="context"></param>
        private void UplodWeik(HttpContext context)
        {
            string result = "";
            JsonModel JsonModel = new JsonModel();
            string UserIdCard = context.Request["UserIdCard"].SafeToString();
            string Type = context.Request["Type"].SafeToString();
            HttpPostedFile file = HttpContext.Current.Request.Files[0];
            string Fpath = ConfigHelper.GetConfigString("FileManageName") + "/PubFolder/Cource/微课/";
            FileHelper.CreateDirectory(context.Server.MapPath(Fpath));

            string ext = System.IO.Path.GetExtension(file.FileName);

            string fileName = Path.GetFileName(file.FileName);// DateTime.Now.Ticks + ext;

            string p = Fpath + "/" + fileName;

            string path = context.Server.MapPath(p);
            #region 处理文件同名问题
            if (FileHelper.IsExistFile(path))
            {
                int i = 0;
                while (true)
                {
                    i++;
                    if (!FileHelper.IsExistFile(context.Server.MapPath(Fpath + "/" + fileName.Split('.')[0] + "(" + i + ")" + "." + fileName.Split('.')[1])))
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
            if (Type == "1")
            {
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "",
                    retData = p
                };
            }
            else
            {
                ResourcesInfoService resourcedll = new ResourcesInfoService();
                ResourcesInfo re = new ResourcesInfo();
                re.Name = fileName.Split('.')[0];
                re.FileSize = file.ContentLength;
                re.FileUrl = p;
                re.CreateTime = Convert.ToDateTime(DateTime.Now.ToString("yyyy-MM-dd"));
                re.FileIcon = "ic" + fileName.Split('.')[1] + ".gif";
                re.postfix = "." + fileName.Split('.')[1];
                re.EidtTime = re.CreateTime;
                re.CreateUID = UserIdCard;
                re.EditUID = UserIdCard;

                re.DownCount = 0;
                re.CheckMessage = "";
                re.CatagoryID = "";
                re.ChapterID = 0;
                re.IsOpen = 0;
                re.Status = 0;
                re.FileGroup = "微课";
                JsonModel = resourcedll.Add(re);
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "",
                    retData = JsonModel.retData.ToString() + "-" + p
                };
                if (context.Request["CourceID"] != null)
                {
                    AddWeike(context, jsonModel.retData.ToString());
                }
            }
            result = "{\"error\":0,\"url\":\"" + context.Server.UrlEncode(p) + "\"}";
            context.Response.Write(result);
            context.Response.End();

        }

        /// <summary>
        /// 上传普通资源
        /// </summary>
        /// <param name="context"></param>
        private void Uplod(HttpContext context)
        {
            string result = "";
            HttpPostedFile file = HttpContext.Current.Request.Files[0];
            string Fpath = ConfigHelper.GetConfigString("FileManageName") + "/Attatchment/CourceAttr";
            FileHelper.CreateDirectory(context.Server.MapPath(Fpath));

            string ext = System.IO.Path.GetExtension(file.FileName);

            string fileName = Path.GetFileName(file.FileName); //DateTime.Now.Ticks + ext;

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
            jsonModel = new JsonModel()
            {
                errNum = 0,
                errMsg = "",
                retData = p
            };
            result = string.IsNullOrEmpty(result) ? "{\"result\":" + jss.Serialize(jsonModel) + "}" : result;
            context.Response.Write(result);
            context.Response.End();

        }
        #endregion

        #region 新增资源
        /// <summary>
        /// 新增资源
        /// </summary>
        /// <param name="context"></param>
        private void AddWeike(HttpContext context, string id)
        {
            string result = "";
            Couse_Resource model = new Couse_Resource();
            try
            {
                model.IsVideo = Convert.ToByte(context.Request["IsVideo"]);
                model.VidoeImag = context.Request["VidoeImag"].SafeToString();
                model.CouseID = int.Parse(context.Request["CourceID"].SafeToString());
                model.ChapterID = context.Request["ChapterID"].SafeToString();
                model.CreateUID = "";
                string resourceid = "";
                if (id != "")
                {
                    resourceid = id;
                }
                else
                {
                    resourceid = context.Request["ResourcesID"].SafeToString();
                }
                if (resourceid.Length > 0)
                {
                    string[] idArray = resourceid.Split(',');
                    for (int i = 0; i < idArray.Length; i++)
                    {
                        if (idArray[i].Length > 0)
                        {
                            model.ResourcesID = int.Parse(idArray[i]);
                            jsonModel = bll.Add(model);
                        }
                    }
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
        #endregion

        #region 删除微课
        /// <summary>
        ///  删除微课
        /// </summary>
        /// <param name="contex"></param>
        private void DelWeike(HttpContext context)
        {
            string result = "";
            Couse_ResourceService Bll = new Couse_ResourceService();
            string id = context.Request.Form["DelID"].SafeToString();
            try
            {
                #region 文件删除
                JsonModel model = Bll.GetEntityById(int.Parse(id));
                Couse_Resource resource = (Couse_Resource)(model.retData);
                string FileUrl = resource.VidoeImag;

                FileHelper.DeleteFile(context.Server.MapPath(FileUrl));
                #endregion
                //数据删除
                jsonModel = Bll.Delete(int.Parse(id));
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
        #endregion

        #region 上传评论图片
        public void UploadTopic_Comment_Image(HttpContext context)
        {
            string result = "";
            HttpPostedFile file = HttpContext.Current.Request.Files[0];
            string Fpath = ConfigHelper.GetConfigString("FileManageName") + "/Attatchment/Topic_Comment_Image";
            FileHelper.CreateDirectory(context.Server.MapPath(Fpath));

            string ext = System.IO.Path.GetExtension(file.FileName);
            string fileName = DateTime.Now.Ticks + ext;
            string p = Fpath + "/" + fileName;
            string path = context.Server.MapPath(p);
            file.SaveAs(path);
            result = "{\"error\":0,\"url\":\"" + p + "\"}";
            context.Response.Write(result);
            context.Response.End();

        }
        #endregion

        #region 上传我的应用图片
        /// <summary>
        /// 上传我的应用图片
        /// </summary>
        /// <param name="context"></param>
        public void SetImage(HttpContext context)
        {
            string result = "";
            HttpPostedFile file = HttpContext.Current.Request.Files[0];
            string Fpath = ConfigHelper.GetConfigString("FileManageName") + "/Attatchment/Exam"; //"/images/MenuImage";
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
            result = string.IsNullOrEmpty(result) ? "{\"result\":" + jss.Serialize(jsonModel) + "}" : result;
            context.Response.Write(result);
            context.Response.End();

        }
        #endregion

        #region 上传作业
        /// <summary>
        /// 上传作业
        /// </summary>
        /// <param name="context"></param>
        private void UplodeCourse_Work(HttpContext context)
        {
            string result = "";
            HttpPostedFile file = HttpContext.Current.Request.Files[0];
            string Fpath = "/Attatchment/CourseWork";
            FileHelper.CreateDirectory(context.Server.MapPath(Fpath));
            string ext = System.IO.Path.GetExtension(file.FileName);
            string fileName = System.IO.Path.GetFileNameWithoutExtension(file.FileName) + "_" + DateTime.Now.Ticks + ext;
            string p = Fpath + "/" + fileName;
            string path = context.Server.MapPath(p);
            file.SaveAs(path);
            jsonModel = new JsonModel()
            {
                errNum = 0,
                errMsg = "",
                retData = p
            };
            result = string.IsNullOrEmpty(result) ? "{\"result\":" + jss.Serialize(jsonModel) + "}" : result;
            context.Response.Write(result);
            context.Response.End();

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