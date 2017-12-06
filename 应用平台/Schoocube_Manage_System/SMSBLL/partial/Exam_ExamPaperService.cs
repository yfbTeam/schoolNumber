using SMSDAL;
using SMSIBLL;
using SMSIDAL;
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
    public partial class Exam_ExamPaperService : BaseService_HZ<Exam_ExamPaper>, IExam_ExamPaperService
    {
        CourseDal courcedal = new CourseDal();

        Exam_ExamPaperDal dal = new Exam_ExamPaperDal();
        /// <summary>
        /// 考试列表
        /// </summary>
        /// <param name="courseid"></param>
        /// <param name="stuno"></param>
        /// <param name="StuName"></param>
        /// <returns></returns>
        public JsonModel GetListPageM(Hashtable ht)
        {
            int RowCount = 0;
            BLLCommon common = new BLLCommon();
            try
            {
                int PageIndex = 0;
                int PageSize = 0;

                //增加起始条数、结束条数
                ht = common.AddStartEndIndex(ht);
                PageIndex = Convert.ToInt32(ht["PageIndex"]);
                PageSize = Convert.ToInt32(ht["PageSize"]);

                //DataTable modList = CurrentDal.GetListByPage(ht, out RowCount, IsPage, where);
                DataTable modList = dal.GetListPageM(ht, out RowCount);

                //定义分页数据实体
                PagedDataModel<Dictionary<string, object>> pagedDataModel = null;
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

                //总页数
                int PageCount = (int)Math.Ceiling(RowCount * 1.0 / PageSize);
                //将数据封装到PagedDataModel分页数据实体中
                pagedDataModel = new PagedDataModel<Dictionary<string, object>>()
                {
                    PageCount = PageCount,
                    PagedData = list,
                    PageIndex = PageIndex,
                    PageSize = PageSize,
                    RowCount = RowCount
                };
                //将分页数据实体封装到JSON标准实体中
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = pagedDataModel
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

        /// <summary>
        /// 问卷列表
        /// </summary>
        /// <param name="courseid"></param>
        /// <param name="stuno"></param>
        /// <param name="StuName"></param>
        /// <returns></returns>
        public JsonModel GetListPageM_questionnaire(Hashtable ht)
        {
            int RowCount = 0;
            BLLCommon common = new BLLCommon();
            try
            {
                int PageIndex = 0;
                int PageSize = 0;

                //增加起始条数、结束条数
                ht = common.AddStartEndIndex(ht);
                PageIndex = Convert.ToInt32(ht["PageIndex"]);
                PageSize = Convert.ToInt32(ht["PageSize"]);

                //DataTable modList = CurrentDal.GetListByPage(ht, out RowCount, IsPage, where);
                DataTable modList = dal.GetListPageM_questionnaire(ht, out RowCount);

                //定义分页数据实体
                PagedDataModel<Dictionary<string, object>> pagedDataModel = null;
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

                //总页数
                int PageCount = (int)Math.Ceiling(RowCount * 1.0 / PageSize);
                //将数据封装到PagedDataModel分页数据实体中
                pagedDataModel = new PagedDataModel<Dictionary<string, object>>()
                {
                    PageCount = PageCount,
                    PagedData = list,
                    PageIndex = PageIndex,
                    PageSize = PageSize,
                    RowCount = RowCount
                };
                //将分页数据实体封装到JSON标准实体中
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = pagedDataModel
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





    }
}
