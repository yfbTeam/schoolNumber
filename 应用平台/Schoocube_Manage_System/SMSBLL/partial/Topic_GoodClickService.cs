using SMSDAL;
using SMSIBLL;
using SMSModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSBLL
{
    public partial class Topic_GoodClickService : BaseService_HZ<Topic_GoodClick>, ITopic_GoodClickService
    {
        Topic_GoodClickDal dal = new Topic_GoodClickDal();
        public virtual JsonModel AddGoodClick(Topic_GoodClick entity, Hashtable ht)
        {
            JsonModel jsonModel = null;
            try
            {
                int result = dal.AddGoodClick(entity, ht);
                if (result > 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = result
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "操作失败！",
                        retData = ""
                    };
                }
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
    }
}
