using SMIBLL;
using SMModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMBLL
{
    public partial class Plat_UserOfSystemService : BaseService<Plat_UserOfSystem>, IPlat_UserOfSystemService
    {
        SMDAL.Plat_UserOfSystemDal DAL = new SMDAL.Plat_UserOfSystemDal();
        /// <summary>
        /// 获取系统账号关系
        /// </summary>
        /// <param name="LoginName">登录账号</param>
        /// <param name="Password">密码</param>
        /// <returns></returns>
        public DataTable GetSystemUser(string LoginName, string SystemKey)
        {
            return DAL.GetSystemUser(LoginName, SystemKey);
        }
    }
}
