using SMIDAL;
using SMModel;
using SMSUtility;
using SMUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMDAL
{
    public partial class Plat_LogInfoDal : BaseDal<Plat_LogInfo>, IPlat_LogInfoDal
    {
        /// <summary>
        /// 查询
        /// </summary>
        /// <param name="PersonName"></param>
        /// <param name="Modelnode"></param>
        /// <param name="starDateHidden"></param>
        /// <param name="endDateHidden"></param>
        /// <returns></returns>
        public DataTable query(string PersonName, string Modelnode, DateTime starDateHidden, DateTime endDateHidden, string quanxian)
        {
            try
            {
//                string SQLstring = @"select a.*,b.XM from Plat_LogInfo a 
//                                    left join Base_Teacher b on a.LoginName=b.YHZH
//　                                  where 1=1  ";
                string SQLstring = @"select a.*,b.XM from Plat_LogInfo a 
                                    left join Plat_Teacher b on a.LoginName=b.LoginName
　                                  where 1=1  ";
                if (!string.IsNullOrEmpty(PersonName.Trim()))
                    SQLstring += " and b.XM like @PersonName";
                if (Modelnode != "0")
                    SQLstring += " and a.Module= @Modelnode";
                if (starDateHidden != DateTime.MaxValue)
                    SQLstring += " and a.CreateTime >= @starDateHidden";
                if (endDateHidden != DateTime.MaxValue)
                    SQLstring += " and a.CreateTime < @endDateHidden";
                SQLstring += "  order by a.CreateTime desc";
                SqlParameter[] parameters = {
					    new SqlParameter("@PersonName","%"+PersonName+"%"),
					    new SqlParameter("@Modelnode", Modelnode),  
                        new SqlParameter("@starDateHidden", DateTime.Parse(starDateHidden.ToString())), 
                        new SqlParameter("@endDateHidden",DateTime.Parse(endDateHidden.ToString()))
                                        };
                return SQLHelp.ExecuteDataTable(SQLstring,CommandType.Text,  parameters);
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
                return null;
            }
        }

        public DataTable ReadData()
        {
            try
            {
                string SQLstring = @"select a.*,b.XM from Plat_LogInfo a 
                                    left join Plat_Teacher b on a.LoginName=b.LoginName ";
                return SQLHelp.ExecuteDataTable(SQLstring,CommandType.Text);
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
                return null;
            }
        }
    }
}
