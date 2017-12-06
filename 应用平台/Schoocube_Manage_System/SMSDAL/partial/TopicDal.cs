using SMSIDAL;
using SMSModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SMSUtility;
using System.Collections;
using System.Data.SqlClient;
namespace SMSDAL
{
    public partial class TopicDal : HZ_BaseDal<Topic>, ITopicDal
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
                sbSql4org.Append(@"select tpc.*,convert(varchar(16),tpc.CreateTime,21) as CreateTime_Format,co.Name as CouseName,chap.* ");
                if (ht.ContainsKey("UserIdCard") && !string.IsNullOrEmpty(ht["UserIdCard"].SafeToString()))
                {
                    sbSql4org.Append(@",isnull(task.ID,0) as TaskID
                                    ,(select count(1) from Course_TaskRel where TaskID=task.ID and CreateUID=@UserIdCard) as ComCount
                                     ,case when (select count(1) where @ClassID in(select value from func_split(task.StuRange,',')))>0 then 1 else 0 end as IsHasTask
                                    ,case when good.Id is null then 0 else 1 end as IsGoodClick ,case when tpc.CreateUID=@UserIdCard then 1 else 0 end as IsCreate ");
                    pms.Add(new SqlParameter("@UserIdCard", ht["UserIdCard"].ToString()));
                    pms.Add(new SqlParameter("@ClassID", ht["ClassID"].SafeToString()));
                }
                sbSql4org.Append(" from Topic tpc ");
                if (ht.ContainsKey("UserIdCard") && !string.IsNullOrEmpty(ht["UserIdCard"].SafeToString()))
                {
                    sbSql4org.Append(@" left join Topic_GoodClick good on good.RelationId=tpc.Id and good.CreateUID=@UserIdCard and good.Type=0
                                        left join Couse_TaskInfo task on task.RelationID=tpc.Id and task.Type=2");
                }
                sbSql4org.Append(@" left join Course co on co.ID=tpc.CouseID 
                                   left join (select content.ID as SingChapterID,
                                    (case when convert(nvarchar,chapter.ID) is null then '' else convert(nvarchar,chapter.ID)+'|' end
                                    +case when convert(nvarchar,knot.ID) is null then '' else +convert(nvarchar,knot.ID)+'|' end
                                    +isnull(convert(nvarchar,content.ID),'')) as ComChapterID ,
                                    isnull(chapter.Name,'') ChapterName,isnull(knot.Name,'') KnotName,isnull(content.Name,'') ContentHName 
                                    from Course_Chapter content 
                                    left join Course_Chapter knot on content.Pid=knot.ID
                                    left join Course_Chapter chapter on knot.Pid=chapter.ID) chap on chap.ComChapterID=tpc.ChapterID "); 
                sbSql4org.Append(" where tpc.IsDelete=0 ");                
                if (ht.ContainsKey("CouseID") && !string.IsNullOrEmpty(ht["CouseID"].ToString()))
                {
                    sbSql4org.Append(" and tpc.CouseID=@CouseID ");
                    pms.Add(new SqlParameter("@CouseID", ht["CouseID"].ToString()));
                }
                if (ht.ContainsKey("Type") && !string.IsNullOrEmpty(ht["Type"].ToString()))
                {
                    sbSql4org.Append(" and tpc.Type=@Type ");
                    pms.Add(new SqlParameter("@Type", ht["Type"].ToString()));
                }
                if(ht.ContainsKey("TopicId") && !string.IsNullOrEmpty(ht["TopicId"].ToString()))
                {
                    sbSql4org.Append(" and tpc.Id=@TopicId ");
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
    }
}
