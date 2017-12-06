  
using System;
namespace SMSModel
{
    

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class AlbumPic
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? AlbumId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string PicUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ActiveId { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class ActivityMem
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? UserId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ActivityId { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class AssoActive
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
		public string ActiveUrl { get; set; }
    }


    //public partial class ActivityData
    //{
    //    public int? Id { get; set; }
    //    public int? AssoId { get; set; }
    //    public int? ActivityId { get; set; }

    //    public DateTime? CreatedTime { get; set; }
        
    //    public string DataUrl { get; set; }
    //    public string DataTitle { get; set; }
    //    public int? DataType { get; set; }
    //    public int? CreatedUserId { get; set; }
    //}
	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class AssoMember
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? AssoId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? UserId { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class AssoMenu
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string MenuUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string MenuTitle { get; set; }


        public int? Pid { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class UserInfo
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
		public string LoginName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Password { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Email { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Sex { get; set; }
		/// <summary>
		/// 
		/// </summary>
        public int? ClassId { get; set; }

        public string ImgUrl { get; set; }
    }



	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class RoleMenu
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? RoleId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? MenuId { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class AssoNews
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? AssoId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string NewsContent { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ClickNumber { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CreateUserId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ActiveId { get; set; }
    }

		/// </summary>
		/// 
		/// </summary>
	[Serializable]
    public partial class AssoType
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Title { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class AssoAlbum
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? AssoId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string AlbumName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string AlbumDescription { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CreateUserId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FirstPicUrl { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Role
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string RoleName { get; set; }
    }

		/// </summary>
		/// 
		/// </summary>
	[Serializable]
    public partial class RoleUser
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? UserId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? RoleId { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class AssoInfo
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string AssoName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string AssoSlogan { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string AssoIntroduce { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? AssoLeaderId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? AssoLeaderSecondId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string AssoType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string AssoStatus { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CreateUserId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string AssoPicURL { get; set; }

        /// <summary>
		/// 
		/// </summary>
        public string AssoBackPicUrl { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public int? PersonLimit { get; set; }
        

        /// <summary>
        /// 
        /// </summary>
        public string SexLimit { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public int? GradeLimit { get; set; }
        
        
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class AssoActivity
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? AssoId { get; set; }
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
		public string ActivityAddress { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ActivityContent { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ActivityTitle { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ExamUserId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ExamSuggest { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ExamStatus { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CreateUserId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string AttachUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ActivityImg { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class AssoApply
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? AssoId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ApplyUserId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Introduce { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? ApplyTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ApplyStatus { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ApplySuggest { get; set; }
        /// <summary>
		/// 
        /// </summary>
        public int? ExamUserId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ApplyType { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class GradeClass
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Pid { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ClassName { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class ActivityData
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? AssoId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ActivityId { get; set; }
		/// <summary>
		/// 
	/// </summary>
		public string DataUrl { get; set; }
		/// <summary>
	///	
	/// </summary>
		public string DataTitle { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreatedTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? CreatedUserId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string DataType { get; set; }
    }
    
    	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class AssoMemberDel
    {

		/// <summary>
		/// 
		/// </summary>
		public int Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int UserId { get; set; }
		/// <summary>
		/// 
		/// </summary>
        public int AssoId { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int CreateUserId { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public DateTime? CreatedTime { get; set; }

    }
      	/// </summary>
	///	
	/// </summary>
    [Serializable]
    public partial class AssoSet
    {

        /// <summary>
        /// 
        /// </summary>
        public int Id { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int? IsOnly { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public DateTime StartDate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public DateTime EndDate { get; set; }
    }
}
