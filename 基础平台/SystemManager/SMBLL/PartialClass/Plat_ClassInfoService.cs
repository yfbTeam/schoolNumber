using SMIBLL;
using SMModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMBLL
{
    public partial class Plat_ClassInfoService : BaseService<Plat_ClassInfo>, IPlat_ClassInfoService
    {
        SMDAL.Base_ClassInfoDal DAL = new SMDAL.Base_ClassInfoDal();
        BLLCommon com = new BLLCommon();

        /// <summary>
        /// 师生名单
        /// </summary>
        /// <returns></returns>
        public JsonModel GetNameList(Hashtable ht)
        {
            JsonModel jsonModel;
            try
            {
                jsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jsonModel.errNum != 0)
                {
                    return jsonModel;
                }
                SMDAL.Base_TeacherDal dalTeacher = new SMDAL.Base_TeacherDal();
                SMDAL.Plat_StudentDal dalstudent = new SMDAL.Plat_StudentDal();
                DataTable dtClass = DAL.GetNameList(ht["GradeID"].ToString(), ht["SystemKey"].ToString());
                if (dtClass != null && dtClass.Rows.Count > 0)
                {
                    List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                    foreach (DataRow dr in dtClass.Rows)
                    {
                        Dictionary<string, object> dic = new Dictionary<string, object>();
                        dic.Add("ClassName", dr["ClassName"].ToString());
                        dic.Add("Headteacher", "");
                        DataTable dtHeadTeacher = dalTeacher.GetTeacherByIDCard(dr["HeadteacherNO"].ToString());
                        if (dtHeadTeacher != null && dtHeadTeacher.Rows.Count > 0)
                        {
                            dic["Headteacher"] = dtHeadTeacher.Rows[0]["Name"].ToString();
                        }
                        dic.Add("Teacher", "");
                        DataTable dtTeacher = dalTeacher.GetClassTeacher(dr["Id"].ToString());
                        if (dtTeacher != null && dtTeacher.Rows.Count > 0)
                        {
                            foreach (DataRow drTea in dtTeacher.Rows)
                            {
                                dic["Teacher"] += drTea["Name"].ToString() + " ";
                            }
                        }
                        dic.Add("Student", "");
                        DataTable dtStudent = dalstudent.GetStudentByClass(dr["Id"].ToString());
                        if (dtStudent != null && dtStudent.Rows.Count > 0)
                        {
                            foreach (DataRow drStu in dtStudent.Rows)
                            {
                                dic["Student"] += drStu["Name"].ToString()+" ";
                            }
                        }
                        list.Add(dic);
                    }
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "成功",
                        retData = list
                    };
                    return jsonModel;
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "没有数据",
                        retData = ""
                    };
                    return jsonModel;
                }
                
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.ToString(),
                    retData = ""
                };
                return jsonModel;
            }
            
        }

    }
}
