
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SMSModel;


namespace SMSIBLL
{

	/// </summary>
	///	
	/// </summary>
    public interface IAlbumPicService:IBaseService<AlbumPic>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface IActivityMemService:IBaseService<ActivityMem>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface IAssoActiveService:IBaseService<AssoActive>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface IAssoMemberService:IBaseService<AssoMember>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface IAssoMenuService:IBaseService<AssoMenu>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface IUserInfoService:IBaseService<UserInfo>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface IRoleMenuService:IBaseService<RoleMenu>
    {

    }
	
    public interface IActivityDataService:IBaseService<ActivityData>
    {

    }

	/// </summary>
	///	
	/// </summary>
    public interface IAssoNewsService:IBaseService<AssoNews>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface IAssoTypeService:IBaseService<AssoType>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface IAssoAlbumService:IBaseService<AssoAlbum>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface IRoleService:IBaseService<Role>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface IRoleUserService:IBaseService<RoleUser>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface IAssoInfoService:IBaseService<AssoInfo>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface IAssoActivityService:IBaseService<AssoActivity>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface IAssoApplyService:IBaseService<AssoApply>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface IGradeClassService:IBaseService<GradeClass>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface IAssoMemberDelService : IBaseService<AssoMemberDel>
    {

    }
	/// </summary>
	///	
	/// </summary>
    public interface IAssoSetService : IBaseService<AssoSet>
    {

    }
	
}