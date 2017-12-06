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
    public partial class Course_EvalueService : BaseService_HZ<Course_Evalue>, ICourse_EvalueService
    {
        Course_EvalueDal dal = new Course_EvalueDal();
        #region 课程评价
        /// <summary>
        /// 课程评价
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public string CourceEvalue(Course_Evalue model)
        {
            string result = dal.CourceEvalue(model);
            return result;
        }
        #endregion

        #region 课程评价统计
        /// <summary>
        /// 课程评价统计
        /// </summary>
        /// <returns></returns>
        public JsonModel Course_EvalueStatistical(Hashtable ht, bool IsPage = true, string where = "")
        {
            int RowCount = 0;
            BLLCommon common = new BLLCommon();
            try
            {
                int PageIndex = 0;
                int PageSize = 0;
                if (IsPage)
                {
                    //增加起始条数、结束条数
                    ht = common.AddStartEndIndex(ht);
                    PageIndex = Convert.ToInt32(ht["PageIndex"]);
                    PageSize = Convert.ToInt32(ht["PageSize"]);
                }

                DataTable modList = dal.Course_EvalueStatistical(ht, out RowCount, IsPage, where);

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

                if (IsPage)
                {
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
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = list
                    };
                }
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

        #region 用于课程评价统计报表
        public DataTable CourseEvalueStatas(Hashtable ht, out int RowCount, bool IsPage=true, string where="")
        {
            if (IsPage)
            {
                BLLCommon common = new BLLCommon();
                ht = common.AddStartEndIndex(ht);
            }
            return dal.CourseEvalueStatas(ht,out RowCount,IsPage,where);
        }

        #endregion
    }
}
