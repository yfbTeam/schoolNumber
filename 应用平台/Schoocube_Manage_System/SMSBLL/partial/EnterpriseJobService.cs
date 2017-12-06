using SMSModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSBLL
{
    public partial class EnterpriseJobService
    {
        SMSDAL.EnterpriseJobDal DAL = new SMSDAL.EnterpriseJobDal();
        BLLCommon common = new BLLCommon();
        public JsonModel MoreEditCourseForJob(Hashtable ht) 
        {
            JsonModel jsonModel = null;
            try
            {
                int number = DAL.MoreEditCourseForJob(ht);
                if (number > 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success"
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 400,
                        errMsg = "fail"
                    };
                }   
                return jsonModel;
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message
                };
                return jsonModel;
            }
        }
    }
}
