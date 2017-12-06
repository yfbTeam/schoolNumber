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
    public partial class CourseService : BaseService_HZ<Course>, ICourseService
    {
        CourseDal courcedal = new CourseDal();

        #region 课程删除
        /// <summary>
        ///课程删除
        /// </summary>
        /// <param name="courseid"></param>
        /// <param name="stuno"></param>
        /// <param name="StuName"></param>
        /// <returns></returns>
        public string DelCourse(string courseid, string IDCard)
        {
            return courcedal.DelCourse(courseid, IDCard);
        }
        #endregion

        #region 课程注册
        /// <summary>
        ///课程注册
        /// </summary>
        /// <param name="courseid"></param>
        /// <param name="stuno"></param>
        /// <param name="StuName"></param>
        /// <returns></returns>
        public string StuSingUp(string courseid, string stuno, string Command)
        {
            return courcedal.StuSingUp(courseid, stuno, Command);
        }
        #endregion

        #region 根据分类获取课程信息
        /// <summary>
        /// 根据分类获取课程信息
        /// </summary>
        /// <returns></returns>
        public JsonModel GetCourseByType(int top, string StuNo, Hashtable ht)
        {
            BLLCommon common = new BLLCommon();
            try
            {

                DataTable modList = courcedal.GetCourseByType(top, StuNo, ht);
                //定义JSON标准格式实体中
                JsonModel jsonModel = null;
                if (modList == null || modList.Rows.Count <= 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                    return jsonModel;
                }
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                list = common.DataTableToList(modList);

                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = list
                };
                return jsonModel;
            }
            catch (Exception ex)
            {
                JsonModel jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }
        #endregion

        #region 学生调整
        /// <summary>
        /// 
        /// </summary>
        /// <param name="Type">1:分配2：删除</param>
        /// <param name="FreeStuIDs">未分配学生</param>
        /// <param name="StuIDs">已分配学生</param>
        /// <returns></returns>
        public string AdjustStu(int Type, string FreeStuIDs, string StuIDs, string CourseID, string CreateUID, string StuName)
        {
            return courcedal.AdjustStu(Type, FreeStuIDs, StuIDs, CourseID, CreateUID, StuName);
        }
        #endregion

        #region 添加课程模版
        /// <summary> 
        /// 添加课程模版
        /// </summary>
        /// <param name="CourceID"></param>
        /// <param name="ModelName"></param>
        /// <returns></returns>
        public string ModoleAdd(int CourceID, string ModelName, string CreateUID, string CourseMes)
        {
            return courcedal.ModoleAdd(CourceID, ModelName, CreateUID, CourseMes);
        }

        #endregion

        #region 根据模板创建课程
        /// <summary>
        /// 根据模板创建课程
        /// </summary>
        /// <param name="ModelID"></param>
        /// <param name="CourceName"></param>
        /// <param name="CourseMessage"></param>
        /// <param name="CreateUID"></param>
        /// <returns></returns>
        public string AddCourseByModol(int ModelID, string CourceName, string CourseMessage, string CreateUID)
        {
            return courcedal.AddCourseByModol(ModelID, CourceName, CourseMessage, CreateUID);
        }
        #endregion

        #region 获取热门课程
        /// <summary>
        /// 获取热门课程
        /// </summary>
        /// <returns></returns>
        public JsonModel HotCourse()
        {
            BLLCommon common = new BLLCommon();
            try
            {

                DataTable modList = courcedal.HotCourse();

                //定义JSON标准格式实体中
                JsonModel jsonModel = null;
                if (modList == null || modList.Rows.Count <= 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                    return jsonModel;
                }
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                list = common.DataTableToList(modList);

                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = list
                };

                return jsonModel;
            }
            catch (Exception ex)
            {
                JsonModel jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }
        #endregion

        #region 添加课程
        /// <summary>
        /// 添加课程
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public string AddCourse(Course entity)
        {
            return courcedal.AddCourse(entity);
        }
        #endregion

        #region 修改课程
        /// <summary>
        /// 修改课程
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public string UpdateCourse(Course entity)
        {
            return courcedal.UpdateCourse(entity);
        }
        #endregion
        #region 统计课程类型
        /// <summary>
        /// 统计课程类型
        /// </summary>
        /// <param name="Type"></param>
        /// <returns></returns>
        public string CouseTypeAnalis(string Type)
        {
            return courcedal.CouseTypeAnalis(Type);
        }
        #endregion

        #region 统计课程任务
        /// <summary>
        /// 统计课程任务
        /// </summary>
        /// <returns></returns>
        public DataTable CouseTaskAnalis(Hashtable ht, out int RowCount, bool IsPage = true, string Where = "")
        {
            if (IsPage)
            {
                BLLCommon common = new BLLCommon();
                ht = common.AddStartEndIndex(ht);
            }
            return courcedal.CouseTaskAnalis(ht, out RowCount, IsPage, Where);
        }
        #endregion
          #region 统计课程任务
        /// <summary>
        /// 统计课程任务
        /// </summary>
        /// <returns></returns>
        public DataTable CouseCompleteAnalis(Hashtable ht, out int RowCount, bool IsPage = true, string Where = "")
        {
            if (IsPage)
            {
                BLLCommon common = new BLLCommon();
                ht = common.AddStartEndIndex(ht);
            }
            return courcedal.CouseCompleteAnalis(ht, out RowCount, IsPage, Where);
        }
        #endregion
        
    }
}
