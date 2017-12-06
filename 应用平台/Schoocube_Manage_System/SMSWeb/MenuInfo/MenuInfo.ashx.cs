using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading;
using System.Web;

namespace SMSWeb.MenuInfo
{
    /// <summary>
    /// MenuInfo1 的摘要说明
    /// </summary>
    public class MenuInfo1 : IHttpHandler
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
                    case "Get_id_MenuInfo": Get_id_MenuInfo(context); break;
                    case "Set_FMenuInfo": Set_FMenuInfo(context); break;
                    case "Set_ZMenuInfo": Set_ZMenuInfo(context); break;
                   
                }
            }
        }

        public void BindBuilding(HttpContext context)
        {
            string callback = context.Request["jsoncallback"];
            SqlParameter[] para = new SqlParameter[1];
            para[0] = new SqlParameter("@id", 0);
            DataTable dt = ExecuteQuery("Proc_GetMenuInfo", para);
            StringBuilder orgJson = new StringBuilder();
            string id = "";
            if (dt.Rows.Count > 0)
            {
                id = dt.Rows[0]["Id"].ToString();
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    var liclass = i == 0 ? " class='selected_build' " : "";
                    orgJson.Append("<li " + liclass + " id='buildli_" + dt.Rows[i]["Id"] + "' onclick='BuildLiClick(this)'>" + dt.Rows[i]["Name"] + "</li>");
                }
            }
            context.Response.Write("{\"result\":\"" + orgJson.ToString() + "\",\"id\":\"" + id + "\"}");
            context.Response.End();
        }


        public void Get_id_MenuInfo(HttpContext context)
        {
            string callback = context.Request["jsoncallback"];
            string id = context.Request["id"];
            string name = "";
            string url = "";
            SqlParameter[] para = new SqlParameter[1];
            para[0] = new SqlParameter("@id", id);
            DataTable dt = ExecuteQuery("Proc_Get_id_MenuInfo", para);
            StringBuilder orgJson = new StringBuilder();
            orgJson.Append("<dl class='listIndex' attr='terminal_brand_s'>");
            orgJson.Append("<dd>");
            //orgJson.Append("<label><a href='SchoolClassEdit.aspx?ClassID=0&SchoolID=" + id + "'\"><span class='jiahao'>+</span><span class='addfuhao'>添加子节点</span></a></label>");
            orgJson.Append("<label><a href='javascript:void(0);' onclick=\"OpenIFrameWindow('新增子节点', 'ZMenuInfoEdit.aspx?pid=" + id + "&id=0&Name=" + name + "&url="+url+"','560px','360px');\"><span class='jiahao'>+</span><span class='addfuhao'>添加子节点</span></a></label>");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
              //  orgJson.Append("<label><a href='SchoolClassEdit.aspx?ClassID=" + dt.Rows[i]["id"].ToString() + "&SchoolID=" + id + "'\"><span class='liangge'>" + dt.Rows[i]["Name"] + "</span></a></label>");
                orgJson.Append("<label><a href='javascript:void(0);' onclick=\"OpenIFrameWindow('编辑子节点', 'ZMenuInfoEdit.aspx?pid=" + id + "&id=" + dt.Rows[i]["Id"].ToString() + "&Name=" + dt.Rows[i]["Name"].ToString() + "&url=" + dt.Rows[i]["Url"].ToString() + "','560px','360px');\"><span class='liangge'>" + dt.Rows[i]["Name"] + "</span></a></label>");
            }
            orgJson.Append("</dd>");
            orgJson.Append("</dl>");
            context.Response.Write("{\"result\":\"" + HttpUtility.UrlEncode(orgJson.ToString()).Replace("+", "%20") + "\"}");
            context.Response.End();

        }


      


        public void Set_FMenuInfo(HttpContext context)
        {
            string callback = context.Request["jsoncallback"];
            string Name = context.Request["Name"];
            SqlParameter[] para = new SqlParameter[1];
            para[0] = new SqlParameter("@Name", Name);
       
            DataTable dt = ExecuteQuery("Proc_Set_FMenuInfo", para);
            string str = dt.Rows[0][0].ToString();
            context.Response.Write("{\"result\":\"" + str.ToString() + "\"}");
            context.Response.End();

        }

        public void Set_ZMenuInfo(HttpContext context)
        {
            string callback = context.Request["jsoncallback"];
            string Name = context.Request["Name"];
            string id = context.Request["id"];
            string Pid = context.Request["Pid"];
            string URL = context.Request["URL"];
            SqlParameter[] para = new SqlParameter[4];
            para[0] = new SqlParameter("@id", id);
            para[1] = new SqlParameter("@Pid", Pid);
            para[2] = new SqlParameter("@Name", Name);
            para[3] = new SqlParameter("@Url", URL);

            DataTable dt = ExecuteQuery("Proc_Set_ZMenuInfo", para);
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



        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}