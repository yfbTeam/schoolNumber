  
using System;
namespace SMSModel
{
    

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class PrepaidCardManagement
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CardNo { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Pwd { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Price { get; set; }
		/// <summary>
		///0未激活;1激活 
		/// </summary>
		public Byte? CardStatus { get; set; }
		/// <summary>
		///0 启用;1 禁用; 
		/// </summary>
		public Byte? UseStatus { get; set; }
		/// <summary>
		///0 正常;1 删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
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
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IdCard { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? PayTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string UserName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Balance { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? AccountPrice { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class FinanceDetail
    {

		/// <summary>
		/// 
		/// </summary>
		public long? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? Money { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? OriginalMoney { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? CanWithdrawMoney { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ProductID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Description { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class System_Favorites
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///0 课程展示 ；1 课程详情 
		/// </summary>
		public int? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? RelationID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Href { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class ResourceReservationCla
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? PId { get; set; }
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
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		///是否删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		///使用状态 
		/// </summary>
		public Byte? UseStatus { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class ResourceReservationInfo
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ResourceId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Address { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Floor { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Room { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string School { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Branch { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Area { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Galleryful { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Image { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CarDriver { get; set; }
		/// <summary>
		///审核状态(0 未审核;1 审核通过;2 审核拒绝;) 
		/// </summary>
		public Byte? ApprovalStutus { get; set; }
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
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		///使用状态 
		/// </summary>
		public Byte? UseStatus { get; set; }
		/// <summary>
		///是否删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ResourceTypeName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OpenTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ClosedTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Model { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string LicensePlate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string SeatNum { get; set; }
		/// <summary>
		///0正常1故障2维修中 
		/// </summary>
		public Byte? Status { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class ResourceReservationManagement
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ResourceTypeId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? TimeIntervalId { get; set; }
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
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		///是否删除(0 正常;1 删除;2归档) 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class System_Timing
    {

		/// <summary>
		/// 
		/// </summary>
		public int? id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string tdesc { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? num { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string time { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Resources_Catagory
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? PID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Targ { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string TargetUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? EditUID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Resources_Chapter
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? PID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CatagoryID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? EditUID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class System_VisitRate
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IP { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Address { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string UserName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Url { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string refer { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ICookie { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class ResourcesInfo
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? DownCount { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CatagoryID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ChapterID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ClickCount { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? EvalueCount { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsOpen { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CheckMessage { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? FileSize { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileIcon { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string postfix { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileGroup { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? EvalueResult { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsVideo { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileIconBig { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class ResourceTimeMappingId
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ResourceId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? TimeIntervalId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///是否删除(0 正常;1 删除) 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? UpdateTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class ResourceType
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Postfixs { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? EditUser { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class SBTQ_AssoActivity
    {

		/// <summary>
		///ID 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///社团ID 
		/// </summary>
		public int? AssoId { get; set; }
		/// <summary>
		///开始时间 
		/// </summary>
		public DateTime? StartTime { get; set; }
		/// <summary>
		///结束时间 
		/// </summary>
		public DateTime? EndTime { get; set; }
		/// <summary>
		///举办地点 
		/// </summary>
		public string ActivityAddress { get; set; }
		/// <summary>
		///动态内容 
		/// </summary>
		public string ActivityContent { get; set; }
		/// <summary>
		///动态标题 
		/// </summary>
		public string ActivityTitle { get; set; }
		/// <summary>
		///审核人ID 
		/// </summary>
		public int? ExamUserId { get; set; }
		/// <summary>
		///审核人 
		/// </summary>
		public string ExamSuggest { get; set; }
		/// <summary>
		///审核状态 
		/// </summary>
		public string ExamStatus { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///创建人ID 
		/// </summary>
		public int? CreateUserId { get; set; }
		/// <summary>
		///资料地址 
		/// </summary>
		public string AttachUrl { get; set; }
		/// <summary>
		///动态图片路径 
		/// </summary>
		public string ActivityImg { get; set; }
		/// <summary>
		///班级ID 
		/// </summary>
		public int? ClassID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class SBTQ_AssoNews
    {

		/// <summary>
		///主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///社团ID 
		/// </summary>
		public int? AssoId { get; set; }
		/// <summary>
		///标题 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		///通知内容 
		/// </summary>
		public string NewsContent { get; set; }
		/// <summary>
		///点击次数 
		/// </summary>
		public int? ClickNumber { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public int? CreateUserId { get; set; }
		/// <summary>
		///关联资料ID 
		/// </summary>
		public int? ActiveId { get; set; }
		/// <summary>
		///班级ID 
		/// </summary>
		public int? ClassID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Schedule
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Content { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? StartDate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EndDate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? AllDay { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? isEndTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class EnterpriseJob
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? EnterID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string MajorIDs { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CourseIDs { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Introduction { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string istrue { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Money { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Treatment { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Region { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Company { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class SchoolStyle
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ImageUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
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
		public int? MenuId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Description { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? SortId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FilePath { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class SomeTableClick
    {

		/// <summary>
		///某些表的点击情况 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///关联表Id 
		/// </summary>
		public int? RelationId { get; set; }
		/// <summary>
		///类型 0 视频资源表（默认）；1 讨论表 
		/// </summary>
		public Byte? Type { get; set; }
		/// <summary>
		///观看时间 
		/// </summary>
		public float? WatchTime { get; set; }
		/// <summary>
		///第一次点击时间 
		/// </summary>
		public DateTime? ClickTime { get; set; }
		/// <summary>
		///最后一次点击时间 
		/// </summary>
		public DateTime? LastTime { get; set; }
		/// <summary>
		///点击次数 
		/// </summary>
		public int? ClickNum { get; set; }
		/// <summary>
		///是否看完过 0 未看完（默认）；1 看完 
		/// </summary>
		public Byte? IsLookEnd { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		///是否删除 0 正常;1 删除;2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class S_Province
    {

		/// <summary>
		/// 
		/// </summary>
		public long? ProvinceID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ProvinceName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? DateCreated { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? DateUpdated { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class StudentTrain
    {

		/// <summary>
		///ID 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		///培训机构名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///学生身份证号 
		/// </summary>
		public string StuIDCard { get; set; }
		/// <summary>
		///入学时间 
		/// </summary>
		public DateTime? StartSchoolDatatime { get; set; }
		/// <summary>
		///毕业时间 
		/// </summary>
		public DateTime? GraduationDatatime { get; set; }
		/// <summary>
		///专业 
		/// </summary>
		public string Major { get; set; }
		/// <summary>
		///学历/学位 
		/// </summary>
		public string Degree { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class S_City
    {

		/// <summary>
		/// 
		/// </summary>
		public long? CityID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CityName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ZipCode { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? ProvinceID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? DateCreated { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? DateUpdated { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class System_Dictionary
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ImageUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class S_District
    {

		/// <summary>
		/// 
		/// </summary>
		public long? DistrictID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string DistrictName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? CityID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? DateCreated { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? DateUpdated { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class System_Link
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ImageUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? SortId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Href { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class NT_Ex_Resumes_Jobs
    {

		/// <summary>
		/// 
		/// </summary>
		public int? JobId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string JobName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ParentId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string JobIndex { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class System_Message
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Contents { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Receiver { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Href { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? isSend { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ReceiverEmail { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreatorName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ReceiverName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Timing { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FilePath { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class S_PCDInfo
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? ProvinceID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ProvinceName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? CityID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CityName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? DistrictID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string DistrictName { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class System_Notice
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Contents { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Hot { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? SortId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ClickNum { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
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
		public string ShowImgUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FilePath { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Root { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? isPush { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class tb
    {

		/// <summary>
		/// 
		/// </summary>
		public string 姓名 { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string 课程 { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? 分数 { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class temp
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Type { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class TimeInterval
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ResourceId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string TimeIntervalName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string TimeManagementId { get; set; }
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
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Editor { get; set; }
		/// <summary>
		///是否删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		///使用状态 
		/// </summary>
		public Byte? UseStatus { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Couse_Selstuinfo
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CourseID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string StuNo { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public short? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string StuName { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class TimeManagement
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EndTime { get; set; }
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
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		///是否删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		///使用状态 
		/// </summary>
		public Byte? UseStatus { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string BeginTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? TimeIntervalId { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Topic
    {

		/// <summary>
		///论题表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///课程编号 
		/// </summary>
		public int? CouseID { get; set; }
		/// <summary>
		///章节编号 
		/// </summary>
		public string ChapterID { get; set; }
		/// <summary>
		///论题名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///论题内容 
		/// </summary>
		public string Contents { get; set; }
		/// <summary>
		///0 讨论（默认）；1 笔记 
		/// </summary>
		public Byte? Type { get; set; }
		/// <summary>
		///点击量 
		/// </summary>
		public int? ClickCount { get; set; }
		/// <summary>
		///GoodCount 
		/// </summary>
		public int? GoodCount { get; set; }
		/// <summary>
		///是否置顶 0 否（默认） ；1 是 
		/// </summary>
		public Byte? IsTop { get; set; }
		/// <summary>
		///是否优秀 0 否（默认） ；1 是 
		/// </summary>
		public Byte? IsGood { get; set; }
		/// <summary>
		///是否共享 0 否（默认） ；1 是 
		/// </summary>
		public Byte? IsShare { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		///是否删除 0 正常;1 删除;2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class AccountInfo
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IdCard { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CardId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Balance { get; set; }
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
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		///0 正常;1 删除; 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? UseStatus { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string UserName { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Topic_Comment
    {

		/// <summary>
		///评论表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///论题Id 
		/// </summary>
		public int? TopicId { get; set; }
		/// <summary>
		///父级评论Id 
		/// </summary>
		public int? Pid { get; set; }
		/// <summary>
		///评论内容 
		/// </summary>
		public string Contents { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		///是否删除 0 正常;1 删除;2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Advertising
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Description { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? MenuId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreativeHTML { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Topic_GoodClick
    {

		/// <summary>
		///点赞表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///关联表Id 
		/// </summary>
		public int? RelationId { get; set; }
		/// <summary>
		///类型 0 讨论表（默认）；1 评价表 
		/// </summary>
		public Byte? Type { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		///是否删除 0 正常;1 删除;2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class AssetManagement
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string AssetModel { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Number { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string AdressName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string UseUnits { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? WarrantyDate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Principal { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? AcquisitionDate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string SourceEquipment { get; set; }
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
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		///0 正常;1 删除;2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		///0 未使用;1 使用 
		/// </summary>
		public Byte? UseStatus { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class TrainingFiles
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string PersonName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string GroupName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string TrainName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Courses { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Exames { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? BeginTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EndTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ClassHour { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string TrainMan { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string TrainResult { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public float? TrainFee { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Status { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class CardPriceHistory
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string UserName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CardId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CardPriceUse { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? AccountPrice { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ConsumptionPrice { get; set; }
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
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		///0 正常;1 删除; 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		///0 使用;1 未使用; 
		/// </summary>
		public Byte? UseStatus { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CardNo { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IdCard { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? ConsumingTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class UserCardInfo
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string UserName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CardId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? PayTime { get; set; }
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
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		///0 启用;1 禁用; 
		/// </summary>
		public Byte? UseStatus { get; set; }
		/// <summary>
		///0 正常;1 删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IdCard { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class CertificateApply
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CertificateID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string StuName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IDCard { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ApplyMessage { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
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
    public partial class CertificateCourse
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CertificateID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CourseID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class WebEntered
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Sex { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Age { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Roots { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IDCard { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Phone { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Address { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Job { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class CertificateExam
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CertificateID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ExamID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public float? Score { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class CertificateList
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Identifier { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IDCard { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CompleteTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IssuingUnit { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IssuedWebSite { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CertificateID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ApplyMessage { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Attachment { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class CertificateManage
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ModelID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Attachment { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class CertificateModol
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ImageUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ModelImage { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class ClassCourse
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		///班级编号 
		/// </summary>
		public int? ClassID { get; set; }
		/// <summary>
		///课程编号 
		/// </summary>
		public int? CourseID { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///是否删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class ClassCourse_Copy
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ClassID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CourseID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ModelID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class ClickDetail
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ResourcesID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? ClickTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? LastTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ClickNum { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///1:点击2评价3下载 
		/// </summary>
		public Byte? ClickType { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Course
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		///课程名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///课程图片 
		/// </summary>
		public string ImageUrl { get; set; }
		/// <summary>
		///课程分类 
		/// </summary>
		public string CatagoryID { get; set; }
		/// <summary>
		///是否收费（0：不收费，1：收费） 
		/// </summary>
		public Byte? IsCharge { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? CoursePrice { get; set; }
		/// <summary>
		///1:选修课2：必修课 
		/// </summary>
		public Byte? CourceType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? StuMaxCount { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CourseSels { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CourseIntro { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? StudyTerm { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string TermName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? StartTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EndTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CourseEvalue { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CourseHardware { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ApplyAttr { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		///选课批次 
		/// </summary>
		public Byte? SelTime { get; set; }
		/// <summary>
		///上课场地 
		/// </summary>
		public string StudyPlace { get; set; }
		/// <summary>
		///主讲老师姓名 
		/// </summary>
		public string LecturerName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Grade { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string GradeName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Class { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string WeekName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CheckMes { get; set; }
		/// <summary>
		///教育学部,艺术学部,服务学部,技术学部 
		/// </summary>
		public string CourseType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? EvalueTimes { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? StudyNumber { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsOpen { get; set; }
		/// <summary>
		///课时数 
		/// </summary>
		public int? LessonPeriod { get; set; }
		/// <summary>
		///课程口令 
		/// </summary>
		public string SecurityCode { get; set; }
		/// <summary>
		///0:自由注册1：口令注册 
		/// </summary>
		public Byte? RigistType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Boutique { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? ClickNum { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Course_Catagory_Delete
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		///类别名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///父节点 
		/// </summary>
		public int? Pid { get; set; }
		/// <summary>
		///类别描述 
		/// </summary>
		public string CatagoryDescription { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Course_Chapter
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		///章节名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///父节点 
		/// </summary>
		public int? Pid { get; set; }
		/// <summary>
		///课程编号 
		/// </summary>
		public int? CourseID { get; set; }
		/// <summary>
		///章节描述 
		/// </summary>
		public string ChapterDescription { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Code { get; set; }
		/// <summary>
		///1:章 2：节 3：课时 4:知识点 
		/// </summary>
		public int? MenuType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Sort { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Course_Chapter_Copy
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Pid { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CourseID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ChapterDescription { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Code { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ModelID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Course_Copy
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ImageUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CatagoryID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsCharge { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? CoursePrice { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? CourceType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? StuMaxCount { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CourseSels { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CourseIntro { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? StudyTerm { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string TermName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? StartTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EndTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CourseEvalue { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CourseHardware { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ApplyAttr { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? SelTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string StudyPlace { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string LecturerName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Grade { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string GradeName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Class { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string WeekName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CheckMes { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CourseType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ModelID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class UpEmailList
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? RelationID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string RelationMsg { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Isdelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Course_Evalue
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CouseID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ChapterID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Evalue { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EvalueCountent { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Course_Modol
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ModoleName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CourceID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ModelMessage { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class PersonDocument
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string DocumentID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Sex { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Photo { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Nation { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Origion { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IDCart { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? BirsDay { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string MaritalStatus { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? joinTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string HalfEdudate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Major { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CompnyType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string PersonIdentity { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CurrentJob { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string JobDegree { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? JobTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? JobYear { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Age { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string SymbolicAnimals { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string SchoolName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string WorkExperience { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FamilyPeople { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string TrainExperience { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ComponyName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string RewardExperience { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string SchoolExperience { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string PoliticalStatus { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? salary { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Course_TaskRel
    {

		/// <summary>
		///课程(章节)任务关系表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///任务ID 
		/// </summary>
		public int? TaskID { get; set; }
		/// <summary>
		///是否完成 0 否（默认） ；1 是 
		/// </summary>
		public Byte? IsComplete { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		///是否删除 0 正常;1 删除;2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Course_Work
    {

		/// <summary>
		///作业表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///课程编号 
		/// </summary>
		public int? CouseID { get; set; }
		/// <summary>
		///章节编号 
		/// </summary>
		public string ChapterID { get; set; }
		/// <summary>
		///知识点id 
		/// </summary>
		public int? PointID { get; set; }
		/// <summary>
		///作业名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///作业要求 
		/// </summary>
		public string Requirement { get; set; }
		/// <summary>
		///开始时间 
		/// </summary>
		public DateTime? StartTime { get; set; }
		/// <summary>
		///截止时间 
		/// </summary>
		public DateTime? EndTime { get; set; }
		/// <summary>
		///附件 
		/// </summary>
		public string Attachment { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		///是否删除 0 正常;1 删除;2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Course_WorkCorrectRel
    {

		/// <summary>
		///作业批改关系表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///作业Id 
		/// </summary>
		public int? WorkId { get; set; }
		/// <summary>
		///作业内容 
		/// </summary>
		public string Contents { get; set; }
		/// <summary>
		///分数 
		/// </summary>
		public int? Score { get; set; }
		/// <summary>
		///分数状态(1优；2良；3中；4差) 
		/// </summary>
		public Byte? ScoreStatus { get; set; }
		/// <summary>
		///批改内容 
		/// </summary>
		public string CorrectContent { get; set; }
		/// <summary>
		///批改人 
		/// </summary>
		public string CorrectUID { get; set; }
		/// <summary>
		///批改时间 
		/// </summary>
		public DateTime? CorrectTime { get; set; }
		/// <summary>
		///附件 
		/// </summary>
		public string Attachment { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		///是否删除 0 正常;1 删除;2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Couse_Resource
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CouseID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ChapterID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ResourcesID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsVideo { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsAllowDown { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string StuRange { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string VidoeImag { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Couse_Selsetting
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? TermID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? SelTime { get; set; }
		/// <summary>
		///1:先到先得2优先级 
		/// </summary>
		public Byte? SelType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsReapeat { get; set; }
		/// <summary>
		///0：待激活1：激活2：停用 
		/// </summary>
		public Byte? Status { get; set; }
		/// <summary>
		///最多选课数量（0为不限制） 
		/// </summary>
		public Byte? SelMaxNum { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///一周设置（0：不设置1特殊设置） 
		/// </summary>
		public Byte? WeekSet { get; set; }
		/// <summary>
		///最少选课数量 
		/// </summary>
		public Byte? SelMinNum { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string TermName { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Couse_SelWeek
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string WeekName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ExcWeek { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? SetID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Couse_TaskInfo
    {

		/// <summary>
		///课程(章节)任务 主键 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		///任务名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///课程编号 
		/// </summary>
		public int? CourseID { get; set; }
		/// <summary>
		///章节编号 
		/// </summary>
		public string ChapterID { get; set; }
		/// <summary>
		///关联表ID 
		/// </summary>
		public int? RelationID { get; set; }
		/// <summary>
		///学生范围 
		/// </summary>
		public string StuRange { get; set; }
		/// <summary>
		///开始时间 
		/// </summary>
		public DateTime? StartTime { get; set; }
		/// <summary>
		///结束时间 
		/// </summary>
		public DateTime? EndTime { get; set; }
		/// <summary>
		///任务类型 0学资源(默认)；1试卷；2讨论；3作业；4调查问卷 
		/// </summary>
		public Byte? Type { get; set; }
		/// <summary>
		///权重 
		/// </summary>
		public int? Weight { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///是否删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Couse_TaskInfo_Copy
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CourseID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ChapterID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? RelationID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string StuRange { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? StartTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EndTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Weight { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ModelID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class DBBackUpLog
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Path { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Type { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Enterprise
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string RelationName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string RelationPhone { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string RelationEmail { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? RecruitNum { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Address { get; set; }
		/// <summary>
		///企业简介 
		/// </summary>
		public string Introduction { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class sysdiagrams
    {

		/// <summary>
		/// 
		/// </summary>
		public string name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? principal_id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? diagram_id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? version { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public byte[] definition { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Exam_ExamAnswer
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ExamID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? QuestionID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ExampaperID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Answer { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? Score { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Exam_Examination
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string UserName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ExampaperID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? Score { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Marker { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? AnswerBeginTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? AnswerEndTime { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Exam_ExamPaper
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Klpoint { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Book { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? FullScore { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ExamTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Difficulty { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ClassID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? WorkBeginTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? WorkEndTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsRelease { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Author { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string evaluate { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Exam_ExamPaperObjQ
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ExampaperID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Content { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionA { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionB { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionC { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionD { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionE { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionF { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Difficulty { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Answer { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? Score { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsShowAnalysis { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Analysis { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? OrderID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Exam_ExamPaperSubQ
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ExampaperID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Content { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Answer { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? OrderID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Analysis { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Difficulty { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsShowAnalysis { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? Score { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class System_UserOnLine
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string UserName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IP { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateDate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ICookie { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Photo { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Exam_ExamType
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string QType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Template { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class TrainCourse
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? TrainID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CourseID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Exam_ObjQuestion
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Klpoint { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Book { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Content { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionA { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionB { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionC { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionD { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionE { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string OptionF { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Answer { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Difficulty { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Analysis { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsShowAnalysis { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Author { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? Score { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Major { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Style { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Questions { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Exam_SubQuestion
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Type { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Klpoint { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Book { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Content { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Answer { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Difficulty { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Status { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Analysis { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsShowAnalysis { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Author { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public decimal? Score { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Major { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Style { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Questions { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class TrainExam
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? TrainID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ExamID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public float? Score { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class JobClass
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? JobID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CourseID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class JobTopic
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? JobID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Contents { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? EnID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class JobTopic_Comment
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? TopicId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Contents { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class LibraryList
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Question { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string MenuID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Answer { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class LibraryMenu
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Pid { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
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
    public partial class MonitorRecord
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? RequestDate { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? RequestType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string RequestSourceID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? RequestCount { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string RequestUrl { get; set; }
		/// <summary>
		///内部学员、外部学员 
		/// </summary>
		public int? RequestUserType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IP { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string RequestAddress { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string RequestSourceName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IDCard { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class MyResource
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		///网盘ID 
		/// </summary>
		public int? PID { get; set; }
		/// <summary>
		///文件名称 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		///是否文件夹 
		/// </summary>
		public int? IsFolder { get; set; }
		/// <summary>
		///文件地址 
		/// </summary>
		public string FileUrl { get; set; }
		/// <summary>
		///文件大小 
		/// </summary>
		public int? FileSize { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileIcon { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string code { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string postfix { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileIconBig { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Notice_Course
    {

		/// <summary>
		///课程通知表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///标题 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		///内容 
		/// </summary>
		public string Contents { get; set; }
		/// <summary>
		///是否置顶 0 否（默认） ；1 是 
		/// </summary>
		public Byte? IsTop { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		///是否删除 0 正常;1 删除;2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class ResourceReservation
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ReSourceInfoId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ReSourceClassId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? AppoIntmentTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string TimeInterval { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string School { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Branch { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Telephone { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string PitchNumber { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string LimitPeople { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string AppoIntmentPeople { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Address { get; set; }
		/// <summary>
		///审批状态(0 待审批 ;1 审批;2 无需审批;) 
		/// </summary>
		public Byte? ApprovalStutus { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ApprovalOpinion { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Remark { get; set; }
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
		public DateTime? UpdateTime { get; set; }
		/// <summary>
		///是否删除 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		///使用状态 
		/// </summary>
		public Byte? UseStatus { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Applicant { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Reason { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? AppoIntmentBeginTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? AppoIntmentEndTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IDCard { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ApprovalPeople { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Notice_CourseSeeRel
    {

		/// <summary>
		///课程通知查看关系表 主键 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		///课程通知表Id 
		/// </summary>
		public int? NoticeId { get; set; }
		/// <summary>
		///点击次数 默认0 
		/// </summary>
		public int? ClickNum { get; set; }
		/// <summary>
		///创建人 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		///创建时间 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		///修改人 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		///修改时间 
		/// </summary>
		public DateTime? EidtTime { get; set; }
		/// <summary>
		///是否删除 0 正常;1 删除;2归档 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class PortalMenuDroit
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? MenuId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string LoginName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Email { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? RoleType { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Couse_Resource_Copy
    {

		/// <summary>
		/// 
		/// </summary>
		public int? ID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CouseID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ChapterID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ResourcesID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsVideo { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsAllowDown { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string StuRange { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreateUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EditUID { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? EditTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string VidoeImag { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ModelID { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class PortalTreeData
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Display { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? PId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string BeforeUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? BeforeAfter { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string AfterUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? SortId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EnName { get; set; }
    }
}
