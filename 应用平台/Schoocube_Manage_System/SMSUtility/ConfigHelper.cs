using System;
using System.Configuration;

namespace SMSUtility
{
    /// <summary>
    /// web.config������
    /// </summary>
    public class ConfigHelper
    {
        

        #region �õ�AppSettings�е�����Bool��Ϣ
        /// <summary>
        /// �õ�AppSettings�е�����Bool��Ϣ
        /// </summary>
        /// <param name="key">keyֵ</param>
        /// <returns></returns>
        public static bool GetConfigBool(string key)
        {
            bool result = false;
            string cfgVal = GetConfigString(key);
            if (!string.IsNullOrEmpty(cfgVal))
            {
                try
                {
                    result = bool.Parse(cfgVal);
                }
                catch (FormatException)
                {
                    // Ignore format exceptions.
                }
            }
            return result;
        }
        #endregion

        #region �õ�AppSettings�е�����Decimal��Ϣ
        /// <summary>
        /// �õ�AppSettings�е�����Decimal��Ϣ
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public static decimal GetConfigDecimal(string key)
        {
            decimal result = 0;
            string cfgVal = GetConfigString(key);
            if (!string.IsNullOrEmpty(cfgVal))
            {
                try
                {
                    result = decimal.Parse(cfgVal);
                }
                catch (FormatException)
                {
                    // Ignore format exceptions.
                }
            }

            return result;
        }
        #endregion

        #region �õ�AppSettings�е�����int��Ϣ
        /// <summary>
        /// �õ�AppSettings�е�����int��Ϣ
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public static int GetConfigInt(string key)
        {
            int result = 0;
            string cfgVal = GetConfigString(key);
            if (!string.IsNullOrEmpty(cfgVal))
            {
                try
                {
                    result = int.Parse(cfgVal);
                }
                catch (FormatException)
                {
                    // Ignore format exceptions.
                }
            }

            return result;
        }
        #endregion
        #region �õ�ConnectionStrings�е������ַ�����Ϣ
        /// <summary>
        /// �õ�AppSettings�е������ַ�����Ϣ
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public static string GetConfigString(string key)
        {
            string result = string.Empty;
            if (!string.IsNullOrEmpty(key))
            {
                try
                {
                    result = ConfigurationManager.ConnectionStrings[key].ConnectionString;
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
            return result;
        }
        #endregion
    }
}