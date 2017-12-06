using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSUtility
{
    /// <summary>
    /// 系统所有模块
    /// </summary>
    public class LogConstants
    {
        /// <summary>
        /// 登录模块
        /// </summary>
        public static string login = "用户登录模块";
        /// <summary>
        /// 教师信息管理
        /// </summary>
        public static string jsxxgl = "教师信息管理";
        /// <summary>
        /// 学生信息管理
        /// </summary>
        public static string xsxxgl = "学生信息管理";
        /// <summary>
        /// 家长信息管理
        /// </summary>
        public static string jzxxgl = "家长信息管理";
        /// <summary>
        /// 组织机构管理
        /// </summary>
        public static string zzjggl = "组织机构管理";
        /// <summary>
        /// 年级管理
        /// </summary>
        public static string njgl = "年级管理";
        /// <summary>
        /// 班级管理
        /// </summary>
        public static string bjgl = "班级管理";
        /// <summary>
        /// 学科信息
        /// </summary>
        public static string xkxx = "学科信息";
        /// <summary>
        /// 学科管理
        /// </summary>
        public static string xkgl = "学科管理";
        /// <summary>
        /// 角色管理
        /// </summary>
        public static string jsgl = "管理员设置";
        /// <summary>
        /// 教研组管理
        /// </summary>
        public static string jyzgl = "教研组管理";
        /// <summary>
        /// 系统账号管理
        /// </summary>
        public static string xtzhgl = "系统模块管理";
        /// <summary>
        /// 接口信息管理
        /// </summary>
        public static string jkxxgl = "接口信息管理";
        /// <summary>
        /// 接口权限管理
        /// </summary>
        public static string jkqxgl = "接口权限管理";
        /// <summary>
        /// 学年学期管理
        /// </summary>
        public static string xnxqgl = "学年学期管理";
        /// <summary>
        /// 修改密码管理
        /// </summary>
        public static string xgmmgl = "修改密码管理";
        /// <summary>
        /// 菜单管理
        /// </summary>
        public static string menumanage = "菜单管理"; 
        /// <summary>
        /// 日志管理
        /// </summary>
        public static string czrzgl = "操作日志管理"; 
    }
    /// <summary>
    /// 
    /// </summary>
    public class ActionConstants
    {
        /// <summary>
        /// 登录
        /// </summary>
        public static string Actionlogin = "登录";
        /// <summary>
        /// 导入
        /// </summary>
        public static string dr = "教师Excel导入";
        public static string exceldc = "教师Excel导出";

        public static string add = "添加";
        public static string Search = "查询";
        public static string xg = "修改";
        public static string del = "删除";


        public static string jy = "禁用";
        public static string qy = "启用";
        public static string czmm = "重置密码";
        public static string jb = "解绑";

        public static string xsup = "学生升级";
        public static string xsdown = "学生降级";
        public static string excelfb = "Excel分班";
        public static string xzmb = "下载模板";
        public static string xsesceldr = "学生Excel导入";

        public static string tjxxxx = "添加学校信息";
        public static string xgxxxx = "修改学校信息";


        public static string glysz = "管理员设置";

        public static string pltj = "批量添加";

        public static string tjrydjyz = "添加人员到教研组";

        public static string xgpwd = "修改密码";
    }
}
