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
    public partial class Couse_TaskInfoService : BaseService_HZ<Couse_TaskInfo>, ICouse_TaskInfoService
    {
        Couse_TaskInfoDal dal = new Couse_TaskInfoDal();
        Topic_CommentDal dal_comment = new Topic_CommentDal();
        BLLCommon common = new BLLCommon();

        #region 获取课程的进度信息
        public JsonModel GetCourseProgressInfo(Hashtable ht)
        {
            JsonModel jsonModel = null;
            try
            {
                DataTable dt = dal.GetCourseProgressInfo(ht);
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

        #region 获取学生任务完成信息
        public JsonModel GetStuTaskCompleteInfo(Hashtable ht)
        {
            JsonModel jsonModel = null;
            try
            {
                DataTable dt = dal.GetStuTaskCompleteInfo(ht);
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

        #region 获取完成某任务的人数
        public virtual JsonModel GetComCountByTaskID(int taskid)
        {
            JsonModel jsonModel = null;
            try
            {
                int result = dal.GetComCountByTaskID(taskid);
                return new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = result
                    };
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

        #region 添加评论、任务关系
        public virtual JsonModel AddTopic_Comment(Topic_Comment entity, string classid)
        {
            JsonModel jsonModel = null;
            try
            {
                int result = dal_comment.AddTopic_Comment(entity, classid);
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
    }
}
