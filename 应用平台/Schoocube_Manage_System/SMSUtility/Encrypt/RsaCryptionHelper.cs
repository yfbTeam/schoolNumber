using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace SMSUtility
{
    /// <summary> 
    /// RSA���ܽ��ܼ�RSAǩ������֤
    /// </summary> 
    public class RsaCryptionHelper
    {
        #region RSA ���ܽ���

        #region RSA ����Կ����

        /// <summary>
        /// RSA ����Կ���� ����˽Կ �͹�Կ 
        /// </summary>
        /// <param name="xmlKeys">��Կ</param>
        /// <param name="xmlPublicKey">��Կ</param>
        public void RsaKey(out string xmlKeys, out string xmlPublicKey)
        {
            var rsa = new RSACryptoServiceProvider();
            xmlKeys = rsa.ToXmlString(true);
            xmlPublicKey = rsa.ToXmlString(false);
        }

        #endregion

        #region RSA�ļ��ܺ���

        /// <summary>
        /// RSA�ļ��ܺ���  string
        /// ˵��KEY������XML����ʽ,���ص����ַ��� 
        /// ����һ����Ҫ˵�������ü��ܷ�ʽ�� ���� ���Ƶģ��� 
        /// </summary>
        /// <param name="xmlPublicKey">��Կ</param>
        /// <param name="mStrEncryptString">�ַ���</param>
        /// <returns>���ؽ��</returns>
        public string RSAEncrypt(string xmlPublicKey, string mStrEncryptString)
        {
            var rsa = new RSACryptoServiceProvider();
            rsa.FromXmlString(xmlPublicKey);
            byte[] plainTextBArray = (new UnicodeEncoding()).GetBytes(mStrEncryptString);
            byte[] cypherTextBArray = rsa.Encrypt(plainTextBArray, false);
            string result = Convert.ToBase64String(cypherTextBArray);
            return result;
        }

        /// <summary>
        /// RSA�ļ��ܺ��� byte[]
        /// </summary>
        /// <param name="xmlPublicKey">��Կ</param>
        /// <param name="encryptString">batep[]��</param>
        /// <returns>���ܺ��ַ���</returns>
        public string RsaEncrypt(string xmlPublicKey, byte[] encryptString)
        {
            var rsa = new RSACryptoServiceProvider();
            rsa.FromXmlString(xmlPublicKey);
            byte[] cypherTextBArray = rsa.Encrypt(encryptString, false);
            string result = Convert.ToBase64String(cypherTextBArray);
            return result;
        }

        #endregion

        #region RSA�Ľ��ܺ���

        /// <summary>
        /// RSA�Ľ��ܺ���  string
        /// </summary>
        /// <param name="xmlPrivateKey">˽Կ</param>
        /// <param name="mStrDecryptString">����</param>
        /// <returns>���ܺ��ַ�</returns>
        public string RSADecrypt(string xmlPrivateKey, string mStrDecryptString)
        {
            var rsa = new RSACryptoServiceProvider();
            rsa.FromXmlString(xmlPrivateKey);
            byte[] plainTextBArray = Convert.FromBase64String(mStrDecryptString);
            byte[] dypherTextBArray = rsa.Decrypt(plainTextBArray, false);
            string result = (new UnicodeEncoding()).GetString(dypherTextBArray);
            return result;
        }

        /// <summary>
        /// RSA�Ľ��ܺ���  byte
        /// </summary>
        /// <param name="xmlPrivateKey">��Կ</param>
        /// <param name="decryptString">����</param>
        /// <returns>���ܺ��ַ�</returns>
        public string RSADecrypt(string xmlPrivateKey, byte[] decryptString)
        {
            var rsa = new RSACryptoServiceProvider();
            rsa.FromXmlString(xmlPrivateKey);
            byte[] dypherTextBArray = rsa.Decrypt(decryptString, false);
            string result = (new UnicodeEncoding()).GetString(dypherTextBArray);
            return result;
        }

        #endregion

        #endregion

        #region RSA����ǩ��

        #region ��ȡHash������

        /// <summary>
        /// ��ȡHash������
        /// </summary>
        /// <param name="mStrSource">�ļ�·��</param>
        /// <param name="hashData">hashֵ(�ַ��ֽ�)</param>
        /// <returns></returns>
        public bool GetHash(string mStrSource, ref byte[] hashData)
        {
            //���ַ�����ȡ��Hash���� 
            HashAlgorithm md5 = HashAlgorithm.Create("MD5");
            byte[] buffer = Encoding.GetEncoding("GB2312").GetBytes(mStrSource);
            hashData = md5.ComputeHash(buffer);

            return true;
        }

        /// <summary>
        /// ��ȡHash������ 
        /// </summary>
        /// <param name="mStrSource">�ļ�·��</param>
        /// <param name="strHashData">hashֵ(�ַ���)</param>
        /// <returns></returns>
        public bool GetHash(string mStrSource, ref string strHashData)
        {
            //���ַ�����ȡ��Hash���� 
            HashAlgorithm md5 = HashAlgorithm.Create("MD5");
            byte[] buffer = Encoding.GetEncoding("GB2312").GetBytes(mStrSource);
            byte[] hashData = md5.ComputeHash(buffer);

            strHashData = Convert.ToBase64String(hashData);
            return true;
        }
        /// <summary>
        /// ��ȡHash������
        /// </summary>
        /// <param name="objFile">�ļ���</param>
        /// <param name="hashData">hashֵ(�ַ��ֽ�)</param>
        /// <returns></returns>
        public bool GetHash(FileStream objFile, ref byte[] hashData)
        {
            //���ļ���ȡ��Hash���� 
            HashAlgorithm md5 = HashAlgorithm.Create("MD5");
            hashData = md5.ComputeHash(objFile);
            objFile.Close();

            return true;
        }

        /// <summary>
        /// ��ȡHash������
        /// </summary>
        /// <param name="objFile">�ļ���</param>
        /// <param name="strHashData">hashֵ(�ַ��ֽ�)</param>
        /// <returns></returns>
        public bool GetHash(FileStream objFile, ref string strHashData)
        {
            //���ļ���ȡ��Hash���� 
            HashAlgorithm md5 = HashAlgorithm.Create("MD5");
            byte[] hashData = md5.ComputeHash(objFile);
            objFile.Close();

            strHashData = Convert.ToBase64String(hashData);

            return true;
        }

        #endregion

        #region RSAǩ��

        /// <summary>
        /// RSAǩ�� 
        /// </summary>
        /// <param name="pStrKeyPrivate">˽Կ</param>
        /// <param name="hashbyteSignature"></param>
        /// <param name="encryptedSignatureData"></param>
        /// <returns></returns>
        public bool SignatureFormatter(string pStrKeyPrivate, byte[] hashbyteSignature,
                                       ref byte[] encryptedSignatureData)
        {
            var rsa = new RSACryptoServiceProvider();

            rsa.FromXmlString(pStrKeyPrivate);
            var rsaFormatter = new RSAPKCS1SignatureFormatter(rsa);
            //����ǩ�����㷨ΪMD5 
            rsaFormatter.SetHashAlgorithm("MD5");
            //ִ��ǩ�� 
            encryptedSignatureData = rsaFormatter.CreateSignature(hashbyteSignature);

            return true;
        }

        /// <summary>
        /// RSAǩ�� 
        /// </summary>
        /// <param name="pStrKeyPrivate">˽Կ</param>
        /// <param name="hashbyteSignature"></param>
        /// <param name="mStrEncryptedSignatureData"></param>
        /// <returns></returns>
        public bool SignatureFormatter(string pStrKeyPrivate, byte[] hashbyteSignature,
                                       ref string mStrEncryptedSignatureData)
        {
            var rsa = new RSACryptoServiceProvider();

            rsa.FromXmlString(pStrKeyPrivate);
            var rsaFormatter = new RSAPKCS1SignatureFormatter(rsa);
            //����ǩ�����㷨ΪMD5 
            rsaFormatter.SetHashAlgorithm("MD5");
            //ִ��ǩ�� 
            byte[] encryptedSignatureData = rsaFormatter.CreateSignature(hashbyteSignature);

            mStrEncryptedSignatureData = Convert.ToBase64String(encryptedSignatureData);

            return true;
        }

        /// <summary>
        /// RSAǩ�� 
        /// </summary>
        /// <param name="pStrKeyPrivate">˽Կ</param>
        /// <param name="mStrHashbyteSignature"></param>
        /// <param name="encryptedSignatureData"></param>
        /// <returns></returns>
        public bool SignatureFormatter(string pStrKeyPrivate, string mStrHashbyteSignature,
                                       ref byte[] encryptedSignatureData)
        {
            byte[] hashbyteSignature = Convert.FromBase64String(mStrHashbyteSignature);
            var rsa = new RSACryptoServiceProvider();

            rsa.FromXmlString(pStrKeyPrivate);
            var rsaFormatter = new RSAPKCS1SignatureFormatter(rsa);
            //����ǩ�����㷨ΪMD5 
            rsaFormatter.SetHashAlgorithm("MD5");
            //ִ��ǩ�� 
            encryptedSignatureData = rsaFormatter.CreateSignature(hashbyteSignature);

            return true;
        }

        /// <summary>
        /// RSAǩ�� 
        /// </summary>
        /// <param name="pStrKeyPrivate">˽Կ</param>
        /// <param name="mStrHashbyteSignature"></param>
        /// <param name="mStrEncryptedSignatureData"></param>
        /// <returns></returns>
 
        public bool SignatureFormatter(string pStrKeyPrivate, string mStrHashbyteSignature,
                                       ref string mStrEncryptedSignatureData)
        {
            byte[] hashbyteSignature = Convert.FromBase64String(mStrHashbyteSignature);
            var rsa = new RSACryptoServiceProvider();

            rsa.FromXmlString(pStrKeyPrivate);
            var rsaFormatter = new RSAPKCS1SignatureFormatter(rsa);
            //����ǩ�����㷨ΪMD5 
            rsaFormatter.SetHashAlgorithm("MD5");
            //ִ��ǩ�� 
            byte[] encryptedSignatureData = rsaFormatter.CreateSignature(hashbyteSignature);

            mStrEncryptedSignatureData = Convert.ToBase64String(encryptedSignatureData);

            return true;
        }

        #endregion

        #region RSA ǩ����֤
        /// <summary>
        /// RSA ǩ����֤
        /// </summary>
        /// <param name="pStrKeyPublic">��Կ</param>
        /// <param name="hashbyteDeformatter"></param>
        /// <param name="deformatterData"></param>
        /// <returns></returns>
        public bool SignatureDeformatter(string pStrKeyPublic, byte[] hashbyteDeformatter, byte[] deformatterData)
        {
            var rsa = new RSACryptoServiceProvider();

            rsa.FromXmlString(pStrKeyPublic);
            var rsaDeformatter = new RSAPKCS1SignatureDeformatter(rsa);
            //ָ�����ܵ�ʱ��HASH�㷨ΪMD5 
            rsaDeformatter.SetHashAlgorithm("MD5");

            return rsaDeformatter.VerifySignature(hashbyteDeformatter, deformatterData);
        }
        /// <summary>
        /// RSA ǩ����֤
        /// </summary>
        /// <param name="pStrKeyPublic">��Կ</param>
        /// <param name="pStrHashbyteDeformatter"></param>
        /// <param name="deformatterData"></param>
        /// <returns></returns>
        public bool SignatureDeformatter(string pStrKeyPublic, string pStrHashbyteDeformatter, byte[] deformatterData)
        {
            byte[] hashbyteDeformatter = Convert.FromBase64String(pStrHashbyteDeformatter);

            var rsa = new RSACryptoServiceProvider();

            rsa.FromXmlString(pStrKeyPublic);
            var rsaDeformatter = new RSAPKCS1SignatureDeformatter(rsa);
            //ָ�����ܵ�ʱ��HASH�㷨ΪMD5 
            rsaDeformatter.SetHashAlgorithm("MD5");

            return rsaDeformatter.VerifySignature(hashbyteDeformatter, deformatterData);
        }
        /// <summary>
        /// RSA ǩ����֤
        /// </summary>
        /// <param name="pStrKeyPublic">��Կ</param>
        /// <param name="hashbyteDeformatter"></param>
        /// <param name="pStrDeformatterData"></param>
        /// <returns></returns>
        public bool SignatureDeformatter(string pStrKeyPublic, byte[] hashbyteDeformatter, string pStrDeformatterData)
        {
            var rsa = new RSACryptoServiceProvider();

            rsa.FromXmlString(pStrKeyPublic);
            var rsaDeformatter = new RSAPKCS1SignatureDeformatter(rsa);
            //ָ�����ܵ�ʱ��HASH�㷨ΪMD5 
            rsaDeformatter.SetHashAlgorithm("MD5");

            byte[] deformatterData = Convert.FromBase64String(pStrDeformatterData);

            return rsaDeformatter.VerifySignature(hashbyteDeformatter, deformatterData);
        }
        /// <summary>
        /// RSA ǩ����֤
        /// </summary>
        /// <param name="pStrKeyPublic">��Կ</param>
        /// <param name="pStrHashbyteDeformatter"></param>
        /// <param name="pStrDeformatterData"></param>
        /// <returns></returns>
        public bool SignatureDeformatter(string pStrKeyPublic, string pStrHashbyteDeformatter,
                                         string pStrDeformatterData)
        {
            byte[] hashbyteDeformatter = Convert.FromBase64String(pStrHashbyteDeformatter);
            var rsa = new RSACryptoServiceProvider();

            rsa.FromXmlString(pStrKeyPublic);
            var rsaDeformatter = new RSAPKCS1SignatureDeformatter(rsa);
            //ָ�����ܵ�ʱ��HASH�㷨ΪMD5 
            rsaDeformatter.SetHashAlgorithm("MD5");

            byte[] deformatterData = Convert.FromBase64String(pStrDeformatterData);

            return rsaDeformatter.VerifySignature(hashbyteDeformatter, deformatterData);
        }

        #endregion

        #endregion
    }
}