using SMSModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSBLL
{
    public partial  class AdminManagerService
    {
        SMSDAL.AdminManagerDal DAL = new SMSDAL.AdminManagerDal();
        BLLCommon common = new BLLCommon();
        public DataTable GetLeftNavigationMenu(Hashtable ht)
        {
            return DAL.GetLeftNavigationMenu(ht);
        }
        public int UpdatePortalTreeData(Hashtable ht,System.Data.SqlClient.SqlTransaction trans) 
        {
            return DAL.UpdatePortalTreeData(ht,trans);
        }

        public DataTable GetPortalTreeData(Hashtable ht, System.Data.SqlClient.SqlTransaction trans) 
        {
            return DAL.GetPortalTreeData(ht, trans);
        }
        public JsonModel GetPortalTreeDataForChildId(Hashtable ht) 
        {
            JsonModel jsonModel = null;
            try
            {
                DataTable dt = DAL.GetPortalTreeDataForChildId(ht);
                if (dt != null)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = common.DataTableToList(dt)
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                }
                return jsonModel;
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }

        public JsonModel AddUserInfos(List<SMSModel.PortalMenuDroit> list)
        {
            int number = DAL.AddUserInfos(list);
            JsonModel jsonModel = null;
            if (number>0)
            {
                jsonModel = new JsonModel()
                {
                    errMsg = "success",
                    errNum=0,
                      
                };
                return jsonModel;
            }
            else
            {
                jsonModel = new JsonModel()
                {
                    errMsg = "error",
                    errNum = 999,

                };
                return jsonModel;
            }
            
        }

        public DataTable GetCourseForStatisc(Hashtable ht) 
        {
            return DAL.GetCourseForStatisc(ht);
        }

        public JsonModel GetCourseForStatiscByEchart(Hashtable ht) 
        {
            JsonModel jsonModel = null;
            try
            {
                DataTable dt = DAL.GetCourseForStatisc(ht);
                if (dt != null)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = common.DataTableToList(dt)
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                }
                return jsonModel;
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }

        public DataTable ExportExcel(Hashtable ht)
        {
            return DAL.ExportExcel(ht);
        }

        public JsonModel GetPageItemList(Hashtable ht) 
        {
            JsonModel jsonModel = null;
            int RowCount = 0;
            SMSIDAL.PagedDataModel<Dictionary<string, object>> pagedDataModel = null;
            int PageIndex = int.Parse(Convert.ToString(ht["PageIndex"]));
            int PageSize = int.Parse(Convert.ToString(ht["PageSize"]));
            DataTable modList = DAL.GetPageItemList(ht);
            if (modList==null)
            {
                jsonModel = new JsonModel()
                {
                    status = "no",
                    errMsg = "无数据"
                };
                return jsonModel;
            }
            RowCount = modList.Rows.Count;
            if (RowCount <= 0)
            {
                jsonModel = new JsonModel()
                {
                    status = "no",
                    errMsg = "无数据"
                };
                return jsonModel;
            }
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            list = common.DataTableToList(modList);
            int PageCount = (int)Math.Ceiling(RowCount * 1.0 / PageSize);
            //将数据封装到PagedDataModel分页数据实体中
            pagedDataModel = new SMSIDAL.PagedDataModel<Dictionary<string, object>>()
            {
                PageCount = PageCount,
                PagedData = list,
                PageIndex = PageIndex,
                PageSize = PageSize,
                RowCount = RowCount
            };
            //将分页数据实体封装到JSON标准实体中
            jsonModel = new JsonModel()
            {
                errNum = 0,
                errMsg = "success",
                retData = pagedDataModel
            };
            return jsonModel;
        }


        public JsonModel GetCourseListByJobIds(Hashtable ht) 
        {
            JsonModel jsonModel = null;
            try
            {
                DataTable dt = DAL.GetCourseListByJobIds(ht);
                if (dt != null)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = common.DataTableToList(dt)
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                }
                return jsonModel;
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }

        public JsonModel GetCoursePageListByJobIds(Hashtable ht)
        {
            JsonModel jsonModel = null;
            try
            {
                int RowCount = 0;
                SMSIDAL.PagedDataModel<Dictionary<string, object>> pagedDataModel = null;
                int PageIndex = int.Parse(Convert.ToString(ht["PageIndex"]));
                int PageSize = int.Parse(Convert.ToString(ht["PageSize"]));
                DataTable modList = DAL.GetCourseListByJobIds(ht);
                if (modList == null)
                {
                    jsonModel = new JsonModel()
                    {
                        status = "no",
                        errMsg = "无数据"
                    };
                    return jsonModel;
                }
                RowCount = modList.Rows.Count;
                if (RowCount <= 0)
                {
                    jsonModel = new JsonModel()
                    {
                        status = "no",
                        errMsg = "无数据"
                    };
                    return jsonModel;
                }
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                list = common.DataTableToList(modList);
                int PageCount = (int)Math.Ceiling(RowCount * 1.0 / PageSize);
                //将数据封装到PagedDataModel分页数据实体中
                pagedDataModel = new SMSIDAL.PagedDataModel<Dictionary<string, object>>()
                {
                    PageCount = PageCount,
                    PagedData = list,
                    PageIndex = PageIndex,
                    PageSize = PageSize,
                    RowCount = RowCount
                };
                //将分页数据实体封装到JSON标准实体中
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = pagedDataModel
                };
                return jsonModel;
                
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }

        public DataTable GetPagedTable(DataTable dt, int PageIndex, int PageSize)
        {
            if (PageIndex == 0) { return dt; }
            DataTable newdt = dt.Copy();
            newdt.Clear();
            int rowbegin = (PageIndex - 1) * PageSize;
            int rowend = PageIndex * PageSize;

            if (rowbegin >= dt.Rows.Count)
            { return newdt; }

            if (rowend > dt.Rows.Count)
            { rowend = dt.Rows.Count; }
            for (int i = rowbegin; i <= rowend - 1; i++)
            {
                DataRow newdr = newdt.NewRow();
                DataRow dr = dt.Rows[i];
                foreach (DataColumn column in dt.Columns)
                {
                    newdr[column.ColumnName] = dr[column.ColumnName];
                }
                newdt.Rows.Add(newdr);
            }
            return newdt;
        }


        public JsonModel GetThisWebList(Hashtable ht) 
        {
            JsonModel jsonModel = null;
            int RowCount = 0;
            SMSIDAL.PagedDataModel<Dictionary<string, object>> pagedDataModel = null;
            int PageIndex = int.Parse(Convert.ToString(ht["PageIndex"]));
            int PageSize = int.Parse(Convert.ToString(ht["PageSize"]));
            DataTable modList = DAL.GetThisWebList(ht);
            if (modList == null)
            {
                jsonModel = new JsonModel()
                {
                    status = "no",
                    errMsg = "无数据"
                };
                return jsonModel;
            }
            RowCount = modList.Rows.Count;
            if (RowCount <= 0)
            {
                jsonModel = new JsonModel()
                {
                    status = "no",
                    errMsg = "无数据"
                };
                return jsonModel;
            }
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            list = common.DataTableToList(modList);
            int PageCount = (int)Math.Ceiling(RowCount * 1.0 / PageSize);
            //将数据封装到PagedDataModel分页数据实体中
            pagedDataModel = new SMSIDAL.PagedDataModel<Dictionary<string, object>>()
            {
                PageCount = PageCount,
                PagedData = list,
                PageIndex = PageIndex,
                PageSize = PageSize,
                RowCount = RowCount
            };
            //将分页数据实体封装到JSON标准实体中
            jsonModel = new JsonModel()
            {
                errNum = 0,
                errMsg = "success",
                retData = pagedDataModel
            };
            return jsonModel;
            
        }

        public JsonModel GetThisWebPageList(Hashtable ht)
        {
            JsonModel jsonModel = null;
            int RowCount = 0;
            SMSIDAL.PagedDataModel<Dictionary<string, object>> pagedDataModel = null;
            int PageIndex = int.Parse(Convert.ToString(ht["PageIndex"]));
            int PageSize = int.Parse(Convert.ToString(ht["PageSize"]));
            DataTable modList = DAL.GetThisWebPageList(ht);
            if (modList == null)
            {
                jsonModel = new JsonModel()
                {
                    status = "no",
                    errMsg = "无数据"
                };
                return jsonModel;
            }
            RowCount = modList.Rows.Count;
            if (RowCount <= 0)
            {
                jsonModel = new JsonModel()
                {
                    status = "no",
                    errMsg = "无数据"
                };
                return jsonModel;
            }
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            list = common.DataTableToList(modList);
            int PageCount = (int)Math.Ceiling(RowCount * 1.0 / PageSize);
            //将数据封装到PagedDataModel分页数据实体中
            pagedDataModel = new SMSIDAL.PagedDataModel<Dictionary<string, object>>()
            {
                PageCount = PageCount,
                PagedData = list,
                PageIndex = PageIndex,
                PageSize = PageSize,
                RowCount = RowCount
            };
            //将分页数据实体封装到JSON标准实体中
            jsonModel = new JsonModel()
            {
                errNum = 0,
                errMsg = "success",
                retData = pagedDataModel
            };
            return jsonModel;

        }

        public DataTable ExportExcelWebSite(Hashtable ht) 
        {
            return DAL.ExportExcelWebSite(ht); 
        }

        public DataTable QueryCourseChartForWebSite(Hashtable ht) 
        {
            return DAL.GetThisWebList(ht);
        }
        public JsonModel GetCourseForStatiscByEchartForWebSite(Hashtable ht)
        {
            JsonModel jsonModel = null;
            try
            {
                DataTable dt = DAL.GetThisWebList(ht);
                if (dt != null)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = common.DataTableToList(dt)
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                }
                return jsonModel;
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }

        public JsonModel QueryCertificateForCourse(Hashtable ht) 
        {
            JsonModel jsonModel = null;
            int RowCount = 0;
            SMSIDAL.PagedDataModel<Dictionary<string, object>> pagedDataModel = null;
            int PageIndex = int.Parse(Convert.ToString(ht["PageIndex"]));
            int PageSize = 100;
            DataTable modList = DAL.QueryCertificateForCourse(ht);
            if (modList == null)
            {
                jsonModel = new JsonModel()
                {
                    status = "no",
                    errMsg = "无数据"
                };
                return jsonModel;
            }
            RowCount = modList.Rows.Count;
            if (RowCount <= 0)
            {
                jsonModel = new JsonModel()
                {
                    status = "no",
                    errMsg = "无数据"
                };
                return jsonModel;
            }
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            list = common.DataTableToList(modList);
            int PageCount = (int)Math.Ceiling(RowCount * 1.0 / PageSize);
            //将数据封装到PagedDataModel分页数据实体中
            pagedDataModel = new SMSIDAL.PagedDataModel<Dictionary<string, object>>()
            {
                PageCount = PageCount,
                PagedData = list,
                PageIndex = PageIndex,
                PageSize = PageSize,
                RowCount = RowCount
            };
            //将分页数据实体封装到JSON标准实体中
            jsonModel = new JsonModel()
            {
                errNum = 0,
                errMsg = "success",
                retData = pagedDataModel
            };
            return jsonModel;
        }


        public JsonModel GetCostPageList(Hashtable ht) 
        {
            JsonModel jsonModel = null;
            int RowCount = 0;
            SMSIDAL.PagedDataModel<Dictionary<string, object>> pagedDataModel = null;
            int PageIndex = int.Parse(Convert.ToString(ht["PageIndex"]));
            int PageSize = int.Parse(Convert.ToString(ht["PageSize"]));
            DataTable modList = DAL.GetCostPageList(ht);
            if (modList == null)
            {
                jsonModel = new JsonModel()
                {
                    status = "no",
                    errMsg = "无数据"
                };
                return jsonModel;
            }
            RowCount = modList.Rows.Count;
            if (RowCount <= 0)
            {
                jsonModel = new JsonModel()
                {
                    status = "no",
                    errMsg = "无数据"
                };
                return jsonModel;
            }
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            list = common.DataTableToList(modList);
            int PageCount = (int)Math.Ceiling(RowCount * 1.0 / PageSize);
            //将数据封装到PagedDataModel分页数据实体中
            pagedDataModel = new SMSIDAL.PagedDataModel<Dictionary<string, object>>()
            {
                PageCount = PageCount,
                PagedData = list,
                PageIndex = PageIndex,
                PageSize = PageSize,
                RowCount = RowCount
            };
            //将分页数据实体封装到JSON标准实体中
            jsonModel = new JsonModel()
            {
                errNum = 0,
                errMsg = "success",
                retData = pagedDataModel
            };
            return jsonModel;

        }
        public DataTable GetCostForStatisc(Hashtable ht) 
        {
            return DAL.GetCostForStatisc(ht);
        }

        public JsonModel GetCostForStatiscByEchart(Hashtable ht)
        {
            JsonModel jsonModel = null;
            try
            {
                DataTable dt = DAL.GetCostForStatisc(ht);
                if (dt != null)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = common.DataTableToList(dt)
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                }
                return jsonModel;
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }
    }
}
