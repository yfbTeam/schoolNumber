using SMSDAL;
using SMSIBLL;
using SMSModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSBLL
{
    public partial class Course_WorkService : BaseService_HZ<Course_Work>, ICourse_WorkService
    {
        Course_WorkDal dal = new Course_WorkDal();
        Course_WorkCorrectRelDal dal_corr = new Course_WorkCorrectRelDal();
        BLLCommon common = new BLLCommon();
        #region 获取学生作业完成信息
        public JsonModel GetStuWorkCompleteInfo(Hashtable ht)
        {
            JsonModel jsonModel = null;
            try
            {
                DataTable dt = dal.GetStuWorkCompleteInfo(ht);
                if (dt != null)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = common.DataTableToList(dt)
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
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
        #endregion 

        #region 获取作业统计信息
        public DataTable GetWorkStatisticsInfo(Hashtable ht)
        {
            return dal.GetWorkStatisticsInfo(ht);
        }
        #endregion 

        #region 上传作业
        public virtual JsonModel AddWorkCorrectRel(Course_WorkCorrectRel entity, string classid)
        {
            JsonModel jsonModel = null;
            try
            {
                int result = dal_corr.AddWorkCorrectRel(entity, classid);
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
        #endregion

        #region 获取可能需要发通知的作业
        public DataTable GetEnableSendMesWork()
        {
            return dal.GetEnableSendMesWork();
        }
        #endregion

        #region 根据作业id获取提交作业的学生
        public DataTable GetCorrectRelByWorkId(string workId)
        {            
            return dal_corr.GetCorrectRelByWorkId(workId);            
        }
        #endregion
    }
}
