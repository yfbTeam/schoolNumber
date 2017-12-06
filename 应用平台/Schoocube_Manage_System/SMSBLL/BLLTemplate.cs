
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
    public class AlbumPicService : BaseService<AlbumPic>, IAlbumPicService
    {
        public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAlbumPicDal();
        }


    }


    /// </summary>
    ///	
    /// </summary>
    public class ActivityMemService : BaseService<ActivityMem>, IActivityMemService
    {
        public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetActivityMemDal();
        }


    }


    /// </summary>
    ///	
    /// </summary>
    public class AssoTypeService : BaseService<AssoType>, IAssoTypeService
    {
        public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssoTypeDal();
        }


    }


    /// </summary>
    ///	
    /// </summary>
    public class AssoActiveService : BaseService<AssoActive>, IAssoActiveService
    {
        public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssoActiveDal();
        }


    }




    /// </summary>
    ///	
    /// </summary>
    public class AssoMemberService : BaseService<AssoMember>, IAssoMemberService
    {
        public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssoMemberDal();
        }


    }


    /// </summary>
    ///	
    /// </summary>
    public class AssoMenuService : BaseService<AssoMenu>, IAssoMenuService
    {
        public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssoMenuDal();
        }


    }


    /// </summary>
    ///	
    /// </summary>
    public class UserInfoService : BaseService<UserInfo>, IUserInfoService
    {
        UserInfoDal dal = new UserInfoDal();
        public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetUserInfoDal();
        }
        public DataTable GetAllUser(string where)
        {
            
            return dal.GetAllUser(where);
        }
        public DataTable GetAllRoleUser(string where)
        {
            return dal.GetAllRoleUser(where);
        }
        public bool ValidateUser(string loginName,string password)
        {
            return dal.ValidateUser(loginName,password);
        }
    }


    /// </summary>
    ///	
    /// </summary>
    public class RoleMenuService : BaseService<RoleMenu>, IRoleMenuService
    {
        RoleMenuDal dal = new RoleMenuDal();
        public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetRoleMenuDal();
        }
        public bool ValidateChecked(string roleId, string menuId)
        {
            return dal.ValidateChecked(roleId,menuId);
        }

        public bool DeleteByRoleAndMenu(string roleId, string menuId)
        {
            return dal.DeleteByRoleAndMenu(roleId, menuId);
        }

    }


    /// </summary>
    ///	
    /// </summary>
    public class AssoActivityService : BaseService<AssoActivity>, IAssoActivityService
    {
        public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssoActivityDal();
        }


    }


    /// </summary>
    ///	
    /// </summary>
    public class AssoNewsService : BaseService<AssoNews>, IAssoNewsService
    {
        public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssoNewsDal();
        }


    }


    /// </summary>
    ///	
    /// </summary>
    public class AssoAlbumService : BaseService<AssoAlbum>, IAssoAlbumService
    {
        public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssoAlbumDal();
        }


    }


    /// </summary>
    ///	
    /// </summary>
    public class AssoInfoService : BaseService<AssoInfo>, IAssoInfoService
    {
        public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssoInfoDal();
        }


    }


    /// </summary>
    ///	
    /// </summary>
    public class AssoApplyService : BaseService<AssoApply>, IAssoApplyService
    {
        public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssoApplyDal();
        }


    }


    /// </summary>
    ///	
    /// </summary>
    public class GradeClassService : BaseService<GradeClass>, IGradeClassService
    {
        public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetGradeClassDal();
        }


    }


    /// </summary>
    ///	
    /// </summary>
    public class RoleService : BaseService<Role>, IRoleService
    {
        public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetRoleDal();
        }


    }


    /// </summary>
    ///	
    /// </summary>
    public class RoleUserService : BaseService<RoleUser>, IRoleUserService
    {
        RoleUserDal dal = new RoleUserDal();
        public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetRoleUserDal();
        }
        public bool DeleteByRoleAndUser(string roleId, string userId)
        {
            return dal.DeleteByRoleAndUser(roleId,userId);
            
        }

    }
    public class ActivityDataService : BaseService<ActivityData>, IActivityDataService
    {
        public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetActivityDataDal();
        }


    }
    public class AssoMemberDelService : BaseService<AssoMemberDel>, IAssoMemberDelService
    {
        public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssoMemberDelDal();
        }


    }
    public class AssoSetService : BaseService<AssoSet>, IAssoSetService
    {
        public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssoSetDal();
        }


    }
    
}