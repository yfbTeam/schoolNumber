using SMSUtility.Mail.Enum;
using SMSUtility.Mail.Helper;
using System;
using System.Collections;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Diagnostics;
using System.IO;
using System.Net.Mail;
using System.Net.Mime;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Linq;

namespace SMSUtility
{
    /// <summary>
    /// ���̰߳�ȫ��
    /// ʹ��ע�����
    /// 1���������裨Ҳ���ܣ����ⲿ�������̣߳���Ϊ�ڲ����ṩ���첽���͡��������ڡ��ⶼʹ�ö��̻߳ᵼ���̳߳ضԿ�����Դ�����У��Ӷ��������������̡߳�
    /// 2��MailHelper��� m_autoDisposeSmtp ���Ե�ʹ�ã���������ֶ�ע�͡�
    /// 3������ UTF-8 �ַ�����
    /// </summary>
    public class MailHelper
    {

        #region ���캯��

        /// <summary>
        /// ���� MailHelper ʵ��
        /// </summary>
        /// <param name="isAsync">�Ƿ������첽�ʼ����ͣ�Ĭ��Ϊͬ������</param>
        public MailHelper(bool isAsync = false)
        {
            m_IsAsync = isAsync;
        }

        /// <summary>
        /// ���� MailHelper ʵ��
        /// </summary>
        /// <param name="mSmtpClient">SmtpClientʵ��</param>
        /// <param name="autoReleaseSmtp">�Ƿ��Զ��ͷ�SmtpClientʵ��</param>
        /// <param name="isAsync">�Ƿ������첽�ʼ�����</param>
        public MailHelper(SmtpClient mSmtpClient, bool autoReleaseSmtp, bool isAsync = false)
        {
            this.SetSmtpClient(mSmtpClient, autoReleaseSmtp);
            m_IsAsync = isAsync;
        }

        #endregion

        #region  �ƻ��ʼ����� �� ��ִ������ʼ�����

        // ��¼�ͻ�ȡ�ڴ�����ִ���첽���ŷ���ʱ�Ѿ������˶�������¼
        // 1�����ݴ�ֵ�ֶ����Զ��ͷ� SmtpClient .ʵ����û����Ҫ���ݴ�ֵ�����ֶ��ͷţ���Ϊ��ȫ�������Զ��ͷ��滻���߼�
        // 2�����ݴ�ֵ�����Լ����ý���
        private long m_CompletedSendCount = 0;
        public long CompletedSendCount
        {
            get { return Interlocked.Read(ref m_CompletedSendCount); }
            private set { Interlocked.Exchange(ref m_CompletedSendCount, value); }
        }

        // �ƻ��ʼ�����
        private long m_PrepareSendCount = 0;
        public long PrepareSendCount
        {
            get { return Interlocked.Read(ref m_PrepareSendCount); }
            private set { Interlocked.Exchange(ref m_PrepareSendCount, value); }
        }

        #endregion

        #region �첽 �����ʼ���ز���

        // �Ƿ������첽�����ʼ�
        private bool m_IsAsync = false;

        // ��������Ϊ�첽�����ʼ���SmtpClient�����������֤һ��һ��ķ��͡�
        // �������������̡߳����Ի��ö��еķ�ʽ���������ķ�ʽ�����첽���ʹ������ʼ�

        // ����������ܺܳ�������ʹ�� Thread ��������ThreadPool�������ⳤʱ���ݾ��̳߳��̣߳�������SmtpClientֻ֧��һ��һ���ʼ�����
        private Thread m_SendMailThread = null;

        private AutoResetEvent m_AutoResetEvent = null;
        private AutoResetEvent AutoResetEvent
        {
            get
            {
                if (m_AutoResetEvent == null)
                    m_AutoResetEvent = new AutoResetEvent(true);
                return m_AutoResetEvent;
            }
        }

        // �����Ͷ��л�����������������������Ϊ����߻�ȡ�˼�����Ч��
        private int m_messageQueueCount = 0;
        // ��Ϊ MessageQueue ������ m_SendMailThread �߳��н��г��Ӳ���,����ʹ�ò�������ConcurrentQueue.
        // �����е�����ֻ��ͨ��ȡ���첽���ͽ�����գ�����ͻ�ÿһԪ�ض�ִ�з����ʼ�
        private ConcurrentQueue<MailUserState> m_MessageQueue = null;
        private ConcurrentQueue<MailUserState> MessageQueue
        {
            get
            {
                if (m_MessageQueue == null)
                    m_MessageQueue = new ConcurrentQueue<MailUserState>();
                return m_MessageQueue;
            }
        }

        /// <summary>
        /// ��ִ���첽����ʱ���ݵĶ������ڴ��ݸ��첽�������ʱ���õķ��� OnSendCompleted ��
        /// </summary>
        public object AsycUserState { get; set; }

        #endregion

        #region �ڲ��ֶΡ�����

        private SmtpClient m_SmtpClient = null;

        /// <summary>
        /// Ĭ��Ϊfalse�������� MailHelper ���ڲ����������ʼ����Ƿ��Զ��ͷ� SmtpClient ʵ��
        /// Smtp�������� MailHelper �ڲ��������ⲿ��������������ͷţ�
        /// ��Ϊ��SmtpClient û���ṩ Finalize() �ս���������GC������л��գ�ֻ��ʹ��������������ͷţ�����ᷢ���ڴ�й¶���⡣
        /// 
        /// ��ʱ�� autoReleaseSmtp ����Ϊfalse������SmtpClient��Ҫ�ظ�ʹ�õ����������Ҫʹ�á���ͬMailHelper������ͬSmtp�����������ʹ��������ʼ�ʱ��
        /// </summary>
        private bool m_autoDisposeSmtp = false;

        /// <summary>
        /// ���ô˵����ʼ����ռ��˵ĵ�ַ���ϡ�
        /// </summary>
        Dictionary<string, string> m_DicTo = null;
        Dictionary<string, string> DicTo
        {
            get
            {
                if (m_DicTo == null)
                    m_DicTo = new Dictionary<string, string>();
                return m_DicTo;
            }
        }
        /// <summary>
        /// ���ô˵����ʼ��ĳ��� (CC) �ռ��˵ĵ�ַ���ϡ�
        /// </summary>
        Dictionary<string, string> m_DicCC = null;
        Dictionary<string, string> DicCC
        {
            get
            {
                if (m_DicCC == null)
                    m_DicCC = new Dictionary<string, string>();
                return m_DicCC;
            }
        }
        /// <summary>
        /// ���ô˵����ʼ����ܼ����� (BCC) �ռ��˵ĵ�ַ���ϡ�
        /// </summary>
        Dictionary<string, string> m_DicBcc = null;
        Dictionary<string, string> DicBcc
        {
            get
            {
                if (m_DicBcc == null)
                    m_DicBcc = new Dictionary<string, string>();
                return m_DicBcc;
            }
        }
        // ��������
        Collection<Attachment> m_Attachments;
        Collection<Attachment> Attachments
        {
            get
            {
                if (m_Attachments == null)
                    m_Attachments = new Collection<Attachment>();
                return m_Attachments;
            }
        }
        // ָ��һ�������ʼ���ͬ��ʽ��ʾ�ĸ�����
        Collection<AlternateView> m_AlternateViews;
        Collection<AlternateView> AlternateViews
        {
            get
            {
                if (m_AlternateViews == null)
                    m_AlternateViews = new Collection<AlternateView>();
                return m_AlternateViews;
            }
        }

        #endregion

        #region ��������

        /// <summary>
        /// ���ô˵����ʼ��ķ����˵�ַ��
        /// </summary>
        public string From { get; set; }
        /// <summary>
        /// ���ô˵����ʼ��ķ����˵�ַ��
        /// </summary>
        public string FromDisplayName { get; set; }

        /// <summary>
        /// ���ô˵����ʼ������⡣
        /// </summary>
        public string Subject { get; set; }
        /// <summary>
        /// �����ʼ����ġ�
        /// </summary>
        public string Body { get; set; }

        /// <summary>
        /// �����ʼ������Ƿ�Ϊ Html ��ʽ��ֵ��
        /// </summary>
        public bool IsBodyHtml { get; set; }

        private int priority = 0;
        /// <summary>
        /// ���ô˵����ʼ������ȼ�  0-Normal   1-Low   2-High
        /// Ĭ��Normal��
        /// </summary>
        public int Priority
        {
            get { return this.priority; }
            set
            {
                if (value < 0 || value > 2)
                    priority = 0;
                else
                    priority = value;
            }
        }

        #endregion

        /// <summary>
        /// ���� MailHelper ʵ����Ϣ 
        /// ���ͷ� SmtpClient ʵ������ص�AutoReleaseSimple�ֶΣ���Ϊ�����첽���͡����������ֶ���SetSmtpClient��������
        /// </summary>
        public void Reset()
        {
            From = String.Empty;
            FromDisplayName = String.Empty;
            if (m_DicTo != null)
                m_DicTo.Clear();
            if (m_DicCC != null)
                m_DicCC.Clear();
            if (m_DicBcc != null)
                m_DicBcc.Clear();
            if (m_Attachments != null)
                m_Attachments.Clear();
            if (m_AlternateViews != null)
                m_AlternateViews.Clear();

            Subject = String.Empty;
            Body = String.Empty;
            IsBodyHtml = false;
            priority = 0;

            AsycUserState = null;

            // 1��������SmtpClient������ m_autoDisposeSmtp �����Զ��ͷŻ����ⲿ�����ͷ�
            // 2�������ã��첽�����Ͷ��м����м�����AutoResetEventʵ����ִ���첽�����̣߳��Ƿ������첽���ͱ�ʶ
        }

        #region SmtpClient ��ط���

        /// <summary>
        /// ���� MailHelper ʵ���Ƿ��Ѿ������� SmtpClient
        /// </summary>
        /// <returns>true����������</returns>
        public bool ExistsSmtpClient()
        {
            return m_SmtpClient != null ? true : false;
        }

        /// <summary>
        /// ���� SmtpClient ʵ�� ���Ƿ��Զ��ͷ�Smtp��Ψһ���
        /// 1�����ڲ� �ƻ����� �� ��������� ���㣬����ͳ���Ա��Զ��ͷ�SmtpClient
        /// 2����Ҫ��SmtpClent����SendCompleted�¼������ڵ��ô˷���ǰ��������
        /// </summary>
        /// <param name="mSmtpClient"> SmtpClient ʵ��</param>
        /// <param name="autoReleaseSmtp">������ MailHelper ���ڲ����������ʼ����Ƿ��Զ��ͷ� SmtpClient ʵ��</param>
        public void SetSmtpClient(SmtpClient mSmtpClient, bool autoReleaseSmtp)
        {
#if DEBUG
            Debug.WriteLine("����SmtpClient,�Զ��ͷ�Ϊ" + (autoReleaseSmtp ? "TRUE" : "FALSE"));
#endif
            m_SmtpClient = mSmtpClient;
            m_autoDisposeSmtp = autoReleaseSmtp;

            // ���ڲ� �ƻ����� �� ��������� ���㣬����ͳ���Ա��Զ��ͷ�SmtpClient  (MailHelperʵ��Ψһ������ط�)
            m_PrepareSendCount = 0;
            m_CompletedSendCount = 0;

            if (m_IsAsync && autoReleaseSmtp)
            {
                // ע���ڲ��ͷŻص��¼�.�ͷŶ���---���¼�������ȡ��ע�ᣬֻ���ͷ�SmtpClientʱ��һ���ͷ�   ������SmtpClient��MailHelper�󶨺󣬾Ͳ�Ҫ�ٵ���ʹ���ˣ�
                m_SmtpClient.SendCompleted += new SendCompletedEventHandler(SendCompleted4Dispose);
            }
        }

        /// <summary>
        /// �ͷ� SmtpClient
        /// </summary>
        public void ManualDisposeSmtp()
        {
            this.InnerDisposeSmtp();
        }

        /// <summary>
        /// �ͷ�SmtpClient
        /// </summary>
        private void AutoDisposeSmtp()
        {
            if (m_autoDisposeSmtp && m_SmtpClient != null)
            {
                if (PrepareSendCount == 0)
                {
                    // PrepareSendCount=0 ˵����δ���üƻ������ʼ��������Բ��Զ��ͷ�SmtpClient��
                    // ������ΪС��CompletedSendCount�ͱ�����Ϊ�������ȷ��������üƻ��ʼ�����
                }
                else if (PrepareSendCount < CompletedSendCount)
                {
                    throw new Exception(MailValidatorHelper.EMAIL_ADDRESS_RANGE_ERROR);
                }
                else if (PrepareSendCount == CompletedSendCount)
                {
                    this.InnerDisposeSmtp();
                }
            }
            else
            {
                // ����պ�Dispose()�ڲ���SmtpClient�ֶΣ���������Ҫ�ظ�ʹ��ʱ����Ҫ�ٵ��� SetSmtpClient() �������á�
            }
        }

        /// <summary>
        /// �ͷ�SmtpClient
        /// </summary>
        private void InnerDisposeSmtp()
        {
            if (m_SmtpClient != null)
            {
#if DEBUG
                Debug.WriteLine("�ͷ�SMtpClient");
#endif
                m_SmtpClient.Dispose();
                m_SmtpClient = null;

                // ������ SmtpClient ��ڴ����½�������
                m_autoDisposeSmtp = false;

                PrepareSendCount = 0;
                CompletedSendCount = 0;
            }
        }

        #endregion

        #region MessageAddress��Attachment��AlternateView ��ط���

        #region ����ռ��ˡ������ˡ������ˣ�ÿ�������У�����ַ���ظ���ֻ������һ����ַ��

        /// <summary>
        /// ����ռ��ˡ������ˡ������ˣ�ÿ�������У�����ַ���ظ���ֻ������һ����ַ��
        /// </summary>
        /// <param name="type">���ͣ��ռ��ˡ������ˡ�������</param>
        /// <param name="addressList">Email��ַ�б�</param>
        public void AddReceive(EmailAddrType type, IEnumerable<string> addressList)
        {
            MailValidatorHelper.ValideArgumentNull<IEnumerable<string>>(addressList, "addressList");
            
            if (addressList.Count() > 0)
            {
                Dictionary<string, string> dic = null;
                switch (type)
                {
                    case EmailAddrType.To:
                        dic = DicTo;
                        break;
                    case EmailAddrType.CC:
                        dic = DicCC;
                        break;
                    case EmailAddrType.Bcc:
                        dic = DicBcc;
                        break;
                    case EmailAddrType.From:
                        throw new Exception(MailValidatorHelper.EMAIL_ADDRESS_RANGE_ERROR);
                }

                foreach (string address in addressList)
                {
                    MailValidatorHelper.ValideStrNullOrEmpty(address, "addressList", MailValidatorHelper.EMAIL_ADDRESS_LIST_ERROR);
                    if (dic.Count > 0 && !dic.ContainsKey(address))
                        dic.Add(address, String.Empty);
                }
            }
        }

        /// <summary>
        /// ����ռ��ˡ������ˡ������ˣ�ÿ�������У�����ַ���ظ���ֻ������һ����ַ��
        /// </summary>
        /// <param name="type">���ͣ��ռ��ˡ������ˡ�������</param>
        /// <param name="address">Email��ַ</param>
        /// <param name="displayName">��ʾ����</param>
        public void AddReceive(EmailAddrType type, string address, string displayName)
        {
            MailValidatorHelper.ValideStrNullOrEmpty(address, "address");

            Dictionary<string, string> dic = null;
            switch (type)
            {
                case EmailAddrType.To:
                    dic = DicTo;
                    break;
                case EmailAddrType.CC:
                    dic = DicCC;
                    break;
                case EmailAddrType.Bcc:
                    dic = DicBcc;
                    break;
                case EmailAddrType.From:
                    throw new Exception(MailValidatorHelper.EMAIL_ADDRESS_RANGE_ERROR);
            }

            if (dic.Count == 0 || !dic.ContainsKey(address))
                dic.Add(address, displayName);

        }

        /// <summary>
        /// ����ռ��ˡ������ˡ������ˣ�ÿ�������У�����ַ���ظ���ֻ������һ����ַ��
        /// </summary>
        /// <param name="type">���ͣ��ռ��ˡ������ˡ�������</param>
        /// <param name="dicAddress">Email��ַ����ʾ����</param>
        public void AddReceive(EmailAddrType type, Dictionary<string, string> dicAddress)
        {
            MailValidatorHelper.ValideArgumentNull<Dictionary<string, string>>(dicAddress, "dicAddress");
            if (dicAddress.Count > 0)
            {
                Dictionary<string, string> dic = null;
                switch (type)
                {
                    case EmailAddrType.To:
                        dic = DicTo;
                        break;
                    case EmailAddrType.CC:
                        dic = DicCC;
                        break;
                    case EmailAddrType.Bcc:
                        dic = DicBcc;
                        break;
                    case EmailAddrType.From:
                        throw new Exception(MailValidatorHelper.EMAIL_ADDRESS_RANGE_ERROR);
                }

                foreach (KeyValuePair<string, string> keyValue in dicAddress)
                {
                    MailValidatorHelper.ValideStrNullOrEmpty(keyValue.Key, "dicAddress", MailValidatorHelper.EMAIL_ADDRESS_DIC_ERROR);
                    if (dic.Count > 0 && !dic.ContainsKey(keyValue.Key))
                        dic.Add(keyValue.Key, keyValue.Value);
                }
            }
        }

        #endregion

        #region ��Ӹ���

        /// <summary>
        /// ��ӵ�������
        /// </summary>
        /// <param name="attachment">Attachment����ʵ��</param>
        public void AddAttachment(Attachment attachment)
        {
            MailValidatorHelper.ValideArgumentNull<Attachment>(attachment, "attachment");
            Attachments.Add(attachment);
        }

        /// <summary>
        /// ��ӵ�������
        /// </summary>
        /// <param name="fieldPath">���ϴ��ļ�·��</param>
        /// <param name="fileName">�ļ���ʾ���ƣ�������׺��</param>
        public void AddAttachment(string fieldPath, string fileName = "")
        {
            MailValidatorHelper.ValideStrNullOrEmpty(fieldPath, "fieldPath");

            this.InnerAddAttachment(fieldPath, fileName, false, String.Empty);
        }

        /// <summary>
        /// �����Ƕ��Դ��eg��ͼƬ��mp3�ȵȣ�
        /// </summary>
        /// <param name="fieldPath">��Ƕ��Դ���ļ�·��</param>
        /// <param name="cidName">���ô˸����� MIME ���� ID</param>
        public void AddInlineAttachment(string fieldPath, string cidName)
        {
            MailValidatorHelper.ValideStrNullOrEmpty(fieldPath, "fieldPath");
            MailValidatorHelper.ValideStrNullOrEmpty(cidName, "cidName");

            this.InnerAddAttachment(fieldPath, String.Empty, true, cidName);
        }

        private void InnerAddAttachment(string fieldPath, string fileName, bool isInline, string cidName)
        {
            // ��ΪAttachment�д洢��ʱFilePath��Ӧ�ļ���Stream����������ڻ�ȡFileInfo��Ϣ��ʱ��ͬʱת��ΪStream���ݸ�Attachmentʵ����
            // �����ٴθ���FilePath��ȡ�ļ�����

            FileInfo file = new FileInfo(fieldPath);

            Stream stream = file.Open(FileMode.Open, FileAccess.Read, FileShare.Read);
            Attachment data = new Attachment(stream, String.Empty);

            //ʵ���ʼ�����
            ContentDisposition disposition = data.ContentDisposition;

            if (isInline)
            {
                disposition.Inline = true;
                // ���ô˸����� MIME ���� ID��
                data.ContentId = cidName;
            }

            // �����ļ������Ĵ������ڡ�
            disposition.CreationDate = file.CreationTime;
            // �����ļ��������޸����ڡ�
            disposition.ModificationDate = file.LastWriteTime;
            // �����ļ������Ķ�ȡ���ڡ�
            disposition.ReadDate = file.LastAccessTime;
            // �趨�ļ����� (��Ƕ��Դ�����ļ�����������������Ĭ�Ϻ�׺)
            if (String.IsNullOrEmpty(fileName))
                disposition.FileName = file.Name.ToString();
            else
            {

                disposition.FileName = fileName + Path.GetExtension(fieldPath);
            }

            Attachments.Add(data);
        }

        #endregion

        #region ���AlternateView
        // ָ��һ�������ʼ���ͬ��ʽ�ĸ�����
        //��eg������HTML��ʽ���ʼ�������ϣ��ͬʱ�ṩ�ʼ��Ĵ��ı���ʽ���Է�ֹһЩ�ռ���ʹ�õĵ����ʼ��Ķ������޷���ʾhtml���ݣ�

        /// <summary>
        /// ���һ�������ʼ���ͬ��ʽ�ĸ�����
        /// </summary>
        /// <param name="filePath">���������ʼ����ݵ��ļ�·��</param>
        public void AddAlterViewPath(string filePath)
        {
            MailValidatorHelper.ValideStrNullOrEmpty(filePath, "filePath");
            AlternateViews.Add(new AlternateView(filePath));
        }

        /// <summary>
        /// ���һ�������ʼ���ͬ��ʽ�ĸ�����
        /// </summary>
        /// <param name="mailContent">�����ʼ�����</param>
        public void AddAlterViewContent(string mailContent)
        {
            MailValidatorHelper.ValideStrNullOrEmpty(mailContent, "mailContent");
            AlternateViews.Add(AlternateView.CreateAlternateViewFromString(mailContent));
        }

        /// <summary>
        /// ���һ�������ʼ���ͬ��ʽ�ĸ�����
        /// </summary>
        /// <param name="contentStream">�����ʼ�������</param>
        public void AddAlterViewStream(Stream contentStream)
        {
            MailValidatorHelper.ValideArgumentNull<Stream>(contentStream, "contentStream");
            AlternateViews.Add(new AlternateView(contentStream));
        }

        /// <summary>
        /// ���һ�������ʼ���ͬ��ʽ�ĸ�����
        /// </summary>
        /// <param name="alternateView">�����ʼ���ͼ</param>
        public void AddAlternateView(AlternateView alternateView)
        {
            MailValidatorHelper.ValideArgumentNull<AlternateView>(alternateView, "alternateView");
            AlternateViews.Add(alternateView);
        }

        #endregion

        #endregion

        #region �����ʼ� ��ط���

        /// <summary>
        /// �ƻ����������ʼ��ĸ���������Զ��ͷ�SmtpClient���������ʼ����Ͳ����ô˷����Ͳ����Զ��ͷ�SmtpClient��
        /// 0���˷��������ڷ����ʼ�����֮ǰ��֮�����
        /// 1��ֻ�����ú�Ż��Զ����� m_autoDisposeSmtp �ֶν����ͷ�SmtpClient��
        /// 2���� m_autoDisposeSmtp = false �����Լ��ֶ��������õ�������ô˷�������Ԥ���ʼ���
        /// </summary>
        /// <param name="preCount">�ƻ��ʼ�����</param>
        public void SetBatchMailCount(long preCount)
        {
            PrepareSendCount = preCount;

            if (preCount < CompletedSendCount)
            {
                throw new ArgumentOutOfRangeException("preCount", MailValidatorHelper.EMAIL_ADDRESS_RANGE_ERROR);
            }
            else if (preCount == CompletedSendCount)
            {
                if (m_autoDisposeSmtp)
                    this.InnerDisposeSmtp();
            }
        }

        /// <summary>
        /// ͬ������һ��Email
        /// </summary>
        public void SendOneMail()
        {
            m_PrepareSendCount = 1;
            this.InnerSendMessage();
        }

        /// <summary>
        /// ����ͬ������Email
        /// </summary>
        public void SendBatchMail()
        {
            this.InnerSendMessage();
        }

        /// <summary>
        /// ȡ���첽�ʼ�����
        /// </summary>
        public void SendAsyncCancel()
        {
            // ��Ϊ����Ϊ���̰߳�ȫ�࣬���� SendAsyncCancel �ͷ����ʼ������в���MessageQueue���ֵĴ���϶��Ǵ��л��ġ�
            // ���Բ�����һ����ӣ�һ�߳��ӵ����޷���ȫȡ�������ʼ�����

            // 1����ն��С�
            // 2��ȡ�������첽���͵�mail��
            // 3�����üƻ�����=�������
            // 4��ִ�� AutoDisposeSmtp() 

            if (m_IsAsync)
            {
                // 1����ն��С�
                MailUserState tempMailUserState = null;
                while (MessageQueue.TryDequeue(out tempMailUserState))
                {
                    Interlocked.Decrement(ref m_messageQueueCount);
                    MailMessage message = tempMailUserState.CurMailMessage;
                    this.InnerDisposeMessage(message);
                }
                tempMailUserState = null;
                // 2��ȡ�������첽���͵�mail��
                m_SmtpClient.SendAsyncCancel();
                // 3�����üƻ�����=�������
                PrepareSendCount = CompletedSendCount;
                // 4��ִ�� AutoDisposeSmtp() 
                this.AutoDisposeSmtp();
            }
            else
            {
                throw new Exception(MailValidatorHelper.EMAIL_ASYNC_CALL_ERROR);
            }
        }

        /// <summary>
        /// ����Email
        /// </summary>
        private void InnerSendMessage()
        {

            bool hasError = false;
            MailMessage mMailMessage = null;

            #region ���� MailMessage
            try
            {
                mMailMessage = new MailMessage();

                mMailMessage.From = new MailAddress(From, FromDisplayName);

                this.InnerSetAddress(EmailAddrType.To, mMailMessage);
                this.InnerSetAddress(EmailAddrType.CC, mMailMessage);
                this.InnerSetAddress(EmailAddrType.Bcc, mMailMessage);

                mMailMessage.Subject = Subject;
                mMailMessage.Body = Body;

                if (m_Attachments != null && m_Attachments.Count > 0)
                {
                    foreach (Attachment attachment in m_Attachments)
                        mMailMessage.Attachments.Add(attachment);
                }

                mMailMessage.SubjectEncoding = Encoding.UTF8;
                mMailMessage.BodyEncoding = Encoding.UTF8;
                // SmtpClient �� Headers �л���� MailMessage Ĭ������Щֵ������Ӧ��Ϊ UTF8 ��
                mMailMessage.HeadersEncoding = Encoding.UTF8;

                mMailMessage.IsBodyHtml = IsBodyHtml;

                if (m_AlternateViews != null && m_AlternateViews.Count > 0)
                {
                    foreach (AlternateView alternateView in AlternateViews)
                    {
                        mMailMessage.AlternateViews.Add(alternateView);
                    }
                }

                mMailMessage.Priority = (MailPriority)Priority;
            }
            catch (ArgumentNullException argumentNullEx)
            {
                hasError = true;
                throw argumentNullEx;
            }
            catch (ArgumentException argumentEx)
            {
                hasError = true;
                throw argumentEx;
            }
            catch (FormatException formatEx)
            {
                hasError = true;
                throw formatEx;
            }
            finally
            {
                if (hasError)
                {
                    if (mMailMessage != null)
                    {
                        this.InnerDisposeMessage(mMailMessage);
                        mMailMessage = null;
                    }
                    this.InnerDisposeSmtp();
                }
            }

            #endregion

            if (!hasError)
            {
                if (m_IsAsync)
                {
                    #region �첽�����ʼ�

                    if (PrepareSendCount == 1)
                    {
                        // ���һ�������� SmtpClient ʵ���ὫPrepareSendCount����Ϊ1
                        // ��������ƻ�����ֻ��һ��

                        // PrepareSendCount �Ƿ��͵����ʼ���
                        MailUserState state = new MailUserState()
                        {
                            AutoReleaseSmtp = m_autoDisposeSmtp,
                            CurMailMessage = mMailMessage,
                            CurSmtpClient = m_SmtpClient,
                            IsSmpleMail = true,
                            UserState = AsycUserState,
                        };
                        if (m_autoDisposeSmtp)
                            // �ɷ�����ɻص��������� IsSmpleMail �ֶν����ͷ�
                            m_SmtpClient = null;

                        ThreadPool.QueueUserWorkItem((userState) =>
                        {
                            // ���� catch �����쳣����Ϊ���첽���������� catch ������
                            MailUserState curUserState = userState as MailUserState;
                            curUserState.CurSmtpClient.SendAsync(mMailMessage, userState);
                        }, state);

                    }
                    else
                    {
                        // ���һ������ SmtpClient �߼��������ǿ���ֱ�Ӳ���ȫ�ֵ� m_SmtpClient 
                        // ����������������ʼ� PrepareSendCount>1
                        // �������PrepareSendCount ��δ���ã�Ϊ0�����糡����ѭ������Щ�жϣ��پ������ʼ���ѭ����ŵ��� SetBatchMailCount ���üƻ��ʼ�����

                        MailUserState state = new MailUserState()
                        {
                            AutoReleaseSmtp = m_autoDisposeSmtp,
                            CurMailMessage = mMailMessage,
                            CurSmtpClient = m_SmtpClient,
                            UserState = AsycUserState,
                        };

                        MessageQueue.Enqueue(state);
                        Interlocked.Increment(ref m_messageQueueCount);

                        if (m_SendMailThread == null)
                        {
                            m_SendMailThread = new Thread(() =>
                            {
                                // noItemCount �λ�ȡ����Ԫ�أ����׳��߳��쳣
                                int noItemCount = 0;
                                while (true)
                                {
                                    if (PrepareSendCount != 0 && PrepareSendCount == CompletedSendCount)
                                    {
                                        // ��ִ����ϡ�
                                        this.AutoDisposeSmtp();
                                        break;
                                    }
                                    else
                                    {
                                        MailUserState curUserState = null;

                                        if (!MessageQueue.IsEmpty)
                                        {
#if DEBUG
                                            Debug.WriteLine("WaitOne" + Thread.CurrentThread.ManagedThreadId);
#endif
                                            // ��ִ���첽ȡ��ʱ�������MessageQueue������ WaitOne �����ڴ�MessageQueue��ȡ��Ԫ��֮ǰ
                                            AutoResetEvent.WaitOne();

                                            if (MessageQueue.TryDequeue(out curUserState))
                                            {
                                                Interlocked.Decrement(ref m_messageQueueCount);
                                                m_SmtpClient.SendAsync(curUserState.CurMailMessage, curUserState);
                                            }
                                        }
                                        else
                                        {
                                            if (noItemCount >= 10)
                                            {
                                                // û����ȷ���� PrepareSendCount ֵ��������û���ʼ������̳߳�����ѭ��
                                                this.InnerDisposeSmtp();

                                                throw new Exception(MailValidatorHelper.EMAIL_PREPARESENDCOUNT_NOTSET_ERROR);
                                            }

                                            Thread.Sleep(1000);
                                            noItemCount++;
                                        }
                                    }
                                    // SmtpClient Ϊnull��ʾ�첽Ԥ�Ʒ����ʼ����Ѿ������꣬�� OnSendCompleted ������ m_SmtpClient �ͷ�
                                    if (m_SmtpClient == null)
                                        break;
                                }

                                m_SendMailThread = null;
                            });
                            m_SendMailThread.Start();
                        }
                    }

                    #endregion
                }
                else
                {
                    #region ͬ�������ʼ�
                    try
                    {
                        m_SmtpClient.Send(mMailMessage);
                        m_CompletedSendCount++;
                    }
                    catch (ObjectDisposedException smtpDisposedEx)
                    {
                        throw smtpDisposedEx;
                    }
                    catch (InvalidOperationException smtpOperationEx)
                    {
                        throw smtpOperationEx;
                    }
                    catch (SmtpFailedRecipientsException smtpFailedRecipientsEx)
                    {
                        throw smtpFailedRecipientsEx;
                    }
                    catch (SmtpException smtpEx)
                    {
                        throw smtpEx;
                    }
                    finally
                    {
                        if (mMailMessage != null)
                        {
                            this.InnerDisposeMessage(mMailMessage);
                            mMailMessage = null;
                        }
                        this.AutoDisposeSmtp();
                    }
                    #endregion
                }
            }
        }

        /// <summary>
        /// ���ռ��ˡ������ˡ���������ӵ� MailMessage ��
        /// </summary>
        /// <param name="type">�ռ��ˡ������ˡ�������</param>
        /// <param name="mMailMessage">�����͵�MailMessage��</param>
        private void InnerSetAddress(EmailAddrType type, MailMessage mMailMessage)
        {
            MailAddressCollection receiveCol = null;
            Dictionary<string, string> dicReceive = null;
            bool hasAddress = false;
            switch (type)
            {
                case EmailAddrType.To:
                    {
                        if (m_DicTo != null && m_DicTo.Count > 0)
                        {
                            dicReceive = m_DicTo;
                            receiveCol = mMailMessage.To;
                            hasAddress = true;
                        }
                    }
                    break;
                case EmailAddrType.CC:
                    {
                        if (m_DicCC != null && m_DicCC.Count > 0)
                        {
                            dicReceive = m_DicCC;
                            receiveCol = mMailMessage.CC;
                            hasAddress = true;
                        }
                    }
                    break;
                case EmailAddrType.Bcc:
                    {
                        if (m_DicBcc != null && m_DicBcc.Count > 0)
                        {
                            dicReceive = m_DicBcc;
                            receiveCol = mMailMessage.Bcc;
                            hasAddress = true;
                        }
                    }
                    break;
                case EmailAddrType.From:
                    throw new Exception(MailValidatorHelper.EMAIL_ADDRESS_RANGE_ERROR);
            }
            if (hasAddress)
            {
                foreach (KeyValuePair<string, string> keyValue in dicReceive)
                {
                    receiveCol.Add(new MailAddress(keyValue.Key, keyValue.Value));
                }
            }
        }

        /// <summary>
        /// �ͷ� MailMessage ����
        /// </summary>
        private void InnerDisposeMessage(MailMessage message)
        {
            if (message != null)
            {
                if (message.AlternateViews.Count > 0)
                {
                    message.AlternateViews.Dispose();
                }

                message.Dispose();
                message = null;
            }
        }

        /// <summary>
        /// ������ SmtpClient.SendAsync() ִ������ͷ���ض���Ļص�����   ��󴥷���ί��
        /// </summary>
        protected void SendCompleted4Dispose(object sender, AsyncCompletedEventArgs e)
        {
            MailUserState state = e.UserState as MailUserState;

            if (state.CurMailMessage != null)
            {
                MailMessage message = state.CurMailMessage;
                this.InnerDisposeMessage(message);
                state.CurMailMessage = null;
            }

            if (state.IsSmpleMail)
            {
                if (state.AutoReleaseSmtp && state.CurSmtpClient != null)
                {
#if DEBUG
                    Debug.WriteLine("�ͷ�SmtpClient");
#endif
                    state.CurSmtpClient.Dispose();
                    state.CurSmtpClient = null;
                }
            }
            else
            {
                if (!e.Cancelled)   // ȡ���ľͲ�����
                    CompletedSendCount++;

                if (state.AutoReleaseSmtp)
                {
                    this.AutoDisposeSmtp();
                }

                // �������첽���ͣ���Ҫ�����ź�
#if DEBUG
                Debug.WriteLine("Set" + Thread.CurrentThread.ManagedThreadId);
#endif
                AutoResetEvent.Set();
            }

            // ���ͷ���Դ����������߼�
            if (e.Error != null && !state.IsErrorHandle)
            {
                throw e.Error;
            }
        }

        #endregion

        #region �첽�����ʼ���MessageQueue�����л���Ĵ����ʼ�������ʹ���߿ɸ��ݴ������������ʼ������������ڴ��˷�

        /// <summary>
        /// ��ȡ�첽�����ʼ���MessageQueue�����л���Ĵ����ʼ�����
        /// ��ʹ���߿ɸ��ݴ������������ʼ������������ڴ��˷ѣ�
        /// </summary>
        public int GetAwaitMailCountAsync()
        {
            if (m_IsAsync)
            {
                return Thread.VolatileRead(ref m_messageQueueCount);
            }
            else
            {
                throw new Exception(MailValidatorHelper.EMAIL_ASYNC_CALL_ERROR);
            }

        }

        #endregion

        #region �����ʼ�ǰ��� ��ط���

        /// <summary>
        /// �����ʼ�ǰ�����Ҫ���õ���Ϣ�Ƿ��������ռ�����ʾ+������Ϣ
        /// </summary>
        public Dictionary<MailInfoType, string> CheckSendMail()
        {
            Dictionary<MailInfoType, string> dicMsg = new Dictionary<MailInfoType, string>();

            this.InnerCheckSendMail4Info(dicMsg);
            this.InnerCheckSendMail4Error(dicMsg);

            return dicMsg;
        }

        /// <summary>
        /// �����ʼ�ǰ�����Ҫ���õ���Ϣ�Ƿ��������ռ� ��ʾ ��Ϣ
        /// </summary>
        public Dictionary<MailInfoType, string> CheckSendMail4Info()
        {
            Dictionary<MailInfoType, string> dicMsg = new Dictionary<MailInfoType, string>();

            this.InnerCheckSendMail4Info(dicMsg);

            return dicMsg;
        }

        /// <summary>
        /// �����ʼ�ǰ�����Ҫ���õ���Ϣ�Ƿ��������ռ� ���� ��Ϣ
        /// </summary>
        public Dictionary<MailInfoType, string> CheckSendMail4Error()
        {
            Dictionary<MailInfoType, string> dicMsg = new Dictionary<MailInfoType, string>();

            this.InnerCheckSendMail4Error(dicMsg);

            return dicMsg;
        }

        /// <summary>
        /// �����ʼ�ǰ�����Ҫ���õ���Ϣ�Ƿ��������ռ� ��ʾ ��Ϣ
        /// </summary>
        /// <param name="dicMsg">�������Ϣ�ռ����˼���</param>
        private void InnerCheckSendMail4Info(Dictionary<MailInfoType, string> dicMsg)
        {
            // ע��ÿ����֤ʹ���� infoBuilder ��Ҫ���� infoBuilder ��
            StringBuilder infoBuilder = new StringBuilder(128);

            this.InnerCheckAddress(infoBuilder, dicMsg, EmailAddrType.CC);
            this.InnerCheckAddress(infoBuilder, dicMsg, EmailAddrType.Bcc);

            // �ʼ�����
            if (Subject.Length == 0)
                dicMsg.Add(MailInfoType.SubjectEmpty, MailInfoHelper.GetMailInfoStr(MailInfoType.SubjectEmpty));

            // �ʼ�����
            if (Body.Length == 0 &&
                (m_Attachments == null || (m_Attachments != null && m_Attachments.Count == 0))
                )
            {
                dicMsg.Add(MailInfoType.BodyEmpty, MailInfoHelper.GetMailInfoStr(MailInfoType.BodyEmpty));
            }
        }

        /// <summary>
        /// �����ʼ�ǰ�����Ҫ���õ���Ϣ�Ƿ��������ռ� ���� ��Ϣ
        /// </summary>
        /// <param name="dicMsg">�������Ϣ�ռ����˼���</param>
        private void InnerCheckSendMail4Error(Dictionary<MailInfoType, string> dicMsg)
        {
            // ע��ÿ����֤ʹ���� infoBuilder ��Ҫ���� infoBuilder ��
            StringBuilder infoBuilder = new StringBuilder(128);

            this.InnerCheckAddress(infoBuilder, dicMsg, EmailAddrType.From);
            this.InnerCheckAddress(infoBuilder, dicMsg, EmailAddrType.To);

            // SmtpClient ʵ��δ����
            if (m_SmtpClient == null)
                dicMsg.Add(MailInfoType.SmtpClientEmpty, MailInfoHelper.GetMailInfoStr(MailInfoType.SmtpClientEmpty));
            else
            {
                // SMTP ������������  ��Ĭ�϶˿�Ϊ25��
                if (m_SmtpClient.Host.Length == 0)
                    dicMsg.Add(MailInfoType.HostEmpty, MailInfoHelper.GetMailInfoStr(MailInfoType.HostEmpty));
                // SMPT ƾ֤
                if (m_SmtpClient.EnableSsl && m_SmtpClient.ClientCertificates.Count == 0)
                    dicMsg.Add(MailInfoType.CertificateEmpty, MailInfoHelper.GetMailInfoStr(MailInfoType.CertificateEmpty));
            }
        }

        /// <summary>
        /// ��� �����ˡ��ռ��ˡ������ˡ������� �����ַ
        /// </summary>
        /// <param name="infoBuilder">StringBuilderʵ��</param>
        /// <param name="dicMsg">�������Ϣ�ռ����˼���</param>
        /// <param name="type">�����ʼ���ַ����</param>
        private void InnerCheckAddress(StringBuilder infoBuilder, Dictionary<MailInfoType, string> dicMsg, EmailAddrType type)
        {
            Dictionary<string, string> dic = null;
            MailInfoType addressFormat = MailInfoType.None;
            MailInfoType addressEmpty = MailInfoType.None;
            bool allowEmpty = true;
            // ֻ�� ������ �ǵ�����ַ���ر���д���
            bool hasHandle = false;
            switch (type)
            {
                case EmailAddrType.From:
                    {
                        // ��ʶΪ�Ѵ���
                        hasHandle = true;

                        allowEmpty = false;
                        if (From.Length == 0)
                        {
                            dicMsg.Add(MailInfoType.FromEmpty, MailInfoHelper.GetMailInfoStr(MailInfoType.FromEmpty));
                        }
                        else if (!MailValidatorHelper.IsEmail(From))
                        {
                            string strTemp = infoBuilder.AppendFormat(MailInfoHelper.GetMailInfoStr(MailInfoType.FromFormat), FromDisplayName, From).ToString();
                            dicMsg.Add(MailInfoType.FromFormat, strTemp);
                            infoBuilder.Length = 0;
                        }
                    }
                    break;
                case EmailAddrType.To:
                    {
                        dic = m_DicTo;
                        addressEmpty = MailInfoType.ToEmpty;

                        allowEmpty = false;
                        addressFormat = MailInfoType.ToFormat;
                    }
                    break;
                case EmailAddrType.CC:
                    {
                        dic = m_DicCC;
                        addressFormat = MailInfoType.CCFormat;

                        allowEmpty = true;
                        addressEmpty = MailInfoType.None;
                    }
                    break;
                case EmailAddrType.Bcc:
                    {
                        dic = m_DicBcc;
                        addressFormat = MailInfoType.BccFormat;

                        allowEmpty = true;
                        addressEmpty = MailInfoType.None;
                    }
                    break;
            }


            #region ���� �ռ��ˡ������ˡ�������

            if (!hasHandle)
            {
                if (dic == null)
                {
                    if (!allowEmpty)
                    {
                        // ��ַΪ��
                        dicMsg.Add(addressEmpty, MailInfoHelper.GetMailInfoStr(addressEmpty));
                    }
                }
                else
                {
                    if (dic.Count > 0)
                    {
                        string strTemp = String.Empty;
                        // �ʼ���ַ��ʽ
                        foreach (KeyValuePair<string, string> keyValue in dic)
                        {
                            if (keyValue.Key.Length == 0)
                            {
                                if (!allowEmpty)
                                {
                                    // ��ַΪ��
                                    dicMsg.Add(addressEmpty, MailInfoHelper.GetMailInfoStr(addressEmpty));
                                }
                            }
                            else if (!MailValidatorHelper.IsEmail(keyValue.Key))
                            {
                                if (strTemp.Length == 0)
                                    strTemp = MailInfoHelper.GetMailInfoStr(addressFormat);
                                if (infoBuilder.Length > 0)
                                    infoBuilder.AppendLine();
                                infoBuilder.AppendFormat(strTemp, keyValue.Value, keyValue.Key);
                            }
                        }
                        if (infoBuilder.Length > 0)
                        {
                            dicMsg.Add(addressFormat, infoBuilder.ToString());
                            infoBuilder.Length = 0;
                        }
                    }
                    else if (!allowEmpty)
                    {
                        // ��ַΪ��
                        dicMsg.Add(addressEmpty, MailInfoHelper.GetMailInfoStr(addressEmpty));
                    }
                }
            }

            #endregion
        }

        #endregion

    }

    /// <summary>
    /// �첽�����ʼ�ʱ�������Ϣ�������ͷźʹ�������
    /// </summary>
    public class MailUserState
    {
        #region ��MailHelper�ڲ���SendCompletedע����¼�ʹ��
        // �����ͷ� MailMessage �� SmtpClient
        public MailMessage CurMailMessage { get; set; }
        public bool AutoReleaseSmtp { get; set; }
        public SmtpClient CurSmtpClient { get; set; }
        // ֻ���͵����ʼ���ʱ��ʹ�ô˽����ж��ͷ�  
        public bool IsSmpleMail { get; set; }
        #endregion

        /// <summary>
        /// �û����ݵ�״̬����
        /// </summary>
        public object UserState { get; set; }

        /// <summary>
        /// ���첽���ͱ���ʱ��ͨ���˱�ʶ�Ƿ��Ѿ�������쳣
        /// </summary>
        public bool IsErrorHandle { get; set; }
    }
}