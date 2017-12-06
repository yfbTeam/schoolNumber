using System;
using System.Text;
using System.Text.RegularExpressions;

namespace SMSUtility

{
    /// <summary>
    /// ������֤��
    /// </summary>
    public class ValidationHelper
    {
        /*һЩ���õ�������ʽ
         * 
         * 
         * 
            ^\d+$����//ƥ��Ǹ������������� + 0�� 
            ^[0-9]*[1-9][0-9]*$����//ƥ�������� 
            ^((-\d+)|(0+))$����//ƥ����������������� + 0�� 
            ^-[0-9]*[1-9][0-9]*$����//ƥ�为���� 
            ^-?\d+$��������//ƥ������ 
            ^\d+(\.\d+)?$����//ƥ��Ǹ����������������� + 0�� 
            ^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$����//ƥ���������� 
            ^((-\d+(\.\d+)?)|(0+(\.0+)?))$����//ƥ��������������������� + 0�� 
            ^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$����//ƥ�为������ 
            ^(-?\d+)(\.\d+)?$����//ƥ�両���� 
            ^[A-Za-z]+$����//ƥ����26��Ӣ����ĸ��ɵ��ַ��� 
            ^[A-Z]+$����//ƥ����26��Ӣ����ĸ�Ĵ�д��ɵ��ַ��� 
            ^[a-z]+$����//ƥ����26��Ӣ����ĸ��Сд��ɵ��ַ��� 
            ^[A-Za-z0-9]+$����//ƥ�������ֺ�26��Ӣ����ĸ��ɵ��ַ��� 
            ^\w+$����//ƥ�������֡�26��Ӣ����ĸ�����»�����ɵ��ַ��� 
            ^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$��������//ƥ��email��ַ 
            ^[a-zA-z]+://ƥ��(\w+(-\w+)*)(\.(\w+(-\w+)*))*(\?\S*)?$����//ƥ��url 

            ƥ�������ַ���������ʽ�� [\u4e00-\u9fa5] 
            ƥ��˫�ֽ��ַ�(������������)��[^\x00-\xff] 
            ƥ����е�������ʽ��\n[\s| ]*\r 
            ƥ��HTML��ǵ�������ʽ��/<(.*)>.*<\/>|<(.*) \/>/ 
            ƥ����β�ո��������ʽ��(^\s*)|(\s*$) 
            ƥ��Email��ַ��������ʽ��\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)* 
            ƥ����ַURL��������ʽ��^[a-zA-z]+://(\w+(-\w+)*)(\.(\w+(-\w+)*))*(\?\S*)?$ 
            ƥ���ʺ��Ƿ�Ϸ�(��ĸ��ͷ������5-16�ֽڣ�������ĸ�����»���)��^[a-zA-Z][a-zA-Z0-9_]{4,15}$ 
            ƥ����ڵ绰���룺(\d{3}-|\d{4}-)?(\d{8}|\d{7})? 
            ƥ����ѶQQ�ţ�^[1-9]*[1-9][0-9]*$ 
         * */
        private static readonly Regex RegChzn = new Regex("[\u4e00-\u9fa5]");
        #region �������Ƿ�Ϊ��

        #region ����1

        /// <summary>
        /// �������Ƿ�Ϊ�գ�Ϊ�շ���true
        /// </summary>
        /// <typeparam name="T">Ҫ��֤�Ķ��������</typeparam>
        /// <param name="data">Ҫ��֤�Ķ���</param>        
        public static bool IsNullOrEmpty<T>(T data)
        {
            //���Ϊnull
            if (data == null)
            {
                return true;
            }

            //���Ϊ""
            if (data.GetType() == typeof(string))
            {
                if (string.IsNullOrEmpty(data.ToString().Trim()))
                {
                    return true;
                }
                return false;
            }

            //���ΪDBNull
            if (data.GetType() == typeof(DBNull))
            {
                return true;
            }

            //��Ϊ��
            return false;
        }

        #endregion

        #region ����2

        /// <summary>
        /// �������Ƿ�Ϊ�գ�Ϊ�շ���true
        /// </summary>
        /// <param name="data">Ҫ��֤�Ķ���</param>
        public static bool IsNullOrEmpty(object data)
        {
            return IsNullOrEmpty<object>(data);
        }

        #endregion

        #region ����3

        /// <summary>
        /// ����ַ����Ƿ�Ϊ�գ�Ϊ�շ���true
        /// </summary>
        /// <param name="text">Ҫ�����ַ���</param>
        public static bool IsNullOrEmpty(string text)
        {
            //����Ƿ�Ϊnull
            if (text == null)
            {
                return true;
            }

            //����ַ�����ֵ
            if (string.IsNullOrEmpty(text.Trim()))
            {
                return true;
            }
            return false;
        }

        #endregion

        #endregion

        #region ��������
        /// <summary>
        /// ��������
        /// </summary>
        /// <param name="text"></param>
        /// <returns></returns>
        public static bool IsWeakPasswurd(string text)
        {
            if (string.IsNullOrEmpty(text))
            {
                return false;
            }
            string[] WeakKey = new string[]{
            "qwerasdf","computer","zxczxczxc","dddddddd","299792458","135792468","20082008","369369369","5845211314","yangyang","csdncsdn","google250",
            "woaini520","zhang123","1234567b","wocaonima","1233211234567","9876543210","qaz123456","q123456789","321654987","369258147","aaa123456",
            "1357924680","123321aa","25257758","wojiushiwo","ssssssss","qazwsx123","123456aaa","1234567a","z123456789","woainima","44444444","buzhidao",
            "ffffffff","100200300","12345679","12369874","1122334455","111111","woaini123","qwe123456","xiaoxiao","123456654321","woshishui","12301230",
            "1234554321","5201314520","12345612","lilylily","123456asd","10101010","1q2w3e4r5t","11235813","12345600","11111111111111111111","wwwwwwww ",
            "0987654321","5845201314","zxcvbnm123","kingcom5","123456987","05962514787","321321321","woaiwojia","1qazxsw2","123qweasd","1234abcd","woaini1314",
            "12345678a","q1w2e3r4","asdfghjk","1123581321","123698745","asdf1234","521521521","147852369","123456qq","3.1415926","qweqweqwe","111222333","zzzzzzzz",
            "ms0083jxj","11112222","code8925","qweasdzxc","77777777","asd123456","qwer1234","33333333","55555555","741852963","963852741","520520520","123456123456",
            "999999999","123456aa","99999999","asdfasdf","aa123456","123456789a","qwertyui","1234qwer","a1234567","123456123","123456","a12345678","abc123456","123321123",
            "22222222","asdasdasd","110110110","12341234","abcd1234","qazwsxedc","12121212","123654789","0123456789","123456abc","1q2w3e4r","asdfghjkl","0000000000","12344321",
            "31415926","iloveyou","qq123456","qwertyuiop","000000000","qqqqqqqq","87654321","password","789456123","xiazhili","1qaz2wsx","11223344","a123456789","66666666","1111111111",
            "aaaaaaaa","987654321","47258369","111111111","88888888","1234567890","123123123","00000000","dearbook","11111111","12345678","123456789","123456"        
            };
            for (int i = 0; i < WeakKey.Length; i++)
            {
                ///���Դ�Сд�Ƚϣ�
                if (WeakKey[i].Equals(text, StringComparison.CurrentCultureIgnoreCase))
                {
                    return false;
                }
            }
            //�����ȫͨ����֤���򷵻���ȷ
            return true;
        }
        #endregion

        #region ��֤IP��ַ�Ƿ�Ϸ�

        /// <summary>
        /// ��֤IP��ַ�Ƿ�Ϸ�
        /// </summary>
        /// <param name="ip">Ҫ��֤��IP��ַ</param>        
        public static bool IsIp(string ip)
        {
            //���Ϊ�գ���Ϊ��֤�ϸ�
            if (IsNullOrEmpty(ip))
            {
                return true;
            }

            //���Ҫ��֤�ַ����еĿո�
            ip = ip.Trim();

            //ģʽ�ַ���
            const string pattern = @"^((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)$";

            //��֤
            return IsMatch(ip, pattern);
        }

        #endregion

        #region  ��֤EMail�Ƿ�Ϸ�

        /// <summary>
        /// ��֤EMail�Ƿ�Ϸ�
        /// </summary>
        /// <param name="email">Ҫ��֤��Email</param>
        public static bool IsEmail(string email)
        {
            //���Ϊ�գ���Ϊ��֤�ϸ�
            if (IsNullOrEmpty(email))
            {
                return true;
            }

            //���Ҫ��֤�ַ����еĿո�
            email = email.Trim();

            //ģʽ�ַ���
            const string pattern = @"^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$";

            //��֤
            return IsMatch(email, pattern);
        }

        #endregion

        #region ��֤�Ƿ�Ϊ����

        /// <summary>
        /// ��֤�Ƿ�Ϊ����
        /// </summary>
        /// <param name="number">Ҫ��֤������</param>        
        public static bool IsInt(string number)
        {
            //���Ϊ�գ���Ϊ��֤�ϸ�
            if (IsNullOrEmpty(number))
            {
                return true;
            }

            //���Ҫ��֤�ַ����еĿո�
            number = number.Trim();

            //ģʽ�ַ���
            const string pattern = @"^[1-9]+[0-9]*$";

            //��֤
            return IsMatch(number, pattern);
        }

        #endregion

        #region ��֤�Ƿ�Ϊ����

        /// <summary>
        /// ��֤�Ƿ�Ϊ����
        /// </summary>
        /// <param name="number">Ҫ��֤������</param>        
        public static bool IsNumber(string number)
        {
            //���Ϊ�գ���Ϊ��֤�ϸ�
            if (IsNullOrEmpty(number))
            {
                return true;
            }

            //���Ҫ��֤�ַ����еĿո�
            number = number.Trim();

            //ģʽ�ַ���
            const string pattern = @"^[1-9]+[0-9]*[.]?[0-9]*$";

            //��֤
            return IsMatch(number, pattern);
        }

        #endregion

        #region ��֤�����Ƿ�Ϸ�

        /// <summary>
        /// ��֤�����Ƿ�Ϸ�,�Բ���������˼򵥴���
        /// </summary>
        /// <param name="date">����</param>
        public static bool IsDate(ref string date)
        {
            //���Ϊ�գ���Ϊ��֤�ϸ�
            if (IsNullOrEmpty(date))
            {
                return true;
            }

            //���Ҫ��֤�ַ����еĿո�
            date = date.Trim();

            //�滻\
            date = date.Replace(@"\", "-");
            //�滻/
            date = date.Replace(@"/", "-");

            //������ҵ�����"��",����Ϊ�ǵ�ǰ����
            if (date.IndexOf("��") != -1)
            {
                date = DateTime.Now.ToString();
            }

            try
            {
                //��ת�������Ƿ�Ϊ����������ַ�
                date = Convert.ToDateTime(date).ToString("d");
                return true;
            }
            catch
            {
                //��������ַ����д��ڷ����֣��򷵻�false
                if (!IsInt(date))
                {
                    return false;
                }

                #region �Դ����ֽ��н���

                //��8λ�����ֽ��н���
                if (date.Length == 8)
                {
                    //��ȡ������
                    string year = date.Substring(0, 4);
                    string month = date.Substring(4, 2);
                    string day = date.Substring(6, 2);

                    //��֤�Ϸ���
                    if (Convert.ToInt32(year) < 1900 || Convert.ToInt32(year) > 2100)
                    {
                        return false;
                    }
                    if (Convert.ToInt32(month) > 12 || Convert.ToInt32(day) > 31)
                    {
                        return false;
                    }

                    //ƴ������
                    date = Convert.ToDateTime(year + "-" + month + "-" + day).ToString("d");
                    return true;
                }

                //��6λ�����ֽ��н���
                if (date.Length == 6)
                {
                    //��ȡ����
                    string year = date.Substring(0, 4);
                    string month = date.Substring(4, 2);

                    //��֤�Ϸ���
                    if (Convert.ToInt32(year) < 1900 || Convert.ToInt32(year) > 2100)
                    {
                        return false;
                    }
                    if (Convert.ToInt32(month) > 12)
                    {
                        return false;
                    }

                    //ƴ������
                    date = Convert.ToDateTime(year + "-" + month).ToString("d");
                    return true;
                }

                //��5λ�����ֽ��н���
                if (date.Length == 5)
                {
                    //��ȡ����
                    string year = date.Substring(0, 4);
                    string month = date.Substring(4, 1);

                    //��֤�Ϸ���
                    if (Convert.ToInt32(year) < 1900 || Convert.ToInt32(year) > 2100)
                    {
                        return false;
                    }

                    //ƴ������
                    date = year + "-" + month;
                    return true;
                }

                //��4λ�����ֽ��н���
                if (date.Length == 4)
                {
                    //��ȡ��
                    string year = date.Substring(0, 4);

                    //��֤�Ϸ���
                    if (Convert.ToInt32(year) < 1900 || Convert.ToInt32(year) > 2100)
                    {
                        return false;
                    }

                    //ƴ������
                    date = Convert.ToDateTime(year).ToString("d");
                    return true;
                }

                #endregion

                return false;
            }
        }

        #endregion

        #region ��֤���֤�Ƿ�Ϸ�

        /// <summary>
        /// ��֤���֤�Ƿ�Ϸ�
        /// </summary>
        /// <param name="idCard">Ҫ��֤�����֤</param>        
        public static bool IsIdCard(string idCard)
        {
            //���Ϊ�գ���Ϊ��֤�ϸ�
            if (IsNullOrEmpty(idCard))
            {
                return true;
            }

            //���Ҫ��֤�ַ����еĿո�
            idCard = idCard.Trim();

            //ģʽ�ַ���
            var pattern = new StringBuilder();
            pattern.Append(@"^(11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|");
            pattern.Append(@"50|51|52|53|54|61|62|63|64|65|71|81|82|91)");
            pattern.Append(@"(\d{13}|\d{15}[\dx])$");

            //��֤
            return IsMatch(idCard, pattern.ToString());
        }

        #endregion

        #region ���ͻ����������Ƿ���Σ���ַ���

        /// <summary>
        /// ���ͻ�������ַ����Ƿ���Ч,����ԭʼ�ַ����޸�Ϊ��Ч�ַ�������ַ�����
        /// ����⵽�ͻ����������й�����Σ���ַ���,�򷵻�false,��Ч����true��
        /// </summary>
        /// <param name="input">Ҫ�����ַ���</param>
        public static bool IsValidInput(ref string input)
        {
            try
            {
                if (IsNullOrEmpty(input))
                {
                    //����ǿ�ֵ,������
                    return true;
                }
                //���� ' --  
                string pattern1 = @"(\%27)|(\')|(\-\-)";
                //��ִֹ�� ' or  
                string pattern2 = @"((\%27)|(\'))\s*((\%6F)|o|(\%4F))((\%72)|r|(\%52))";
                //��ִֹ��sql server �ڲ��洢���̻���չ�洢����  
                string pattern3 = @"\s+exec(\s|\+)+(s|x)p\w+";
                input = Regex.Replace(input, pattern1,"-", RegexOptions.IgnoreCase);
                input = Regex.Replace(input, pattern2, "o r", RegexOptions.IgnoreCase);
                input = Regex.Replace(input, pattern3, "e xec", RegexOptions.IgnoreCase); 
                //�滻������
                input = input.Replace("'", "''").Trim();
                //δ��⵽�����ַ���
                return false;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// ����Ƿ��зǷ��ַ�
        /// </summary>
        /// <remarks>����Ƿ��зǷ��ַ�</remarks>
        /// <param name="str">Ҫ�����ַ���</param>
        /// <returns></returns>
        public static bool IsValidInput(string str)
        {
            bool result = false;
            if (string.IsNullOrEmpty(str))
                return false;
            const string strBadChar = "@@,+,',--,%,^,&,?,(,),<,>,[,],{,},/,\\,;,:,\",\"\"";
            string[] arrBadChar = StringHelper.SplitString(strBadChar, ",");
            string tempChar = str;
            for (int i = 0; i < arrBadChar.Length; i++)
            {
                if (tempChar.IndexOf(arrBadChar[i]) >= 0)
                    result = true;
            }
            return result;
        }

        #endregion

        #region ��֤�����ַ����Ƿ���ģʽ�ַ���ƥ��

        #region ����1

        /// <summary>
        /// ��֤�����ַ����Ƿ���ģʽ�ַ���ƥ�䣬ƥ�䷵��true
        /// </summary>
        /// <param name="input">�����ַ���</param>
        /// <param name="pattern">ģʽ�ַ���</param>        
        public static bool IsMatch(string input, string pattern)
        {
            return IsMatch(input, pattern, RegexOptions.IgnoreCase);
        }

        #endregion

        #region ����2

        /// <summary>
        /// ��֤�����ַ����Ƿ���ģʽ�ַ���ƥ�䣬ƥ�䷵��true
        /// </summary>
        /// <param name="input">������ַ���</param>
        /// <param name="pattern">ģʽ�ַ���</param>
        /// <param name="options">ɸѡ����,�����Ƿ���Դ�Сд</param>
        public static bool IsMatch(string input, string pattern, RegexOptions options)
        {
            return Regex.IsMatch(input, pattern, options);
        }

        #endregion

        #endregion

        #region ��ȡƥ���ֵ

        #region ����1

        /// <summary>
        /// ��ȡƥ���ֵ
        /// </summary>
        /// <param name="input">�����ַ���</param>
        /// <param name="pattern">ģʽ�ַ���</param>
        /// <param name="resultPattern">���ģʽ�ַ���,������"$1"������ȡ��һ��( )�ڵ�ֵ</param>
        /// <param name="options">ɸѡ����,�����Ƿ���Դ�Сд</param>
        public static string GetMatchValue(string input, string pattern, string resultPattern, RegexOptions options)
        {
            //�ж��Ƿ�ƥ��
            return Regex.IsMatch(input, pattern, options)
                       ? Regex.Match(input, pattern, options).Result(resultPattern)
                       : string.Empty;
        }

        #endregion

        #region ����2

        /// <summary>
        /// ��ȡƥ���ֵ
        /// </summary>
        /// <param name="input">�����ַ���</param>
        /// <param name="pattern">ģʽ�ַ���</param>
        /// <param name="resultPattern">���ģʽ�ַ���,������"$1"������ȡ��һ��( )�ڵ�ֵ</param>
        public static string GetMatchValue(string input, string pattern, string resultPattern)
        {
            return GetMatchValue(input, pattern, resultPattern, RegexOptions.IgnoreCase);
        }

        #endregion

        #region ����3

        /// <summary>
        /// ��ȡƥ���ֵ
        /// </summary>
        /// <param name="input">�����ַ���</param>
        /// <param name="pattern">ģʽ�ַ���</param>
        public static string GetMatchValue(string input, string pattern)
        {
            return Regex.IsMatch(input, pattern, RegexOptions.IgnoreCase)
                       ? Regex.Match(input, pattern, RegexOptions.IgnoreCase).Value
                       : string.Empty;
        }

        #endregion

        #endregion

        #region ����Ƿ��������ַ�

        /// <summary>
        /// ����Ƿ��������ַ�
        /// </summary>
        /// <param name="inputData"></param>
        /// <returns></returns>
        public static bool IsHasChzn(string inputData)
        {
            Match m = RegChzn.Match(inputData);
            return m.Success;
        }

        #endregion

        #region ����Ƿ���ϵ绰��ʽ

        /// <summary>
        /// ����Ƿ���ϵ绰��ʽ
        /// </summary>
        /// <param name="phoneNumber"></param>
        /// <returns></returns>
        public static bool IsPhoneNumber(string phoneNumber)
        {
            return Regex.IsMatch(phoneNumber, @"(^[0-9]{3,4}\-[0-9]{3,8}$)|(^[0-9]{3,8}$)|(^\([0-9]{3,4}\)[0-9]{3,8}$)");
        }

        #endregion

        #region ����Ƿ��ֻ������ʽ

        /// <summary>
        /// ����Ƿ��ֻ������ʽ
        /// </summary>
        /// <param name="phoneNumber"></param>
        /// <returns></returns>
        public static bool IsMobiletelePhone(string phoneNumber)
        {
            return Regex.IsMatch(phoneNumber, "^13[0-9]{1}[0-9]{8}$|^15[9]{1}[0-9]{8}$");
        }

        #endregion

        #region ����Ƿ����url��ʽ,ǰ����躬��http://

        /// <summary>
        /// ����Ƿ����url��ʽ,ǰ����躬��http://
        /// </summary>
        /// <param name="url"></param>
        /// <returns></returns>
        public static bool IsUrl(string url)
        {
            if (string.IsNullOrEmpty(url))
            {
                return false;
            }
            return Regex.IsMatch(url, @"^http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?$");
        }

        public static bool IsNoHttpUrl(string url)
        {
            if (string.IsNullOrEmpty(url))
            {
                return false;
            }
            return Regex.IsMatch(url, @"^/([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?$");
        }

        #endregion

        #region ����Ƿ����ʱ���ʽ

        /// <summary>
        /// ����Ƿ����ʱ���ʽ
        /// </summary>
        /// <returns></returns>
        public static bool IsTime(string timeval)
        {
            return Regex.IsMatch(timeval,
                                 @"20\d{2}\-[0-1]{1,2}\-[0-3]?[0-9]?(\s*((([0-1]?[0-9])|(2[0-3])):([0-5]?[0-9])(:[0-5]?[0-9])?))?");
        }

        #endregion

        #region ����Ƿ�����ʱ��ʽ

        /// <summary>
        /// ����Ƿ�����ʱ��ʽ
        /// </summary>
        /// <param name="postCode"></param>
        /// <returns></returns>
        public static bool IsPostCode(string postCode)
        {
            return Regex.IsMatch(postCode, @"^\d{6}$");
        }

        #endregion

        #region ��֤�Ƿ�Ϊ����,ƴ������

        /// <summary>
        ///  ��֤�Ƿ�Ϊ����,ƴ������
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        public static bool IsNts(string input)
        {
            return Regex.IsMatch(input, "^[a-zA-Z0-9\\u4e00-\\u9fa5]+$");
        }

        #endregion
    }
}