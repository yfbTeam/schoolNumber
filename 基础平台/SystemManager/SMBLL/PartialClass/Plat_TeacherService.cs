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
    public partial class Plat_TeacherService : BaseService<Plat_Teacher>, IPlat_TeacherService
    {
        SMDAL.Base_TeacherDal DAL = new SMDAL.Base_TeacherDal();
        BLLCommon common = new BLLCommon();
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

        public JsonModel ValidataIsExist(Hashtable ht) 
        {
            DataTable dt = new DataTable();
            dt.TableName = "ds";
            int result = DAL.ValidataIsExist(ht,ref dt);
            List<string> list = new List<string>();
            list.Add(common.DataTableToJson(dt));
            JsonModel jsonModel = new JsonModel();
            if (result > 0)
            {
                jsonModel.status = "ok";
                jsonModel.retData = list;
                jsonModel.errMsg = "操作成功";
            }
            else
            {
                jsonModel.status = "no";
                jsonModel.retData = list;
                jsonModel.errMsg = "操作失败";
            }
            return jsonModel;
        }

        public JsonModel Register(Hashtable ht) 
        {
            try
            {
                int result = DAL.Register(ht);
                //定义JSON标准格式实体中
                JsonModel jsonModel = new JsonModel();
                if (result > 0)
                {
                    jsonModel.status = "ok";
                    jsonModel.errMsg = "操作成功";
                }
                else
                {
                    jsonModel.status = "no";
                    jsonModel.errMsg = "操作失败";
                }
                return jsonModel;
            }
            catch (Exception ex)
            {
                JsonModel jsonModel = new JsonModel();
                jsonModel.status = "error";
                jsonModel.errMsg = ex.ToString();
                return jsonModel;
            }
        }

        public JsonModel GetGradeAndClassById(Hashtable ht)
        {
            try
            {
                DataTable modList = DAL.GetGradeAndClassById(ht);
                //定义JSON标准格式实体中
                JsonModel jsonModel = null;
                if (modList.Rows.Count <= 0)
                {
                    jsonModel = new JsonModel()
                    {
                        status = "no",
                        errMsg = "无数据"
                    };
                    return jsonModel;
                }
                List<string> list = new List<string>();
                list.Add(new BLLCommon().DataTableToJson(modList));
                jsonModel = new JsonModel()
                {
                    retData = list,
                    errMsg = "",
                    status = "ok"
                };
                return jsonModel;
            }
            catch (Exception ex)
            {
                JsonModel jsonModel = new JsonModel();
                jsonModel.status = "error";
                jsonModel.retData = ex.ToString();
                return jsonModel;
            }
        }

        /// <summary>
        /// 获得可分配为班主任的教师
        /// </summary>
        /// <param name="context"></param>
        public JsonModel GetNotHeadTeacher(Hashtable ht)
        {
            try
            {
                JsonModel jm = common.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jm.errNum != 0)
                {
                    return jm;
                }
                DataTable dt = DAL.GetNotHeadTeacher(ht["SchoolID"].ToString(), jm.retData.ToString());
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
                        retData = common.DataTableToList(dt)
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
        /// 读取Excel导入数据--教师
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
                        bool CunZai = DAL.IsExistTeacherBySchool(dr["身份证号"].ToString().Trim().Substring(1), dr["学校ID"].ToString().Trim());
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
                            SMModel.Plat_Teacher modelTeacher = new Plat_Teacher();
                            modelTeacher.IDCard = dr["身份证号"].ToString().Trim().Substring(1);//登录名
                            modelTeacher.LoginName = dr["登录账号"].ToString().Trim();//登录账号
                            modelTeacher.SchoolID = Convert.ToInt32(dr["学校ID"].ToString().Trim());//学校ID
                            modelTeacher.Password = common.Md5Encrypting(Password);//密码
                            modelTeacher.State = Convert.ToByte(dr["状态"].ToString().Trim());//状态
                            //modelTeacher.Creator = "00000000000000000X";//创建人
                            modelTeacher.JobNumber = dr["工号"].ToString().Trim();//工号
                            modelTeacher.Name = dr["姓名"].ToString().Trim();//姓名
                            if (dr["性别"].ToString().Trim() == "男")
                            {
                                modelTeacher.Sex = 0;//性别
                            }
                            else
                            {
                                modelTeacher.Sex = 1;//性别
                            }
                            //modelTeacher.Birthday = Convert.ToDateTime(dr["出生日期"].ToString().Trim());//出生日期
                            modelTeacher.Address = dr["家庭住址"].ToString().Trim();//家庭住址
                            modelTeacher.Phone = dr["电话"].ToString().Trim();//电话
                            modelTeacher.Remarks = dr["备注"].ToString().Trim();//备注
                            modelTeacher.Nickname = dr["昵称"].ToString().Trim();//昵称
                            modelTeacher.Email = dr["邮箱"].ToString().Trim();//邮箱
                            modelTeacher.BriefIntroduction = dr["简介"].ToString().Trim();//简介
                            modelTeacher.IsDelete = 0;//是否删除
                            JsonModel jsonModel = Add(modelTeacher);
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
