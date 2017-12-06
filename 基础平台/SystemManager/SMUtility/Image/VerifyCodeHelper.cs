using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI;
namespace SMSUtility
{
    /// <summary>
    /// ��֤����
    /// </summary>
    public class VerifyCodeHelper : Page
    {
        private bool _chaos = true;

        #region ��֤�볤��(Ĭ��6����֤��ĳ���)

        /// <summary>
        /// ��֤�볤��(Ĭ��6����֤��ĳ���) 
        /// </summary>
        public int Length { get; set; }

        #endregion

        #region ��֤�������С(Ϊ����ʾŤ��Ч����Ĭ��40���أ����������޸�)

        /// <summary>
        /// ��֤�������С(Ϊ����ʾŤ��Ч����Ĭ��40���أ����������޸�)
        /// </summary>
        public int FontSize { get; set; }

        #endregion

        #region �߿�(Ĭ��1����)

        /// <summary>
        /// �߿�(Ĭ��1����)
        /// </summary>
        public int Padding { get; set; }

        #endregion

        #region �Ƿ�������(Ĭ�ϲ����)

        /// <summary>
        /// �Ƿ�������(Ĭ�ϲ����)
        /// </summary>
        public bool Chaos
        {
            get { return _chaos; }
            set { _chaos = value; }
        }

        #endregion

        #region ���������ɫ(Ĭ�ϻ�ɫ)

        /// <summary>
        /// ���������ɫ(Ĭ�ϻ�ɫ)
        /// </summary>
        private Color _chaoscolor = Color.LightGray;

        public Color ChaosColor
        {
            get { return _chaoscolor; }
            set { _chaoscolor = value; }
        }

        #endregion

        #region �Զ��屳��ɫ(Ĭ�ϰ�ɫ)

        /// <summary>
        /// �Զ��屳��ɫ(Ĭ�ϰ�ɫ)
        /// </summary>
        private Color _backgroundcolor = Color.White;

        public Color BackgroundColor
        {
            get { return _backgroundcolor; }
            set { _backgroundcolor = value; }
        }

        #endregion

        #region �Զ��������ɫ����

        /// <summary>
        /// �Զ��������ɫ����
        /// </summary>
        private Color[] _colors = {
                                      Color.Black, Color.Red, Color.DarkBlue, Color.Green, Color.Orange, Color.Brown,
                                      Color.DarkCyan, Color.Purple
                                  };

        public Color[] Colors
        {
            get { return _colors; }
            set { _colors = value; }
        }

        #endregion

        #region �Զ�����������

        /// <summary>
        /// �Զ�����������
        /// </summary>
        private string[] _fonts = {"Arial", "Georgia"};

        public string[] Fonts
        {
            get { return _fonts; }
            set { _fonts = value; }
        }

        #endregion

        #region �Զ���������ַ�������(ʹ�ö��ŷָ�)

        /// <summary>
        /// �Զ���������ַ�������(ʹ�ö��ŷָ�)
        /// </summary>
        private string _codeserial = "0,1,2,3,4,5,6,7,8,9";

        //,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z";

        public string CodeSerial
        {
            get { return _codeserial; }
            set { _codeserial = value; }
        }

        #endregion

        #region ���������˾�Ч��

        private const double Pi2 = 6.283185307179586476925286766559;

        /// <summary>
        /// ��������WaveŤ��ͼƬ
        /// </summary>
        /// <param name="srcBmp">ͼƬ·��</param>
        /// <param name="bXDir">���Ť����ѡ��ΪTrue</param>
        /// <param name="dMultValue">���εķ��ȱ�����Խ��Ť���ĳ̶�Խ�ߣ�һ��Ϊ3</param>
        /// <param name="dPhase">���ε���ʼ��λ��ȡֵ����[0-2*PI)</param>
        /// <returns></returns>
        public Bitmap TwistImage(Bitmap srcBmp, bool bXDir, double dMultValue, double dPhase)
        {
            var destBmp = new Bitmap(srcBmp.Width, srcBmp.Height);
            // ��λͼ�������Ϊ��ɫ
            Graphics graph = Graphics.FromImage(destBmp);
            graph.FillRectangle(new SolidBrush(Color.White), 0, 0, destBmp.Width, destBmp.Height);
            graph.Dispose();
            double dBaseAxisLen = bXDir ? destBmp.Height : destBmp.Width;
            for (int i = 0; i < destBmp.Width; i++)
            {
                for (int j = 0; j < destBmp.Height; j++)
                {
                    double dx = bXDir ? (Pi2*j)/dBaseAxisLen : (Pi2*i)/dBaseAxisLen;
                    dx += dPhase;
                    double dy = Math.Sin(dx);
                    // ȡ�õ�ǰ�����ɫ
                    int nOldX = bXDir ? i + (int) (dy*dMultValue) : i;
                    int nOldY = bXDir ? j : j + (int) (dy*dMultValue);
                    Color color = srcBmp.GetPixel(i, j);
                    if (nOldX >= 0 && nOldX < destBmp.Width
                        && nOldY >= 0 && nOldY < destBmp.Height)
                    {
                        destBmp.SetPixel(nOldX, nOldY, color);
                    }
                }
            }
            return destBmp;
        }

        #endregion

        #region ����У����ͼƬ

        /// <summary>
        /// ����У����ͼƬ
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public Bitmap CreateImageCode(string code)
        {
            int fSize = FontSize;
            int fWidth = fSize + Padding;
            int imageWidth = (code.Length*fWidth) + 4 + Padding*2;
            int imageHeight = fSize*2 + Padding;
            var image = new Bitmap(imageWidth, imageHeight);
            Graphics g = Graphics.FromImage(image);
            g.Clear(BackgroundColor);
            var rand = new Random();
            //���������������ɵ����
            if (Chaos)
            {
                var pen = new Pen(ChaosColor, 0);
                int c = Length*10;
                for (int i = 0; i < c; i++)
                {
                    int x = rand.Next(image.Width);
                    int y = rand.Next(image.Height);
                    g.DrawRectangle(pen, x, y, 1, 1);
                }
            }
            int n1 = (imageHeight - FontSize - Padding*2);
            int n2 = n1/4;
            int top1 = n2;
            int top2 = n2*2;
            //����������ɫ����֤���ַ�
            for (int i = 0; i < code.Length; i++)
            {
                int cindex = rand.Next(Colors.Length - 1);
                int findex = rand.Next(Fonts.Length - 1);
                var f = new Font(Fonts[findex], fSize, FontStyle.Bold);
                Brush b = new SolidBrush(Colors[cindex]);
                int top = i%2 == 1 ? top2 : top1;
                int left = i*fWidth;
                g.DrawString(code.Substring(i, 1), f, b, left, top);
            }
            //��һ���߿� �߿���ɫΪColor.Black
            // g.DrawRectangle(new Pen(Color.Black, 0), 0, 0, image.Width - 1, image.Height - 1);
            g.Dispose();
            //��������
            image = TwistImage(image, true, 3, 0);
            return image;
        }

        #endregion

        #region �������õ�ͼƬ�����ҳ��

        /// <summary>
        /// �������õ�ͼƬ�����ҳ��
        /// </summary>
        /// <param name="code"></param>
        /// <param name="context"></param>
        public void CreateImageOnPage(string code, HttpContext context)
        {
            var ms = new MemoryStream();
            Bitmap image = CreateImageCode(code);
            image.Save(ms, ImageFormat.Jpeg);
            context.Response.ClearContent();
            context.Response.ContentType = "image/Jpeg";
            context.Response.BinaryWrite(ms.GetBuffer());
            ms.Close();
            image.Dispose();
        }

        #endregion

        #region ��������ַ���

        /// <summary>
        /// ��������ַ���
        /// </summary>
        /// <param name="codeLen"></param>
        /// <returns></returns>
        public string CreateVerifyCode(int codeLen)
        {
            if (codeLen == 0)
            {
                codeLen = Length;
            }

            string[] arr = CodeSerial.Split(',');

            string code = "";

            var rand = new Random(unchecked((int) DateTime.Now.Ticks));

            for (int i = 0; i < codeLen; i++)
            {
                int randValue = rand.Next(0, arr.Length - 1);

                code += arr[randValue];
            }

            return code;
        }

        public string CreateVerifyCode()
        {
            return CreateVerifyCode(0);
        }

        #endregion

        #region ���ɺ����ַ�

        /// <summary>
        /// ���ɺ����ַ�
        /// </summary>
        /// <returns></returns>
        public char CreateZhChar()
        {
            //���ṩ�˺��ּ�����ѯ���ּ�ѡȡ����
            //if (ChineseChars.Length > 0)
            //{
            //    return ChineseChars[rnd.Next(0, ChineseChars.Length)];
            //}
            //��û���ṩ���ּ�������ݡ�GB2312�������ı������������캺��
            //else
            //{
            var rnd = new Random();
            var bytes = new byte[2];

            //��һ���ֽ�ֵ��0xb0, 0xf7֮��
            bytes[0] = (byte) rnd.Next(0xb0, 0xf8);
            //�ڶ����ֽ�ֵ��0xa1, 0xfe֮��
            bytes[1] = (byte) rnd.Next(0xa1, 0xff);

            //���ݺ��ֱ�����ֽ������������ĺ���
            string str1 = Encoding.GetEncoding("gb2312").GetString(bytes);

            return str1[0];
            //}
        }

        #endregion
    }
}