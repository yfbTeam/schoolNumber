using System;
using System.Linq;
using System.Security.Cryptography;
using System.Text;

namespace SMSUtility
{
    /// <summary>
    /// �õ������ȫ�루��ϣ���ܣ���
    /// </summary>
    public class HashEncodeHelper
    {
        /// <summary>
        /// �õ������ϣ�����ַ���
        /// </summary>
        /// <returns></returns>
        public static string GetSecurity()
        {
            string security = HashEncoding(GetRandomValue());
            return security;
        }

        /// <summary>
        /// �õ�һ�������ֵ
        /// </summary>
        /// <returns></returns>
        public static string GetRandomValue()
        {
            var seed = new Random();
            string randomVaule = seed.Next(1, int.MaxValue).ToString();
            return randomVaule;
        }

        /// <summary>
        /// ��ϣ����һ���ַ���
        /// </summary>
        /// <param name="security"></param>
        /// <returns></returns>
        public static string HashEncoding(string security)
        {
            var code = new UnicodeEncoding();
            byte[] message = code.GetBytes(security);
            var arithmetic = new SHA512Managed();
            byte[] value = arithmetic.ComputeHash(message);
            return value.Aggregate("", (current, o) => current + ((int) o + "O"));
        }
    }
}