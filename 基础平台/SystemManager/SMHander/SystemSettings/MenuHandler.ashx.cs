﻿using SMBLL;
using SMModel;
using SMSUtility;
using SMUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;

namespace SMHander.SystemSettings
{
    /// <summary>
    /// MenuHandler 的摘要说明
    /// </summary>
    public class MenuHandler : IHttpHandler
    {
        Plat_MenuInfoService bll = new Plat_MenuInfoService();
        Plat_LogInfoService log = new Plat_LogInfoService();
        StringBuilder orgJson = new StringBuilder();
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        BLLCommon bll_com = new BLLCommon();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string syskey = context.Request["SystemKey"];
            string infkey = context.Request["InfKey"];
            string func = context.Request["func"];
            string loginname = HttpContext.Current.Request["loginname"]??"";
            string idcard = context.Request["useridcard"]; 
            string result = string.Empty;
            string optionType = string.Empty;
            string methodDescrip = string.Empty;
            try
            {
                if (idcard != "00000000000000000X")
                {
                    jsonModel = bll_com.IsHasAuthority(syskey, infkey, func);
                    optionType = ActionConstants.Search;
                    methodDescrip = "判断是否有访问系统方法的权限并返回字段";
                }                
                if (jsonModel.errNum == 0)
                {
                    switch (func)
                    {
                        case "GetLeftNavigationMenu":
                            string retdata = "[" + GetSysLeftNavigationMenu(syskey, idcard).TrimEnd(',') + "]";
                            jsonModel = new JsonModel()
                            {
                                errNum = 0,
                                errMsg = "success",
                                retData = retdata
                            };
                            optionType = ActionConstants.Search;
                            methodDescrip = "获取系统左侧导航菜单";
                            break;
                        case "GetMenuByRoleId":
                            GetSysMenuByRoleId(syskey);
                            optionType = ActionConstants.Search;
                            methodDescrip = "根据角色id获取角色权限";
                            break;
                        case "SetRoleMenu":
                            SetRoleMenu(syskey);
                            optionType = ActionConstants.xg;
                            methodDescrip = "为角色设置菜单信息";
                            break;
                        case "GetSysMenuBySysId":
                            GetSysMenuBySysId(syskey);
                            optionType = ActionConstants.Search;
                            methodDescrip = "根据系统id获取系统菜单";
                            break;
                        case "SetSystemMenu":
                            SetSystemMenu(syskey);
                            optionType = ActionConstants.xg;
                            methodDescrip = "为系统设置菜单信息";
                            break;
                        case "GetMenuByPidAndIDCard":
                            GetMenuByPidAndIDCard(syskey, idcard);
                            optionType = ActionConstants.Search;
                            methodDescrip = "根据pid和身份证号查找菜单";
                            break;
                        case "EditMenuCode":
                            EditMenuCode(syskey);
                            optionType = ActionConstants.xg;
                            methodDescrip = "编辑菜单";
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
                if (!string.IsNullOrEmpty(loginname)){
                    log.WriteLog(LogConstants.menumanage, optionType, "", loginname, methodDescrip + "[" + func + "]");
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
        #region 获取系统左侧导航菜单
        private string GetSysLeftNavigationMenu(string syskey, string idcard, string pid = "0")
        {
            try
            {
                DataTable dt = bll.GetLeftNavigationMenu(syskey, idcard, pid);
                int dtcount = dt.Rows.Count;
                if (dtcount > 0)
                {
                    for (int i = 0; i < dtcount; i++)
                    {
                        DataRow row = dt.Rows[i];
                        orgJson.Append("{\"id\":" + row["Id"].ToString() + ", \"pid\": " + row["Pid"].ToString()
                   + ", \"name\":\"" + row["Name"].ToString() + "\", \"url\":\"" + row["Url"].ToString() + "\",\"children\":[");
                        GetSysLeftNavigationMenu(syskey, idcard, row["Id"].ToString());
                        string endStr = (i + 1) == dtcount ? "]}" : "]},";
                        orgJson.Append(endStr);
                    }
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
            return orgJson.ToString();
        }
        #endregion

        #region 根据角色id获取角色权限
        private void GetSysMenuByRoleId(string syskey)
        {
            try
            {
                string roleid = HttpContext.Current.Request["roleid"] ?? "";
                DataTable perDt = bll.GetPermissionMenu(syskey, roleid);
                StringBuilder menuJson = new StringBuilder();
                foreach (DataRow row in perDt.Rows)
                {
                    menuJson.Append("{\"id\":" + row["Id"].ToString() + ", \"pId\": " + row["Pid"].ToString()
                        + ", \"name\":\"" + row["Name"].ToString() + "\",\"checked\":" + (row["ischeck"].ToString() == "0" ? "false" : "true") + "},");  //
                }
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = "[" + menuJson.ToString().TrimEnd(',') + "]"
                };
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

        #region 为角色设置菜单信息
        private void SetRoleMenu(string syskey)
        {
            try
            {
                string roleid = HttpContext.Current.Request["roleid"] ?? "";
                string nodeids = HttpContext.Current.Request["nodeids"];
                jsonModel = bll.SetRoleMenu(roleid, nodeids);
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

        #region 根据系统id获取系统菜单
        private void GetSysMenuBySysId(string syskey)
        {
            try
            {
                string selSysKey = HttpContext.Current.Request["selsyskey"] ?? "";
                DataTable menuDt = bll.GetSysMenuBySysId(selSysKey);
                StringBuilder menuJson = new StringBuilder();
                foreach (DataRow row in menuDt.Rows)
                {
                    menuJson.Append("{\"id\":" + row["Id"].ToString() + ", \"pId\": " + row["Pid"].ToString()
                        + ", \"name\":\"" + row["Name"].ToString() + "\",\"checked\":" + (row["ischeck"].ToString() == "0" ? "false" : "true") + "},");
                }
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = "[" + menuJson.ToString().TrimEnd(',') + "]"
                };
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

        #region 为系统设置菜单信息
        private void SetSystemMenu(string syskey)
        {
            try
            {
                string selSysKey = HttpContext.Current.Request["selsyskey"] ?? "";
                string nodeids = HttpContext.Current.Request["nodeids"];
                jsonModel = bll.SetSystemMenu(selSysKey, nodeids);
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

        #region 根据pid和身份证号查找菜单
        private void GetMenuByPidAndIDCard(string syskey, string idcard)
        {
            try
            {
                //string pid = HttpContext.Current.Request["pid"] ?? "0";
                string pid = HttpContext.Current.Request["pid"] ?? "";

                jsonModel = bll.GetMenuByPidAndIDCard(syskey, idcard, pid);
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

        #region 编辑菜单
        private void EditMenuCode(string syskey)
        {
            int menuId = Convert.ToInt32(HttpContext.Current.Request["MenuID"]);
            string menuCode = HttpContext.Current.Request["MenuCode"];           
            jsonModel = bll.GetEntityById(menuId);
            if (jsonModel.errNum == 0)
            {
                Plat_MenuInfo menu = jsonModel.retData as Plat_MenuInfo;
                menu.Id = menuId;
                menu.MenuCode = menuCode;
                jsonModel = bll.Update(menu);
            }            
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