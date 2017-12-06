using SMSBLL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SMSHanderler.Library
{
    /// <summary>
    /// Library 的摘要说明
    /// </summary>
    public class Library : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();

        LibraryMenuService ebll = new LibraryMenuService();
        JsonModel jsonModel = null;
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string FuncName = context.Request["Func"].ToString();
            if (FuncName != null && FuncName != "")
            {
                try
                {
                    switch (FuncName)
                    {
                        case "BindNav":
                            BindNav(context);
                            break;
                        case "GetLibrary":
                            GetLibrary(context);
                            break;
                        case "AddMenu":
                            AddMenu(context);
                            break;
                        case "DelMenu":
                            DelMenu(context);
                            break;
                        case "AddLibrary":
                            AddLibrary(context);
                            break;

                        default:
                            break;
                    }
                }
                catch (Exception ex)
                {
                    string result = "";
                    jsonModel = new JsonModel()
                    {
                        errNum = 400,
                        errMsg = ex.Message,
                        retData = ""
                    };
                    LogService.WriteErrorLog(ex.Message);
                    result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
                    context.Response.Write(result);

                }
            }
            context.Response.End();
        }
        private void GetLibraryByID() { }
        #region 添加知识库
        /// <summary>
        /// 添加知识库
        /// </summary>
        /// <param name="context"></param>
        private void AddLibrary(HttpContext context)
        {
            LibraryListService bll = new LibraryListService();
            string result = "";
            try
            {
                string ID = context.Request["ID"].SafeToString();
                string Key = context.Request["Key"].SafeToString();
                string Content = HttpUtility.UrlDecode(context.Request["Content"]);

                LibraryList modole = new LibraryList();
                modole.Question = Key;
                modole.Answer = Content;
                if (ID != "")
                {
                    modole.ID = int.Parse(ID);
                    jsonModel = bll.Update(modole);
                }
                else
                {
                    jsonModel = bll.Add(modole);
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
        }
        #endregion
        #region 添加/修改导航
        /// <summary>
        /// 添加/修改导航
        /// </summary>
        /// <param name="context"></param>
        private void AddMenu(HttpContext context)
        {
            string result = "";
            try
            {
                string ID = context.Request["ID"].SafeToString();
                string PID = context.Request["PID"].SafeToString();
                string MenuName = context.Request["MenuName"].SafeToString();
                LibraryMenu modole = new LibraryMenu();
                modole.Pid = int.Parse(PID);
                modole.Name = MenuName;
                if (PID == "")
                {
                    modole.ID = int.Parse(ID);
                    jsonModel = ebll.Update(modole);
                }
                else
                {
                    jsonModel = ebll.Add(modole);
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
        }
        #endregion

        #region  删除导航
        /// <summary>
        /// 删除导航
        /// </summary>
        /// <param name="context"></param>
        private void DelMenu(HttpContext context)
        {
            string result = "";
            try
            {
                string MenuID = context.Request["MenuID"].SafeToString();
                string ReturnResult = ebll.DelMenu(MenuID);
                if (ReturnResult == "")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "删除成功",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "删除失败",
                        retData = ""
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
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            //context.Response.Write("[" + ebll.BindtvNodes().TrimEnd(',') + "]");
        }
        #endregion
        private void BindNav(HttpContext context)
        {
            context.Response.Write("[" + ebll.BindtvNodes().TrimEnd(',') + "]");
        }
        #region 获取知识库信息
        /// <summary>
        /// 获取知识库信息
        /// </summary>
        /// <param name="context"></param>
        private void GetLibrary(HttpContext context)
        {
            LibraryListService bll = new LibraryListService();
            string result = "";

            try
            {
                Hashtable ht = new Hashtable();
                bool Ispage = true;
                string ID = context.Request["ID"].SafeToString();
                if (context.Request["Ispage"].SafeToString().Length > 0)
                { Ispage = Convert.ToBoolean(context.Request["Ispage"]); }
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("TableName", "LibraryList");
                string Key = context.Request["Key"].SafeToString();
                string where = "";

                if (ID.Length > 0)
                {
                    where += "and id=" + ID;
                }
                if (Key.Length > 0)
                {
                    where += "and Question='" + Key + "'";
                }
                jsonModel = bll.GetPage(ht, Ispage, where);
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