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
    /// InterfaceHandler 的摘要说明
    /// </summary>
    public class InterfaceHandler : IHttpHandler
    {
        Plat_InterfaceService bll = new Plat_InterfaceService();
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
                    case "GetInterfaceDataPage":
                        GetInterfaceDataPage();
                        optionType = ActionConstants.Search;
                        methodDescrip = "获取接口的分页数据";
                        break;
                    case "AddInterface":
                        AddInterface(syskey);
                        optionType = ActionConstants.add;
                        methodDescrip = "添加接口";
                        break;
                    case "EditInterface":
                        EditInterface(syskey);
                        optionType = ActionConstants.xg;
                        methodDescrip = "编辑接口";
                        break;
                    case "DeleteInterface":
                        DeleteInterface(syskey);
                        optionType = ActionConstants.del;
                        methodDescrip = "删除接口";
                        break;
                    case "GetInterfaceModelById":
                        GetInterfaceModelById(syskey);
                        optionType = ActionConstants.Search;
                        methodDescrip = "根据接口id获取接口实体";
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
                    log.WriteLog(LogConstants.jkxxgl, optionType, "", loginname, methodDescrip + "[" + func + "]");
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
        #region 获取接口的分页数据
        private void GetInterfaceDataPage()
        {
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrEmpty(HttpContext.Current.Request["name"]))
                {
                    ht.Add("Name", HttpContext.Current.Request["name"].ToString());
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

        #region 添加接口
        private void AddInterface(string syskey)
        {
            string callback = HttpContext.Current.Request["jsoncallback"];
            string name = HttpContext.Current.Request["name"];
            jsonModel = bll.IsNameExists(syskey, name);
            if (jsonModel.errNum == 0)
            {
                if (jsonModel.retData.ToString().ToLower() == "true")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = -1,
                        errMsg = "该接口名称已存在",
                        retData = ""
                    };
                }
                else
                {
                    Plat_Interface inter = new Plat_Interface();
                    inter.Name = name;
                    inter.Description = HttpContext.Current.Request["description"];
                    inter.ServicePage = HttpContext.Current.Request["servicepage"];
                    inter.Creator = HttpContext.Current.Request["useridcard"];
                    inter.CreateTime = DateTime.Now;
                    inter.IsDelete = 0;
                    jsonModel = bll.Add(inter);
                }
            }
        }
        #endregion

        #region 编辑接口
        private void EditInterface(string syskey)
        {
            string callback = HttpContext.Current.Request["jsoncallback"];
            int itemid = Convert.ToInt32(HttpContext.Current.Request["itemid"]);
            string name = HttpContext.Current.Request["name"]; 
            jsonModel=bll.IsNameExists(syskey, name, itemid);
            if (jsonModel.errNum == 0)
            {
                if (jsonModel.retData.ToString().ToLower() == "true")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = -1,
                        errMsg = "该接口名称已存在",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = bll.GetEntityById(itemid);
                    if (jsonModel.errNum == 0)
                    {
                        Plat_Interface inter = jsonModel.retData as Plat_Interface;
                        inter.Id = itemid;
                        inter.Name = name;
                        inter.Description = HttpContext.Current.Request["description"];
                        inter.ServicePage = HttpContext.Current.Request["servicepage"];
                        inter.Editor = HttpContext.Current.Request["useridcard"];
                        inter.EditTime = DateTime.Now;
                        jsonModel = bll.Update(inter);
                    }
                }                
            }
        }
        #endregion

        #region 删除接口
        private void DeleteInterface(string syskey)
        {
            string callback = HttpContext.Current.Request["jsoncallback"];
            int itemid = Convert.ToInt32(HttpContext.Current.Request["itemid"]);
            jsonModel = bll.GetEntityById(itemid);
            if (jsonModel.errNum == 0)
            {
                Plat_Interface inter = jsonModel.retData as Plat_Interface;
                inter.Id = itemid;
                inter.IsDelete = 1;
                jsonModel = bll.Update(inter);
            }
        }
        #endregion

        #region 根据接口id获取接口实体
        private void GetInterfaceModelById(string syskey)
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