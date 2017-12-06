  
using System;
namespace SMModel
{
    

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_ClassInfo
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///班号 
		/// </summary>
		public string ClassNO { get; set; }
		/// <summary>
		///班级名称 
		/// </summary>
		public string ClassName { get; set; }
		/// <summary>
		///班主任工号 
		/// </summary>
		public string HeadteacherNO { get; set; }
		/// <summary>
		///班长学号 
		/// </summary>
		public string MonitorNO { get; set; }
		/// <summary>
		///学制 
		/// </summary>
		public Byte? XZ { get; set; }
		/// <summary>
		///文理类型 0文科 1理科 
		/// </summary>
		public Byte? CultureScienceType { get; set; }
		/// <summary>
		///学校ID 
		/// </summary>
		public int? SchoolID { get; set; }
		/// <summary>
		///班级ID 
		/// </summary>
		public int? GradeID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///备注 
		/// </summary>
		public string Remarks { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		///专业ID 
		/// </summary>
		public int? MajorID { get; set; }
		/// <summary>
		///建班年月 
		/// </summary>
		public DateTime? CreateClassDate { get; set; }
		/// <summary>
		///毕业时间 
		/// </summary>
		public DateTime? GraduationDate { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_District
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///区县名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_Grade
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///年级名称 
		/// </summary>
		public string GradeName { get; set; }
		/// <summary>
		///学段ID 
		/// </summary>
		public int? PeriodID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		///备注 
		/// </summary>
		public string Remarks { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_GradeOfSubject
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///年级ID 
		/// </summary>
		public int? GradeID { get; set; }
		/// <summary>
		///科目ID 
		/// </summary>
		public int? SubjectID { get; set; }
		/// <summary>
		///学校ID 
		/// </summary>
		public int? SchoolID { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_Interface
    {

		/// <summary>
		///接口表 主键  
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///接口名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Description { get; set; }
		/// <summary>
		///服务页面 
		/// </summary>
		public string ServicePage { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///是否删除 0正常1删除2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_LogInfo
    {

		/// <summary>
		///日志表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///用户登录名 
		/// </summary>
		public string LoginName { get; set; }
		/// <summary>
		///当前IP 
		/// </summary>
		public string IP { get; set; }
		/// <summary>
		///模块 
		/// </summary>
		public string Module { get; set; }
		/// <summary>
		///操作类型  登录；查询；新增；修改；删除 
		/// </summary>
		public string Type { get; set; }
		/// <summary>
		///操作内容 （方法描述[方法名称]） 
		/// </summary>
		public string Operation { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///备注 
		/// </summary>
		public string Remarks { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_Major
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///专业名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///学校ID 
		/// </summary>
		public int? SchoolID { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_MenuInfo
    {

		/// <summary>
		///菜单信息表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///菜单名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///菜单code 
		/// </summary>
		public string MenuCode { get; set; }
		/// <summary>
		///父级Id 
		/// </summary>
		public int? Pid { get; set; }
		/// <summary>
		///菜单Url 
		/// </summary>
		public string Url { get; set; }
		/// <summary>
		///菜单描述 
		/// </summary>
		public string Description { get; set; }
		/// <summary>
		///是否菜单 0.菜单(默认)；1.按钮 
		/// </summary>
		public Byte? IsMenu { get; set; }
		/// <summary>
		///是否显示菜单  0.不显示;1.显示导航;2.显示权限列表;3.都显示 
		/// </summary>
		public Byte? IsShow { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_Period
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///学段名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_PeriodOfSubject
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///学段ID 
		/// </summary>
		public int? PeriodID { get; set; }
		/// <summary>
		///科目ID 
		/// </summary>
		public int? SubjectID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_Role
    {

		/// <summary>
		///角色表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///角色名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///系统Key 
		/// </summary>
		public string SystemKey { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///是否删除 0正常1删除2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_RoleOfMenu
    {

		/// <summary>
		///角色菜单关系表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///角色Id 
		/// </summary>
		public int? RoleId { get; set; }
		/// <summary>
		///菜单Id 
		/// </summary>
		public int? MenuId { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_RoleOfUser
    {

		/// <summary>
		///角色用户关系表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///角色Id 
		/// </summary>
		public int? RoleId { get; set; }
		/// <summary>
		///用户身份证号 
		/// </summary>
		public string UserIDCard { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_School
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///学校名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///学校地址 
		/// </summary>
		public string Address { get; set; }
		/// <summary>
		///校长工号 
		/// </summary>
		public string PrincipalNumber { get; set; }
		/// <summary>
		///校长姓名 
		/// </summary>
		public string PrincipalName { get; set; }
		/// <summary>
		///联系电话 
		/// </summary>
		public string Phone { get; set; }
		/// <summary>
		///传真电话 
		/// </summary>
		public string Fax { get; set; }
		/// <summary>
		///电子信箱 
		/// </summary>
		public string Email { get; set; }
		/// <summary>
		///主页地址 
		/// </summary>
		public string Homepage { get; set; }
		/// <summary>
		///幼儿园学制 0不是 1是 
		/// </summary>
		public Byte? YEYXZ { get; set; }
		/// <summary>
		///小学学制 0不是 1是 
		/// </summary>
		public Byte? XXXZ { get; set; }
		/// <summary>
		///初中学制 0不是 1是 
		/// </summary>
		public Byte? CZXZ { get; set; }
		/// <summary>
		///高中学制 0不是 1是 
		/// </summary>
		public Byte? GZXZ { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		///备注 
		/// </summary>
		public string Remarks { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_SchoolOfPeriod
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///学校ID 
		/// </summary>
		public int? SchoolID { get; set; }
		/// <summary>
		///学段ID 
		/// </summary>
		public int? PeriodID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_Student
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
		///学号 
		/// </summary>
		public string SchoolNO { get; set; }
		/// <summary>
		///登录账号 
		/// </summary>
		public string LoginName { get; set; }
		/// <summary>
		///学校ID 
		/// </summary>
		public int? SchoolID { get; set; }
		/// <summary>
		///用户状态 0 启用 1禁用 
		/// </summary>
		public Byte? State { get; set; }
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
		///年龄 
		/// </summary>
		public Byte? Age { get; set; }
		/// <summary>
		///照片 
		/// </summary>
		public string Photo { get; set; }
		/// <summary>
		///年级ID 
		/// </summary>
		public int? GradeID { get; set; }
		/// <summary>
		///现住址 
		/// </summary>
		public string Address { get; set; }
		/// <summary>
		///最近登录时间 
		/// </summary>
		public DateTime? LatelyLoginTime { get; set; }
		/// <summary>
		///登录IP 
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
		///备注 
		/// </summary>
		public string Remarks { get; set; }
		/// <summary>
		///昵称 
		/// </summary>
		public string Nickname { get; set; }
		/// <summary>
		///班级ID 
		/// </summary>
		public int? ClassID { get; set; }
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
		/// <summary>
		///联系电话 
		/// </summary>
		public string Phone { get; set; }
		/// <summary>
		///邮箱 
		/// </summary>
		public string Email { get; set; }
		/// <summary>
		///固定电话 
		/// </summary>
		public string fixPhone { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_StudySection
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///学年 
		/// </summary>
		public string Academic { get; set; }
		/// <summary>
		///学期（名称） 
		/// </summary>
		public string Semester { get; set; }
		/// <summary>
		///开始时间 
		/// </summary>
		public DateTime? SStartDate { get; set; }
		/// <summary>
		///结束时间 
		/// </summary>
		public DateTime? SEndDate { get; set; }
		/// <summary>
		///学校ID 
		/// </summary>
		public int? SchoolID { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_Subject
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///科目名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_SysIndentify
    {

		/// <summary>
		///系统模块表 Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///系统Key 
		/// </summary>
		public string SystemKey { get; set; }
		/// <summary>
		///模块名称 
		/// </summary>
		public string InfName { get; set; }
		/// <summary>
		///模块Key 
		/// </summary>
		public string InfKey { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///是否删除 0正常1删除2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_SysOfInter_Rel
    {

		/// <summary>
		///系统模块与接口关系表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///系统模块Id 
		/// </summary>
		public int? IndentifyId { get; set; }
		/// <summary>
		///接口Id 
		/// </summary>
		public int? InterfaceId { get; set; }
		/// <summary>
		///返回字段 
		/// </summary>
		public string ReturnField { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_SysOfMenu_Rel
    {

		/// <summary>
		///系统与菜单关系表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///系统Key 
		/// </summary>
		public string SystemKey { get; set; }
		/// <summary>
		///菜单Id 
		/// </summary>
		public int? MenuId { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_SystemInfo
    {

		/// <summary>
		///系统信息表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///区县 
		/// </summary>
		public string Region { get; set; }
		/// <summary>
		///学校Id 
		/// </summary>
		public int? SchoolId { get; set; }
		/// <summary>
		///系统名称 
		/// </summary>
		public string SystemName { get; set; }
		/// <summary>
		///系统Key 
		/// </summary>
		public string SystemKey { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///是否删除 0正常1删除2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_Teacher
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
		/// <summary>
		///邮箱 
		/// </summary>
		public string Email { get; set; }
		/// <summary>
		///简介 
		/// </summary>
		public string BriefIntroduction { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_TeacherOfClassOfSubject
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///教师身份证号 
		/// </summary>
		public string TeacherIDCard { get; set; }
		/// <summary>
		///班级ID 
		/// </summary>
		public int? ClassID { get; set; }
		/// <summary>
		///学科ID 
		/// </summary>
		public int? SubjectID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_Textbook
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///教材名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///版本ID 
		/// </summary>
		public int? VersionID { get; set; }
		/// <summary>
		///科目ID 
		/// </summary>
		public int? SubjectID { get; set; }
		/// <summary>
		///学段ID 
		/// </summary>
		public int? PeriodID { get; set; }
		/// <summary>
		///年级ID 
		/// </summary>
		public int? GradeID { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_TextbookCatalog
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///目录名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///上级ID 
		/// </summary>
		public int? PID { get; set; }
		/// <summary>
		///教材ID 
		/// </summary>
		public int? TextbooxID { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_TextbookVersion
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///版本名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Plat_UserOfSystem
    {

		/// <summary>
		///Id 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///用户ID 
		/// </summary>
		public string LoginName { get; set; }
		/// <summary>
		///系统ID 
		/// </summary>
		public int? SystemID { get; set; }
		/// <summary>
		///用户状态 0启用 1禁用 
		/// </summary>
		public Byte? UserStatus { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///是否删除 0正常 1删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }
}
