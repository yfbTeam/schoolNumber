using SMIDAL;
using SMModel;
using SMUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMDAL
{
    public partial class Plat_MenuInfoDal : BaseDal<Plat_MenuInfo>, IPlat_MenuInfoDal
    {
        #region 获得首页左侧导航处菜单信息
        /// <summary>
        /// 获得首页左侧导航处菜单信息
        /// </summary>  
        public DataTable GetLeftNavigationMenu(string systemkey, string useridcard,string pid)
        {
            StringBuilder sbSql4org;
            List<SqlParameter> pms = new List<SqlParameter>();

            sbSql4org = new StringBuilder();
            if (useridcard == "00000000000000000X")//如果是默认最大权限的管理员
            {
                sbSql4org.Append(@"select distinct mi.* from Plat_SysOfMenu_Rel sm
                                 inner join Plat_MenuInfo mi on sm.MenuId=mi.Id and  mi.Id is not null and mi.IsMenu=0 and  mi.isShow=3
                                 where sm.SystemKey=@SystemKey and mi.Pid=@Pid ");
            }
            else
            {
                sbSql4org.Append(@"select distinct mi.* from Plat_RoleOfUser ru
                                inner join Plat_RoleOfMenu rm on ru.RoleId=rm.RoleId   
                                inner join Plat_MenuInfo mi on mi.Id=rm.MenuId  
                                inner join Plat_SysOfMenu_Rel sm on sm.MenuId=mi.Id and sm.SystemKey=@SystemKey                              
                                where mi.Id is not null and mi.IsMenu=0 and mi.Pid=@Pid and mi.isShow=3 and ru.UserIDCard=@UserIDCard ");
            }

            sbSql4org.Append(" order by mi.Id ");
            pms.Add(new SqlParameter("@SystemKey",systemkey));
            pms.Add(new SqlParameter("@UserIDCard",useridcard));
            pms.Add(new SqlParameter("@Pid", pid));
            return SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
        }
        #endregion

        #region 获得权限设置处菜单信息
        /// <summary>
        /// 获得权限设置处菜单信息
        /// </summary>  
        public DataTable GetPermissionMenu(string systemkey,string roleid)
        {
            StringBuilder sbSql4org;
            List<SqlParameter> pms = new List<SqlParameter>();

            sbSql4org = new StringBuilder();
            sbSql4org.Append(@"select mi.*,ISNULL(rm.MenuId,0) as ischeck from Plat_MenuInfo mi
                     inner join Plat_SysOfMenu_Rel sm on sm.MenuId=mi.Id and sm.SystemKey=@SystemKey
                     left join Plat_RoleOfMenu rm on mi.Id=rm.MenuId and rm.RoleId=@RoleId ");
            sbSql4org.Append(" order by mi.Id ");
            pms.Add(new SqlParameter("@SystemKey", systemkey));
            pms.Add(new SqlParameter("@RoleId", roleid));
            return SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
        }
        #endregion

        #region 根据系统id获取系统菜单
        /// <summary>
        /// 根据系统id获取系统菜单
        /// </summary>  
        public DataTable GetSysMenuBySysId(string selSysKey)
        {
            StringBuilder sbSql4org;
            List<SqlParameter> pms = new List<SqlParameter>();

            sbSql4org = new StringBuilder();
            sbSql4org.Append(@"select mi.*,ISNULL(smr.MenuId,0) as ischeck from Plat_MenuInfo mi
                              left join Plat_SysOfMenu_Rel smr on smr.MenuId=mi.Id and smr.SystemKey=@SystemKey ");
            sbSql4org.Append(" order by mi.Id ");
            pms.Add(new SqlParameter("@SystemKey", selSysKey));
            return SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
        }
        #endregion

        #region 根据系统key删除系统下的菜单关系
        /// <summary>
        /// 根据系统key删除系统下的菜单关系
        /// </summary>
        /// <param name="syskey">系统key</param>
        /// <returns>返回 影响行数</returns>
        public int DelMenusBySysKey(string syskey, SqlTransaction trans)
        {
            try
            {
                StringBuilder sbSql;
                List<SqlParameter> pms = new List<SqlParameter>();

                sbSql = new StringBuilder();
                sbSql.Append("DELETE FROM Plat_SysOfMenu_Rel ");
                sbSql.Append(" WHERE SystemKey=@SystemKey ");

                pms.Add(new SqlParameter("@SystemKey", syskey));
                if (trans == null)
                {
                    return SQLHelp.ExecuteNonQuery(sbSql.ToString(), CommandType.Text, pms.ToArray());
                }
                else
                {
                    return SQLHelp.ExecuteNonQuery(trans, sbSql.ToString(), CommandType.Text, pms.ToArray());
                }
            }
            catch (Exception)
            {
                //写入日志
                //throw;
                return 0;
            }
        }
        #endregion

        #region 根据pid和身份证号查找菜单
        /// <summary>
        /// 根据pid和身份证号查找菜单
        /// </summary>  
        public DataTable GetMenuByPidAndIDCard(string systemkey, string useridcard,string pid)
        {
            StringBuilder sbSql4org;
            List<SqlParameter> pms = new List<SqlParameter>();
            sbSql4org = new StringBuilder();
            sbSql4org.Append(@"select mi.*,ISNULL(um.MenuId,0) as IsOwner from Plat_MenuInfo mi
                     inner join Plat_SysOfMenu_Rel sm on sm.MenuId=mi.Id and sm.SystemKey=@SystemKey
                     left join
					 ( select distinct rm.MenuId from Plat_RoleOfUser ru
                    inner join Plat_RoleOfMenu rm on ru.RoleId=rm.RoleId 
					inner join Plat_Role pr on pr.Id=rm.RoleId and pr.SystemKey=@SystemKey
					where ru.UserIDCard=@UserIDCard  ) um on mi.Id=um.MenuId
                    where 1=1 ");
            if (!string.IsNullOrEmpty(pid))
            {
                sbSql4org.Append(" and mi.Pid=@Pid ");
                pms.Add(new SqlParameter("@Pid", pid));
            }
            sbSql4org.Append(" order by mi.Id ");
            pms.Add(new SqlParameter("@SystemKey", systemkey));
            pms.Add(new SqlParameter("@UserIDCard", useridcard));
            return SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
        }
        #endregion
    }
}
