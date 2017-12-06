
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SMSUtility;
using SMSModel;
using System.Configuration;


namespace SMSIDAL
{

	/// </summary>
	///	
	/// </summary>
    public interface IAlbumPicDal: IBaseDal<AlbumPic>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IActivityMemDal: IBaseDal<ActivityMem>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IAssoActiveDal: IBaseDal<AssoActive>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IAssoMemberDal: IBaseDal<AssoMember>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IAssoMenuDal: IBaseDal<AssoMenu>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IUserInfoDal: IBaseDal<UserInfo>
    {
           //DataTable GetAllUser(string condition);
		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IRoleMenuDal: IBaseDal<RoleMenu>
    {

		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IAssoActivityDal: IBaseDal<AssoActivity>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IAssoNewsDal: IBaseDal<AssoNews>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IAssoTypeDal: IBaseDal<AssoType>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IAssoAlbumDal: IBaseDal<AssoAlbum>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IAssoInfoDal: IBaseDal<AssoInfo>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IAssoApplyDal: IBaseDal<AssoApply>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IGradeClassDal: IBaseDal<GradeClass>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IRoleDal: IBaseDal<Role>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IRoleUserDal: IBaseDal<RoleUser>
    {


		
    }

    public interface IActivityDataDal:IBaseDal<ActivityData>
    {

    }

    public interface IAssoMemberDelDal : IBaseDal<AssoMemberDel>
    {

    }
    public interface IAssoSetDal : IBaseDal<AssoSet>
    {

    }
    
}