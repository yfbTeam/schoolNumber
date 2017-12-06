using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMModel
{
    //public class Student
    //{
    //    public int Id { get; set; }

    //    public string Name { get; set; }

    //    public int? Age { get; set; }

    //    public int ClassId { get; set; }

    //    public string Email { get; set; }
    //}
    public partial class Plat_UserModel
    {

        /// <summary>
        ///Id 
        /// </summary>
        public int? Id { get; set; }
        /// <summary>
        ///身份证件号 
        /// </summary>
        public string IDCard { get; set; }
        /// <summary>
        ///用户账号 
        /// </summary>
        public string LoginName { get; set; }
        /// <summary>
        ///学校Id 
        /// </summary>
        public int? SchoolID { get; set; }
        /// <summary>
        ///用户状态  0启用 1禁用 
        /// </summary>
        public Byte? State { get; set; }
        /// <summary>
        ///工号 
        /// </summary>
        public string JobNumber { get; set; }
        /// <summary>
        ///姓名 
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        ///性别 0男 1女 
        /// </summary>
        public Byte? Sex { get; set; }
        /// <summary>
        ///出生日期 
        /// </summary>
        public DateTime? Birthday { get; set; }
        /// <summary>
        ///照片 
        /// </summary>
        public string Photo { get; set; }
        /// <summary>
        ///现住址 
        /// </summary>
        public string Address { get; set; }
        /// <summary>
        ///联系电话 
        /// </summary>
        public string Phone { get; set; }
        /// <summary>
        ///备注 
        /// </summary>
        public string Remarks { get; set; }
        /// <summary>
        ///最近登录时间 
        /// </summary>
        public DateTime? LatelyLoginTime { get; set; }
        /// <summary>
        ///登录IP地址 
        /// </summary>
        public string LoginIP { get; set; }
        /// <summary>
        ///登录标识码 
        /// </summary>
        public string LoginKey { get; set; }
        /// <summary>
        ///修改时间 
        /// </summary>
        public DateTime? UpdateTime { get; set; }
        /// <summary>
        ///年龄 
        /// </summary>
        public Byte? Age { get; set; }
        /// <summary>
        ///昵称 
        /// </summary>
        public string Nickname { get; set; }
        /// <summary>
        ///系统Key 
        /// </summary>
        public string SystemKey { get; set; }
        /// <summary>
        ///密码 
        /// </summary>
        public string Password { get; set; }
        /// <summary>
        ///是否删除 0正常 1删除 
        /// </summary>
        public Byte? IsDelete { get; set; }

        public string __VIEWSTATE { get; set; }

        public string VIEWSTATE { get; set; }
    }
}
