using SMBLL;
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

namespace SMHander.SystemSettings
{
    /// <summary>
    /// RoleHandler 的摘要说明
    /// </summary>
    public class RoleHandler : IHttpHandler
    {
        Plat_RoleService bll = new Plat_RoleService();
        Plat_LogInfoService log = new Plat_LogInfoService();
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        BLLCommon bll_com = new BLLCommon();

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
                        case "GetRoleTreeData":
                            GetSysRoleTreeData(syskey, infkey);
                            optionType = ActionConstants.Search;
                            methodDescrip = "获取系统的角色树信息";
                            break;
                        case "GetRoleByUser":
                            GetRoleByUser(syskey, idcard);
                            optionType = ActionConstants.Search;
                            methodDescrip = "获取某用户的角色信息";
                            break;
                        case "AddRole":
                            AddRole(syskey);
                            optionType = ActionConstants.add;
                            methodDescrip = "添加角色";
                            break;
                        case "EditRole":
                            EditRole(syskey);
                            optionType = ActionConstants.xg;
                            methodDescrip = "编辑角色";
                            break;
                        case "DeleteRole":
                            DeleteRole(syskey);
                            optionType = ActionConstants.del;
                            methodDescrip = "删除角色";
                            break;
                        case "GetUserDataByRoleId":
                            GetUserDataByRoleId(syskey);
                            optionType = ActionConstants.Search;
                            methodDescrip = "根据角色id获取角色下的用户";
                            break;
                        case "GetNotDataByRoleId":
                            GetUserDataByRoleId(syskey, " not in ");
                            optionType = ActionConstants.Search;
                            methodDescrip = "根据角色id获取非该角色下的用户列表";
                            break;
                        case "SetRoleMember":
                            SetRoleMember(syskey);
                            optionType = ActionConstants.xg;
                            methodDescrip = "设置角色成员";
                            break;
                        case "DeleteUserRelation":
                            DeleteUserRelation(syskey);
                            optionType = ActionConstants.del;
                            methodDescrip = "将用户移出角色";
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
                if (!string.IsNullOrEmpty(loginname))
                {
                    log.WriteLog(LogConstants.jsgl, optionType, "", loginname, methodDescrip + "[" + func + "]");
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
        #region 获取系统的角色树信息
        private void GetSysRoleTreeData(string syskey, string indentify)
        {
            try
            {
                DataTable roledt = bll.GetAllRoleList(syskey, indentify);
                StringBuilder roleJson = new StringBuilder();
                if (roledt.Rows.Count > 0)
                {
                    for (int i = 0; i < roledt.Rows.Count; i++)
                    {
                        DataRow row = roledt.Rows[i];
                        roleJson.Append("{\"id\":" + row["Id"].ToString() + ", \"pId\": 0, \"name\":\"" + row["Name"].ToString() + "\"},");
                    }
                }
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg ="success",
                    retData = "[" + roleJson.ToString().TrimEnd(',') + "]"
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

        #region
        private void GetRoleByUser(string syskey,string useridcard)
        {
            try
            {
                Hashtable ht = new Hashtable();                
                ht.Add("SystemKey", syskey);
                ht.Add("UserIDCard", useridcard);
                jsonModel = bll.GetRoleByUser(ht);
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

        #region 添加角色
        private void AddRole(string syskey)
        {
            string callback = HttpContext.Current.Request["jsoncallback"];
            string name = HttpContext.Current.Request["name"];
            jsonModel = bll.IsNameExists(syskey, name,0,"Name",true);
            if (jsonModel.errNum == 0)
            {
                if (jsonModel.retData.ToString().ToLower() == "true")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = -1,
                        errMsg = "exist",
                        retData = ""
                    };
                }
                else
                {
                    string useridcard = HttpContext.Current.Request["useridcard"];
                    Plat_Role role = new Plat_Role();
                    role.SystemKey = syskey;
                    role.Name = name;
                    role.Creator = useridcard;
                    role.CreateTime = DateTime.Now;
                    role.IsDelete = 0;
                    jsonModel = bll.Add(role);
                }
            }
        }
        #endregion        

        #region 编辑角色
        private void EditRole(string syskey)
        {
            string callback = HttpContext.Current.Request["jsoncallback"];
            int roleid = Convert.ToInt32(HttpContext.Current.Request["roleid"]);
            string name = HttpContext.Current.Request["name"];
            string useridcard = HttpContext.Current.Request["useridcard"];
            jsonModel = bll.IsNameExists(syskey, name, roleid,"Name",true);
            if (jsonModel.errNum == 0)
            {
                if (jsonModel.retData.ToString().ToLower() == "true")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = -1,
                        errMsg = "exist",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = bll.GetEntityById(roleid);
                    if (jsonModel.errNum == 0)
                    {
                        Plat_Role role = jsonModel.retData as Plat_Role;
                        role.Id = roleid;
                        role.Name = name;
                        role.Editor = useridcard;
                        role.EditTime = DateTime.Now;
                        jsonModel = bll.Update(role);
                    }  
                }
            }
        }
        #endregion

        #region 删除角色
        private void DeleteRole(string syskey)
        {
            string callback = HttpContext.Current.Request["jsoncallback"];
            int roleid = Convert.ToInt32(HttpContext.Current.Request["roleid"]);
            jsonModel = bll.DeleteRole(roleid);
        }
        #endregion

        #region 根据角色id获取角色下的用户
        private void GetUserDataByRoleId(string syskey,string joinStr=" in ")
        {
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrEmpty(HttpContext.Current.Request["name"]))
                {
                    ht.Add("Name", HttpContext.Current.Request["name"].ToString());
                }
                if (!string.IsNullOrEmpty(HttpContext.Current.Request["roleid"]))
                {
                    ht.Add("RoleId", HttpContext.Current.Request["roleid"].ToString());
                    ht.Add("JoinStr", joinStr);
                }
                bool ispage = true;
                if (!string.IsNullOrEmpty(HttpContext.Current.Request["ispage"]))
                {
                    ispage = false;
                }
                ht.Add("SystemKey", syskey);
                ht.Add("PageIndex", HttpContext.Current.Request["PageIndex"]??"1");
                ht.Add("PageSize", HttpContext.Current.Request["PageSize"]??"10");
                jsonModel = new Plat_RoleOfUserService().GetPage(ht,null, ispage);
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

        #region 设置角色成员
        private void SetRoleMember(string syskey)
        {
            try
            {
                string roleid = HttpContext.Current.Request["roleid"] ?? "";
                string idCardStr = HttpContext.Current.Request["idcardStr"];
                jsonModel = bll.SetRoleMember(roleid, idCardStr);
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

        #region 将用户移出角色
        private void DeleteUserRelation(string syskey)
        {
            Plat_RoleOfUser ruser = new Plat_RoleOfUser();
            ruser.RoleId=Convert.ToInt32(HttpContext.Current.Request["roleid"]);
            ruser.UserIDCard = HttpContext.Current.Request["deluseridcard"];
            jsonModel = new Plat_RoleOfUserService().DeleteUserRelation(ruser);
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