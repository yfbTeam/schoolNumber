using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;

namespace SMSUtility
{
    /// <summary>
    /// ͼƬ�ϴ�������
    /// </summary>
    public class UpImageHelper
    {
        #region ˽�г�Ա
        private static string _allowFormat = ".jpeg|.jpg|.bmp|.gif"; //����ͼƬ��ʽ
        private static int _allowSize = 1; //�����ϴ�ͼƬ��С,Ĭ��Ϊ1MB
        private static string _wordWater = ""; //����ˮӡ
        private static string _picWater = ""; //ͼƬ·��
        private static string _imgwidth = ""; //����ͼƬ��ȼ���
        private static string _imgheight = ""; //����ͼƬ�߶ȼ��� 
        private static bool _limitWidth = true; //�Ƿ����������
        private static int _maxWidth = 600; //�����
        private static bool _cutImage = true; //�Ƿ����ͼƬ

        #endregion

        #region ����

        /// <summary>
        /// ����ͼƬ��ʽ
        /// </summary>
        public static string AllowFormat
        {
            get { return _allowFormat; }
            set { _allowFormat = value; }
        }

        /// <summary>
        /// �����ϴ�ͼƬ��С
        /// </summary>
        public static int AllowSize
        {
            get { return _allowSize; }
            set { _allowSize = value; }
        }

        /// <summary>
        /// ����ˮӡ�ַ�
        /// </summary>
        public static string WordWater
        {
            get { return _wordWater; }
            set { _wordWater = value; }
        }

        /// <summary>
        /// ͼƬˮӡ
        /// </summary>
        public static string PicWater
        {
            get { return _picWater; }
            set { _picWater = value; }
        }

        /// <summary>
        /// ͼƬ���
        /// </summary>
        public static string ImgWidth
        {
            get { return _imgwidth; }
            set { _imgwidth = value; }
        }

        /// <summary>
        /// ͼƬ�߶�
        /// </summary>
        public static string ImgHeight
        {
            get { return _imgheight; }
            set { _imgheight = value; }
        }

        /// <summary>
        /// �Ƿ���������ȣ�Ĭ��Ϊtrue
        /// </summary>
        public static bool LimitWidth
        {
            get { return _limitWidth; }
            set { _limitWidth = value; }
        }

        /// <summary>
        /// ����ȳߴ磬Ĭ��Ϊ600
        /// </summary>
        public static int MaxWidth
        {
            get { return _maxWidth; }
            set { _maxWidth = value; }
        }

        /// <summary>
        /// �Ƿ����ͼƬ��Ĭ��true
        /// </summary>
        public static bool CutImage
        {
            get { return _cutImage; }
            set { _cutImage = value; }
        }

        /// <summary>
        /// ����ͼƬ��С��ȣ�0��ʾ������
        /// </summary>
        public static int MinWidth { get; set; }

        #endregion

        #region ö��
        /// <summary>
        /// ����ģʽ
        /// </summary>
        public enum CutMode
        {
            /// <summary>
            /// ���ݸ߿����
            /// </summary>
            CutWh = 1,
            /// <summary>
            /// ���ݿ����
            /// </summary>
            CutW = 2,
            /// <summary>
            /// ���ݸ߼���
            /// </summary>
            CutH = 3,
            /// <summary>
            /// ���Ų�����
            /// </summary>
            CutNo = 4
        }

        #endregion

        #region ����

        /// <summary>
        /// ͨ��ͼƬ�ϴ���
        /// </summary>
        /// <param name="postedFile">HttpPostedFile�ؼ�</param>
        /// <param name="savePath">����·����sys.config����·����</param>
        /// <param name="oImgWidth">ͼƬ���</param>
        /// <param name="oImgHeight">ͼƬ�߶�</param>
        /// <param name="cMode">��������</param>
        /// <param name="fileName"></param>
        /// <returns>��0-ϵͳ���ô���,1-�ϴ�ͼƬ�ɹ���2-��ʽ����3-�����ļ��ϴ���С��</returns>
        public static int FileSaveAs(HttpPostedFile postedFile, string savePath, int oImgWidth, int oImgHeight,
                                     CutMode cMode, ref string fileName)
        {
            try
            {
                //��ȡ�ϴ��ļ�����չ�� 
                string sEx = Path.GetExtension(postedFile.FileName);
                if (!CheckValidExt(AllowFormat, sEx))
                    return 2; //��ʽ����  

                //��ȡ�ϴ��ļ��Ĵ�С
                int postFileSize = postedFile.ContentLength/1024;

                if (postFileSize > AllowSize)
                    return 3; //�����ļ��ϴ���С 

                if (!Directory.Exists(savePath))
                {
                    Directory.CreateDirectory(savePath);
                }
                //����������
                string newfileName = DateTime.Now.Year + DateTime.Now.Month.ToString() + DateTime.Now.Day +
                                     DateTime.Now.Hour + DateTime.Now.Minute + DateTime.Now.Second +
                                     DateTime.Now.Millisecond.ToString("000");
                string fName = "s" + newfileName + sEx;
                string fullPath = Path.Combine(savePath, fName);
                postedFile.SaveAs(fullPath);

                //����������
                string sNewfileName = DateTime.Now.Year + DateTime.Now.Month.ToString() + DateTime.Now.Day +
                                      DateTime.Now.Hour + DateTime.Now.Minute + DateTime.Now.Second +
                                      DateTime.Now.Millisecond.ToString("000");
                string sFName = sNewfileName + sEx;
                fileName = sFName;
                string sFullPath = Path.Combine(savePath, sFName);
                CreateSmallPhoto(fullPath, oImgWidth, oImgHeight, sFullPath, PicWater, WordWater, cMode);
                if (File.Exists(fullPath))
                {
                    File.Delete(fullPath);
                }
                //ѹ��
                if (postFileSize > 100)
                {
                    CompressPhoto(sFullPath, 100);
                }
                return 1;
            }
            catch
            {
                return -1;
            }
        }

        /// <summary>
        /// ͨ��ͼƬ�ϴ���
        /// </summary>
        /// <param name="postedFile">HttpPostedFile�ؼ�</param>
        /// <param name="savePath">����·����sys.config����·����</param>
        /// <param name="finame">�����ļ���</param>
        /// <param name="fisize">�����ļ���С</param>
        /// <returns>��-1,�ϴ�ʧ�ܣ�0-ϵͳ���ô���,1-�ϴ�ͼƬ�ɹ���2-��ʽ����3-�����ļ��ϴ���С,4-δ�ϴ��ļ���</returns>
        public static int FileSaveAs(HttpPostedFile postedFile, string savePath, ref string finame, ref int fisize)
        {
            try
            {
                if (string.IsNullOrEmpty(postedFile.FileName))
                    return 4;

                var rd = new Random();
                int rdInt = rd.Next(1000, 9999);
                //����������
                string newfileName = DateTime.Now.Year + DateTime.Now.Month.ToString() + DateTime.Now.Day +
                                     DateTime.Now.Hour + DateTime.Now.Minute + DateTime.Now.Second +
                                     DateTime.Now.Millisecond + rdInt;

                //��ȡ�ϴ��ļ�����չ�� 
                string sEx = Path.GetExtension(postedFile.FileName);
                if (!CheckValidExt(AllowFormat, sEx))
                    return 2; //��ʽ����  

                //��ȡ�ϴ��ļ��Ĵ�С
                int postFileSize = postedFile.ContentLength/1024;

                if (postFileSize > AllowSize)
                    return 3; //�����ļ��ϴ���С 


                if (!Directory.Exists(savePath))
                {
                    Directory.CreateDirectory(savePath);
                }


                string fullPath = savePath + newfileName + sEx;

                postedFile.SaveAs(fullPath);


                var bmp = new Bitmap(fullPath);
                int realWidth = bmp.Width;
                int realHeight = bmp.Height;
                bmp.Dispose();

                #region ���ͼƬ�������

                if (MinWidth > 0)
                {
                    if (realWidth < MinWidth)
                    {
                        return -1;
                    }
                }

                #endregion

                #region ���ͼƬ����Ƿ񳬹�600�������Ļ����Զ�ѹ����600

                if (_limitWidth && realWidth > MaxWidth)
                {
                    int mWidth = MaxWidth;
                    int mHeight = mWidth*realHeight/realWidth;

                    string tempFile = savePath + Guid.NewGuid() + sEx;
                    File.Move(fullPath, tempFile);
                    CreateSmallPhoto(tempFile, mWidth, mHeight, fullPath, "", "");
                    File.Delete(tempFile);
                }

                #endregion

                #region ѹ��ͼƬ�洢�ߴ�

                if (sEx != null)
                {
                    if (sEx.ToLower() != ".gif")
                    {
                        CompressPhoto(fullPath, 100);
                    }

                    #endregion

                    finame = newfileName + sEx;
                }
                fisize = postFileSize;

                //��������ͼƬ�߿�
                if (string.IsNullOrEmpty(ImgWidth))
                    return 1;

                string[] oWidthArray = ImgWidth.Split(',');
                string[] oHeightArray = ImgHeight.Split(',');
                if (oWidthArray.Length != oHeightArray.Length)
                    return 0; //ϵͳ���ô���

                for (int i = 0; i < oWidthArray.Length; i++)
                {
                    if (Convert.ToInt32(oWidthArray[i]) <= 0 || Convert.ToInt32(oHeightArray[i]) <= 0)
                        continue;

                    string sImg = savePath + newfileName + "_" + i + sEx;
                    if (CutImage)
                        CreateSmallPhoto(fullPath, Convert.ToInt32(oWidthArray[i]), Convert.ToInt32(oHeightArray[i]),
                                         sImg, "", "");
                    else
                        CreateSmallPhoto(fullPath, Convert.ToInt32(oWidthArray[i]), Convert.ToInt32(oHeightArray[i]),
                                         sImg, "", "", CutMode.CutNo);
                }

                #region ����ͼ���ˮӡ

                if (!string.IsNullOrEmpty(PicWater))
                    AttachPng(PicWater, fullPath);
                else if (!string.IsNullOrEmpty(WordWater))
                    AttachText(WordWater, fullPath);

                #endregion

                return 1;
            }
            catch
            {
                return -1;
            }
        }

        #region ��֤��ʽ

        /// <summary>
        /// ��֤��ʽ
        /// </summary>
        /// <param name="allType">���и�ʽ</param>
        /// <param name="chkType">�����ĸ�ʽ</param>
        /// <returns>bool</returns>
        public static bool CheckValidExt(string allType, string chkType)
        {
            string[] sArray = allType.Split('|');

            return sArray.Any(temp => temp.ToLower() == chkType.ToLower());
        }

        #endregion

        #region ������Ҫ��ͼƬ�ߴ磬����������ԭʼͼƬ

        /// <summary>
        /// ������Ҫ��ͼƬ�ߴ磬����������ԭʼͼƬ
        /// </summary>
        /// <param name="nWidth">����ͼ���</param>
        /// <param name="nHeight">����ͼ�߶�</param>
        /// <param name="img">ԭʼͼƬ</param>
        /// <returns>��������ߴ�</returns>
        public static Size CutRegion(int nWidth, int nHeight, Image img)
        {
            double width;
            double height;

            double nw = nWidth;
            double nh = nHeight;

            double pw = img.Width;
            double ph = img.Height;

            if (nw/nh > pw/ph)
            {
                width = pw;
                height = pw*nh/nw;
            }
            else if (nw/nh < pw/ph)
            {
                width = ph*nw/nh;
                height = ph;
            }
            else
            {
                width = pw;
                height = ph;
            }

            return new Size(Convert.ToInt32(width), Convert.ToInt32(height));
        }

        #endregion

        #region �ȱ�����СͼƬ
        /// <summary>
        /// �ȱ�����СͼƬ
        /// </summary>
        /// <param name="nWidth">���</param>
        /// <param name="nHeight">�߶�</param>
        /// <param name="img">image����</param>
        /// <returns>ת�����С</returns>
        public static Size NewSize(int nWidth, int nHeight, Image img)
        {
            double w;
            double h;
            double sw = Convert.ToDouble(img.Width);
            double sh = Convert.ToDouble(img.Height);
            double mw = Convert.ToDouble(nWidth);
            double mh = Convert.ToDouble(nHeight);

            if (sw < mw && sh < mh)
            {
                w = sw;
                h = sh;
            }
            else if ((sw/sh) > (mw/mh))
            {
                w = nWidth;
                h = (w*sh)/sw;
            }
            else
            {
                h = nHeight;
                w = (h*sw)/sh;
            }

            return new Size(Convert.ToInt32(w), Convert.ToInt32(h));
        }

        #endregion

        #region ��������ͼ

        #region ��������ͼ������ˮӡ

        /// <summary>
        /// ��������ͼ������ˮӡ
        /// </summary>
        /// <param name="filename">Դ�ļ�</param>
        /// <param name="nWidth">����ͼ���</param>
        /// <param name="nHeight">����ͼ�߶�</param>
        /// <param name="destfile">����ͼ����λ��</param>
        public static void CreateSmallPhoto(string filename, int nWidth, int nHeight, string destfile)
        {
            Image img = Image.FromFile(filename);
            ImageFormat thisFormat = img.RawFormat;

            Size cutSize = CutRegion(nWidth, nHeight, img);
            var outBmp = new Bitmap(nWidth, nHeight);
            Graphics g = Graphics.FromImage(outBmp);

            // ���û������������
            g.CompositingQuality = CompositingQuality.HighQuality;
            g.SmoothingMode = SmoothingMode.HighQuality;
            g.InterpolationMode = InterpolationMode.HighQualityBicubic;

            int nStartX = (img.Width - cutSize.Width)/2;
            int nStartY = (img.Height - cutSize.Height)/2;

            g.DrawImage(img, new Rectangle(0, 0, nWidth, nHeight),
                        nStartX, nStartY, cutSize.Width, cutSize.Height, GraphicsUnit.Pixel);
            g.Dispose();

            //if (thisFormat.Equals(ImageFormat.Gif))
            //{
            //    Response.ContentType = "image/gif";
            //}
            //else
            //{
            //    Response.ContentType = "image/jpeg";
            //}

            // ���´���Ϊ����ͼƬʱ������ѹ������
            var encoderParams = new EncoderParameters();
            var quality = new long[1];
            quality[0] = 100;

            var encoderParam = new EncoderParameter(Encoder.Quality, quality);
            encoderParams.Param[0] = encoderParam;

            //��ð����й�����ͼ��������������Ϣ��ImageCodecInfo ����
            ImageCodecInfo[] arrayIci = ImageCodecInfo.GetImageEncoders();
            ImageCodecInfo jpegIci = arrayIci.FirstOrDefault(t => t.FormatDescription.Equals("JPEG"));

            if (jpegIci != null)
            {
                //outBmp.Save(Response.OutputStream, jpegICI, encoderParams);
                outBmp.Save(destfile, jpegIci, encoderParams);
            }
            else
            {
                //outBmp.Save(Response.OutputStream, thisFormat);
                outBmp.Save(destfile, thisFormat);
            }

            img.Dispose();
            outBmp.Dispose();
        }

        #endregion

        #region ��������ͼ����ˮӡ
        /// <summary>
        /// ��������ͼ����ˮӡ
        /// </summary>
        /// <param name="filename">Դ�ļ�</param>
        /// <param name="nWidth">����ͼ���</param>
        /// <param name="nHeight">����ͼ�߶�</param>
        /// <param name="destfile">����ͼ����λ��</param>
        /// <param name="sy">ͼƬˮӡ</param>
        /// <param name="nType"></param>
        public static void CreateSmallPhoto(string filename, int nWidth, int nHeight, string destfile, string sy,
                                            int nType)
        {
            if (nType == 0)
                CreateSmallPhoto(filename, nWidth, nHeight, destfile, sy, "");
            else
                CreateSmallPhoto(filename, nWidth, nHeight, destfile, "", sy);
        }

        #endregion

        #region ��������ͼ

        /// <summary>
        /// ��������ͼ
        /// </summary>
        /// <param name="filename">Դ�ļ�</param>
        /// <param name="nWidth">����ͼ���</param>
        /// <param name="nHeight">����ͼ�߶�</param>
        /// <param name="destfile">����ͼ����λ��</param>
        /// <param name="png">ͼƬˮӡ</param>
        /// <param name="text">�ı�ˮӡ</param>
        public static void CreateSmallPhoto(string filename, int nWidth, int nHeight, string destfile, string png,
                                            string text)
        {
            Image img = Image.FromFile(filename);
            ImageFormat thisFormat = img.RawFormat;

            Size cutSize = CutRegion(nWidth, nHeight, img);
            var outBmp = new Bitmap(nWidth, nHeight);
            Graphics g = Graphics.FromImage(outBmp);
            g.Clear(Color.White);

            // ���û������������
            g.CompositingQuality = CompositingQuality.HighQuality;
            g.SmoothingMode = SmoothingMode.HighQuality;
            g.InterpolationMode = InterpolationMode.HighQualityBicubic;

            int nStartX = (img.Width - cutSize.Width)/2;
            int nStartY = (img.Height - cutSize.Height)/2;

            g.DrawImage(img, new Rectangle(0, 0, nWidth, nHeight),
                        nStartX, nStartY, cutSize.Width, cutSize.Height, GraphicsUnit.Pixel);
            g.Dispose();

            // ���´���Ϊ����ͼƬʱ������ѹ������
            var encoderParams = new EncoderParameters();
            var quality = new long[1];
            quality[0] = 100;

            var encoderParam = new EncoderParameter(Encoder.Quality, quality);
            encoderParams.Param[0] = encoderParam;

            //��ð����й�����ͼ��������������Ϣ��ImageCodecInfo ����
            ImageCodecInfo[] arrayIci = ImageCodecInfo.GetImageEncoders();
            ImageCodecInfo jpegIci = arrayIci.FirstOrDefault(t => t.FormatDescription.Equals("JPEG"));

            if (jpegIci != null)
            {
                outBmp.Save(destfile, jpegIci, encoderParams);
            }
            else
            {
                outBmp.Save(destfile, thisFormat);
            }

            img.Dispose();
            outBmp.Dispose();

            if (!string.IsNullOrEmpty(png))
                AttachPng(png, destfile);

            if (!string.IsNullOrEmpty(text))
                AttachText(text, destfile);
        }

        /// <summary>
        /// ��������ͼ
        /// </summary>
        /// <param name="filename">Դ�ļ�</param>
        /// <param name="nWidth">����ͼ���</param>
        /// <param name="nHeight">����ͼ�߶�</param>
        /// <param name="destfile">����ͼ����λ��</param>
        /// <param name="png">ͼƬˮӡ</param>
        /// <param name="text">�ı�ˮӡ</param>
        /// <param name="cMode">����ģʽ</param>
        public static void CreateSmallPhoto(string filename, int nWidth, int nHeight, string destfile, string png,
                                            string text, CutMode cMode)
        {
            Image img = Image.FromFile(filename);

            if (nWidth <= 0)
                nWidth = img.Width;
            if (nHeight <= 0)
                nHeight = img.Height;

            int towidth = nWidth;
            int toheight = nHeight;

            switch (cMode)
            {
                case CutMode.CutWh: //ָ���߿����ţ����ܱ��Σ�                
                    break;
                case CutMode.CutW: //ָ�����߰�����                    
                    toheight = img.Height*nWidth/img.Width;
                    break;
                case CutMode.CutH: //ָ���ߣ�������
                    towidth = img.Width*nHeight/img.Height;
                    break;
                case CutMode.CutNo: //���Ų�����
                    int maxSize = (nWidth >= nHeight ? nWidth : nHeight);
                    if (img.Width >= img.Height)
                    {
                        towidth = maxSize;
                        toheight = img.Height*maxSize/img.Width;
                    }
                    else
                    {
                        toheight = maxSize;
                        towidth = img.Width*maxSize/img.Height;
                    }
                    break;
                default:
                    break;
            }
            nWidth = towidth;
            nHeight = toheight;

            ImageFormat thisFormat = img.RawFormat;

            var cutSize = new Size(nWidth, nHeight);
            if (cMode != CutMode.CutNo)
                cutSize = CutRegion(nWidth, nHeight, img);

            var outBmp = new Bitmap(cutSize.Width, cutSize.Height);

            Graphics g = Graphics.FromImage(outBmp);
            g.Clear(Color.White);

            // ���û������������
            g.CompositingQuality = CompositingQuality.HighQuality;
            g.SmoothingMode = SmoothingMode.HighQuality;
            g.InterpolationMode = InterpolationMode.HighQualityBicubic;

            int nStartX = (img.Width - cutSize.Width)/2;
            int nStartY = (img.Height - cutSize.Height)/2;

            //int x1 = (outBmp.Width - nWidth) / 2;
            //int y1 = (outBmp.Height - nHeight) / 2;

            if (cMode != CutMode.CutNo)
                g.DrawImage(img, new Rectangle(0, 0, nWidth, nHeight),
                            nStartX, nStartY, cutSize.Width, cutSize.Height, GraphicsUnit.Pixel);
            else
                g.DrawImage(img, new Rectangle(0, 0, nWidth, nHeight),
                            0, 0, img.Width, img.Height, GraphicsUnit.Pixel);
            g.Dispose();

            // ���´���Ϊ����ͼƬʱ������ѹ������
            var encoderParams = new EncoderParameters();
            var quality = new long[1];
            quality[0] = 100;

            var encoderParam = new EncoderParameter(Encoder.Quality, quality);
            encoderParams.Param[0] = encoderParam;

            //��ð����й�����ͼ��������������Ϣ��ImageCodecInfo ����
            ImageCodecInfo[] arrayIci = ImageCodecInfo.GetImageEncoders();
            ImageCodecInfo jpegIci = arrayIci.FirstOrDefault(t => t.FormatDescription.Equals("JPEG"));

            if (jpegIci != null)
            {
                outBmp.Save(destfile, jpegIci, encoderParams);
            }
            else
            {
                outBmp.Save(destfile, thisFormat);
            }

            img.Dispose();
            outBmp.Dispose();

            if (!string.IsNullOrEmpty(png))
                AttachPng(png, destfile);

            if (!string.IsNullOrEmpty(text))
                AttachText(text, destfile);
        }

        #endregion

        #endregion

        #region �������ˮӡ
        /// <summary>
        /// �������ˮӡ
        /// </summary>
        /// <param name="text">�ı�</param>
        /// <param name="file">Դ�ļ�</param>
        public static void AttachText(string text, string file)
        {
            if (string.IsNullOrEmpty(text))
                return;

            if (!File.Exists(file))
                return;

            var oFile = new FileInfo(file);
            string strTempFile = Path.Combine(oFile.DirectoryName, Guid.NewGuid() + oFile.Extension);
            oFile.CopyTo(strTempFile);

            Image img = Image.FromFile(strTempFile);
            ImageFormat thisFormat = img.RawFormat;

            int nHeight = img.Height;
            int nWidth = img.Width;

            var outBmp = new Bitmap(nWidth, nHeight);
            Graphics g = Graphics.FromImage(outBmp);
            g.Clear(Color.White);

            // ���û������������
            g.CompositingQuality = CompositingQuality.HighQuality;
            g.SmoothingMode = SmoothingMode.HighQuality;
            g.InterpolationMode = InterpolationMode.HighQualityBicubic;

            g.DrawImage(img, new Rectangle(0, 0, nWidth, nHeight),
                        0, 0, nWidth, nHeight, GraphicsUnit.Pixel);

            var sizes = new[] {16, 14, 12, 10, 8, 6, 4};

            Font crFont = null;
            var crSize = new SizeF();

            //ͨ��ѭ��������飬��ѡ�ò�ͬ�������С
            //������Ĵ�СС��ͼ��Ŀ�ȣ���ѡ�������С������
            for (int i = 0; i < 7; i++)
            {
                //�������壬��������arial������
                crFont = new Font("arial", sizes[i], FontStyle.Bold);
                //Measure the Copyright string in this Font
                crSize = g.MeasureString(text, crFont);

                if ((ushort) crSize.Width < (ushort) nWidth)
                    break;
            }

            //��ΪͼƬ�ĸ߶ȿ��ܲ�����ͬ, ���Զ�����
            //��ͼƬ�ײ�����Ԥ����5%�Ŀռ�
            var yPixlesFromBottom = (int) (nHeight*.08);

            //����ʹ�ð�Ȩ��Ϣ�ַ����ĸ߶���ȷ��Ҫ���Ƶ�ͼ����ַ�����y����

            float yPosFromBottom = ((nHeight - yPixlesFromBottom) - (crSize.Height/2));

            //����x����
            // ReSharper disable PossibleLossOfFraction
            float xCenterOfImg = (nWidth/2);
            // ReSharper restore PossibleLossOfFraction

            //���ı���������Ϊ����
            var strFormat = new StringFormat {Alignment = StringAlignment.Center};

            //ͨ��Brush�����ú�ɫ��͸��
            var semiTransBrush2 = new SolidBrush(Color.FromArgb(153, 0, 0, 0));

            //���ư�Ȩ�ַ���
            g.DrawString(text, //��Ȩ�ַ����ı�
                         crFont, //����
                         semiTransBrush2, //Brush
                         new PointF(xCenterOfImg + 1, yPosFromBottom + 1), //λ��
                         strFormat);

            //���óɰ�ɫ��͸��
            var semiTransBrush = new SolidBrush(Color.FromArgb(153, 255, 255, 255));

            //�ڶ��λ��ư�Ȩ�ַ�����������ӰЧ��
            //��ס�ƶ��ı���λ��1����
            g.DrawString(text, //��Ȩ�ı�
                         crFont, //����
                         semiTransBrush, //Brush
                         new PointF(xCenterOfImg, yPosFromBottom), //λ��
                         strFormat);

            g.Dispose();

            // ���´���Ϊ����ͼƬʱ������ѹ������
            var encoderParams = new EncoderParameters();
            var quality = new long[1];
            quality[0] = 100;

            var encoderParam = new EncoderParameter(Encoder.Quality, quality);
            encoderParams.Param[0] = encoderParam;

            //��ð����й�����ͼ��������������Ϣ��ImageCodecInfo ����
            ImageCodecInfo[] arrayIci = ImageCodecInfo.GetImageEncoders();
            ImageCodecInfo jpegIci = arrayIci.FirstOrDefault(t => t.FormatDescription.Equals("JPEG"));

            if (jpegIci != null)
            {
                outBmp.Save(file, jpegIci, encoderParams);
            }
            else
            {
                outBmp.Save(file, thisFormat);
            }

            img.Dispose();
            outBmp.Dispose();

            File.Delete(strTempFile);
        }

        #endregion

        #region ���ͼƬˮӡ
        /// <summary>
        /// ���ͼƬˮӡ
        /// </summary>
        /// <param name="png">ˮӡͼƬ</param>
        /// <param name="file">ԭͼƬ</param>
        public static void AttachPng(string png, string file)
        {
            if (string.IsNullOrEmpty(png))
                return;

            if (!File.Exists(png))
                return;

            if (!File.Exists(file))
                return;

            var oFile = new FileInfo(file);
            string strTempFile = Path.Combine(oFile.DirectoryName, Guid.NewGuid() + oFile.Extension);
            oFile.CopyTo(strTempFile);

            Image img = Image.FromFile(strTempFile);
            ImageFormat thisFormat = img.RawFormat;
            int nHeight = img.Height;
            int nWidth = img.Width;

            var outBmp = new Bitmap(nWidth, nHeight);
            Graphics g = Graphics.FromImage(outBmp);

            // ���û������������
            g.CompositingQuality = CompositingQuality.HighQuality;
            g.SmoothingMode = SmoothingMode.HighQuality;
            g.InterpolationMode = InterpolationMode.HighQualityBicubic;

            g.DrawImage(img, new Rectangle(0, 0, nWidth, nHeight),
                        0, 0, nWidth, nHeight, GraphicsUnit.Pixel);

            img.Dispose();

            img = Image.FromFile(png);

            //Bitmap bmpPng = new Bitmap(img);

            //ImageAttributes imageAttr = new ImageAttributes();
            //Color bg = Color.Green;
            //imageAttr.SetColorKey(bg, bg);

            Size pngSize = NewSize(nWidth, nHeight, img);
            g.DrawImage(img,
                        new Rectangle((nWidth - pngSize.Width)/2, (nHeight - pngSize.Height)/2, pngSize.Width,
                                      pngSize.Height),
                        0, 0, img.Width, img.Height, GraphicsUnit.Pixel);

            g.Dispose();

            // ���´���Ϊ����ͼƬʱ������ѹ������
            var encoderParams = new EncoderParameters();
            var quality = new long[1];
            quality[0] = 100;

            var encoderParam = new EncoderParameter(Encoder.Quality, quality);
            encoderParams.Param[0] = encoderParam;

            //��ð����й�����ͼ��������������Ϣ��ImageCodecInfo ����
            ImageCodecInfo[] arrayIci = ImageCodecInfo.GetImageEncoders();
            ImageCodecInfo jpegIci = arrayIci.FirstOrDefault(t => t.FormatDescription.Equals("JPEG"));

            if (jpegIci != null)
            {
                outBmp.Save(file, jpegIci, encoderParams);
            }
            else
            {
                outBmp.Save(file, thisFormat);
            }

            img.Dispose();
            outBmp.Dispose();

            File.Delete(strTempFile);
        }

        #endregion

        #region �õ�ָ��mimeType��ImageCodecInfo

        /// <summary> 
        /// ����JPGʱ�� 
        /// </summary> 
        /// <param name="mimeType"> </param> 
        /// <returns>�õ�ָ��mimeType��ImageCodecInfo </returns> 
        private static ImageCodecInfo GetCodecInfo(string mimeType)
        {
            ImageCodecInfo[] codecInfo = ImageCodecInfo.GetImageEncoders();
            return codecInfo.FirstOrDefault(ici => ici.MimeType == mimeType);
        }

        #endregion

        #region ����ΪJPEG��ʽ��֧��ѹ������ѡ��

        /// <summary>
        /// ����ΪJPEG��ʽ��֧��ѹ������ѡ��
        /// </summary>
        /// <param name="sourceFile">ԭ�ļ�</param>
        /// <param name="fileName">���ļ�</param>
        /// <param name="qty">EncoderParameterֵ</param>
        /// <returns></returns>
        public static bool KiSaveAsJpeg(string sourceFile, string fileName, int qty)
        {
            var bmp = new Bitmap(sourceFile);

            try
            {
                var ps = new EncoderParameters(1);

                var p = new EncoderParameter(Encoder.Quality, qty);
                ps.Param[0] = p;

                bmp.Save(fileName, GetCodecInfo("image/jpeg"), ps);

                bmp.Dispose();

                return true;
            }
            catch
            {
                bmp.Dispose();
                return false;
            }
        }

        #endregion

        #region ��ͼƬѹ����ָ����С

        /// <summary>
        /// ��ͼƬѹ����ָ����С
        /// </summary>
        /// <param name="fileName">��ѹ��ͼƬ</param>
        /// <param name="size">����ѹ����ĳߴ�</param>
        public static void CompressPhoto(string fileName, int size)
        {
            if (!File.Exists(fileName))
                return;

            int nCount = 0;
            var oFile = new FileInfo(fileName);
            long nLen = oFile.Length;
            while (nLen > size*1024 && nCount < 10)
            {
                string dir = oFile.Directory.FullName;
                string tempFile = Path.Combine(dir, Guid.NewGuid() + "." + oFile.Extension);
                oFile.CopyTo(tempFile, true);

                KiSaveAsJpeg(tempFile, fileName, 70);

                try
                {
                    File.Delete(tempFile);
                }
                catch (Exception)
                {
                }

                nCount++;

                oFile = new FileInfo(fileName);
                nLen = oFile.Length;
            }
        }

        #endregion

        #endregion
    }
}