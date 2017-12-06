using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSDAL
{
    public partial class NoticesDal
    {
        public DataTable GetNoticeAll(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                string sql = string.Empty;
                if (ht.ContainsKey("top") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["top"]))) sql = "top " + ht["top"].ToString();
                sbSql4org.Append("select " + sql + " * from System_Notice where 1=1 ");
                if (ht.ContainsKey("Id") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["Id"])))
                {
                    sbSql4org.Append(" and [Id]=@Id");
                    List.Add(new SqlParameter("@Id", ht["Id"].ToString()));
                }
                if (ht.ContainsKey("type") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["type"])))
                {
                    sbSql4org.Append(" and [Type]=@type");
                    List.Add(new SqlParameter("@type",ht["type"].ToString()));
                }
                if (ht.ContainsKey("tys") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["tys"])))
                {
                    sbSql4org.Append(" and [Type] in (" + ht["tys"].ToString() + ")");
                }
                if (ht.ContainsKey("Root") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["Root"])))
                {
                    sbSql4org.Append(" and ([Root]=0 or [Root]=@Root)");
                    List.Add(new SqlParameter("@Root", ht["Root"].ToString()));
                }
                if (ht.ContainsKey("isPush") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["isPush"])))
                {
                    sbSql4org.Append(" and isPush=@isPush");
                    List.Add(new SqlParameter("@isPush", ht["isPush"].ToString()));
                }

                sbSql4org.Append(" and IsDelete=@IsDelete");
                List.Add(new SqlParameter("@IsDelete",((int)SysStatus.正常).ToString()));
                sbSql4org.Append(" order by Hot desc,SortId desc,CreateTime desc,ClickNum asc");
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception)
            {
                return null;
            }
        }

        public DataTable GetNewsAll(Hashtable ht) 
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append(" select * from( select *, ROW_NUMBER() over(partition by [Type] order by Hot desc,SortId desc,CreateTime desc,ClickNum asc) as rowNum from System_Notice ) T");
                sbSql4org.Append(" where T.rowNum <=@Top  ");
                if (ht.ContainsKey("tys") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["tys"])))
                    sbSql4org.Append(" and  [type] in (" + ht["tys"].ToString() + ")");
                else
                    sbSql4org.Append(" and [type] =" + (int)NewsType.通知公告);

                if (ht.ContainsKey("Root") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["Root"])))
                {
                    sbSql4org.Append(" and ([Root]=0 or [Root]=" + ht["Root"].ToString() + ")");
                }
                if (ht.ContainsKey("isPush") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["isPush"])))
                {
                    sbSql4org.Append(" and [isPush]=" + ht["isPush"].ToString());
                }
                sbSql4org.Append(" and IsDelete=@IsDelete order by T.Hot desc,T.SortId desc,T.CreateTime desc,T.ClickNum asc");
                if (ht.ContainsKey("top") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["top"])))
                    List.Add(new SqlParameter("@Top", ht["top"].ToString()));
                else
                    List.Add(new SqlParameter("@Top", 6));
                List.Add(new SqlParameter("@IsDelete", ((int)SysStatus.正常).ToString()));
                //if (ht.ContainsKey("tys") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["tys"])))
                //    sbSql4org.Append(" From System_Notice where [type] in (" + ht["tys"].ToString() + ")");
                //else
                //    sbSql4org.Append(" From System_Notice where [type] =" + (int)NewsType.通知公告);
                //sbSql4org.Append(" and IsDelete=@IsDelete");
                
                //sbSql4org.Append(" ) T where T.[order]<@Top");
                
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception)
            {
                return null;
            }
            
        }

        public DataTable GetDataInfo(Hashtable ht) 
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append("select * from System_Notice where 1=1 ");
                if (ht.ContainsKey("Id") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["Id"])))
                {
                    sbSql4org.Append(" and Id=@Id");
                    List.Add(new SqlParameter("@Id", ht["Id"].ToString()));
                }
                if (ht.ContainsKey("IsDelete") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["IsDelete"])))
                {
                    sbSql4org.Append(" and IsDelete=@IsDelete");
                    List.Add(new SqlParameter("@IsDelete", ht["IsDelete"].ToString()));
                }
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
        }
    }
}
