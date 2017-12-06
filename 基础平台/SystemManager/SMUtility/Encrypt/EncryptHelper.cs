using System;
using System.Collections;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;

namespace SMSUtility
{
    /// <summary>
    /// �ַ�������
    /// </summary>
    public class EncryptHelper
    {
        #region MD5����

        #region MD5�㷨�����ַ���( 16λ )

        /// <summary>
        /// MD5�㷨�����ַ���( 16λ )
        /// </summary>
        /// <param name="text">Ҫ���ܵ��ַ���</param>    
        public static string Md5By16(string text)
        {
            //����ַ���Ϊ�գ��򷵻�
            if (ValidationHelper.IsNullOrEmpty(text))
            {
                return string.Empty;
            }

            try
            {
                //����MD5��������ṩ����
                var md5 = new MD5CryptoServiceProvider();

                //��ȡ�����ַ���
                string result = BitConverter.ToString(md5.ComputeHash(Encoding.Default.GetBytes(text)), 4, 8);

                //�ͷ���Դ
                md5.Clear();

                //����MD5ֵ���ַ�����ʾ
                return result.Replace("-", "");
            }
            catch
            {
                return string.Empty;
            }
        }

        #endregion

        #region MD5�㷨�����ַ���( 32λ )

        #region ����1

        /// <summary>
        /// MD5�㷨�����ַ���( 32λ )
        /// </summary>
        /// <param name="text">Ҫ���ܵ��ַ���</param>    
        /// <param name="encoding">�ַ�����</param>    
        public static string MD5By32(string text, Encoding encoding)
        {
            //����ַ���Ϊ�գ��򷵻�
            if (ValidationHelper.IsNullOrEmpty(text))
            {
                return string.Empty;
            }

            try
            {
                //����MD5��������ṩ����
                var md5 = new MD5CryptoServiceProvider();

                //���㴫����ֽ�����Ĺ�ϣֵ
                byte[] hashCode = md5.ComputeHash(encoding.GetBytes(text));

                //�ͷ���Դ
                md5.Clear();

                //����MD5ֵ���ַ�����ʾ
                string temp = "";
                int len = hashCode.Length;
                for (int i = 0; i < len; i++)
                {
                    temp += hashCode[i].ToString("x").PadLeft(2, '0');
                }
                return temp;
            }
            catch
            {
                return string.Empty;
            }
        }

        #endregion

        #region ����2

        /// <summary>
        /// MD5�㷨�����ַ���( 32λ )
        /// </summary>
        /// <param name="text">Ҫ���ܵ��ַ���</param>
        public static string Md5By32(string text)
        {
            return MD5By32(text, Encoding.UTF8);
        }

        #endregion

        #region ����3

        /// <summary>
        /// MD5�㷨�����ַ���( ֧����ר�� )
        /// </summary>
        /// <param name="text">Ҫ���ܵ��ַ���</param>
        public static string Md5ByAlipay(string text)
        {
            return MD5By32(text, Encoding.GetEncoding("gb2312"));
        }

        #endregion

        #endregion

        #endregion

        #region Base64����

        /// <summary>
        /// Base64����
        /// </summary>
        /// <param name="text">Ҫ���ܵ��ַ���</param>
        /// <returns></returns>
        public static string EncodeBase64(string text)
        {
            //����ַ���Ϊ�գ��򷵻�
            if (ValidationHelper.IsNullOrEmpty<string>(text))
            {
                return "";
            }

            var base64Code = new[]
                                 {
                                     'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
                                     'Q', 'R', 'S', 'T',
                                     'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
                                     'k', 'l', 'm', 'n',
                                     'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3',
                                     '4', '5', '6', '7',
                                     '8', '9', '+', '/', '='
                                 };
            const byte empty = 0;
            var byteMessage = new ArrayList(Encoding.Default.GetBytes(text));
            int messageLen = byteMessage.Count;
            int page = messageLen/3;
            int use;
            if ((use = messageLen%3) > 0)
            {
                for (int i = 0; i < 3 - use; i++)
                    byteMessage.Add(empty);
                page++;
            }
            var outmessage = new StringBuilder(page*4);
            for (int i = 0; i < page; i++)
            {
                var instr = new byte[3];
                instr[0] = (byte) byteMessage[i*3];
                instr[1] = (byte) byteMessage[i*3 + 1];
                instr[2] = (byte) byteMessage[i*3 + 2];
                var outstr = new int[4];
                outstr[0] = instr[0] >> 2;
                outstr[1] = ((instr[0] & 0x03) << 4) ^ (instr[1] >> 4);
                if (!instr[1].Equals(empty))
                    outstr[2] = ((instr[1] & 0x0f) << 2) ^ (instr[2] >> 6);
                else
                    outstr[2] = 64;
                if (!instr[2].Equals(empty))
                    outstr[3] = (instr[2] & 0x3f);
                else
                    outstr[3] = 64;
                outmessage.Append(base64Code[outstr[0]]);
                outmessage.Append(base64Code[outstr[1]]);
                outmessage.Append(base64Code[outstr[2]]);
                outmessage.Append(base64Code[outstr[3]]);
            }
            return outmessage.ToString();
        }

        #endregion

        #region Base64����

        /// <summary>
        /// Base64����
        /// </summary>
        /// <param name="text">Ҫ���ܵ��ַ���</param>
        public static string DecodeBase64(string text)
        {
            //����ַ���Ϊ�գ��򷵻�
            if (ValidationHelper.IsNullOrEmpty<string>(text))
            {
                return "";
            }

            //���ո��滻Ϊ�Ӻ�
            text = text.Replace(" ", "+");

            if ((text.Length%4) != 0)
            {
                return "��������ȷ��BASE64����";
            }
            if (!Regex.IsMatch(text, "^[A-Z0-9/+=]*$", RegexOptions.IgnoreCase))
            {
                return "��������ȷ��BASE64����";
            }
            const string base64Code = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
            int page = text.Length/4;
            var outMessage = new ArrayList(page*3);
            char[] message = text.ToCharArray();
            for (int i = 0; i < page; i++)
            {
                var instr = new byte[4];
                instr[0] = (byte) base64Code.IndexOf(message[i*4]);
                instr[1] = (byte) base64Code.IndexOf(message[i*4 + 1]);
                instr[2] = (byte) base64Code.IndexOf(message[i*4 + 2]);
                instr[3] = (byte) base64Code.IndexOf(message[i*4 + 3]);
                var outstr = new byte[3];
                outstr[0] = (byte) ((instr[0] << 2) ^ ((instr[1] & 0x30) >> 4));
                if (instr[2] != 64)
                {
                    outstr[1] = (byte) ((instr[1] << 4) ^ ((instr[2] & 0x3c) >> 2));
                }
                else
                {
                    outstr[2] = 0;
                }
                if (instr[3] != 64)
                {
                    outstr[2] = (byte) ((instr[2] << 6) ^ instr[3]);
                }
                else
                {
                    outstr[2] = 0;
                }
                outMessage.Add(outstr[0]);
                if (outstr[1] != 0)
                    outMessage.Add(outstr[1]);
                if (outstr[2] != 0)
                    outMessage.Add(outstr[2]);
            }
            var outbyte = (byte[]) outMessage.ToArray(Type.GetType("System.Byte"));
            return Encoding.Default.GetString(outbyte);
        }

        #endregion

        #region HMAC����

        /// <summary>
        /// HMAC����
        /// </summary>
        /// <param name="text">Ҫ���ܵ��ı�</param>
        /// <param name="key">��</param>
        public static string Hmac32(string text, string key)
        {
            //����ַ���Ϊ�գ��򷵻�
            if (ValidationHelper.IsNullOrEmpty(text))
            {
                return string.Empty;
            }

            const string ipad = "6666666666666666666666666666666666666666666666666666666666666666";
            const string opad = @"\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\";
            string kIpad = FunMd5(StrXor(key, ipad) + text);

            string kOpad = StrXor(key, opad);

            byte[] test = Hexstr2Array(kIpad);

            char[] b = Encoding.GetEncoding(1252).GetChars(test);
            string temp = b.Aggregate("", (current, t) => current + t);
            temp = kOpad + temp;
            return FunMd5(temp).ToLower();
        }

        private static  string FunMd5(string str)
        {
            byte[] b = Encoding.GetEncoding(1252).GetBytes(str);
            b = new MD5CryptoServiceProvider().ComputeHash(b);
            string ret = "";
            for (int i = 0; i < b.Length; i++)
                ret += b[i].ToString("x").PadLeft(2, '0');
            return ret;
        }

        private static Byte[] Hexstr2Array(string hexStr)
        {
            const string hex = "0123456789ABCDEF";
            string str = hexStr.ToUpper();
            int len = str.Length;
            var retByte = new byte[len/2];
            for (int i = 0; i < len/2; i++)
            {
                int numHigh = hex.IndexOf(str[i*2]);
                int numLow = hex.IndexOf(str[i*2 + 1]);
                retByte[i] = Convert.ToByte(numHigh*16 + numLow);
            }
            return retByte;
        }

        private static string StrXor(string password, string pad)
        {
            string iResult = "";
            int kLen = password.Length;

            for (int i = 0; i < 64; i++)
            {
                if (i < kLen)
                    iResult += Convert.ToChar(pad[i] ^ password[i]);
                else
                    iResult += Convert.ToChar(pad[i]);
            }
            return iResult;
        }

        #endregion

        #region ʹ�� ȱʡ��Կ�ַ��� ����/����string

        /// <summary>
        /// ʹ��ȱʡ��Կ�ַ�������string
        /// </summary>
        /// <param name="original">����</param>
        /// <returns>����</returns>
        public static string Encrypt(string original)
        {
            return Encrypt(original, "LITIANPING");
        }

        /// <summary>
        /// ʹ��ȱʡ��Կ�ַ�������string
        /// </summary>
        /// <param name="original">����</param>
        /// <returns>����</returns>
        public static string Decrypt(string original)
        {
            return Decrypt(original, "LITIANPING", Encoding.Default);
        }

        #endregion

        #region ʹ�� ������Կ�ַ��� ����/����string

        /// <summary>
        /// ʹ�ø�����Կ�ַ�������string
        /// </summary>
        /// <param name="original">ԭʼ����</param>
        /// <param name="key">��Կ</param>
        /// <returns>����</returns>
        public static string Encrypt(string original, string key)
        {
            byte[] buff = Encoding.Default.GetBytes(original);
            byte[] kb = Encoding.Default.GetBytes(key);
            return Convert.ToBase64String(Encrypt(buff, kb));
        }

        /// <summary>
        /// ʹ�ø�����Կ�ַ�������string
        /// </summary>
        /// <param name="original">����</param>
        /// <param name="key">��Կ</param>
        /// <returns>����</returns>
        public static string Decrypt(string original, string key)
        {
            return Decrypt(original, key, Encoding.Default);
        }

        /// <summary>
        /// ʹ�ø�����Կ�ַ�������string,����ָ�����뷽ʽ����
        /// </summary>
        /// <param name="encrypted">����</param>
        /// <param name="key">��Կ</param>
        /// <param name="encoding">�ַ����뷽��</param>
        /// <returns>����</returns>
        public static string Decrypt(string encrypted, string key, Encoding encoding)
        {
            byte[] buff = Convert.FromBase64String(encrypted);
            byte[] kb = Encoding.Default.GetBytes(key);
            return encoding.GetString(Decrypt(buff, kb));
        }

        #endregion

        #region ʹ�� ȱʡ��Կ�ַ��� ����/����/byte[]

        /// <summary>
        /// ʹ��ȱʡ��Կ�ַ�������byte[]
        /// </summary>
        /// <param name="encrypted">����</param>
        /// <returns>����</returns>
        public static byte[] Decrypt(byte[] encrypted)
        {
            byte[] key = Encoding.Default.GetBytes("LITIANPING");
            return Decrypt(encrypted, key);
        }

        /// <summary>
        /// ʹ��ȱʡ��Կ�ַ�������
        /// </summary>
        /// <param name="original">ԭʼ����</param>
        /// <returns>����</returns>
        public static byte[] Encrypt(byte[] original)
        {
            byte[] key = Encoding.Default.GetBytes("LITIANPING");
            return Encrypt(original, key);
        }

        #endregion

        #region  ʹ�� ������Կ ����/����/byte[]

        /// <summary>
        /// ����MD5ժҪ
        /// </summary>
        /// <param name="original">����Դ</param>
        /// <returns>ժҪ</returns>
        public static byte[] MakeMd5(byte[] original)
        {
            var hashmd5 = new MD5CryptoServiceProvider();
            byte[] keyhash = hashmd5.ComputeHash(original);
            return keyhash;
        }


        /// <summary>
        /// ʹ�ø�����Կ����
        /// </summary>
        /// <param name="original">����</param>
        /// <param name="key">��Կ</param>
        /// <returns>����</returns>
        public static byte[] Encrypt(byte[] original, byte[] key)
        {
            var des = new TripleDESCryptoServiceProvider {Key = MakeMd5(key), Mode = CipherMode.ECB};

            return des.CreateEncryptor().TransformFinalBlock(original, 0, original.Length);
        }

        /// <summary>
        /// ʹ�ø�����Կ��������
        /// </summary>
        /// <param name="encrypted">����</param>
        /// <param name="key">��Կ</param>
        /// <returns>����</returns>
        public static byte[] Decrypt(byte[] encrypted, byte[] key)
        {
            var des = new TripleDESCryptoServiceProvider {Key = MakeMd5(key), Mode = CipherMode.ECB};

            return des.CreateDecryptor().TransformFinalBlock(encrypted, 0, encrypted.Length);
        }

        #endregion
    }
}