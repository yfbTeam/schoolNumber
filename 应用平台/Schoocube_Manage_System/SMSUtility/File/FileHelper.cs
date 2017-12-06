using System;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

namespace SMSUtility
{
    /// <summary>
    /// �ļ�����������
    /// </summary>
    public class FileHelper
    {
        #region �ֶζ���

        /// <summary>
        /// ͬ����ʶ
        /// </summary>
        private static readonly Object sync = new object();

        #endregion

        #region ���ָ��Ŀ¼�Ƿ����

        /// <summary>
        /// ���ָ��Ŀ¼�Ƿ����
        /// </summary>
        /// <param name="directoryPath">Ŀ¼�ľ���·��</param>        
        public static bool IsExistDirectory(string directoryPath)
        {
            return Directory.Exists(directoryPath);
        }

        #endregion

        #region ���ָ���ļ��Ƿ����

        /// <summary>
        /// ���ָ���ļ��Ƿ����,��������򷵻�true��
        /// </summary>
        /// <param name="filePath">�ļ��ľ���·��</param>        
        public static bool IsExistFile(string filePath)
        {
            return File.Exists(filePath);
        }

        #endregion

        #region ���ָ��Ŀ¼�Ƿ�Ϊ��

        /// <summary>
        /// ���ָ��Ŀ¼�Ƿ�Ϊ��
        /// </summary>
        /// <param name="directoryPath">ָ��Ŀ¼�ľ���·��</param>        
        public static bool IsEmptyDirectory(string directoryPath)
        {
            try
            {
                //�ж��Ƿ�����ļ�
                string[] fileNames = GetFileNames(directoryPath);
                if (fileNames.Length > 0)
                {
                    return false;
                }

                //�ж��Ƿ�����ļ���
                string[] directoryNames = GetDirectories(directoryPath);
                if (directoryNames.Length > 0)
                {
                    return false;
                }

                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion

        #region ���ָ��Ŀ¼���Ƿ����ָ�����ļ�

        /// <summary>
        /// ���ָ��Ŀ¼���Ƿ����ָ�����ļ�,��Ҫ������Ŀ¼��ʹ�����ط���.
        /// </summary>
        /// <param name="directoryPath">ָ��Ŀ¼�ľ���·��</param>
        /// <param name="searchPattern">ģʽ�ַ�����"*"����0��N���ַ���"?"����1���ַ���
        /// ������"Log*.xml"��ʾ����������Log��ͷ��Xml�ļ���</param>        
        public static bool Contains(string directoryPath, string searchPattern)
        {
            try
            {
                //��ȡָ�����ļ��б�
                string[] fileNames = GetFileNames(directoryPath, searchPattern, false);

                //�ж�ָ���ļ��Ƿ����
                if (fileNames.Length == 0)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// ���ָ��Ŀ¼���Ƿ����ָ�����ļ�
        /// </summary>
        /// <param name="directoryPath">ָ��Ŀ¼�ľ���·��</param>
        /// <param name="searchPattern">ģʽ�ַ�����"*"����0��N���ַ���"?"����1���ַ���
        /// ������"Log*.xml"��ʾ����������Log��ͷ��Xml�ļ���</param> 
        /// <param name="isSearchChild">�Ƿ�������Ŀ¼</param>
        public static bool Contains(string directoryPath, string searchPattern, bool isSearchChild)
        {
            try
            {
                //��ȡָ�����ļ��б�
                string[] fileNames = GetFileNames(directoryPath, searchPattern, true);

                //�ж�ָ���ļ��Ƿ����
                if (fileNames.Length == 0)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion

        #region ����һ��Ŀ¼

        /// <summary>
        /// ����һ��Ŀ¼
        /// </summary>
        /// <param name="directoryPath">Ŀ¼�ľ���·��</param>
        public static bool CreateDirectory(string directoryPath)
        {
            bool flag = true;
            try
            {
                //���Ŀ¼�������򴴽���Ŀ¼
                if (!IsExistDirectory(directoryPath))
                {
                    Directory.CreateDirectory(directoryPath);
                }
            }
            catch (Exception ex)
            {
                flag = false;
                LogService.WriteErrorLog(ex.Message);
            }
            return flag;

        }

        #endregion

        #region ����һ���ļ�

        #region ����һ���ļ�

        /// <summary>
        /// ����һ���ļ�
        /// </summary>
        /// <param name="filePath">�ļ��ľ���·��</param>
        public static void CreateFile(string filePath)
        {
            try
            {
                //����ļ��������򴴽����ļ�
                if (!IsExistFile(filePath))
                {
                    //��ȡ�ļ�Ŀ¼·��
                    string directoryPath = GetDirectoryFromFilePath(filePath);

                    //����ļ���Ŀ¼�����ڣ��򴴽�Ŀ¼
                    CreateDirectory(directoryPath);

                    lock (sync)
                    {
                        //�����ļ�                    
                        using (var fs = new FileStream(filePath, FileMode.OpenOrCreate))
                        {
                        }
                    }
                }
            }
            catch
            {
            }
        }

        #endregion

        #region ����һ���ļ�,�����ֽ���д���ļ�

        /// <summary>
        /// ����һ���ļ�,�����ֽ���д���ļ���
        /// </summary>
        /// <param name="filePath">�ļ��ľ���·��</param>
        /// <param name="buffer">������������</param>
        public static void CreateFile(string filePath, byte[] buffer)
        {
            try
            {
                //����ļ��������򴴽����ļ�
                if (!IsExistFile(filePath))
                {
                    //��ȡ�ļ�Ŀ¼·��
                    string directoryPath = GetDirectoryFromFilePath(filePath);

                    //����ļ���Ŀ¼�����ڣ��򴴽�Ŀ¼
                    CreateDirectory(directoryPath);

                    //����һ��FileInfo����
                    var file = new FileInfo(filePath);

                    //�����ļ�
                    using (FileStream fs = file.Create())
                    {
                        //д���������
                        fs.Write(buffer, 0, buffer.Length);
                    }
                }
            }
            catch
            {
            }
        }

        #endregion

        #region ����һ���ļ�,�����ַ���д���ļ�

        #region ����1

        /// <summary>
        /// ����һ���ļ�,�����ַ���д���ļ���
        /// </summary>
        /// <param name="filePath">�ļ��ľ���·��</param>
        /// <param name="text">�ַ�������</param>
        public static void CreateFile(string filePath, string text)
        {
            CreateFile(filePath, text, Encoding.UTF8);
        }

        #endregion

        #region ����2

        /// <summary>
        /// ����һ���ļ�,�����ַ���д���ļ���
        /// </summary>
        /// <param name="filePath">�ļ��ľ���·��</param>
        /// <param name="text">�ַ�������</param>
        /// <param name="encoding">�ַ�����</param>
        public static void CreateFile(string filePath, string text, Encoding encoding)
        {
            try
            {
                //����ļ��������򴴽����ļ�
                if (!IsExistFile(filePath))
                {
                    //��ȡ�ļ�Ŀ¼·��
                    string directoryPath = GetDirectoryFromFilePath(filePath);

                    //����ļ���Ŀ¼�����ڣ��򴴽�Ŀ¼
                    CreateDirectory(directoryPath);

                    //�����ļ�
                    var file = new FileInfo(filePath);
                    using (FileStream stream = file.Create())
                    {
                        using (var writer = new StreamWriter(stream, encoding))
                        {
                            //д���ַ���     
                            writer.Write(text);

                            //���
                            writer.Flush();
                        }
                    }
                }
            }
            catch
            {
            }
        }

        #endregion

        #endregion

        #endregion

        #region ��Ŀ¼

        /// <summary>
        /// ��Ŀ¼
        /// </summary>
        /// <param name="directoryPath">Ŀ¼�ľ���·��</param>
        public static void OpenDirectory(string directoryPath)
        {
            //���Ŀ¼�Ƿ����
            if (!IsExistDirectory(directoryPath))
            {
                return;
            }

            //��Ŀ¼
            WebUtils.GetMapPath(directoryPath);
        }

        #endregion

        #region ���ļ�

        /// <summary>
        /// ���ļ�
        /// </summary>
        /// <param name="filePath">�ļ��ľ���·��</param>
        public static void OpenFile(string filePath)
        {
            //����ļ��Ƿ����
            if (!IsExistFile(filePath))
            {
                return;
            }

            //��Ŀ¼
            WebUtils.GetMapPath(filePath);
        }

        #endregion

        #region ���ļ�����·���л�ȡĿ¼·��

        /// <summary>
        /// ���ļ�����·���л�ȡĿ¼·��
        /// </summary>
        /// <param name="filePath">�ļ��ľ���·��</param>
        public static string GetDirectoryFromFilePath(string filePath)
        {
            //ʵ�����ļ�
            var file = new FileInfo(filePath);

            //��ȡĿ¼��Ϣ
            DirectoryInfo directory = file.Directory;

            //����Ŀ¼·��
            return directory.FullName;
        }

        #endregion

        #region ��ȡ�ı��ļ�������

        /// <summary>
        /// ��ȡ�ı��ļ�������
        /// </summary>
        /// <param name="filePath">�ļ��ľ���·��</param>        
        public static int GetLineCount(string filePath)
        {
            //��������ȡ��
            using (var reader = new StreamReader(filePath))
            {
                //����
                int i = 0;

                while (true)
                {
                    //�����ȡ�����ݾͰ�������1
                    if (reader.ReadLine() != null)
                    {
                        i++;
                    }
                    else
                    {
                        break;
                    }
                }

                //��������
                return i;
            }
        }

        #endregion

        #region ��ȡһ���ļ��ĳ���

        /// <summary>
        /// ��ȡһ���ļ��ĳ���,��λΪByte
        /// </summary>
        /// <param name="filePath">�ļ��ľ���·��</param>        
        public static int GetFileSize(string filePath)
        {
            //����һ���ļ�����
            var fi = new FileInfo(filePath);

            //��ȡ�ļ��Ĵ�С
            return (int)fi.Length;
        }

        /// <summary>
        /// ��ȡһ���ļ��ĳ���,��λΪKB
        /// </summary>
        /// <param name="filePath">�ļ���·��</param>        
        public static double GetFileSizeByKB(string filePath)
        {
            //����һ���ļ�����
            var fi = new FileInfo(filePath);

            //��ȡ�ļ��Ĵ�С
            return ConvertHelper.ToDouble(ConvertHelper.ToDouble(fi.Length) / 1024, 1);
        }

        /// <summary>
        /// ��ȡһ���ļ��ĳ���,��λΪMB
        /// </summary>
        /// <param name="filePath">�ļ���·��</param>        
        public static double GetFileSizeByMB(string filePath)
        {
            //����һ���ļ�����
            var fi = new FileInfo(filePath);

            //��ȡ�ļ��Ĵ�С
            return ConvertHelper.ToDouble(ConvertHelper.ToDouble(fi.Length) / 1024 / 1024, 1);
        }

        #endregion

        #region
         public static long GetDirectoryLength(string dirPath)
        {
            //�жϸ�����·���Ƿ����,������������˳�
            if (!Directory.Exists(dirPath))
                return 0;
            long len = 0;

            //����һ��DirectoryInfo����
            DirectoryInfo di = new DirectoryInfo(dirPath);

            //ͨ��GetFiles����,��ȡdiĿ¼�е������ļ��Ĵ�С
            foreach (FileInfo fi in di.GetFiles())
            {
                len += fi.Length;
            }
            //��ȡdi�����е��ļ���,���浽һ���µĶ���������,�Խ��еݹ�
            DirectoryInfo[] dis = di.GetDirectories();
            if (dis.Length > 0)
            {
                for (int i = 0; i < dis.Length; i++)
                {
                    len += GetDirectoryLength(dis[i].FullName);
                }
            }
            return len;
        }

        //Ҳ�����õݹ��˼��,ֻ������ͨ��File���Exits�������ж�

        //����·��������Ӧ���Ƿ�Ϊ�ļ�

        public static long FileSize(string filePath)
        {
            long temp = 0;

            //�жϵ�ǰ·����ָ����Ƿ�Ϊ�ļ�
            if (File.Exists(filePath) == false)
            {
                string[] str1 = Directory.GetFileSystemEntries(filePath);
                foreach (string s1 in str1)
                {
                    temp += FileSize(s1);
                }
            }
            else
            {
                //����һ��FileInfo����,ʹ֮��filePath��ָ����ļ������,
                //�Ի�ȡ���С
                FileInfo fileInfo = new FileInfo(filePath);
                return fileInfo.Length;
            }
            return temp;
        }
        #endregion
        #region ��ȡָ��Ŀ¼�е��ļ��б�

        /// <summary>
        /// ��ȡָ��Ŀ¼�������ļ��б�
        /// </summary>
        /// <param name="directoryPath">ָ��Ŀ¼�ľ���·��</param>        
        public static string[] GetFileNames(string directoryPath)
        {
            //���Ŀ¼�����ڣ����׳��쳣
            if (!IsExistDirectory(directoryPath))
            {
                throw new FileNotFoundException();
            }

            //��ȡ�ļ��б�
            return Directory.GetFiles(directoryPath);
        }

        /// <summary>
        /// ��ȡָ��Ŀ¼����Ŀ¼�������ļ��б�
        /// </summary>
        /// <param name="directoryPath">ָ��Ŀ¼�ľ���·��</param>
        /// <param name="searchPattern">ģʽ�ַ�����"*"����0��N���ַ���"?"����1���ַ���
        /// ������"Log*.xml"��ʾ����������Log��ͷ��Xml�ļ���</param>
        /// <param name="isSearchChild">�Ƿ�������Ŀ¼</param>
        public static string[] GetFileNames(string directoryPath, string searchPattern, bool isSearchChild)
        {
            //���Ŀ¼�����ڣ����׳��쳣
            if (!IsExistDirectory(directoryPath))
            {
                throw new FileNotFoundException();
            }

            try
            {
                if (isSearchChild)
                {
                    return Directory.GetFiles(directoryPath, searchPattern, SearchOption.AllDirectories);
                }
                else
                {
                    return Directory.GetFiles(directoryPath, searchPattern, SearchOption.TopDirectoryOnly);
                }
            }
            catch (IOException ex)
            {
                throw ex;
            }
        }

        #endregion

        #region ��ȡָ��Ŀ¼�е���Ŀ¼�б�

        /// <summary>
        /// ��ȡָ��Ŀ¼��������Ŀ¼�б�,��Ҫ����Ƕ�׵���Ŀ¼�б�,��ʹ�����ط���.
        /// </summary>
        /// <param name="directoryPath">ָ��Ŀ¼�ľ���·��</param>        
        public static string[] GetDirectories(string directoryPath)
        {
            try
            {
                return Directory.GetDirectories(directoryPath);
            }
            catch (IOException ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// ��ȡָ��Ŀ¼����Ŀ¼��������Ŀ¼�б�
        /// </summary>
        /// <param name="directoryPath">ָ��Ŀ¼�ľ���·��</param>
        /// <param name="searchPattern">ģʽ�ַ�����"*"����0��N���ַ���"?"����1���ַ���
        /// ������"Log*.xml"��ʾ����������Log��ͷ��Xml�ļ���</param>
        /// <param name="isSearchChild">�Ƿ�������Ŀ¼</param>
        public static string[] GetDirectories(string directoryPath, string searchPattern, bool isSearchChild)
        {
            try
            {
                if (isSearchChild)
                {
                    return Directory.GetDirectories(directoryPath, searchPattern, SearchOption.AllDirectories);
                }
                else
                {
                    return Directory.GetDirectories(directoryPath, searchPattern, SearchOption.TopDirectoryOnly);
                }
            }
            catch (IOException ex)
            {
                throw ex;
            }
        }

        #endregion

        #region ���ı��ļ�д������

        /// <summary>
        /// ���ı��ļ���д������
        /// </summary>
        /// <param name="filePath">�ļ��ľ���·��</param>
        /// <param name="text">д�������</param>        
        public static void WriteText(string filePath, string text)
        {
            WriteText(filePath, text, Encoding.UTF8);
        }

        /// <summary>
        /// ���ı��ļ���д������
        /// </summary>
        /// <param name="filePath">�ļ��ľ���·��</param>
        /// <param name="text">д�������</param>
        /// <param name="encoding">����</param>
        public static void WriteText(string filePath, string text, Encoding encoding)
        {
            //���ļ�д������
            File.WriteAllText(filePath, text, encoding);
        }

        #endregion

        #region ���ı��ļ���β��׷������

        /// <summary>
        /// ���ı��ļ���β��׷������
        /// </summary>
        /// <param name="filePath">�ļ��ľ���·��</param>
        /// <param name="text">д�������</param>
        public static void AppendText(string filePath, string text)
        {
            //======= ׷������ =======
            try
            {
                lock (sync)
                {
                    //������д����
                    using (var writer = new StreamWriter(filePath, true))
                    {
                        writer.WriteLine(text);
                    }
                }
            }
            catch
            {
            }
        }

        #endregion

        #region �������ļ������ݸ��Ƶ����ļ���

        /// <summary>
        /// ��Դ�ļ������ݸ��Ƶ�Ŀ���ļ���
        /// </summary>
        /// <param name="sourceFilePath">Դ�ļ��ľ���·��</param>
        /// <param name="destFilePath">Ŀ���ļ��ľ���·��</param>
        public static void CopyTo(string sourceFilePath, string destFilePath)
        {
            //��Ч�Լ��
            if (!IsExistFile(sourceFilePath))
            {
                return;
            }

            try
            {
                //���Ŀ���ļ���Ŀ¼�Ƿ���ڣ��������򴴽�
                string destDirectoryPath = GetDirectoryFromFilePath(destFilePath);
                CreateDirectory(destDirectoryPath);

                //�����ļ�
                var file = new FileInfo(sourceFilePath);
                file.CopyTo(destFilePath, true);
            }
            catch
            {
            }
        }

        #endregion
        public static void CopyFolder(string strFromPath, string strToPath)
        {
            //���Դ�ļ��в����ڣ��򴴽�
            if (!Directory.Exists(strFromPath))
            {
                Directory.CreateDirectory(strFromPath);
            }
            //ȡ��Ҫ�������ļ�����
            string strFolderName = strFromPath.Substring(strFromPath.LastIndexOf("\\") +
               1, strFromPath.Length - strFromPath.LastIndexOf("\\") - 1);
            //���Ŀ���ļ�����û��Դ�ļ�������Ŀ���ļ����д���Դ�ļ���
            if (!Directory.Exists(strToPath + "\\" + strFolderName))
            {
                Directory.CreateDirectory(strToPath + "\\" + strFolderName);
            }
            //�������鱣��Դ�ļ����µ��ļ���
            string[] strFiles = Directory.GetFiles(strFromPath);
            //ѭ�������ļ�
            for (int i = 0; i < strFiles.Length; i++)
            {
                //ȡ�ÿ������ļ�����ֻȡ�ļ�������ַ�ص���
                string strFileName = strFiles[i].Substring(strFiles[i].LastIndexOf("\\") + 1, strFiles[i].Length - strFiles[i].LastIndexOf("\\") - 1);
                //��ʼ�����ļ�,true��ʾ����ͬ���ļ�
                File.Copy(strFiles[i], strToPath + "\\" + strFolderName + "\\" + strFileName, true);
            }
            //����DirectoryInfoʵ��
            DirectoryInfo dirInfo = new DirectoryInfo(strFromPath);
            //ȡ��Դ�ļ����µ��������ļ�������
            DirectoryInfo[] ZiPath = dirInfo.GetDirectories();
            for (int j = 0; j < ZiPath.Length; j++)
            {
                //��ȡ�������ļ�����
                string strZiPath = strFromPath + "\\" + ZiPath[j].ToString();
                //�ѵõ������ļ��е����µ�Դ�ļ��У���ͷ��ʼ��һ�ֵĿ���
                CopyFolder(strZiPath, strToPath + "\\" + strFolderName);
            }
        }
        

        #region ���ļ��ƶ���ָ��Ŀ¼( ���� )

        /// <summary>
        /// ���ļ��ƶ���ָ��Ŀ¼( ���� )
        /// </summary>
        /// <param name="sourceFilePath">��Ҫ�ƶ���Դ�ļ��ľ���·��</param>
        /// <param name="descDirectoryPath">�ƶ�����Ŀ¼�ľ���·��</param>
        public static void MoveToDirectory(string sourceFilePath, string descDirectoryPath)
        {
            //��Ч�Լ��
            if (!IsExistFile(sourceFilePath))
            {
                return;
            }

            try
            {
                //��ȡԴ�ļ�������
                string sourceFileName = GetFileName(sourceFilePath);

                //���Ŀ��Ŀ¼�������򴴽�
                CreateDirectory(descDirectoryPath);

                //���Ŀ���д���ͬ���ļ�,��ɾ��
                if (IsExistFile(descDirectoryPath + "\\" + sourceFileName))
                {
                    DeleteFile(descDirectoryPath + "\\" + sourceFileName);
                }

                //Ŀ���ļ�·��
                string descFilePath;
                if (!descDirectoryPath.EndsWith(@"\"))
                {
                    descFilePath = descDirectoryPath + "\\" + sourceFileName;
                }
                else
                {
                    descFilePath = descDirectoryPath + sourceFileName;
                }

                //���ļ��ƶ���ָ��Ŀ¼
                File.Move(sourceFilePath, descFilePath);
            }
            catch
            {
            }
        }

        #endregion

        #region ���ļ��ƶ���ָ��Ŀ¼����ָ���µ��ļ���( ���в����� )

        /// <summary>
        /// ���ļ��ƶ���ָ��Ŀ¼����ָ���µ��ļ���( ���в����� )
        /// </summary>
        /// <param name="sourceFilePath">��Ҫ�ƶ���Դ�ļ��ľ���·��</param>
        /// <param name="descFilePath">Ŀ���ļ��ľ���·��</param>
        public static void Move(string sourceFilePath, string descFilePath)
        {
            //��Ч�Լ��
            if (!IsExistFile(sourceFilePath))
            {
                return;
            }

            try
            {
                //��ȡĿ���ļ�Ŀ¼
                string descDirectoryPath = GetDirectoryFromFilePath(descFilePath);

                //����Ŀ��Ŀ¼
                CreateDirectory(descDirectoryPath);

                //���ļ��ƶ���ָ��Ŀ¼
                File.Move(sourceFilePath, descFilePath);
            }
            catch
            {
            }
        }

        #endregion

        #region ������ȡ����������

        /// <summary>
        /// ������ȡ����������
        /// </summary>
        /// <param name="stream">ԭʼ��</param>
        public static byte[] StreamToBytes(Stream stream)
        {
            try
            {
                //����������
                var buffer = new byte[stream.Length];

                //��ȡ��
                stream.Read(buffer, 0, ConvertHelper.ToInt32(stream.Length));

                //������
                return buffer;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                //�ر���
                stream.Close();
            }
        }

        #endregion

        #region ���ļ���ȡ����������

        /// <summary>
        /// ���ļ���ȡ����������
        /// </summary>
        /// <param name="filePath">�ļ��ľ���·��</param>
        public static byte[] FileToBytes(string filePath)
        {
            //��ȡ�ļ��Ĵ�С 
            int fileSize = GetFileSize(filePath);

            //����һ����ʱ������
            var buffer = new byte[fileSize];

            //����һ���ļ�
            var file = new FileInfo(filePath);

            //����һ���ļ���
            using (FileStream fs = file.Open(FileMode.Open))
            {
                //���ļ������뻺����
                fs.Read(buffer, 0, fileSize);

                return buffer;
            }
        }

        #endregion

        #region ���ļ���ȡ���ַ�����

        /// <summary>
        /// ���ļ���ȡ���ַ�����
        /// </summary>
        /// <param name="filePath">�ļ��ľ���·��</param>
        public static string FileToString(string filePath)
        {
            return FileToString(filePath, Encoding.UTF8);
        }

        /// <summary>
        /// ���ļ���ȡ���ַ�����
        /// </summary>
        /// <param name="filePath">�ļ��ľ���·��</param>
        /// <param name="encoding">�ַ�����</param>
        public static string FileToString(string filePath, Encoding encoding)
        {
            //��������ȡ��
            var reader = new StreamReader(filePath, encoding);
            try
            {
                //��ȡ��
                return reader.ReadToEnd();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                //�ر�����ȡ��
                reader.Close();
            }
        }

        #endregion

        #region ���ļ��ľ���·���л�ȡ�ļ���( ������չ�� )

        /// <summary>
        /// ���ļ��ľ���·���л�ȡ�ļ���( ������չ�� )
        /// </summary>
        /// <param name="filePath">�ļ��ľ���·��</param>        
        public static string GetFileName(string filePath)
        {
            //��ȡ�ļ�������
            var fi = new FileInfo(filePath);
            return fi.Name;
        }

        #endregion

        #region ���ļ��ľ���·���л�ȡ�ļ���( ��������չ�� )

        /// <summary>
        /// ���ļ��ľ���·���л�ȡ�ļ���( ��������չ�� )
        /// </summary>
        /// <param name="filePath">�ļ��ľ���·��</param>        
        public static string GetFileNameNoExtension(string filePath)
        {
            //��ȡ�ļ�������
            var fi = new FileInfo(filePath);
            return fi.Name.Split('.')[0];
        }

        #endregion

        #region ���ļ��ľ���·���л�ȡ��չ��

        /// <summary>
        /// ���ļ��ľ���·���л�ȡ��չ��
        /// </summary>
        /// <param name="filePath">�ļ��ľ���·��</param>        
        public static string GetExtension(string filePath)
        {
            //��ȡ�ļ�������
            var fi = new FileInfo(filePath);
            return fi.Extension;
        }

        #endregion

        #region ���ָ��Ŀ¼

        /// <summary>
        /// ���ָ��Ŀ¼�������ļ�����Ŀ¼,����Ŀ¼��Ȼ����.
        /// </summary>
        /// <param name="directoryPath">ָ��Ŀ¼�ľ���·��</param>
        public static void ClearDirectory(string directoryPath)
        {
            if (IsExistDirectory(directoryPath))
            {
                //ɾ��Ŀ¼�����е��ļ�
                string[] fileNames = GetFileNames(directoryPath);
                foreach (string t in fileNames)
                {
                    DeleteFile(t);
                }

                //ɾ��Ŀ¼�����е���Ŀ¼
                string[] directoryNames = GetDirectories(directoryPath);
                foreach (string t in directoryNames)
                {
                    DeleteDirectory(t);
                }
            }
        }

        #endregion

        #region ����ļ�����

        /// <summary>
        /// ����ļ�����
        /// </summary>
        /// <param name="filePath">�ļ��ľ���·��</param>
        public static void ClearFile(string filePath)
        {
            //ɾ���ļ�
            File.Delete(filePath);

            //���´������ļ�
            CreateFile(filePath);
        }

        #endregion

        #region ɾ��ָ���ļ�

        /// <summary>
        /// ɾ��ָ���ļ�
        /// </summary>
        /// <param name="filePath">�ļ��ľ���·��</param>
        public static void DeleteFile(string filePath)
        {
            if (IsExistFile(filePath))
            {
                File.Delete(filePath);
            }
        }

        #endregion

        #region ɾ��ָ��Ŀ¼

        /// <summary>
        /// ɾ��ָ��Ŀ¼����������Ŀ¼
        /// </summary>
        /// <param name="directoryPath">ָ��Ŀ¼�ľ���·��</param>
        public static void DeleteDirectory(string directoryPath)
        {
            if (IsExistDirectory(directoryPath))
            {
                Directory.Delete(directoryPath, true);
            }
        }

        #endregion

        #region д�ļ�

        /// <summary>
        /// д�ļ�
        /// </summary>
        /// <param name="strFilePath"></param>
        /// <param name="strValue"></param>
        public static void WriteFile(string strFilePath, string strValue)
        {
            var oFile = new FileInfo(strFilePath);
            if (!oFile.Directory.Exists)
                oFile.Directory.Create();

            if (!oFile.Exists)
                oFile.Create().Close();

            var oWrite = new StreamWriter(strFilePath, false, Encoding.UTF8);
            oWrite.Write(strValue);
            oWrite.Flush();
            oWrite.Close();
        }

        /// <summary>
        /// д�ļ�
        /// </summary>
        /// <param name="strFilePath"></param>
        /// <param name="strValue"></param>
        /// <param name="charset"></param>
        public static void WriteFile(string strFilePath, string strValue, string charset)
        {
            var oFile = new FileInfo(strFilePath);
            if (!oFile.Directory.Exists)
                oFile.Directory.Create();

            if (!oFile.Exists)
                oFile.Create().Close();

            var oWrite = new StreamWriter(strFilePath, false, Encoding.GetEncoding(charset));
            oWrite.Write(strValue);
            oWrite.Flush();
            oWrite.Close();
        }

        #endregion
    }
    public class WebUtils
    {
        #region ��õ�ǰ����·��

        /// <summary>
        /// ��õ�ǰ����·��
        /// </summary>
        /// <param name="strPath">ָ����·��</param>
        /// <returns>����·��</returns>
        public static string GetMapPath(string strPath)
        {
            if (HttpContext.Current != null)
            {
                return HttpContext.Current.Server.MapPath(strPath);
            }
            else //��web��������
            {
                return Path.Combine(AppDomain.CurrentDomain.BaseDirectory, strPath);
            }
        }

        #endregion

        /// <summary>
        /// ���ָ��Url������ֵ
        /// </summary>
        /// <param name="strName">Url����</param>
        /// <returns>Url������ֵ</returns>
        public static string GetQueryString(string strName)
        {
            if (HttpContext.Current.Request.QueryString[strName] == null)
            {
                return "";
            }
            return HttpContext.Current.Request.QueryString[strName];
        }

        /// <summary>
        /// ���ָ����������ֵ
        /// </summary>
        /// <param name="strName">������</param>
        /// <returns>��������ֵ</returns>
        public static string GetFormString(string strName)
        {
            if (HttpContext.Current.Request.Form[strName] == null)
            {
                return "";
            }
            return HttpContext.Current.Request.Form[strName];
        }

        /// <summary>
        /// ���Url���������ֵ, ���ж�Url�����Ƿ�Ϊ���ַ���, ��ΪTrue�򷵻ر�������ֵ
        /// </summary>
        /// <param name="strName">����</param>
        /// <returns>Url���������ֵ</returns>
        public static string GetString(string strName)
        {
            if ("".Equals(GetQueryString(strName)))
            {
                return GetFormString(strName);
            }
            else
            {
                return GetQueryString(strName);
            }
        }


    }
}