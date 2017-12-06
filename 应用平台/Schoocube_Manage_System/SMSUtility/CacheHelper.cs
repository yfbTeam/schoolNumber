using System;
using System.Web;
using System.Web.Caching;

namespace SMSUtility
{
    /// <summary>
    /// ���������صĹ�����
    /// </summary>
    public class CacheHelper
    {
        #region ��Ŀ�����洢��������

        #region ����1

        /// <summary>
        /// ��Ŀ�����洢��������
        /// </summary>
        /// <typeparam name="T">Ŀ����������</typeparam>
        /// <param name="key">������ļ���</param>
        /// <param name="target">Ŀ�����</param>
        public static void SetCache<T>(string key, T target)
        {
            try
            {
                //��Ŀ�����洢��������
                HttpRuntime.Cache.Insert(key, target);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion

        #region ����2

        /// <summary>
        /// ��Ŀ�����洢��������
        /// </summary>
        /// <typeparam name="T">Ŀ����������</typeparam>
        /// <param name="key">������ļ���</param>
        /// <param name="target">Ŀ�����</param>
        /// <param name="dependencyFilePath">�������ļ�����·��,�����ļ�����ʱ,�򽫸����Ƴ�����</param>
        public static void SetCache<T>(string key, T target, string dependencyFilePath)
        {
            try
            {
                //������������
                var dependency = new CacheDependency(dependencyFilePath);

                //��Ŀ�����洢��������
                HttpRuntime.Cache.Insert(key, target, dependency);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion

        #region ����3        
        /// <summary>
        /// д�뻺�桾����Сʱ��
        /// </summary>
        /// <typeparam name="T">Ŀ����������</typeparam>
        /// <param name="key">������ļ���</param>
        /// <param name="target">Ŀ�����</param>
        /// <param name="Hour">Сʱ</param>
        public static void SetCacheHours<T>(string key, T target, int Hour)
        {
            HttpRuntime.Cache.Insert(key, target, null, DateTime.Now.AddHours(Hour), Cache.NoSlidingExpiration,
                                     CacheItemPriority.Default, null);
        }
        /// <summary>
        /// д�뻺�桾���÷��ӡ�
        /// </summary>
        /// <typeparam name="T">Ŀ����������</typeparam>
        /// <param name="key">������ļ���</param>
        /// <param name="target">Ŀ�����</param>
        /// <param name="Minutes">����</param>
        public static void SetCacheMinutes<T>(string key, T target, int Minutes)
        {
            HttpRuntime.Cache.Insert(key, target, null, DateTime.Now.AddMinutes(Minutes), Cache.NoSlidingExpiration,
                                     CacheItemPriority.Default, null);
        }
        /// <summary>
        /// д�뻺�桾����������
        /// </summary>
        /// <typeparam name="T">Ŀ����������</typeparam>
        /// <param name="key">������ļ���</param>
        /// <param name="target">Ŀ�����</param>
        /// <param name="Days">����</param>
        public static void SetCacheDays<T>(string key, T target, int Days)
        {
            HttpRuntime.Cache.Insert(key, target, null, DateTime.Now.AddDays(Days), Cache.NoSlidingExpiration,
                                     CacheItemPriority.Default, null);
        }
        
        /// <summary>
        /// д�뻺�桾���ݿ�������
        /// </summary>
        /// <typeparam name="T">Ŀ����������</typeparam>
        /// <param name="key">������ļ���</param>
        /// <param name="target">Ŀ�����</param>
        /// <param name="dependency">sql������</param>
        public static void SetCacheDependency<T>(string key, T target, SqlCacheDependency dependency)
        {
            HttpRuntime.Cache.Insert(key, target, dependency, Cache.NoAbsoluteExpiration, Cache.NoSlidingExpiration);
        }
        /// <summary>
        /// д�뻺�桾����������
        /// </summary>
        /// <typeparam name="T">Ŀ����������</typeparam>
        /// <param name="key">������ļ���</param>
        /// <param name="target">Ŀ�����</param>
        /// <param name="Months">�·�</param>
        public static void SetCacheMonths<T>(string key, T target, int Months)
        {
            HttpRuntime.Cache.Insert(key, target, null, DateTime.Now.AddMonths(Months), Cache.NoSlidingExpiration,
                                     CacheItemPriority.Default, null);
        }
        /// <summary>
        /// д�뻺�桾����������
        /// </summary>
        /// <typeparam name="T">Ŀ����������</typeparam>
        /// <param name="key">������ļ���</param>
        /// <param name="target">Ŀ�����</param>
        /// <param name="Years">���</param>
        public static void SetCacheYears<T>(string key, T target, int Years)
        {
            HttpRuntime.Cache.Insert(key, target, null, DateTime.Now.AddYears(Years), Cache.NoSlidingExpiration,
                                     CacheItemPriority.Default, null);
        }

        /// <summary>
        /// д�뻺�桾���ϴη��ʺ� ? ���ӹ��ڡ�
        /// </summary>
        /// <typeparam name="T">Ŀ����������</typeparam>
        /// <param name="key">������ļ���</param>
        /// <param name="target">Ŀ�����</param>
        /// <param name="minute">���</param>
        public static void SaveCacheMinuteSliding<T>(string key, T target, int minute)
        {
            HttpRuntime.Cache.Insert(key, target, null, DateTime.MaxValue, TimeSpan.FromMinutes(minute));
        }

        /// <summary>
        /// д�뻺�桾�����ڡ�
        /// </summary>
        /// <typeparam name="T">Ŀ����������</typeparam>
        /// <param name="obj">������ļ���</param>
        /// <param name="key">Ŀ�����</param>
        public static void SavaCacheNoOverdue<T>(string key, T target)
        {
            HttpRuntime.Cache.Insert(key, target, null);
        }

        #endregion

        #endregion

        #region ��ȡ�����е�Ŀ�����

        /// <summary>
        /// ��ȡ�����е�Ŀ�����
        /// </summary>
        /// <typeparam name="T">Ŀ����������</typeparam>
        /// <param name="key">������ļ���</param>
        public static T GetCache<T>(string key)
        {
            //��ȡ�����е�Ŀ�����
            return ConvertHelper.ConvertTo<T>(HttpRuntime.Cache.Get(key));
        }

        #endregion

        #region ɾ��ָ������

        /// <summary>
        /// ��ջ���
        /// </summary>
        /// <param name="key">������ļ���</param>
        public static void ClearCache(string key)
        {
            if (null != HttpRuntime.Cache[key])
                HttpRuntime.Cache.Remove(key);
        }

        #endregion

        #region ���Ŀ������Ƿ�洢�ڻ�����

        /// <summary>
        /// ���Ŀ������Ƿ�洢�ڻ�����,���ڷ���true
        /// </summary>
        /// <param name="key">������ļ���</param>
        public static bool Contains(string key)
        {
            try
            {
                //��Ŀ�����洢��������
                return ValidationHelper.IsNullOrEmpty(HttpRuntime.Cache.Get(key)) ? false : true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion
    }
}