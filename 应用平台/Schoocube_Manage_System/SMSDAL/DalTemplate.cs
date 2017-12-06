
using SMSIDAL;
using SMSModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSDAL
{



	/// </summary>
	///	
	/// </summary>
		 public class AlbumPicDal:BaseDal<AlbumPic>,IAlbumPicDal
    {


    }	

      public partial class DalFactory
    {
        public static IAlbumPicDal GetAlbumPicDal()
        {
            return new AlbumPicDal();
        }
	}



	/// </summary>
	///	
	/// </summary>
		 public class ActivityMemDal:BaseDal<ActivityMem>,IActivityMemDal
    {


    }	

      public partial class DalFactory
    {
        public static IActivityMemDal GetActivityMemDal()
        {
            return new ActivityMemDal();
        }
	}



	/// </summary>
	///	
	/// </summary>
		 public class AssoActiveDal:BaseDal<AssoActive>,IAssoActiveDal
    {


    }	

      public partial class DalFactory
    {
        public static IAssoActiveDal GetAssoActiveDal()
        {
            return new AssoActiveDal();
        }
	}



	/// </summary>
	///	
	/// </summary>
		 public class AssoMemberDal:BaseDal<AssoMember>,IAssoMemberDal
    {


    }	

      public partial class DalFactory
    {
        public static IAssoMemberDal GetAssoMemberDal()
        {
            return new AssoMemberDal();
        }
	}



	/// </summary>
	///	
	/// </summary>
		 public class AssoMenuDal:BaseDal<AssoMenu>,IAssoMenuDal
    {


    }	

      public partial class DalFactory
    {
        public static IAssoMenuDal GetAssoMenuDal()
        {
            return new AssoMenuDal();
        }
	}



	/// </summary>
	///	
	/// </summary>
		 public class UserInfoDal:BaseDal<UserInfo>,IUserInfoDal
    {


    }	

      public partial class DalFactory
    {
        public static IUserInfoDal GetUserInfoDal()
        {
            return new UserInfoDal();
        }
	}



	/// </summary>
	///	
	/// </summary>
		 public class RoleMenuDal:BaseDal<RoleMenu>,IRoleMenuDal
    {


    }	

      public partial class DalFactory
    {
        public static IRoleMenuDal GetRoleMenuDal()
        {
            return new RoleMenuDal();
        }
	}



	/// </summary>
	///	
	/// </summary>
		 public class AssoNewDal:BaseDal<AssoNew>,IAssoNewDal
    {


    }	

      public partial class DalFactory
    {
        public static IAssoNewDal GetAssoNewDal()
        {
            return new AssoNewDal();
        }
	}



	/// </summary>
	///	
	/// </summary>
		 public class AssoTypeDal:BaseDal<AssoType>,IAssoTypeDal
    {


    }	

      public partial class DalFactory
    {
        public static IAssoTypeDal GetAssoTypeDal()
        {
            return new AssoTypeDal();
        }
	}



	/// </summary>
	///	
	/// </summary>
		 public class AssoAlbumDal:BaseDal<AssoAlbum>,IAssoAlbumDal
    {


    }	

      public partial class DalFactory
    {
        public static IAssoAlbumDal GetAssoAlbumDal()
        {
            return new AssoAlbumDal();
        }
	}



	/// </summary>
	///	
	/// </summary>
		 public class RoleDal:BaseDal<Role>,IRoleDal
    {


    }	

      public partial class DalFactory
    {
        public static IRoleDal GetRoleDal()
        {
            return new RoleDal();
        }
	}



	/// </summary>
	///	
	/// </summary>
		 public class RoleUserDal:BaseDal<RoleUser>,IRoleUserDal
    {


    }	

      public partial class DalFactory
    {
        public static IRoleUserDal GetRoleUserDal()
        {
            return new RoleUserDal();
        }
	}



	/// </summary>
	///	
	/// </summary>
		 public class AssoInfoDal:BaseDal<AssoInfo>,IAssoInfoDal
    {


    }	

      public partial class DalFactory
    {
        public static IAssoInfoDal GetAssoInfoDal()
        {
            return new AssoInfoDal();
        }
	}



	/// </summary>
	///	
	/// </summary>
		 public class AssoActivityDal:BaseDal<AssoActivity>,IAssoActivityDal
    {


    }	

      public partial class DalFactory
    {
        public static IAssoActivityDal GetAssoActivityDal()
        {
            return new AssoActivityDal();
        }
	}



	/// </summary>
	///	
	/// </summary>
		 public class AssoApplyDal:BaseDal<AssoApply>,IAssoApplyDal
    {


    }	

      public partial class DalFactory
    {
        public static IAssoApplyDal GetAssoApplyDal()
        {
            return new AssoApplyDal();
        }
	}



	/// </summary>
	///	
	/// </summary>
		 public class GradeClaDal:BaseDal<GradeCla>,IGradeClaDal
    {


    }	

      public partial class DalFactory
    {
        public static IGradeClaDal GetGradeClaDal()
        {
            return new GradeClaDal();
        }
	}



	/// </summary>
	///	
	/// </summary>
		 public class ActivityDataDal:BaseDal<ActivityData>,IActivityDataDal
    {


    }	

      public partial class DalFactory
    {
        public static IActivityDataDal GetActivityDataDal()
        {
            return new ActivityDataDal();
        }
	}
}