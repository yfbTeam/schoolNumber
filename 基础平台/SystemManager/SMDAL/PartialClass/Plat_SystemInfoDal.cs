using SMIDAL;
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

namespace SMDAL
{
    public partial class Plat_SystemInfoDal : BaseDal<Plat_SystemInfo>, IPlat_SystemInfoDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int rowCount, bool IsPage)
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            rowCount = 0;
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select si.*,sch.Name as SchoolName from Plat_SystemInfo si
                                    left join Plat_School sch on sch.Id=si.SchoolId
                                    where si.IsDelete=0  ");
                if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(ht["Name"].ToString()))
                {
                    sbSql4org.Append(" and si.SystemName like N'%'+@Name+'%' ");
                    pms.Add(new SqlParameter("@Name", ht["Name"].ToString()));
                }
                if (ht.ContainsKey("SchoolId") && !string.IsNullOrEmpty(ht["SchoolId"].ToString()))
                {
                    sbSql4org.Append(" and si.SchoolId=@SchoolId ");
                    pms.Add(new SqlParameter("@SchoolId", ht["SchoolId"].ToString()));
                }
                DataTable dt = SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", "", "", Convert.ToInt32(ht["StartIndex"].ToString()), Convert.ToInt32(ht["EndIndex"].ToString()), pms.ToArray(), out rowCount, IsPage);
                return dt;
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;                
                return null;
            }
        }


        #region 判断是否有访问系统方法的权限并返回字段
        /// <summary>
        /// 判断是否有访问系统方法的权限并返回字段
        /// </summary>  
        public string IsHasAuthority(string syskey, string indenkey, string func)
        {
            StringBuilder sbSql4org;
            List<SqlParameter> pms = new List<SqlParameter>();

            sbSql4org = new StringBuilder();
            sbSql4org.Append(@"select sir.ReturnField from Plat_SysOfInter_Rel sir
                     left join Plat_SysIndentify si on si.Id=sir.IndentifyId 
                     left join Plat_Interface inter on inter.Id=sir.InterfaceId  
                     where si.SystemKey=@SystemKey and si.InfKey=@InfKey and inter.Name=@InterfaceName ");
            pms.Add(new SqlParameter("@SystemKey", syskey));
            pms.Add(new SqlParameter("@InfKey", indenkey));
            pms.Add(new SqlParameter("@InterfaceName", func));
            object obj = SQLHelp.ExecuteScalar(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
            return obj==null?"":obj.ToString();
        }
        #endregion

        #region 根据学校id判断该学校是否已存在同名系统
        /// <summary>
        /// 根据学校id判断该学校是否已存在同名系统
        /// </summary>
        /// <param name="schoolid">学校id</param>
        /// <param name="sysname">系统名称</param>
        /// <param name="Id">系统id</param>
        /// <returns></returns>
        public virtual bool IsSchoolSysExists(int schoolid, string sysname, Int32 Id = 0)
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            StringBuilder sbSql = new StringBuilder();
            sbSql.Append("SELECT COUNT(1) FROM Plat_SystemInfo ");
            sbSql.Append(" where IsDelete=0 and SchoolId=@SchoolId and SystemName=@SystemName ");
            if (Id != 0)
            {
                sbSql.Append(" and Id!=@Id ");
            }
            pms.Add(new SqlParameter("@SchoolId", schoolid));
            pms.Add(new SqlParameter("@SystemName", sysname));
            pms.Add(new SqlParameter("@Id", Id));
            object obj = SQLHelp.ExecuteScalar(sbSql.ToString(), CommandType.Text, pms.ToArray());
            return int.Parse(obj.ToString()) > 0;
        }
        #endregion        

        #region 根据系统条件查找学校详细
        /// <summary>
        /// 根据系统条件查找学校详细
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataTable GetSystemAndSchoolBySysId(Hashtable ht) 
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append("select p_sys.*,p_s.Name as SchoolName from [dbo].[Plat_SystemInfo] p_sys left join [dbo].[Plat_School] p_s on p_sys.SchoolId=p_s.Id where 1=1 ");
                if (ht.ContainsKey("Id") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["Id"])))
                {
                    sbSql4org.Append(" and p_sys.Id=@Id");
                    List.Add(new SqlParameter("@Id", ht["Id"]));
                }
                if (ht.ContainsKey("SystemKey") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["SystemKey"])))
                {
                    sbSql4org.Append(" and p_sys.SystemKey=@SystemKey");
                    List.Add(new SqlParameter("@SystemKey", ht["SystemKey"]));
                }
                sbSql4org.Append(" and p_sys.IsDelete !=@sysDel");
                List.Add(new SqlParameter("@sysDel", (int)Status.删除));
                sbSql4org.Append(" and p_s.IsDelete !=@psDel");
                List.Add(new SqlParameter("@psDel", (int)Status.删除));
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
        }
        #endregion

        #region 根据系统key查找
        /// <summary>
        /// 根据系统条件查找学校详细
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataTable GetSystemByKey(string SystemKey)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append("select * from Plat_SystemInfo where SystemKey=@SystemKey ");
                
                List.Add(new SqlParameter("@SystemKey", SystemKey));
                
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
        }
        #endregion
    }
}
