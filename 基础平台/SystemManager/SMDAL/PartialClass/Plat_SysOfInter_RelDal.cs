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
    public partial class Plat_SysOfInter_RelDal : BaseDal<Plat_SysOfInter_Rel>, IPlat_SysOfInter_RelDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int rowCount, bool IsPage)
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            rowCount = 0;
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select rel.*,sysin.Region,sch.Id as SchoolId,sch.Name as SchoolName,sysin.SystemName,sysin.SystemKey,
                                    inf.InfName,inf.InfKey,inter.Name as InterName
                                    from Plat_SysOfInter_Rel rel
                                    left join Plat_Interface inter on inter.Id=rel.InterfaceId
                                    left join Plat_SysIndentify inf on inf.Id=rel.IndentifyId
                                    left join Plat_SystemInfo sysin on sysin.SystemKey=inf.SystemKey
                                    left join Plat_School sch on sch.Id=sysin.SchoolId
                                    where 1=1 ");
                if (ht.ContainsKey("SchoolId") && !string.IsNullOrEmpty(ht["SchoolId"].ToString()))
                {
                    sbSql4org.Append(" and sysin.SchoolId=@SchoolId ");
                    pms.Add(new SqlParameter("@SchoolId", ht["SchoolId"].ToString()));
                }
                if (ht.ContainsKey("InfName") && !string.IsNullOrEmpty(ht["InfName"].ToString()))
                {
                    sbSql4org.Append(" and inf.InfName like N'%'+@InfName+'%' ");
                    pms.Add(new SqlParameter("@InfName", ht["InfName"].ToString()));
                }
                if (ht.ContainsKey("RelId") && !string.IsNullOrEmpty(ht["RelId"].ToString()))
                {
                    sbSql4org.Append(" and rel.Id=@RelId ");
                    pms.Add(new SqlParameter("@RelId", ht["RelId"].ToString()));
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

        #region 判断系统模块与接口的关系是否已存在
        /// <summary>
        /// 判断系统模块与接口的关系是否已存在
        /// </summary>
        /// <param name="infid">系统模块id</param>
        /// <param name="interid">接口id</param>
        /// <param name="Id">关系表主键</param>
        /// <returns></returns>
        public virtual bool IsSysOfInter_RelExists(int infid, int interid, Int32 Id = 0)
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            StringBuilder sbSql = new StringBuilder();
            sbSql.Append("SELECT COUNT(1) FROM Plat_SysOfInter_Rel ");
            sbSql.Append(" where IndentifyId=@IndentifyId and InterfaceId=@InterfaceId ");
            if (Id != 0)
            {
                sbSql.Append(" and Id!=@Id ");
            }
            pms.Add(new SqlParameter("@IndentifyId", infid));
            pms.Add(new SqlParameter("@InterfaceId", interid));
            pms.Add(new SqlParameter("@Id", Id));
            object obj = SQLHelp.ExecuteScalar(sbSql.ToString(), CommandType.Text, pms.ToArray());
            return int.Parse(obj.ToString()) > 0;
        }
        #endregion        
    }
}
