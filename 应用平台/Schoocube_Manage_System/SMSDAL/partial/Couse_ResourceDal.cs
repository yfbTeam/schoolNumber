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
    public partial class Couse_ResourceDal : HZ_BaseDal<Couse_Resource>, ICouse_ResourceDal
    {

        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage, string where)
        {
            RowCount = 0;
            List<SqlParameter> pms = new List<SqlParameter>();
            DataTable dt = new DataTable();
            try
            {
                int StartIndex = 0;
                int EndIndex = 0;
                string CouseID = ht["CouseID"].SafeToString();
                string IsVideo = ht["IsVideo"].SafeToString();
                string StuIdCard = ht["StuIdCard"].SafeToString();
                string orderBy = string.Empty;
                StringBuilder sb = new StringBuilder();
                sb.Append(@"select a.ID,a.VidoeImag,a.CreateTime,b.Name,b.FileUrl,a.ChapterID,b.postfix,co.Name as CouseName ");
                if (!string.IsNullOrEmpty(StuIdCard))
                {
                    sb.Append(@",isnull(click.Id,0) as ClickId,isnull(click.ClickNum,0) as ClickNum,isnull(click.WatchTime,0) as WatchTime,isnull(click.IsLookEnd,0) as IsLookEnd ");
                    orderBy = "IsLookEnd ";
                }
                sb.Append(@"from Couse_Resource a  inner join ResourcesInfo b on a.ResourcesID=b.ID 
                             left join Course co on co.ID=a.CouseID ");
                if (!string.IsNullOrEmpty(StuIdCard))
                {
                    sb.Append(@" left join SomeTableClick click on click.RelationId=a.ID and click.Type=0 
                                                     and click.IsDelete=0 and click.CreateUID=@StuIdCard ");
                    pms.Add(new SqlParameter("@StuIdCard", StuIdCard));
                }
                sb.Append(" where 1=1 ");
                if (CouseID.Length > 0)
                {
                    sb.Append(" and  a.CouseID=@CouseID ");
                    pms.Add(new SqlParameter("@CouseID", CouseID));
                }
                if (IsVideo.Length > 0)
                {
                    sb.Append(" and  a.IsVideo=@IsVideo ");
                    pms.Add(new SqlParameter("@IsVideo", IsVideo));
                }
                if (IsPage)
                {
                    StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                if (ht.ContainsKey("ChapterID") && !string.IsNullOrEmpty(ht["ChapterID"].SafeToString()))
                {
                    sb.Append(" and '|'+a.ChapterID+'|'  like N'|" + ht["ChapterID"].SafeToString() + "|%' ");
                    // pms.Add(new SqlParameter("@ChapterID", ht["ChapterID"].ToString()));
                }
                if (ht.ContainsKey("Couse_ResourceID") && !string.IsNullOrEmpty(ht["Couse_ResourceID"].SafeToString()))
                {
                    sb.Append(" and  a.ID=@Couse_ResourceID ");
                    pms.Add(new SqlParameter("@Couse_ResourceID", ht["Couse_ResourceID"].SafeToString()));
                }
                if (ht.ContainsKey("CourceType") && !string.IsNullOrEmpty(ht["CourceType"].SafeToString()))
                {
                    sb.Append(" and  co.CourceType=@CourceType ");
                    pms.Add(new SqlParameter("@CourceType", ht["CourceType"].SafeToString()));
                }
                if (ht.ContainsKey("ResName") && !string.IsNullOrEmpty(ht["ResName"].ToString()))
                {
                    sb.Append(" and b.Name like N'%' + @ResName + '%' ");
                    pms.Add(new SqlParameter("@ResName", ht["ResName"].ToString()));
                }
                dt = SQLHelp.GetListByPage("(" + sb.ToString() + ")", where, orderBy, StartIndex, EndIndex, IsPage, pms.ToArray(), out RowCount);
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }
            return dt;
        }
        /// <summary>
        /// 根据用户权限获取用户资源
        /// </summary>
        /// <param name="RoleType">1.学生2.老师</param>
        /// <param name="StuNo">学生身份证号码</param>
        /// <param name="ClassID">班级编号</param>
        /// <returns></returns>
        public DataTable GetResourceByRole(Hashtable ht, out int RowCount, bool IsPage)
        {
            DataTable dt = new DataTable();
            List<SqlParameter> pms = new List<SqlParameter>();
            string RoleType = ht["RoleType"].SafeToString();
            string StuNo = ht["StuNo"].SafeToString();
            string ClassID = ht["ClassID"].SafeToString();
            if (ClassID.Length==0)
            {
                ClassID = "0";
            }
            RowCount = 0;
            int StartIndex = 0;
            int EndIndex = 0;

            string sqlStr = "";
            try
            {
                if (RoleType == "2")
                {
                    sqlStr = "select * from [dbo].[ResourcesInfo] where LEN(CatagoryID)>0";
                }
                else
                {
                    sqlStr = "select * from [dbo].[ResourcesInfo] where ID in(select ResourcesID from [dbo].[Couse_Resource] where " +
                        "CouseID in (select ID from Course where IsOpen=1 union select ID from Course where CourceType=2 and ID in(select CourseID from ClassCourse where ClassID=" + ClassID
                        + ") union select CourseID from [dbo].[Couse_Selstuinfo] where StuNo=@StuNo and Status=1))";
                    pms.Add(new SqlParameter("@StuNo", StuNo));
                    pms.Add(new SqlParameter("@ClassID", ClassID));

                }
                if (IsPage)
                {
                    StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                dt = SQLHelp.GetListByPage("(" + sqlStr + ")", "", "", StartIndex, EndIndex, IsPage, pms.ToArray(), out RowCount);

                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }

        }
    }
}
