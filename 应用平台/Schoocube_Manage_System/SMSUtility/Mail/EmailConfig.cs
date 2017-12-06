﻿using SMSUtility.Mail.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSUtility.Mail
{
    public static class EmailConfig
    {
        public static EmailType TestEmailType = EmailType.QQ_FoxMail;
        /// <summary>
        /// 测试发送地址
        /// </summary>
        public static string TestFromAddress = System.Configuration.ConfigurationManager.AppSettings["SendPersonalMailUser"];
        public static string TestUserName = System.Configuration.ConfigurationManager.AppSettings["SendPersonalMailUser"];
        public static string TestPassword = System.Configuration.ConfigurationManager.AppSettings["SendPersonalMailPwd"];

        /// <summary>
        /// 测试收件地址  
        /// </summary>
        public static string TestToAddress = "";

        private static Dictionary<string, string> m_dicNameMap = null;
        /// <summary>
        /// 用于获取显示名称
        /// </summary>
        private static Dictionary<string, string> DicNameMap
        {
            get
            {
                if (m_dicNameMap == null)
                {
                    m_dicNameMap = new Dictionary<string, string>();
                    m_dicNameMap.Add(TestFromAddress, "系统管理员");
                    m_dicNameMap.Add(TestToAddress, "admin");
                }
                return m_dicNameMap;
            }
        }

        /// <summary>
        /// 获取邮件地址对应的显示名称
        /// </summary>
        /// <param name="address">邮件地址</param>
        /// <returns>邮件显示名称</returns>
        public static string GetAddressName(string address)
        {
            if (DicNameMap.ContainsKey(address))
                return DicNameMap[address];
            else
                return String.Empty;
        }
    }
}
