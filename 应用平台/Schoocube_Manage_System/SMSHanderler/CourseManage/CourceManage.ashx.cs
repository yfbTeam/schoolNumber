using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SMSBLL;
using SMSModel;
using SMSUtility;
using System.Web.Script.Serialization;
using System.Collections;
using System.Data;
using SMSHanderler.OnlineLearning;
namespace SMSWeb.CourseManage
{
    /// <summary>
    /// CourceManage 的摘要说明
    /// </summary>
    public class CourceManage : IHttpHandler
    {
        CourseService bll = new CourseService();
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;
        Course_ChapterService courcebll = new Course_ChapterService();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            // HttpPostedFile hpf = HttpContext.Current.Request.Files["imgfile"];//HttpPostedFile提供对客户端已上载的单独文件的访问        string savepath = context.Server.MapPath("." + hpf.FileName);//路径,相对于服务器当前的路径        hpf.SaveAs(savepath);//保存        context.Response.Write("保存成功"+hpf.FileName);
            string FuncName = context.Request["Func"].ToString();
            string result = string.Empty;

            if (FuncName != null && FuncName != "")
            {
                try
                {
                    switch (FuncName)
                    {
                        case "GetPageList":
                            GetPageList(context);
                            break;
                        case "AddCource":
                            AddCource(context);
                            break;
                        case "Chapator":
                            Chapator(context);
                            break;
                        case "ChapatorM":
                            ChapatorM(context);
                            break;
                        case "AddNewMenu":
                            AddNewMenu(context);
                            break;
                        case "DelMenu":
                            DelMenu(context);
                            break;
                        case "TaskInfo":
                            TaskInfo(context);
                            break;
                        case "SingUp":
                            SingUp(context);
                            break;
                        case "CourceCheck":
                            CourceCheck(context);
                            break;
                        case "GetCourseByType":
                            GetCourseByType(context);
                            break;
                        case "GetSelStu":
                            GetSelStu(context);
                            break;
                        case "GetFreeStu":
                            GetFreeStu(context);
                            break;
                        case "AdjustStu":
                            AdjustStu(context);
                            break;
                        case "ModoleAdd":
                            ModoleAdd(context);
                            break;
                        case "BindModol":
                            BindModol(context);
                            break;
                        case "AddCourseByModol":
                            AddCourseByModol(context);
                            break;
                        case "HotCourse":
                            HotCourse(context);
                            break;
                        case "Course_EvalueStatistical":
                            Course_EvalueStatistical(context);
                            break;
                        case "OneCourse_EvalueStatist":
                            OneCourse_EvalueStatist(context);
                            break;
                        case "Course_EvalueList":
                            Course_EvalueList(context);
                            break;
                        case "reMenuName":
                            reMenuName(context);
                            break;
                        case "DelCourse":
                            DelCourse(context);
                            break;
                        case "SortMenu":
                            SortMenu(context);
                            break;
                        case "CouseTypeAnalis":
                            CouseTypeAnalis(context);
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
        }


        #region 统计课程类型
        /// <summary>
        /// 调整目录排序
        /// </summary>
        /// <param name="context"></param>
        private void CouseTypeAnalis(HttpContext context)
        {
            try
            {
                string Type = context.Request["Type"].SafeToString();
                string result = bll.CouseTypeAnalis(Type);

                jsonModel = new JsonModel
                {
                    errNum = 0,
                    errMsg = "",
                    retData = result
                };

            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
            }
        }
        #endregion

        #region 调整目录排序
        /// <summary>
        /// 调整目录排序
        /// </summary>
        /// <param name="context"></param>
        private void SortMenu(HttpContext context)
        {
            Course_ChapterService chapterdll = new Course_ChapterService();
            try
            {
                int ID = Convert.ToInt32(context.Request["ID"]);
                string Type = context.Request["Type"].SafeToString();
                string result = chapterdll.EditChapterSort(ID, Type);
                if (result == "")
                {
                    jsonModel = new JsonModel
                    {
                        errNum = 0,
                        errMsg = "修改成功",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel
                    {
                        errNum = 999,
                        errMsg = result,
                        retData = ""
                    };
                }
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
            }
        }
        #endregion

        #region 删除课程

        private void DelCourse(HttpContext context)
        {
            string ID = context.Request["ID"].SafeToString();
            string IdCard = context.Request["IdCard"].SafeToString();
            string Message = "";
            try
            {

                Message = bll.DelCourse(ID, IdCard);
                if (Message == "")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "操作成功",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = Message,
                        retData = ""
                    };
                }
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 404,
                    errMsg = ex.Message,
                    retData = ""
                };
            }
        }
        #endregion

        #region 修改课程目录名称
        /// <summary>
        /// 修改文件夹（文件夹）名称
        /// </summary>
        /// <param name="context"></param>
        private void reMenuName(HttpContext context)
        {
            string result = "";
            JsonModel jsonModel = null;
            JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();

            Course_Chapter modol = new Course_Chapter();
            string Name = context.Request["NewName"].SafeToString();
            modol.ID = Convert.ToInt32(context.Request["ID"]);

            modol.Name = Name;
            modol.EditTime = DateTime.Now;
            jsonModel = courcebll.Update(modol);
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();
        }

        #endregion

        #region 所有评价
        /// <summary>
        /// 所有评价
        /// </summary>
        /// <param name="context"></param>
        private void Course_EvalueList(HttpContext context)
        {
            CommonHandler common = new CommonHandler();
            Course_EvalueService evalue = new Course_EvalueService();
            try
            {
                int CourseID = Convert.ToInt32(context.Request["CourseID"].SafeToString());
                Hashtable ht = new Hashtable();
                bool Ispage = false;
                ht.Add("TableName", "Course_Evalue");
                if (context.Request["Ispage"].SafeToString().Length > 0)
                {
                    Ispage = Convert.ToBoolean(context.Request["Ispage"]);
                }
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                //jsonModel = evalue.GetPage(ht, false, " and CouseID=" + CourseID);
                jsonModel = common.AddCreateNameForData(evalue.GetPage(ht, Ispage, " and CouseID=" + CourseID), 3, Ispage);

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
        #endregion

        #region 评价详情
        private void OneCourse_EvalueStatist(HttpContext context)
        {
            Course_EvalueService evalue = new Course_EvalueService();
            try
            {
                int CourseID = Convert.ToInt32(context.Request["ID"].SafeToString());
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());
                ht.Add("ID", CourseID);
                jsonModel = evalue.Course_EvalueStatistical(ht, false);

                List<Dictionary<string, object>> gas = (List<Dictionary<string, object>>)jsonModel.retData;
                //List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                List<object> list = new List<object>();

                for (int i = 0; i < gas.Count; i++)
                {
                    string ID = gas[i]["Evalue"].ToString() + "分";
                    string Name = gas[i]["Num"].ToString();
                    list.Add(new { name = ID, value = Name });
                    //rtnList.Add(new { name = "未完成任务", value = allCount - comCount });

                    //Dictionary<string, object> drow = new Dictionary<string, object>();
                    //drow.Add("name", ID);
                    //drow.Add("value", Name);

                    //list.Add(drow);
                }
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = list
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
        #endregion

        #region 课程评价统计
        /// <summary>
        /// 课程评价统计
        /// </summary>
        /// <param name="context"></param>
        private void Course_EvalueStatistical(HttpContext context)
        {
            Course_EvalueService evalue = new Course_EvalueService();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("StudyTerm", context.Request["StudyTerm"].SafeToString());
                jsonModel = evalue.Course_EvalueStatistical(ht);
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
            }
        }
        #endregion

        #region 获取热门课程
        /// <summary>
        /// 获取热门课程
        /// </summary>
        /// <param name="context"></param>
        private void HotCourse(HttpContext context)
        {
            try
            {
                jsonModel = bll.HotCourse();
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
            }

        }
        #endregion

        #region 根据模版生成课程
        /// <summary>
        /// 根据模版生成课程
        /// </summary>
        /// <param name="context"></param>
        private void AddCourseByModol(HttpContext context)
        {
            try
            {
                string ModelID = context.Request["ModelID"].SafeToString();
                string CourseName = context.Request["CourseName"].SafeToString();
                string CourseMes = context.Request["CourseMes"].SafeToString();
                string CreateUID = context.Request["CreateUID"].SafeToString();
                string ReturnMessage = bll.AddCourseByModol(int.Parse(ModelID), CourseName, CourseMes, CreateUID);
                int ReturnFlag = 0;
                if (ReturnMessage.Length > 0)
                {
                    ReturnFlag = 2;
                }
                jsonModel = new JsonModel
                {
                    errNum = ReturnFlag,
                    errMsg = ReturnMessage,
                    retData = ""
                };
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
            }

        }
        #endregion

        #region 绑定课程模版
        /// <summary>
        /// 绑定课程模版
        /// </summary>
        /// <param name="context"></param>
        private void BindModol(HttpContext context)
        {
            Course_ModolService Course_Modoldll = new Course_ModolService();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());
                ht.Add("TableName", "Course_Modol");

                jsonModel = Course_Modoldll.GetPage(ht);
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
        #endregion

        #region 添加模版
        /// <summary>
        /// 添加模版
        /// </summary>
        /// <param name="context"></param>
        private void ModoleAdd(HttpContext context)
        {
            try
            {
                string CourceID = context.Request["CourceID"].SafeToString();
                string ModelName = context.Request["ModoleName"].SafeToString();
                string CreateUID = context.Request["CreateUID"].SafeToString();
                string CourseMes = context.Request["CourseMes"].SafeToString();
                string ReturnMessage = bll.ModoleAdd(int.Parse(CourceID), ModelName, CourseMes, CreateUID);
                int ReturnFlag = 0;
                if (ReturnMessage.Length > 0)
                {
                    ReturnFlag = 2;
                }
                jsonModel = new JsonModel
                {
                    errNum = ReturnFlag,
                    errMsg = ReturnMessage,
                    retData = ""
                };
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
            }

        }
        #endregion

        #region 调整报名学生
        /// <summary>
        /// 调整报名学生
        /// </summary>
        /// <param name="context"></param>
        private void AdjustStu(HttpContext context)
        {
            try
            {
                string Type = context.Request["Type"].SafeToString();
                string FreeStuIDs = context.Request["FreeStuIDs"].SafeToString();
                string StuIDs = context.Request["StuIDs"].SafeToString();
                string CourseID = context.Request["CourseID"].SafeToString();
                string CreateUID = context.Request["CreateUID"].SafeToString();

                string Result = bll.AdjustStu(int.Parse(Type), FreeStuIDs, StuIDs, CourseID, CreateUID, "");
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = Result,
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
            }

        }
        #endregion

        #region 获取报名学生信息
        private void GetSelStu(HttpContext context)
        {
            CommonHandler common = new CommonHandler();
            Couse_SelstuinfoService selbll = new Couse_SelstuinfoService();
            string CourseID = context.Request["CourseID"].SafeToString();
            string ClassID = context.Request["ClassID"].SafeToString();
            JsonModel jsonModel1 = selbll.GetDataByCourceID(CourseID);
            if (ClassID.Length > 0)
            {
                jsonModel = common.AddCreateNameForData(jsonModel1, 2, false, ClassID, "", "StuNo");
            }
            else { jsonModel = common.AddCreateNameForData(jsonModel1, 0, false, ClassID, "", "StuNo"); }
        }
        #endregion

        #region 班级内所有学生

        private void GetFreeStu(HttpContext context)
        {
            BLLCommon common = new BLLCommon();
            ClassCourseService classCourse = new ClassCourseService();
            string CourseID = context.Request["CourseID"].SafeToString();

            Hashtable ht = new Hashtable();
            ht.Add("TableName", "ClassCourse");
            string ReturnCourseID = "";

            jsonModel = classCourse.GetPage(ht, false, " and CourseID=" + CourseID);
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();

            if (jsonModel.retData.SafeToString().Length > 0)
            {
                list = (List<Dictionary<string, object>>)jsonModel.retData;

                for (int i = 0; i < list.Count; i++)
                {
                    ReturnCourseID += list[i]["ClassID"] + ",";
                }
            }
            GetClassID(ReturnCourseID.TrimEnd(','), context);
            //return ReturnCourseID;
        }
        /// <summary>
        /// 班级内所有学生
        /// </summary>
        /// <param name="pid"></param>
        private void GetClassID(string ClassID, HttpContext context)
        {
            string loginName = context.Request["loginName"].SafeToString();
            string passWord = context.Request["passWord"].SafeToString();
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string RequestClassID = context.Request["ClassID"].SafeToString();
            ClassID = RequestClassID == "" ? ClassID : RequestClassID;
            if (ClassID=="")
            {
                ClassID = "0";
            }
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string urlbady = "func=GetStudentData&ClassID=" + ClassID + "&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);


            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 根据分类获取课程信息
        /// <summary>
        /// 根据分类获取课程信息
        /// </summary>
        /// <param name="context"></param>
        private void GetCourseByType(HttpContext context)
        {
            string Stu = context.Request["Stu"].SafeToString();
            Hashtable ht = new Hashtable();
            ht.Add("ClassID", context.Request["ClassID"].SafeToString());
            ht.Add("CourceType", context.Request["CourceType"].SafeToString());
            ht.Add("Name", context.Request["Name"].SafeToString());
            int num = int.Parse(context.Request["Num"]);
            jsonModel = bll.GetCourseByType(num, Stu, ht);
        }
        #endregion

        #region 课程审核
        /// <summary>
        /// 课程审核
        /// </summary>
        /// <param name="contex"></param>
        private void CourceCheck(HttpContext contex)
        {
            Course cource = new Course();
            cource.Status = int.Parse(contex.Request["Status"].SafeToString());
            cource.CheckMes = contex.Request["CheckMsg"].SafeToString();
            cource.ID = Convert.ToInt32(contex.Request["ID"]);
            jsonModel = bll.Update(cource);
        }
        #endregion

        #region 报名
        /// <summary>
        /// 报名
        /// </summary>
        /// <param name="context"></param>
        private void SingUp(HttpContext context)
        {
            try
            {
                string CouseID = context.Request["CourseID"].ToString();
                string StuNo = context.Request["StuNo"].ToString();
                string Command = context.Request["Command"].ToString();
                string flag = bll.StuSingUp(CouseID, StuNo, Command);
                int returnNo = 0;
                if (flag.Length > 0)
                {
                    returnNo = 5;
                }
                jsonModel = new JsonModel
                {
                    errNum = returnNo,
                    errMsg = flag,
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
        #endregion

        #region 获取任务信息
        /// <summary>
        /// 获取任务信息
        /// </summary>
        /// <param name="context"></param>
        private void TaskInfo(HttpContext context)
        {
            Couse_TaskInfoService taskbll = new Couse_TaskInfoService();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("CourseID", context.Request["CourceID"].ToString());
                ht.Add("ChapterID", context.Request["ChapterID"].ToString());
                //ht.Add("ID", context.Request.Form["ID"].ToString());

                jsonModel = taskbll.GetPage(ht, false);
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
        #endregion

        #region 获取左侧导航
        /// <summary>
        /// 获取左侧导航
        /// </summary>
        /// <param name="context"></param>
        private void Chapator(HttpContext context)
        {
            try
            {
                MyResource resource = new MyResource();
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "Course_Chapter");
                ht.Add("CourseID", context.Request["CourseID"].ToString());
                ht.Add("Type", context.Request["Type"].SafeToString());
                ht.Add("Pid", context.Request["Pid"] ?? "");
                jsonModel = courcebll.GetPage(ht, false);
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
        /// <summary>
        /// 获取章节
        /// 移动端--返回视频
        /// </summary>
        /// <param name="context"></param>
        private void ChapatorM(HttpContext context)
        {
            try
            {
                Chapator(context);
                string CourseID = context.Request["CourseID"].ToString();
                string IsVideo = "1";
                string WebUrl = System.Configuration.ConfigurationManager.ConnectionStrings["WebUrl"].ToString();
                if (jsonModel.errNum == 0)
                {

                    List<Dictionary<string, object>> list = jsonModel.retData as List<Dictionary<string, object>>;
                    List<Dictionary<string, object>> list1 = new List<Dictionary<string, object>>();
                    Couse_ResourceService bll = new Couse_ResourceService();
                    foreach (Dictionary<string, object> item in list)
                    {
                        if (item["Pid"].ToString() == "0")
                        {
                            Dictionary<string, object> dic = new Dictionary<string, object>();
                            dic.Add("ID", item["ID"].ToString());
                            dic.Add("Name", item["Name"].ToString());
                            dic.Add("Pid", item["Pid"].ToString());
                            dic.Add("VideoURL", "");
                            dic.Add("NodeName", "章");
                            list1.Add(dic);

                            foreach (Dictionary<string, object> item1 in list)
                            {
                                if (item1["Pid"].ToString() == item["ID"].ToString())
                                {
                                    Dictionary<string, object> dic1 = new Dictionary<string, object>();
                                    dic1.Add("ID", item1["ID"].ToString());
                                    dic1.Add("Name", item1["Name"].ToString());
                                    dic1.Add("Pid", item1["Pid"].ToString());
                                    dic1.Add("VideoURL", "");
                                    dic1.Add("NodeName", "节");
                                    list1.Add(dic1);
                                    //foreach (Dictionary<string, object> item2 in list)
                                    //{
                                    //    if (item2["Pid"].ToString() == item1["ID"].ToString())
                                    //    {
                                    //        Dictionary<string, object> dic2 = new Dictionary<string, object>();
                                    //        dic2.Add("ID", item2["ID"].ToString());
                                    //        dic2.Add("Name", item2["Name"].ToString());
                                    //        dic2.Add("Pid", item2["Pid"].ToString());
                                    //        dic2.Add("VideoURL", "");
                                    //        dic2.Add("NodeName", "课时");
                                    //        list1.Add(dic2);
                                    //    }
                                    //}
                                }
                            }
                            //获取视频信息
                            List<Dictionary<string, object>> ListVideo = new List<Dictionary<string, object>>();
                            Hashtable htZhang = new Hashtable();
                            htZhang.Add("CouseID", CourseID);
                            htZhang.Add("IsVideo", IsVideo);
                            htZhang.Add("ChapterID", item["ID"].ToString());
                            htZhang.Add("StuIdCard", "");

                            JsonModel jsonModelVideo = bll.GetPage(htZhang, false);
                            if (jsonModelVideo.errNum == 0)
                            {
                                ListVideo = jsonModelVideo.retData as List<Dictionary<string, object>>;
                            }
                            //添加视频
                            foreach (Dictionary<string, object> itemVideo in ListVideo)
                            {
                                Dictionary<string, object> dicVideo = new Dictionary<string, object>();
                                dicVideo.Add("ID", itemVideo["ID"].ToString());
                                dicVideo.Add("Name", itemVideo["Name"].ToString());
                                dicVideo.Add("Pid", itemVideo["ChapterID"].ToString());
                                dicVideo.Add("VideoURL", WebUrl + itemVideo["FileUrl"].ToString());
                                dicVideo.Add("NodeName", "视频");
                                list1.Add(dicVideo);
                            }
                        }
                    }

                    jsonModel.retData = list1;
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
        /// <summary>
        /// 添加左侧导航
        /// </summary>
        /// <param name="context"></param>
        private void AddNewMenu(HttpContext context)
        {
            try
            {
                string Type = context.Request["type"].SafeToString();
                Course_Chapter chapter = new Course_Chapter();
                chapter.Name = context.Request["FileName"].SafeToString();
                chapter.CourseID = Convert.ToInt32(context.Request["CourseID"]);
                chapter.Pid = Convert.ToInt32(context.Request["Pid"]);
                chapter.CreateUID = context.Request["IdCard"].SafeToString();
                chapter.EditUID = context.Request["IdCard"].SafeToString();
                chapter.MenuType = int.Parse(Type);
                jsonModel = courcebll.Add(chapter);
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
        /// <summary>
        /// 删除左侧导航
        /// </summary>
        /// <param name="context"></param>
        private void DelMenu(HttpContext context)
        {
            try
            {
                int ID = Convert.ToInt32(context.Request["ID"]);
                string DelResult = courcebll.DelChapter(ID);
                if (DelResult == "0")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "删除成功",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 100,
                        errMsg = DelResult,
                        retData = ""
                    };
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
        #endregion

        #region 获取课程信息
        /// <summary>
        /// 获取课程信息
        /// </summary>
        /// <param name="context"></param>
        private void GetPageList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("TableName", "Course");
                ht.Add("OperSymbol", context.Request["OperSymbol"].SafeToString());
                ht.Add("ID", context.Request["ID"].SafeToString());
                ht.Add("StudyTerm", context.Request["StudyTerm"].SafeToString());
                ht.Add("IdCard", context.Request["IdCard"].SafeToString());
                ht.Add("CourseType", context.Request["CourseType"].SafeToString());
                ht.Add("Name", context.Request["Name"].SafeToString());
                if (!string.IsNullOrWhiteSpace(context.Request["IsCharge"])) ht.Add("IsCharge", context.Request["IsCharge"]);
                bool Ispage = true;
                if (context.Request["Ispage"].SafeToString().Length > 0)
                {
                    Ispage = Convert.ToBoolean(context.Request["Ispage"]);
                }
                jsonModel = bll.GetPage(ht, Ispage);
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
        #endregion

        #region 添加课程

        private void AddCource(HttpContext context)
        {
            Key key = new Key();
            try
            {
                Course cource = new Course();
                string Name = context.Request["Name"].SafeToString();
                cource.Name = context.Request["Name"].SafeToString();
                cource.IsCharge = Convert.ToByte(context.Request["IsCharge"]);
                cource.CourseIntro = context.Request["CourseIntro"].SafeToString();
                cource.CoursePrice = Convert.ToDecimal(context.Request["CoursePrice"]);
                cource.ImageUrl = context.Request["CoursePic"].SafeToString();
                cource.StudyPlace = context.Request["StudyPlace"].SafeToString();
                cource.LecturerName = context.Request["LecturerName"].SafeToString();
                cource.CatagoryID = context.Request["CatagoryID"].SafeToString();
                cource.CourceType = Convert.ToByte(context.Request["CourceType"]);
                string OldCourceType = context.Request["OldCourceType"].SafeToString();
                string OldStatus = context.Request["OldStatus"].SafeToString();


                if (cource.CourceType == 1)
                {
                    cource.Status = 1;
                }
                else { cource.Status = 0; }
                cource.Grade = context.Request["Grade"].SafeToString();
                cource.Class = context.Request["Class"].SafeToString();
                cource.StudyTerm = int.Parse(context.Request["StudyTerm"]);
                cource.TermName = context.Request["TermName"].SafeToString();
                cource.WeekName = context.Request["WeekName"].SafeToString();
                cource.GradeName = context.Request["GradeName"].SafeToString();
                cource.CreateUID = context.Request["CreateUID"].SafeToString();
                cource.StartTime = Convert.ToDateTime(context.Request["StartTime"]);
                cource.EndTime = Convert.ToDateTime(context.Request["EndTime"]);
                cource.CourseType = context.Request["CourseType"].SafeToString();
                cource.IsOpen = Convert.ToInt32(context.Request["IsOpen"]);
                cource.LessonPeriod = Convert.ToInt32(context.Request["LessonPeriod"]);
                cource.RigistType = Convert.ToByte(context.Request["RigistType"]);
                cource.StuMaxCount = Convert.ToInt32(context.Request["StuMaxCount"]);
                if (context.Request["SecurityCode"].SafeToString().Length <= 0)
                {
                    cource.SecurityCode = key.GetKey();
                }
                else { cource.SecurityCode = context.Request["SecurityCode"].SafeToString(); }
                string Message = "";
                if (context.Request["ID"].SafeToString().Length > 0)
                {
                    if (OldCourceType == "2" && cource.CourceType == 2)
                    {
                        cource.Status = int.Parse(OldStatus);
                    }
                    cource.EditUID = context.Request["CreateUID"].SafeToString();
                    cource.EidtTime = DateTime.Now;
                    cource.ID = Convert.ToInt32(context.Request["ID"]);
                    Message = bll.UpdateCourse(cource);
                }
                else
                {
                    Message = bll.AddCourse(cource);
                }
                if (Message == "")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "操作成功",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = Message,
                        retData = ""
                    };
                }
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 404,
                    errMsg = ex.Message,
                    retData = ""
                };
            }
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