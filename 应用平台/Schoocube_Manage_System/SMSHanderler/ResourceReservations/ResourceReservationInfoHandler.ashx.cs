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
    /// ResourceReservationInfo 的摘要说明
    /// </summary>
    public class ResourceReservationInfoHandler : IHttpHandler
    {
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        ResourceReservationInfoService resourceService = new ResourceReservationInfoService();
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
                    case "AddNewResourceInfo":
                        AddNewResourceInfo(context);
                        break;
                    case "DelResource":
                        DelResource(context);
                        break;
                    case "ChangeStatus":
                        ChangeStatus(context);
                        break;
                    case "Uplod_Image":
                        Uplod_Image(context);
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
                ht.Add("ID", context.Request["ID"] ?? "");
                ht.Add("CPID", context.Request["CPID"] ?? "");//查询PId=Id
                ht.Add("PID", context.Request["PID"] ?? "");
                ht.Add("Level", context.Request["Level"] ?? "");
                ht.Add("LikeName", context.Request["LikeName"] ?? "");
                ht.Add("Name", context.Request["Name"] ?? "");
                ht.Add("ResourceTypeName", context.Request["ResourceTypeName"] ?? "");
                ht.Add("ResourceReservation", context.Request["ResourceReservation"] ?? "");
                ht.Add("TimeInterval", context.Request["TimeInterval"] ?? "");
                ht.Add("AppoIntmentTime", context.Request["AppoIntmentTime"] ?? "");
                ht.Add("BookCar", context.Request["BookCar"] ?? "");
                ht.Add("TableName", "ResourceReservationInfo");
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

        private void AddNewResourceInfo(HttpContext context)
        {
            try
            {
                ResourceReservationInfo resource = new ResourceReservationInfo();
                if (!string.IsNullOrEmpty(context.Request["Name"]))
                {
                    resource.Name = context.Request["Name"];
                }

                if (!string.IsNullOrEmpty(context.Request["FoldUrl"]))
                {
                    resource.Image = context.Request["FoldUrl"];
                }

                if (!string.IsNullOrEmpty(context.Request["ResourceId"]))
                {
                    resource.ResourceId = Convert.ToInt32(context.Request["ResourceId"]);
                }
                if (!string.IsNullOrEmpty(context.Request["ResourceTypeName"]))
                {
                    resource.ResourceTypeName = context.Request["ResourceTypeName"];
                }
                if (!string.IsNullOrEmpty(context.Request["ResourceId"]))
                {
                    resource.ResourceId = Convert.ToInt32(context.Request["ResourceId"]);
                }
                if (!string.IsNullOrEmpty(context.Request["Room"]))
                {
                    resource.Room = Convert.ToInt32(context.Request["Room"]);
                }
                if (!string.IsNullOrEmpty(context.Request["Floor"]))
                {
                    resource.Floor = context.Request["Floor"];
                }
                if (!string.IsNullOrEmpty(context.Request["Status"]))
                {
                    resource.Status = Convert.ToByte(context.Request["Status"]);
                }
                if ("1".Equals(context.Request["Type"]))
                {
                    resource.Model = context.Request["Model"];
                    resource.LicensePlate = context.Request["LicensePlate"];
                    resource.SeatNum = context.Request["SeatNum"];
                    resource.CarDriver = context.Request["CarDriver"];
                }
                else
                {
                    resource.Address = context.Request["Address"];
                    resource.Area = Convert.ToInt32(context.Request["Area"]);
                    resource.Galleryful = Convert.ToInt32(context.Request["Galleryful"]);
                    resource.OpenTime = context.Request["OpenTime"];
                    resource.ClosedTime = context.Request["ClosedTime"];
                }

                if (!string.IsNullOrEmpty(context.Request["ID"]))
                {
                    resource.Id = Convert.ToInt32(context.Request["ID"]);
                    resource.Editor = context.Request["UserName"];
                    resource.UpdateTime = DateTime.Now;
                    if (NameCommon(resource.ResourceId.ToString(), resource.Id.ToString(), resource.Name) == 0) {
                        jsonModel = new JsonModel
                        {
                            errNum = 999,
                            errMsg = "名称重复",
                            retData = ""
                        };
                    }
                    else
                    {
                        jsonModel = resourceService.Update(resource);
                    }
                }
                else
                {
                    if (NameCommon(resource.ResourceId.ToString(), "", resource.Name) == 0)
                    {
                        jsonModel = new JsonModel
                        {
                            errNum = 999,
                            errMsg = "名称重复",
                            retData = ""
                        };
                    }
                    else
                    {
                        resource.Creator = context.Request["UserName"];
                        resource.CreateTime = DateTime.Now;
                        jsonModel = resourceService.Add(resource);
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
        }
        private int NameCommon(string ResourceId, string ID, string Name)
        {
            Hashtable ht = new Hashtable();

            ht.Add("TableName", "ResourceReservationInfo");

            if (ID.Length > 0)
            {
                jsonModel = resourceService.GetPage(ht, false, " and ResourceId=" + ResourceId + " and Name='" + Name + "' and ID<>" + ID);
            }
            else
            {
                jsonModel = resourceService.GetPage(ht, false, " and ResourceId=" + ResourceId + " and Name='" + Name + "'");
            }
            return jsonModel.errNum;
        }
        /// <summary>
        /// 删除资源数据
        /// </summary>
        /// <param name="context"></param>
        private void DelResource(HttpContext context)
        {
            try
            {
                string ids = context.Request["ID"] == null ? "" : context.Request["ID"].ToString();
                if (ids.Contains(","))
                {
                    string[] idarry = ids.TrimEnd(',').Split(',');
                    int length = idarry.Length;
                    int[] intids = new int[length];
                    for (int i = 0; i < idarry.Length; i++)
                    {
                        string item = idarry[i];
                        intids[i] = int.Parse(item);
                        jsonModel = resourceService.GetEntityById(intids[i]);
                        if (jsonModel.errNum == 0)
                        {
                            ResourceReservationInfo resourceInfo = jsonModel.retData as ResourceReservationInfo;
                            resourceInfo.Id = intids[i];
                            resourceInfo.IsDelete = 1;
                            resourceInfo.Editor = context.Request["UserName"];
                            resourceInfo.UpdateTime = DateTime.Now;
                            jsonModel = resourceService.Update(resourceInfo);
                        }
                    }

                }
                else
                {
                    int id = Convert.ToInt32(ids);
                    jsonModel = resourceService.GetEntityById(id);
                    if (jsonModel.errNum == 0)
                    {
                        ResourceReservationInfo resourceInfo = jsonModel.retData as ResourceReservationInfo;
                        resourceInfo.Id = id;
                        resourceInfo.IsDelete = 1;
                        resourceInfo.Editor = context.Request["UserName"];
                        resourceInfo.UpdateTime = DateTime.Now;
                        jsonModel = resourceService.Update(resourceInfo);
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
        }

        #endregion

        #region 上传图片
        private void Uplod_Image(HttpContext context)
        {
            HttpPostedFile file = HttpContext.Current.Request.Files[0];
            string Fpath = "/ResourceReservationImage";
            FileHelper.CreateDirectory(context.Server.MapPath(Fpath));

            string ext = System.IO.Path.GetExtension(file.FileName);

            string fileName = DateTime.Now.Ticks + ext;

            string p = Fpath + "/" + fileName;

            string path = context.Server.MapPath(p);

            file.SaveAs(path);
            jsonModel = new JsonModel()
            {
                errNum = 0,
                errMsg = "",
                retData = p
            };

        }
        #endregion

        #region 更改状态
        public void ChangeStatus(HttpContext context)
        {
            ResourceReservationInfo resource = new ResourceReservationInfo();
            resource.Id = Convert.ToInt32(context.Request["Id"]);
            resource.UseStatus = Convert.ToByte(context.Request["Status"]);
            resource.Editor = context.Request["UserName"];
            resource.UpdateTime = DateTime.Now;
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