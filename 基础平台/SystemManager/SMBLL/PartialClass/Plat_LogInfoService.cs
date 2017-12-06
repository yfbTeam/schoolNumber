using SMBLL;
using SMDAL;
using SMIBLL;
using SMModel;
using SMUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMBLL
{
    public partial class Plat_LogInfoService : BaseService<Plat_LogInfo>, IPlat_LogInfoService
    {
        Plat_LogInfoDal dal = new Plat_LogInfoDal();
        /// <summary>
        /// 查询
        /// </summary>
        /// <param name="PersonName"></param>
        /// <param name="Modelnode"></param>
        /// <param name="starDateHidden"></param>
        /// <param name="endDateHidden"></param>
        /// <returns></returns>
        public DataTable query(string PersonName, string Modelnode, DateTime starDateHidden, DateTime endDateHidden, string quanxian)
        {
            return dal.query(PersonName, Modelnode, starDateHidden, endDateHidden, quanxian);
            
        }

        /// <summary>
        /// 记录操作日志
        /// </summary>
        /// <param name="MKMC"></param>
        /// <param name="CZXX"></param>
        public void WriteLog(string MKMC, string Type, string Remarks, string LoginName, string Operation)
        {
            SMModel.Plat_LogInfo Log = new Plat_LogInfo();
            Log.LoginName = LoginName;
            Log.IP = GetIP.getIPAddress();
            Log.Module = MKMC;
            Log.Type = Type;
            Log.Operation = Operation;
            Log.CreateTime = DateTime.Now;
            Log.Remarks = Remarks;
            base.CurrentDal.Add(Log);
        }

        public DataTable ReadData()
        {
            return dal.ReadData();
        }
    }
}
