using System;
using System.Collections;
using System.IO;
using System.Net.Sockets;
using System.Text;

namespace SMSUtility
{
    /// <summary>
    /// E-maile������
    /// </summary>
    public class MailHelper
    {
        /// <summary> 
        /// �ʼ������б� 
        /// </summary> 
        private readonly ArrayList Attachments;

        /// <summary> 
        /// SMTP��������ϣ�� 
        /// </summary> 
        private readonly Hashtable ErrCodeHT = new Hashtable();

        /// <summary> 
        /// �ռ����б� 
        /// </summary> 
        private readonly Hashtable Recipient = new Hashtable();

        /// <summary> 
        /// SMTP��ȷ�����ϣ�� 
        /// </summary> 
        private readonly Hashtable RightCodeHT = new Hashtable();

        /// <summary> 
        /// �ʼ����� 
        /// </summary> 
        public string Body = "";

        /// <summary> 
        /// �趨���Դ��룬Ĭ���趨ΪGB2312���粻��Ҫ������Ϊ"" 
        /// </summary> 
        public string Charset = "GB2312";

        /// <summary> 
        /// �Ƿ���ҪSMTP��֤ 
        /// </summary> 
        private bool ESmtp;

        /// <summary> 
        /// �����˵�ַ 
        /// </summary> 
        public string From = "";

        /// <summary> 
        /// ���������� 
        /// </summary> 
        public string FromName = "";

        /// <summary> 
        /// �Ƿ�Html�ʼ� 
        /// </summary> 
        public bool Html;

        /// <summary> 
        /// �ظ��ʼ���ַ 
        /// </summary> 
        //public string ReplyTo=""; 
        /// <summary> 
        /// �ռ������� 
        /// </summary> 
        public string RecipientName = "";

        /// <summary> 
        /// �ռ������� 
        /// </summary> 
        private int RecipientNum;

        /// <summary> 
        /// �ʼ����� 
        /// </summary> 
        public string Subject = "";

        private string enter = "\r\n";

        /// <summary> 
        /// �ܼ��ռ������� 
        /// </summary> 
        //private int RecipientBCCNum=0; 
        /// <summary> 
        /// ������Ϣ���� 
        /// </summary> 
        private string errmsg;

        /// <summary> 
        /// ������������¼ 
        /// </summary> 
        private string logs = "";

        /// <summary> 
        /// �ʼ����������� 
        /// </summary> 
        private string mailserver = "";

        /// <summary> 
        /// �ʼ��������˿ں� 
        /// </summary> 
        private int mailserverport = 25;

        /// <summary> 
        /// NetworkStream���� 
        /// </summary> 
        private NetworkStream ns;

        /// <summary> 
        /// SMTP��֤ʱʹ�õ����� 
        /// </summary> 
        private string password = "";

        /// <summary> 
        /// �ʼ��������ȼ���������Ϊ"High","Normal","Low"��"1","3","5" 
        /// </summary> 
        private string priority = "Normal";

        /// <summary> 
        /// ����ռ������� 
        /// </summary> 
        private int recipientmaxnum = 1;

        /// <summary> 
        /// TcpClient�����������ӷ����� 
        /// </summary> 
        private TcpClient tc;

        /// <summary> 
        /// SMTP��֤ʱʹ�õ��û��� 
        /// </summary> 
        private string username = "";
        /// <summary>
        /// ���캯��
        /// </summary>
        public MailHelper()
        {
            Attachments = new ArrayList();
        }

        /// <summary> 
        /// �ʼ���������������֤��Ϣ 
        /// ���磺"user:pass@www.server.com:25"��Ҳ��ʡ�Դ�Ҫ��Ϣ����"user:pass@www.server.com"��"www.server.com" 
        /// </summary> 
        public string MailDomain
        {
            set
            {
                string maidomain = value.Trim();
                int tempint;

                if (maidomain != "")
                {
                    tempint = maidomain.IndexOf("@");
                    if (tempint != -1)
                    {
                        string str = maidomain.Substring(0, tempint);
                        MailServerUserName = str.Substring(0, str.IndexOf(":"));
                        MailServerPassWord = str.Substring(str.IndexOf(":") + 1, str.Length - str.IndexOf(":") - 1);
                        maidomain = maidomain.Substring(tempint + 1, maidomain.Length - tempint - 1);
                    }

                    tempint = maidomain.IndexOf(":");
                    if (tempint != -1)
                    {
                        mailserver = maidomain.Substring(0, tempint);
                        mailserverport =
                            Convert.ToInt32(maidomain.Substring(tempint + 1, maidomain.Length - tempint - 1));
                    }
                    else
                    {
                        mailserver = maidomain;
                    }
                }
            }
        }


        /// <summary> 
        /// �ʼ��������˿ں� 
        /// </summary> 
        public int MailDomainPort
        {
            set { mailserverport = value; }
        }


        /// <summary> 
        /// SMTP��֤ʱʹ�õ��û��� 
        /// </summary> 
        public string MailServerUserName
        {
            set
            {
                if (value.Trim() != "")
                {
                    username = value.Trim();
                    ESmtp = true;
                }
                else
                {
                    username = "";
                    ESmtp = false;
                }
            }
        }

        /// <summary> 
        /// SMTP��֤ʱʹ�õ����� 
        /// </summary> 
        public string MailServerPassWord
        {
            set { password = value; }
        }

        /// <summary> 
        /// �ʼ��������ȼ���������Ϊ"High","Normal","Low"��"1","3","5" 
        /// </summary> 
        public string Priority
        {
            set
            {
                switch (value.ToLower())
                {
                    case "high":
                        priority = "High";
                        break;

                    case "1":
                        priority = "High";
                        break;

                    case "normal":
                        priority = "Normal";
                        break;

                    case "3":
                        priority = "Normal";
                        break;

                    case "low":
                        priority = "Low";
                        break;

                    case "5":
                        priority = "Low";
                        break;

                    default:
                        priority = "Normal";
                        break;
                }
            }
        }


        /// <summary> 
        /// ������Ϣ���� 
        /// </summary> 
        public string ErrorMessage
        {
            get { return errmsg; }
        }


        /// <summary> 
        /// ������������¼���緢�ֱ��������ʹ�õ�SMTP���������뽫����ʱ��Logs�����ң�lion-a@sohu.com�����ҽ��������ԭ�� 
        /// </summary> 
        public string Logs
        {
            get { return logs; }
        }

        /// <summary> 
        /// ����ռ������� 
        /// </summary> 
        public int RecipientMaxNum
        {
            set { recipientmaxnum = value; }
        }


        /// <summary> 
        /// SMTP��Ӧ�����ϣ�� 
        /// </summary> 
        private void SMTPCodeAdd()
        {
            ErrCodeHT.Add("500", "�����ַ����");
            ErrCodeHT.Add("501", "������ʽ����");
            ErrCodeHT.Add("502", "�����ʵ��");
            ErrCodeHT.Add("503", "��������ҪSMTP��֤");
            ErrCodeHT.Add("504", "�����������ʵ��");
            ErrCodeHT.Add("421", "����δ�������رմ����ŵ�");
            ErrCodeHT.Add("450", "Ҫ����ʼ�����δ��ɣ����䲻���ã����磬����æ��");
            ErrCodeHT.Add("550", "Ҫ����ʼ�����δ��ɣ����䲻���ã����磬����δ�ҵ����򲻿ɷ��ʣ�");
            ErrCodeHT.Add("451", "����Ҫ��Ĳ�������������г���");
            ErrCodeHT.Add("551", "�û��Ǳ��أ��볢��<forward-path>");
            ErrCodeHT.Add("452", "ϵͳ�洢���㣬Ҫ��Ĳ���δִ��");
            ErrCodeHT.Add("552", "�����Ĵ洢���䣬Ҫ��Ĳ���δִ��");
            ErrCodeHT.Add("553", "�����������ã�Ҫ��Ĳ���δִ�У����������ʽ����");
            ErrCodeHT.Add("432", "��Ҫһ������ת��");
            ErrCodeHT.Add("534", "��֤���ƹ��ڼ�");
            ErrCodeHT.Add("538", "��ǰ�������֤������Ҫ����");
            ErrCodeHT.Add("454", "��ʱ��֤ʧ��");
            ErrCodeHT.Add("530", "��Ҫ��֤");

            RightCodeHT.Add("220", "�������");
            RightCodeHT.Add("250", "Ҫ����ʼ��������");
            RightCodeHT.Add("251", "�û��Ǳ��أ���ת����<forward-path>");
            RightCodeHT.Add("354", "��ʼ�ʼ����룬��<enter>.<enter>����");
            RightCodeHT.Add("221", "����رմ����ŵ�");
            RightCodeHT.Add("334", "��������Ӧ��֤Base64�ַ���");
            RightCodeHT.Add("235", "��֤�ɹ�");
        }


        /// <summary> 
        /// ���ַ�������ΪBase64�ַ��� 
        /// </summary> 
        /// <param name="estr">Ҫ������ַ���</param> 
        private string Base64Encode(string str)
        {
            byte[] barray;
            barray = Encoding.Default.GetBytes(str);
            return Convert.ToBase64String(barray);
        }


        /// <summary> 
        /// ��Base64�ַ�������Ϊ��ͨ�ַ��� 
        /// </summary> 
        /// <param name="dstr">Ҫ������ַ���</param> 
        private string Base64Decode(string str)
        {
            byte[] barray;
            barray = Convert.FromBase64String(str);
            return Encoding.Default.GetString(barray);
        }


        /// <summary> 
        /// �õ��ϴ��������ļ��� 
        /// </summary> 
        /// <param name="FilePath">�����ľ���·��</param> 
        private string GetStream(string FilePath)
        {
            //�����ļ������� 
            var FileStr = new FileStream(FilePath, FileMode.Open);
            var by = new byte[Convert.ToInt32(FileStr.Length)];
            FileStr.Read(by, 0, by.Length);
            FileStr.Close();
            return (Convert.ToBase64String(by));
        }


        /// <summary> 
        /// ����ʼ����� 
        /// </summary> 
        /// <param name="path">��������·��</param> 
        public void AddAttachment(string path)
        {
            Attachments.Add(path);
        }


        /// <summary> 
        /// ���һ���ռ��� 
        /// </summary> 
        /// <param name="str">�ռ��˵�ַ</param> 
        public bool AddRecipient(string str)
        {
            str = str.Trim();
            if (str == null || str == "" || str.IndexOf("@") == -1)
                return true;
            if (RecipientNum < recipientmaxnum)
            {
                Recipient.Add(RecipientNum, str);
                RecipientNum++;
                return true;
            }
            else
            {
                errmsg += "�ռ��˹���";
                return false;
            }
        }


        /// <summary> 
        /// ���һ���ռ��ˣ�������recipientmaxnum����������Ϊ�ַ������� 
        /// </summary> 
        /// <param name="str">�������ռ��˵�ַ���ַ������飨������recipientmaxnum����</param> 
        public bool AddRecipient(string[] str)
        {
            for (int i = 0; i < str.Length; i++)
            {
                if (!AddRecipient(str[i]))
                {
                    return false;
                }
            }
            return true;
        }

        /// <summary> 
        /// ����SMTP���� 
        /// </summary> 
        private bool SendCommand(string str)
        {
            byte[] WriteBuffer;
            if (str == null || str.Trim() == "")
            {
                return true;
            }
            logs += str;
            WriteBuffer = Encoding.Default.GetBytes(str);
            try
            {
                ns.Write(WriteBuffer, 0, WriteBuffer.Length);
            }
            catch
            {
                errmsg = "�������Ӵ���";
                return false;
            }
            return true;
        }

        /// <summary> 
        /// ����SMTP��������Ӧ 
        /// </summary> 
        private string RecvResponse()
        {
            int StreamSize;
            string ReturnValue = "";
            var ReadBuffer = new byte[1024];
            try
            {
                StreamSize = ns.Read(ReadBuffer, 0, ReadBuffer.Length);
            }
            catch
            {
                errmsg = "�������Ӵ���";
                return "false";
            }

            if (StreamSize == 0)
            {
                return ReturnValue;
            }
            else
            {
                ReturnValue = Encoding.Default.GetString(ReadBuffer).Substring(0, StreamSize);
                logs += ReturnValue;
                return ReturnValue;
            }
        }


        /// <summary> 
        /// �����������������һ��������ջ�Ӧ�� 
        /// </summary> 
        /// <param name="Command">һ��Ҫ���͵�����</param> 
        /// <param name="errstr">�������Ҫ��������Ϣ</param> 
        private bool Dialog(string str, string errstr)
        {
            if (str == null || str.Trim() == "")
            {
                return true;
            }
            if (SendCommand(str))
            {
                string RR = RecvResponse();
                if (RR == "false")
                {
                    return false;
                }
                string RRCode = RR.Substring(0, 3);
                if (RightCodeHT[RRCode] != null)
                {
                    return true;
                }
                else
                {
                    if (ErrCodeHT[RRCode] != null)
                    {
                        errmsg += (RRCode + ErrCodeHT[RRCode]);
                        errmsg += enter;
                    }
                    else
                    {
                        errmsg += RR;
                    }
                    errmsg += errstr;
                    return false;
                }
            }
            else
            {
                return false;
            }
        }


        /// <summary> 
        /// �����������������һ��������ջ�Ӧ�� 
        /// </summary> 
        private bool Dialog(string[] str, string errstr)
        {
            for (int i = 0; i < str.Length; i++)
            {
                if (!Dialog(str[i], ""))
                {
                    errmsg += enter;
                    errmsg += errstr;
                    return false;
                }
            }

            return true;
        }

        /// <summary>
        /// ����email
        /// </summary>
        /// <returns></returns>
        private bool SendEmail()
        {
            //�������� 
            try
            {
                tc = new TcpClient(mailserver, mailserverport);
            }
            catch (Exception e)
            {
                errmsg = e.ToString();
                return false;
            }

            ns = tc.GetStream();
            SMTPCodeAdd();

            //��֤���������Ƿ���ȷ 
            if (RightCodeHT[RecvResponse().Substring(0, 3)] == null)
            {
                errmsg = "��������ʧ��";
                return false;
            }


            string[] SendBuffer;
            string SendBufferstr;

            //����SMTP��֤ 
            if (ESmtp)
            {
                SendBuffer = new string[4];
                SendBuffer[0] = "EHLO " + mailserver + enter;
                SendBuffer[1] = "AUTH LOGIN" + enter;
                SendBuffer[2] = Base64Encode(username) + enter;
                SendBuffer[3] = Base64Encode(password) + enter;
                if (!Dialog(SendBuffer, "SMTP��������֤ʧ�ܣ���˶��û��������롣"))
                    return false;
            }
            else
            {
                SendBufferstr = "HELO " + mailserver + enter;
                if (!Dialog(SendBufferstr, ""))
                    return false;
            }

            // 
            SendBufferstr = "MAIL FROM:<" + From + ">" + enter;
            if (!Dialog(SendBufferstr, "�����˵�ַ���󣬻���Ϊ��"))
                return false;

            // 
            SendBuffer = new string[recipientmaxnum];
            for (int i = 0; i < Recipient.Count; i++)
            {
                SendBuffer[i] = "RCPT TO:<" + Recipient[i] + ">" + enter;
            }
            if (!Dialog(SendBuffer, "�ռ��˵�ַ����"))
                return false;

            SendBufferstr = "DATA" + enter;
            if (!Dialog(SendBufferstr, ""))
                return false;

            SendBufferstr = "From:" + FromName + "<" + From + ">" + enter;

            SendBufferstr += "To:=?" + Charset.ToUpper() + "?B?" + Base64Encode(RecipientName) + "?=" + "<" +
                             Recipient[0] + ">" + enter;
            SendBufferstr += "CC:";
            for (int i = 0; i < Recipient.Count; i++)
            {
                SendBufferstr += Recipient[i] + "<" + Recipient[i] + ">,";
            }
            SendBufferstr += enter;


            if (Charset == "")
            {
                SendBufferstr += "Subject:" + Subject + enter;
            }
            else
            {
                SendBufferstr += "Subject:" + "=?" + Charset.ToUpper() + "?B?" + Base64Encode(Subject) + "?=" + enter;
            }

            SendBufferstr += "X-Priority:" + priority + enter;
            SendBufferstr += "X-MSMail-Priority:" + priority + enter;
            SendBufferstr += "Importance:" + priority + enter;
            SendBufferstr += "X-Mailer: Huolx.Pubclass" + enter;
            SendBufferstr += "MIME-Version: 1.0" + enter;

            SendBufferstr += "Content-Type: multipart/mixed;" + enter; //���ݸ�ʽ�ͷָ��� 
            SendBufferstr += " boundary=\"----=_NextPart_000_00D6_01C29593.AAB31770\"" + enter;
            SendBufferstr += "------=_NextPart_000_00D6_01C29593.AAB31770" + enter;

            if (Html)
            {
                SendBufferstr += "Content-Type: text/html;" + enter;
            }
            else
            {
                SendBufferstr += "Content-Type: text/plain;" + enter;
            }

            if (Charset == "")
            {
                SendBufferstr += " charset=\"iso-8859-1\"" + enter;
            }
            else
            {
                SendBufferstr += " charset=\"" + Charset.ToLower() + "\"" + enter;
            }
            //SendBufferstr += "Content-Transfer-Encoding: base64"+enter; 

            SendBufferstr += "Content-Transfer-Encoding: base64" + enter + enter;

            SendBufferstr += Base64Encode(Body) + enter;
            if (Attachments.Count != 0)
            {
                foreach (string filepath in Attachments)
                {
                    SendBufferstr += "------=_NextPart_000_00D6_01C29593.AAB31770" + enter;
                    SendBufferstr += "Content-Type: application/octet-stream" + enter;
                    SendBufferstr += " name=\"=?" + Charset.ToUpper() + "?B?" +
                                     Base64Encode(filepath.Substring(filepath.LastIndexOf("\\") + 1)) + "?=\"" + enter;
                    SendBufferstr += "Content-Transfer-Encoding: base64" + enter;
                    SendBufferstr += "Content-Disposition: attachment;" + enter;
                    SendBufferstr += " filename=\"=?" + Charset.ToUpper() + "?B?" +
                                     Base64Encode(filepath.Substring(filepath.LastIndexOf("\\") + 1)) + "?=\"" + enter +
                                     enter;
                    SendBufferstr += GetStream(filepath) + enter + enter;
                }
            }
            SendBufferstr += "------=_NextPart_000_00D6_01C29593.AAB31770--" + enter + enter;


            SendBufferstr += enter + "." + enter;

            if (!Dialog(SendBufferstr, "�����ż���Ϣ"))
                return false;


            SendBufferstr = "QUIT" + enter;
            if (!Dialog(SendBufferstr, "�Ͽ�����ʱ����"))
                return false;


            ns.Close();
            tc.Close();
            return true;
        }


        /// <summary> 
        /// �����ʼ����������в�����ͨ���������á� 
        /// </summary> 
        public bool Send()
        {
            if (Recipient.Count == 0)
            {
                errmsg = "�ռ����б���Ϊ��";
                return false;
            }

            if (mailserver.Trim() == "")
            {
                errmsg = "����ָ��SMTP������";
                return false;
            }

            return SendEmail();
        }


        /// <summary> 
        /// �����ʼ����� 
        /// </summary> 
        /// <param name="smtpserver">smtp��������Ϣ����"username:password@www.smtpserver.com:25"��Ҳ��ȥ�����ִ�Ҫ��Ϣ����"www.smtpserver.com"</param> 
        public bool Send(string smtpserver)
        {
            MailDomain = smtpserver;
            return Send();
        }


        /// <summary> 
        /// �����ʼ����� 
        /// </summary> 
        /// <param name="smtpserver">smtp��������Ϣ����"username:password@www.smtpserver.com:25"��Ҳ��ȥ�����ִ�Ҫ��Ϣ����"www.smtpserver.com"</param> 
        /// <param name="from">������mail��ַ</param> 
        /// <param name="fromname">����������</param> 
        /// <param name="to">�ռ��˵�ַ</param> 
        /// <param name="toname">�ռ�������</param> 
        /// <param name="html">�Ƿ�HTML�ʼ�</param> 
        /// <param name="subject">�ʼ�����</param> 
        /// <param name="body">�ʼ�����</param> 
        public bool Send(string smtpserver, string from, string fromname, string to, string toname, bool html,
                         string subject, string body)
        {
            MailDomain = smtpserver;
            From = from;
            FromName = fromname;
            AddRecipient(to);
            RecipientName = toname;
            Html = html;
            Subject = subject;
            Body = body;
            return Send();
        }
    }
}