using SMBLL;
using SMIDAL;
using SMModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;

namespace SMHander.InterfaceConfig
{
    /// <summary>
    /// SystemHandler 的摘要说明
    /// </summary>
    public class SystemHandler : IHttpHandler
    {
        Plat_SystemInfoService bll = new Plat_SystemInfoService();
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
                    case "GetSystemDataPage":
                        GetSystemDataPage();
                        optionType = ActionConstants.Search;
                        methodDescrip = "获取系统的分页数据";
                        break;
                    case "GetSystemTreeData":
                        GetSystemTreeData(syskey,infkey);
                        optionType = ActionConstants.Search;
                        methodDescrip = "获取系统的系统树信息";
                        break;
                    case "AddSystem":
                        AddSystem(syskey);
                        optionType = ActionConstants.add;
                        methodDescrip = "添加系统";
                        break;
                    case "EditSystem":
                        EditSystem(syskey);
                        optionType = ActionConstants.xg;
                        methodDescrip = "编辑系统";
                        break;
                    case "DeleteSystem":
                        DeleteSystem(syskey);
                        optionType = ActionConstants.del;
                        methodDescrip = "删除系统";
                        break;
                    case "GetSystemModelById":
                        GetSystemModelById(syskey);
                        optionType = ActionConstants.Search;
                        methodDescrip = "根据系统id获取系统实体";
                        break;
                    case "GetSystemAndSchoolBySysId":
                        GetSystemAndSchoolBySysId(context);
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
        #region 获取系统的分页数据
        private void GetSystemDataPage()
        {
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrEmpty(HttpContext.Current.Request["name"]))
                {
                    ht.Add("Name", HttpContext.Current.Request["name"].ToString());
                }
                if (!string.IsNullOrEmpty(HttpContext.Current.Request["schoolid"]))
                {
                    ht.Add("SchoolId", HttpContext.Current.Request["schoolid"].ToString());
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

        #region 获取系统的系统树信息
        private void GetSystemTreeData(string syskey, string indentify)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex","1");
                ht.Add("PageSize","10");
                jsonModel = bll.GetPage(ht, null, false);
                if (jsonModel.errNum == 0)
                {
                    PagedDataModel<Dictionary<string, object>> pagedDataModel = jsonModel.retData as PagedDataModel<Dictionary<string, object>>;
                    List<Dictionary<string, object>> list = pagedDataModel.PagedData;
                    StringBuilder sysJson = new StringBuilder();
                    foreach(Dictionary<string, object> dic in list){                      
                            sysJson.Append("{\"id\":" + dic["Id"].ToString() + ", \"pId\": 0, \"name\":\"" +dic["SchoolName"].ToString()+"-"+ dic["SystemName"].ToString() + "\",\"key\":\"" + dic["SystemKey"].ToString() + "\"},");
                    }                  
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = "[" + sysJson.ToString().TrimEnd(',') + "]"
                    };
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
        }
        #endregion

        #region 添加系统
        private void AddSystem(string syskey)
        {
            string callback = HttpContext.Current.Request["jsoncallback"];
            string addsysname = HttpContext.Current.Request["opersysname"];
            string addsyskey = HttpContext.Current.Request["opersyskey"];
            int schoolid = Convert.ToInt32(HttpContext.Current.Request["schoolid"]); 
            jsonModel = bll.IsNameExists(syskey, addsyskey,0,"SystemKey");//判断系统key是否已存在
            if (jsonModel.errNum == 0)
            {
                if (jsonModel.retData.ToString().ToLower() == "true")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = -1,
                        errMsg = "该系统key已存在",
                        retData = "！"
                    };
                }
                else
                {
                    jsonModel = bll.IsSchoolSysExists(schoolid, addsysname);//根据学校id判断该学校是否已存在同名系统
                    if (jsonModel.errNum == 0)
                    {
                        if (jsonModel.retData.ToString().ToLower() == "true")
                        {
                            jsonModel = new JsonModel()
                            {
                                errNum = -1,
                                errMsg = "该学校已存在同名系统！",
                                retData = ""
                            };
                        }
                        else
                        {
                            Plat_SystemInfo sys = new Plat_SystemInfo();
                            sys.Region = HttpContext.Current.Request["region"];
                            sys.SchoolId = schoolid;
                            sys.SystemName = addsysname;
                            sys.SystemKey = addsyskey;
                            sys.Creator = HttpContext.Current.Request["useridcard"];
                            sys.CreateTime = DateTime.Now;
                            sys.IsDelete = 0;
                            jsonModel = bll.Add(sys);
                        }
                    }
                }
            }
        }
        #endregion

        #region 编辑系统
        private void EditSystem(string syskey)
        {
            string callback = HttpContext.Current.Request["jsoncallback"];
            int itemid = Convert.ToInt32(HttpContext.Current.Request["itemid"]);
            string editsysname = HttpContext.Current.Request["opersysname"];
            string editsyskey = HttpContext.Current.Request["opersyskey"];
            int schoolid = Convert.ToInt32(HttpContext.Current.Request["schoolid"]);
            jsonModel = bll.IsNameExists(syskey, editsyskey, itemid, "SystemKey"); //判断系统key是否已存在
            if (jsonModel.errNum == 0)
            {
                if (jsonModel.retData.ToString().ToLower() == "true")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = -1,
                        errMsg = "该系统key已存在！",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = bll.IsSchoolSysExists(schoolid, editsysname,itemid);//根据学校id判断该学校是否已存在同名系统
                    if (jsonModel.errNum == 0)
                    {
                        if (jsonModel.retData.ToString().ToLower() == "true")
                        {
                            jsonModel = new JsonModel()
                            {
                                errNum = -1,
                                errMsg = "该学校已存在同名系统！",
                                retData = ""
                            };
                        }
                        else
                        {
                            jsonModel = bll.GetEntityById(itemid);
                            if (jsonModel.errNum == 0)
                            {
                                Plat_SystemInfo sys = jsonModel.retData as Plat_SystemInfo;
                                sys.Id = itemid;
                                sys.Region = HttpContext.Current.Request["region"];
                                sys.SchoolId = schoolid;
                                sys.SystemName = editsysname;
                                sys.SystemKey = editsyskey;
                                sys.Editor = HttpContext.Current.Request["useridcard"];
                                sys.EditTime = DateTime.Now;
                                jsonModel = bll.Update(sys);
                            }
                        }
                    }
                }
            }
        }
        #endregion

        #region 删除系统
        private void DeleteSystem(string syskey)
        {
            string callback = HttpContext.Current.Request["jsoncallback"];
            int itemid = Convert.ToInt32(HttpContext.Current.Request["itemid"]);
            jsonModel = bll.GetEntityById(itemid);
            if (jsonModel.errNum == 0)
            {
                Plat_SystemInfo sys = jsonModel.retData as Plat_SystemInfo;
                sys.Id = itemid;
                sys.IsDelete = 1;
                jsonModel = bll.Update(sys);
            }
        }
        #endregion

        #region 根据系统id获取系统实体
        private void GetSystemModelById(string syskey)
        {
            string callback = HttpContext.Current.Request["jsoncallback"];
            int itemid = Convert.ToInt32(HttpContext.Current.Request["itemid"]);
            jsonModel = bll.GetEntityById(itemid);
        }
        #endregion

        public void GetSystemAndSchoolBySysId(HttpContext context) 
        {
            Hashtable ht = new Hashtable();
            if (!string.IsNullOrWhiteSpace(context.Request["SysID"]))
                ht.Add("Id", context.Request["SysID"]);
            if (!string.IsNullOrWhiteSpace(context.Request["SystemKey"]))
                ht.Add("SystemKey", context.Request["SystemKey"]);
            SMModel.JsonModel Model = bll.GetSystemAndSchoolBySysId(ht);
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();

            HttpContext.Current.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
            HttpContext.Current.Response.End();
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