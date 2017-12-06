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
    public partial class CertificateManageDal
    {

        #region 添加平台证书
        /// <summary>
        /// 添加平台证书
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public string PlatCertificateAdd(string Name, string Course, string Exam1, string Scor1, string Exam2, string Scor2, string Exam3, string Scor3, string UserIdCard, string ModelID)
        {
            SqlParameter[] param = { 
                                       new SqlParameter("@Name",Name),
                                       new SqlParameter("@Course", Course),
                                       new SqlParameter("@Exam1",Exam1),
                                       new SqlParameter("@Scor1", Scor1),
                                       new SqlParameter("@Exam2",Exam2),
                                       new SqlParameter("@Scor2",Scor2),
                                       new SqlParameter("@Exam3", Exam3),
                                       new SqlParameter("@Scor3",Scor3),
                                       new SqlParameter("@UserIdCard",UserIdCard),
                                       new SqlParameter("@ModelID",ModelID)
                                   };
            object obj = SQLHelp.ExecuteScalar("AddPlatCertificate", CommandType.StoredProcedure, param);
            string result = "添加成功";
            if (obj.ToString().Length > 0)
            {
                result = obj.ToString();
            }
            return result;
        }
        #endregion

        #region 修改平台证书
        /// <summary>
        /// 修改平台证书
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public string PlatCertificateEdit(string Name, string Course, string Exam1, string Scor1, string Exam2, string Scor2, string Exam3, string Scor3, string UserIdCard, string ModelID, int ID)
        {
            SqlParameter[] param = { 
                                       new SqlParameter("@Name",Name),
                                       new SqlParameter("@Course", Course),
                                       new SqlParameter("@Exam1",Exam1),
                                       new SqlParameter("@Scor1", Scor1),
                                       new SqlParameter("@Exam2",Exam2),
                                       new SqlParameter("@Scor2",Scor2),
                                       new SqlParameter("@Exam3", Exam3),
                                       new SqlParameter("@Scor3",Scor3),
                                       new SqlParameter("@UserIdCard",UserIdCard),
                                       new SqlParameter("@ModelID",ModelID),
                                       new SqlParameter("@ID",ID),
                                   };
            object obj = SQLHelp.ExecuteScalar("EditPlatCertificate", CommandType.StoredProcedure, param);
            string result = "修改成功";
            if (obj.ToString().Length > 0)
            {
                result = obj.ToString();
            }
            return result;
        }
        #endregion

        #region 删除平台证书
        /// <summary>
        /// 删除平台证书
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public string PlatCertificateDel(string UserIdCard,int ID)
        {
            SqlParameter[] param = {                                     
                                       new SqlParameter("@UserIdCard",UserIdCard),
                                       new SqlParameter("@ID",ID),
                                   };
            object obj = SQLHelp.ExecuteScalar("DelPlatCertificate", CommandType.StoredProcedure, param);
            string result = "删除成功";
            if (obj.ToString().Length > 0)
            {
                result = obj.ToString();
            }
            return result;
        }
        #endregion
        
        public string Apply(string CertificateID, string StuName, string IDCard, string ClassID)
        {
            SqlParameter[] param = { 
                                       new SqlParameter("@CertificateID",CertificateID),
                                       new SqlParameter("@StuName", StuName),
                                       new SqlParameter("@IDCard",IDCard),
                                       new SqlParameter("@ClassID", ClassID)
                                   };
            object obj = SQLHelp.ExecuteScalar("CertApply", CommandType.StoredProcedure, param);
            string result = "申请成功";
            if (obj.ToString().Length > 0)
            {
                result = obj.ToString();
            }
            return result;
        }
    }
}
