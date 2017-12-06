using SMSIDAL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSDAL
{
    public partial class TrainingFilesDal : HZ_BaseDal<TrainingFiles>, ITrainingFilesDal
    {
        #region 添加培训档案
        /// <summary>
        /// 添加培训档案
        /// </summary>
        /// <param name="train">TrainingFiles</param>
        /// <param name="Course">课程</param>
        /// <param name="Exam">考试</param>
        /// <returns></returns>
        public string TrainAdd(TrainingFiles train, string Course, string Exam)
        {
            SqlParameter[] param = { 
                                       new SqlParameter("@CreateUID",train.CreateUID),
                                       new SqlParameter("@TrainName", train.TrainName),
                                       new SqlParameter("@GroupName", train.GroupName),
                                       new SqlParameter("@BeginTime",train.BeginTime),
                                       new SqlParameter("@EndTime",train.EndTime),
                                       new SqlParameter("@ClassHour", train.ClassHour),
                                       new SqlParameter("@TrainFee",train.TrainFee),
                                       new SqlParameter("@TrainMan",train.TrainMan),
                                       new SqlParameter("@TrainResult", train.TrainResult),
                                       new SqlParameter("@Course",Course),
                                       new SqlParameter("@Exam",Exam)
                                   };
            return SQLHelp.ExecuteScalar("TrainAdd", CommandType.StoredProcedure, param).ToString();

        }
        #endregion

        #region 课程档案
        /// <summary>
        /// 课程档案
        /// </summary>
        /// <param name="trainID"></param>
        /// <returns></returns>
        public DataTable GetTrainCourse(string trainID)
        {
            string str = "select Name,CourceType,TermName,GradeName,WeekName,Status,CreateTime from Course where ID in(select CourseID from TrainCourse where trainID=" + trainID + ")";
            DataTable dt = SQLHelp.ExecuteDataTable(str, CommandType.Text, null);
            return dt;
        }
        #endregion

        #region 考试档案
        /// <summary>
        /// 考试档案
        /// </summary>
        /// <param name="trainID"></param>
        /// <returns></returns>
        public DataTable GetTrainExam(string trainID)
        {
            string str = "select Title,Score,AnswerBeginTime,AnswerEndTime from Exam_Examination where ExampaperID in (select ExamID from TrainExam where trainID="+trainID+")";
            DataTable dt = SQLHelp.ExecuteDataTable(str, CommandType.Text, null);
            return dt;
        }
        #endregion
    }
}
