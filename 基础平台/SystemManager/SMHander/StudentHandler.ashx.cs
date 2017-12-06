using SMBLL;
using SMModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;


namespace SMHander
{
    /// <summary>
    /// StudentHandler 的摘要说明
    /// </summary>
    public class StudentHandler : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        SMBLL.Plat_LogInfoService log = new SMBLL.Plat_LogInfoService();
        JsonModel jsonModel = null;
        BLLCommon com = new SMBLL.BLLCommon();
        SMBLL.Plat_StudentService BLL = new Plat_StudentService();
        public void ProcessRequest(HttpContext context)
        {
            string func = context.Request["func"] ?? "";
            try
            {
                switch (func)
                {
                    case "GetStudentData":
                        GetStudentData(context);
                        break;
                    case "GetStudentPageData":
                        GetStudentPageData(context);
                        break;
                    case "DeleteStudent":
                        DeleteStudent(context);
                        break;
                    case "AddStudent":
                        AddStudent(context);
                        break;
                    case "GetStudentById":
                        GetStudentById(context);
                        break;
                    case "UpdateStudent":
                        UpdateStudent(context);
                        break;
                    case "JoinClass":
                        JoinClass(context);
                        break;
                    case "GetClassStudent":
                        GetClassStudent(context);
                        break;
                    case "GetStudentByTeacher":
                        GetStudentByTeacher(context);
                        break;
                    case "UploadStudentExcel":
                        UploadStudentExcel(context);
                        break;
                    case "ImportStudent":
                        ImportStudent(context);
                        break;
                    default:
                        jsonModel = new JsonModel()
                        {
                            errNum = 5,
                            errMsg = "没有此方法",
                            retData = ""
                        };
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
            string result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }

        /// <summary>
        /// 获得学生数据
        /// </summary>
        /// <param name="context"></param>
        public void GetStudentData(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();
                //获取参数值
                if (context.Request["SystemKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                }
                if (context.Request["InfKey"] != null)
                {
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                if (context.Request["IDCard"] != null)
                {
                    string[] sdf = context.Request["IDCard"].ToString().Split(',');
                    string IDCards = "";
                    foreach (string item in sdf)
                    {
                        IDCards += ",'" + item + "'";
                    }
                    IDCards = IDCards.Substring(1);
                    sb.Append(" and a.IDCard in (" + IDCards + ")");
                }
                if (context.Request["ClassID"] != null && context.Request["ClassID"].SafeToString().Length>0)
                {
                    sb.Append(" and a.ClassID in (" + context.Request["ClassID"].ToString() + ")");
                }
                sb.Append(" and a.IsDelete=0");
                ht.Add("Where", sb.ToString());
                string PhotoURL = System.Configuration.ConfigurationManager.ConnectionStrings["PhotoURL"].ToString();
                ht.Add("TableName", "Plat_Student a left join Plat_ClassInfo b on a.ClassID=b.Id left join Plat_Grade c on a.GradeID=c.Id left join Plat_School d on a.SchoolID=d.Id");
                ht.Add("Columns", "a.*,b.ClassName,c.GradeName,'" + PhotoURL + "'+a.Photo as PhotoURL,d.Name as SchoolName");
                ht.Add("func", "GetStudentData");
                jsonModel = com.GetData(ht);
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
                return;
            }
        }

        /// <summary>
        /// 获得学生分页数据
        /// </summary>
        /// <param name="context"></param>
        public void GetStudentPageData(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();

                //获取参数值
                if (context.Request["SystemKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                }
                if (context.Request["InfKey"] != null)
                {
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                if (context.Request["PageIndex"] != null)
                {
                    ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                }
                if (context.Request["PageSize"] != null)
                {
                    ht.Add("PageSize", context.Request["PageSize"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["Name"]))
                {
                    sb.Append(" and Name like '%" + context.Request["Name"].ToString() + "%'");
                }
                if (!string.IsNullOrWhiteSpace(context.Request["SchoolID"]))
                {
                    sb.Append(" and SchoolID = '" + context.Request["SchoolID"].ToString() + "'");
                }
                sb.Append(" and IsDelete=0");
                ht.Add("func", "GetStudentPageData");
                ht.Add("Columns", "*");
                ht.Add("TableName", "Plat_Student");
                ht.Add("Where", sb.ToString());

                jsonModel = com.GetPagingData(ht);
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
                return;
            }
        }

        /// <summary>
        /// 修改删除状态
        /// </summary>
        /// <param name="context"></param>
        public void DeleteStudent(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();

                //获取参数值
                if (context.Request["SystemKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                }
                if (context.Request["InfKey"] != null)
                {
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    ht.Add("Id", context.Request["Id"].ToString());
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 3,
                        errMsg = "loss",
                        retData = ""
                    };
                    return;
                }

                ht.Add("func", "DeleteStudent");
                jsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jsonModel.errNum != 0)
                {
                    return;
                }
                jsonModel = BLL.DeleteFalse(Convert.ToInt32(ht["Id"].ToString()));
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
                return;
            }
        }

        /// <summary>
        /// 新增学生
        /// </summary>
        /// <param name="context"></param>
        public void AddStudent(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();

                //获取参数值
                if (context.Request["SystemKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                }
                if (context.Request["InfKey"] != null)
                {
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                ht.Add("func", "AddStudent");
                jsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jsonModel.errNum != 0)
                {
                    return;
                }
                SMModel.Plat_Student model = new Plat_Student();
                if (context.Request["Name"] != null)
                {
                    model.Name = context.Request["Name"].ToString();
                }
                if (context.Request["IDCard"] != null)
                {
                    model.IDCard = context.Request["IDCard"].ToString();
                }
                if (context.Request["LoginName"] != null)
                {
                    model.LoginName = context.Request["LoginName"].ToString();
                }
                if (context.Request["SchoolID"] != null)
                {
                    model.SchoolID = Convert.ToInt32(context.Request["SchoolID"].ToString());
                }
                if (context.Request["State"] != null)
                {
                    model.State = Convert.ToByte(context.Request["State"].ToString());
                }
                if (context.Request["SchoolNO"] != null)
                {
                    model.SchoolNO = context.Request["SchoolNO"].ToString();
                }
                if (context.Request["Sex"] != null)
                {
                    model.Sex = Convert.ToByte(context.Request["Sex"].ToString());
                }
                if (context.Request["Birthday"] != null)
                {
                    model.Birthday = Convert.ToDateTime(context.Request["Birthday"].ToString());
                    model.Age = Convert.ToByte(CalculateAge(DateTime.Now, Convert.ToDateTime(context.Request["Birthday"].ToString())));
                }
                if (context.Request["Photo"] != null)
                {
                    model.Photo = context.Request["Photo"].ToString();
                }
                if (context.Request["Address"] != null)
                {
                    model.Address = context.Request["Address"].ToString();
                }
                if (context.Request["Phone"] != null)
                {
                    model.Phone = context.Request["Phone"].ToString();
                }
                if (context.Request["Nickname"] != null)
                {
                    model.Nickname = context.Request["Nickname"].ToString();
                }
                if (context.Request["Password"] != null)
                {
                    model.Password = EncryptHelper.Md5By32(context.Request["Password"].ToString());
                }
                if (context.Request["Remarks"] != null)
                {
                    model.Remarks = context.Request["Remarks"].ToString();
                }
                model.IsDelete = 0;
                jsonModel = BLL.Add(model);

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
                return;
            }
        }
        /// <summary>
        /// 计算年龄
        /// </summary>
        public int CalculateAge(DateTime NowTime, DateTime BirthDate)
        {
            try
            {
                DateTime Age = new DateTime((NowTime - BirthDate).Ticks);
                return Age.Year;
            }
            catch (Exception)
            {

                return 0;
            }
            
        }

        /// <summary>
        /// 获得学生数据
        /// </summary>
        /// <param name="context"></param>
        public void GetStudentById(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();

                //获取参数值
                if (context.Request["SystemKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                }
                if (context.Request["InfKey"] != null)
                {
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    ht.Add("Id", context.Request["Id"].ToString());
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 3,
                        errMsg = "loss",
                        retData = ""
                    };
                    return;
                }

                ht.Add("func", "GetStudentById");
                jsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jsonModel.errNum != 0)
                {
                    return;
                }
                jsonModel = BLL.GetEntityById(Convert.ToInt32(ht["Id"].ToString()));
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
                return;
            }
        }

        /// <summary>
        /// 修改学生
        /// </summary>
        /// <param name="context"></param>
        public void UpdateStudent(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();

                //获取参数值
                if (context.Request["SystemKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                }
                if (context.Request["InfKey"] != null)
                {
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                ht.Add("func", "UpdateStudent");
                jsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jsonModel.errNum != 0)
                {
                    return;
                }
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    ht.Add("Id", context.Request["Id"].ToString());
                }
                SMModel.Plat_Student model = new Plat_Student();
                JsonModel JsonModel1 = BLL.GetEntityById(Convert.ToInt32(ht["Id"].ToString()));
                if (JsonModel1.errNum != 0)
                {
                    jsonModel = JsonModel1;
                    return;
                }
                model = (Plat_Student)(JsonModel1.retData);
                if (context.Request["Name"] != null)
                {
                    model.Name = context.Request["Name"].ToString();
                }
                if (context.Request["IDCard"] != null)
                {
                    model.IDCard = context.Request["IDCard"].ToString();
                }
                if (context.Request["LoginName"] != null)
                {
                    model.LoginName = context.Request["LoginName"].ToString();
                }
                if (context.Request["SchoolID"] != null)
                {
                    model.SchoolID = Convert.ToInt32(context.Request["SchoolID"].ToString());
                }
                if (context.Request["State"] != null)
                {
                    model.State = Convert.ToByte(context.Request["State"].ToString());
                }
                if (context.Request["SchoolNO"] != null)
                {
                    model.SchoolNO = context.Request["SchoolNO"].ToString();
                }
                if (context.Request["Sex"] != null)
                {
                    model.Sex = Convert.ToByte(context.Request["Sex"].ToString());
                }
                if (context.Request["Birthday"] != null)
                {
                    model.Birthday = Convert.ToDateTime(context.Request["Birthday"].ToString());
                    model.Age = Convert.ToByte(CalculateAge(DateTime.Now, Convert.ToDateTime(context.Request["Birthday"].ToString())));
                }
                if (context.Request["Photo"] != null)
                {
                    model.Photo = context.Request["Photo"].ToString();
                }
                if (context.Request["Address"] != null)
                {
                    model.Address = context.Request["Address"].ToString();
                }
                if (context.Request["Phone"] != null)
                {
                    model.Phone = context.Request["Phone"].ToString();
                }
                if (context.Request["Nickname"] != null)
                {
                    model.Nickname = context.Request["Nickname"].ToString();
                }
                //if (!string.IsNullOrWhiteSpace(context.Request["Password"]))
                //{
                //    model.Password = EncryptHelper.Md5By32(context.Request["Password"].ToString());
                //}
                if (context.Request["Remarks"] != null)
                {
                    model.Remarks = context.Request["Remarks"].ToString();
                }
                if (context.Request["Email"] != null)
                {
                    model.Email = context.Request["Email"].ToString();
                }
                if (context.Request["fixPhone"] != null)
                {
                    model.fixPhone = context.Request["fixPhone"].ToString();
                }
                model.UpdateTime = DateTime.Now;
                jsonModel = BLL.Update(model);
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
                return;
            }
        }

        //public JsonModel GetData(Hashtable ht)
        //{
        //    JsonModel JsonModel;
        //    try
        //    {

        //        string Columns = "";
        //        JsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["IdKey"].ToString(), ht["func"].ToString());
        //        if (JsonModel.errNum != 0)
        //        {
        //            return JsonModel;
        //        }
        //        Columns = JsonModel.retData.ToString();
                
        //        string SQL = " select " + Columns + " from " + ht["TableName"].ToString() + " where 1=1 ";

        //        if (ht.Contains("Where"))
        //        {
        //            SQL += ht["Where"].ToString();
        //        }
        //        if (ht.Contains("order"))
        //        {
        //            SQL += " order by " + ht["order"].ToString();
        //        }
        //        DataTable dt = SQLHelp.ExecuteDataTable(SQL, CommandType.Text);
        //        jsonModel.retData = com.DataTableToList(dt);
        //        return jsonModel;
        //    }
        //    catch (Exception ex)
        //    {

        //        jsonModel = new JsonModel()
        //        {
        //            errNum = 400,
        //            errMsg = ex.Message,
        //            retData = ""
        //        };
        //        LogService.WriteErrorLog(ex.Message);
        //        return jsonModel;
        //    }
        //}

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        /// <summary>
        /// 学生加入班级
        /// </summary>
        /// <param name="context"></param>
        public void JoinClass(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();
                //获取参数值
                if (context.Request["SystemKey"] != null && context.Request["InfKey"] != null
                    && context.Request["IDCards"] != null && context.Request["ClassID"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                    ht.Add("IDCards", context.Request["IDCards"].ToString());
                    ht.Add("ClassID", context.Request["ClassID"].ToString());
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 3,
                        errMsg ="参数不完整",
                        retData = ""
                    };
                    return;
                }
                ht.Add("func", "JoinClass");
                jsonModel = BLL.JoinClass(ht);
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
                return;
            }
        }

        /// <summary>
        /// 获得同班同学信息
        /// </summary>
        /// <param name="context"></param>
        public void GetClassStudent(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();
                //获取参数值
                if (context.Request["SystemKey"] != null && context.Request["InfKey"] != null
                    && context.Request["IDCard"] != null )
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                    ht.Add("IDCard", context.Request["IDCard"].ToString());
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 3,
                        errMsg = "参数不完整",
                        retData = ""
                    };
                    return;
                }
                ht.Add("func", "GetClassStudent");
                jsonModel = BLL.GetClassStudent(ht);
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
                return;
            }
        }
        /// <summary>
        /// 获得教师所教的所有学生
        /// </summary>
        /// <param name="context"></param>
        public void GetStudentByTeacher(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();
                //获取参数值
                if (context.Request["SystemKey"] != null && context.Request["InfKey"] != null
                    && context.Request["TeacherIDCard"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                    ht.Add("TeacherIDCard", context.Request["TeacherIDCard"].ToString());
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 3,
                        errMsg = "参数不完整",
                        retData = ""
                    };
                    return;
                }
                ht.Add("func", "GetStudentByTeacher");
                jsonModel = BLL.GetStudentByTeacher(ht);
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
                return;
            }
        }

        #region Excel导入学生信息
        /// <summary>
        /// 上传Excel学生信息
        /// </summary>
        /// <param name="context"></param>
        public void UploadStudentExcel(HttpContext context)
        {
            try
            {
                //string name = context.Request.Files[0].FileName;
                //Stream filestream = context.Request.Files[0].InputStream;
                //string UploadPath = context.Server.MapPath(System.Configuration.ConfigurationManager.ConnectionStrings["ImagePath"].ToString());
                string UploadPath = context.Server.MapPath("/UploadFile");
                //string ImageName = context.Request["ImageName"].ToString();
                string ImageName = "StudentInfo.xlsx";
                HttpFileCollection files = context.Request.Files;
                if (files == null || files.Count == 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "没有文件！",
                        retData = ""
                    };
                    return;
                }
                //1.获取文件信息
                var fileToUpload = files[0];
                //if (fileToUpload.ContentLength > 2097152)
                //{
                //    jsonModel = new JsonModel()
                //    {
                //        errNum = 1,
                //        errMsg = "大小不成超过2M！",
                //        retData = ""
                //    };
                //    return;
                //}
                //判断文件目录是否存在
                if (!Directory.Exists(UploadPath))
                {
                    Directory.CreateDirectory(UploadPath);
                }
                string FilePath = UploadPath + "\\" + ImageName;
                fileToUpload.SaveAs(FilePath);
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "上传成功",
                    retData = FilePath
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
                return;
            }
        }

        /// <summary>
        /// 导入Excel学生信息
        /// </summary>
        /// <param name="context"></param>
        public void ImportStudent(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                if (context.Request["SystemKey"] != null && context.Request["InfKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 3,
                        errMsg = "缺少key",
                        retData = ""
                    };
                    return;
                }
                if (context.Request["FilePath"] != null)
                {
                    ht.Add("FilePath", context.Request["FilePath"].ToString());
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 3,
                        errMsg = "缺少文件路径",
                        retData = ""
                    };
                    return;
                }
                jsonModel = BLL.ImportTeacher(ht);
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
                return;
            }
        }

        #endregion
    }
}