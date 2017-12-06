using System;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;

namespace SMSUtility
{
    /// <summary>
    /// ������������ת��������ת��������ת����ص���
    /// </summary>    
    public class ConvertHelper
    {
        #region ����λ��

        /// <summary>
        /// ָ���ַ����Ĺ̶����ȣ�����ַ���С�ڹ̶����ȣ�
        /// �����ַ�����ǰ�油���㣬�����õĹ̶��������Ϊ9λ
        /// </summary>
        /// <param name="text">ԭʼ�ַ���</param>
        /// <param name="limitedLength">�ַ����Ĺ̶�����</param>
        public static string RepairZero(string text, int limitedLength)
        {
            //����0���ַ���
            string temp = "";

            //����0
            for (int i = 0; i < limitedLength - text.Length; i++)
            {
                temp += "0";
            }

            //����text
            temp += text;

            //���ز���0���ַ���
            return temp;
        }

        #endregion

        #region ����������ת��

        /// <summary>
        /// ʵ�ָ����������ת����ConvertBase("15",10,16)��ʾ��ʮ������15ת��Ϊ16���Ƶ�����
        /// </summary>
        /// <param name="value">Ҫת����ֵ,��ԭֵ</param>
        /// <param name="from">ԭֵ�Ľ���,ֻ����2,8,10,16�ĸ�ֵ��</param>
        /// <param name="to">Ҫת������Ŀ����ƣ�ֻ����2,8,10,16�ĸ�ֵ��</param>
        public static string ConvertBase(string value, int from, int to)
        {
            try
            {
                int intValue = Convert.ToInt32(value, from); //��ת��10����
                string result = Convert.ToString(intValue, to); //��ת��Ŀ�����
                if (to == 2)
                {
                    int resultLength = result.Length; //��ȡ�����Ƶĳ���
                    switch (resultLength)
                    {
                        case 7:
                            result = "0" + result;
                            break;
                        case 6:
                            result = "00" + result;
                            break;
                        case 5:
                            result = "000" + result;
                            break;
                        case 4:
                            result = "0000" + result;
                            break;
                        case 3:
                            result = "00000" + result;
                            break;
                    }
                }
                return result;
            }
            catch
            {
                return "0";
            }
        }

        #endregion

        #region ʹ��ָ���ַ�����stringת����byte[]

        /// <summary>
        /// ��stringת����byte[]
        /// </summary>
        /// <param name="text">Ҫת�����ַ���</param>        
        public static byte[] StringToBytes(string text)
        {
            return Encoding.UTF8.GetBytes(text);
        }

        /// <summary>
        /// ʹ��ָ���ַ�����stringת����byte[]
        /// </summary>
        /// <param name="text">Ҫת�����ַ���</param>
        /// <param name="encoding">�ַ�����</param>
        public static byte[] StringToBytes(string text, Encoding encoding)
        {
            return encoding.GetBytes(text);
        }

        #endregion

        #region ʹ��ָ���ַ�����byte[]ת����string

        /// <summary>
        /// ��byte[]ת����string
        /// </summary>
        /// <param name="bytes">Ҫת�����ֽ�����</param>        
        public static string BytesToString(byte[] bytes)
        {
            return Encoding.UTF8.GetString(bytes);
        }

        /// <summary>
        /// ʹ��ָ���ַ�����byte[]ת����string
        /// </summary>
        /// <param name="bytes">Ҫת�����ֽ�����</param>
        /// <param name="encoding">�ַ�����</param>
        public static string BytesToString(byte[] bytes, Encoding encoding)
        {
            return encoding.GetString(bytes);
        }

        #endregion

        #region ����ת�����ַ���

        /// <summary>
        /// ����ת�����ַ���,ͬʱ�رո���
        /// </summary>
        /// <param name="stream">��</param>
        /// <param name="encoding">�ַ�����</param>
        public static string StreamToString(Stream stream, Encoding encoding)
        {
            //��ȡ���ı�
            string streamText;

            //��ȡ��
            try
            {
                using (var reader = new StreamReader(stream, encoding))
                {
                    streamText = reader.ReadToEnd();
                }
            }
            catch
            {
                return string.Empty;
            }
            finally
            {
                stream.Close();
            }

            //�����ı�
            return streamText;
        }

        /// <summary>
        /// ����ת�����ַ���,ͬʱ�رո���
        /// </summary>
        /// <param name="stream">��</param>
        public static string StreamToString(Stream stream)
        {
            return StreamToString(stream, Encoding.Default);
        }

        #endregion

        #region ��byte[]ת����int

        /// <summary>
        /// ��byte[]ת����int
        /// </summary>
        /// <param name="data">��Ҫת����������byte����</param>
        public static int BytesToInt32(byte[] data)
        {
            //���������ֽ����鳤��С��4,�򷵻�0
            if (data.Length < 4)
            {
                return 0;
            }

            //����Ҫ���ص�����
            int num = 0;

            //���������ֽ����鳤�ȴ���4,��Ҫ���д���
            if (data.Length >= 4)
            {
                //����һ����ʱ������
                var tempBuffer = new byte[4];

                //��������ֽ������ǰ4���ֽڸ��Ƶ���ʱ������
                Buffer.BlockCopy(data, 0, tempBuffer, 0, 4);

                //����ʱ��������ֵת����������������num
                num = BitConverter.ToInt32(tempBuffer, 0);
            }

            //��������
            return num;
        }

        #endregion

        #region ת��Ϊ����

        /// <summary>
        /// ������ת��Ϊ����,���������Ч�򷵻�"1900-1-1"
        /// </summary>
        /// <param name="date">����</param>
        public static DateTime ToDateTime(object date)
        {
            try
            {
                if (ValidationHelper.IsNullOrEmpty(date))
                {
                    return Convert.ToDateTime("1900-1-1");
                }
                else
                {
                    return Convert.ToDateTime(date);
                }
            }
            catch
            {
                return Convert.ToDateTime("1900-1-1");
            }
        }

        #endregion

        #region ������ת��ΪGUID

        /// <summary>
        /// ������ת��ΪGUID
        /// </summary>
        /// <param name="data"></param>
        public static Guid ToGuid(object data)
        {
            //��Ч����֤
            if (ValidationHelper.IsNullOrEmpty(data))
            {
                return Guid.Empty;
            }

            try
            {
                return new Guid(data.ToString());
            }
            catch
            {
                return Guid.Empty;
            }
        }

        #endregion

        #region ������ת��Ϊ����

        #region ����1

        /// <summary>
        /// ������ת��Ϊ����
        /// </summary>
        /// <typeparam name="T">���ݵ�����</typeparam>
        /// <param name="data">Ҫת��������</param>
        public static int ToInt32<T>(T data)
        {
            try
            {
                //���Ϊ���򷵻�0
                if (ValidationHelper.IsNullOrEmpty(data))
                {
                    return 0;
                }
                else
                {
                    return Convert.ToInt32(data);
                }
            }
            catch
            {
                return 0;
            }
        }

        #endregion

        #region ����2

        /// <summary>
        /// ������ת��Ϊ����
        /// </summary>
        /// <param name="data">Ҫת��������</param>
        public static int ToInt32(object data)
        {
            try
            {
                //���Ϊ���򷵻�0
                if (ValidationHelper.IsNullOrEmpty(data))
                {
                    return 0;
                }
                else
                {
                    return Convert.ToInt32(data);
                }
            }
            catch
            {
                return 0;
            }
        }

        #endregion

        #endregion

        #region ������ת��Ϊ�ַ���

        /// <summary>
        /// ������ת��Ϊ�ַ���
        /// </summary>
        /// <param name="data">����</param>
        public static string ToString(object data)
        {
            //��Ч����֤
            if (data == null)
            {
                return string.Empty;
            }

            return data.ToString();
        }

        #endregion

        #region ������ת��Ϊ������

        #region ����1

        /// <summary>
        /// ������ת��Ϊ������
        /// </summary>
        /// <typeparam name="T">���ݵ�����</typeparam>
        /// <param name="data">Ҫת��������</param>
        public static bool ToBoolean<T>(T data)
        {
            try
            {
                //���Ϊ���򷵻�false
                if (ValidationHelper.IsNullOrEmpty(data))
                {
                    return false;
                }
                else
                {
                    return Convert.ToBoolean(data);
                }
            }
            catch
            {
                return false;
            }
        }

        #endregion

        #region ����2

        /// <summary>
        /// ������ת��Ϊ������
        /// </summary>
        /// <param name="data">Ҫת��������</param>
        public static bool ToBoolean(object data)
        {
            try
            {
                //���Ϊ���򷵻�false
                if (ValidationHelper.IsNullOrEmpty(data))
                {
                    return false;
                }
                else
                {
                    return Convert.ToBoolean(data);
                }
            }
            catch
            {
                return false;
            }
        }

        #endregion

        #endregion

        #region ������ת��Ϊ�����ȸ�����

        #region ����1

        /// <summary>
        /// ������ת��Ϊ�����ȸ�����
        /// </summary>
        /// <typeparam name="T">���ݵ�����</typeparam>
        /// <param name="data">Ҫת��������</param>
        public static float ToFloat<T>(T data)
        {
            try
            {
                //���Ϊ���򷵻�0
                if (ValidationHelper.IsNullOrEmpty(data))
                {
                    return 0;
                }
                else
                {
                    return Convert.ToSingle(data);
                }
            }
            catch
            {
                return 0;
            }
        }

        #endregion

        #region ����2

        /// <summary>
        /// ������ת��Ϊ�����ȸ�����
        /// </summary>
        /// <param name="data">Ҫת��������</param>
        public static float ToFloat(object data)
        {
            try
            {
                //���Ϊ���򷵻�0
                if (ValidationHelper.IsNullOrEmpty<object>(data))
                {
                    return 0;
                }
                else
                {
                    return Convert.ToSingle(data);
                }
            }
            catch
            {
                return 0;
            }
        }

        #endregion

        #endregion

        #region ������ת��Ϊ˫���ȸ�����

        #region ����1

        /// <summary>
        /// ������ת��Ϊ˫���ȸ�����
        /// </summary>
        /// <typeparam name="T">���ݵ�����</typeparam>
        /// <param name="data">Ҫת��������</param>
        public static double ToDouble<T>(T data)
        {
            try
            {
                //���Ϊ���򷵻�0
                if (ValidationHelper.IsNullOrEmpty(data))
                {
                    return 0;
                }
                else
                {
                    return Convert.ToDouble(data);
                }
            }
            catch
            {
                return 0;
            }
        }

        #endregion

        #region ����2

        /// <summary>
        /// ������ת��Ϊ˫���ȸ�����,������С��λ
        /// </summary>
        /// <typeparam name="T">���ݵ�����</typeparam>
        /// <param name="data">Ҫת��������</param>
        /// <param name="decimals">С����λ��</param>
        public static double ToDouble<T>(T data, int decimals)
        {
            try
            {
                //���Ϊ���򷵻�0
                if (ValidationHelper.IsNullOrEmpty(data))
                {
                    return 0;
                }
                else
                {
                    double temp = Convert.ToDouble(data);
                    return Math.Round(temp, decimals);
                }
            }
            catch
            {
                return 0;
            }
        }

        #endregion

        #region ����3

        /// <summary>
        /// ������ת��Ϊ˫���ȸ�����
        /// </summary>
        /// <param name="data">Ҫת��������</param>
        public static double ToDouble(object data)
        {
            try
            {
                //���Ϊ���򷵻�0
                if (ValidationHelper.IsNullOrEmpty(data))
                {
                    return 0;
                }
                else
                {
                    return Convert.ToDouble(data);
                }
            }
            catch
            {
                return 0;
            }
        }

        #endregion

        #region ����4

        /// <summary>
        /// ������ת��Ϊ˫���ȸ�����,������С��λ
        /// </summary>
        /// <param name="data">Ҫת��������</param>
        /// <param name="decimals">С����λ��</param>
        public static double ToDouble(object data, int decimals)
        {
            try
            {
                //���Ϊ���򷵻�0
                if (ValidationHelper.IsNullOrEmpty<object>(data))
                {
                    return 0;
                }
                else
                {
                    double temp = Convert.ToDouble(data);
                    return Math.Round(temp, decimals);
                }
            }
            catch
            {
                return 0;
            }
        }

        #endregion

        #endregion

        #region ������ת��ΪDecimal����

        #region ����1

        /// <summary>
        /// ������ת��ΪDecimal����
        /// </summary>
        /// <typeparam name="T">���ݵ�����</typeparam>
        /// <param name="data">Ҫת��������</param>
        public static decimal ToDecimal<T>(T data)
        {
            try
            {
                //���Ϊ���򷵻�0
                if (ValidationHelper.IsNullOrEmpty(data))
                {
                    return 0;
                }
                else
                {
                    return Convert.ToDecimal(data);
                }
            }
            catch
            {
                return 0;
            }
        }

        #endregion

        #region ����2

        /// <summary>
        /// ������ת��ΪDecimal����
        /// </summary>
        /// <typeparam name="T">���ݵ�����</typeparam>
        /// <param name="data">Ҫת��������</param>
        /// <param name="decimals">С����λ��</param>
        public static decimal ToDecimal<T>(T data, int decimals)
        {
            try
            {
                //���Ϊ���򷵻�0
                if (ValidationHelper.IsNullOrEmpty(data))
                {
                    return 0;
                }
                else
                {
                    decimal temp = Convert.ToDecimal(data);
                    return Math.Round(temp, decimals);
                }
            }
            catch
            {
                return 0;
            }
        }

        #endregion

        #region ����3

        /// <summary>
        /// ������ת��ΪDecimal����
        /// </summary>
        /// <param name="data">Ҫת��������</param>
        public static decimal ToDecimal(object data)
        {
            try
            {
                //���Ϊ���򷵻�0
                if (ValidationHelper.IsNullOrEmpty(data))
                {
                    return 0;
                }
                else
                {
                    return Convert.ToDecimal(data);
                }
            }
            catch
            {
                return 0;
            }
        }

        #endregion

        #region ����4

        /// <summary>
        /// ������ת��ΪDecimal����
        /// </summary>
        /// <param name="data">Ҫת��������</param>
        /// <param name="decimals">С����λ��</param>
        public static decimal ToDecimal(object data, int decimals)
        {
            try
            {
                //���Ϊ���򷵻�0
                if (ValidationHelper.IsNullOrEmpty<object>(data))
                {
                    return 0;
                }
                else
                {
                    decimal temp = Convert.ToDecimal(data);
                    return Math.Round(temp, decimals);
                }
            }
            catch
            {
                return 0;
            }
        }

        #endregion

        #endregion

        #region ������ת��Ϊָ������

        #region ����һ

        /// <summary>
        /// ������ת��Ϊָ������
        /// </summary>
        /// <param name="data">ת��������</param>
        /// <param name="targetType">ת����Ŀ������</param>
        public static object ConvertTo(object data, Type targetType)
        {
            //�������Ϊ�գ��򷵻�
            if (ValidationHelper.IsNullOrEmpty(data))
            {
                return null;
            }

            try
            {
                //�������ʵ����IConvertible�ӿڣ���ת������
                if (data is IConvertible)
                {
                    return Convert.ChangeType(data, targetType);
                }
                else
                {
                    return data;
                }
            }
            catch
            {
                return null;
            }
        }

        #endregion

        #region ���ض�

        /// <summary>
        /// ������ת��Ϊָ������
        /// </summary>
        /// <typeparam name="T">ת����Ŀ������</typeparam>
        /// <param name="data">ת��������</param>
        public static T ConvertTo<T>(object data)
        {
            //�������Ϊ�գ��򷵻�
            if (ValidationHelper.IsNullOrEmpty(data))
            {
                return default(T);
            }

            try
            {
                //���������T���ͣ���ֱ��ת��
                if (data is T)
                {
                    return (T)data;
                }

                //���Ŀ��������ö��
                if (typeof(T).BaseType == typeof(Enum))
                {
                    return EnumHelper.GetInstance<T>(data);
                }

                //�������ʵ����IConvertible�ӿڣ���ת������
                if (data is IConvertible)
                {
                    return (T)Convert.ChangeType(data, typeof(T));
                }
                else
                {
                    return default(T);
                }
            }
            catch
            {
                return default(T);
            }
        }

        #endregion

        #endregion

        /// <summary>
        /// string��ת��Ϊbool��
        /// </summary>
        /// <param name="strValue">Ҫת�����ַ���</param>
        /// <returns>ת�����bool���ͽ��</returns>
        public static bool StrToBool(string strValue)
        {
            if (!string.IsNullOrEmpty(strValue))
            {
                strValue = strValue.Trim();
                return (((string.Compare(strValue, "true", true) == 0) || (string.Compare(strValue, "yes", true) == 0)) ||
                        (string.Compare(strValue, "1", true) == 0));
            }
            return false;
        }

        /// <summary>
        /// string��ת��Ϊʱ����
        /// </summary>
        /// <param name="strValue">Ҫת�����ַ���</param>
        /// <param name="defValue">ȱʡֵ</param>
        /// <returns>ת�����ʱ�����ͽ��</returns>
        public static DateTime StrToDateTime(object strValue, DateTime defValue)
        {
            if ((strValue == null) || (strValue.ToString().Length > 20))
            {
                return defValue;
            }

            DateTime intValue;

            if (!DateTime.TryParse(strValue.ToString(), out intValue))
            {
                intValue = defValue;
            }
            return intValue;
        }

        /// <summary>
        /// �������long��ת��ΪDateTime��
        /// </summary>
        /// <param name="inputLong">long��ֵ</param>
        /// <returns></returns>
        public static DateTime BigIntToDateTime(long inputLong)
        {
            DateTime beginTime = DateTime.Now.Date;
            DateTime.TryParse("1970-01-01", out beginTime);
            double addDays = inputLong / (double)(24 * 3600);

            return beginTime.AddDays(addDays);
        }

        /// <summary>
        /// object��ת��Ϊdecimal��
        /// </summary>
        /// <param name="strValue">Ҫת�����ַ���</param>
        /// <returns>ת�����decimal���ͽ��</returns>
        public static decimal StrToDecimal(object strValue)
        {
            if (!Convert.IsDBNull(strValue) && !Equals(strValue, null))
            {
                return StrToDecimal(strValue.ToString());
            }
            return 0M;
        }

        /// <summary>
        /// string��ת��Ϊdecimal��
        /// </summary>
        /// <param name="strValue">Ҫת�����ַ���</param>
        /// <returns>ת�����decimal���ͽ��</returns>
        public static decimal StrToDecimal(string strValue)
        {
            decimal num;
            decimal.TryParse(strValue, out num);
            return num;
        }

        /// <summary>
        /// string��ת��Ϊdecimal��
        /// </summary>
        /// <param name="strValue">Ҫת�����ַ���</param>
        /// <param name="defValue">ȱʡֵ</param>
        /// <returns>ת�����decimal���ͽ��</returns>
        public static decimal StrToDecimal(string input, decimal defaultValue)
        {
            decimal num;
            if (decimal.TryParse(input, out num))
            {
                return num;
            }
            return defaultValue;
        }

        /// <summary>
        /// string��ת��Ϊdouble��
        /// </summary>
        /// <param name="strValue">Ҫת�����ַ���</param>
        /// <returns>ת�����double���ͽ��</returns>
        public static double StrToDouble(object strValue)
        {
            if (!Convert.IsDBNull(strValue) && !Equals(strValue, null))
            {
                return StrToDouble(strValue.ToString());
            }
            return 0.0;
        }

        /// <summary>
        /// string��ת��Ϊdouble��
        /// </summary>
        /// <param name="strValue">Ҫת�����ַ���</param>
        /// <returns>ת�����double���ͽ��</returns>
        public static double StrToDouble(string strValue)
        {
            double num;
            double.TryParse(strValue, out num);
            return num;
        }

        /// <summary>
        /// string��ת��Ϊfloat��
        /// </summary>
        /// <param name="strValue">Ҫת�����ַ���</param>
        /// <param name="defValue">ȱʡֵ</param>
        /// <returns>ת�����float���ͽ��</returns>
        public static float StrToFloat(object strValue, float defValue)
        {
            if ((strValue == null) || (strValue.ToString().Length > 10))
            {
                return defValue;
            }

            float intValue = defValue;
            if (strValue != null)
            {
                bool IsFloat = new Regex(@"^([-]|[0-9])[0-9]*(\.\w*)?$").IsMatch(strValue.ToString());
                if (IsFloat)
                {
                    intValue = Convert.ToSingle(strValue);
                }
            }
            return intValue;
        }

        /// <summary>
        /// string��ת��Ϊint��
        /// </summary>
        /// <param name="strValue">Ҫת�����ַ���</param>
        /// <returns>ת�����int���ͽ��.���Ҫת�����ַ����Ƿ�����,�򷵻�-1.</returns>
        public static int StrToInt(object strValue)
        {
            int defValue = -1;
            if ((strValue == null) || (strValue.ToString() == string.Empty) || (strValue.ToString().Length > 10))
            {
                return defValue;
            }

            string val = strValue.ToString();
            string firstletter = val[0].ToString();

            if (val.Length == 10 && ValidationHelper.IsNumber(firstletter) && int.Parse(firstletter) > 1)
            {
                return defValue;
            }
            else if (val.Length == 10 && !ValidationHelper.IsNumber(firstletter))
            {
                return defValue;
            }


            int intValue = defValue;
            if (strValue != null)
            {
                bool IsInt = new Regex(@"^([-]|[0-9])[0-9]*$").IsMatch(strValue.ToString());
                if (IsInt)
                {
                    intValue = Convert.ToInt32(strValue);
                }
            }

            return intValue;
        }

        /// <summary>
        /// string��ת��Ϊint��
        /// </summary>
        /// <param name="strValue">Ҫת�����ַ���</param>
        /// <param name="defValue">ȱʡֵ</param>
        /// <returns>ת�����int���ͽ��</returns>
        public static int StrToInt(object strValue, int defValue)
        {
            if ((strValue == null) || (strValue.ToString() == string.Empty) || (strValue.ToString().Length > 10))
            {
                return defValue;
            }

            string val = strValue.ToString();
            string firstletter = val[0].ToString();

            if (val.Length == 10 && ValidationHelper.IsNumber(firstletter) && int.Parse(firstletter) > 1)
            {
                return defValue;
            }
            else if (val.Length == 10 && !ValidationHelper.IsNumber(firstletter))
            {
                return defValue;
            }


            int intValue = defValue;
            if (strValue != null)
            {
                bool IsInt = new Regex(@"^([-]|[0-9])[0-9]*$").IsMatch(strValue.ToString());
                if (IsInt)
                {
                    intValue = Convert.ToInt32(strValue);
                }
            }

            return intValue;
        }

        /// <summary>
        /// ��long����ֵת��ΪInt32����
        /// </summary>
        /// <param name="objNum"></param>
        /// <returns></returns>
        public static int SafeInt32(object objNum)
        {
            if (objNum == null)
            {
                return 0;
            }
            string strNum = objNum.ToString();
            if (ValidationHelper.IsNumber(strNum))
            {
                if (strNum.Length > 9)
                {
                    return int.MaxValue;
                }
                return Int32.Parse(strNum);
            }
            else
            {
                return 0;
            }
        } 
    }
}