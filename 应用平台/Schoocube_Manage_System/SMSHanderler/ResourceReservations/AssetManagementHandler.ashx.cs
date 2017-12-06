using SMSBLL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SMSHanderler.ResourceReservations
{
    /// <summary>
    /// AssetManagementHandler 的摘要说明
    /// </summary>
    public class AssetManagementHandler : IHttpHandler
    {

        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        AssetManagementService resourceService = new AssetManagementService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string func = context.Request["Func"];
            string result = string.Empty;
            try
            {
                switch (func)
                {
                    case "GetPageList":
                        GetPageList(context);
                        break;
                    case "AddAssetManagement":
                        AddAssetManagement(context);
                        break;
                    case "DelAssetManagement":
                        DelAssetManagement(context);
                        break;
                    case "ChangeStatus":
                        ChangeStatus(context);
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
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();
        }

        #region 获取资源表的分页数据
        private void GetPageList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"] ?? "");
                ht.Add("PageSize", context.Request["pageSize"] ?? "");
                ht.Add("LikeName", context.Request["LikeName"] ?? "");
                ht.Add("ID", context.Request["ID"] ?? "");
                ht.Add("AssetModel", context.Request["AssetModel"] ?? "");
                ht.Add("UseStatus", context.Request["UseStatus"] ?? "");
                ht.Add("IsDelete", context.Request["IsDelete"] ?? "");
                ht.Add("Name", context.Request["Name"] ?? "");
                ht.Add("TableName", "AssetManagement");
                bool ispage = true;
                if (!string.IsNullOrEmpty(context.Request["ispage"]))
                {
                    ispage = Convert.ToBoolean(context.Request["ispage"]);
                }

                jsonModel = resourceService.GetPage(ht, ispage);
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

        private void AddAssetManagement(HttpContext context)
        {
            try
            {
                AssetManagement resource = new AssetManagement();
                
                if (!string.IsNullOrEmpty(context.Request["Name"]))
                {
                    resource.Name = context.Request["Name"];
                }
                if (!string.IsNullOrEmpty(context.Request["AssetModel"]))
                {
                    resource.AssetModel = context.Request["AssetModel"];
                }
                if (!string.IsNullOrEmpty(context.Request["Number"]))
                {
                    resource.Number = Convert.ToInt32(context.Request["Number"]);
                }
                if (!string.IsNullOrEmpty(context.Request["AdressName"]))
                {
                    resource.AdressName = context.Request["AdressName"];
                }
                if (!string.IsNullOrEmpty(context.Request["UseUnits"]))
                {
                    resource.UseUnits = context.Request["UseUnits"];
                }
                if (!string.IsNullOrEmpty(context.Request["WarrantyDate"]))
                {
                    resource.WarrantyDate = Convert.ToDateTime(context.Request["WarrantyDate"]);
                }
                if (!string.IsNullOrEmpty(context.Request["Principal"]))
                {
                    resource.Principal = context.Request["Principal"];
                }
                if (!string.IsNullOrEmpty(context.Request["AcquisitionDate"]))
                {
                    resource.AcquisitionDate = Convert.ToDateTime(context.Request["AcquisitionDate"]);
                }
                if (!string.IsNullOrEmpty(context.Request["SourceEquipment"]))
                {
                    resource.SourceEquipment = context.Request["SourceEquipment"];
                }

                if (!string.IsNullOrEmpty(context.Request["UseStatus"]))
                {
                    resource.UseStatus = Convert.ToByte(context.Request["UseStatus"]);
                }
                
                if (!string.IsNullOrEmpty(context.Request["ID"]))
                {
                    resource.Id = Convert.ToInt32(context.Request["ID"]);
                    resource.Editor = context.Request["UserName"]; 
                    resource.UpdateTime = DateTime.Now;
                    jsonModel = resourceService.Update(resource);
                }
                else
                {
                    resource.Creator = context.Request["UserName"];
                    resource.CreateTime = DateTime.Now;
                    jsonModel = resourceService.Add(resource);
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

        /// <summary>
        /// 删除资源数据
        /// </summary>
        /// <param name="context"></param>
        private void DelAssetManagement(HttpContext context)
        {
            try
            {
                int id=0;
                if(context.Request["ID"] == null || !string.IsNullOrEmpty(context.Request["ID"].ToString())){
                     id = Convert.ToInt32(context.Request["ID"]);
                }
                jsonModel = resourceService.GetEntityById(id);
                if (jsonModel.errNum == 0)
                {
                    AssetManagement asset = jsonModel.retData as AssetManagement;
                    asset.Id = id;
                    asset.IsDelete = 1;
                    jsonModel = resourceService.Update(asset);
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

        #region 更改状态
        public void ChangeStatus(HttpContext context)
        {
            AssetManagement resource = new AssetManagement();
            resource.Id = Convert.ToInt32(context.Request["Id"]);
            resource.UseStatus = Convert.ToByte(context.Request["Status"]);
            jsonModel = resourceService.Update(resource);
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