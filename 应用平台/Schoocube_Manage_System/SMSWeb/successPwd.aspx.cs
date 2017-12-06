using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSWeb
{
    public partial class successPwd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string user = decodeValue(Request.QueryString["user"]);
                string pwd = decodeValue(Request.QueryString["pwd"]);
                huser.Value = user;
                hpwd.Value = pwd;
            }
        }

        private static string decodeValue(string value)
        {
            if (value.Equals(""))
            {
                //throw new NullPointerException();
            }
            if (value.Length < 20)
            {
                //throw new NullPointerException();
            }
            string charLength = value.Substring(3, 2); //加密后的字符有多少位
            int charLen = Convert.ToInt32(charLength, 16); //转换成10进制
            int type = Convert.ToInt32(value.Substring(5, 1)); //加密字符的类型（0：数字，1：字符串）
            string valueEnc = value.Substring(6, charLen); //16进制字符串
            if (type == 0)
            {
                long trueValue = Convert.ToInt64(valueEnc, 16);
                return Convert.ToString(trueValue);
            }
            else
            {
                StringBuilder sb = new StringBuilder();
                string[] valueEncArray = StringSplit(valueEnc, "", true);
                for (int i = 1; i < valueEncArray.Length; i += 2)
                {
                    int value10 = Convert.ToInt32(valueEncArray[i] + valueEncArray[i + 1], 16); //转换成10进制的asc码
                    sb.Append(Convert.ToString((char)value10)); //asc码转换成字符
                }
                return sb.ToString();
            }

        }

        public static string[] StringSplit(string source, string regexDelimiter, bool trimTrailingEmptyStrings)
        {
            string[] splitArray = System.Text.RegularExpressions.Regex.Split(source, regexDelimiter);

            if (trimTrailingEmptyStrings)
            {
                if (splitArray.Length > 1)
                {
                    for (int i = splitArray.Length; i > 0; i--)
                    {
                        if (splitArray[i - 1].Length > 0)
                        {
                            if (i < splitArray.Length)
                                System.Array.Resize(ref splitArray, i);

                            break;
                        }
                    }
                }
            }

            return splitArray;
        }
    }
}