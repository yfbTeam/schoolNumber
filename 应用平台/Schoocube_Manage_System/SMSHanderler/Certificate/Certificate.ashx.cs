using SMSBLL;
using SMSHanderler.OnlineLearning;
using SMSModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SMSHanderler.Certificate
{
    /// <summary>
    /// Certificate 的摘要说明
    /// </summary>
    public class Certificate : IHttpHandler
    {
        TrainingFilesService bll = new TrainingFilesService();
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;
        Course_ChapterService courcebll = new Course_ChapterService();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string FuncName = context.Request["Func"].ToString();
            string result = string.Empty;

            if (FuncName != null && FuncName != "")
            {

                switch (FuncName)
                {
                    case "GetModolList":
                        GetModolList(context);
                        break;
                    case "GetCertificates":
                        GetCertificates(context);
                        break;
                    case "PersonDocument":
                        PersonDocument(context);
                        break;
                    case "EditPersonDocument":
                        EditPersonDocument(context);
                        break;
                    case "GetPlatCertificate":
                        GetPlatCertificate(context);
                        break;
                    case "EditDoc":
                        EditDoc(context);
                        break;
                    case "AddPlatCertificate":
                        AddPlatCertificate(context);
                        break;
                    case "ApplyCert":
                        ApplyCert(context);
                        break;
                    case "CheckApply":
                        CheckApply(context);
                        break;
                    case "DelPlatCertificate":
                        DelPlatCertificate(context);
                        break;
                    case "AddDocList":
                        AddDocList(context);
                        break;
                    case "EditCert":
                        EditCert(context);
                        break;
                    default:
                        jsonModel = new JsonModel()
                        {
                            errNum = 404,
                            errMsg = "无此方法",
                            retData = ""
                        };
                        break;
                }
                LogService.WriteLog("");

            }
            context.Response.End();
        }
        private void EditCert(HttpContext context)
        {
            string result = "";
            string ID = context.Request["ID"].SafeToString();
            string Attachment = context.Request["Attachment"].SafeToString();
            string Type = context.Request["Type"].SafeToString();
            if (Type == "1")
            {
                CertificateListService bll = new CertificateListService();
                CertificateList modole = new CertificateList();
                modole.ID = int.Parse(ID);
                modole.Attachment = Attachment;
                jsonModel = bll.Update(modole);
            }
            else
            {
                CertificateManageService bll = new CertificateManageService();
                CertificateManage modole = new CertificateManage();
                modole.ID = int.Parse(ID);
                modole.Attachment = Attachment;
                jsonModel = bll.Update(modole);
            }
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
        }

        #region 更新追加个人档案
        /// <summary>
        /// 更新追加个人档案
        /// </summary>
        /// <param name="context"></param>
        private void AddDocList(HttpContext context)
        {
            string result = "";

            PersonDocumentService docbll = new PersonDocumentService();
            string Messagee = docbll.AddDocList();
            if (Messagee == "添加成功")
            {
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = Messagee,
                    retData = ""
                };
            }
            else
            {
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = Messagee,
                    retData = ""
                };
            }
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
        }
        #endregion

        #region 证书申请审核
        /// <summary>
        /// 证书申请审核
        /// </summary>
        /// <param name="context"></param>
        private void CheckApply(HttpContext context)
        {
            string result = "";
            string ID = context.Request["ID"].SafeToString();
            string CheckMessage = context.Request["CheckMessage"].SafeToString();
            string isPass = context.Request["isPass"].SafeToString();
            string UserIdCard = context.Request["UserIdCard"].SafeToString();
            CertificateListService bll = new CertificateListService();
            CertificateList modle = new CertificateList();
            modle.ID = int.Parse(ID);
            modle.Status = int.Parse(isPass);
            modle.EditTime = DateTime.Now;
            modle.EditUID = UserIdCard;
            modle.ApplyMessage = CheckMessage;
            jsonModel = bll.Update(modle);
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);

        }
        #endregion

        #region 证书申请
        //证书申请
        private void ApplyCert(HttpContext context)
        {
            string result = "";
            string ClassID = context.Request["ClassID"].SafeToString();
            string StuNo = context.Request["StuNo"].SafeToString();
            string StuName = context.Request["StuName"].SafeToString();
            string CertificateID = context.Request["CertificateID"].SafeToString();

            CertificateManageService bll = new CertificateManageService();
            string Messagee = bll.Apply(CertificateID, StuName, StuNo, ClassID);
            if (Messagee == "添加成功")
            {
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = Messagee,
                    retData = ""
                };
            }
            else
            {
                jsonModel = new JsonModel()
                {
                    errNum = 999,
                    errMsg = Messagee,
                    retData = ""
                };
            }
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
        }
        #endregion

        #region 添加平台证书
        private void AddPlatCertificate(HttpContext context)
        {
            string result = "";
            string Name = context.Request["Name"].SafeToString();
            string Course = context.Request["Course[]"].SafeToString();
            string Exam1 = context.Request["Exam1"].SafeToString();
            string Scor1 = context.Request["Scor1"].SafeToString();
            string Exam2 = context.Request["Exam2"].SafeToString();
            string Scor2 = context.Request["Scor2"].SafeToString();
            string Exam3 = context.Request["Exam3"].SafeToString();
            string Scor3 = context.Request["Scor3"].SafeToString();
            string UserIdCard = context.Request["UserIdCard"].SafeToString();
            string ModelID = context.Request["ModelID"].SafeToString();
            CertificateManageService bll = new CertificateManageService();
            string ID = context.Request["ID"].SafeToString();
            if (ID.Length > 0)
            {
                string Messagee = bll.PlatCertificateEdit(Name, Course, Exam1, Scor1, Exam2, Scor2, Exam3, Scor3, UserIdCard, ModelID, int.Parse(ID));
                if (Messagee == "修改成功")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = Messagee,
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = Messagee,
                        retData = ""
                    };
                }
            }
            else
            {
                string Messagee = bll.PlatCertificateAdd(Name, Course, Exam1, Scor1, Exam2, Scor2, Exam3, Scor3, UserIdCard, ModelID);
                if (Messagee == "添加成功")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = Messagee,
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                        {
                            errNum = 0,
                            errMsg = Messagee,
                            retData = ""
                        };
                }
            }
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
        }
        #endregion

        #region 档案归档
        /// <summary>
        /// 档案归档
        /// </summary>
        /// <param name="context"></param>
        private void EditDoc(HttpContext context)
        {
            string result = "";
            string TableName = context.Request["TableName"].SafeToString();
            try
            {
                if (TableName == "PersonDocument")
                {
                    PersonDocumentService dll = new PersonDocumentService();
                    PersonDocument document = new PersonDocument();
                    document.ID = int.Parse(context.Request["EditID"]);
                    document.Status = Convert.ToByte(context.Request["Status"]);
                    jsonModel = dll.Update(document);
                }
                else
                {
                    TrainingFilesService dll = new TrainingFilesService();
                    TrainingFiles document = new TrainingFiles();
                    document.ID = int.Parse(context.Request["EditID"]);
                    document.Status = Convert.ToByte(context.Request["Status"]);
                    jsonModel = dll.Update(document);
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
        }
        #endregion

        #region 删除平台正式
        /// <summary>
        /// 删除平台正式
        /// </summary>
        /// <param name="context"></param>
        private void DelPlatCertificate(HttpContext context)
        {
            string result = "";
            string UserIdCard = context.Request["UserIdCard"].SafeToString();

            string ID = context.Request["ID"].SafeToString();
            CertificateManageService CertificateManage = new CertificateManageService();
            string Messagee = CertificateManage.PlatCertificateDel(UserIdCard, int.Parse(ID));

            if (Messagee == "删除成功")
            {
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = Messagee,
                    retData = ""
                };
            }
            else
            {
                jsonModel = new JsonModel()
                {
                    errNum = 999,
                    errMsg = Messagee,
                    retData = ""
                };
            }

            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);

        }
        #endregion

        #region 获取平台证书
        private void GetPlatCertificate(HttpContext context)
        {
            string result = "";
            Hashtable ht = new Hashtable();
            ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
            ht.Add("PageSize", context.Request["PageSize"].SafeToString());
            string CertID = context.Request["ID"].SafeToString();
            bool Ispage = true;
            if (context.Request["Ispage"].SafeToString().Length > 0)
            {
                Ispage = Convert.ToBoolean(context.Request["Ispage"]);
            }
            string str = "select a.*,b.ImageUrl from CertificateManage a,CertificateModol b where a.ModelID=b.ID ";

            if (CertID.Length > 0)
            {
                str += " and a.ID=" + CertID;
            }
            ht.Add("TableName", "(" + str + ")");

            CertificateManageService CertificateManage = new CertificateManageService();
            JsonModel CertiModel = CertificateManage.GetPage(ht, Ispage, "");
            result = "{";
            result += "\"CertificateManage\":" + jss.Serialize(CertiModel);

            Hashtable ht1 = new Hashtable();
            ht1.Add("PageIndex", context.Request["PageIndex"].SafeToString());
            ht1.Add("PageSize", context.Request["PageSize"].SafeToString());
            ht1.Add("TableName", "(select b.Title,T.*  from Exam_ExamPaper b,CertificateExam T  WHERE 1=1  and T.examID=b.ID)");

            CertificateExamService CertificateExam = new CertificateExamService();
            JsonModel Exam = CertificateManage.GetPage(ht1, false);
            result += ",\"Exam\":" + jss.Serialize(Exam);

            Hashtable ht2 = new Hashtable();
            ht2.Add("PageIndex", context.Request["PageIndex"].SafeToString());
            ht2.Add("PageSize", context.Request["PageSize"].SafeToString());
            ht2.Add("TableName", "(select b.Name as CourseName,T.* from Course b,CertificateCourse T  WHERE 1=1  and T.CourseID=b.ID)");

            CertificateCourseService CertificateCourse = new CertificateCourseService();
            JsonModel Course = CertificateCourse.GetPage(ht2, false);
            result += ",\"Course\":" + jss.Serialize(Course);
            result += "}";
            context.Response.Write(result);

        }
        #endregion

        #region 个人档案
        /// <summary>
        /// 获取培训信息
        /// </summary>
        /// <param name="context"></param>
        private void PersonDocument(HttpContext context)
        {
            PersonDocumentService dll = new PersonDocumentService();
            string result = "";
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("TableName", "PersonDocument");
                string IDCart = context.Request["IDCart"].SafeToString();
                bool Ispage = false;
                if (context.Request["Ispage"].SafeToString().Length > 0)
                {
                    Ispage = Convert.ToBoolean(context.Request["Ispage"]);
                }
                if (IDCart.Length > 0)
                {
                    jsonModel = bll.GetPage(ht, Ispage, " and IDCart='" + IDCart+"'");
                }
                else
                {
                    jsonModel = dll.GetPage(ht, Ispage);
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
        }


        private void EditPersonDocument(HttpContext context)
        {
            PersonDocumentService dll = new PersonDocumentService();
            PersonDocument model = new PersonDocument();
            string result = "";
            try
            {
                model.ID = Convert.ToInt32(context.Request["ID"]);
                string Age = context.Request["Age"].SafeToString();
                if (Age.Length > 0)
                {
                    model.Age = Convert.ToInt32(Age);
                }
                else
                {
                    model.Age = 0;
                }
                string BirsDay = context.Request["BirsDay"].SafeToString();
                if (BirsDay.Length > 0)
                {
                    model.BirsDay = Convert.ToDateTime(BirsDay);
                }
                else
                {
                    model.BirsDay = DateTime.Now;
                }
                model.Sex = context.Request["Sex"].SafeToString();
                model.CompnyType = context.Request["CompnyType"].SafeToString();
                model.ComponyName = context.Request["ComponyName"].SafeToString();
                model.CurrentJob = context.Request["CurrentJob"].SafeToString();
                model.FamilyPeople = context.Request["FamilyPeople"].SafeToString();
                model.HalfEdudate = context.Request["HalfEdudate"].SafeToString();
                model.JobDegree = context.Request["JobDegree"].SafeToString();
                string JobTime = context.Request["JobTime"].SafeToString();
                if (JobTime.Length > 0)
                {
                    model.JobTime = Convert.ToDateTime(JobTime);
                }
                else
                {
                    model.JobTime = DateTime.Now;
                }
                string JobYear = context.Request["JobYear"].SafeToString();
                if (JobYear.Length > 0)
                {
                    model.JobYear = Convert.ToInt32(JobYear);
                }
                else
                {
                    model.JobYear = 0;
                }
                string joinTime = context.Request["joinTime"].SafeToString();
                if (joinTime.Length > 0)
                {
                    model.joinTime = Convert.ToDateTime(joinTime);
                }
                else
                {
                    model.joinTime = DateTime.Now;
                }
                model.Major = context.Request["Major"].SafeToString();
                string MaritalStatus = context.Request["MaritalStatus"].SafeToString();
                model.MaritalStatus = MaritalStatus;
                //if (MaritalStatus.Length > 0)
                //{
                //    model.MaritalStatus = Convert.ToInt32(MaritalStatus);
                //}
                //else
                //{
                //    model.MaritalStatus = 0;
                //}
                model.Nation = context.Request["Nation"].SafeToString();
                model.Origion = context.Request["Origion"].SafeToString();
                model.PersonIdentity = context.Request["PersonIdentity"].SafeToString();
                model.PoliticalStatus = context.Request["PoliticalStatus"].SafeToString();
                model.RewardExperience = context.Request["RewardExperience"].SafeToString();
                model.SchoolExperience = context.Request["SchoolExperience"].SafeToString();
                model.WorkExperience = context.Request["WorkExperience"].SafeToString();
                model.TrainExperience = context.Request["TrainExperience"].SafeToString();
                model.SymbolicAnimals = context.Request["SymbolicAnimals"].SafeToString();
                jsonModel = dll.Update(model);
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
        }
        #endregion

        #region 获取证书模板信息
        /// <summary>
        /// 获取培训信息
        /// </summary>
        /// <param name="context"></param>
        private void GetModolList(HttpContext context)
        {
            CertificateModolService modelDll = new CertificateModolService();
            string result = "";
            try
            {
                Hashtable ht = new Hashtable();
                //ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                //ht.Add("PageSize", context.Request["PageSize"].ToString());
                ht.Add("TableName", "CertificateModol");
                jsonModel = modelDll.GetPage(ht, false);
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
        }
        #endregion

        #region 证书列表

        private void GetCertificates(HttpContext context)
        {
            CommonHandler common = new CommonHandler();
            CertificateListService modelDll = new CertificateListService();
            string result = "";
            try
            {
                bool Ispage = false;
                if (context.Request["Ispage"].SafeToString().Length > 0)
                {
                    Ispage = Convert.ToBoolean(context.Request["Ispage"]);
                }
                Hashtable ht = new Hashtable();
                //ht.Add("TableName", "CertificateList");
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("NStatus", context.Request["PageSize"].SafeToString());
                ht.Add("IDCard", context.Request["IDCard"].SafeToString());
                ht.Add("ID", context.Request["ID"].SafeToString());
                ht.Add("CertificateID", context.Request["CertificateID"].SafeToString());
                ht.Add("Status", context.Request["Status"].SafeToString());
                ht.Add("Identifier", context.Request["Identifier"].SafeToString());
                jsonModel = common.AddCreateNameForData(modelDll.GetPage(ht, Ispage), 0, Ispage);
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