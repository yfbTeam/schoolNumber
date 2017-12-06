using SMSBLL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.IO;
namespace SMSWeb.ResourceManage
{
    /// <summary>
    /// PubFileUpload 的摘要说明
    /// </summary>
    public class PubFileUpload : IHttpHandler
    {
        ResourcesInfoService Bll = new ResourcesInfoService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            Upload(context);
        }
        private void Upload(HttpContext context)
        {
            JsonModel jsonModel = null;
            JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();

            string FoldUrl =  context.Request["FoldUrl"] == null ? "" : context.Request["FoldUrl"].SafeToString();
            FoldUrl = ConfigHelper.GetConfigString("FileManageName") + FoldUrl;
            string GroupName = context.Request["GroupName"].SafeToString().Trim();
            string CatagoryID = context.Request["CatagoryID"].SafeToString().Trim().Replace("|0", "");
            string ChapterID = context.Request["ChapterID"].SafeToString().Trim();
            string result = "0";
            string CreateUID = context.Request["CreateUID"].SafeToString();

            try
            {

                if (!FileHelper.IsExistDirectory(context.Server.MapPath(FoldUrl + "/" + GroupName)))
                {
                    FileHelper.CreateDirectory(context.Server.MapPath(FoldUrl + "/" + GroupName));
                }
                HttpPostedFile file = context.Request.Files[0];

                string ext = Path.GetExtension(file.FileName);

                string fileName = Path.GetFileName(file.FileName);
                string p = FoldUrl + "/" + fileName;

                string path = context.Server.MapPath(p);

                #region 处理文件同名问题
                if (FileHelper.IsExistFile(path))
                {
                    int i = 0;
                    while (true)
                    {
                        i++;
                        if (!FileHelper.IsExistFile(context.Server.MapPath(FoldUrl + "/" + fileName.Split('.')[0] + "(" + i + ")" + "." + fileName.Split('.')[1])))
                        {
                            fileName = fileName.Split('.')[0] + "(" + i + ")" + "." + fileName.Split('.')[1];
                            p = FoldUrl + "/" + fileName;
                            path = context.Server.MapPath(p);

                            break;
                        }
                    }
                }
                #endregion

                file.SaveAs(path);
                ResourcesInfo re = new ResourcesInfo();
                re.Name = fileName.Replace(ext,"");
                re.FileSize = file.ContentLength;
                re.FileUrl = p;
                re.FileIcon = "ico-" + fileName.Split('.')[1] + "b.png";
                re.FileIconBig = "ico-" + fileName.Split('.')[1] + "t.png";
                re.postfix = ext;
                re.CreateUID = CreateUID;
                re.EditUID = CreateUID;

                re.DownCount = 0;
                re.CheckMessage = "";
                re.CatagoryID = CatagoryID;
                re.ChapterID = ChapterID == "" ? 0 : int.Parse(ChapterID);
                re.IsOpen = 0;
                re.Status = 0;
                re.FileGroup = GroupName;
                jsonModel = Bll.Add(re);
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";

            context.Response.Write(result);
            context.Response.End();
        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}