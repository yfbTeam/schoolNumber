<%@ WebHandler Language="C#" Class="ToExcelHandler" %>

using System;
using System.Web;
using System.Reflection;
using System.Data;
using SMSUtility;
public class ToExcelHandler : IHttpHandler
{
    private static Assembly Bll_Assembly;
    public void ProcessRequest(HttpContext context)
    {
        //调用的导出方法的类名
        string className = context.Request["ClassName"];
        //调用的导出的方法名
        string methodName = context.Request["MethodName"];
        //导出的数据的表头
        string headName = context.Request["headName"];
        //导出保存的文件名
        string FileName = context.Request["FileName"];

        try
        {
            //根据名称获得访问类
            Bll_Assembly = Assembly.Load("SMSBLL");
            Type bllType = Bll_Assembly.GetType("SMSBLL." + className);
            MethodInfo method = bllType.GetMethod(methodName);
            object bll = Bll_Assembly.CreateInstance("BLL." + className);
            DataTable dt = new DataTable();
            dt = ((DataTable)method.Invoke(bll, null));
            string Filename = FileName + DateTime.Now.ToString("yyyyMMddHHmmss");
            if (dt.Rows.Count > 0)
            {
                ExcelHelper.ExportByWeb(dt, headName, Filename, "1");
                dt.Dispose();
            }
        }
        catch (Exception ex)
        {
            LogService.WriteErrorLog("导出excel的一般处理程序错误：" + ex.Message);
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