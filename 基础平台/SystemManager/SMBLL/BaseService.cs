using SMIDAL;
using SMModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMBLL
{
    public abstract class BaseService<T> where T : class ,new()
    {
        public IBaseDal<T> CurrentDal;//依赖抽象的接口。

        private T currentEntity;

        public T CurrentEntity
        {
            get { return new T(); }
        }

        public BaseService()
        {
            //执行给当前CurrentDal赋值。
            //强迫子类给当前类的CurrentDal属性赋值。
            SetCurrentDal();//调用了一个抽象方法。
        }

        //纯抽象方法：子类必须重写此方法。
        public abstract void SetCurrentDal();

        public virtual JsonModel Add(T entity)
        {
            JsonModel jsonModel = null;
            try
            {
                int result = CurrentDal.Add(entity);


                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = result
                };
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

        /// <summary>
        /// 更新单条数据
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public virtual JsonModel Update(T entity)
        {
            JsonModel jsonModel = null;
            try
            {
                bool result = CurrentDal.Update(entity);

                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = result
                };
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


        /// <summary>
        /// 伪删除单条数据
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public virtual JsonModel DeleteFalse(int id)
        {
            JsonModel jsonModel = null;
            try
            {
                bool result = CurrentDal.DeleteFalse(CurrentEntity, id);
                if (result)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "",
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

        /// <summary>
        /// 批量伪删除数据
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public virtual JsonModel DeleteBatchFalse(params int[] ids)
        {
            JsonModel jsonModel = null;
            try
            {
                int result = CurrentDal.DeleteBatchFalse(CurrentEntity, ids);

                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = result
                };
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


        /// <summary>
        /// 删除单条数据
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public virtual JsonModel Delete(int id)
        {
            JsonModel jsonModel = null;
            try
            {
                bool result = CurrentDal.Delete(CurrentEntity, id);

                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = result
                };
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

        /// <summary>
        /// 批量删除数据
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public virtual JsonModel DeleteBatch(params string[] ids)
        {
            JsonModel jsonModel = null;
            try
            {
                int result = CurrentDal.DeleteBatch(CurrentEntity, ids);
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = result
                };
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
            //return CurrentDal.DeleteBatch(CurrentEntity, ids);

        }

        public virtual JsonModel GetEntityById(int id)
        {
            JsonModel jsonModel = null;
            try
            {
                T entity = CurrentDal.GetEntityById(CurrentEntity, id);
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = entity
                };
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

        //public virtual JsonModel GetEntityListByField(string filed, string value)
        //{
        //    JsonModel jsonModel = null;
        //    try
        //    {
        //        List<T> list = CurrentDal.GetEntityListByField(CurrentEntity, filed, value);
        //        jsonModel = new JsonModel()
        //        {
        //            errNum = 0,
        //            errMsg = "success",
        //            retData = list
        //        };
        //        return jsonModel;
        //    }
        //    catch (Exception ex)
        //    {
        //        jsonModel = new JsonModel()
        //        {
        //            errNum = 400,
        //            errMsg = ex.Message,
        //            retData = ""
        //        };
        //        return jsonModel;
        //    }
        //    //return CurrentDal.GetEntityListByField(CurrentEntity, filed, value);
        //}
        /// <summary>
        /// 分页查询
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public JsonModel GetEntityOfPage(int pageIndex, int pagesize, string fdname, string filedName, string WhereStr, string OrderByStr, out int pageCount, out int recordcount)
        {
            pageCount = 0;
            recordcount = 0;
            JsonModel jsonModel = null;
            try
            {
                DataTable dt = CurrentDal.GetEntityOfPage(pageIndex, pagesize, fdname, filedName, CurrentEntity, WhereStr, OrderByStr, out pageCount, out recordcount);

                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = dt
                };
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
            //return CurrentDal.GetEntityOfPage(pageIndex, pagesize, fdname, filedName, CurrentEntity, WhereStr, OrderByStr, out pageCount, out recordcount);
        }
        //public virtual bool CheckForeignKey(string field, string value)
        //{
        //    return CurrentDal.CheckForeignKey(CurrentEntity, field, value);
        //}
        /// <summary>
        /// 根据条件获取所有数据
        /// </summary>
        /// <param name="entity">实体类</param>
        /// <param name="where">条件（例如：id>1）</param>
        /// <param name="order">排序（例如：createtime desc）</param>
        /// <returns></returns>
        public virtual JsonModel GetData(string where, string order)
        {
            JsonModel jsonModel = null;
            try
            {
                DataTable dt = CurrentDal.GetData(CurrentEntity, where, order);

                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = dt
                };
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
        public virtual JsonModel GetPage(Hashtable ht, SqlParameter[] parms4org,bool isPage=true)
        {
            BLLCommon common = new BLLCommon();
            try
            {
                //增加起始条数、结束条数
                ht = common.AddStartEndIndex(ht);
                int PageIndex = Convert.ToInt32(ht["PageIndex"]);
                int PageSize = Convert.ToInt32(ht["PageSize"]);
                int rowCount = 0;
                DataTable modList = CurrentDal.GetListByPage(ht,out rowCount,isPage);
                //定义分页数据实体
                PagedDataModel<Dictionary<string, object>> pagedDataModel = null;
                //定义JSON标准格式实体中
                JsonModel jsonModel = null;
                if (modList.Rows.Count <= 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 100,
                        errMsg = "无数据",
                        retData = ""
                    };
                    return jsonModel;
                }
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                list = common.DataTableToList(modList);

                //common.DataTableToList(modList);
                //List<string> list = new List<string>();
                //list.Add(common.DataTableToJson(modList));
                //总条数
                int RowCount = rowCount;

                //总页数
                int PageCount = (int)Math.Ceiling(RowCount * 1.0 / PageSize);
                //将数据封装到PagedDataModel分页数据实体中
                pagedDataModel =new PagedDataModel<Dictionary<string, object>>()
// new PagedDataModel<string>()
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

        #region 判断名称是否已存在
        /// <summary>
        /// 判断名称是否已存在
        /// </summary>
        /// <param name="entity">实体</param>
        /// <param name="syskey">系统key</param>
        /// <param name="name">名称</param>
        /// <param name="Id">Id</param>
        /// <param name="fieldname">字段名称（默认为Name）</param>
        /// <param name="isJudgeSys">是否判断系统key（默认false）</param>
        /// <returns></returns>
        public JsonModel IsNameExists(string syskey, string name, Int32 Id = 0, string fieldname = "Name", bool isJudgeSys = false)
        {
            JsonModel jsonModel = null;
            try
            {
                bool result = CurrentDal.IsNameExists(CurrentEntity, syskey, name, Id, fieldname, isJudgeSys);
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = result
                };
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
