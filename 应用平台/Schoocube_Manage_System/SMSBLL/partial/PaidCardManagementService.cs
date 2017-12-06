using SMSModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSBLL
{
    public partial class PaidCardManagementService
    {
        SMSDAL.PaidCardManagementDal dal = new SMSDAL.PaidCardManagementDal();
        public JsonModel PrepaidCardHistory(Hashtable ht)
        {
            try
            {
                int result = dal.PrepaidCardHistory(ht);
                //定义JSON标准格式实体中
                JsonModel jsonModel = new JsonModel();
                if (result > 0)
                    jsonModel.errMsg = "success";
                else
                    jsonModel.errMsg = "fail";
                return jsonModel;
            }
            catch (Exception ex)
            {
                JsonModel jsonModel = new JsonModel();
                jsonModel.status = "error";
                jsonModel.errMsg = ex.ToString();
                return jsonModel;
            }
        }
    }
}
