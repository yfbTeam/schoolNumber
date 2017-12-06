using SMBLL;
using SMModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;

namespace SMHander
{
    /// <summary>
    /// StudySection 的摘要说明
    /// </summary>
    public class TextbookHandler : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        SMBLL.Plat_LogInfoService log = new SMBLL.Plat_LogInfoService();
        JsonModel jsonModel = null;
        BLLCommon com = new SMBLL.BLLCommon();
        SMBLL.Plat_TextbookService BLL = new Plat_TextbookService();
        public void ProcessRequest(HttpContext context)
        {
            string func = context.Request["func"] ?? "";
            try
            {
                switch (func)
                {
                    case "GetTextbookData":
                        GetTextbookData(context);
                        break;
                    case "GetTextbookPageData":
                        GetTextbookPageData(context);
                        break;
                    case "DeleteTextbook":
                        DeleteTextbook(context);
                        break;
                    case "AddTextbook":
                        AddTextbook(context);
                        break;
                    case "GetTextbookById":
                        GetTextbookById(context);
                        break;
                    case "UpdateTextbook":
                        UpdateTextbook(context);
                        break;
                    default:
                        jsonModel = new JsonModel()
                        {
                            errNum = 5,
                            errMsg = "没有此方法",
                            retData = ""
                        };
                        break;
                }
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
            string result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.ContentType = "text/plain";
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

        /// <summary>
        /// 获得教材数据
        /// </summary>
        /// <param name="context"></param>
        public void GetTextbookData(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();
                //获取参数值
                if (context.Request["SystemKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                }
                if (context.Request["InfKey"] != null)
                {
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                sb.Append(" and IsDelete=0");
                ht.Add("func", "GetTextbookData");
                ht.Add("Columns", "*");
                ht.Add("TableName", "Plat_Textbook");
                ht.Add("Where", sb.ToString());
                
                jsonModel = com.GetData(ht);
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
                return;
            }
        }

        /// <summary>
        /// 获得教材分页数据
        /// </summary>
        /// <param name="context"></param>
        public void GetTextbookPageData(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();

                //获取参数值
                if (context.Request["SystemKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                }
                if (context.Request["InfKey"] != null)
                {
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                if (context.Request["PageIndex"] != null)
                {
                    ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                }
                if (context.Request["PageSize"] != null)
                {
                    ht.Add("PageSize", context.Request["PageSize"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["Name"]))
                {
                    sb.Append(" and a.Name like '%" + context.Request["Name"].ToString() + "%'");
                }
                sb.Append(" and a.IsDelete=0");
                ht.Add("func", "GetTextbookPageData");
                ht.Add("Columns", "a.*,b.Name as VersionName,c.Name as SubjectName,d.Name as PeriodName");
                ht.Add("TableName", "Plat_Textbook a left join Plat_TextbookVersion b on a.VersionID=b.Id left join Plat_Subject c on a.SubjectID=c.Id left join Plat_Period d on a.PeriodID=d.Id");
                ht.Add("Where", sb.ToString());

                jsonModel = com.GetPagingData(ht);
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
                return;
            }
        }

        /// <summary>
        /// 修改删除状态
        /// </summary>
        /// <param name="context"></param>
        public void DeleteTextbook(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();

                //获取参数值
                if (context.Request["SystemKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                }
                if (context.Request["InfKey"] != null)
                {
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    ht.Add("Id", context.Request["Id"].ToString());
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 3,
                        errMsg = "loss",
                        retData = ""
                    };
                    return;
                }

                ht.Add("func", "DeleteTextbook");
                jsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (jsonModel.errNum != 0)
                {
                    return;
                }
                jsonModel = BLL.DeleteFalse(Convert.ToInt32(ht["Id"].ToString()));
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
                return;
            }
        }

        /// <summary>
        /// 新增教材
        /// </summary>
        /// <param name="context"></param>
        public void AddTextbook(HttpContext context)
        {
            try
            {
                //Hashtable ht = new Hashtable();
                //StringBuilder sb = new StringBuilder();

                //获取参数值
                SMModel.Plat_Textbook model = new Plat_Textbook();
                if (context.Request["Name"] != null)
                {
                    model.Name = context.Request["Name"].ToString();
                }
                if (context.Request["VersionID"] != null)
                {
                    model.VersionID = Convert.ToInt32(context.Request["VersionID"].ToString());
                }
                if (context.Request["SubjectID"] != null)
                {
                    model.SubjectID = Convert.ToInt32(context.Request["SubjectID"].ToString());
                }
                if (context.Request["PeriodID"] != null)
                {
                    model.PeriodID = Convert.ToInt32(context.Request["PeriodID"].ToString());
                }
                if (context.Request["UserIDCard"] != null)
                {
                    model.Creator = context.Request["UserIDCard"].ToString();
                }
                model.CreateTime = DateTime.Now;
                model.IsDelete = 0;
                jsonModel = BLL.Add(model);

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
                return;
            }
        }
        /// <summary>
        /// 获得教材数据
        /// </summary>
        /// <param name="context"></param>
        public void GetTextbookById(HttpContext context)
        {
            try
            {
                //Hashtable ht = new Hashtable();
                //StringBuilder sb = new StringBuilder();
                string ID = "";
                //获取参数值
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    ID = context.Request["Id"].ToString();
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 3,
                        errMsg = "loss",
                        retData = ""
                    };
                    return;
                }
                jsonModel = BLL.GetEntityById(Convert.ToInt32(ID));
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
                return;
            }
        }

        /// <summary>
        /// 修改教材
        /// </summary>
        /// <param name="context"></param>
        public void UpdateTextbook(HttpContext context)
        {
            try
            {
                //Hashtable ht = new Hashtable();
                //StringBuilder sb = new StringBuilder();

                //获取参数值
                string ID = "";
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    ID = context.Request["Id"].ToString();
                }
                SMModel.Plat_Textbook model = new Plat_Textbook();
                JsonModel JsonModel1 = BLL.GetEntityById(Convert.ToInt32(ID));
                if (JsonModel1.errNum != 0)
                {
                    jsonModel = JsonModel1;
                    return;
                }
                model = (Plat_Textbook)(JsonModel1.retData);
                if (context.Request["Name"] != null)
                {
                    model.Name = context.Request["Name"].ToString();
                }
                if (context.Request["VersionID"] != null)
                {
                    model.VersionID = Convert.ToInt32(context.Request["VersionID"].ToString());
                }
                if (context.Request["SubjectID"] != null)
                {
                    model.SubjectID = Convert.ToInt32(context.Request["SubjectID"].ToString());
                }
                if (context.Request["PeriodID"] != null)
                {
                    model.PeriodID = Convert.ToInt32(context.Request["PeriodID"].ToString());
                }
                if (context.Request["UserIDCard"] != null)
                {
                    model.Editor = context.Request["UserIDCard"].ToString();
                }
                model.EditTime = DateTime.Now;
                jsonModel = BLL.Update(model);
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
                return;
            }
        }
    }
}