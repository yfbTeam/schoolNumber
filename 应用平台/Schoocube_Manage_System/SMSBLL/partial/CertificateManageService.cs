using SMSDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSBLL
{
    public partial class CertificateManageService
    {
        CertificateManageDal dal = new CertificateManageDal();
        public string PlatCertificateAdd(string Name, string Course, string Exam1, string Scor1, string Exam2, string Scor2, string Exam3, string Scor3, string UserIdCard, string ModelID)
        {
            return dal.PlatCertificateAdd(Name, Course, Exam1, Scor1, Exam2, Scor2, Exam3, Scor3, UserIdCard, ModelID);
        }
        public string PlatCertificateEdit(string Name, string Course, string Exam1, string Scor1, string Exam2, string Scor2, string Exam3, string Scor3, string UserIdCard, string ModelID, int ID)
        {
            return dal.PlatCertificateEdit(Name, Course, Exam1, Scor1, Exam2, Scor2, Exam3, Scor3, UserIdCard, ModelID, ID);
        }
        public string PlatCertificateDel(string UserIdCard, int ID)
        {
            return dal.PlatCertificateDel(UserIdCard, ID);
        }
        public string Apply(string CertificateID, string StuName, string IDCard, string ClassID)
        {
            return dal.Apply(CertificateID, StuName, IDCard, ClassID);
        }
    }
}
