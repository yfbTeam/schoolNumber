using SMBLL;
using SMModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SMHander.InterfaceConfig
{
    /// <summary>
    /// SysOfInterRelHandler 的摘要说明
    /// </summary>
    public class SysOfInterRelHandler : IHttpHandler
    {
        Plat_SysOfInter_RelService bll = new Plat_SysOfInter_RelService();
        Plat_LogInfoService log = new Plat_LogInfoService();
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string syskey = context.Request["SystemKey"];
            string infkey = context.Request["InfKey"];
            string func = context.Request["func"];
            string loginname = HttpContext.Current.Request["loginname"] ?? "";
            string idcard = context.Request["useridcard"]; 
            string result = string.Empty;
            string optionType = string.Empty;
            string methodDescrip = string.Empty;
            try
            {
                switch (func)
                {
                    case "GetSysOfInter_RelDataPage":
                        GetSysOfInter_RelDataPage();
                        optionType = ActionConstants.Search;
                        methodDescrip = "获取系统模块与接口关系的分页数据";
                        break;
                    case "AddSysOfInter_Rel":
                        AddSysOfInter_Rel(syskey);
                        optionType = ActionConstants.add;
                        methodDescrip = "添加系统模块与接口关系";
                        break;
                    case "EditSysOfInter_Rel":
                        EditSysOfInter_Rel(syskey);
                        optionType = ActionConstants.xg;
                        methodDescrip = "编辑系统模块与接口关系";
                        break;
                    case "DeleteSysOfInter_Rel":
                        DeleteSysOfInter_Rel(syskey);
                        optionType = ActionConstants.del;
                        methodDescrip = "删除系统模块与接口关系";
                        break;
                    case "GetSysOfInter_RelModelById":
                        GetSysOfInter_RelModelById(syskey);
                        optionType = ActionConstants.Search;
                        methodDescrip = "根据系统模块与接口关系id获取系统模块与接口关系实体";
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
                if (!string.IsNullOrEmpty(loginname))
                {
                    log.WriteLog(LogConstants.jkqxgl, optionType, "", loginname, methodDescrip + "[" + func + "]");
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
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();
        }
        #region 获取系统模块与接口关系的分页数据
        private void GetSysOfInter_RelDataPage()
        {
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrEmpty(HttpContext.Current.Request["schoolid"]))
                {
                    ht.Add("SchoolId", HttpContext.Current.Request["schoolid"].ToString());
                }
                if (!string.IsNullOrEmpty(HttpContext.Current.Request["infname"]))
                {
                    ht.Add("InfName", HttpContext.Current.Request["infname"].ToString());
                }    
                if (!string.IsNullOrEmpty(HttpContext.Current.Request["relid"]))
                {
                    ht.Add("RelId", HttpContext.Current.Request["relid"].ToString());
                }
                bool ispage = true;
                if (!string.IsNullOrEmpty(HttpContext.Current.Request["ispage"]))
                {
                    ispage = false;
                } 
                ht.Add("PageIndex", HttpContext.Current.Request["PageIndex"].ToString());
                ht.Add("PageSize", HttpContext.Current.Request["PageSize"].ToString());
                jsonModel = bll.GetPage(ht, null, ispage);
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
        }
        #endregion

        #region 添加系统模块与接口关系
        private void AddSysOfInter_Rel(string syskey)
        {
            string callback = HttpContext.Current.Request["jsoncallback"];
            int infid =Convert.ToInt32(HttpContext.Current.Request["infid"]);
            int interid =Convert.ToInt32(HttpContext.Current.Request["interid"]);
            jsonModel = bll.IsSysOfInter_RelExists(infid,interid);
            if (jsonModel.errNum == 0)
            {
                if (jsonModel.retData.ToString().ToLower() == "true")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = -1,
                        errMsg = "该权限已存在！",
                        retData = ""
                    };
                }
                else
                {
                    Plat_SysOfInter_Rel rel = new Plat_SysOfInter_Rel();
                    rel.IndentifyId = infid;
                    rel.InterfaceId = interid;
                    rel.ReturnField = HttpContext.Current.Request["returnfield"]; 
                    jsonModel = bll.Add(rel);
                }
            }
        }
        #endregion

        #region 编辑系统模块与接口关系
        private void EditSysOfInter_Rel(string syskey)
        {
            string callback = HttpContext.Current.Request["jsoncallback"];
            int itemid = Convert.ToInt32(HttpContext.Current.Request["itemid"]);
            int infid = Convert.ToInt32(HttpContext.Current.Request["infid"]);
            int interid = Convert.ToInt32(HttpContext.Current.Request["interid"]);
            jsonModel = bll.IsSysOfInter_RelExists(infid, interid, itemid);
            if (jsonModel.errNum == 0)
            {
                if (jsonModel.retData.ToString().ToLower() == "true")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = -1,
                        errMsg = "该权限已存在！",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = bll.GetEntityById(itemid);
                    if (jsonModel.errNum == 0)
                    {
                        Plat_SysOfInter_Rel rel = jsonModel.retData as Plat_SysOfInter_Rel;
                        rel.Id = itemid;
                        rel.IndentifyId = infid;
                        rel.InterfaceId = interid;
                        rel.ReturnField = HttpContext.Current.Request["returnfield"]; 
                        jsonModel = bll.Update(rel);
                    }
                }
            }
        }
        #endregion

        #region 删除系统模块与接口关系
        private void DeleteSysOfInter_Rel(string syskey)
        {
            string callback = HttpContext.Current.Request["jsoncallback"];
            int itemid = Convert.ToInt32(HttpContext.Current.Request["itemid"]);
            jsonModel = bll.Delete(itemid);
        }
        #endregion

        #region 根据系统模块与接口关系id获取系统模块与接口关系实体
        private void GetSysOfInter_RelModelById(string syskey)
        {
            string callback = HttpContext.Current.Request["jsoncallback"];
            int itemid = Convert.ToInt32(HttpContext.Current.Request["itemid"]);
            jsonModel = bll.GetEntityById(itemid);
        }
        #endregion

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}