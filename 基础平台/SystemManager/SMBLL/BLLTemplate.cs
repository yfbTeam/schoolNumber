
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SMUtility;
using SMDAL;
using SMModel;
using SMIBLL;



namespace SMBLL
{

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_ClassInfoService:BaseService<Plat_ClassInfo>,IPlat_ClassInfoService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_ClassInfoDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_DistrictService:BaseService<Plat_District>,IPlat_DistrictService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_DistrictDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_GradeService:BaseService<Plat_Grade>,IPlat_GradeService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_GradeDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_GradeOfSubjectService:BaseService<Plat_GradeOfSubject>,IPlat_GradeOfSubjectService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_GradeOfSubjectDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_InterfaceService:BaseService<Plat_Interface>,IPlat_InterfaceService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_InterfaceDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_LogInfoService:BaseService<Plat_LogInfo>,IPlat_LogInfoService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_LogInfoDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_MajorService:BaseService<Plat_Major>,IPlat_MajorService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_MajorDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_MenuInfoService:BaseService<Plat_MenuInfo>,IPlat_MenuInfoService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_MenuInfoDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_PeriodService:BaseService<Plat_Period>,IPlat_PeriodService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_PeriodDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_PeriodOfSubjectService:BaseService<Plat_PeriodOfSubject>,IPlat_PeriodOfSubjectService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_PeriodOfSubjectDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_RoleService:BaseService<Plat_Role>,IPlat_RoleService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_RoleDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_RoleOfMenuService:BaseService<Plat_RoleOfMenu>,IPlat_RoleOfMenuService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_RoleOfMenuDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_RoleOfUserService:BaseService<Plat_RoleOfUser>,IPlat_RoleOfUserService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_RoleOfUserDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_SchoolService:BaseService<Plat_School>,IPlat_SchoolService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_SchoolDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_SchoolOfPeriodService:BaseService<Plat_SchoolOfPeriod>,IPlat_SchoolOfPeriodService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_SchoolOfPeriodDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_StudentService:BaseService<Plat_Student>,IPlat_StudentService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_StudentDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_StudySectionService:BaseService<Plat_StudySection>,IPlat_StudySectionService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_StudySectionDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_SubjectService:BaseService<Plat_Subject>,IPlat_SubjectService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_SubjectDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_SysIndentifyService:BaseService<Plat_SysIndentify>,IPlat_SysIndentifyService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_SysIndentifyDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_SysOfInter_RelService:BaseService<Plat_SysOfInter_Rel>,IPlat_SysOfInter_RelService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_SysOfInter_RelDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_SysOfMenu_RelService:BaseService<Plat_SysOfMenu_Rel>,IPlat_SysOfMenu_RelService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_SysOfMenu_RelDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_SystemInfoService:BaseService<Plat_SystemInfo>,IPlat_SystemInfoService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_SystemInfoDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_TeacherService:BaseService<Plat_Teacher>,IPlat_TeacherService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_TeacherDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_TeacherOfClassOfSubjectService:BaseService<Plat_TeacherOfClassOfSubject>,IPlat_TeacherOfClassOfSubjectService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_TeacherOfClassOfSubjectDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_TextbookService:BaseService<Plat_Textbook>,IPlat_TextbookService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_TextbookDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_TextbookCatalogService:BaseService<Plat_TextbookCatalog>,IPlat_TextbookCatalogService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_TextbookCatalogDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_TextbookVersionService:BaseService<Plat_TextbookVersion>,IPlat_TextbookVersionService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_TextbookVersionDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Plat_UserOfSystemService:BaseService<Plat_UserOfSystem>,IPlat_UserOfSystemService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPlat_UserOfSystemDal();
        }
		

    }
	
}