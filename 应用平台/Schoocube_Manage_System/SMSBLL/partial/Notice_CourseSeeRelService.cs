using SMSDAL;
using SMSIBLL;
using SMSModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSBLL
{
    public partial class Notice_CourseSeeRelService : BaseService_HZ<Notice_CourseSeeRel>, INotice_CourseSeeRelService
    {
        Notice_CourseSeeRelDal dal = new Notice_CourseSeeRelDal();
        public virtual JsonModel OperNotice_CourseSeeRel(Notice_CourseSeeRel entity)
        {
            JsonModel jsonModel = null;
            try
            {
                int result = dal.OperNotice_CourseSeeRel(entity);
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
