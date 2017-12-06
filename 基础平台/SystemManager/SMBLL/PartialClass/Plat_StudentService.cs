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
    public partial class Plat_StudentService : BaseService<Plat_Student>, IPlat_StudentService
    {
        SMDAL.Plat_StudentDal DAL = new SMDAL.Plat_StudentDal();
        BLLCommon com = new BLLCommon();
        /// <summary>
        /// 验证账号密码
        /// </summary>
        /// <param name="LoginName">登录账号</param>
        /// <param name="Password">密码</param>
        /// <returns></returns>
        public DataTable ValidationUser(string LoginName, string Password)
        {
            return DAL.ValidationUser(LoginName, Password);
        }

        /// <summary>
        /// 注册
        /// </summary>
        /// <param name="context"></param>
        public JsonModel Register(Hashtable ht)
        {
            SMDAL.Plat_StudentDal dal = new SMDAL.Plat_StudentDal();
            SMModel.Plat_Student model = new Plat_Student();
            model.IDCard = ht["IDCard"].ToString();
            
            model.LoginName = ht["LoginName"].ToString();
            if (dal.IsNameExists(new SMModel.Plat_Student(), "", model.LoginName, 0, "LoginName", false)
                || new SMDAL.Plat_TeacherDal().IsNameExists(new SMModel.Plat_Teacher(), "", model.LoginName, 0, "LoginName", false))
            {
                JsonModel jsonModel = new JsonModel()
                {
                    errNum = 1,
                    errMsg = "登录名已存在",
                    retData = ""
                };
                return jsonModel;
            }

            model.Password = EncryptHelper.Md5By32(ht["Password"].ToString());
            SMDAL.Plat_SystemInfoDal dalSystem = new SMDAL.Plat_SystemInfoDal();
            DataTable dt = dalSystem.GetSystemByKey(ht["SystemKey"].ToString());
            if (dt == null || dt.Rows.Count == 0)
            {
                JsonModel jsonModel = new JsonModel()
                {
                    errNum = 1,
                    errMsg = "系统不存在",
                    retData = ""
                };
                return jsonModel; 
            }
            model.SchoolID = Convert.ToInt32(dt.Rows[0]["SchoolID"].ToString());
            model.State = 0;
            model.Name = ht["Name"].ToString();
            if (ht["Sex"].ToString() == "女")
            {
                model.Sex = 1;
            }
            else
            {
                model.Sex = 0;
            }
            model.Nickname = ht["Nickname"].ToString();
            model.Email = ht["Email"].ToString();
            model.Address = ht["Address"].ToString();
            model.Phone = ht["Phone"].ToString();
            model.IsDelete = 0;
            if (dal.IsNameExists(new SMModel.Plat_Student(), "", model.IDCard, 0, "IDCard", false))
            {
                JsonModel jsonModel = new JsonModel()
                {
                    errNum = 1,
                    errMsg = "已注册账号，不能重复注册",
                    retData = ""
                };
                return jsonModel; 
            }
            return Add(model);
        }

        /// <summary>
        /// 加入班级
        /// </summary>
        /// <param name="context"></param>
        public JsonModel JoinClass(Hashtable ht)
        {
            JsonModel jm = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
            if (jm.errNum != 0)
            {
                return jm;
            }
            int count = DAL.JoinClass(ht["ClassID"].ToString(), ht["IDCards"].ToString());
            if (count > 0)
            {
                JsonModel jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "成功",
                    retData = ""
                };
                return jsonModel;
            }
            else
            {
                JsonModel jsonModel = new JsonModel()
                {
                    errNum = 1,
                    errMsg = "失败",
                    retData = ""
                };
                return jsonModel;
            }
        }

        /// <summary>
        /// 获得同班同学信息
        /// </summary>
        /// <param name="context"></param>
        public JsonModel GetClassStudent(Hashtable ht)
        {
            try
            {
                JsonModel jm = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jm.errNum != 0)
                {
                    return jm;
                }
                DataTable dt = DAL.GetClassStudent(ht["IDCard"].ToString());
                JsonModel jsonModel;
                if (dt == null)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "失败",
                        retData = ""
                    };
                    return jsonModel;
                }
                if (dt.Rows.Count == 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                    return jsonModel;
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "成功",
                        retData = com.DataTableToList(dt)
                    };
                    return jsonModel;
                }
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.ToString());
                JsonModel jsonModel = new JsonModel()
                {
                    errNum = 1,
                    errMsg = "失败",
                    retData = ""
                };
                return jsonModel;
            }
            
        }

        /// <summary>
        /// 获得教师所教的所有学生
        /// </summary>
        /// <param name="context"></param>
        public JsonModel GetStudentByTeacher(Hashtable ht)
        {
            try
            {
                JsonModel jm = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jm.errNum != 0)
                {
                    return jm;
                }
                DataTable dt = DAL.GetStudentByTeacher(ht["TeacherIDCard"].ToString());
                JsonModel jsonModel;
                if (dt == null)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "失败",
                        retData = ""
                    };
                    return jsonModel;
                }
                if (dt.Rows.Count == 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                    return jsonModel;
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "成功",
                        retData = com.DataTableToList(dt)
                    };
                    return jsonModel;
                }
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.ToString());
                JsonModel jsonModel = new JsonModel()
                {
                    errNum = 1,
                    errMsg = "失败",
                    retData = ""
                };
                return jsonModel;
            }

        }

        /// <summary>
        /// 读取Excel导入数据--学生
        /// </summary>
        /// <param name="ht">参数</param>
        /// <returns></returns>
        public JsonModel ImportTeacher(Hashtable ht)
        {
            try
            {
                BLLCommon common = new BLLCommon();
                DataTable dt = common.ExcelToDataTable(ht["FilePath"].ToString());

                int Yse = 0;
                int No = 0;
                StringBuilder sb = new StringBuilder();


                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DataRow dr = dt.Rows[i];
                    try
                    {
                        if (string.IsNullOrWhiteSpace(dr["身份证号"].ToString().Trim()) && string.IsNullOrWhiteSpace(dr["姓名"].ToString().Trim()))
                        {
                            continue;
                        }




                        Hashtable htCunZai = new Hashtable();
                        htCunZai.Add("IDCard", dr["身份证号"].ToString().Trim());
                        bool CunZai = DAL.IsExistStudentBySchool(dr["身份证号"].ToString().Trim().Substring(1), dr["学校ID"].ToString().Trim());
                        //bool CunZai = false;
                        int Id = 0;
                        if (CunZai)
                        {
                            //存在
                            continue;
                        }
                        else
                        {
                            string Password = "pwd@123";
                            //不存在添加
                            SMModel.Plat_Student modelStudent = new Plat_Student();
                            modelStudent.IDCard = dr["身份证号"].ToString().Trim().Substring(1);//登录名
                            modelStudent.LoginName = dr["登录账号"].ToString().Trim();//登录账号
                            modelStudent.SchoolID = Convert.ToInt32(dr["学校ID"].ToString().Trim());//学校ID
                            modelStudent.Password = common.Md5Encrypting(Password);//密码
                            modelStudent.State = Convert.ToByte(dr["状态"].ToString().Trim());//状态
                            //modelTeacher.Creator = "00000000000000000X";//创建人
                            modelStudent.SchoolNO = dr["学号"].ToString().Trim();//学号
                            modelStudent.Name = dr["姓名"].ToString().Trim();//姓名
                            if (dr["性别"].ToString().Trim() == "男")
                            {
                                modelStudent.Sex = 0;//性别
                            }
                            else
                            {
                                modelStudent.Sex = 1;//性别
                            }
                            //modelTeacher.Birthday = Convert.ToDateTime(dr["出生日期"].ToString().Trim());//出生日期
                            modelStudent.Address = dr["家庭住址"].ToString().Trim();//家庭住址
                            modelStudent.Phone = dr["电话"].ToString().Trim();//电话
                            modelStudent.Remarks = dr["备注"].ToString().Trim();//备注
                            modelStudent.Nickname = dr["昵称"].ToString().Trim();//昵称
                            modelStudent.Email = dr["邮箱"].ToString().Trim();//邮箱
                            modelStudent.fixPhone = dr["固定电话"].ToString().Trim();//固定电话
                            modelStudent.IsDelete = 0;//是否删除
                            JsonModel jsonModel = Add(modelStudent);
                            Id = Convert.ToInt32(jsonModel.retData);

                            #region 事物添加教师账号、账号权限

                            ////事务
                            //using (SqlTransaction trans = dal.GetTran())
                            //{
                            //    Id = dal.Add(trans, model);
                            //    if (Id > 0)
                            //    {
                            //        //添加用户权限
                            //        bool RoleOfUserIDBool = true;
                            //        foreach (EmsModel.RoleOfUser ModelRoleOfUser in ListRoleOfUser)
                            //        {
                            //            int ModelRoleOfUserID = DALRoleOfUser.Add(trans, ModelRoleOfUser);
                            //            if (ModelRoleOfUserID <= 0)
                            //            {
                            //                RoleOfUserIDBool = false;
                            //                break;
                            //            }
                            //        }
                            //        if (RoleOfUserIDBool)
                            //        {
                            //            trans.Commit();
                            //        }
                            //        else
                            //        {
                            //            Id = 0;
                            //            trans.Rollback();
                            //        }
                            //    }
                            //    else
                            //    {
                            //        Id = 0;
                            //        trans.Rollback();
                            //    }
                            //}

                            #endregion
                        }
                        if (Id > 0)
                        {
                            Yse++;
                        }
                        else
                        {
                            No++;
                            sb.Append((i + 1).ToString() + ",");
                        }
                    }
                    catch (Exception)
                    {
                        No++;
                        sb.Append((i + 1).ToString() + ",");
                    }
                }

                JsonModel returnJM = new JsonModel();
                returnJM.errNum = 0;
                //jsonModel.Msg = "成功" + Yse + "条，失败" + No + "条，共" + dt.Rows.Count + "条";
                returnJM.errMsg = "成功" + Yse + "条，失败" + No + "条";
                if (sb.Length != 0)
                {
                    returnJM.errMsg += "\n失败数据行号：" + sb.ToString();
                }
                return returnJM;
            }
            catch (Exception ex)
            {
                JsonModel jsonModel = new JsonModel();
                jsonModel.errNum = 400;
                jsonModel.errMsg = ex.ToString();
                return jsonModel;
            }
        }
        /// <summary>
        /// 修改密码
        /// </summary>
        /// <param name="LoginName">登录账号</param>
        /// <param name="NewPassword">新密码</param>
        /// <returns></returns>
        public bool UpdatePassword(string LoginName, string NewPassword)
        {

            return DAL.UpdatePassword(LoginName, NewPassword);
        }
    }
}
