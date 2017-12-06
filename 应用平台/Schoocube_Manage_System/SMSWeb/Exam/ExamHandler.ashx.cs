using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using SMSBLL;
using SMSModel;
using System.Web.Script.Serialization;
using System.Collections;
using SMSUtility;
using System.Text;
using System.IO;
using LitJson;
using System.Text.RegularExpressions;
using System.Globalization;
using System.Xml;
using System.Web.SessionState;

namespace SMSHanderler.Exam
{
    /// <summary>
    /// ExamHandler 的摘要说明
    /// </summary>
    public class ExamHandler : IHttpHandler, IRequiresSessionState
    {
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        Exam_ObjQuestionService objqservice = new Exam_ObjQuestionService();
        Exam_SubQuestionService subqservice = new Exam_SubQuestionService();
        Exam_ExamTypeService examTypeservice = new Exam_ExamTypeService();
        Exam_ExamPaperService paperservice = new Exam_ExamPaperService();
        Exam_ExaminationService nationservice = new Exam_ExaminationService();
        Exam_ExamPaperObjQService perobjqservice = new Exam_ExamPaperObjQService();
        Exam_ExamPaperSubQService persubqservice = new Exam_ExamPaperSubQService();
        Exam_service examservice = new Exam_service();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request["action"].ToString();
            string result = string.Empty;
            try
            {
                if (action != null && action != "")
                {
                    switch (action)
                    {
                        case "GetExamQTList":
                            GetExamQTList(context);
                            break;
                        case "GetExamQPageList":
                            GetExamQPageList(context);
                            break;
                        case "GetExamSubQList":
                            GetExamSubQList(context);
                            break;
                        case "GetExamObjQList":
                            GetExamObjQList(context);
                            break;
                        case "AddExamQuestion":
                            AddExamQuestion(context);
                            break;
                        case "EditExamQuestion":
                            EditExamQuestion(context);
                            break;
                        case "ChangeQuestionStatus":
                            ChangeQuestionStatus(context);
                            break;
                        case "ChangPaperStatus":
                            ChangPaperStatus(context);
                            break;
                        case "GetChildNode":
                            GetChildNode(context);
                            break;
                        case "GetOption":
                            GetOption(context);
                            break;
                        case "FileManager":
                            FileManager(context);
                            break;
                        case "Upload_json":
                            Uploadjson(context);
                            break;
                        case "BindOption":
                            BindOption(context);
                            break;
                        case "ChangeNum":
                            ChangeNum(context);
                            break;
                        case "AddNum":
                            AddNum(context);
                            break;
                        case "ReduceNum":
                            ReduceNum(context);
                            break;
                        case "GetQuestionTypeList":
                            GetQuestionTypeList(context);
                            break;
                        case "DelQuestion":
                            DelQuestion(context);
                            break;
                        case "GetQuestion":
                            GetQuestion(context);
                            break;
                        case "getTestBasket":
                            gettestbasket(context);
                            break;
                        case "AddQToTesstBasket":
                            AddQToTesstBasket(context);
                            break;
                        case "DelTestBasket":
                            DelTestBasket(context);
                            break;
                        case "getTextBasketTypeQ":
                            getTextBasketTypeQ(context);
                            break;
                        case "getQTcount":
                            getQTcount(context);
                            break;
                        case "GetExamNPageList":
                            GetExamNPageList(context);
                            break;
                        case "annanduchakexun":
                            annanduchakexun(context);
                            break;
                        case "annanduchazhuxun":
                            annanduchazhuxun(context);
                            break;
                        case "checknumberke":
                            checknumberke(context);
                            break;
                        case "checknumberzhu":
                            checknumberzhu(context);
                            break;
                        case "checkrandomIDke":
                            checkrandomIDke(context);
                            break;
                        case "checkrandomIDzhu":
                            checkrandomIDzhu(context);
                            break;
                        case "checktypeid":
                            checktypeid(context);
                            break;
                        case "chaxuntileike":
                            chaxuntileike(context);
                            break;
                        case "chaxuntileizhu":
                            chaxuntileizhu(context);
                            break;
                        case "chaxunzhutimuke":
                            chaxunzhutimuke(context);
                            break;
                        case "chaxunzhutimuzhu":
                            chaxunzhutimuzhu(context);
                            break;
                        case "GetExamPaper":
                            GetExamPaper(context);
                            break;
                        case "addexamlist":
                            addexamlist(context);
                            break;
                        case "chaxuntileikeyulan":
                            chaxuntileikeyulan(context);
                            break;
                        case "chaxuntileizhuyulan":
                            chaxuntileizhuyulan(context);
                            break;
                        case "chaxunzhutimuyulanke":
                            chaxunzhutimuyulanke(context);
                            break;
                        case "chaxunzhutimuyulanzhu":
                            chaxunzhutimuyulanzhu(context);
                            break;
                        case "addExam_ExamAnswer":
                            addExam_ExamAnswer(context);
                            break;
                        case "inquirycategory":
                            inquirycategory(context);
                            break;
                        case "inquirytitlezhu":
                            inquirytitlezhu(context);
                            break;
                        case "inquirytitle":
                            inquirytitle(context);
                            break;
                        case "addExam_ExamPaperSubQ":
                            addExam_ExamPaperSubQ(context);
                            break;
                        case "addExam_ExamPaperObjQ":
                            addExam_ExamPaperObjQ(context);
                            break;
                        case "chaxunzhu":
                            chaxunzhu(context);
                            break;
                        case "chaxunke":
                            chaxunke(context);
                            break;
                        case "chaxunscore":
                            chaxunscore(context);
                            break;
                        case "chaxunTitle":
                            chaxunTitle(context);
                            break;
                        case "upExam_ExamPaperDal":
                            upExam_ExamPaperDal(context);
                            break;
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

        private void getQTcount(HttpContext context)
        {
            try
            {

                //获取所有试题类型
                DataTable showTypedt = new DataTable();
                string Type = context.Request["Type"] == "0" ? "" : context.Request["Type"];
                string DifficultyID = context.Request["DifficultyID"] == "0" ? "" : context.Request["DifficultyID"];
                string Major = context.Request["Major"] ?? "";
                string KlpointID = context.Request["KlpointID"] ?? "";
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "Exam_ExamType");
                ht.Add("Status", "1");
                jsonModel = examTypeservice.GetPage(ht, false, "");
                showTypedt = jsonModel.retData as DataTable;
                if (showTypedt != null)
                {
                    //添加试题类型试题数量列并统计
                    showTypedt.Columns.Add("Number");
                    showTypedt.Columns.Add("TypeQCount");

                    foreach (DataRow showitem in showTypedt.Rows)
                    {
                        //已选试题统计
                        showitem["Number"] = "0";
                        //统计试题类型可选试题数量
                        Type = showitem["ID"].SafeToString();
                        DataTable obdt = new DataTable();
                        showitem["TypeQCount"] = GetListCount(Major, KlpointID, DifficultyID, Type, int.Parse(showitem["QType"].SafeToString()), ref obdt);
                        Type = null;
                        //判断session是否存在试题篮并有数据
                        if (context.Session["Testbasket"] != null)
                        {
                            DataTable testbasketdb = context.Session["Testbasket"] as DataTable;
                            if (testbasketdb != null && testbasketdb.Rows.Count > 0)
                            {
                                foreach (DataRow item in testbasketdb.Rows)
                                {
                                    DataTable qitemdb = new DataTable();

                                    foreach (DataRow obitem in obdt.Rows)
                                    {
                                        //判断试题蓝中的当前试题和返回当前类型的试题id与类型是否一样
                                        if (obitem["ID"].SafeToString().Equals(item["ID"].SafeToString()) && obitem["TypeID"].SafeToString().Equals(item["TypeId"].SafeToString()))
                                        {
                                            showitem["Number"] = Convert.ToInt32(showitem["Number"].SafeToString()) + 1;
                                            break;
                                        }

                                    }

                                }
                            }
                        }
                    }
                    BLLCommon common = new BLLCommon();
                    List<Dictionary<string, object>> mlist = common.DataTableToList(showTypedt);
                    jsonModel = new JsonModel()
                    {
                        errMsg = "",
                        errNum = 0,
                        retData = mlist
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errMsg = "",
                        errNum = 1,
                        retData = ""
                    };
                }
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errMsg = ex.Message,
                    errNum = 1,
                    retData = ""
                };
                LogService.WriteErrorLog("绑定智能选题试题类型试题|||" + ex.Message);
            }
        }
        /// <summary>
        /// 获取绑定试题数据
        /// </summary>
        /// <param name="querystr"></param>
        protected int GetListCount(string Major, string KlpointID, string DifficultyID, string Type, int? QType, ref DataTable obdt)
        {
            obdt = CreateDataTable(new string[] { "ID", "TypeID", "MajorID", "SubjectID", "Difficulty" });
            //条件筛选

            int count = 0;
            if (QType == null)
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "Exam_SubQuestion");
                ht.Add("MajorId", Major);
                ht.Add("KlpointID", KlpointID);
                ht.Add("Type", Type);
                ht.Add("Status", "1");
                ht.Add("Difficult", DifficultyID);
                JsonModel submodel = subqservice.GetPage(ht, false, null);
                DataTable items = submodel.retData == "" ? new DataTable() : submodel.retData as DataTable;
                if (items != null && items.Rows.Count > 0)
                {

                    foreach (DataRow item in items.Rows)
                    {
                        count++;
                        DataRow newrow = obdt.NewRow();
                        newrow["ID"] = item["ID"];
                        newrow["TypeID"] = item["Type"];
                        obdt.Rows.Add(newrow);
                    }
                }
                Hashtable oht = new Hashtable();
                oht.Add("TableName", "Exam_ObjQuestion");
                oht.Add("MajorId", Major);
                oht.Add("KlpointID", KlpointID);
                oht.Add("Type", Type);
                oht.Add("Status", "1");
                oht.Add("Difficult", DifficultyID);
                JsonModel objmodel = objqservice.GetPage(oht, false, null);
                DataTable oitems = objmodel.retData == "" ? new DataTable() : objmodel.retData as DataTable;
                if (oitems != null && oitems.Rows.Count > 0)
                {

                    foreach (DataRow oitem in oitems.Rows)
                    {
                        count++;
                        DataRow newrow = obdt.NewRow();
                        newrow["ID"] = oitem["ID"];
                        newrow["TypeID"] = oitem["Type"];

                        obdt.Rows.Add(newrow);
                    }

                }
            }
            else
            {
                Hashtable ht = new Hashtable();
                JsonModel model = new JsonModel();
                if (QType == 1)
                {
                    ht.Add("TableName", "Exam_SubQuestion");
                    ht.Add("MajorId", Major);
                    ht.Add("KlpointID", KlpointID);
                    ht.Add("Type", Type);
                    ht.Add("Status", "1");
                    ht.Add("Difficult", DifficultyID);
                    model = subqservice.GetPage(ht, false, null);
                }
                else if (QType == 2)
                {
                    ht.Add("TableName", "Exam_ObjQuestion");
                    ht.Add("MajorId", Major);
                    ht.Add("KlpointID", KlpointID);
                    ht.Add("Type", Type);
                    ht.Add("Status", "1");
                    ht.Add("Difficult", DifficultyID);
                    model = objqservice.GetPage(ht, false, null);
                }

                if (model != null)
                {
                    DataTable items = model.retData == "" ? new DataTable() : model.retData as DataTable;
                    if (items != null && items.Rows.Count > 0)
                    {

                        foreach (DataRow item in items.Rows)
                        {
                            count++;
                            DataRow newrow = obdt.NewRow();
                            newrow["ID"] = item["ID"];
                            newrow["TypeID"] = item["Type"];
                            obdt.Rows.Add(newrow);
                        }
                    }
                }
            }
            return count;
        }
        private void getTextBasketTypeQ(HttpContext context)
        {
            try
            {

                DataTable showEQBasketbt = new DataTable();
                showEQBasketbt.Columns.Add("Type");
                showEQBasketbt.Columns.Add("Count");
                showEQBasketbt.Columns.Add("TypeID");
                string Major = context.Request["Major"];
                string Klpoint = context.Request["Klpoint"];
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "Exam_ExamType");
                jsonModel = examTypeservice.GetEntityListByField("Status", "1");
                List<Exam_ExamType> list = jsonModel.retData as List<Exam_ExamType>;
                if (list != null)
                {
                    //循环新增试题类型数据
                    foreach (Exam_ExamType spitem in list)
                    {
                        DataRow dr = showEQBasketbt.NewRow();
                        dr["TypeID"] = spitem.ID;

                        dr["Type"] = spitem.Title;
                        dr["Count"] = 0;
                        showEQBasketbt.Rows.Add(dr);
                    }
                }
                //判断session是否存在试题篮并有数据
                if (context.Session["Testbasket"] != null)
                {
                    DataTable testbasketdb = context.Session["Testbasket"] as DataTable;
                    if (testbasketdb != null && testbasketdb.Rows.Count > 0)
                    {

                        //循环累计数量
                        foreach (DataRow showitem in showEQBasketbt.Rows)
                        {
                            DataTable objdt = new DataTable();
                            DataTable subjdt = new DataTable();

                            foreach (DataRow item in testbasketdb.Rows)
                            {
                                if (item["Type"].SafeToString().Equals(showitem["TypeID"].SafeToString()))
                                {
                                    showitem["Count"] = Convert.ToInt32(showitem["Count"].SafeToString()) + 1;
                                }
                            }
                        }
                    }
                }
                //绑定
                BLLCommon common = new BLLCommon();
                List<Dictionary<string, object>> mlist = common.DataTableToList(showEQBasketbt);
                jsonModel = new JsonModel()
                {
                    errMsg = "",
                    errNum = 0,
                    retData = mlist
                };

            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errMsg = ex.Message,
                    errNum = 1,
                    retData = ""
                };
                LogService.WriteErrorLog("绑定试题蓝试题类型试题|||" + ex.Message);
            }
        }

        private void DelTestBasket(HttpContext context)
        {
            try
            {
                string typeid = context.Request["Type"];
                //清空试题蓝
                if (string.IsNullOrEmpty(typeid))
                {
                    if (context.Session["Testbasket"] != null)
                    {
                        context.Session.Remove("Testbasket");
                        //Bindtestbasket();
                        jsonModel = new JsonModel()
                        {
                            errNum = 0,
                            errMsg = "删除成功！",
                            retData = ""
                        };
                    }
                }
                //删除试题蓝类型试题
                else
                {
                    DataTable Testbasket = context.Session["Testbasket"] as DataTable;
                    DataTable newtestbasket = CreateDataTable(new string[] { "ID", "Type", "QType", "Score" });
                    string ID = context.Request["ID"];
                    //根据试题类型删除试题
                    if (string.IsNullOrEmpty(ID))
                    {
                        int id = Convert.ToInt32(typeid);
                        //判断session里是否存在该试题篮（存在修改数据）
                        if (context.Session["Testbasket"] != null)
                        {

                            foreach (DataRow item in Testbasket.Rows)
                            {
                                if (!item["Type"].SafeToString().Equals(id.SafeToString()))
                                {
                                    DataRow newdr = newtestbasket.NewRow();
                                    newdr.ItemArray = item.ItemArray;
                                    newtestbasket.Rows.Add(newdr);
                                }

                            }
                            context.Session["Testbasket"] = newtestbasket;
                            jsonModel = new JsonModel()
                            {
                                errNum = 0,
                                errMsg = "删除成功！",
                                retData = ""
                            };
                        }
                    }
                    //根据试题id删除试题
                    else
                    {
                        string QType = context.Request["QType"].SafeToString();
                        //判断session里是否存在该试题篮（不存在便新增，存在修改数据）
                        if (context.Session["Testbasket"] != null)
                        {
                            foreach (DataRow item in Testbasket.Rows)
                            {
                                if (!item["ID"].SafeToString().Equals(ID.ToString()) || !item["QType"].SafeToString().Equals(QType.ToString()))
                                {
                                    DataRow newdr = newtestbasket.NewRow();
                                    newdr.ItemArray = item.ItemArray;
                                    newtestbasket.Rows.Add(newdr);
                                }

                            }
                            context.Session["Testbasket"] = newtestbasket;
                            jsonModel = new JsonModel()
                            {
                                errNum = 0,
                                errMsg = "删除成功！",
                                retData = ""
                            };
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 1,
                    errMsg = "删除失败！" + ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog("ES_wp_ManualMakeExam_删除试题蓝|||" + ex.Message);
            }
        }
        string id = "";
        private void AddQToTesstBasket(HttpContext context)
        {
            string errMsg = "";
            int errNum = 1;
            try
            {
                string ID = context.Request["ID"].SafeToString();
                string QType = context.Request["QType"].SafeToString();
                string type = context.Request["Type"].SafeToString();
                string Score = context.Request["Score"].SafeToString();
                //判断session里是否存在该试题篮（不存在便新增，存在修改数据）
                if (context.Session["Testbasket"] != null)
                {

                    DataTable Testbasket = context.Session["Testbasket"] as DataTable;
                    bool ishave = false;
                    foreach (DataRow item in Testbasket.Rows)
                    {
                        if (item["ID"].SafeToString().Equals(ID.ToString()) && item["QType"].SafeToString().Equals(QType.ToString()))
                        {
                            ishave = true;
                        }

                    }
                    if (ishave)
                    {
                        errMsg = "alert('该试题已加入了试题篮，请重新选择！');";
                        return;

                    }
                    else
                    {
                        //修改
                        DataRow newdr = Testbasket.NewRow();
                        DataRow dr = Testbasket.NewRow();
                        dr["ID"] = ID;
                        id += ID;
                        id += ",";
                        dr["Type"] = type;
                        dr["QType"] = QType;
                        dr["Score"] = Score;
                        Testbasket.Rows.Add(dr);
                        context.Session["Testbasket"] = Testbasket;
                        errMsg = "添加成功！";
                        errNum = 0;

                    }
                }
                else
                {
                    //新增
                    DataTable Testbasket = new DataTable();
                    Testbasket = CreateDataTable(new string[] { "ID", "Type", "QType", "Score" });
                    DataRow dr = Testbasket.NewRow();
                    dr["ID"] = ID;
                    dr["Type"] = type;
                    dr["QType"] = QType;
                    dr["Score"] = Score;
                    Testbasket.Rows.Add(dr);
                    context.Session.Add("Testbasket", Testbasket);
                    errMsg = "添加成功！";
                    errNum = 0;
                }
                jsonModel = new JsonModel()
                {
                    errNum = errNum,
                    errMsg = errMsg,
                    retData = ""
                };
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
        private DataTable CreateDataTable(string[] str)
        {
            DataTable dt = new DataTable();
            foreach (string item in str)
            {
                dt.Columns.Add(item);
            }
            return dt;
        }
        /// <summary>
        /// 获取试题篮
        /// </summary>
        private void gettestbasket(HttpContext context)
        {
            try
            {
                //判断session是否存在试题篮并有数据
                if (context.Session["Testbasket"] != null)
                {
                    DataTable testbasketdb = context.Session["Testbasket"] as DataTable;
                    if (testbasketdb != null && testbasketdb.Rows.Count > 0)
                    {

                        //绑定
                        BLLCommon common = new BLLCommon();
                        List<Dictionary<string, object>> mlist = common.DataTableToList(testbasketdb);
                        jsonModel = new JsonModel()
                        {
                            errMsg = "",
                            errNum = 0,
                            retData = mlist
                        };
                    }
                }

            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog("绑定试题蓝试题数据|||" + ex.Message);
            }
        }
        private void GetQuestion(HttpContext context)
        {
            try
            {
                Exam_ObjQuestionService objqservice = new Exam_ObjQuestionService();
                Exam_SubQuestionService subqservice = new Exam_SubQuestionService();
                string ID = context.Request["ID"].SafeToString();
                string Qtype = context.Request["Qtype"].SafeToString();
                JsonModel model = new JsonModel();

                DataTable newdt = new DataTable();
                string[] columns = new string[] { 
                        "ID", "Title", "Type", "Typeshow", "Template", "QType", 
                        "Analysis", "IsShowAnalysis", "IsShowAnalysisShow",
                        "Difficulty","DifficultyShow" ,"Status","StatusShow","Author","CreateTime","Klpoint","Book","Answer","Score", 
                    "OptionA", "OptionB", "OptionC", "OptionD", "OptionE", "OptionF","Question"};
                if (Qtype.Equals("1"))
                {
                    model = subqservice.GetEntityById(int.Parse(ID));

                }
                else
                {
                    model = objqservice.GetEntityById(int.Parse(ID));
                    //context.Response.Write(model);
                }
                foreach (string column in columns)
                {
                    newdt.Columns.Add(column);
                }
                Exam_ExamTypeService typeserivce = new Exam_ExamTypeService();
                if (model.retData != null)
                {
                    DataRow dr = newdt.NewRow();
                    if (Qtype.Equals("1"))
                    {
                        Exam_SubQuestion subquestion = model.retData as Exam_SubQuestion;
                        dr["Analysis"] = subquestion.Analysis;
                        dr["Answer"] = subquestion.Answer;
                        dr["Author"] = subquestion.Author;
                        dr["Book"] = subquestion.Book;
                        dr["Question"] = subquestion.Content;
                        dr["CreateTime"] = subquestion.CreateTime;
                        dr["Difficulty"] = subquestion.Difficulty;
                        dr["ID"] = subquestion.ID;
                        dr["IsShowAnalysis"] = subquestion.IsShowAnalysis;
                        dr["Klpoint"] = subquestion.Klpoint;
                        dr["Book"] = subquestion.Major;
                        dr["Score"] = subquestion.Score;
                        dr["Status"] = subquestion.Status;
                        dr["Title"] = subquestion.Title;
                        dr["Type"] = subquestion.Type;
                    }
                    if (Qtype.Equals("2"))
                    {
                        Exam_ObjQuestion objquestion = model.retData as Exam_ObjQuestion;
                        dr["Analysis"] = objquestion.Analysis;
                        dr["Answer"] = objquestion.Answer;
                        dr["Author"] = objquestion.Author;
                        dr["Book"] = objquestion.Book;
                        dr["Question"] = objquestion.Content;
                        dr["CreateTime"] = objquestion.CreateTime;
                        dr["Difficulty"] = objquestion.Difficulty;
                        dr["ID"] = objquestion.ID;
                        dr["IsShowAnalysis"] = objquestion.IsShowAnalysis;
                        dr["Klpoint"] = objquestion.Klpoint;
                        dr["Book"] = objquestion.Major;
                        dr["Score"] = objquestion.Score;
                        dr["Status"] = objquestion.Status;
                        dr["Title"] = objquestion.Title;
                        dr["Type"] = objquestion.Type;
                        dr["OptionA"] = objquestion.OptionA;
                        dr["OptionB"] = objquestion.OptionB;
                        dr["OptionC"] = objquestion.OptionC;
                        dr["OptionD"] = objquestion.OptionD;
                        dr["OptionE"] = objquestion.OptionE;
                        dr["OptionF"] = objquestion.OptionF;
                    }
                    int typeid = int.Parse(dr["Type"].SafeToString("0"));
                    JsonModel typemodel = typeserivce.GetEntityById(typeid);
                    dr["QType"] = "1";
                    if (typemodel.retData != null)
                    {
                        Exam_ExamType typedt = typemodel.retData as Exam_ExamType;
                        dr["Typeshow"] = typedt.Title;
                        dr["QType"] = typedt.QType;
                        dr["Template"] = typedt.Template;
                    }
                    dr["IsShowAnalysisShow"] = dr["IsShowAnalysis"].SafeToString().Equals("1") ? "显示" : "不显示";
                    dr["StatusShow"] = dr["Status"].SafeToString().Equals("1") ? "启用" : "禁用";
                    dr["DifficultyShow"] = dr["Difficulty"].SafeToString().Equals("1") ? "简单" : dr["Difficulty"].SafeToString().Equals("2") ? "中等" : "困难";

                    newdt.Rows.Add(dr);

                }

                BLLCommon common = new BLLCommon();
                List<Dictionary<string, object>> list = common.DataTableToList(newdt);
                jsonModel = new JsonModel()
                {
                    errNum = model.errNum,
                    retData = list,
                    errMsg = model.errMsg
                };

            }
            catch (Exception ex)
            {

                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog("GetQuestion_获取试题|||" + ex.Message);
            }
        }

        private void DelQuestion(HttpContext context)
        {
            try
            {
                string DelID = context.Request["DelID"].SafeToString();
                string Qtype = context.Request["Qtype"].SafeToString();
                if (Qtype.Equals("1"))
                {
                    LogService.WriteLog("删除ID为" + DelID + "主观试题");
                    jsonModel = subqservice.GetEntityById(int.Parse(DelID));
                }
                else
                {
                    LogService.WriteLog("删除ID为" + DelID + "客观试题");
                    jsonModel = objqservice.GetEntityById(int.Parse(DelID));
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
                LogService.WriteErrorLog("DelQuestion_删除试题|||" + ex.Message);
            }
        }

        private void GetExamQPageList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("MajorId", context.Request["MajorID"] ?? "");
                ht.Add("Book", context.Request["Book"] ?? "");
                ht.Add("KlpointID", context.Request["KlpointID"] ?? "");
                ht.Add("Type", context.Request["Type"] ?? "");
                ht.Add("Title", context.Request["Title"] ?? "");
                ht.Add("Status", context.Request["Status"] ?? "1");
                ht.Add("IsRelease", context.Request["IsRelease"] ?? "1");
                bool ispage = true;
                if (!string.IsNullOrEmpty(HttpContext.Current.Request["IsPage"]))
                {
                    ispage = false;
                }
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());
                jsonModel = paperservice.GetPage(ht, ispage);
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
        private void GetExamNPageList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("Status", context.Request["Status"] ?? "");
                ht.Add("Title", context.Request["Title"] ?? "");
                ht.Add("Type", context.Request["Type"] ?? "");
                ht.Add("ClassID", context.Request["ClassID"] ?? "");
                ht.Add("Book", context.Request["Book"] ?? "");
                ht.Add("noCreateUID", context.Request["noCreateUID"] ?? "");
                ht.Add("CreateUID", context.Request["CreateUID"] ?? "");
                bool ispage = true;
                if (!string.IsNullOrEmpty(HttpContext.Current.Request["IsPage"]))
                {
                    ispage = false;
                }
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());
                jsonModel = nationservice.GetPage(ht, ispage);
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
        private void annanduchakexun(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("Difficulty", context.Request["Difficulty"] ?? "");
                ht.Add("Klpoint", context.Request["Klpoint"] ?? "");
                jsonModel = examservice.GetdataEQ(ht);
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
        private void annanduchazhuxun(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("Difficulty", context.Request["Difficulty"] ?? "");
                ht.Add("Klpoint", context.Request["Klpoint"] ?? "");
                jsonModel = examservice.GetdataES(ht);
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
        private void checknumberke(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("Title", context.Request["Title"] ?? "");
                jsonModel = examservice.GetdatarandomEQ(ht);
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
        private void checknumberzhu(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("Title", context.Request["Title"] ?? "");
                jsonModel = examservice.GetdatarandomES(ht);
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
        private void checkrandomIDke(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ID", context.Request["ID"] ?? "");
                jsonModel = examservice.GetdatarandomoneEQ(ht);
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
        private void checkrandomIDzhu(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ID", context.Request["ID"] ?? "");
                jsonModel = examservice.GetdatarandomoneES(ht);
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
        private void checktypeid(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("Title", context.Request["Title"] ?? "");
                jsonModel = examservice.GetdatarandomET(ht);
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
        private void GetExamPaper(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ID", context.Request["ID"] ?? "");
                jsonModel = examservice.GetdataEP(ht);
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
        private void addexamlist(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("Title", context.Request["Title"] ?? "");
                ht.Add("ExamTime", context.Request["ExamTime"] ?? "");
                ht.Add("Difficulty", context.Request["Difficulty"] ?? "");
                ht.Add("Status", context.Request["Status"] ?? "");
                ht.Add("Type", context.Request["Type"] ?? "");
                ht.Add("FullScore", context.Request["FullScore"] ?? "");
                ht.Add("Klpoint", context.Request["Klpoint"] ?? "");
                ht.Add("IsRelease", context.Request["IsRelease"] ?? "");
                ht.Add("CreateTime", context.Request["CreateTime"] ?? "");
                ht.Add("Author", context.Request["Author"] ?? "");
                ht.Add("Book", context.Request["Book"] ?? "");
                jsonModel = examservice.addexams(ht);
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
        private void chaxuntileike(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ID", context.Request["ID"] ?? "");
                jsonModel = examservice.GetdataEQ(ht);
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
        private void chaxuntileizhu(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ID", context.Request["ID"] ?? "");
                jsonModel = examservice.GetdataES(ht);
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
        private void chaxunke(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ID", context.Request["ID"] ?? "");
                jsonModel = examservice.GetdataEQADD(ht);
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
        private void chaxunzhu(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ID", context.Request["ID"] ?? "");
                jsonModel = examservice.GetdataESADD(ht);
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
        private void chaxunscore(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("hCreateUID", context.Request["hCreateUID"] ?? "");
                jsonModel = examservice.GetdataEM(ht);
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
        private void chaxunTitle(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ExampaperID", context.Request["ExampaperID"] ?? "");
                jsonModel = examservice.chaExamAnswer(ht);
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
        private void upExam_ExamPaperDal(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ID", context.Request["ID"] ?? "");
                ht.Add("WorkBeginTime", context.Request["WorkBeginTime"] ?? "");
                ht.Add("WorkEndTime", context.Request["WorkEndTime"] ?? "");
                ht.Add("ClassID", context.Request["ClassID"] ?? "");
                ht.Add("IsRelease", context.Request["IsRelease"] ?? "");
                jsonModel = examservice.upExam_ExamPaperDal(ht);
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

        private void chaxuntileikeyulan(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ExampaperID", context.Request["ExampaperID"] ?? "");
                jsonModel = examservice.GetdataEPQ(ht);
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
        private void chaxuntileizhuyulan(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ExampaperID", context.Request["ExampaperID"] ?? "");
                jsonModel = examservice.GetdataEPS(ht);
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
        private void chaxunzhutimuyulanke(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ID", context.Request["ID"] ?? "");
                ht.Add("Title", context.Request["Title"] ?? "");
                jsonModel = examservice.GetListtimuEPQ(ht);
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
        private void chaxunzhutimuyulanzhu(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ID", context.Request["ID"] ?? "");
                ht.Add("Title", context.Request["Title"] ?? "");
                jsonModel = examservice.GetListtimuEPS(ht);
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
        private void chaxunzhutimuke(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ID", context.Request["ID"] ?? "");
                ht.Add("Title", context.Request["Title"] ?? "");
                jsonModel = examservice.GetListtimuEQ(ht);
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
        private void chaxunzhutimuzhu(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ID", context.Request["ID"] ?? "");
                ht.Add("Title", context.Request["Title"] ?? "");
                jsonModel = examservice.GetListtimuES(ht);
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
        private void inquirycategory(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("Title", context.Request["Title"] ?? "");
                jsonModel = examservice.GetdatarandomET(ht);
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
        private void inquirytitle(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ExampaperID", context.Request["ExampaperID"] ?? "");
                ht.Add("ExamID", context.Request["ExamID"] ?? "");
                jsonModel = examservice.GetdataEAQ(ht);
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
        private void inquirytitlezhu(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ExampaperID", context.Request["ExampaperID"] ?? "");
                ht.Add("ExamID", context.Request["ExamID"] ?? "");
                jsonModel = examservice.GetdataEAS(ht);
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
        private void addExam_ExamAnswer(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ExamID", context.Request["ExamID"] ?? "");
                ht.Add("QuestionID", context.Request["QuestionID"] ?? "");
                ht.Add("ExampaperID", context.Request["ExampaperID"] ?? "");
                ht.Add("Type", context.Request["Type"] ?? "");
                ht.Add("Answer", context.Request["Answer"] ?? "");
                ht.Add("Score", context.Request["Score"] ?? "");
                jsonModel = examservice.addExamAnswer(ht);
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
        private void addExam_ExamPaperSubQ(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ExampaperID", context.Request["ExampaperID"] ?? "");
                ht.Add("Type", context.Request["Type"] ?? "");
                ht.Add("Content", context.Request["Content"] ?? "");
                ht.Add("Answer", context.Request["Answer"] ?? "");
                ht.Add("OrderID", context.Request["OrderID"] ?? "");
                ht.Add("Analysis", context.Request["Analysis"] ?? "");
                ht.Add("Difficulty", context.Request["Difficulty"] ?? "");
                ht.Add("IsShowAnalysis", context.Request["IsShowAnalysis"] ?? "");
                ht.Add("Score", context.Request["Score"] ?? "");
                jsonModel = examservice.addexamsEPS(ht);
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
        private void addExam_ExamPaperObjQ(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ExampaperID", context.Request["ExampaperID"] ?? "");
                ht.Add("Type", context.Request["Type"] ?? "");
                ht.Add("Content", context.Request["Content"] ?? "");
                ht.Add("OptionA", context.Request["OptionA"] ?? "");
                ht.Add("OptionB", context.Request["OptionB"] ?? "");
                ht.Add("OptionC", context.Request["OptionC"] ?? "");
                ht.Add("OptionD", context.Request["OptionD"] ?? "");
                ht.Add("OptionE", context.Request["OptionE"] ?? "");
                ht.Add("OptionF", context.Request["OptionF"] ?? "");
                ht.Add("Difficulty", context.Request["Difficulty"] ?? "");
                ht.Add("Answer", context.Request["Answer"] ?? "");
                ht.Add("Score", context.Request["Score"] ?? "");
                ht.Add("IsShowAnalysis", context.Request["IsShowAnalysis"] ?? "");
                ht.Add("Analysis", context.Request["Analysis"] ?? "");
                ht.Add("OrderID", context.Request["OrderID"] ?? "");
                jsonModel = examservice.addexamsEPQ(ht);
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
        public DataTable getQList(DataTable examdb, HttpContext context)
        {

            //将datatable转成xml缓存

            //string filePath = XmlHelper.CreateFolder();
            //XmlDocument xDoc = new XmlDocument();
            //XmlDeclaration xmlDec = xDoc.CreateXmlDeclaration("1.0", "utf-8", null);
            //xDoc.AppendChild(xmlDec);
            //XmlElement xmlRoot = xDoc.CreateElement("ExamQ");
            //xDoc.AppendChild(xmlRoot);
            //foreach (DataRow item in examdb.Rows)
            //{
            //    XmlElement xmlQItem = xDoc.CreateElement("QItem");
            //    foreach (DataColumn itemc in examdb.Columns)
            //    {
            //        XmlAttribute xmlAttr = xDoc.CreateAttribute(itemc.ColumnName);
            //        xmlAttr.Value = item[itemc.ColumnName] == null ? "" : item[itemc.ColumnName].SafeToString();
            //        xmlQItem.Attributes.Append(xmlAttr);
            //    }
            //    xmlRoot.AppendChild(xmlQItem);
            //}
            //xDoc.Save(filePath);
            return examdb;
        }
        /// <summary>
        /// 智能选题减试题数量
        /// </summary>
        private void ReduceNum(HttpContext context)
        {
            try
            {
                string type = context.Request["type"].SafeToString();
                string id = context.Request["id"].SafeToString();
                string diff = context.Request["diff"].SafeToString();
                int chagenum = -1;

                //判断session是否存在试题篮并有数据
                if (context.Session["Testbasket"] != null)
                {
                    DataTable Testbasket = context.Session["Testbasket"] as DataTable;
                    Testbasket = getNewTestbasket(type, id, diff, ref chagenum, context);
                    context.Session["Testbasket"] = Testbasket;
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "",
                        retData = 0
                    };
                }
                else
                {
                    ////新增
                    //DataTable Testbasket = new DataTable();
                    //Testbasket = getNewTestbasket(type, id, diff, ref chagenum);
                    //Session.Add("Testbasket", Testbasket);
                    jsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "",
                        retData = 0
                    };
                }


            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 1,
                    errMsg = "",
                    retData = 0
                };
                LogService.WriteErrorLog("ES_wp_Intelligence_修改试题类型试题数量||||" + ex.Message);
            }
        }
        /// <summary>
        /// 智能选题加试题数量
        /// </summary>
        private void AddNum(HttpContext context)
        {
            try
            {
                string type = context.Request["type"].SafeToString();
                string id = context.Request["id"].SafeToString();
                string diff = context.Request["diff"].SafeToString();

                int chagenum = 1;
                //判断session是否存在试题篮并有数据
                if (context.Session["Testbasket"] != null)
                {
                    DataTable Testbasket = context.Session["Testbasket"] as DataTable;
                    Testbasket = getNewTestbasket(type, id, diff, ref chagenum, context);
                    context.Session["Testbasket"] = Testbasket;

                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "",
                        retData = chagenum
                    };
                }
                else
                {
                    //新增
                    DataTable Testbasket = new DataTable();
                    Testbasket = getNewTestbasket(type, id, diff, ref chagenum, context);
                    context.Session.Add("Testbasket", Testbasket);
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "",
                        retData = chagenum
                    };

                }


            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "",
                    retData = 0
                };
                LogService.WriteErrorLog("ES_wp_Intelligence_修改试题类型试题数量|||" + ex.Message);
            }
        }
        /// <summary>
        /// 智能选题改变试题数量
        /// </summary>
        private void ChangeNum(HttpContext context)
        {
            try
            {
                string oldnum = context.Request["oldnum"].SafeToString();
                string num = context.Request["num"].SafeToString();
                string type = context.Request["type"].SafeToString();
                string id = context.Request["id"].SafeToString();
                string diff = context.Request["diff"].SafeToString();
                int chagenum = Convert.ToInt32(num) - Convert.ToInt32(oldnum);

                //判断session是否存在试题篮并有数据
                if (context.Session["Testbasket"] != null)
                {
                    DataTable Testbasket = context.Session["Testbasket"] as DataTable;
                    Testbasket = getNewTestbasket(type, id, diff, ref chagenum, context);
                    context.Session["Testbasket"] = Testbasket;
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "",
                        retData = chagenum
                    };
                }
                else
                {
                    //新增
                    DataTable Testbasket = new DataTable();
                    Testbasket = getNewTestbasket(type, id, diff, ref chagenum, context);
                    context.Session.Add("Testbasket", Testbasket);

                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "",
                        retData = chagenum
                    };
                }


            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 1,
                    errMsg = "",
                    retData = "0"
                };
                LogService.WriteErrorLog("ES_wp_Intelligence_修改试题类型试题数量||||" + ex.Message);
            }
        }
        /// <summary>
        /// 获取新的试题蓝
        /// </summary>
        /// <param name="type"></param>
        /// <param name="id"></param>
        /// <param name="diff"></param>
        /// <param name="chagenum"></param>
        /// <returns></returns>
        private DataTable getNewTestbasket(string type, string id, string diff, ref int chagenum, HttpContext context)
        {
            DataTable Testbasket = new DataTable();
            string[] columns = new string[] { "ID", "Type", "QType" };
            foreach (string item in columns)
            {
                Testbasket.Columns.Add(item);
            }

            if (context.Session["Testbasket"] != null) { Testbasket = context.Session["Testbasket"] as DataTable; };
            // SPQuery query = new SPQuery();
            string Major = context.Session["Major"].SafeToString();
            string Subject = context.Session["Subject"].SafeToString();
            string Chapter = context.Session["Chapter"].SafeToString();
            string Part = context.Session["Part"].SafeToString();
            string Klpoint = context.Session["Klpoint"].SafeToString();
            #region 查询条件

            // query.Query = CAML.Where(CAML.And(CAML.Eq(CAML.FieldRef("Status"), CAML.Value("1")), 

            string query = "Status=1 And " + AppendQuery(Major, Subject, id, Chapter, Part, Klpoint, diff);
            DataTable questiondb = new DataTable();
            string[] qcolumns = new string[] { "ID", "QType", "TypeID" };
            foreach (string qitem in qcolumns)
            {
                questiondb.Columns.Add(qitem);
            }
            if (type.Equals("1"))
            {
                // questiondb = ExamQManager.GetExamSubjQList(true, query);
                DataTable items = new DataTable();// = subqservice.GetData(query,null).retData as DataTable;
                if (items != null && items.Rows.Count > 0)
                {

                    foreach (DataRow item in items.Rows)
                    {
                        DataRow newrow = questiondb.NewRow();
                        newrow["TypeID"] = item["Type"];
                        newrow["QType"] = type;
                        newrow["ID"] = item["ID"];

                        questiondb.Rows.Add(newrow);
                    }
                }

            }
            if (type.Equals("2"))
            {
                //questiondb = ExamQManager.GetExamObjQList(true, query);
                DataTable items = new DataTable();// = objqservice.GetData(query, null).retData as DataTable;
                if (items != null && items.Rows.Count > 0)
                {

                    foreach (DataRow item in items.Rows)
                    {
                        DataRow newrow = questiondb.NewRow();
                        newrow["TypeID"] = item["Type"];
                        newrow["QType"] = type;
                        newrow["ID"] = item["ID"];
                        questiondb.Rows.Add(newrow);
                    }
                }

            }

            #endregion
            if (questiondb.Rows.Count > 0)
            {
                Random rd = new Random();
                if (chagenum > 0)
                {
                    if (chagenum > questiondb.Rows.Count)
                    {
                        chagenum = questiondb.Rows.Count;
                    }
                    for (int i = chagenum; i > 0; i--)
                    {
                        DataRow qitem = questiondb.NewRow();
                        qitem = null;// GetQItem(Testbasket, questiondb, rd, type, chagenum);
                        if (qitem != null)
                        {
                            //修改(新增)
                            DataRow dr = Testbasket.NewRow();
                            dr["ID"] = qitem["ID"];
                            dr["Type"] = qitem["TypeID"];
                            dr["QType"] = type;
                            Testbasket.Rows.Add(dr);
                        }
                        else { chagenum--; continue; }
                    }
                }
                else
                {
                    //修改(减)
                    for (int i = 0; i < -chagenum; i++)
                    {
                        for (int j = 0; j < Testbasket.Rows.Count; j++)
                        {
                            DataRow item = Testbasket.Rows[j];
                            if (item["Type"].SafeToString().Equals(id) && item["QType"].SafeToString().Equals(type))
                            {
                                Testbasket.Rows.RemoveAt(j);
                                break;
                            }
                        }

                    }
                }
            }
            else { chagenum--; }

            return Testbasket;
        }
        private string AppendQuery(string Subject, string Major, string Type, string Chapter, string Part, string Klpoint, string DifficultyID)
        {
            string querystr = "ID !=-1";
            if (Subject != null && Subject != "-1" && !string.IsNullOrEmpty(Subject))//学科
            {
                querystr += " and Major =" + Subject + Major;
            }
            else if (Major != null && !string.IsNullOrEmpty(Major) && Major != "-1")//专业
            {
                DataTable subjectdt = new DataTable();
                string[] scolumns = new string[] { "ID", "Title", "Pid" };
                foreach (string sitem in scolumns)
                {
                    subjectdt.Columns.Add(sitem);
                }
                //subjectdt = ExamQManager.GetSubject(int.Parse(Major));
                int i = 0;
                foreach (DataRow subjitem in subjectdt.Rows)
                {
                    i++;
                    querystr = querystr + (i == 1 ? " and Major =" + subjitem["ID"].SafeToString() + Major : " Or Major =" + subjitem["ID"].SafeToString() + Major);
                }
                querystr = querystr + (" Or Major=" + Major);
            }
            if (Klpoint != null && Klpoint != "-1" && !string.IsNullOrEmpty(Klpoint))//知识点
            {
                querystr = querystr + (" And Klpoint=" + Klpoint);
            }
            else if (Part != null && Part != "-1" && !string.IsNullOrEmpty(Part))//节
            {
                querystr = querystr + (" And Klpoint=" + Part);
            }
            else if (Chapter != null && Chapter != "-1" && !string.IsNullOrEmpty(Chapter))//章
            {
                querystr = querystr + (" And Klpoint=" + Chapter);
            }

            if (Type != null && Type != "0" && !string.IsNullOrEmpty(Type))//类型
            {
                querystr = querystr + (" And Type=" + Type);
            }
            if (DifficultyID != null && DifficultyID != "0" && !string.IsNullOrEmpty(DifficultyID))//难度
            {
                querystr = querystr + (" And Difficulty=" + DifficultyID);
            }
            return querystr;
        }
        private void BindOption(HttpContext context)
        {
            try
            {

                if (context.Request["QID"] != null && !string.IsNullOrEmpty(context.Request["QID"].SafeToString()) && !string.IsNullOrEmpty(context.Request["oldtype"].SafeToString()))
                {
                    int QID = Convert.ToInt32(context.Request["QID"].SafeToString());
                    int tid = Convert.ToInt32(context.Request["oldtype"].SafeToString());
                    Exam_ExamType item = examTypeservice.GetEntityById(tid).retData as Exam_ExamType;

                    if (item != null)
                    {
                        StringBuilder sb = new StringBuilder();
                        if (item.QType != null && item.QType.ToString().Equals("2"))
                        {
                            Exam_ObjQuestion qQt = objqservice.GetEntityById(QID).retData as Exam_ObjQuestion;
                            if (qQt != null)
                            {
                                context.Response.Write("1|" + qQt.Answer + "|");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog("ES_wp_EditExamQuestion_试题绑定选项答案|||" + ex.Message);

            }

        }

        /// <summary>
        /// 上传文件
        /// </summary>
        private void Uploadjson(HttpContext context)
        {
            try
            {
                string result = "";
                HttpPostedFile file = HttpContext.Current.Request.Files[0];
                string Fpath = ConfigHelper.GetConfigString("FileManageName") + "/Attatchment/Exam_Image";
                FileHelper.CreateDirectory(context.Server.MapPath(Fpath));

                string ext = System.IO.Path.GetExtension(file.FileName);
                string fileName = DateTime.Now.Ticks + ext;
                string p = Fpath + "/" + fileName;
                string path = context.Server.MapPath(p);
                file.SaveAs(path);


                //String fileUrl = saveUrl + newFileName;
                //Hashtable hash = new Hashtable();
                //hash["error"] = 0;
                //hash["url"] = fileUrl.Replace("\\", "/");
                //context.Response.AddHeader("Content-Type", "text/html; charset=UTF-8");
                //context.Response.Write(JsonMapper.ToJson(hash));
                //context.Response.End();

                result = "{\"error\":0,\"url\":\"" + p + "\"}";
                context.Response.Write(result);
                context.Response.End();
            }
            catch (Exception ex)
            {

            }
            //try
            //{
            //    String aspxUrl = context.Request.Path.Substring(0, context.Request.Path.LastIndexOf("/") + 1);

            //    //文件保存目录路径
            //    String savePath = "/attached/";

            //    //文件保存目录URL
            //    String saveUrl = aspxUrl + "/attached/";

            //    //定义允许上传的文件扩展名
            //    Hashtable extTable = new Hashtable();
            //    extTable.Add("image", "gif,jpg,jpeg,png,bmp");
            //    extTable.Add("flash", "swf,flv");
            //    extTable.Add("media", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb");
            //    extTable.Add("file", "doc,docx,xls,xlsx,ppt,htm,html,txt,zip,rar,gz,bz2");

            //    //最大文件大小
            //    int maxSize = 1000000;
            //    //this.context = context;

            //    HttpPostedFile imgFile = context.Request.Files["imgFile"];
            //    if (imgFile == null)
            //    {
            //        showError("请选择文件。", context);
            //    }

            //    String dirPath = context.Server.MapPath(savePath);
            //    if (!Directory.Exists(dirPath))
            //    {
            //        Directory.CreateDirectory(dirPath);
            //        //showError("上传目录不存在。");
            //    }
            //    String dirName = context.Request.QueryString["dir"];
            //    if (String.IsNullOrEmpty(dirName))
            //    {
            //        dirName = "image";
            //    }
            //    if (!extTable.ContainsKey(dirName))
            //    {
            //        showError("目录名不正确。", context);
            //    }

            //    String fileName = imgFile.FileName;
            //    String fileExt = Path.GetExtension(fileName).ToLower();

            //    if (imgFile.InputStream == null || imgFile.InputStream.Length > maxSize)
            //    {
            //        showError("上传文件大小超过限制。", context);
            //    }

            //    if (String.IsNullOrEmpty(fileExt) || Array.IndexOf(((String)extTable[dirName]).Split(','), fileExt.Substring(1).ToLower()) == -1)
            //    {
            //        showError("上传文件扩展名是不允许的扩展名。\n只允许" + ((String)extTable[dirName]) + "格式。", context);
            //    }

            //    //创建文件夹
            //    dirPath += dirName + "/";
            //    saveUrl += dirName + "/";
            //    if (!Directory.Exists(dirPath))
            //    {
            //        Directory.CreateDirectory(dirPath);
            //    }
            //    String ymd = DateTime.Now.ToString("yyyyMMdd", DateTimeFormatInfo.InvariantInfo);
            //    dirPath += ymd + "/";
            //    saveUrl += ymd + "/";
            //    if (!Directory.Exists(dirPath))
            //    {
            //        Directory.CreateDirectory(dirPath);
            //    }

            //    String newFileName = DateTime.Now.ToString("yyyyMMddHHmmss_ffff", DateTimeFormatInfo.InvariantInfo) + fileExt;

            //    String filePath = dirPath + newFileName;
            //    //string filePath = string.Empty;
            //    bool result = false;
            //    string msg = string.Empty;
            //    //PictureHandle.UploadImage(imgFile, null, out filePath, out result, out msg);
            //    imgFile.SaveAs(filePath);
            //    if (result)
            //    {
            //        String fileUrl = saveUrl + newFileName;
            //        Hashtable hash = new Hashtable();
            //        hash["error"] = 0;
            //        hash["url"] = fileUrl.Replace("\\", "/");
            //        context.Response.AddHeader("Content-Type", "text/html; charset=UTF-8");
            //        context.Response.Write(JsonMapper.ToJson(hash));
            //        context.Response.End();
            //    }

            //}
            //catch (Exception ex)
            //{

            //    LogService.WriteErrorLog("保存试题时图片文件保存|||" + ex.Message);
            //}
        }

        private void showError(string message, HttpContext context)
        {
            Hashtable hash = new Hashtable();
            hash["error"] = 1;
            hash["message"] = message;
            context.Response.AddHeader("Content-Type", "text/html; charset=UTF-8");
            context.Response.Write(JsonMapper.ToJson(hash));
            context.Response.End();
        }
        /// <summary>
        /// 文件格式判断
        /// </summary>
        private void FileManager(HttpContext context)
        {
            try
            {

                String aspxUrl = context.Request.Path.Substring(0, context.Request.Path.LastIndexOf("/") + 1);

                //根目录路径，相对路径
                String rootPath = "/attached/";
                //根目录URL，可以指定绝对路径，比如 http://www.yoursite.com/attached/
                String rootUrl = aspxUrl + "/attached/";
                //图片扩展名
                // String fileTypes = "gif,jpg,jpeg,png,bmp";

                String currentPath = "";
                String currentUrl = "";
                String currentDirPath = "";
                String moveupDirPath = "";

                String dirPath = context.Server.MapPath(rootPath);
                String dirName = context.Request.QueryString["dir"];
                if (!String.IsNullOrEmpty(dirName))
                {
                    if (Array.IndexOf("image,flash,media,file".Split(','), dirName) == -1)
                    {
                        context.Response.Write("Invalid Directory name.");
                        context.Response.End();
                    }
                    dirPath += dirName + "/";
                    rootUrl += dirName + "/";
                    if (!Directory.Exists(dirPath))
                    {
                        Directory.CreateDirectory(dirPath);
                    }
                }

                //根据path参数，设置各路径和URL
                String path = context.Request.QueryString["path"];
                path = String.IsNullOrEmpty(path) ? "" : path;
                if (path == "")
                {
                    currentPath = dirPath;
                    currentUrl = rootUrl;
                    currentDirPath = "";
                    moveupDirPath = "";
                }
                else
                {
                    currentPath = dirPath + path;
                    currentUrl = rootUrl + path;
                    currentDirPath = path;
                    moveupDirPath = Regex.Replace(currentDirPath, @"(.*?)[^\/]+\/$", "$1");
                }

                //排序形式，name or size or type
                String order = context.Request.QueryString["order"];
                order = String.IsNullOrEmpty(order) ? "" : order.ToLower();

                //不允许使用..移动到上一级目录
                if (Regex.IsMatch(path, @"\.\."))
                {
                    context.Response.Write("Access is not allowed.");
                    context.Response.End();
                }
                //最后一个字符不是/
                if (path != "" && !path.EndsWith("/"))
                {
                    context.Response.Write("Parameter is not valid.");
                    context.Response.End();
                }
                //目录不存在或不是目录
                if (!Directory.Exists(currentPath))
                {
                    context.Response.Write("Directory does not exist.");
                    context.Response.End();
                }

                //遍历目录取得文件信息
                string[] dirList = Directory.GetDirectories(currentPath);
                string[] fileList = Directory.GetFiles(currentPath);

                switch (order)
                {
                    case "size":
                        Array.Sort(dirList, new NameSorter());
                        Array.Sort(fileList, new SizeSorter());
                        break;
                    case "type":
                        Array.Sort(dirList, new NameSorter());
                        Array.Sort(fileList, new TypeSorter());
                        break;
                    case "name":
                    default:
                        Array.Sort(dirList, new NameSorter());
                        Array.Sort(fileList, new NameSorter());
                        break;
                }
                Hashtable hash = new Hashtable();
                hash["error"] = 0;
                hash["message"] = "格式正确！";
                context.Response.AddHeader("Content-Type", "text/html; charset=UTF-8");
                context.Response.Write(JsonMapper.ToJson(hash));
                context.Response.End();
            }
            catch (Exception ex)
            {

                LogService.WriteErrorLog("ES_wp_AddExamQuestion_ES_wp_EditExamQuestion_保存试题时文件处理|||" + ex.Message);
            }
        }

        public class NameSorter : IComparer
        {
            public int Compare(object x, object y)
            {
                if (x == null && y == null)
                {
                    return 0;
                }
                if (x == null)
                {
                    return -1;
                }
                if (y == null)
                {
                    return 1;
                }
                FileInfo xInfo = new FileInfo(x.ToString());
                FileInfo yInfo = new FileInfo(y.ToString());

                return xInfo.FullName.CompareTo(yInfo.FullName);
            }
        }

        public class SizeSorter : IComparer
        {
            public int Compare(object x, object y)
            {
                if (x == null && y == null)
                {
                    return 0;
                }
                if (x == null)
                {
                    return -1;
                }
                if (y == null)
                {
                    return 1;
                }
                FileInfo xInfo = new FileInfo(x.ToString());
                FileInfo yInfo = new FileInfo(y.ToString());

                return xInfo.Length.CompareTo(yInfo.Length);
            }
        }

        public class TypeSorter : IComparer
        {
            public int Compare(object x, object y)
            {
                if (x == null && y == null)
                {
                    return 0;
                }
                if (x == null)
                {
                    return -1;
                }
                if (y == null)
                {
                    return 1;
                }
                FileInfo xInfo = new FileInfo(x.ToString());
                FileInfo yInfo = new FileInfo(y.ToString());

                return xInfo.Extension.CompareTo(yInfo.Extension);
            }
        }

        private void GetOption(HttpContext context)
        {

            try
            {

                if (context.Request["tid"] != null && !string.IsNullOrEmpty(context.Request["tid"].ToString()))
                {
                    int tid = int.Parse(context.Request["tid"].ToString());
                    Exam_ExamType item = examTypeservice.GetEntityById(tid).retData as Exam_ExamType;
                    if (item != null)
                    {
                        StringBuilder sb = new StringBuilder();
                        if (!string.IsNullOrEmpty(item.Template.SafeToString()))
                        {
                            context.Response.Write("1|" + item.Template.SafeToString() + "|");
                        }
                        else
                        {
                            context.Response.Write("0|");
                        }
                    }
                    else { context.Response.Write("0|"); }
                }
                else { context.Response.Write("0|"); }
            }
            catch (Exception ex)
            {

                LogService.WriteErrorLog("ES_wp_AddExamQuestion_试题类型联动选项答案|||" + ex.Message);

            }
        }
        private void GetChildNode(HttpContext context)
        {
            try
            {

                if (context.Request["pid"] != null && !string.IsNullOrEmpty(context.Request["pid"].ToString()))
                {
                    int pid = int.Parse(context.Request["pid"].ToString());
                    int nodesid = int.Parse(context.Request["nodes"].SafeToString());
                    DataTable Subjectdt = new DataTable();
                    string[] columns = new string[] { "ID", "Title", "Pid" };
                    foreach (string column in columns)
                    {
                        Subjectdt.Columns.Add(column);
                    }
                    if (pid == 0)
                    {
                        //Subjectdt = ExamQManager.GetMajor();
                    }
                    else if (nodesid == 1)
                    { //Subjectdt = ExamQManager.GetSubject(pid); 
                    }
                    else
                    {
                        // Subjectdt = ExamQManager.GetNodesByPid(pid);
                    }
                    StringBuilder sb = new StringBuilder();
                    for (int i = 0; i < Subjectdt.Rows.Count; i++)
                    {
                        sb.Append("<option value='" + Subjectdt.Rows[i]["ID"] + "'>" + Subjectdt.Rows[i]["Title"] + "</option>");
                    }
                    if (sb != null)
                    {
                        context.Response.Write(sb.ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog("GetChildNode_专业学科联动获取数据|||" + ex.Message);

            }
        }
        /// <summary>
        /// 新增试题
        /// </summary>
        private void AddExamQuestion(HttpContext context)
        {
            try
            {

                LogService.WriteLog("新增试题");
                string type = context.Request["Type"].SafeToString();
                //获取试题类型
                string Qtype = string.Empty;
                string template = string.Empty;

                int typeid = int.Parse(type);
                jsonModel = examTypeservice.GetEntityById(typeid);
                Exam_ExamType exam_type = jsonModel.retData as Exam_ExamType;
                Qtype = exam_type.QType.SafeToString();
                template = exam_type.Template.SafeToString();
                //判断主观/客观试题
                if (Qtype.Equals("1"))
                {
                    SaveSubjQuestion(type, context);
                }
                else if (Qtype.Equals("2"))
                { SaveObjQuestion(type, template, context); }
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog("AddExamQuestion_新增试题|||" + ex.Message);
            }
        }
        /// <summary>
        /// 客观题添加
        /// </summary>
        /// <param name="list"></param>
        /// <param name="typeid"></param>
        private void SaveObjQuestion(string typeid, string template, HttpContext context)
        {
            try
            {
                string question = context.Request["Question"].SafeToString();
                string answer = context.Request["Answer"].SafeToString();
                string OptionA = context.Request["OptionA"].SafeToString();
                string OptionB = context.Request["OptionB"].SafeToString();
                string OptionC = context.Request["OptionC"].SafeToString();
                string OptionD = context.Request["OptionD"].SafeToString();
                string OptionE = context.Request["OptionE"].SafeToString();
                string OptionF = context.Request["OptionF"].SafeToString();
                string difficulty = context.Request["Difficulty"];
                string Major = context.Request["Major"];
                string Subject = context.Request["Subject"];
                string Book = context.Request["Book"];
                Book = Book == "0" ? "0" : Book.Split('|')[1];
                string Chapter = context.Request["Chapter"];
                string Part = context.Request["Part"];
                string Point = context.Request["Point"];
                string Status = context.Request["Status"];
                string Analysis = context.Request["Analysis"];
                string Author = context.Request["Author"];
                string Score = context.Request["Score"];

                string isshowanalysis = context.Request["isshowanalysis"].SafeToString();
                if (!string.IsNullOrEmpty(question) && !string.IsNullOrEmpty(answer) && ((template == "3") || (template != "3" && !string.IsNullOrEmpty(OptionA))) && !string.IsNullOrEmpty(Status) && !string.IsNullOrEmpty(Major))
                {
                    string Title = context.Request["Title"];
                    string query = "Title='" + Title.Trim();//CAML.And(CAML.Eq(CAML.FieldRef("Answer"),CAML.Value(answer)),CAML.And( )),CAML.Eq(CAML.FieldRef("Content"),CAML.Value(question.Trim()))@"<Where><Eq><FieldRef Name='Title' /><Value Type='Text'>"+ Title.Trim() + "</Value></Eq></Where>";
                    jsonModel = objqservice.GetEntityListByField("Title", Title);
                    List<Exam_ObjQuestion> objlist = jsonModel.retData as List<Exam_ObjQuestion>;
                    if (objlist != null && objlist.Count > 0)
                    {
                        //context.Response.Write("0|新增失败,已存在该试题！");
                        jsonModel = new JsonModel()
                        {
                            errNum = 1,
                            errMsg = "新增失败,已存在该试题！！",
                            retData = ""
                        };
                        return;
                    }
                    Exam_ObjQuestion item = new Exam_ObjQuestion();
                    item.Title = Title.Trim();
                    item.Type = int.Parse(typeid);
                    item.Content = question;
                    item.OptionA = OptionA;
                    item.OptionB = OptionB;
                    item.OptionC = OptionC;
                    item.OptionD = OptionD;
                    item.OptionE = OptionE;
                    item.OptionF = OptionF;
                    if (!string.IsNullOrEmpty(Subject))
                    {
                        item.Major = !string.IsNullOrEmpty(context.Request["Book"]) && !context.Request["Book"].Equals("0") && !Subject.Equals("0") ? (Subject + "|" + context.Request["Book"]) : Subject;
                        //item.Major = !string.IsNullOrEmpty(Subject) && !Subject.Equals("0") ? int.Parse(Subject) : int.Parse(Major);
                        item.Klpoint = !string.IsNullOrEmpty(Point) && !Point.Equals("0") ? int.Parse(Point) : !string.IsNullOrEmpty(Part) && !Part.Equals("0") ? int.Parse(Part) : int.Parse(Chapter);
                    }
                    //item.Major = Subject;//需要改
                    item.Answer = answer;
                    item.Difficulty = int.Parse(difficulty);
                    item.Analysis = Analysis;
                    item.Status = int.Parse(Status);
                    item.CreateTime = DateTime.Now;
                    item.Author = Author;//需要改
                    item.Score = Convert.ToInt32(Score);//需要改
                    item.Book = Book;
                    item.IsShowAnalysis = int.Parse(isshowanalysis);
                    jsonModel = objqservice.Add(item);
                }
                else
                {
                    LogService.WriteErrorLog("0|新增失败(参数不正确)！");
                    jsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "新增失败(参数不正确)！",
                        retData = ""
                    };
                }
            }
            catch (Exception ex)
            {

                LogService.WriteErrorLog("ES_wp_AddExamQuestion_新增试题||||" + ex.Message);
                jsonModel = new JsonModel()
                {
                    errNum = 1,
                    errMsg = "新增失败！",
                    retData = ""
                };
            }
        }
        /// <summary>
        /// 主观题添加
        /// </summary>
        /// <param name="list"></param>
        /// <param name="typeid"></param>
        private void SaveSubjQuestion(string typeid, HttpContext context)
        {
            try
            {
                string question = context.Request["Question"].SafeToString();
                string canswer = context.Request["CAnswer"].SafeToString();
                string difficulty = context.Request["Difficulty"].SafeToString();
                string Major = context.Request["Major"].SafeToString();
                string Subject = context.Request["Subject"].SafeToString();
                string Book = context.Request["Book"].SafeToString();
                Book = Book == "0" ? "0" : Book.Split('|')[1];
                string Chapter = context.Request["Chapter"].SafeToString();
                string Part = context.Request["Part"].SafeToString();
                string Point = context.Request["Point"].SafeToString();
                string Status = context.Request["Status"].SafeToString();
                string Analysis = context.Request["Analysis"].SafeToString();

                string isshowanalysis = context.Request["isshowanalysis"].SafeToString();
                if (!string.IsNullOrEmpty(question) && !string.IsNullOrEmpty(Major))
                {
                    string Title = context.Request["Title"];
                    string query = "Title='" + Title.Trim();//CAML.And(CAML.Eq(CAML.FieldRef("Answer"),CAML.Value(answer)),CAML.And( )),CAML.Eq(CAML.FieldRef("Content"),CAML.Value(question.Trim()))@"<Where><Eq><FieldRef Name='Title' /><Value Type='Text'>"+ Title.Trim() + "</Value></Eq></Where>";
                    JsonModel subqjson = subqservice.GetEntityListByField("Title", Title);
                    List<Exam_SubQuestion> sublist = subqjson.retData as List<Exam_SubQuestion>;
                    if (sublist != null && sublist.Count > 0)
                    {
                        //context.Response.Write("0|新增失败,已存在该试题！");
                        jsonModel = new JsonModel()
                        {
                            errNum = 1,
                            errMsg = "新增失败,已存在该试题！！",
                            retData = ""
                        };
                        return;
                    }
                    Exam_SubQuestion item = new Exam_SubQuestion();
                    item.Title = Title.Trim();
                    item.Type = int.Parse(typeid);
                    item.Difficulty = int.Parse(difficulty);
                    item.Content = question;
                    if (!string.IsNullOrEmpty(Subject))
                    {

                        item.Major = !string.IsNullOrEmpty(context.Request["Book"]) && !context.Request["Book"].Equals("0") && !Subject.Equals("0") ? (Subject + "|" + context.Request["Book"]) : Subject;
                        //item.Major = !string.IsNullOrEmpty(Subject) && !Subject.Equals("0") ? int.Parse(Subject) : int.Parse(Major);
                        item.Klpoint = !string.IsNullOrEmpty(Point) && !Point.Equals("0") ? int.Parse(Point) : !string.IsNullOrEmpty(Part) && !Part.Equals("0") ? int.Parse(Part) : int.Parse(Chapter);
                    }
                    item.Answer = canswer;
                    item.Analysis = Analysis;
                    item.Status = int.Parse(Status);
                    item.IsShowAnalysis = int.Parse(isshowanalysis);
                    item.CreateTime = DateTime.Now;
                    //item.Author = 1;//需要改
                    //item.Score = 5;//需要改
                    item.Book = Book;
                    jsonModel = subqservice.Add(item);

                }
                else
                {
                    LogService.WriteErrorLog("0|新增失败(参数不正确)！");
                    jsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "新增失败(参数不正确)！",
                        retData = ""
                    };
                    context.Response.Write(jsonModel);
                }
            }
            catch (Exception ex)
            {

                LogService.WriteErrorLog("ES_wp_AddExamQuestion_新增试题||||" + ex.Message);
                jsonModel = new JsonModel()
                {
                    errNum = 1,
                    errMsg = "新增失败！",
                    retData = ""
                };
            }
        }
        /// <summary>
        /// 修改启用或禁用状态
        /// </summary>
        private void ChangeQuestionStatus(HttpContext context)
        {
            try
            {
                string status = context.Request["Status"].SafeToString();
                string qtype = context.Request["Qtype"].SafeToString();
                string quesID = context.Request["QuesID"].SafeToString();
                if (!string.IsNullOrEmpty(status) && !string.IsNullOrEmpty(quesID))
                {
                    if (qtype.Equals("1"))
                    {
                        Exam_SubQuestion subquestion = subqservice.GetEntityById(Convert.ToInt32(quesID)).retData as Exam_SubQuestion;
                        subquestion.Status = Convert.ToInt32(status);
                        jsonModel = subqservice.Update(subquestion);

                    }
                    else if (qtype.Equals("2"))
                    {
                        Exam_ObjQuestion objquestion = objqservice.GetEntityById(Convert.ToInt32(quesID)).retData as Exam_ObjQuestion;
                        objquestion.Status = Convert.ToInt32(status);
                        jsonModel = objqservice.Update(objquestion);
                    }
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "修改失败！",
                        retData = ""
                    };
                }
            }
            catch (Exception ex)
            {

                LogService.WriteErrorLog("ES_wp_ExamQManager_试题管理修改试题状态|||" + ex.Message);
                jsonModel = new JsonModel()
                {
                    errNum = 1,
                    errMsg = "修改失败！",
                    retData = ""
                };
            }
        }

        #region 修改试卷的启用或禁用状态
        /// <summary>
        /// 修改试卷的启用或禁用状态
        /// </summary>
        private void ChangPaperStatus(HttpContext context)
        {
            try
            {
                string status = context.Request["Status"].SafeToString();
                string paperID = context.Request["PaperID"].SafeToString();
                if (!string.IsNullOrEmpty(status) && !string.IsNullOrEmpty(paperID))
                {
                    Exam_ExamPaper paper = paperservice.GetEntityById(Convert.ToInt32(paperID)).retData as Exam_ExamPaper;
                    paper.Status = Convert.ToInt32(status);
                    jsonModel = paperservice.Update(paper);
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "修改失败！",
                        retData = ""
                    };
                }
            }
            catch (Exception ex)
            {

                LogService.WriteErrorLog("ChangPaperStatus_修改试卷的启用或禁用状态|||" + ex.Message);
                jsonModel = new JsonModel()
                {
                    errNum = 1,
                    errMsg = "修改失败！",
                    retData = ""
                };
            }
        }
        #endregion

        /// <summary>
        /// 编辑试题
        /// </summary>
        private void EditExamQuestion(HttpContext context)
        {
            try
            {
                //获取参数
                string type = context.Request["Type"] == null ? "0" : context.Request["Type"].SafeToString();
                string QID = context.Request["QID"] == null ? "0" : context.Request["QID"].SafeToString();
                string oldtype = context.Request["oldtype"] == null ? "0" : context.Request["oldtype"].SafeToString();
                if (!string.IsNullOrEmpty(QID))
                {
                    int qid = int.Parse(QID);
                    //获取试题类型
                    string Qtype = string.Empty;
                    string Qoldtype = string.Empty;
                    string template = string.Empty;

                    int typeid = int.Parse(type);
                    int oldtypeid = int.Parse(oldtype);
                    Exam_ExamType typeitem = examTypeservice.GetEntityById(typeid).retData as Exam_ExamType;
                    Exam_ExamType oldtypeitem = examTypeservice.GetEntityById(oldtypeid).retData as Exam_ExamType;
                    if (typeitem != null)
                    {
                        Qtype = typeitem.QType.SafeToString();
                    }
                    if (oldtypeitem != null)
                    {
                        Qoldtype = oldtypeitem.QType.SafeToString();
                    }
                    template = typeitem.Template.SafeToString();


                    //判断1主观/2客观试题
                    if (Qtype.Equals("1"))
                    {
                        //判断是新增还是修改（当前类型是否和修改之前的类型一样）
                        bool one = Qtype.Equals(Qoldtype);
                        if (one)
                        {
                            EditSubjQuestion(qid, type, oldtype, context, "1");
                        }
                        else { EditSubjQuestion(qid, type, oldtype, context, "2"); }
                    }
                    else if (Qtype.Equals("2"))
                    {
                        //判断是新增还是修改（当前类型是否和修改之前的类型一样）
                        bool one = Qtype.Equals(Qoldtype);
                        if (one)
                        { EditObjQuestion(qid, type, template, oldtype, context, "1"); }
                        else { EditObjQuestion(qid, type, template, oldtype, context, "2"); }
                    }
                }
            }
            catch (Exception ex)
            {

                LogService.WriteErrorLog("ES_wp_EditExamQuestion_修改试题|||" + ex.Message);
            }
        }
        /// <summary>
        /// 客观题修改
        /// </summary>
        /// <param name="list"></param>
        /// <param name="typeid"></param>
        private void EditObjQuestion(int id, string typeid, string template, string oldtype, HttpContext context, string isupdete)
        {
            JsonModel resultjson = new JsonModel();
            try
            {
                //获取参数
                string question = context.Request["Question"];
                string answer = context.Request["Answer"];
                string OptionA = context.Request["OptionA"];
                string OptionB = context.Request["OptionB"];
                string OptionC = context.Request["OptionC"];
                string OptionD = context.Request["OptionD"];
                string OptionE = context.Request["OptionE"];
                string OptionF = context.Request["OptionF"];
                string difficulty = context.Request["Difficulty"];
                string Major = context.Request["Major"];
                string Book = context.Request["Book"];
                string Subject = context.Request["Subject"];
                string Chapter = context.Request["Chapter"];
                string Part = context.Request["Part"];
                string Point = context.Request["Point"];
                string Status = context.Request["Status"];
                string Analysis = context.Request["Analysis"];

                string isshowanalysis = context.Request["isshowanalysis"].SafeToString();
                if (!string.IsNullOrEmpty(question) && !string.IsNullOrEmpty(answer) && (template == "3" || (template != "3" && !string.IsNullOrEmpty(OptionA))) && !string.IsNullOrEmpty(Status) && !string.IsNullOrEmpty(Major))
                {
                    string Title = context.Request["Title"];
                    Exam_ObjQuestion item = new Exam_ObjQuestion();
                    if (isupdete == "1")
                    {
                        item = objqservice.GetEntityById(id).retData as Exam_ObjQuestion;//修改题
                    }
                    item.Title = Title.Trim();
                    item.Type = int.Parse(typeid);
                    item.Difficulty = int.Parse(difficulty);
                    item.Content = question;
                    item.OptionA = OptionA;
                    item.OptionB = OptionB;
                    item.OptionC = OptionC;
                    item.OptionD = OptionD;
                    item.OptionE = OptionE;
                    item.OptionF = OptionF;
                    if (!string.IsNullOrEmpty(Subject))
                    {
                        item.Book = Book == "0" ? "0" : Book.Split('|')[1];
                        item.Major = !string.IsNullOrEmpty(Book) && !Subject.Equals("0") ? (Subject + "|" + Book) : Subject;
                        //item.Major = !string.IsNullOrEmpty(Subject) && !Subject.Equals("0") ? int.Parse(Subject) : int.Parse(Major);
                        item.Klpoint = !string.IsNullOrEmpty(Point) && !Point.Equals("0") ? int.Parse(Point) : !string.IsNullOrEmpty(Part) && !Part.Equals("0") ? int.Parse(Part) : int.Parse(Chapter);
                    }
                    item.Answer = answer;
                    item.Status = int.Parse(Status);
                    item.Analysis = Analysis;
                    item.IsShowAnalysis = int.Parse(isshowanalysis);
                    if (isupdete == "1")
                    {
                        resultjson = objqservice.Update(item);//修改题
                    }
                    else
                    {
                        subqservice.Delete(id);//删除原来的题
                        resultjson = objqservice.Add(item);//新增新的题
                    }

                    context.Response.Write(resultjson);
                }
                else
                {
                    resultjson.errNum = 1;
                    resultjson.errMsg = "0|保存失败(参数不正确)！";
                    context.Response.Write(resultjson);
                }
            }
            catch (Exception ex)
            {

                LogService.WriteErrorLog("ES_wp_EditExamQuestion_修改试题|||" + ex.Message);
                resultjson.errNum = 1;
                resultjson.errMsg = "0|保存失败！";
                context.Response.Write(resultjson);
            }
        }
        /// <summary>
        /// 主观题修改
        /// </summary>
        /// <param name="list"></param>
        /// <param name="typeid"></param>
        private void EditSubjQuestion(int id, string typeid, string oldtype, HttpContext context, string isupdete)
        {
            JsonModel resultjson = new JsonModel();
            try
            {
                //获取参数
                string question = context.Request["Question"];
                string canswer = context.Request["CAnswer"];
                string difficulty = context.Request["Difficulty"];
                string Major = context.Request["Major"];
                string Book = context.Request["Book"];
                string Subject = context.Request["Subject"];
                string Chapter = context.Request["Chapter"];
                string Part = context.Request["Part"];
                string Point = context.Request["Point"];
                string Status = context.Request["Status"];
                string Analysis = context.Request["Analysis"];

                string isshowanalysis = context.Request["isshowanalysis"].SafeToString();
                if (!string.IsNullOrEmpty(question) && !string.IsNullOrEmpty(Status) && !string.IsNullOrEmpty(Book))
                {
                    string Title = context.Request["Title"];
                    Exam_SubQuestion item = new Exam_SubQuestion();
                    if (isupdete == "1")
                    {
                        item = subqservice.GetEntityById(id).retData as Exam_SubQuestion;//修改题
                    }
                    item.Title = Title.Trim();
                    item.Type = int.Parse(typeid);
                    item.Difficulty = int.Parse(difficulty);
                    item.Content = question;
                    if (!string.IsNullOrEmpty(Major))
                    {
                        item.Book = Book == "0" ? "0" : Book.Split('|')[1];
                        item.Major = !string.IsNullOrEmpty(Book) && !Subject.Equals("0") ? (Subject + "|" + Book) : Subject;
                        //item.Major = !string.IsNullOrEmpty(Subject) && !Subject.Equals("0") ? int.Parse(Subject) : int.Parse(Major);
                        item.Klpoint = !string.IsNullOrEmpty(Point) && !Point.Equals("0") ? int.Parse(Point) : !string.IsNullOrEmpty(Part) && !Part.Equals("0") ? int.Parse(Part) : int.Parse(Chapter);
                    }
                    item.Answer = canswer;
                    item.Status = int.Parse(Status);
                    item.Analysis = Analysis;
                    item.IsShowAnalysis = int.Parse(isshowanalysis);

                    if (isupdete == "1")
                    {
                        resultjson = subqservice.Update(item);//修改题
                    }
                    else
                    {
                        objqservice.Delete(id);//删除原来的题
                        resultjson = subqservice.Add(item);//新增新的题
                    }
                    context.Response.Write(resultjson);

                }
                else
                {
                    resultjson.errNum = 1;
                    resultjson.errMsg = "0|保存失败(参数不正确)！";
                    context.Response.Write(resultjson);
                }
            }
            catch (Exception ex)
            {

                LogService.WriteErrorLog("ES_wp_EditExamQuestion_修改试题|||" + ex.Message);
                resultjson.errNum = 1;
                resultjson.errMsg = "0|保存失败！";
                context.Response.Write(resultjson);
            }
        }
        private void GetExamObjQList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("MajorId", context.Request["MajorID"] ?? "");
                ht.Add("KlpointID", context.Request["KlpointID"] ?? "");
                ht.Add("Type", context.Request["Type"].SafeToString().Equals("0") || context.Request["Type"].SafeToString().Equals("") ? "" : context.Request["Type"].SafeToString());
                ht.Add("Title", context.Request["Title"] ?? "");
                bool ispage = true;
                if (!string.IsNullOrEmpty(HttpContext.Current.Request["IsPage"]))
                {
                    ispage = false;
                }
                ht.Add("Difficult", context.Request["Difficult"].SafeToString().Equals("0") || context.Request["Difficult"].SafeToString().Equals("") ? "" : context.Request["Difficult"].SafeToString());
                ht.Add("Status", context.Request["Status"]);
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());
                jsonModel = objqservice.GetPage(ht, ispage);
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
        private void GetExamSubQList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("MajorId", context.Request["MajorID"] ?? "");
                ht.Add("KlpointID", context.Request["KlpointID"] ?? "");
                ht.Add("Type", context.Request["Type"].SafeToString().Equals("0") || context.Request["Type"].SafeToString().Equals("") ? "" : context.Request["Type"].SafeToString());
                ht.Add("Title", context.Request["Title"] ?? "");
                bool ispage = true;
                if (!string.IsNullOrEmpty(HttpContext.Current.Request["IsPage"]))
                {
                    ispage = false;
                }
                ht.Add("Difficult", context.Request["Difficult"].SafeToString().Equals("0") || context.Request["Difficult"].SafeToString().Equals("") ? "" : context.Request["Difficult"].SafeToString());
                ht.Add("Status", context.Request["Status"]);
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());
                jsonModel = subqservice.GetPage(ht, ispage);
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
        public void GetExamQTList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());
                jsonModel = examTypeservice.GetPage(ht, true);
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
        public void GetQuestionTypeList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "Exam_ExamType");
                jsonModel = examTypeservice.GetPage(ht, false, "  and T.Status=1");
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
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}