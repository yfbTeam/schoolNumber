
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
    public partial class PrepaidCardManagementService:BaseService_HZ<PrepaidCardManagement>,IPrepaidCardManagementService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPrepaidCardManagementDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class FinanceDetailService:BaseService_HZ<FinanceDetail>,IFinanceDetailService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetFinanceDetailDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class System_FavoritesService:BaseService_HZ<System_Favorites>,ISystem_FavoritesService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSystem_FavoritesDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class ResourceReservationClaService:BaseService_HZ<ResourceReservationCla>,IResourceReservationClaService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetResourceReservationClaDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class ResourceReservationInfoService:BaseService_HZ<ResourceReservationInfo>,IResourceReservationInfoService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetResourceReservationInfoDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class ResourceReservationManagementService:BaseService_HZ<ResourceReservationManagement>,IResourceReservationManagementService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetResourceReservationManagementDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class System_TimingService:BaseService_HZ<System_Timing>,ISystem_TimingService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSystem_TimingDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Resources_CatagoryService:BaseService_HZ<Resources_Catagory>,IResources_CatagoryService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetResources_CatagoryDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Resources_ChapterService:BaseService_HZ<Resources_Chapter>,IResources_ChapterService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetResources_ChapterDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class System_VisitRateService:BaseService_HZ<System_VisitRate>,ISystem_VisitRateService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSystem_VisitRateDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class ResourcesInfoService:BaseService_HZ<ResourcesInfo>,IResourcesInfoService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetResourcesInfoDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class ResourceTimeMappingIdService:BaseService_HZ<ResourceTimeMappingId>,IResourceTimeMappingIdService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetResourceTimeMappingIdDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class ResourceTypeService:BaseService_HZ<ResourceType>,IResourceTypeService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetResourceTypeDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class SBTQ_AssoActivityService:BaseService_HZ<SBTQ_AssoActivity>,ISBTQ_AssoActivityService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSBTQ_AssoActivityDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class SBTQ_AssoNewsService:BaseService_HZ<SBTQ_AssoNews>,ISBTQ_AssoNewsService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSBTQ_AssoNewsDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class ScheduleService:BaseService_HZ<Schedule>,IScheduleService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetScheduleDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class EnterpriseJobService:BaseService_HZ<EnterpriseJob>,IEnterpriseJobService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetEnterpriseJobDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class SchoolStyleService:BaseService_HZ<SchoolStyle>,ISchoolStyleService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSchoolStyleDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class SomeTableClickService:BaseService_HZ<SomeTableClick>,ISomeTableClickService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSomeTableClickDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class S_ProvinceService:BaseService_HZ<S_Province>,IS_ProvinceService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetS_ProvinceDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class StudentTrainService:BaseService_HZ<StudentTrain>,IStudentTrainService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetStudentTrainDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class S_CityService:BaseService_HZ<S_City>,IS_CityService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetS_CityDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class System_DictionaryService:BaseService_HZ<System_Dictionary>,ISystem_DictionaryService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSystem_DictionaryDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class S_DistrictService:BaseService_HZ<S_District>,IS_DistrictService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetS_DistrictDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class System_LinkService:BaseService_HZ<System_Link>,ISystem_LinkService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSystem_LinkDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class NT_Ex_Resumes_JobsService:BaseService_HZ<NT_Ex_Resumes_Jobs>,INT_Ex_Resumes_JobsService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetNT_Ex_Resumes_JobsDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class System_MessageService:BaseService_HZ<System_Message>,ISystem_MessageService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSystem_MessageDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class S_PCDInfoService:BaseService_HZ<S_PCDInfo>,IS_PCDInfoService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetS_PCDInfoDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class System_NoticeService:BaseService_HZ<System_Notice>,ISystem_NoticeService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSystem_NoticeDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class tbService:BaseService_HZ<tb>,ItbService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GettbDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class tempService:BaseService_HZ<temp>,ItempService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GettempDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class TimeIntervalService:BaseService_HZ<TimeInterval>,ITimeIntervalService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetTimeIntervalDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Couse_SelstuinfoService:BaseService_HZ<Couse_Selstuinfo>,ICouse_SelstuinfoService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCouse_SelstuinfoDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class TimeManagementService:BaseService_HZ<TimeManagement>,ITimeManagementService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetTimeManagementDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class TopicService:BaseService_HZ<Topic>,ITopicService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetTopicDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class AccountInfoService:BaseService_HZ<AccountInfo>,IAccountInfoService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAccountInfoDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Topic_CommentService:BaseService_HZ<Topic_Comment>,ITopic_CommentService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetTopic_CommentDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class AdvertisingService:BaseService_HZ<Advertising>,IAdvertisingService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAdvertisingDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Topic_GoodClickService:BaseService_HZ<Topic_GoodClick>,ITopic_GoodClickService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetTopic_GoodClickDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class AssetManagementService:BaseService_HZ<AssetManagement>,IAssetManagementService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAssetManagementDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class TrainingFilesService:BaseService_HZ<TrainingFiles>,ITrainingFilesService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetTrainingFilesDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class CardPriceHistoryService:BaseService_HZ<CardPriceHistory>,ICardPriceHistoryService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCardPriceHistoryDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class UserCardInfoService:BaseService_HZ<UserCardInfo>,IUserCardInfoService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetUserCardInfoDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class CertificateApplyService:BaseService_HZ<CertificateApply>,ICertificateApplyService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCertificateApplyDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class CertificateCourseService:BaseService_HZ<CertificateCourse>,ICertificateCourseService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCertificateCourseDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class WebEnteredService:BaseService_HZ<WebEntered>,IWebEnteredService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetWebEnteredDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class CertificateExamService:BaseService_HZ<CertificateExam>,ICertificateExamService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCertificateExamDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class CertificateListService:BaseService_HZ<CertificateList>,ICertificateListService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCertificateListDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class CertificateManageService:BaseService_HZ<CertificateManage>,ICertificateManageService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCertificateManageDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class CertificateModolService:BaseService_HZ<CertificateModol>,ICertificateModolService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCertificateModolDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class ClassCourseService:BaseService_HZ<ClassCourse>,IClassCourseService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetClassCourseDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class ClassCourse_CopyService:BaseService_HZ<ClassCourse_Copy>,IClassCourse_CopyService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetClassCourse_CopyDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class ClickDetailService:BaseService_HZ<ClickDetail>,IClickDetailService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetClickDetailDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class CourseService:BaseService_HZ<Course>,ICourseService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCourseDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Course_Catagory_DeleteService:BaseService_HZ<Course_Catagory_Delete>,ICourse_Catagory_DeleteService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCourse_Catagory_DeleteDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Course_ChapterService:BaseService_HZ<Course_Chapter>,ICourse_ChapterService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCourse_ChapterDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Course_Chapter_CopyService:BaseService_HZ<Course_Chapter_Copy>,ICourse_Chapter_CopyService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCourse_Chapter_CopyDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Course_CopyService:BaseService_HZ<Course_Copy>,ICourse_CopyService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCourse_CopyDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class UpEmailListService:BaseService_HZ<UpEmailList>,IUpEmailListService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetUpEmailListDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Course_EvalueService:BaseService_HZ<Course_Evalue>,ICourse_EvalueService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCourse_EvalueDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Course_ModolService:BaseService_HZ<Course_Modol>,ICourse_ModolService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCourse_ModolDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class PersonDocumentService:BaseService_HZ<PersonDocument>,IPersonDocumentService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPersonDocumentDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Course_TaskRelService:BaseService_HZ<Course_TaskRel>,ICourse_TaskRelService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCourse_TaskRelDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Course_WorkService:BaseService_HZ<Course_Work>,ICourse_WorkService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCourse_WorkDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Course_WorkCorrectRelService:BaseService_HZ<Course_WorkCorrectRel>,ICourse_WorkCorrectRelService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCourse_WorkCorrectRelDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Couse_ResourceService:BaseService_HZ<Couse_Resource>,ICouse_ResourceService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCouse_ResourceDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Couse_SelsettingService:BaseService_HZ<Couse_Selsetting>,ICouse_SelsettingService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCouse_SelsettingDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Couse_SelWeekService:BaseService_HZ<Couse_SelWeek>,ICouse_SelWeekService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCouse_SelWeekDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Couse_TaskInfoService:BaseService_HZ<Couse_TaskInfo>,ICouse_TaskInfoService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCouse_TaskInfoDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Couse_TaskInfo_CopyService:BaseService_HZ<Couse_TaskInfo_Copy>,ICouse_TaskInfo_CopyService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCouse_TaskInfo_CopyDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class DBBackUpLogService:BaseService_HZ<DBBackUpLog>,IDBBackUpLogService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetDBBackUpLogDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class EnterpriseService:BaseService_HZ<Enterprise>,IEnterpriseService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetEnterpriseDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class sysdiagramsService:BaseService_HZ<sysdiagrams>,IsysdiagramsService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetsysdiagramsDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Exam_ExamAnswerService:BaseService_HZ<Exam_ExamAnswer>,IExam_ExamAnswerService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetExam_ExamAnswerDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Exam_ExaminationService:BaseService_HZ<Exam_Examination>,IExam_ExaminationService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetExam_ExaminationDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Exam_ExamPaperService:BaseService_HZ<Exam_ExamPaper>,IExam_ExamPaperService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetExam_ExamPaperDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Exam_ExamPaperObjQService:BaseService_HZ<Exam_ExamPaperObjQ>,IExam_ExamPaperObjQService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetExam_ExamPaperObjQDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Exam_ExamPaperSubQService:BaseService_HZ<Exam_ExamPaperSubQ>,IExam_ExamPaperSubQService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetExam_ExamPaperSubQDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class System_UserOnLineService:BaseService_HZ<System_UserOnLine>,ISystem_UserOnLineService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSystem_UserOnLineDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Exam_ExamTypeService:BaseService_HZ<Exam_ExamType>,IExam_ExamTypeService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetExam_ExamTypeDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class TrainCourseService:BaseService_HZ<TrainCourse>,ITrainCourseService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetTrainCourseDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Exam_ObjQuestionService:BaseService_HZ<Exam_ObjQuestion>,IExam_ObjQuestionService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetExam_ObjQuestionDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Exam_SubQuestionService:BaseService_HZ<Exam_SubQuestion>,IExam_SubQuestionService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetExam_SubQuestionDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class TrainExamService:BaseService_HZ<TrainExam>,ITrainExamService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetTrainExamDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class JobClassService:BaseService_HZ<JobClass>,IJobClassService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetJobClassDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class JobTopicService:BaseService_HZ<JobTopic>,IJobTopicService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetJobTopicDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class JobTopic_CommentService:BaseService_HZ<JobTopic_Comment>,IJobTopic_CommentService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetJobTopic_CommentDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class LibraryListService:BaseService_HZ<LibraryList>,ILibraryListService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetLibraryListDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class LibraryMenuService:BaseService_HZ<LibraryMenu>,ILibraryMenuService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetLibraryMenuDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class MonitorRecordService:BaseService_HZ<MonitorRecord>,IMonitorRecordService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetMonitorRecordDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class MyResourceService:BaseService_HZ<MyResource>,IMyResourceService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetMyResourceDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Notice_CourseService:BaseService_HZ<Notice_Course>,INotice_CourseService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetNotice_CourseDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class ResourceReservationService:BaseService_HZ<ResourceReservation>,IResourceReservationService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetResourceReservationDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Notice_CourseSeeRelService:BaseService_HZ<Notice_CourseSeeRel>,INotice_CourseSeeRelService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetNotice_CourseSeeRelDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class PortalMenuDroitService:BaseService_HZ<PortalMenuDroit>,IPortalMenuDroitService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPortalMenuDroitDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class Couse_Resource_CopyService:BaseService_HZ<Couse_Resource_Copy>,ICouse_Resource_CopyService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetCouse_Resource_CopyDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class PortalTreeDataService:BaseService_HZ<PortalTreeData>,IPortalTreeDataService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPortalTreeDataDal();
        }
		

    }
	
}