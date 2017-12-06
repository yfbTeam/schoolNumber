using SMDAL;
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
    public partial class Plat_SysOfInter_RelService : BaseService<Plat_SysOfInter_Rel>, IPlat_SysOfInter_RelService
    {
        Plat_SysOfInter_RelDal dal = new Plat_SysOfInter_RelDal();

        #region 判断系统模块与接口的关系是否已存在
        /// <summary>
        /// 判断系统模块与接口的关系是否已存在
        /// </summary>
        /// <param name="infid">系统模块id</param>
        /// <param name="interid">接口id</param>
        /// <param name="Id">关系表主键</param>
        /// <returns></returns>
        public JsonModel IsSysOfInter_RelExists(int infid, int interid, Int32 Id = 0)
        {
            JsonModel jsonModel = null;
            try
            {
                bool result = dal.IsSysOfInter_RelExists(infid, interid, Id);
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = result
                };
                return jsonModel;
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }
        #endregion
    }
}
