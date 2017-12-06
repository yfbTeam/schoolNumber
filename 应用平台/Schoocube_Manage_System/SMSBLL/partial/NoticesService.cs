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
    public partial class NoticesService
    {
        SMSDAL.NoticesDal DAL = new SMSDAL.NoticesDal();
        BLLCommon common = new BLLCommon();
        public JsonModel GetNoticeAll(Hashtable ht)
        {
            try
            {
                DataTable modList = DAL.GetNoticeAll(ht);
                //定义JSON标准格式实体中
                JsonModel jsonModel = null;
                if (modList.Rows.Count <= 0)
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
                jsonModel = new JsonModel()
                {
                    retData = list,
                    errMsg = "",
                    status = "ok"
                };
                return jsonModel;
            }
            catch (Exception ex)
            {
                JsonModel jsonModel = new JsonModel();
                jsonModel.status = "error";
                jsonModel.retData = ex.ToString();
                return jsonModel;
            }
        }

        public JsonModel GetNewsAll(Hashtable ht)
        {
            try
            {
                DataTable modList = DAL.GetNewsAll(ht);
                //定义JSON标准格式实体中
                JsonModel jsonModel = null;
                if (modList.Rows.Count <= 0)
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
                jsonModel = new JsonModel()
                {
                    retData = list,
                    errMsg = "",
                    status = "ok"
                };
                return jsonModel;
            }
            catch (Exception ex)
            {
                JsonModel jsonModel = new JsonModel();
                jsonModel.status = "error";
                jsonModel.retData = ex.ToString();
                return jsonModel;
            }
        }

        public JsonModel GetDataInfo(Hashtable ht) 
        {
            JsonModel jsonModel = null;
            try
            {
                DataTable dt = DAL.GetDataInfo(ht);
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
