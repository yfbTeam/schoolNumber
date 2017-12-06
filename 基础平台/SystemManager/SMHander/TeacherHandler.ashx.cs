using SMBLL;
using SMModel;
using SMSUtility;
using SMUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Script.Serialization;

namespace SMHander
{
    /// <summary>
    /// TeacherHandler 的摘要说明
    /// </summary>
    public class TeacherHandler : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        SMBLL.Plat_LogInfoService log = new SMBLL.Plat_LogInfoService();
        JsonModel jsonModel = null;
        BLLCommon com = new SMBLL.BLLCommon();
        SMBLL.Plat_TeacherService BLL = new Plat_TeacherService();
        public void ProcessRequest(HttpContext context)
        {
            string func = context.Request["func"] ?? "";
            try
            {
                switch (func)
                {
                    case "GetTeacherData":
                        GetTeacherData(context);
                        break;
                    case "GetTeacherPageData":
                        GetTeacherPageData(context);
                        break;
                    case "DeleteTeacher":
                        DeleteTeacher(context);
                        break;
                    case "AddTeacher":
                        AddTeacher(context);
                        break;
                    case "GetTeacherById":
                        GetTeacherById(context);
                        break;
                    case "UpdateTeacher":
                        UpdateTeacher(context);
                        break;
                    case "GetTeacherByStudent":
                        GetTeacherByStudent(context);
                        break;
                    case "GetTeacherClassSubject":
                        GetTeacherClassSubject(context);
                        break;
                    case "GetSchoolTeacherByT":
                        GetSchoolTeacherByT(context);
                        break;
                    case "GetNotHeadTeacher":
                        GetNotHeadTeacher(context);
                        break;
                    case "ImportTeacher":
                        ImportTeacher(context);
                        break;
                    case "UploadTeacherExcel":
                        UploadTeacherExcel(context);
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
        /// 获得教师数据
        /// </summary>
        /// <param name="context"></param>
        public void GetTeacherData(HttpContext context)
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

                sb.Append(" and a.IsDelete=0 and a.IDCard <> '00000000000000000X'");
                ht.Add("Where", sb.ToString());
                ht.Add("TableName", "Plat_Teacher a left join Plat_School b on a.SchoolID=b.Id ");

                string PhotoURL = System.Configuration.ConfigurationManager.ConnectionStrings["PhotoURL"].ToString();

                ht.Add("Columns", "a.*,b.Name as SchoolName,'" + PhotoURL + "'+a.Photo as PhotoURL");
                ht.Add("func", "GetTeacherData");
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
        /// 获得教师分页数据
        /// </summary>
        /// <param name="context"></param>
        public void GetTeacherPageData(HttpContext context)
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
                sb.Append(" and IsDelete=0 and IDCard <> '00000000000000000X'");
                ht.Add("func", "GetTeacherPageData");
                ht.Add("Columns", "*");
                ht.Add("TableName", "Plat_Teacher");
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
        public void DeleteTeacher(HttpContext context)
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

                ht.Add("func", "DeleteTeacher");
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
        /// 新增学校
        /// </summary>
        /// <param name="context"></param>
        public void AddTeacher(HttpContext context)
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
                ht.Add("func", "AddTeacher");
                jsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jsonModel.errNum != 0)
                {
                    return;
                }
                SMModel.Plat_Teacher model = new Plat_Teacher();
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
                if (context.Request["JobNumber"] != null)
                {
                    model.JobNumber = context.Request["JobNumber"].ToString();
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
        /// 获得教师数据
        /// </summary>
        /// <param name="context"></param>
        public void GetTeacherById(HttpContext context)
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

                ht.Add("func", "GetTeacherById");
                jsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jsonModel.errNum != 0)
                {
                    return;
                }
                //jsonModel = com.GetData3(ht);
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
        /// 修改学校
        /// </summary>
        /// <param name="context"></param>
        public void UpdateTeacher(HttpContext context)
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
                ht.Add("func", "UpdateTeacher");
                jsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jsonModel.errNum != 0)
                {
                    return;
                }
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    ht.Add("Id", context.Request["Id"].ToString());
                }
                SMModel.Plat_Teacher model = new Plat_Teacher();
                JsonModel JsonModel1 = BLL.GetEntityById(Convert.ToInt32(ht["Id"].ToString()));
                if (JsonModel1.errNum != 0)
                {
                    jsonModel = JsonModel1;
                    return;
                }
                model = (Plat_Teacher)(JsonModel1.retData);
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
                if (context.Request["JobNumber"] != null)
                {
                    model.JobNumber = context.Request["JobNumber"].ToString();
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
                if (!string.IsNullOrWhiteSpace(context.Request["Password"]))
                {
                    model.Password = EncryptHelper.Md5By32(context.Request["Password"].ToString());
                }
                if (context.Request["Remarks"] != null)
                {
                    model.Remarks = context.Request["Remarks"].ToString();
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
        /// 根据学生获得学生所在学校的所有老师的信息
        /// 门户--师资力量
        /// </summary>
        /// <param name="context"></param>
        public void GetTeacherByStudent(HttpContext context)
        {
            try
            {
                
                
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();
                bool Pageing = false;//不分页
                //获取参数值
                if (context.Request["SystemKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                }
                if (context.Request["InfKey"] != null)
                {
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                if (context.Request["PageIndex"] != null && context.Request["PageSize"] != null)
                {
                    ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                    ht.Add("PageSize", context.Request["PageSize"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["StudentIDCard"]))
                {
                    //ht.Add("StudentIDCard", context.Request["StudentIDCard"].ToString());
                    sb.Append(" and SchoolID=(select SchoolID from Plat_Student where IDCard='" + context.Request["StudentIDCard"].ToString() + "')");
                }
                if (context.Request["Pageing"] != null)
                {
                    Pageing = Convert.ToBoolean(context.Request["Pageing"].ToString());
                }
                sb.Append(" and IsDelete=0 and IDCard <> '00000000000000000X'");
                ht.Add("Where", sb.ToString());
                ht.Add("TableName", "Plat_Teacher");

                string PhotoURL = System.Configuration.ConfigurationManager.ConnectionStrings["PhotoURL"].ToString();

                ht.Add("Columns", "*,'" + PhotoURL + "'+Photo as PhotoURL");
                ht.Add("func", "GetTeacherByStudent");
                if (Pageing)
                {
                    jsonModel = com.GetPagingData(ht);
                }
                else
                {
                    jsonModel = com.GetData(ht);
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
                return;
            }
        }
        /// <summary>
        /// 根据老师获得老师所在学校的所有老师的信息
        /// 门户--师资力量
        /// </summary>
        /// <param name="context"></param>
        public void GetSchoolTeacherByT(HttpContext context)
        {
            try
            {

                bool Pageing = false;//不分页
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
                ht.Add("func", "GetSchoolTeacherByT");
                if (context.Request["PageIndex"] != null && context.Request["PageSize"] != null)
                {
                    ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                    ht.Add("PageSize", context.Request["PageSize"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["TeacherIDCard"]))
                {
                    //ht.Add("StudentIDCard", context.Request["StudentIDCard"].ToString());
                    sb.Append(" and SchoolID=(select SchoolID from Plat_Teacher where IDCard='" + context.Request["TeacherIDCard"].ToString() + "')");
                }

                sb.Append(" and IsDelete=0 and IDCard <> '00000000000000000X'");
                ht.Add("Where", sb.ToString());
                ht.Add("TableName", "Plat_Teacher");

                string PhotoURL = System.Configuration.ConfigurationManager.ConnectionStrings["PhotoURL"].ToString();

                ht.Add("Columns", "*,'" + PhotoURL + "'+Photo as PhotoURL");
                if (context.Request["Pageing"] != null)
                {
                    Pageing = Convert.ToBoolean(context.Request["Pageing"].ToString());
                }
                if (Pageing)
                {
                    jsonModel = com.GetPagingData(ht);
                }
                else
                {
                    jsonModel = com.GetData(ht);
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
                return;
            }
        }

        #region 老师所教班级和所教学科
        /// <summary>
        /// 老师所教班级和所教学科
        /// </summary>
        /// <param name="context"></param>
        public void GetTeacherClassSubject(HttpContext context)
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
                ht.Add("func", "GetTeacherClassSubject");

                if (context.Request["TeacherIDCard"] != null)
                {
                    //ht.Add("StudentIDCard", context.Request["StudentIDCard"].ToString());
                    sb.Append(" and TeacherIDCard='" + context.Request["TeacherIDCard"].ToString() + "'");
                }

                ht.Add("Where", sb.ToString());
                ht.Add("TableName", "Plat_TeacherOfClassOfSubject");

                ht.Add("Columns", "*");
                
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
        #endregion

        #region 获得可分配为班主任的教师
        /// <summary>
        /// 获得可分配为班主任的教师
        /// </summary>
        /// <param name="context"></param>
        public void GetNotHeadTeacher(HttpContext context)
        {
            try
            {


                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();
                //获取参数值
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
                ht.Add("func", "GetNotHeadTeacher");

                if (context.Request["SchoolID"] != null)
                {
                    ht.Add("SchoolID", context.Request["SchoolID"].ToString());
                }

                jsonModel = BLL.GetNotHeadTeacher(ht);
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

        #region Excel导入教师信息
        /// <summary>
        /// 上传Excel教师信息
        /// </summary>
        /// <param name="context"></param>
        public void UploadTeacherExcel(HttpContext context)
        {
            try
            {
                //string name = context.Request.Files[0].FileName;
                //Stream filestream = context.Request.Files[0].InputStream;
                //string UploadPath = context.Server.MapPath(System.Configuration.ConfigurationManager.ConnectionStrings["ImagePath"].ToString());
                //string UploadPath = "c:\\wyr\\UploadFile\\";
                string UploadPath = context.Server.MapPath("/UploadFile");
                //string ImageName = context.Request["ImageName"].ToString();
                string ImageName = "TeacherInfo.xlsx";
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
        /// 导入Excel教师信息
        /// </summary>
        /// <param name="context"></param>
        public void ImportTeacher(HttpContext context)
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
                if (context.Request["FilePath"] != null )
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