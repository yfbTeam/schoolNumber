using SMSIDAL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSDAL
{
    public partial class AssetManagementDal : HZ_BaseDal<AssetManagement>, IAssetManagementDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage, string where)
        {
            int PageIndex = 0;
            int PageSize = 0;
            RowCount = 0;
            DataTable dt = new DataTable();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select *  from AssetManagement rri where 1=1 and rri.IsDelete=0");

                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and rri.Id ='{0}' ", ht["ID"].ToString());
                }

                if (ht.ContainsKey("LikeName") && !string.IsNullOrEmpty(ht["LikeName"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and rri.Name like '%{0}%' ", ht["LikeName"].ToString());
                }

                if (ht.ContainsKey("AssetModel") && !string.IsNullOrEmpty(ht["AssetModel"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and rri.AssetModel ='{0}' ", ht["AssetModel"].ToString());
                }

                if (ht.ContainsKey("UseStatus") && !string.IsNullOrEmpty(ht["UseStatus"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and rri.UseStatus = '{0}' ", ht["UseStatus"].ToString());
                }

                if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(ht["Name"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and rri.Name = '{0}' ", ht["Name"].ToString());
                }

                if (ht.ContainsKey("IsDelete") && !string.IsNullOrEmpty(ht["IsDelete"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and rri.IsDelete = '{0}' ", ht["IsDelete"].ToString());
                }
                
                if (IsPage)
                {
                    PageIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    PageSize = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                //dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, null);
                dt = SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", where, "", PageIndex, PageSize, IsPage, null, out RowCount);
            }
            catch (Exception ex)
            {
                //写入日志
                //throw 
                return null;
            }
            return dt;
        }
    }
}
