using SMDAL;
using SMIBLL;
using SMModel;
using SMUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMBLL
{
    public partial class Plat_SystemInfoService : BaseService<Plat_SystemInfo>, IPlat_SystemInfoService
    {
        Plat_SystemInfoDal dal = new Plat_SystemInfoDal();
        #region 根据学校id判断该学校是否已存在同名系统
        /// <summary>
        /// 根据学校id判断该学校是否已存在同名系统
        /// </summary>
        /// <param name="schoolid">学校id</param>
        /// <param name="sysname">系统名称</param>
        /// <param name="Id">系统id</param>
        /// <returns></returns>
        public JsonModel IsSchoolSysExists(int schoolid,string sysname, Int32 Id = 0)
        {
            JsonModel jsonModel = null;
            try
            {
                bool result = dal.IsSchoolSysExists(schoolid, sysname, Id);
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = result
                };
                return jsonModel;
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }
        #endregion

        #region 添加系统
        /// <summary>
        /// 添加系统
        /// </summary>
        /// <param name="system">系统实体</param>
        /// <returns></returns>
        public JsonModel AddSystem(Plat_SystemInfo system)
        {
            //定义JSON标准格式实体中
            JsonModel jsonModel = new JsonModel();
            try
            {
                //事务
                using (SqlTransaction trans = dal.GetTran())
                {
                    try
                    {
                        int result=dal.Add(system,trans);
                        if (result <= 0)
                        {
                            trans.Rollback();//回滚
                            jsonModel = new JsonModel()
                            {
                                errNum = 1,
                                errMsg = "fial",
                                retData = "操作失败"
                            };
                            return jsonModel;
                        }
                        Plat_Role role = new Plat_Role();
                        role.SystemKey = system.SystemKey;
                        role.Name = "超级管理员";
                        role.Creator = "";
                        role.CreateTime = DateTime.Now;
                        role.IsDelete = 0;
                        int roleid = new Plat_RoleDal().Add(role, trans);
                        if (roleid <= 0)
                        {
                            trans.Rollback();//回滚
                            jsonModel = new JsonModel()
                            {
                                errNum = 1,
                                errMsg = "fial",
                                retData = "操作失败"
                            };
                            return jsonModel;
                        }
                        Plat_Teacher ter = new Plat_Teacher();                        
                        ter.IDCard="00000000000000000X";
                        ter.LoginName = "admin";
                        ter.SystemKey = system.SystemKey;
                        ter.State = 0;
                        ter.Name = "超级管理员";
                        ter.Password = "pwd@123";
                        int terid = new Plat_TeacherDal().Add(ter, trans);
                        if (terid <= 0)
                        {
                            trans.Rollback();//回滚
                            jsonModel = new JsonModel()
                            {
                                errNum = 1,
                                errMsg = "fial",
                                retData = "操作失败"
                            };
                            return jsonModel;
                        }
                        Plat_RoleOfUser rou = new Plat_RoleOfUser();
                        rou.RoleId = roleid;
                        rou.UserIDCard = ter.IDCard;
                        int rouid = new Plat_RoleOfUserDal().Add(rou);
                        if (terid <= 0)
                        {
                            trans.Rollback();//回滚
                            jsonModel = new JsonModel()
                            {
                                errNum = 1,
                                errMsg = "fial",
                                retData = "操作失败"
                            };
                            return jsonModel;
                        }
                       trans.Commit();//提交
                    }
                    catch (Exception)
                    {
                        trans.Rollback();//回滚
                        throw;
                    }
                }
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = "操作成功"
                };
                return jsonModel;
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }
        #endregion

        public JsonModel GetSystemAndSchoolBySysId(Hashtable ht)
        {
            try
            {
                DataTable modList = dal.GetSystemAndSchoolBySysId(ht);
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
    }
}
