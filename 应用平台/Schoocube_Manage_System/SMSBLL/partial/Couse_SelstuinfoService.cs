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
    public partial class Couse_SelstuinfoService : BaseService_HZ<Couse_Selstuinfo>, ICouse_SelstuinfoService
    {
        Couse_SelstuinfoDal dal = new Couse_SelstuinfoDal();
        BLLCommon common = new BLLCommon();

        public JsonModel GetDataByCourceID(string CourceID)
        {

            {
                JsonModel jsonModel = null;
                try
                {
                    DataTable dt = dal.GetDataByCourceID(CourceID);
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
        }

        public JsonModel GetClassOrStuByCourceID(string courceID, string courseType)
        {
            JsonModel jsonModel = null;
            try
            {
                DataTable dt = dal.GetClassOrStuByCourceID(courceID, courseType);
                if (dt != null)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = dt
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

        public JsonModel GetMyLessonsByType(Hashtable ht, bool IsPage = true)
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
                DataTable modList = dal.GetMyLessonsByType(ht, out RowCount, IsPage);

                //DataTable modList = CurrentDal.GetListByPage(ht, out RowCount, IsPage, where);

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

        #region 获取班级课程
        public JsonModel GetClassCourses(Hashtable ht)
        {

            JsonModel jsonModel = null;
            try
            {
                DataTable dt = dal.GetClassCourses(ht);
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

        #region 批量添加班级课程
        public JsonModel BatchAddClassCourse(ClassCourse entity, string courseids)
        {
            JsonModel jsonModel = null;
            try
            {
                int result = dal.BatchAddClassCourse(entity, courseids);
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
