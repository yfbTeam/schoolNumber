using SMSBLL;
using SMSUtility;
using SMSUtility.FusionChart;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;

namespace SMSHanderler.PortalManage
{
    /// <summary>
    /// AdminManager 的摘要说明
    /// </summary>
    public class AdminManager : IHttpHandler
    {
        AdminManagerService BllAMS = new AdminManagerService();
        SMSBLL.PortalTreeDataService BllPTDS = new PortalTreeDataService();
        SMSBLL.DBBackUpLogService BllDULS = new DBBackUpLogService();
        SMSBLL.WebEnteredService BllWES = new WebEnteredService();
        SMSBLL.System_DictionaryService BllSDS = new System_DictionaryService();
        SMSBLL.System_LinkService BllLS = new System_LinkService();
        SMSBLL.PortalMenuDroitService BllPMDS = new PortalMenuDroitService();
        SMSBLL.CourseService BllCS = new SMSBLL.CourseService();
        FusionCharPublicClass fusionCharPulic = new FusionCharPublicClass();
        SMSBLL.System_FavoritesService BllSFS = new System_FavoritesService();
        SMSBLL.FinanceDetailService BllFDS = new FinanceDetailService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request["func"];
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "GetLeftNavigationMenu": GetLeftNavigationMenu(context); break;
                    case "GetNavigationMenu": GetNavigationMenu(context); break;
                    case "EditPortalTreeData": EditPortalTreeData(context); break;
                    case "UpdatePortalTreeData": UpdatePortalTreeData(context); break;
                    case "GetPortalTreeData": GetPortalTreeData(context); break;
                    case "GetBeforeMenu": GetBeforeMenu(context); break;
                    case "GetDbBackUpPageList": GetDbBackUpPageList(context); break;
                    case "GetPortalTreeDataForChildId": GetPortalTreeDataForChildId(context); break;
                    case "GetWebEnteredList": GetWebEnteredList(context); break;
                    case "AddWebEntered": AddWebEntered(context); break;
                    case "UpdateWebEnterd": UpdateWebEnterd(context); break;
                    case "GetWebEntered": GetWebEntered(context); break;
                    case "GetDictionaryList": GetDictionaryList(context); break;
                    case "UpdateDictionary": UpdateDictionary(context); break;
                    case "GetDictionary": GetDictionary(context); break;
                    case "EditDictionary": EditDictionary(context); break;
                    case "GetLinkList": GetLinkList(context); break;
                    case "UpdateLink": UpdateLink(context); break;
                    case "GetLink": GetLink(context); break;
                    case "EditLink": EditLink(context); break;
                    case "AddUserInfoForMenu": AddUserInfoForMenu(context); break;
                    case "GetUserInfoList": GetUserInfoList(context); break;
                    case "GetParentMenu": GetParentMenu(context); break;
                    case "UpdatePortalMenuDroit": UpdatePortalMenuDroit(context); break;
                    case "QueryUserisRoot": QueryUserisRoot(context); break;
                    case "GetCoursePageList": GetCoursePageList(context); break;
                    case "QueryCourseChart": QueryCourseChart(context); break;
                    case "QueryCourseEchart": QueryCourseEchart(context); break;
                    case "GetThisWebList": GetThisWebList(context); break;
                    case "GetThisWebPageList": GetThisWebPageList(context); break;
                    case "QueryCourseHistory": QueryCourseHistory(context); break;
                    case "QueryCourseChartForWebSite": QueryCourseChartForWebSite(context); break;
                    case "QueryCourseEchartForWebSite": QueryCourseEchartForWebSite(context); break;
                    case "QueryCertificateForCourse": QueryCertificateForCourse(context); break;
                    case "AddFavorites": AddFavorites(context); break;
                    case "GetPageFavoritesList": GetPageFavoritesList(context); break;
                    case "DelFavorites": DelFavorites(context); break;
                    case "GetCostPageList": GetCostPageList(context); break;
                    case "QueryCostChart": QueryCostChart(context); break;
                    case "QueryCostEchart": QueryCostEchart(context); break;
                }
            }
            else
            {
                context.Response.Write("System Error");
            }
        }

        /// <summary>
        /// 门户后台左侧菜单
        /// </summary>
        /// <param name="context"></param>
        public void GetLeftNavigationMenu(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                bool isParam = false;
                if (!string.IsNullOrWhiteSpace(Convert.ToString(context.Request["Display"])))
                    ht.Add("Display", context.Request["Display"]);
                if (!string.IsNullOrWhiteSpace(Convert.ToString(context.Request["IsDelete"])))
                    ht.Add("IsDelete", context.Request["IsDelete"]);
                if (!string.IsNullOrWhiteSpace(Convert.ToString(context.Request["BeforeAfter"])))
                    ht.Add("BeforeAfter", context.Request["BeforeAfter"]);
                if (!string.IsNullOrWhiteSpace(context.Request["isParam"])) isParam = Convert.ToBoolean(context.Request["isParam"]);
                string creator = context.Request["Creator"];
                DataTable dt = BllAMS.GetLeftNavigationMenu(ht);
                List<int> menuRoot = CurrentUserForRoot(creator);
                StringBuilder orgJson = new StringBuilder();
                DataRow[] parMenu = null;
                if (!string.IsNullOrWhiteSpace(Convert.ToString(context.Request["Display"])))
                    parMenu = dt.Select("PId=0 and Display=" + context.Request["Display"]);
                else
                    parMenu = dt.Select("PId=0");
                #region
                for (int i = 0; i < parMenu.Count(); i++)
                {
                    if (menuRoot != null && menuRoot.Count > 0)
                    {
                        if (!menuRoot.Contains(Convert.ToInt32(parMenu[i]["Id"])))
                        {
                            continue;
                        }
                    }
                    orgJson.Append("<li>");
                    orgJson.Append("<a class='menuclick' href='#'>" + parMenu[i]["Name"] + "<span class='iconfont icon-icoxiala'></span></a>");
                    DataRow[] subMenu = null;
                    if (!string.IsNullOrWhiteSpace(Convert.ToString(context.Request["Display"])))
                        subMenu = dt.Select(" PId=" + parMenu[i]["Id"] + "and Display=" + context.Request["Display"]);
                    else
                        subMenu = dt.Select(" PId=" + parMenu[i]["Id"]);
                    orgJson.Append("<ul class='submenu' style='display:none;'>");
                    for (int j = 0; j < subMenu.Count(); j++)
                    {
                        string url = string.Empty;
                        if (Convert.ToInt32(subMenu[j]["BeforeAfter"]) == (int)BeforeAfter.前后台展示)
                        {
                            switch (Convert.ToInt32(context.Request["BeforeAfter"]))
                            {
                                case (int)BeforeAfter.前台展示:
                                    url = (subMenu[j]["BeforeUrl"]).ToString();
                                    break;
                                case (int)BeforeAfter.后台展示:
                                    url = (subMenu[j]["AfterUrl"]).ToString();
                                    break;
                            }
                        }
                        else if (Convert.ToInt32(context.Request["BeforeAfter"]) == (int)BeforeAfter.前台展示)
                        {
                            url = (subMenu[j]["BeforeUrl"]).ToString();
                        }
                        else if (Convert.ToInt32(context.Request["BeforeAfter"]) == (int)BeforeAfter.后台展示)
                        {
                            url = (subMenu[j]["AfterUrl"]).ToString();
                        }
                        if (isParam)
                        {
                            if (url.IndexOf("?") > -1)
                                url += "&";
                            else
                                url += "?";
                            url += "title=" + subMenu[j]["Name"] + "&ptitle=" + parMenu[i]["Name"];
                        }
                        orgJson.Append("<li><a href='javascript:void(0);' data-src='" + url + "'>" + subMenu[j]["Name"] + "</a></li>");
                    }
                    orgJson.Append("</ul>");
                    orgJson.Append("</li>");
                }
                #endregion
                //输出Json
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = orgJson.ToString(),
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }

        }

        /// <summary>
        /// 菜单管理中菜单
        /// </summary>
        /// <param name="context"></param>
        public void GetNavigationMenu(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {

                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(Convert.ToString(context.Request["Display"])))
                    ht.Add("Display", context.Request["Display"]);
                if (!string.IsNullOrWhiteSpace(Convert.ToString(context.Request["IsDelete"])))
                    ht.Add("IsDelete", context.Request["IsDelete"]);
                if (!string.IsNullOrWhiteSpace(Convert.ToString(context.Request["BeforeAfter"])))
                    ht.Add("BeforeAfter", context.Request["BeforeAfter"]);
                DataTable dt = BllAMS.GetLeftNavigationMenu(ht);
                List<string> list = new List<string>();
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errNum = 0,
                    errMsg = "success"
                };
                if (dt != null && dt.Rows.Count > 0)
                {
                    list.Add(new BLLCommon().DataTableToJson(dt));
                    jsonModel.retData = list;
                }
                else
                {
                    jsonModel.retData = null;
                }
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {

                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        /// <summary>
        /// 门户前台首页顶部菜单
        /// </summary>
        /// <param name="context"></param>
        public void GetBeforeMenu(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(Convert.ToString(context.Request["Display"])))
                    ht.Add("Display", context.Request["Display"]);
                if (!string.IsNullOrWhiteSpace(Convert.ToString(context.Request["IsDelete"])))
                    ht.Add("IsDelete", context.Request["IsDelete"]);
                if (!string.IsNullOrWhiteSpace(Convert.ToString(context.Request["BeforeAfter"])))
                    ht.Add("BeforeAfter", context.Request["BeforeAfter"]);
                DataTable dt = BllAMS.GetLeftNavigationMenu(ht);
                StringBuilder orgJson = new StringBuilder();
                DataRow[] parMenu = null;
                if (!string.IsNullOrWhiteSpace(Convert.ToString(context.Request["Display"])))
                    parMenu = dt.Select("PId=0 and Id<>40 and Display=" + context.Request["Display"], "SortId desc");
                else
                    parMenu = dt.Select("PId=0 and Id<>40", "SortId desc");
                #region
                for (int i = 0; i < parMenu.Count(); i++)
                {
                    string parUrl = string.Empty;
                    if (Convert.ToInt32(parMenu[i]["BeforeAfter"]) == (int)BeforeAfter.前后台展示)
                    {
                        switch (Convert.ToInt32(context.Request["BeforeAfter"]))
                        {
                            case (int)BeforeAfter.前台展示:
                                parUrl = (parMenu[i]["BeforeUrl"]).ToString();
                                break;
                            case (int)BeforeAfter.后台展示:
                                parUrl = (parMenu[i]["AfterUrl"]).ToString();
                                break;
                        }
                    }
                    else if (Convert.ToInt32(context.Request["BeforeAfter"]) == (int)BeforeAfter.前台展示)
                    {
                        parUrl = (parMenu[i]["BeforeUrl"]).ToString();
                    }
                    else if (Convert.ToInt32(context.Request["BeforeAfter"]) == (int)BeforeAfter.后台展示)
                    {
                        parUrl = (parMenu[i]["AfterUrl"]).ToString();
                    }
                    orgJson.Append("<li> <dl class='xiala'><dt><a href='#'  onclick=ResponstUrl('" + parUrl + "')>" + parMenu[i]["Name"] + "</a><em></em></dt><dd><div class='lie'><ul class='liea'>");
                    DataRow[] subMenu = dt.Select(" PId=" + (parMenu[i]["Id"]).ToString() + " and Display=" + context.Request["Display"]);
                    for (int j = 0; j < subMenu.Count(); j++)
                    {
                        string url = string.Empty;
                        if (Convert.ToInt32(subMenu[j]["BeforeAfter"]) == (int)BeforeAfter.前后台展示)
                        {
                            switch (Convert.ToInt32(context.Request["BeforeAfter"]))
                            {
                                case (int)BeforeAfter.前台展示:
                                    url = (subMenu[j]["BeforeUrl"]).ToString();
                                    break;
                                case (int)BeforeAfter.后台展示:
                                    url = (subMenu[j]["AfterUrl"]).ToString();
                                    break;
                            }
                        }
                        else if (Convert.ToInt32(context.Request["BeforeAfter"]) == (int)BeforeAfter.前台展示)
                        {
                            url = (subMenu[j]["BeforeUrl"]).ToString();
                        }
                        else if (Convert.ToInt32(context.Request["BeforeAfter"]) == (int)BeforeAfter.后台展示)
                        {
                            url = (subMenu[j]["AfterUrl"]).ToString();
                        }
                        orgJson.Append("<li><a href='#' onclick=ResponstUrl('" + url + "')>" + subMenu[j]["Name"] + "</a></li>");
                    }
                    orgJson.Append("</ul></div>  </dd></dl> </li>");
                }



                #endregion

                //特殊节点
                DataRow[] drSpecial = null;
                drSpecial = dt.Select("PId=0 and Id=40");
                for (int i = 0; i < drSpecial.Count(); i++)
                {

                    DataRow[] subMenu = dt.Select(" PId=" + (drSpecial[i]["Id"]).ToString() + " and Display=" + context.Request["Display"]);
                    for (int j = 0; j < subMenu.Count(); j++)
                    {

                        orgJson.Append("<li> <dl class='xiala'><dt><a href='#'  onclick=ResponstUrl('" + subMenu[j]["BeforeUrl"] + "')>" + subMenu[j]["Name"] + "</a><em></em></dt><dd><div class='lie'><ul class='liea'>");
                        orgJson.Append("</ul></div>  </dd></dl> </li>");
                    }
                }

                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = orgJson.ToString(),
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");

            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void GetParentMenu(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "PortalTreeData");
                string where = "and (BeforeAfter=" + (int)BeforeAfter.后台展示 + " or BeforeAfter=" + (int)BeforeAfter.前后台展示 + ") and PId=0 and Display=" + (int)Display.显示 + " and  IsDelete!=" + (int)SysStatus.删除;
                ht.Add("CreateTime", " SortId desc");
                SMSModel.JsonModel Model = BllLS.GetPage(ht, false, where);
                context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }


        public void GetPortalTreeData(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    SMSModel.JsonModel jsonModel = BllPTDS.GetEntityById(int.Parse(context.Request["Id"]));
                    context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
                }
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }
        public void EditPortalTreeData(HttpContext context)
        {
            SMSModel.JsonModel jsonModel = new SMSModel.JsonModel();
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            using (SqlTransaction trans = SQLHelp.BeginTransaction())
            {
                try
                {
                    string Name = context.Request["Name"];
                    string Display = context.Request["Display"];
                    string BeforeUrl = context.Request["BeforeUrl"];
                    string BeforeAfter = context.Request["BeforeAfter"];
                    string AfterUrl = context.Request["AfterUrl"];
                    string SortId = context.Request["SortId"];
                    string EnName = context.Request["EnName"];
                    SMSModel.PortalTreeData ptd = new SMSModel.PortalTreeData();
                    ptd.Name = Name;
                    ptd.EnName = EnName;
                    ptd.Display = Convert.ToByte(Display);
                    ptd.BeforeAfter = int.Parse(BeforeAfter);

                    ptd.SortId = string.IsNullOrWhiteSpace(SortId) ? 0 : int.Parse(SortId);
                    if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                    {
                        ptd.BeforeUrl = BeforeUrl;
                        ptd.AfterUrl = AfterUrl;
                        Hashtable ht = new Hashtable();
                        ptd.Id = int.Parse(context.Request["Id"]);
                        jsonModel = BllPTDS.Update(ptd, trans);
                        //List<SMSModel.PortalTreeData> childItem = BllPTDS.GetEntityListByField("PId", context.Request["Id"]).retData as List<SMSModel.PortalTreeData>;
                        ht.Add("Id", context.Request["Id"]);
                        DataTable childTb = BllAMS.GetPortalTreeData(ht, trans);
                        if (childTb != null && childTb.Rows.Count > 0)
                        {

                            if (!string.IsNullOrWhiteSpace(Display)) ht.Add("Display", Display);
                            string ids = "";
                            foreach (DataRow row in childTb.Rows)
                            {
                                ids += row["Id"].ToString() + ",";
                            }
                            if (ids != "")
                            {
                                ids = ids.Substring(0, ids.Length - 1);
                                ht.Add("ids", ids);
                            }
                            int number = BllAMS.UpdatePortalTreeData(ht, trans);
                            if (number < 1)
                            {
                                trans.Rollback();
                            }
                        }
                        trans.Commit();
                    }
                    else
                    {

                        ptd.Creator = context.Request["Creator"];
                        ptd.CreateTime = DateTime.Now;
                        ptd.IsDelete = (int)SysStatus.正常;
                        ptd.PId = int.Parse(context.Request["PId"]);
                        jsonModel = BllPTDS.Add(ptd);
                        SMSModel.JsonModel jmItem = BllPTDS.GetEntityById(Convert.ToInt32(jsonModel.retData));
                        if (jmItem != null)
                        {
                            SMSModel.PortalTreeData ptData = jmItem.retData as SMSModel.PortalTreeData;
                            if (ptData != null)
                            {
                                ptData.BeforeUrl = "/Portal/about/BeforeView.aspx?id=" + jsonModel.retData.ToString();
                                ptData.AfterUrl = "/Portal/about/AfterEdit.aspx?id=" + jsonModel.retData.ToString();
                                ptData.Id = int.Parse(jsonModel.retData.ToString());
                                SMSModel.JsonModel upJm = BllPTDS.Update(ptData, trans);
                            }
                        }
                        trans.Commit();
                    }
                    context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    jsonModel = new SMSModel.JsonModel()
                    {
                        errMsg = ex.Message,
                    };
                    context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
                }
            }
        }

        public void UpdatePortalTreeData(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {

                    SMSModel.PortalTreeData ptd = BllPTDS.GetEntityById(int.Parse(context.Request["Id"])).retData as SMSModel.PortalTreeData;
                    if (ptd != null)
                    {
                        if (!string.IsNullOrWhiteSpace(context.Request["Name"]))
                            ptd.Name = context.Request["Name"];
                        if (!string.IsNullOrWhiteSpace(context.Request["IsDelete"]))
                            ptd.IsDelete = Convert.ToByte(context.Request["IsDelete"]);
                        SMSModel.JsonModel jsonModel = BllPTDS.Update(ptd);
                        context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
                    }
                    else
                    {
                        SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                        {
                            errMsg = "null",
                        };
                        context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
                    }
                }
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }

        }

        public void GetDbBackUpPageList(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                ht.Add("PageSize", context.Request["PageSize"].ToString());
                ht.Add("TableName", "DBBackUpLog");
                string where = string.Empty;
                if (!string.IsNullOrWhiteSpace(context.Request["type"]))
                    where += " and [Type]=" + context.Request["type"].ToString();
                if (!string.IsNullOrWhiteSpace(context.Request["StarDate"]) && !string.IsNullOrWhiteSpace(context.Request["EndDate"]))
                    where += " and ([CreateTime]>='" + context.Request["StarDate"].ToString() + " 00:00:00' and [CreateTime]<='" + context.Request["EndDate"].ToString() + " 23:59:59')";
                ht.Add("Order", " CreateTime desc");
                SMSModel.JsonModel Model = BllDULS.GetPage(ht, true, where);
                context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void GetPortalTreeDataForChildId(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(context.Request["MenuId"]))
                    ht.Add("Id", context.Request["MenuId"]);
                SMSModel.JsonModel jsonModel = BllAMS.GetPortalTreeDataForChildId(ht);
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void GetWebEnteredList(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) ht.Add("PageSize", context.Request["PageSize"].ToString());
                ht.Add("TableName", "WebEntered");
                string where = "";
                if (!string.IsNullOrWhiteSpace(context.Request["Status"]))
                    where += " and [Status]=" + context.Request["Status"].ToString();
                if (!string.IsNullOrWhiteSpace(context.Request["StarDate"]) && !string.IsNullOrWhiteSpace(context.Request["EndDate"]))
                    where += " and ([CreateTime]>='" + context.Request["StarDate"].ToString() + " 00:00:00' and [CreateTime]<='" + context.Request["EndDate"].ToString() + " 23:59:59')";
                where += " and IsDelete!=" + (int)SysStatus.删除;
                ht.Add("Order", " CreateTime desc");
                SMSModel.JsonModel Model = BllDULS.GetPage(ht, true, where);
                context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }


        }

        public void AddWebEntered(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                string name = context.Request["Name"];
                string sex = context.Request["Sex"];
                string Age = context.Request["Age"];
                string Roots = context.Request["Roots"];
                string IDCard = context.Request["IDCard"];
                string Phone = context.Request["Phone"];
                string Address = context.Request["Address"];
                string Job = context.Request["Job"];
                SMSModel.WebEntered model = new SMSModel.WebEntered();
                model.Address = Address;
                model.Age = int.Parse(Age);
                model.CreateTime = DateTime.Now;
                model.IDCard = IDCard;
                model.IsDelete = (int)SysStatus.正常;
                model.Job = Job;
                model.Name = name;
                model.Phone = Phone;
                model.Roots = Roots;
                model.Sex = int.Parse(sex);
                model.Status = (int)EnteredStatus.已申请;
                SMSModel.JsonModel jsModel = BllWES.Add(model);
                context.Response.Write("{\"result\":" + jss.Serialize(jsModel) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void UpdateWebEnterd(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    SMSModel.WebEntered ptd = BllWES.GetEntityById(int.Parse(context.Request["Id"])).retData as SMSModel.WebEntered;
                    if (!string.IsNullOrWhiteSpace(context.Request["Status"]))
                        ptd.Status = int.Parse(context.Request["Status"]);
                    if (!string.IsNullOrWhiteSpace(context.Request["IsDelete"]))
                        ptd.IsDelete = Convert.ToByte(context.Request["IsDelete"]);
                    SMSModel.JsonModel jsonModel = BllWES.Update(ptd);
                    context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
                }
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void GetWebEntered(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    SMSModel.JsonModel jsonModel = BllWES.GetEntityById(int.Parse(context.Request["Id"]));
                    context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
                }
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void GetDictionaryList(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) ht.Add("PageSize", context.Request["PageSize"].ToString());
                ht.Add("TableName", "System_Dictionary");
                string where = "";
                if (!string.IsNullOrWhiteSpace(context.Request["Type"]))
                    where += " and [Type]=" + context.Request["Type"].ToString();
                if (!string.IsNullOrWhiteSpace(context.Request["StarDate"]) && !string.IsNullOrWhiteSpace(context.Request["EndDate"]))
                    where += " and ([CreateTime]>='" + context.Request["StarDate"].ToString() + " 00:00:00' and [CreateTime]<='" + context.Request["EndDate"].ToString() + " 23:59:59')";
                where += " and IsDelete!=" + (int)SysStatus.删除;
                ht.Add("Order", " CreateTime desc");
                SMSModel.JsonModel Model = BllSDS.GetPage(ht, true, where);
                context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void UpdateDictionary(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    SMSModel.System_Dictionary ptd = BllSDS.GetEntityById(int.Parse(context.Request["Id"])).retData as SMSModel.System_Dictionary;
                    if (!string.IsNullOrWhiteSpace(context.Request["IsDelete"]))
                        ptd.IsDelete = Convert.ToByte(context.Request["IsDelete"]);
                    SMSModel.JsonModel jsonModel = BllSDS.Update(ptd);
                    context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
                }
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void GetDictionary(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    SMSModel.JsonModel jsonModel = BllSDS.GetEntityById(int.Parse(context.Request["Id"]));
                    context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
                }
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void EditDictionary(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            SMSModel.JsonModel jsonModel = new SMSModel.JsonModel();
            try
            {
                string Id = context.Request["Id"];
                string Title = context.Request["Title"];
                string ImageUrl = context.Request["ImageUrl"];
                string Type = context.Request["Type"];
                SMSModel.System_Dictionary sd = new SMSModel.System_Dictionary();
                sd.Title = Title;
                sd.ImageUrl = ImageUrl;
                sd.Type = int.Parse(Type);
                if (!string.IsNullOrWhiteSpace(Id))
                {

                    sd.Id = int.Parse(Id);
                    jsonModel = BllSDS.Update(sd);
                }
                else
                {
                    sd.CreateTime = DateTime.Now;
                    sd.IsDelete = (int)SysStatus.正常;
                    jsonModel = BllSDS.Add(sd);
                }
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                jsonModel.errMsg = ex.Message;
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void GetLinkList(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) ht.Add("PageSize", context.Request["PageSize"].ToString());
                ht.Add("TableName", "System_Link");
                string where = "";
                if (!string.IsNullOrWhiteSpace(context.Request["StarDate"]) && !string.IsNullOrWhiteSpace(context.Request["EndDate"]))
                    where += " and ([CreateTime]>='" + context.Request["StarDate"].ToString() + " 00:00:00' and [CreateTime]<='" + context.Request["EndDate"].ToString() + " 23:59:59')";
                where += " and IsDelete!=" + (int)SysStatus.删除;
                ht.Add("Order", " SortId desc");
                SMSModel.JsonModel Model = BllLS.GetPage(ht, true, where);
                context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void UpdateLink(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    SMSModel.System_Link ptd = BllLS.GetEntityById(int.Parse(context.Request["Id"])).retData as SMSModel.System_Link;
                    if (!string.IsNullOrWhiteSpace(context.Request["IsDelete"]))
                        ptd.IsDelete = Convert.ToByte(context.Request["IsDelete"]);
                    SMSModel.JsonModel jsonModel = BllLS.Update(ptd);
                    context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
                }
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void GetLink(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    SMSModel.JsonModel jsonModel = BllLS.GetEntityById(int.Parse(context.Request["Id"]));
                    context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
                }
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void EditLink(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            SMSModel.JsonModel jsonModel = new SMSModel.JsonModel();
            try
            {
                string Id = context.Request["Id"];
                string Title = context.Request["Title"];
                string ImageUrl = context.Request["ImageUrl"];
                string SortId = context.Request["SortId"];
                string Href = context.Request["Href"];
                SMSModel.System_Link sd = new SMSModel.System_Link();
                sd.Title = Title;
                sd.ImageUrl = ImageUrl;
                sd.SortId = int.Parse(SortId);
                sd.Href = Href;
                if (!string.IsNullOrWhiteSpace(Id))
                {
                    sd.Id = int.Parse(Id);
                    jsonModel = BllLS.Update(sd);
                }
                else
                {
                    sd.CreateTime = DateTime.Now;
                    sd.IsDelete = (int)SysStatus.正常;
                    jsonModel = BllLS.Add(sd);
                }
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                jsonModel.errMsg = ex.Message;
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void GetUserInfoList(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                bool isPage = true;
                if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) ht.Add("PageSize", context.Request["PageSize"].ToString());
                if (!string.IsNullOrWhiteSpace(context.Request["isPage"])) isPage = Convert.ToBoolean(context.Request["isPage"]);
                ht.Add("TableName", "PortalMenuDroit");
                string where = "";
                if (!string.IsNullOrWhiteSpace(context.Request["MenuId"]) && !string.IsNullOrWhiteSpace(context.Request["MenuId"]))
                    where += " and MenuId=" + context.Request["MenuId"];
                if (!string.IsNullOrWhiteSpace(context.Request["Name"]) && !string.IsNullOrWhiteSpace(context.Request["Name"]))
                    where += " and [Name]+LoginName like '%" + context.Request["Name"] + "%'";
                where += " and IsDelete!=" + (int)SysStatus.删除;
                ht.Add("CreateTime", " SortId desc");
                SMSModel.JsonModel Model = BllLS.GetPage(ht, isPage, where);
                context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void AddUserInfoForMenu(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            SMSModel.JsonModel jsonModel = new SMSModel.JsonModel();
            try
            {
                string users = context.Request["Users"];
                if (!string.IsNullOrWhiteSpace(users))
                {
                    List<SMSModel.PortalMenuDroit> list = jss.Deserialize<List<SMSModel.PortalMenuDroit>>(users);
                    if (list != null && list.Count > 0)
                    {
                        jsonModel = BllAMS.AddUserInfos(list);
                        context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
                    }
                }

            }
            catch (Exception ex)
            {
                jsonModel.errMsg = ex.Message;
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void UpdatePortalMenuDroit(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    SMSModel.PortalMenuDroit ptd = BllPMDS.GetEntityById(int.Parse(context.Request["Id"])).retData as SMSModel.PortalMenuDroit;
                    if (!string.IsNullOrWhiteSpace(context.Request["IsDelete"]))
                        ptd.IsDelete = Convert.ToByte(context.Request["IsDelete"]);
                    SMSModel.JsonModel jsonModel = BllPMDS.Update(ptd);
                    context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
                }
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public List<int> CurrentUserForRoot(string creator)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "PortalMenuDroit");
                string where = " and LoginName='" + creator + "'";
                where += " and IsDelete!=" + (int)SysStatus.删除;
                ht.Add("Order", "CreateTime,SortId desc");
                DataTable dt = BllLS.GetData(ht, false, where);
                List<int> items = new List<int>();
                foreach (DataRow row in dt.Rows)
                {
                    items.Add(Convert.ToInt32(row["MenuId"]));
                }
                return items;
            }
            catch (Exception ex)
            {
                return null;
            }

        }

        public void QueryUserisRoot(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                if (!string.IsNullOrWhiteSpace(context.Request["LoginName"]))
                {
                    Hashtable ht = new Hashtable();
                    ht.Add("TableName", "PortalMenuDroit");
                    string where = " and LoginName='" + context.Request["LoginName"] + "'";
                    where += " and IsDelete!=" + (int)SysStatus.删除;
                    ht.Add("CreateTime", " SortId desc");
                    SMSModel.JsonModel Model = BllLS.GetPage(ht, false, where);
                    context.Response.Write("{\"result\":" + jss.Serialize(Model) + "}");
                }
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void GetCoursePageList(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            SMSModel.JsonModel jsonModel = new SMSModel.JsonModel();
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("TableName", "Course");
                string where = string.Empty;
                //if (!string.IsNullOrWhiteSpace(context.Request["CourseType"]))
                //{
                //    where += " and CourseType=" + context.Request["CourseType"];
                //}
                ht.Add("CourseType", context.Request["CourseType"]);
                ht.Add("IsCharge", context.Request["IsCharge"]);
                bool Ispage = true;
                if (!string.IsNullOrWhiteSpace(context.Request["Ispage"]))
                {
                    Ispage = Convert.ToBoolean(context.Request["Ispage"]);
                }
                jsonModel = BllCS.GetPage(ht, Ispage);
            }
            catch (Exception ex)
            {
                jsonModel.errMsg = ex.Message;
            }
            context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
        }

        protected void QueryCourseChart(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                string isload = context.Request["FirstLoad"];
                if (!string.IsNullOrWhiteSpace(context.Request["CourseType"]))
                    ht.Add("CourseType", context.Request["CourseType"]);
                if (!string.IsNullOrWhiteSpace(context.Request["IsCharge"]))
                    ht.Add("IsCharge", context.Request["IsCharge"]);
                int rows = 0;

                DataTable dt = BllAMS.GetCourseForStatisc(ht);
                chart c = new chart();
                c.Caption = "访问率分析饼图";
                c.ShowValues = "0";
                c.ShowLegend = "1";
                c.LegendPosition = "RIGHT";
                c.ChartRightmargin = "0";
                c.Bgcolor = "ECF5FF";
                c.Bgalpha = "70";
                c.CanvasBorderColor = "C6D2DF";
                c.BaseFontColor = "2F2F2F";
                c.Basefontsize = "11";
                c.Showpercentvalues = "1";
                c.Bgratio = "0";
                c.Startingangle = "200";
                c.Animation = "1";
                c.HowLables = "0";

                style s = new style();
                s.Name = "myCaptionFont";
                s.Type = "font";
                s.Font = "Arial";
                s.Size = "14";
                s.Bold = "1";
                s.Underline = "1";
                s.ToObject = "Caption";
                style s1 = new style();
                s1.Name = "myCaptionFont1";
                s1.Type = "font";
                s1.Font = "Arial";
                s1.Size = "12";
                s1.Bold = "1";
                s1.Underline = "0";
                s1.ToObject = "QUADRANTLABELS";
                style s2 = new style();
                s2.Name = "myCaptionFont2";
                s2.Type = "font";
                s2.Color = "00ff00";
                s2.ToObject = "TRENDVALUES";
                IList<style> slist = new List<style>();
                slist.Add(s);
                slist.Add(s1);
                slist.Add(s2);
                FusionChartType chartType = FusionChartType.Pie3D;

                string chartString = fusionCharPulic.GetXMLData(dt, c, null, slist, chartType, null, "VisitCourse", "866", "300", isload);
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = "success",
                    errNum = 0,
                    retData = chartString
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }


        }

        public void QueryCourseEchart(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                string isload = context.Request["FirstLoad"];
                if (!string.IsNullOrWhiteSpace(context.Request["CourseType"]))
                    ht.Add("CourseType", context.Request["CourseType"]);
                if (!string.IsNullOrWhiteSpace(context.Request["IsCharge"]))
                    ht.Add("IsCharge", context.Request["IsCharge"]);
                SMSModel.JsonModel jsonModel = BllAMS.GetCourseForStatiscByEchart(ht);
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void GetThisWebList(HttpContext context) 
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            SMSModel.JsonModel jsonModel = new SMSModel.JsonModel();
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("TableName", "Course");
                string where = string.Empty;
                ht.Add("CourseType", context.Request["CourseType"]);
                jsonModel = BllAMS.GetThisWebList(ht);
            }
            catch (Exception ex)
            {
                jsonModel.errMsg = ex.Message;
                jsonModel.errNum = 400;
            }
            context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
        }

        public void GetThisWebPageList(HttpContext context) 
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            SMSModel.JsonModel jsonModel = new SMSModel.JsonModel();
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("TableName", "Course");
                string where = string.Empty;
                ht.Add("CourseType", context.Request["CourseType"]);
                jsonModel = BllAMS.GetThisWebPageList(ht);
            }
            catch (Exception ex)
            {
                jsonModel.errMsg = ex.Message;
                jsonModel.errNum = 400;
            }
            context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
        }

        public void QueryCourseHistory(HttpContext context) 
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            SMSModel.JsonModel jsonModel = new SMSModel.JsonModel();
            Hashtable ht = new Hashtable();
            try
            {
                if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("TableName", "Course");
                string type = context.Request["type"];
                string where = string.Empty;
                switch (type)
                {
                    case "0":
                        //where+=" and Boutique=1";//精品
                        ht.Add("Boutique", 1);
                        break;
                    case "1":
                        //where+=" and ClickNum>=10";//热门
                        ht.Add("MaxClickNum", 10);
                        break;
                    case "2":
                        //where+=" and CreateTime>=" + DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd") + "00:00:01";
                        ht.Add("RecentlyTime", DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd") + "00:00:01");
                        break;
                }
                ht.Add("Order ", "CreateTime desc ");
                jsonModel = BllCS.GetPage(ht, true, where);
                
            }
            catch (Exception ex)
            {
                jsonModel.errMsg = ex.Message;
                jsonModel.errNum = 400;
            }
            context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
        }

        protected void QueryCourseChartForWebSite(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                string isload = context.Request["FirstLoad"];
                if (!string.IsNullOrWhiteSpace(context.Request["CourseType"]))
                    ht.Add("CourseType", context.Request["CourseType"]);
                int rows = 0;

                DataTable dt = BllAMS.QueryCourseChartForWebSite(ht);
                chart c = new chart();
                c.Caption = "访问率分析饼图";
                c.ShowValues = "0";
                c.ShowLegend = "1";
                c.LegendPosition = "RIGHT";
                c.ChartRightmargin = "0";
                c.Bgcolor = "ECF5FF";
                c.Bgalpha = "70";
                c.CanvasBorderColor = "C6D2DF";
                c.BaseFontColor = "2F2F2F";
                c.Basefontsize = "11";
                c.Showpercentvalues = "1";
                c.Bgratio = "0";
                c.Startingangle = "200";
                c.Animation = "1";
                c.HowLables = "0";

                style s = new style();
                s.Name = "myCaptionFont";
                s.Type = "font";
                s.Font = "Arial";
                s.Size = "14";
                s.Bold = "1";
                s.Underline = "1";
                s.ToObject = "Caption";
                style s1 = new style();
                s1.Name = "myCaptionFont1";
                s1.Type = "font";
                s1.Font = "Arial";
                s1.Size = "12";
                s1.Bold = "1";
                s1.Underline = "0";
                s1.ToObject = "QUADRANTLABELS";
                style s2 = new style();
                s2.Name = "myCaptionFont2";
                s2.Type = "font";
                s2.Color = "00ff00";
                s2.ToObject = "TRENDVALUES";
                IList<style> slist = new List<style>();
                slist.Add(s);
                slist.Add(s1);
                slist.Add(s2);
                FusionChartType chartType = FusionChartType.Pie3D;

                string chartString = fusionCharPulic.GetXMLData(dt, c, null, slist, chartType, null, "VisitCourse", "866", "300", isload);
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = "success",
                    errNum = 0,
                    retData = chartString
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }


        }

        public void QueryCourseEchartForWebSite(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                string isload = context.Request["FirstLoad"];
                if (!string.IsNullOrWhiteSpace(context.Request["CourseType"]))
                    ht.Add("CourseType", context.Request["CourseType"]);
                SMSModel.JsonModel jsonModel = BllAMS.GetCourseForStatiscByEchartForWebSite(ht);
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void QueryCertificateForCourse(HttpContext context) 
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            List<SMSModel.JsonModel> jsons = new List<SMSModel.JsonModel>();
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("Name", context.Request["CourseName"]);
                ht.Add("TableName", "Course");
                SMSModel.JsonModel jsonModel =BllAMS.QueryCertificateForCourse(ht);
                jsons.Add(jsonModel);
                SMSModel.JsonModel jsonModel2 = BllCS.GetPage(ht, true, string.Empty);
                jsons.Add(jsonModel2);
                context.Response.Write("{\"result\":" + jss.Serialize(jsons) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errNum=400,
                    errMsg = ex.Message
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }

        public void AddFavorites(HttpContext context) 
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            SMSModel.JsonModel jsonModel = null;
            try
            {
                SMSModel.System_Favorites sf = new SMSModel.System_Favorites();
                sf.CreateTime = DateTime.Now;
                sf.Creator = context.Request["IDCard"];
                sf.Href = context.Request["href"];
                sf.Name = context.Request["Name"];
                sf.Type = Convert.ToInt32(context.Request["Type"]);
                sf.RelationID= Convert.ToInt32(context.Request["RelationID"]??"0");
                SMSModel.JsonModel jModel = BllSFS.GetEntityListByField("Href", sf.Href);
                if (jModel.errNum == 0)
                {
                    jsonModel = new SMSModel.JsonModel()
                    {
                        errNum = 400,
                        errMsg = "收藏内容已存在！"
                    };
                }
                else if (jModel.errNum == 999)
                {
                    jsonModel = BllSFS.Add(sf);
                }
            }
            catch (Exception ex)
            {
                jsonModel = new SMSModel.JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message
                };
            }
            context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
        }

        public void GetPageFavoritesList(HttpContext context) 
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            SMSModel.JsonModel jsonModel = null;
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                bool isPage=false;
                if(!string.IsNullOrWhiteSpace(context.Request["isPage"]))isPage=Convert.ToBoolean(context.Request["isPage"]);
                ht.Add("TableName", "System_Favorites");
                string where = string.Empty;
                if (!string.IsNullOrWhiteSpace(context.Request["IDCard"])) where += " and Creator='" + context.Request["IDCard"] + "'";
                jsonModel = BllSFS.GetPage(ht, isPage, where);

            }
            catch (Exception ex)
            {
                jsonModel = new SMSModel.JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message
                };
            }
            context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
        }

        public void DelFavorites(HttpContext context) 
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            SMSModel.JsonModel jsonModel = null;
            try
            {
                string ID = context.Request["ID"];
                if (!string.IsNullOrWhiteSpace(ID))
                {
                    jsonModel = BllSFS.Delete(int.Parse(ID));
                }
            }
            catch (Exception ex)
            {
                jsonModel = new SMSModel.JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message
                };
            }
            context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
        }

        public void GetCostPageList(HttpContext context) 
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            SMSModel.JsonModel jsonModel = null;
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                bool isPage = false;
                //ht.Add("TableName", "FinanceDetail");
                //string where = "";
                //if (!string.IsNullOrWhiteSpace(context.Request["StarDate"]) && !string.IsNullOrWhiteSpace(context.Request["EndDate"]))
                //    where += " and ([CreateTime]>='" + context.Request["StarDate"].ToString() + " 00:00:00' and [CreateTime]<='" + context.Request["EndDate"].ToString() + " 23:59:59')";
                //if (!string.IsNullOrWhiteSpace(context.Request["Type"])) where += " and Type=" + context.Request["Type"];
                //ht.Add("Order", " CreateTime desc");
                //jsonModel = BllFDS.GetPage(ht, isPage, where);
                if (!string.IsNullOrWhiteSpace(context.Request["Type"]))
                    ht.Add("Type", context.Request["Type"]);
                if (!string.IsNullOrWhiteSpace(context.Request["StarDate"]))
                    ht.Add("StarDate", context.Request["StarDate"] + " 00:00:00");
                if (!string.IsNullOrWhiteSpace(context.Request["EndDate"]))
                    ht.Add("EndDate", context.Request["EndDate"] + " 23:59:59");
                jsonModel = BllAMS.GetCostPageList(ht);
            }
            catch (Exception ex)
            {
                jsonModel = new SMSModel.JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message
                };
            }
            context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
        }

        public void QueryCostChart(HttpContext context) 
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            SMSModel.JsonModel jsonModel = null;
            try
            {
                 Hashtable ht = new Hashtable();
                string isload = context.Request["FirstLoad"];
                if (!string.IsNullOrWhiteSpace(context.Request["Type"]))
                    ht.Add("Type", context.Request["Type"]);
                if (!string.IsNullOrWhiteSpace(context.Request["StarDate"]))
                    ht.Add("StarDate", context.Request["StarDate"] + " 00:00:00");
                if (!string.IsNullOrWhiteSpace(context.Request["EndDate"]))
                    ht.Add("EndDate", context.Request["EndDate"] + " 23:59:59");
                DataTable dt = BllAMS.GetCostForStatisc(ht);
                chart c = new chart();
                c.Caption = "消费分析饼图";
                c.ShowValues = "0";
                c.ShowLegend = "1";
                c.LegendPosition = "RIGHT";
                c.ChartRightmargin = "0";
                c.Bgcolor = "ECF5FF";
                c.Bgalpha = "70";
                c.CanvasBorderColor = "C6D2DF";
                c.BaseFontColor = "2F2F2F";
                c.Basefontsize = "11";
                c.Showpercentvalues = "1";
                c.Bgratio = "0";
                c.Startingangle = "200";
                c.Animation = "1";
                c.HowLables = "0";

                style s = new style();
                s.Name = "myCaptionFont";
                s.Type = "font";
                s.Font = "Arial";
                s.Size = "14";
                s.Bold = "1";
                s.Underline = "1";
                s.ToObject = "Caption";
                style s1 = new style();
                s1.Name = "myCaptionFont1";
                s1.Type = "font";
                s1.Font = "Arial";
                s1.Size = "12";
                s1.Bold = "1";
                s1.Underline = "0";
                s1.ToObject = "QUADRANTLABELS";
                style s2 = new style();
                s2.Name = "myCaptionFont2";
                s2.Type = "font";
                s2.Color = "00ff00";
                s2.ToObject = "TRENDVALUES";
                IList<style> slist = new List<style>();
                slist.Add(s);
                slist.Add(s1);
                slist.Add(s2);
                FusionChartType chartType = FusionChartType.Pie3D;

                string chartString = fusionCharPulic.GetXMLData(dt, c, null, slist, chartType, null, "VisitCourse", "866", "300", isload);
                jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = "success",
                    errNum = 0,
                    retData = chartString
                };
            }
            catch (Exception ex)
            {
                jsonModel = new SMSModel.JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message
                };
            }
            context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
        }

        public void QueryCostEchart(HttpContext context) 
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                if (!string.IsNullOrWhiteSpace(context.Request["Type"]))
                    ht.Add("Type", context.Request["Type"]);
                if (!string.IsNullOrWhiteSpace(context.Request["StarDate"]))
                    ht.Add("StarDate", context.Request["StarDate"] + " 00:00:00");
                if (!string.IsNullOrWhiteSpace(context.Request["EndDate"]))
                    ht.Add("EndDate", context.Request["EndDate"] + " 23:59:59");
                SMSModel.JsonModel jsonModel = BllAMS.GetCostForStatiscByEchart(ht);
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                SMSModel.JsonModel jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
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