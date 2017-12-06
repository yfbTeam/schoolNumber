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
    public partial class StudentTrainDal : HZ_BaseDal<StudentTrain>, IStudentTrainDal
    {
        #region 培训信息查询
        /// <summary>
        ///  章节查询
        /// </summary>
        /// <param name="ht"></param>
        /// <param name="RowCount"></param>
        /// <param name="IsPage"></param>
        /// <param name="Where"></param>
        /// <returns></returns>
        public DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage, string Where)
        {
            RowCount = 0;
            DataTable dt = new DataTable();
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                int StartIndex = 1;
                int EndIndex = 1;
                if (IsPage)
                {
                    StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                //if (!string.IsNullOrWhiteSpace(Where))
                //{
                //    Where += " and";
                //}
                //Where += " IsDelete=0";
                //if (string.IsNullOrWhiteSpace(Where))
                //{
                //    Where += " 1=1";
                //}
                if (ht.Contains("StuIDCard"))
                {
                    Where += " and StuIDCard=@StuIDCard";
                    pms.Add(new SqlParameter("@StuIDCard", ht["StuIDCard"].ToString()));
                }
                if (ht.Contains("ID"))
                {
                    Where += " and ID=@ID";
                    pms.Add(new SqlParameter("@ID", ht["ID"].ToString()));
                }

                dt = SQLHelp.GetListByPage("StudentTrain", Where, "", StartIndex,
                   EndIndex, IsPage, pms.ToArray(), out RowCount);
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }
            return dt;
        }
        #endregion
    }
}
