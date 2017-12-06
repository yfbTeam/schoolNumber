
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SMSUtility;
using SMSDAL;
using SMSModel;
using SMSIBLL;



namespace SMSBLL
{

	/// </summary>
	///	
	/// </summary>
    public class AlbumPicService:BaseService<AlbumPic>,IAlbumPicService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAlbumPicDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public class ActivityMemService:BaseService<ActivityMem>,IActivityMemService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetActivityMemDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public class AssoActiveService:BaseService<AssoActive>,IAssoActiveService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssoActiveDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public class AssoMemberService:BaseService<AssoMember>,IAssoMemberService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssoMemberDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public class AssoMenuService:BaseService<AssoMenu>,IAssoMenuService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssoMenuDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public class UserInfoService:BaseService<UserInfo>,IUserInfoService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetUserInfoDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public class RoleMenuService:BaseService<RoleMenu>,IRoleMenuService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetRoleMenuDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public class AssoNewService:BaseService<AssoNew>,IAssoNewService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssoNewDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public class AssoTypeService:BaseService<AssoType>,IAssoTypeService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssoTypeDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public class AssoAlbumService:BaseService<AssoAlbum>,IAssoAlbumService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssoAlbumDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public class RoleService:BaseService<Role>,IRoleService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetRoleDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public class RoleUserService:BaseService<RoleUser>,IRoleUserService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetRoleUserDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public class AssoInfoService:BaseService<AssoInfo>,IAssoInfoService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssoInfoDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public class AssoActivityService:BaseService<AssoActivity>,IAssoActivityService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssoActivityDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public class AssoApplyService:BaseService<AssoApply>,IAssoApplyService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssoApplyDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public class GradeClaService:BaseService<GradeCla>,IGradeClaService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetGradeClaDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public class ActivityDataService:BaseService<ActivityData>,IActivityDataService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetActivityDataDal();
        }
		

    }
	
}