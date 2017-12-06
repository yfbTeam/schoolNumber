using SMSIDAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSBLL
{
    public abstract class BaseService<T> where T : class ,new()
    {
        public IBaseDal<T> CurrentDal;//依赖抽象的接口。

        //private T currentEntity;

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

        public virtual bool Add(T entity)
        {
            return CurrentDal.Add(entity);

        }
        public virtual int Insert(T entity)
        {
            return CurrentDal.Insert(entity);
        }
        /// <summary>
        /// 更新单挑数据
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public virtual bool Update(T entity)
        {
            return CurrentDal.Update(entity);

        }


        /// <summary>
        /// 伪删除单条数据
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public virtual bool DeleteFalse(int id)
        {
            return CurrentDal.DeleteFalse(CurrentEntity, id);

        }

        /// <summary>
        /// 批量伪删除数据
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public virtual int DeleteBatchFalse(params int[] ids)
        {
            return CurrentDal.DeleteBatchFalse(CurrentEntity, ids);

        }


        /// <summary>
        /// 删除单条数据
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public virtual bool Delete(int id)
        {

            return CurrentDal.Delete(CurrentEntity, id);

        }

        /// <summary>
        /// 批量删除数据
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public virtual int DeleteBatch(params string[] ids)
        {

            return CurrentDal.DeleteBatch(CurrentEntity, ids);

        }

        public virtual T GetEntityById(int id)
        {
            return CurrentDal.GetEntityById(CurrentEntity, id);
        }
        /// <summary>
        /// 分页查询
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public virtual DataTable GetEntityOfPage(int pageIndex, int pagesize, string fdname, string filedName, string WhereStr, string OrderByStr, out int pageCount, out int recordcount)
        {
            return CurrentDal.GetEntityOfPage(pageIndex, pagesize, fdname, filedName, CurrentEntity, WhereStr, OrderByStr, out pageCount, out recordcount);
        }
        /// <summary>
        /// 根据条件获取所有数据
        /// </summary>
        /// <param name="entity">实体类</param>
        /// <param name="where">条件（例如：id>1）</param>
        /// <param name="order">排序（例如：createtime desc）</param>
        /// <returns></returns>
        public virtual DataTable GetData(string where, string order)
        {
            return CurrentDal.GetData(CurrentEntity, where, order);
        }
        public virtual List<T> GetEntityListByField(string filed, string value)
        {
            return CurrentDal.GetEntityListByField(CurrentEntity, filed, value);
        }

        public virtual bool CheckForeignKey(string field, string value)
        {
            return CurrentDal.CheckForeignKey(CurrentEntity, field, value);
        }
    }
}
