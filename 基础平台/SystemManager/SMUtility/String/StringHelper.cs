using System;
using System.Collections;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace SMSUtility
{
    /// <summary>
    /// �����ַ�������Ĺ���������
    /// </summary>
    [Serializable]
    public class StringHelper
    {
        #region �ֶζ���

        /// <summary>
        /// ��������
        /// </summary>
        private int _indentLevel;

        /// <summary>
        /// Ҫ���ɵ��ַ���
        /// </summary>
        private StringBuilder _str;

        #endregion

        #region ���캯��

        /// <summary>
        /// ��ʼ������
        /// </summary>
        public StringHelper()
        {
            //��ʼ���ַ���
            _str = new StringBuilder();
        }

        #endregion

        #region ����ַ���

        /// <summary>
        /// ����ַ���
        /// </summary>
        /// <param name="text">�ı�</param>
        /// <param name="parameters">����</param>
        public void Append(string text, params object[] parameters)
        {
            if (parameters.Length == 0)
            {
                //����������
                _str.Append(text);
            }
            else
            {
                //��������
                _str.AppendFormat(text, parameters);
            }
        }

        #endregion

        #region ����ַ���

        /// <summary>
        /// ����ַ���
        /// </summary>
        public void Clear()
        {
            Clear(_str);
        }

        #endregion

        #region �ַ�������

        /// <summary>
        /// �ַ�������
        /// </summary>
        public int Length
        {
            get { return _str.Length; }
        }

        #endregion

        #region ��������

        /// <summary>
        /// ��������
        /// </summary>
        public void IncreaseIndent()
        {
            _indentLevel++;
        }

        /// <summary>
        /// ��������
        /// </summary>
        /// <param name="step">������</param>
        public void IncreaseIndent(int step)
        {
            _indentLevel += step;
        }

        #endregion

        #region ��������

        /// <summary>
        /// ��������
        /// </summary>
        public void DecreaseIndent()
        {
            _indentLevel--;
        }

        #endregion

        #region �Ƴ�ĩβָ���ַ���

        /// <summary>
        /// �Ƴ��ַ���ĩβָ���ַ���
        /// </summary>
        /// <param name="removeString">Ҫ�Ƴ����ַ���</param>
        public void RemoveEnd(string removeString)
        {
            //������ʱ�ַ���
            string tempString = _str.ToString().TrimEnd(removeString.ToCharArray());

            if (tempString != _str.ToString())
            {
                var temp = new StringBuilder();
                temp.Append(tempString);

                //Ϊ�ֶθ�ֵ
                _str = temp;
            }
        }

        #endregion

        #region ��̬����

        #region ���ַ�ת��ΪASCII

        public static int Asc(string character)
        {
            if (character.Length != 1)
            {
                throw new Exception("Character is not valid.");
            }
            ASCIIEncoding asciiEncoding = new ASCIIEncoding();
            return asciiEncoding.GetBytes(character)[0];
        }

        public static string Chr(int asciiCode)
        {
            if ((asciiCode < 0) || (asciiCode > 0xff))
            {
                throw new Exception("ASCII Code is not valid.");
            }
            ASCIIEncoding asciiEncoding = new ASCIIEncoding();
            byte[] byteArray = new byte[] { (byte)asciiCode };
            return asciiEncoding.GetString(byteArray);
        }

        #endregion

        #region ��ASCIIת��Ϊ�ַ�

        public static string UnAsc(int asciiCode)
        {
            if (asciiCode >= 0 && asciiCode <= 255)
            {
                var asciiEncoding = new ASCIIEncoding();
                var byteArray = new[] {(byte) asciiCode};
                string strCharacter = asciiEncoding.GetString(byteArray);
                return (strCharacter);
            }
            throw new Exception("ASCII Code is not valid.");
        }

        #endregion

        #region �Խű��е���Ϣ���й��˴���

        /// <summary>
        /// �Խű��е���Ϣ���й��˴���
        /// </summary>
        /// <param name="msg">�ű��е���Ϣ�ַ���,���������ű�����.
        /// ������alert('ab\n\rc'),ֻ����ab\n\rc,��Ҫ��alert('')��������</param>
        public static string GetValidScriptMsg(string msg)
        {
            var validMsg = new StringBuilder(msg);
            validMsg.Replace("\\", @"\\");
            validMsg.Replace("\n", "\\n");
            validMsg.Replace("\t", "\\t");
            validMsg.Replace("\r", "\\r");
            validMsg.Replace("'", "\\'");

            //������Ч���ַ���
            return validMsg.ToString();
        }

        #endregion

        #region ȥ���ַ������Ķ���

        /// <summary>
        /// ȥ���ַ������Ķ���,�����µ��ַ���
        /// </summary>
        /// <param name="text">ԭʼ�ַ���</param>
        public static string RemoveLastComma(ref string text)
        {
            text = text.TrimEnd(',');
            return text;
        }

        /// <summary>
        /// ȥ���ַ������Ķ���,�����µ��ַ���
        /// </summary>
        /// <param name="text">ԭʼ�ַ���</param>
        public static string RemoveLastComma(StringBuilder text)
        {
            return text.ToString().TrimEnd(',');
        }

        /// <summary>
        /// ȥ���ַ������Ķ���,�����µ��ַ���
        /// </summary>
        /// <param name="text">ԭʼ�ַ���</param>
        public static string RemoveLastComma(StringHelper text)
        {
            return text.ToString().TrimEnd(',');
        }

        #endregion

        #region ����ַ���

        /// <summary>
        /// ����ַ���
        /// </summary>
        /// <param name="text">ԭʼ�ַ���</param>
        public static void Clear(StringBuilder text)
        {
            text.Remove(0, text.Length);
        }

        #endregion

        #region ��ȡ�ַ��������һ���ַ�

        /// <summary>
        /// ��ȡ�ַ��������һ���ַ�
        /// </summary>
        /// <param name="text">ԭʼ�ַ���</param>        
        public static string GetLastChar(string text)
        {
            //����ַ���Ϊ�գ��򷵻�
            if (ValidationHelper.IsNullOrEmpty(text))
            {
                return "";
            }

            return text.Substring(text.Length - 1, 1);
        }

        #endregion

        #region �ö���ƴ������

        #region ���ط���1

        /// <summary>
        /// ��ȡ�ö���ƴ������Ԫ�ص��ַ����������ַ���������Ԫ��Ĭ�ϲ������ţ������Ҫ������ʹ�����ط�����
        /// ����: ����Ϊ:string[] a = new string[] { "1","2","3" };����ֵ:1,2,3
        /// </summary>
        /// <param name="stringArray">ԭʼ�ַ�������</param>
        public static string GetCommaString(params string[] stringArray)
        {
            return GetCommaString(false, stringArray);
        }

        #endregion

        #region ���ط���2

        /// <summary>
        /// ��ȡ�ö���ƴ������Ԫ�ص��ַ�����
        /// ����: ����Ϊ:string[] a = new string[] { "1","2","3" };����ֵ:1,2,3
        /// </summary>
        /// <param name="isAddQuotationMarks">�Ƿ���ӵ�����,�������true���򷵻�ֵΪ'1','2','3'</param>
        /// <param name="stringArray">ԭʼ�ַ�������</param>
        public static string GetCommaString(bool isAddQuotationMarks, params string[] stringArray)
        {
            //��ʱ�ַ���
            var list = new StringBuilder();

            //ѭ���ַ������飬��ӵ���ʱ�ַ�����
            foreach (string text in stringArray)
            {
                list.AppendFormat(isAddQuotationMarks ? "'{0}'," : "{0},", text);
            }

            //�����ַ���
            return RemoveLastComma(list);
        }

        #endregion

        #region ���ط���3

        /// <summary>
        /// ��ȡ�ö���ƴ������Ԫ�ص��ַ����������ַ���������Ԫ��Ĭ�ϲ������ţ������Ҫ������ʹ�����ط�����
        /// ����: ����Ϊ:int[] a = new int[] { 1,2,3 };����ֵ:1,2,3
        /// </summary>
        /// <param name="intArray">ԭʼ��������</param>
        public static string GetCommaString(params int[] intArray)
        {
            return GetCommaString(false, intArray);
        }

        #endregion

        #region ���ط���4

        /// <summary>
        /// ��ȡ�ö���ƴ������Ԫ�ص��ַ�����
        /// ����: ����Ϊ:int[] a = new int[] { 1,2,3 };����ֵ:1,2,3
        /// </summary>
        /// <param name="isAddQuotationMarks">�Ƿ���ӵ�����,�������true���򷵻�ֵΪ'1','2','3'</param>
        /// <param name="intArray">ԭʼ��������</param>
        public static string GetCommaString(bool isAddQuotationMarks, params int[] intArray)
        {
            //��ʱ�ַ���
            var list = new StringBuilder();

            //ѭ���ַ������飬��ӵ���ʱ�ַ�����
            foreach (int text in intArray)
            {
                list.AppendFormat(isAddQuotationMarks ? "'{0}'," : "{0},", text);
            }

            //�����ַ���
            return RemoveLastComma(list);
        }

        #endregion

        #region ���ط���5

        /// <summary>
        /// ��ȡ�ö���ƴ��Ԫ�ص��ַ����������ַ�����Ԫ��Ĭ�ϲ������ţ������Ҫ������ʹ�����ط�����
        /// </summary>
        /// <param name="table">����</param>
        /// <param name="columnName">����</param>
        public static string GetCommaString(DataTable table, string columnName)
        {
            return GetCommaString(table, columnName, false);
        }

        #endregion

        #region ���ط���6

        /// <summary>
        /// ��ȡ�ö���ƴ��Ԫ�ص��ַ����������ַ�����Ԫ��Ĭ�ϲ������ţ������Ҫ������ʹ�����ط�����
        /// </summary>
        /// <param name="table">����</param>
        /// <param name="columnName">����</param>
        /// <param name="isAddQuotationMarks">�Ƿ���ӵ�����,�������true���򷵻�ֵΪ'1','2','3'</param>
        public static string GetCommaString(DataTable table, string columnName, bool isAddQuotationMarks)
        {
            //��ʱ�ַ���
            var list = new StringBuilder();

            //ѭ�����ݼ�����ӵ���ʱ�ַ�����
            foreach (DataRow row in table.Rows)
            {
                list.AppendFormat(isAddQuotationMarks ? "'{0}'," : "{0},", row[columnName]);
            }

            //�����ַ���
            return RemoveLastComma(list);
        }

        #endregion

        #endregion

        #region ��ȡ���ָ�ʽ�ĵ�ǰʱ��

        /// <summary>
        /// ��ȡ���ָ�ʽ�ĵ�ǰʱ��
        /// </summary>
        public static string GetNumberByNowDate()
        {
            //��ȡ��ǰʱ����ַ�����ʾ
            string numberTime = DateTime.Now.ToString("g");

            //ת��Ϊ������
            numberTime = numberTime.Replace("-", "");
            numberTime = numberTime.Replace(":", "");
            numberTime = numberTime.Replace(" ", "");

            //�������ָ�ʽ�ĵ�ǰʱ��
            return numberTime;
        }

        #endregion

        #region ���ַ���������ĸ��д

        /// <summary>
        /// ���ַ���������ĸ��д
        /// </summary>
        /// <param name="text">ԭʼ�ַ���</param>
        public static void FirstCharUpper(ref string text)
        {
            //��ȡ����ĸ
            string temp = text.Substring(0, 1).ToUpper();

            //���ַ���������ĸ��д
            text = temp + text.Substring(1, text.Length - 1);
        }

        #endregion

        #region ��ȡ�ٷֱ��ַ���

        /// <summary>
        /// ��ȡ�ٷֱ��ַ���,����ֵ������ 100%
        /// </summary>
        /// <param name="percent">0-100֮�������</param>
        public static string GetPercentage(int percent)
        {
            return percent + "%";
        }

        #endregion

        #region ����������ʽ��ģʽ�ַ���

        /// <summary>
        /// ����������ʽ��ģʽ�ַ���,����˿�ͷ�ͽ�β��ģʽ�ַ���
        /// ���紫���ַ���"abc",����"^abc$"
        /// </summary>
        /// <param name="text">ԭʼ�ַ���</param>
        public static string GetPattern(string text)
        {
            return "^" + text + "$";
        }

        #endregion

        #region �ֽ�URL

        /// <summary>
        /// �ֽ�URL,��ȡurl·����?��ǰ����( ȥ���˲�ѯ�ַ����Ĳ��� ) �� ��ѯ�ַ�������
        /// </summary>
        /// <param name="url">ԭʼURL</param>
        /// <param name="hostUrl">ȥ���˲�ѯ�ַ�����URL</param>
        /// <param name="queryString">��ѯ�ַ���</param>
        public static void DecomposeUrl(string url, out string hostUrl, out string queryString)
        {
            //�����д��URL�в�ѯ�ַ�������ֽ�
            if (url.IndexOf("?") != -1)
            {
                //��ȡurl·����?��ǰ����
                hostUrl = url.Substring(0, url.IndexOf('?'));
                //��ȡ��ѯ�ַ���
                queryString = url.Substring(url.IndexOf('?') + 1);
            }
            else
            {
                //url·����?��ǰ����
                hostUrl = url;
                //��ѯ�ַ���
                queryString = string.Empty;
            }
        }

        #endregion

        #region �ָ��ַ���

        /// <summary>
        /// �ָ��ַ���
        /// </summary>
        public static string[] SplitString(string strContent, string strSplit)
        {
            if (strContent.IndexOf(strSplit) < 0)
            {
                string[] tmp = {strContent};
                return tmp;
            }
            return Regex.Split(strContent, Regex.Escape(strSplit), RegexOptions.IgnoreCase);
        }

        /// <summary>
        /// �ָ��ַ���
        /// </summary>
        /// <returns></returns>
        public static string[] SplitString(string strContent, string strSplit, int p3)
        {
            var result = new string[p3];

            string[] splited = SplitString(strContent, strSplit);

            for (int i = 0; i < p3; i++)
            {
                if (i < splited.Length)
                    result[i] = splited[i];
                else
                    result[i] = string.Empty;
            }

            return result;
        }

        #endregion

        #region �ж�ָ���ַ����Ƿ�����ָ���ַ��������е�һ��Ԫ��

        /// <summary>
        /// �ж�ָ���ַ�����ָ���ַ��������е�λ��
        /// </summary>
        /// <param name="strSearch">�ַ���</param>
        /// <param name="stringArray">�ַ�������</param>
        /// <param name="caseInsensetive">�Ƿ����ִ�Сд, trueΪ������, falseΪ����</param>
        /// <returns>�ַ�����ָ���ַ��������е�λ��, �粻�����򷵻�-1</returns>
        public static int GetInArrayID(string strSearch, string[] stringArray, bool caseInsensetive)
        {
            for (int i = 0; i < stringArray.Length; i++)
            {
                if (caseInsensetive)
                {
                    if (strSearch.ToLower() == stringArray[i].ToLower())
                    {
                        return i;
                    }
                }
                else
                {
                    if (strSearch == stringArray[i])
                    {
                        return i;
                    }
                }
            }
            return -1;
        }


        /// <summary>
        /// �ж�ָ���ַ�����ָ���ַ��������е�λ��
        /// </summary>
        /// <param name="strSearch">�ַ���</param>
        /// <param name="stringArray">�ַ�������</param>
        /// <returns>�ַ�����ָ���ַ��������е�λ��, �粻�����򷵻�-1</returns>		
        public static int GetInArrayID(string strSearch, string[] stringArray)
        {
            return GetInArrayID(strSearch, stringArray, true);
        }

        /// <summary>
        /// �ж�ָ���ַ����Ƿ�����ָ���ַ��������е�һ��Ԫ��
        /// </summary>
        /// <param name="strSearch">�ַ���</param>
        /// <param name="stringArray">�ַ�������</param>
        /// <param name="caseInsensetive">�Ƿ����ִ�Сд, trueΪ������, falseΪ����</param>
        /// <returns>�жϽ��</returns>
        public static bool InArray(string strSearch, string[] stringArray, bool caseInsensetive)
        {
            return GetInArrayID(strSearch, stringArray, caseInsensetive) >= 0;
        }

        /// <summary>
        /// �ж�ָ���ַ����Ƿ�����ָ���ַ��������е�һ��Ԫ��
        /// </summary>
        /// <param name="str">�ַ���</param>
        /// <param name="stringarray">�ַ�������</param>
        /// <returns>�жϽ��</returns>
        public static bool InArray(string str, string[] stringarray)
        {
            return InArray(str, stringarray, false);
        }

        /// <summary>
        /// �ж�ָ���ַ����Ƿ�����ָ���ַ��������е�һ��Ԫ��
        /// </summary>
        /// <param name="str">�ַ���</param>
        /// <param name="stringarray">�ڲ��Զ��ŷָ�ʵ��ַ���</param>
        /// <returns>�жϽ��</returns>
        public static bool InArray(string str, string stringarray)
        {
            return InArray(str, SplitString(stringarray, ","), false);
        }

        /// <summary>
        /// �ж�ָ���ַ����Ƿ�����ָ���ַ��������е�һ��Ԫ��
        /// </summary>
        /// <param name="str">�ַ���</param>
        /// <param name="stringarray">�ڲ��Զ��ŷָ�ʵ��ַ���</param>
        /// <param name="strsplit">�ָ��ַ���</param>
        /// <returns>�жϽ��</returns>
        public static bool InArray(string str, string stringarray, string strsplit)
        {
            return InArray(str, SplitString(stringarray, strsplit), false);
        }

        /// <summary>
        /// �ж�ָ���ַ����Ƿ�����ָ���ַ��������е�һ��Ԫ��
        /// </summary>
        /// <param name="str">�ַ���</param>
        /// <param name="stringarray">�ڲ��Զ��ŷָ�ʵ��ַ���</param>
        /// <param name="strsplit">�ָ��ַ���</param>
        /// <param name="caseInsensetive">�Ƿ����ִ�Сд, trueΪ������, falseΪ����</param>
        /// <returns>�жϽ��</returns>
        public static bool InArray(string str, string stringarray, string strsplit, bool caseInsensetive)
        {
            return InArray(str, SplitString(stringarray, strsplit), caseInsensetive);
        }

        #endregion

        #region ���ַ�����ָ��λ�ý�ȡָ�����ȵ����ַ���

        /// <summary>
        /// ���ַ�����ָ��λ�ý�ȡָ�����ȵ����ַ���
        /// </summary>
        /// <param name="str">ԭ�ַ���</param>
        /// <param name="startIndex">���ַ�������ʼλ��</param>
        /// <param name="length">���ַ����ĳ���</param>
        /// <returns>���ַ���</returns>
        public static string CutString(string str, int startIndex, int length)
        {
            if (startIndex >= 0)
            {
                if (length < 0)
                {
                    length = length*-1;
                    if (startIndex - length < 0)
                    {
                        length = startIndex;
                        startIndex = 0;
                    }
                    else
                    {
                        startIndex = startIndex - length;
                    }
                }


                if (startIndex > str.Length)
                {
                    return "";
                }
            }
            else
            {
                if (length < 0)
                {
                    return "";
                }
                if (length + startIndex > 0)
                {
                    length = length + startIndex;
                    startIndex = 0;
                }
                else
                {
                    return "";
                }
            }

            if (str.Length - startIndex < length)
            {
                length = str.Length - startIndex;
            }

            return str.Substring(startIndex, length);
        }

        /// <summary>
        /// ���ַ�����ָ��λ�ÿ�ʼ��ȡ���ַ�����β���˷���
        /// </summary>
        /// <param name="str">ԭ�ַ���</param>
        /// <param name="startIndex">���ַ�������ʼλ��</param>
        /// <returns>���ַ���</returns>
        public static string CutString(string str, int startIndex)
        {
            return CutString(str, startIndex, str.Length);
        }


        /// <summary>
        /// �ַ�������ٹ�ָ�������򽫳����Ĳ�����ָ���ַ�������
        /// </summary>
        /// <param name="pSrcString">Ҫ�����ַ���</param>
        /// <param name="pLength">ָ������</param>
        /// <param name="pTailString">�����滻���ַ���</param>
        /// <returns>��ȡ����ַ���</returns>
        public static string GetSubString(string pSrcString, int pLength, string pTailString)
        {
            return GetSubString(pSrcString, 0, pLength, pTailString);
        }

        /// <summary>
        /// ��ȡ�ַ�����������Ӣ��
        /// </summary>
        /// <param name="pSrcString"></param>
        /// <param name="pLength"></param>
        /// <param name="bdot"></param>
        /// <returns></returns>
        public static string GetSubString(string pSrcString, int pLength, bool bdot)
        {
            string str = "";

            if (pLength >= pSrcString.Length)
                return pSrcString;

            int nRealLen = pLength*2;
            if (bdot)
                nRealLen = nRealLen - 3;

            Encoding encoding = Encoding.GetEncoding("gb2312");
            for (int i = pSrcString.Length; i >= 0; i--)
            {
                str = pSrcString.Substring(0, i);
                if (encoding.GetBytes(str).Length > nRealLen)
                    continue;
                break;
            }

            if (bdot)
                str += "...";

            return str;
        }

        /// <summary>
        /// ȡָ�����ȵ��ַ���
        /// </summary>
        /// <param name="pSrcString">Ҫ�����ַ���</param>
        /// <param name="pStartIndex">��ʼλ��</param>
        /// <param name="pLength">ָ������</param>
        /// <param name="pTailString">�����滻���ַ���</param>
        /// <returns>��ȡ����ַ���</returns>
        public static string GetSubString(string pSrcString, int pStartIndex, int pLength, string pTailString)
        {
            string myResult = pSrcString;

            if (pLength >= 0)
            {
                byte[] bsSrcString = Encoding.Default.GetBytes(pSrcString);

                //���ַ������ȴ�����ʼλ��
                if (bsSrcString.Length > pStartIndex)
                {
                    int pEndIndex = bsSrcString.Length;

                    //��Ҫ��ȡ�ĳ������ַ�������Ч���ȷ�Χ��
                    if (bsSrcString.Length > (pStartIndex + pLength))
                    {
                        pEndIndex = pLength + pStartIndex;
                    }
                    else
                    {
                        //��������Ч��Χ��ʱ,ֻȡ���ַ����Ľ�β

                        pLength = bsSrcString.Length - pStartIndex;
                        pTailString = "";
                    }


                    int nRealLength = pLength;
                    var anResultFlag = new int[pLength];

                    int nFlag = 0;
                    for (int i = pStartIndex; i < pEndIndex; i++)
                    {
                        if (bsSrcString[i] > 127)
                        {
                            nFlag++;
                            if (nFlag == 3)
                            {
                                nFlag = 1;
                            }
                        }
                        else
                        {
                            nFlag = 0;
                        }

                        anResultFlag[i] = nFlag;
                    }

                    if ((bsSrcString[pEndIndex - 1] > 127) && (anResultFlag[pLength - 1] == 1))
                    {
                        nRealLength = pLength + 1;
                    }

                    var bsResult = new byte[nRealLength];

                    Array.Copy(bsSrcString, pStartIndex, bsResult, 0, nRealLength);

                    myResult = Encoding.Default.GetString(bsResult);

                    myResult = myResult + pTailString;
                }
            }

            return myResult;
        }

        /// <summary>
        /// ��һ���ֽڳ��Ƚ�ȡ�ַ���
        /// </summary>
        /// <param name="str">Ҫ��ȡ���ַ���</param>
        /// <param name="length">Ҫ��ȡ���ֽڳ���</param>
        /// <param name="pTailString"></param>
        /// <returns>���ش������ַ������������Ȳ��ֱ�""�滻</returns>
        public static string GetStringByLength(string str, int length, string pTailString)
        {
            byte[] bwrite = Encoding.GetEncoding("GB2312").GetBytes(str.ToCharArray());
            if (bwrite.Length >= length)
            {
                string newStr = Encoding.Default.GetString(bwrite, 0, length - 4);
                if (newStr[newStr.Length - 1] == '?')
                {
                    newStr = Encoding.Default.GetString(bwrite, 0, length - 3);
                }
                return newStr + pTailString;
            }
            return str;
        }

        #endregion

        #region ����HTML����

        public static string ReplaceHtml(string html)
        {
            var regex1 = new Regex(@"<script[\s\S]+</script *>", RegexOptions.IgnoreCase);
            var regex2 = new Regex(@" href *= *[\s\S]*script *:", RegexOptions.IgnoreCase);
            var regex3 = new Regex(@" no[\s\S]*=", RegexOptions.IgnoreCase);
            var regex4 = new Regex(@"<iframe[\s\S]+</iframe *>", RegexOptions.IgnoreCase);
            var regex5 = new Regex(@"<frameset[\s\S]+</frameset *>", RegexOptions.IgnoreCase);
            var regex6 = new Regex(@"\<img[^\>]+\>", RegexOptions.IgnoreCase);
            var regex7 = new Regex(@"</p>", RegexOptions.IgnoreCase);
            var regex8 = new Regex(@"<p>", RegexOptions.IgnoreCase);
            var regex9 = new Regex(@"<[^>]*>", RegexOptions.IgnoreCase);
            html = regex1.Replace(html, ""); //����<script></script>��� 
            html = regex2.Replace(html, ""); //����href=javascript: (<A>) ���� 
            html = regex3.Replace(html, " _disibledevent="); //���������ؼ���on...�¼� 
            html = regex4.Replace(html, ""); //����iframe 
            html = regex5.Replace(html, ""); //����frameset 
            html = regex6.Replace(html, ""); //����frameset 
            html = regex7.Replace(html, ""); //����frameset 
            html = regex8.Replace(html, ""); //����frameset 
            html = regex9.Replace(html, "");
            html = html.Replace("&nbsp;", " ");
            html = html.Replace("&#40;", "(");
            html = html.Replace("&#41;", ")");
            html = html.Replace("\n\r", "");
            html = html.Replace("\r\n", "");
            html = html.Replace("\n", "");
            html = html.Replace("\r", "");
            html = html.Replace("</strong>", "");
            html = html.Replace("<strong>", "");

            html = html.Replace(" ", "");
            return html;
        }

        #endregion

        #region �滻,�ָ�html�е������ַ�

        /// <summary>
        /// �滻���ָ�html�е������ַ�
        /// </summary>
        /// <param name="theString">��Ҫ�����滻���ı���</param>
        /// <returns>�滻����ı���</returns>
        public string HtmlEncode(string theString)
        {
            theString = theString.Replace(">", "&gt;");
            theString = theString.Replace("<", "&lt;");
            theString = theString.Replace(" ", "&nbsp;");
            theString = theString.Replace(" ", "&nbsp;");
            theString = theString.Replace("\"", "&quot;");
            theString = theString.Replace("\'", "'");
            theString = theString.Replace("\n", "<br/> ");
            return theString;
        }

        /// <summary>
        /// �ָ�html�е������ַ�
        /// </summary>
        /// <param name="theString">��Ҫ�ָ����ı���</param>
        /// <returns>�ָ��õ��ı���</returns>
        public string HtmlDiscode(string theString)
        {
            theString = theString.Replace("&gt;", ">");
            theString = theString.Replace("&lt;", "<");
            theString = theString.Replace("&nbsp;", " ");
            theString = theString.Replace("&nbsp;", " ");
            theString = theString.Replace("&quot;", "\"");
            theString = theString.Replace("'", "\'");
            theString = theString.Replace("<br/> ", "\n");
            return theString;
        }

        #endregion

        #region �滻�ַ������Ƿ��зǷ����ַ�

        /// <summary>
        /// ���˷Ƿ��ַ�
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static string ReplaceBadChar(string str)
        {
            if (string.IsNullOrEmpty(str))
                return "";
            const string strBadChar = "@@,+,',--,%,^,&,?,(,),<,>,[,],{,},/,\\,;,:,\",\"\"";
            string[] arrBadChar = SplitString(strBadChar, ",");
            return arrBadChar.Where(t => t.Length > 0).Aggregate(str, (current, t) => current.Replace(t, ""));
        }

        public static string ReplaceSqlChar(string text)
        {
            string reText = text;
            if (!string.IsNullOrEmpty(reText))
            {
                reText = reText.ToLower();
                reText = reText.Replace("'", "''");
                return reText.Trim();
            }
            return "";
        }

        public static string InputText(string text, int maxLength)
        {
            text = text.Trim();
            if (string.IsNullOrEmpty(text))
                return string.Empty;
            if (text.Length > maxLength)
                text = text.Substring(0, maxLength);
            text = Regex.Replace(text, "[\\s]{2,}", " "); //two or more spaces
            text = Regex.Replace(text, "(<[b|B][r|R]/*>)+|(<[p|P](.|\\n)*?>)", "\n"); //<br>
            text = Regex.Replace(text, "(\\s*&[n|N][b|B][s|S][p|P];\\s*)+", " "); //&nbsp;
            text = Regex.Replace(text, "<(.|\\n)*?>", string.Empty); //any other tags
            text = text.Replace("'", "''");
            return text;
        }

        public static string InputText(string text)
        {
            text = text.Trim();
            if (string.IsNullOrEmpty(text))
                return string.Empty;
            text = Regex.Replace(text, "[\\s]{2,}", " "); //two or more spaces
            text = Regex.Replace(text, "(<[b|B][r|R]/*>)+|(<[p|P](.|\\n)*?>)", "\n"); //<br>
            text = Regex.Replace(text, "(\\s*&[n|N][b|B][s|S][p|P];\\s*)+", " "); //&nbsp;
            text = Regex.Replace(text, "<(.|\\n)*?>", string.Empty); //any other tags
            text = text.Replace("'", "''");
            return text;
        }

        #endregion

        #region �����ַ�����ʵ����

        /// <summary>
        /// �����ַ�����ʵ����, 1�����ֳ���Ϊ2
        /// </summary>
        /// <returns></returns>
        public static int GetStringLength(string text)
        {
            int len = 0;

            for (int i = 0; i < text.Length; i++)
            {
                byte[] byteLen = Encoding.Default.GetBytes(text.Substring(i, 1));
                if (byteLen.Length > 1)
                    len += 2; //������ȴ���1�������ģ�ռ�����ֽڣ�+2
                else
                    len += 1; //������ȵ���1����Ӣ�ģ�ռһ���ֽڣ�+1
            }

            return len;
        }

        #endregion

        #region ȥ���������ظ�Ԫ��

        /**/

        /// <summary>
        /// ȥ���������ظ�Ԫ��
        /// </summary>
        /// <param name="arr"></param>
        /// <returns></returns> 
        public static ArrayList FilterRepeatArrayItem(ArrayList arr)
        {
            //����������
            var newArr = new ArrayList();
            //�����һ��ԭ����Ԫ��
            if (arr.Count > 0)
            {
                newArr.Add(arr[0]);
            }
            //ѭ���Ƚ�
            foreach (object t in arr)
            {
                if (!newArr.Contains(t))
                {
                    newArr.Add(t);
                }
            }
            return newArr;
        }

        #endregion

        #region ���ת��д
        /// <summary>
        ///   ���ת��д  
        /// </summary>  
        public static string MoneyToChinese(string LowerMoney)
        {
            string functionReturnValue = null;
            bool IsNegative = false; // �Ƿ��Ǹ���  
            if (LowerMoney.Trim().Substring(0, 1) == "-")
            {
                // �Ǹ�������תΪ����  
                LowerMoney = LowerMoney.Trim().Remove(0, 1);
                IsNegative = true;
            }
            string strLower = null;
            string strUpart = null;
            string strUpper = null;
            int iTemp = 0;
            // ������λС�� 123.489��123.49����123.4��123.4  
            LowerMoney = Math.Round(double.Parse(LowerMoney), 2).ToString();
            if (LowerMoney.IndexOf(".") > 0)
            {
                if (LowerMoney.IndexOf(".") == LowerMoney.Length - 2)
                {
                    LowerMoney = LowerMoney + "0";
                }
            }
            else
            {
                LowerMoney = LowerMoney + ".00";
            }
            strLower = LowerMoney;
            iTemp = 1;
            strUpper = "";
            while (iTemp <= strLower.Length)
            {
                switch (strLower.Substring(strLower.Length - iTemp, 1))
                {
                    case ".":
                        strUpart = "Բ";
                        break;
                    case "0":
                        strUpart = "��";
                        break;
                    case "1":
                        strUpart = "Ҽ";
                        break;
                    case "2":
                        strUpart = "��";
                        break;
                    case "3":
                        strUpart = "��";
                        break;
                    case "4":
                        strUpart = "��";
                        break;
                    case "5":
                        strUpart = "��";
                        break;
                    case "6":
                        strUpart = "½";
                        break;
                    case "7":
                        strUpart = "��";
                        break;
                    case "8":
                        strUpart = "��";
                        break;
                    case "9":
                        strUpart = "��";
                        break;
                }

                switch (iTemp)
                {
                    case 1:
                        strUpart = strUpart + "��";
                        break;
                    case 2:
                        strUpart = strUpart + "��";
                        break;
                    case 3:
                        strUpart = strUpart + "";
                        break;
                    case 4:
                        strUpart = strUpart + "";
                        break;
                    case 5:
                        strUpart = strUpart + "ʰ";
                        break;
                    case 6:
                        strUpart = strUpart + "��";
                        break;
                    case 7:
                        strUpart = strUpart + "Ǫ";
                        break;
                    case 8:
                        strUpart = strUpart + "��";
                        break;
                    case 9:
                        strUpart = strUpart + "ʰ";
                        break;
                    case 10:
                        strUpart = strUpart + "��";
                        break;
                    case 11:
                        strUpart = strUpart + "Ǫ";
                        break;
                    case 12:
                        strUpart = strUpart + "��";
                        break;
                    case 13:
                        strUpart = strUpart + "ʰ";
                        break;
                    case 14:
                        strUpart = strUpart + "��";
                        break;
                    case 15:
                        strUpart = strUpart + "Ǫ";
                        break;
                    case 16:
                        strUpart = strUpart + "��";
                        break;
                    default:
                        strUpart = strUpart + "";
                        break;
                }

                strUpper = strUpart + strUpper;
                iTemp = iTemp + 1;
            }

            strUpper = strUpper.Replace("��ʰ", "��");
            strUpper = strUpper.Replace("���", "��");
            strUpper = strUpper.Replace("��Ǫ", "��");
            strUpper = strUpper.Replace("������", "��");
            strUpper = strUpper.Replace("����", "��");
            strUpper = strUpper.Replace("������", "��");
            strUpper = strUpper.Replace("���", "��");
            strUpper = strUpper.Replace("���", "��");
            strUpper = strUpper.Replace("����������Բ", "��Բ");
            strUpper = strUpper.Replace("��������Բ", "��Բ");
            strUpper = strUpper.Replace("��������", "��");
            strUpper = strUpper.Replace("������Բ", "��Բ");
            strUpper = strUpper.Replace("����", "��");
            strUpper = strUpper.Replace("����", "��");
            strUpper = strUpper.Replace("��Բ", "Բ");
            strUpper = strUpper.Replace("����", "��");

            // ��ҼԲ���µĽ��Ĵ���  
            if (strUpper.Substring(0, 1) == "Բ")
            {
                strUpper = strUpper.Substring(1, strUpper.Length - 1);
            }
            if (strUpper.Substring(0, 1) == "��")
            {
                strUpper = strUpper.Substring(1, strUpper.Length - 1);
            }
            if (strUpper.Substring(0, 1) == "��")
            {
                strUpper = strUpper.Substring(1, strUpper.Length - 1);
            }
            if (strUpper.Substring(0, 1) == "��")
            {
                strUpper = strUpper.Substring(1, strUpper.Length - 1);
            }
            if (strUpper.Substring(0, 1) == "��")
            {
                strUpper = "��Բ��";
            }
            functionReturnValue = strUpper;

            if (IsNegative == true)
            {
                return "��" + functionReturnValue;
            }
            else
            {
                return functionReturnValue;
            }
        }
        #endregion

        #endregion

        #region ��дToString

        /// <summary>
        /// ��ȡ���ɵ��ַ���
        /// </summary>
        public override string ToString()
        {
            return _str.ToString();
        }

        #endregion
    }
}