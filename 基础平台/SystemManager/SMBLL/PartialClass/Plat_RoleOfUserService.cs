using SMDAL;
using SMIBLL;
using SMModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMBLL
{
    public partial class Plat_RoleOfUserService : BaseService<Plat_RoleOfUser>, IPlat_RoleOfUserService
    {
        Plat_RoleOfUserDal dal = new Plat_RoleOfUserDal();
        #region 删除关系数据， 删单条
        /// <summary>
        /// 删除关系数据， 删单条
        /// </summary>
        /// <returns>返回 JsonModel</returns>
        public JsonModel DeleteUserRelation(Plat_RoleOfUser roleu)
        {
            JsonModel jsonModel = null;
            try
            {
                bool result = dal.DeleteUserRelation(roleu);
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
