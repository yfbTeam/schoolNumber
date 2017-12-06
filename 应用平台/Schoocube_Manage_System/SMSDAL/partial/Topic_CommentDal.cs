using SMSIDAL;
using SMSModel;
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
    public partial class Topic_CommentDal : HZ_BaseDal<Topic_Comment>, ITopic_CommentDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage = true, string Where = "")
        {
            RowCount = 0;
            List<SqlParameter> pms = new List<SqlParameter>();
            int StartIndex = 0;
            int EndIndex = 0;
            if (IsPage)
            {
                StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
            }
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select comm.*,convert(varchar(16),comm.CreateTime,21) as CreateTime_Format ");
                if (ht.ContainsKey("UserIdCard") && !string.IsNullOrEmpty(ht["UserIdCard"].SafeToString()))
                {
                    sbSql4org.Append(" ,case when comm.CreateUID=@UserIdCard then 1 else 0 end as IsCreate ");
                    pms.Add(new SqlParameter("@UserIdCard", ht["UserIdCard"].ToString()));
                }
                sbSql4org.Append(@" from Topic_Comment comm 
                                    inner join Topic tpc on tpc.Id=comm.TopicId and tpc.IsDelete=0
                                    where comm.IsDelete=0 ");
                if (ht.ContainsKey("CouseID") && !string.IsNullOrEmpty(ht["CouseID"].ToString()))
                {
                    sbSql4org.Append(" and tpc.CouseID=@CouseID ");
                    pms.Add(new SqlParameter("@CouseID", ht["CouseID"].ToString()));
                }
                if (ht.ContainsKey("TopicId") && !string.IsNullOrEmpty(ht["TopicId"].ToString()))
                {
                    sbSql4org.Append(" and comm.TopicId=@TopicId ");
                    pms.Add(new SqlParameter("@TopicId", ht["TopicId"].ToString()));
                }
                if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(ht["Name"].ToString()))
                {
                    sbSql4org.Append(" and tpc.Name like N'%' + @Name + '%' ");
                    pms.Add(new SqlParameter("@Name", ht["Name"].ToString()));
                }
                if (ht.ContainsKey("ChapterID") && !string.IsNullOrEmpty(ht["ChapterID"].SafeToString()))
                {
                    sbSql4org.Append(" and '|'+tpc.ChapterID+'|'  like N'|' + @ChapterID + '|%' ");
                    pms.Add(new SqlParameter("@ChapterID", ht["ChapterID"].ToString()));
                }
                if (ht.ContainsKey("StuIDCard") && !string.IsNullOrEmpty(ht["StuIDCard"].SafeToString()))
                {
                    sbSql4org.Append(" and (tpc.CreateUID=@StuIDCard or tpc.IsShare=1 )");
                    pms.Add(new SqlParameter("@StuIDCard", ht["StuIDCard"].ToString()));
                }
                return SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", Where, "", StartIndex, EndIndex, IsPage, pms.ToArray(), out RowCount);
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }

        }

        public int AddTopic_Comment(Topic_Comment entity,string classid)
        {
            int result = 0;
            SqlParameter[] param = { 
                                       new SqlParameter("@TopicId", entity.TopicId),
                                       new SqlParameter("@Pid", entity.Pid),
                                       new SqlParameter("@Contents", entity.Contents),
                                       new SqlParameter("@CreateUID", entity.CreateUID),
                                       new SqlParameter("@ClassID",classid)
                                   };
            object obj = SQLHelp.ExecuteScalar("AddTopic_Comment", CommandType.StoredProcedure, param);
            result = Convert.ToInt32(obj);
            return result;
        }
    }
}
