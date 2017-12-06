using SMSBLL;
using SMSModel;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Script.Serialization;

namespace SMSWeb.Menu
{
    /// <summary>
    /// Menu1 的摘要说明
    /// </summary>
    public class Menu1 : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request["action"];
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "BindBuilding": BindBuilding(context); break;
                    case "Get_Pid_MenuInfo": Get_Pid_MenuInfo(context); break;
                    case "ZMenuEdit": ZMenuEdit(context); break;
                    case "DeleteMenu": DeleteMenu(context); break;
                    case "Set_FMenuInfo": Set_FMenuInfo(context); break;
                    case "Get_id_MenuInfo": Get_id_MenuInfo(context); break;
                }
            }
        }

        public void BindBuilding(HttpContext context)
        {
            string callback = context.Request["jsoncallback"];
            string id = context.Request["id"];
            SqlParameter[] para = new SqlParameter[1];
            para[0] = new SqlParameter("@id", id);
            DataTable dt = ExecuteQuery("Proc_GetMenuInfo", para);
            DataRow dr = dt.NewRow();
            dr[0] = 0;
            dr[1] = "全部";
            dr[2] = "";
            dr[3] = 0;
            dr[4] = "";
            dr[5] = "";
            dr[6] = 0;
            dr[7] = 0;
            dt.Rows.InsertAt(dr, 0); 
            StringBuilder orgJson = new StringBuilder();
            string ids = "";
            if (dt.Rows.Count > 0)
            {
                ids = dt.Rows[0]["Id"].ToString();
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    var liclass = i == 0 ? " class='selected_build' " : "";
                    orgJson.Append("<li " + liclass + " id='buildli_" + dt.Rows[i]["Id"] + "' onclick='BuildLiClick(this)'>" + dt.Rows[i]["Name"] + "</li>");
                }
            }
            context.Response.Write("{\"result\":\"" + orgJson.ToString() + "\",\"id\":\"" + ids + "\"}");
            context.Response.End();
        }


        public void Get_Pid_MenuInfo(HttpContext context)
        {
            BLLCommon common = new BLLCommon();
            string callback = context.Request["jsoncallback"];
            string Pid = context.Request["Pid"];
            string id = context.Request["id"];
            SqlParameter[] para = new SqlParameter[2];
            para[0] = new SqlParameter("@Pid", Pid);
            para[1] = new SqlParameter("@id", id);
            DataTable dt = ExecuteQuery("Proc_GetMenuInfo", para);
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            list = common.DataTableToList(dt);
            JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            JsonModel jsonModel = new JsonModel()
            {
                errNum = 0,
                errMsg = "",
                retData = list
            };
            string result = string.Empty;
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();
        }


        public void Get_id_MenuInfo(HttpContext context)
        {
            BLLCommon common = new BLLCommon();
            string callback = context.Request["jsoncallback"];
            string id = context.Request["id"];
            SqlParameter[] para = new SqlParameter[1];
            para[0] = new SqlParameter("@id", id);
            DataTable dt = ExecuteQuery("Proc_Get_id_MenuInfo", para);
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            list = common.DataTableToList(dt);
            JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            JsonModel jsonModel = new JsonModel()
            {
                errNum = 0,
                errMsg = "",
                retData = list
            };
            string result = string.Empty;
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();
        }



        public void Set_FMenuInfo(HttpContext context)
        {
            string callback = context.Request["jsoncallback"];
            string Name = context.Request["Name"];
            string id = context.Request["id"];
            string MenuCode = context.Request["MenuCode"];
            SqlParameter[] para = new SqlParameter[3];
            para[0] = new SqlParameter("@Name", Name);
            para[1] = new SqlParameter("@id", id);
            para[2] = new SqlParameter("@MenuCode", MenuCode);

            DataTable dt = ExecuteQuery("Proc_Set_FMenuInfo", para);
            string str = dt.Rows[0][0].ToString();
            context.Response.Write("{\"result\":\"" + str.ToString() + "\"}");
            context.Response.End();

        }


        public void DeleteMenu(HttpContext context)
        {
            string callback = context.Request["jsoncallback"];
            string id = context.Request["id"];
            SqlParameter[] para = new SqlParameter[1];
            para[0] = new SqlParameter("@id", id);

            DataTable dt = ExecuteQuery("Proc_DeleteMenu", para);
            string str = dt.Rows[0][0].ToString();
            context.Response.Write("{\"result\":\"" + str.ToString() + "\"}");
            context.Response.End();
        }




        public void ZMenuEdit(HttpContext context)
        {
            string callback = context.Request["jsoncallback"];
            string Name = context.Request["Name"];
            string id = context.Request["id"];
            string Pid = context.Request["Pid"];
            string URL = context.Request["URL"];
            string MenuCode = context.Request["MenuCode"];
            SqlParameter[] para = new SqlParameter[5];
            para[0] = new SqlParameter("@id", id);
            para[1] = new SqlParameter("@Pid", Pid);
            para[2] = new SqlParameter("@Name", Name);
            para[3] = new SqlParameter("@Url", URL);
            para[4] = new SqlParameter("@MenuCode", MenuCode);

            DataTable dt = ExecuteQuery("Proc_ZMenuEdit", para);
            string str = dt.Rows[0][0].ToString();
            context.Response.Write("{\"result\":\"" + str.ToString() + "\"}");
            context.Response.End();

        }



        public static SqlConnection GetConnection()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MenuInfo"].ToString();

            SqlConnection Conn = new SqlConnection(connectionString);
            while (Conn.State == ConnectionState.Connecting)
            {
                Thread.Sleep(5);
            }
            if (Conn.State != ConnectionState.Open)
            {
                try
                {
                    Conn.Open();
                }
                catch (Exception e)
                {
                    Conn.Dispose();
                    // throw e;
                }

            }
            return Conn;
        }



        public static DataTable ExecuteQuery(string sql, params SqlParameter[] paras)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = GetConnection())
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(sql, con))
                {
                    sda.SelectCommand.Parameters.Clear();
                    sda.SelectCommand.Parameters.AddRange(paras);
                    sda.SelectCommand.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        sda.Fill(dt);
                        sda.SelectCommand.Parameters.Clear();
                        sda.Dispose();
                        con.Close();
                        con.Dispose();
                        return dt;
                    }
                    catch (Exception e)
                    {
                        con.Close();
                        con.Dispose();
                        if (sda != null)
                            sda.Dispose();
                        throw e;
                    }
                }
            }
        }



        public string DataTableToJson(DataTable dt)
        {
            if (dt == null) return string.Empty;
            StringBuilder sb = new StringBuilder();
            sb.Append("{\"");
            sb.Append("data");
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


        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}