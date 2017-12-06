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
    public partial class MonitorRecordService
    {
        SMSDAL.MonitorRecordDal DAL = new SMSDAL.MonitorRecordDal();
        BLLCommon common = new BLLCommon();
        public DataTable GetNewRecordForOrder(Hashtable ht, ref int rows)
        {
            int PageIndex = int.Parse(Convert.ToString(ht["PageIndex"]));
            int PageSize = int.Parse(Convert.ToString(ht["PageSize"]));
            DataTable dt = DAL.GetNewRecordForOrder(ht, ref rows);
            if (dt != null && dt.Rows.Count > 0) dt = GetPagedTable(dt, PageIndex, PageSize);
            return dt;
        }

        public DataTable GetRecordForStatisc(Hashtable ht,ref int rows) 
        {
            return DAL.GetNewRecordForOrder(ht, ref rows);
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

        public DataTable GetNetworkflowForOrder(Hashtable ht,ref int rows) 
        {
            return DAL.GetNetworkflowForOrder(ht,ref rows);
        }

        public JsonModel QueryNetworkflowEChart(Hashtable ht)
        {
            JsonModel jsonModel = null;
            try
            {
                int rows = 0;
                DataTable dt = DAL.GetNetworkflowForOrder(ht,ref rows);
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

        public JsonModel GetRecordForResouceID(Hashtable ht) 
        {
            JsonModel jsonModel = null;
            int RowCount = 0;
            SMSIDAL.PagedDataModel<Dictionary<string, object>> pagedDataModel = null;
            int PageIndex = int.Parse(Convert.ToString(ht["PageIndex"]));
            int PageSize = int.Parse(Convert.ToString(ht["PageSize"]));
            DataTable modList = DAL.GetRecordForResouceID(ht);
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

        public JsonModel RemoveUserOnLine(Hashtable ht) 
        {
            int number = DAL.RemoveUserOnLine(ht);
            JsonModel jsonModel = null;
            if (number > 0)
            {
                jsonModel = new JsonModel()
                {
                    errMsg = "success",
                    errNum = 0,

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
    }
}
