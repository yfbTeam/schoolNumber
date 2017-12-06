
using SMSDAL;
using SMSIBLL;
using SMSModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSBLL
{
    public partial class TrainingFilesService : BaseService_HZ<TrainingFiles>, ITrainingFilesService
    {
        TrainingFilesDal dal = new TrainingFilesDal();
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
            string Result = dal.TrainAdd(train, Course, Exam);
            return Result;
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
            DataTable dt = dal.GetTrainCourse(trainID);
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
            DataTable dt = dal.GetTrainExam(trainID);
            return dt;
        }
        #endregion
    }
}
