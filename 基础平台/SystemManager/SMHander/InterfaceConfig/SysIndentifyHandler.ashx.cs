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
    /// SysIndentifyHandler 的摘要说明
    /// </summary>
    public class SysIndentifyHandler : IHttpHandler
    {
        Plat_SysIndentifyService bll = new Plat_SysIndentifyService();
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
                    case "GetSysIndentifyDataPage":
                        GetSysIndentifyDataPage();
                        optionType = ActionConstants.Search;
                        methodDescrip = "获取系统模块的分页数据";
                        break;
                    case "AddSysIndentify":
                        AddSysIndentify(syskey);
                        optionType = ActionConstants.add;
                        methodDescrip = "添加系统模块";
                        break;
                    case "EditSysIndentify":
                        EditSysIndentify(syskey);
                        optionType = ActionConstants.xg;
                        methodDescrip = "编辑系统模块";
                        break;
                    case "DeleteSysIndentify":
                        DeleteSysIndentify(syskey);
                        optionType = ActionConstants.del;
                        methodDescrip = "删除系统模块";
                        break;
                    case "GetSysIndentifyModelById":
                        GetSysIndentifyModelById(syskey);
                        optionType = ActionConstants.Search;
                        methodDescrip = "根据系统模块id获取系统模块实体";
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
                    log.WriteLog(LogConstants.xtzhgl, optionType, "", loginname, methodDescrip + "[" + func + "]");
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
        #region 获取系统模块的分页数据
        private void GetSysIndentifyDataPage()
        {
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrEmpty(HttpContext.Current.Request["name"]))
                {
                    ht.Add("Name", HttpContext.Current.Request["name"].ToString());
                }
                if (!string.IsNullOrEmpty(HttpContext.Current.Request["selsyskey"]))
                {
                    ht.Add("SelSystemKey", HttpContext.Current.Request["selsyskey"].ToString());
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

        #region 添加系统模块
        private void AddSysIndentify(string syskey)
        {
            string callback = HttpContext.Current.Request["jsoncallback"];
            string cursyskey = HttpContext.Current.Request["cursyskey"];
            string infname = HttpContext.Current.Request["infname"];
            string curinfkey = HttpContext.Current.Request["curinfkey"];
            jsonModel = bll.IsNameExists(cursyskey, infname, 0, "InfName", true);
            if (jsonModel.errNum == 0)
            {
                if (jsonModel.retData.ToString().ToLower() == "true")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = -1,
                        errMsg = "该系统下的模块名称已存在！",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = bll.IsNameExists(cursyskey, curinfkey, 0, "InfKey", true);
                    if (jsonModel.retData.ToString().ToLower() == "true")
                    {
                        jsonModel = new JsonModel()
                        {
                            errNum = -1,
                            errMsg = "该系统下的模块key已存在！",
                            retData = ""
                        };
                    }
                    else
                    {
                        Plat_SysIndentify inf = new Plat_SysIndentify();
                        inf.SystemKey = cursyskey;
                        inf.InfName = infname;
                        inf.InfKey = curinfkey;
                        inf.Creator = HttpContext.Current.Request["useridcard"];
                        inf.CreateTime = DateTime.Now;
                        inf.IsDelete = 0;
                        jsonModel = bll.Add(inf);
                    }
                }
            }
        }
        #endregion

        #region 编辑系统模块
        private void EditSysIndentify(string syskey)
        {
            string callback = HttpContext.Current.Request["jsoncallback"];
            int itemid = Convert.ToInt32(HttpContext.Current.Request["itemid"]);
            string cursyskey = HttpContext.Current.Request["cursyskey"];
            string infname = HttpContext.Current.Request["infname"];
            string curinfkey = HttpContext.Current.Request["curinfkey"];
            jsonModel = bll.IsNameExists(cursyskey, infname, itemid, "InfName", true);
            if (jsonModel.errNum == 0)
            {
                if (jsonModel.retData.ToString().ToLower() == "true")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = -1,
                        errMsg = "该系统下的模块名称已存在！",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = bll.IsNameExists(cursyskey, curinfkey, itemid, "InfKey", true);
                    if (jsonModel.retData.ToString().ToLower() == "true")
                    {
                        jsonModel = new JsonModel()
                        {
                            errNum = -1,
                            errMsg = "该系统下的模块key已存在！",
                            retData = ""
                        };
                    }
                    else
                    {
                        jsonModel = bll.GetEntityById(itemid);
                        if (jsonModel.errNum == 0)
                        {
                            Plat_SysIndentify inf = jsonModel.retData as Plat_SysIndentify;
                            inf.Id = itemid;
                            inf.InfName = infname;
                            inf.InfKey = curinfkey;
                            inf.Editor = HttpContext.Current.Request["useridcard"];
                            inf.EditTime = DateTime.Now;
                            jsonModel = bll.Update(inf);
                        }
                    }
                }
            }
        }
        #endregion

        #region 删除系统模块
        private void DeleteSysIndentify(string syskey)
        {
            string callback = HttpContext.Current.Request["jsoncallback"];
            int itemid = Convert.ToInt32(HttpContext.Current.Request["itemid"]);
            jsonModel = bll.GetEntityById(itemid);
            if (jsonModel.errNum == 0)
            {
                Plat_SysIndentify inf = jsonModel.retData as Plat_SysIndentify;
                inf.Id = itemid;
                inf.IsDelete = 1;
                jsonModel = bll.Update(inf);
            }
        }
        #endregion

        #region 根据系统模块id获取系统模块实体
        private void GetSysIndentifyModelById(string syskey)
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