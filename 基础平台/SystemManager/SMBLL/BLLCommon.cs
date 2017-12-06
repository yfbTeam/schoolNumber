using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using System.Data;
using System.IO;
using SMModel;
using SMDAL;
using SMUtility;
using SMSUtility;
using System.Security.Cryptography;
using System.Data.SqlClient;
using SMIDAL;
using NPOI;
using NPOI.HSSF.UserModel;
using NPOI.XSSF.UserModel;
using NPOI.SS.UserModel;


namespace SMBLL
{
    public class BLLCommon
    {
        #region 判断是否有访问系统方法的权限并返回字段
        /// <summary>
        /// 判断是否有访问系统方法的权限并返回字段
        /// </summary>
        /// <param name="syskey"></param>
        /// <param name="indenkey"></param>
        /// <param name="func"></param>
        /// <returns></returns>
        public JsonModel IsHasAuthority(string syskey, string indenkey, string func)
        {
            JsonModel jsonModel = null;
            try
            {
                if (string.IsNullOrEmpty(syskey) || string.IsNullOrEmpty(indenkey) || string.IsNullOrEmpty(func))
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 3,
                        errMsg = "loss",
                        retData = ""
                    };
                    return jsonModel;
                }
                if (syskey == "baseplat_self" && indenkey == "allpower")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = "*"
                    };
                    return jsonModel;
                }
                string rtnresult = new Plat_SystemInfoDal().IsHasAuthority(syskey, indenkey, func);
                if (string.IsNullOrEmpty(rtnresult))
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 2,
                        errMsg = "noauth",
                        retData = ""
                    };
                    return jsonModel;
                }
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = rtnresult
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
        #endregion
       
        /// <summary>
        /// 根据第几页、每页条数增加起始条数、结束条数
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public Hashtable AddStartEndIndex(Hashtable ht)
        {
            try 
	        {	        
		        int PageIndex = Convert.ToInt32(ht["PageIndex"]);
                int PageSize = Convert.ToInt32(ht["PageSize"]);
                ht.Add("StartIndex", (((PageIndex - 1) * PageSize)+1).ToString());
                ht.Add("EndIndex", (PageIndex * PageSize).ToString());
	        }
	        catch (Exception)
	        {
		
		        throw;
	        }
            return ht;
        }

        /// <summary>
        /// DataTable转换成Json格式
        /// </summary>
        /// <param name="dt">要转换的DataTable</param>        
        /// <returns>Json字符串</returns>
        public string DataTableToJson(DataTable dt)
        {
            if (dt == null) return string.Empty;
            StringBuilder sb = new StringBuilder();
            sb.Append("{\"");
            sb.Append(dt.TableName);
            sb.Append("\":[");
            foreach (DataRow r in dt.Rows)
            {
                sb.Append("{");
                foreach (DataColumn c in dt.Columns)
                {
                    sb.Append("\"");
                    sb.Append(c.ColumnName);
                    sb.Append("\":\"");
                    sb.Append(r[c].ToString());
                    sb.Append("\",");
                }
                sb.Remove(sb.Length - 1, 1);
                sb.Append("},");
            }
            sb.Remove(sb.Length - 1, 1);
            sb.Append("]}");
            return sb.ToString();
        }
        /// <summary>
        /// DataTable转换成List
        /// </summary>
        /// <param name="dt">要转换的DataTable</param>        
        /// <returns>List<Dictionary<string, object>></returns>
        public List<Dictionary<string, object>> DataTableToList(DataTable dt)
        {
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, object> result = new Dictionary<string, object>();
                foreach (DataColumn dc in dt.Columns)
                {
                    result.Add(dc.ColumnName, dr[dc].ToString());
                }
                list.Add(result);
            }
            return list;
        }

        /// <summary>
        /// 有验证-不分页
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public JsonModel GetData(Hashtable ht)
        {
            BLLCommon com = new SMBLL.BLLCommon();
            JsonModel JsonModel;
            try
            {

                string Columns = "";
                JsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (JsonModel.errNum != 0)
                {
                    return JsonModel;
                }
                Columns = JsonModel.retData.ToString();

                string SQL = " select " + Columns + " from (";
                SQL += " select " + ht["Columns"].ToString() + " from " + ht["TableName"].ToString() + " where 1=1 ";
                if (ht.Contains("Where") && !string.IsNullOrWhiteSpace(ht["Where"].ToString()))
                {
                    SQL += ht["Where"].ToString();
                }
                if (ht.Contains("Order") && !string.IsNullOrWhiteSpace(ht["Order"].ToString()))
                {
                    SQL += " order by " + ht["Order"].ToString();
                }
                SQL += ") T";
                DataTable dt = SQLHelp.ExecuteDataTable(SQL, CommandType.Text);
                if (dt == null)
                {
                    JsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "失败",
                        retData = ""
                    };
                    LogService.WriteErrorLog("DataTable为NULL");
                    return JsonModel;
                }
                if (dt.Rows.Count==0)
                {
                    JsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                    return JsonModel;
                }
                JsonModel.retData = com.DataTableToList(dt);
                return JsonModel;
            }
            catch (Exception ex)
            {

                JsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
                return JsonModel;
            }
        }

        /// <summary>
        /// 无验证-不分页
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public JsonModel GetData_NoVerification(Hashtable ht)
        {
            BLLCommon com = new SMBLL.BLLCommon();
            JsonModel JsonModel;
            try
            {
                string SQL = " select " + ht["Columns"].ToString() + " from " + ht["TableName"].ToString() + " where 1=1 ";
                if (ht.Contains("Where") && !string.IsNullOrWhiteSpace(ht["Where"].ToString()))
                {
                    SQL += ht["Where"].ToString();
                }
                if (ht.Contains("Order") && !string.IsNullOrWhiteSpace(ht["Order"].ToString()))
                {
                    SQL += " order by " + ht["Order"].ToString();
                }
                DataTable dt = SQLHelp.ExecuteDataTable(SQL, CommandType.Text);
                if (dt == null)
                {
                    JsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "失败",
                        retData = ""
                    };
                    LogService.WriteErrorLog("DataTable为NULL");
                    return JsonModel;
                }
                if (dt.Rows.Count == 0)
                {
                    JsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                    return JsonModel;
                }
                JsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "成功",
                    retData = com.DataTableToList(dt)
                };
                return JsonModel;
            }
            catch (Exception ex)
            {

                JsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
                return JsonModel;
            }
        }
        /// <summary>
        /// 分页
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public JsonModel GetPagingData(Hashtable ht)
        {
            BLLCommon com = new SMBLL.BLLCommon();
            JsonModel JsonModel;
            List<SqlParameter> List = new List<SqlParameter>();
            try
            {
                if (!ht.Contains("PageIndex") || !ht.Contains("PageSize"))
                {
                    JsonModel = new JsonModel()
                    {
                        errNum = 3,
                        errMsg = "loss",
                        retData = ""
                    };
                    return JsonModel;
                }
                int PageIndex = Convert.ToInt32(ht["PageIndex"]);
                int PageSize = Convert.ToInt32(ht["PageSize"]);
                ht.Add("StartIndex", (((PageIndex - 1) * PageSize) + 1).ToString());
                ht.Add("EndIndex", (PageIndex * PageSize).ToString());

                string Columns = "";
                JsonModel = com.IsHasAuthority(ht["SystemKey"].ToString(), ht["InfKey"].ToString(), ht["func"].ToString());
                if (JsonModel.errNum != 0)
                {
                    return JsonModel;
                }
                Columns = JsonModel.retData.ToString();

                string SQL = " select " + Columns + " from (";
                SQL += " select " + ht["Columns"].ToString() + " from " + ht["TableName"].ToString() + " where 1=1 ";
                if (ht.Contains("Where") && !string.IsNullOrWhiteSpace(ht["Where"].ToString()))
                {
                    SQL += ht["Where"].ToString();
                }
                if (ht.Contains("Order") && !string.IsNullOrWhiteSpace(ht["Order"].ToString()))
                {
                    SQL += " order by " + ht["Order"].ToString();
                }
                SQL += ") T1 ";
                //DataTable dt = SQLHelp.ExecuteDataTable(SQL, CommandType.Text);
                DataTable dt = GetListByPage("(" + SQL + ")", "", "", Convert.ToInt32(ht["StartIndex"].ToString()), Convert.ToInt32(ht["EndIndex"].ToString()), List.ToArray());
                if (dt == null)
                {
                    JsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "失败",
                        retData = ""
                    };
                    LogService.WriteErrorLog("DataTable为NULL");
                    return JsonModel;
                }
                if (dt.Rows.Count == 0)
                {
                    JsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                    return JsonModel;
                }
                int RowCount = GetRecordCount("(" + SQL + ") T", "", List.ToArray());
                //JsonModel.retData = DataTableToList(dt);
                //定义分页数据实体
                PagedDataModel<Dictionary<string, object>> pagedDataModel = null;
                //总页数
                int PageCount = (int)Math.Ceiling(RowCount * 1.0 / PageSize);
                //将数据封装到PagedDataModel分页数据实体中
                pagedDataModel = new PagedDataModel<Dictionary<string, object>>()
                {
                    PageCount = PageCount,
                    PagedData = DataTableToList(dt),
                    PageIndex = PageIndex,
                    PageSize = PageSize,
                    RowCount = RowCount
                };
                JsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "成功",
                    retData = pagedDataModel
                };
                return JsonModel;
            }
            catch (Exception ex)
            {

                JsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
                return JsonModel;
            }
        }
        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        /// <param name="strWhere">条件</param>
        /// <param name="orderby">排序</param>
        /// <param name="startIndex">起始行数</param>
        /// <param name="endIndex">结束行数</param>
        /// <returns>DataSet</returns>
        public DataTable GetListByPage(string TableName, string strWhere, string orderby, int startIndex, int endIndex, SqlParameter[] parms4org, bool ispage = true)
        {
            StringBuilder sbSql = new StringBuilder();
            sbSql.Append("SELECT * FROM ( ");
            sbSql.Append(" SELECT ROW_NUMBER() OVER (");
            if (!string.IsNullOrEmpty(orderby.Trim()))
            {
                sbSql.Append("order by T." + orderby);
            }
            else
            {
                sbSql.Append("order by T.ID desc");
            }
            sbSql.Append(")AS rowNum, T.*  from " + TableName + " T ");
            if (!string.IsNullOrEmpty(strWhere.Trim()))
            {
                sbSql.Append(" WHERE 1=1 " + strWhere);
            }
            sbSql.Append(" ) TT");
            if (ispage)
            {
                sbSql.AppendFormat(" WHERE TT.rowNum between {0} and {1}", startIndex, endIndex);
            }
            return SQLHelp.ExecuteDataTable(sbSql.ToString(), CommandType.Text, parms4org);
        }
        /// <summary>
        /// 获取记录总数
        /// </summary>
        /// <param name="strWhere">条件</param>
        /// <returns>记录总数</returns>
        public int GetRecordCount(string TableName, string strWhere, SqlParameter[] parms4org)
        {
            StringBuilder sbSql = new StringBuilder();
            sbSql.Append("select count(1) FROM " + TableName);
            if (strWhere.Trim() != "")
            {
                sbSql.Append(" where 1=1" + strWhere);
            }

            object obj = SQLHelp.ExecuteScalar(sbSql.ToString(), CommandType.Text, parms4org);

            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }
        /// <summary>
        /// Md5加密
        /// </summary>
        public string Md5Encrypting(string SourceStr)
        {

            var provider = new MD5CryptoServiceProvider();
            var bytes = Encoding.UTF8.GetBytes(SourceStr);
            var builder = new StringBuilder();

            bytes = provider.ComputeHash(bytes);

            foreach (var b in bytes)
                builder.Append(b.ToString("x2").ToLower());

            return builder.ToString();
        }

        /// <summary>
        /// Excel表格转DataTable
        /// </summary>
        /// <param name="FilePath">Excel文件物理路径</param>
        /// <returns>DataTable</returns>
        public DataTable ExcelToDataTable(string FilePath)
        {
            DataTable dt = new DataTable("table1");
            using (FileStream fs = new FileStream(FilePath, FileMode.Open, FileAccess.Read))
            {
                IWorkbook workbook = WorkbookFactory.Create(fs);//使用接口，自动识别excel2003/2007格式
                ISheet sheet = workbook.GetSheetAt(0);//得到里面第一个sheet
                //表头  
                IRow headerRow = sheet.GetRow(0);//获得第一行
                int cellCount = headerRow.LastCellNum - 1;//获得最后一个单元格的列号
                for (int i = 0; i <= cellCount; i++)
                {
                    //DataColumn column = new DataColumn(headerRow.Cells[i].ToString());
                    DataColumn column;
                    if (headerRow.GetCell(i) == null)
                    {
                        column = new DataColumn("");
                    }
                    else
                    {
                        string ColumnName = headerRow.GetCell(i).StringCellValue.ToString().Trim();
                        //判断重名
                        if (dt.Columns.Contains(ColumnName))
                        {
                            int RepeatNum = 1;
                            //加重复数后缀，循环判断
                            while (dt.Columns.Contains(ColumnName + RepeatNum.ToString()))
                            {
                                RepeatNum++;
                            }
                            column = new DataColumn(ColumnName + RepeatNum.ToString());
                        }
                        else
                        {
                            column = new DataColumn(ColumnName);
                        }
                    }
                    dt.Columns.Add(column);
                }
                //内容
                for (int i = 1; i <= sheet.LastRowNum; i++)
                {
                    DataRow dr = dt.NewRow();
                    IRow Row = sheet.GetRow(i);
                    if (Row == null)
                    {
                        continue;
                    }
                    for (int j = 0; j <= cellCount; j++)
                    {
                        if (Row.GetCell(j) == null)
                        {
                            dr[j] = "";
                        }
                        else
                        {
                            dr[j] = Row.GetCell(j).ToString().Trim();
                        }
                    }
                    dt.Rows.Add(dr);
                }
            }
            return dt;
        }


        #region MyRegion
        
        //#region 将Excel文件中的数据读出到DataTable中
        ///// <summary>  
        ///// 将Excel文件中的数据读出到DataTable中(xlsx)  
        ///// </summary>
        ///// <param name="strColumn">dt字段名和excel字段名</param>
        ///// <param name="file">文件路径</param>  
        ///// <param name="a">di</param>  
        ///// <returns>表</returns>  
        //public static DataTable ExcelToTable(string[][] strColumn, string file, int a)
        //{
        //    DataTable dt2 = new DataTable();

        //    #region 得到dt2
        //    using (FileStream fs = new FileStream(file, FileMode.Open, FileAccess.Read))
        //    {
        //        IWorkbook workbook = WorkbookFactory.Create(fs);
        //        ISheet sheet = workbook.GetSheetAt(a);
        //        IRow header = sheet.GetRow(sheet.FirstRowNum);
        //        if (header == null)
        //        {
        //            return null;
        //        }
        //        List<int> columns = new List<int>();
        //        for (int i = 0; i < header.LastCellNum; i++)
        //        {
        //            object obj = GetValueTypeForXLSX(header.GetCell(i) as XSSFCell);
        //            if (obj == null || obj.ToString() == string.Empty)
        //            {
        //                dt2.Columns.Add(new DataColumn(""));
        //            }
        //            else
        //            {
        //                dt2.Columns.Add(new DataColumn(obj.ToString().Trim()));
        //            }
        //            columns.Add(i);
        //        }
        //        //数据 
        //        try
        //        {
        //            for (int i = sheet.FirstRowNum + 1; i <= sheet.LastRowNum; i++)
        //            {
        //                DataRow dr = dt2.NewRow();
        //                bool hasValue = false;

        //                foreach (int j in columns)
        //                {
        //                    dr[j] = GetValueTypeForXLSX(sheet.GetRow(i).GetCell(j) as XSSFCell);
        //                    if (dr[j] != null && dr[j].ToString() != string.Empty)
        //                    {
        //                        hasValue = true;
        //                    }
        //                }
        //                if (hasValue)
        //                {
        //                    dt2.Rows.Add(dr);
        //                }
        //            }
        //        }
        //        catch (Exception e)
        //        {
        //            return null;
        //        }
        //    }
        //    #endregion

        //    #region 得到要显示的dt
        //    string[] list = new string[strColumn.Length];
        //    for (int m = 0; m < strColumn.Length; m++)
        //    {
        //        list[m] = strColumn[m][1].Trim();
        //    }
        //    DataTable dt = dt2.DefaultView.ToTable(false, list);
        //    return dt;
        //    #endregion
        //}
        //#endregion

        //#region 将Excel文件中的数据读出到数据库中
        ///// <summary>  
        ///// 将Excel文件中的数据读出到数据库中(xlsx)  
        ///// </summary>
        ///// <param name="strColumn">dt字段名和excel字段名</param>
        ///// <param name="dt">DataTable</param>  
        ///// <param name="dtName">表名</param>
        ///// <returns>string</returns>
        //public static string ExcelToTableForDb(string[][] strColumn, DataTable dt, string dtName)
        //{
        //    string returning = "";//要返回的值
        //    //DataTable dt = ExcelToTable(strColumn, file, a);
        //    if (dt.Columns.Count == strColumn.Length)//传入得数组和列数是否相等
        //    {
        //        #region 存到数据库中
        //        string desConnString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        //        SqlConnection desConnection = new SqlConnection(desConnString);
        //        using (SqlBulkCopy sbc = new SqlBulkCopy(desConnString, SqlBulkCopyOptions.UseInternalTransaction))
        //        {
        //            sbc.BulkCopyTimeout = 1000;//???超时之前操作完成所允许的秒数
        //            sbc.NotifyAfter = dt.Rows.Count;
        //            try
        //            {
        //                sbc.DestinationTableName = dtName;
        //                sbc.WriteToServer(dt);
        //            }
        //            catch (Exception ex)
        //            {
        //                return returning = ex.Message + "请检查数据是否符合数据库中的数据类型";
        //            }
        //            desConnection.Close();
        //            if (returning.Length < 2)
        //            {
        //                return returning = dt.Rows.Count.ToString();
        //            }
        //        }
        //        #endregion
        //    }
        //    else
        //    {//传入的文件列数与数据库表列不等
        //        return returning = "-1";
        //    }
        //    return returning;
        //}
        //#endregion
        //#region 获取单元格类型
        ///// <summary>  
        ///// 获取单元格类型(xlsx)  
        ///// </summary>  
        ///// <param name="cell">撒大大</param>  
        ///// <returns>object</returns>  
        //private static object GetValueTypeForXLSX(XSSFCell cell)
        //{
        //    if (cell == null)
        //    {
        //        return null;
        //    }
        //    switch (cell.CellType)
        //    {
        //        case CellType.BLANK: //BLANK:  
        //            return null;
        //        case CellType.BOOLEAN: //BOOLEAN:  
        //            return cell.BooleanCellValue;
        //        case CellType.NUMERIC: //NUMERIC:  
        //            return cell.NumericCellValue;
        //        case CellType.STRING: //STRING:  
        //            return cell.StringCellValue;
        //        case CellType.ERROR: //ERROR:  
        //            return cell.ErrorCellValue;
        //        case CellType.FORMULA: //FORMULA:  
        //        default:
        //            return "=" + cell.CellFormula;
        //    }
        //}
        //#endregion

        #endregion
    }
}
