using SMSUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SMSUtility;
using System.Data.SqlClient;
using SMSModel;
using System.Collections;
namespace SMSDAL
{
    public partial class Course_EvalueDal
    {
        #region 课程评价
        /// <summary>
        /// 课程评价
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public string CourceEvalue(Course_Evalue model)
        {
            SqlParameter[] parm = { 
                                  new SqlParameter("@CouseID",model.CouseID),
                                  new SqlParameter("@CreateUID",model.CreateUID),
                                  new SqlParameter("@Evalue",model.Evalue),
                                  new SqlParameter("@EvalueCountent",model.EvalueCountent)
                                  };
            object obj = SQLHelp.ExecuteScalar("Course_Eva", CommandType.StoredProcedure, parm);
            return obj.SafeToString();
        }
        #endregion

        #region 课程评价统计
        /// <summary>
        /// 课程评价统计
        /// </summary>
        /// <returns></returns>
        public DataTable Course_EvalueStatistical(Hashtable ht, out int RowCount, bool IsPage, string where)
        {
            StringBuilder str = new StringBuilder();
            str.Append("select c.ID,c.Name,c.CourseEvalue,c.EvalueTimes,d.Evalue,d.Num,c.CreateTime from Course c,(select b.Evalue,a.ID,COUNT(1) as Num from  Course a inner join Course_Evalue b on a.id=b.CouseID group by a.ID,b.Evalue) d  where c.ID=d.ID");

            int StartIndex = 0;
            int EndIndex = 0;
            if (IsPage)
            {
                StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
            }
            if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
            {
                str.Append(" and c.ID = " + ht["ID"].SafeToString());
            }
            if (ht.ContainsKey("StudyTerm") && !string.IsNullOrEmpty(ht["StudyTerm"].SafeToString()))
            {
                str.Append(" and  c.StudyTerm = " + ht["StudyTerm"].SafeToString());
            }

            //string sql = "select c.ID,c.Name,c.CourseEvalue,c.EvalueTimes,d.Evalue,d.Num,c.CreateTime from Course c,(select b.Evalue,a.ID,COUNT(1) as Num from  Course a inner join Course_Evalue b on a.id=b.CouseID group by a.ID,b.Evalue) d  where c.ID=d.ID";
            DataTable dt = new DataTable();
            dt = SQLHelp.GetListByPage("(" + str.ToString() + ")", where, "", StartIndex, EndIndex, IsPage, null, out RowCount);

            return dt;
        }
        #endregion

        #region 用于课程评价统计报表
        public DataTable CourseEvalueStatas(Hashtable ht, out int RowCount, bool IsPage, string where)
        {
            RowCount = 0;
            int StartIndex = 0;
            int EndIndex = 0;
            if (IsPage)
            {
                StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
            }

            try
            {
                string strSql = "select a.ID as CouseID,b.ID,a.Name,a.CourseEvalue,a.EvalueTimes,b.Evalue,b.CreateUID from  Course a inner join Course_Evalue b on a.id=b.CouseID ";
                if (ht.ContainsKey("CourseName") && !string.IsNullOrEmpty(ht["CourseName"].SafeToString()))
                {
                    strSql += " and a.Name like '%" + ht["CourseName"] + "%'";
                }
                if (ht.ContainsKey("CourseID") && !string.IsNullOrEmpty(ht["CourseID"].SafeToString()))
                {
                    strSql += " and CouseID=" + ht["CourseID"];
                }               
                
                 return SQLHelp.GetListByPage("(" + strSql.ToString() + ")", where, "", StartIndex, EndIndex, IsPage, null, out RowCount);
            }
            catch (Exception ex)
            {
                return null;
            }

        }
        #endregion
    }
}
