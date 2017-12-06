
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
    public interface IPrepaidCardManagementDal: IBaseDal_HZ<PrepaidCardManagement>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IFinanceDetailDal: IBaseDal_HZ<FinanceDetail>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISystem_FavoritesDal: IBaseDal_HZ<System_Favorites>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IResourceReservationClaDal: IBaseDal_HZ<ResourceReservationCla>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IResourceReservationInfoDal: IBaseDal_HZ<ResourceReservationInfo>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IResourceReservationManagementDal: IBaseDal_HZ<ResourceReservationManagement>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISystem_TimingDal: IBaseDal_HZ<System_Timing>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IResources_CatagoryDal: IBaseDal_HZ<Resources_Catagory>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IResources_ChapterDal: IBaseDal_HZ<Resources_Chapter>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISystem_VisitRateDal: IBaseDal_HZ<System_VisitRate>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IResourcesInfoDal: IBaseDal_HZ<ResourcesInfo>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IResourceTimeMappingIdDal: IBaseDal_HZ<ResourceTimeMappingId>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IResourceTypeDal: IBaseDal_HZ<ResourceType>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISBTQ_AssoActivityDal: IBaseDal_HZ<SBTQ_AssoActivity>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISBTQ_AssoNewsDal: IBaseDal_HZ<SBTQ_AssoNews>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IScheduleDal: IBaseDal_HZ<Schedule>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IEnterpriseJobDal: IBaseDal_HZ<EnterpriseJob>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISchoolStyleDal: IBaseDal_HZ<SchoolStyle>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISomeTableClickDal: IBaseDal_HZ<SomeTableClick>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IS_ProvinceDal: IBaseDal_HZ<S_Province>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IStudentTrainDal: IBaseDal_HZ<StudentTrain>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IS_CityDal: IBaseDal_HZ<S_City>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISystem_DictionaryDal: IBaseDal_HZ<System_Dictionary>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IS_DistrictDal: IBaseDal_HZ<S_District>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISystem_LinkDal: IBaseDal_HZ<System_Link>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface INT_Ex_Resumes_JobsDal: IBaseDal_HZ<NT_Ex_Resumes_Jobs>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISystem_MessageDal: IBaseDal_HZ<System_Message>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IS_PCDInfoDal: IBaseDal_HZ<S_PCDInfo>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISystem_NoticeDal: IBaseDal_HZ<System_Notice>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ItbDal: IBaseDal_HZ<tb>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ItempDal: IBaseDal_HZ<temp>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ITimeIntervalDal: IBaseDal_HZ<TimeInterval>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICouse_SelstuinfoDal: IBaseDal_HZ<Couse_Selstuinfo>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ITimeManagementDal: IBaseDal_HZ<TimeManagement>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ITopicDal: IBaseDal_HZ<Topic>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IAccountInfoDal: IBaseDal_HZ<AccountInfo>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ITopic_CommentDal: IBaseDal_HZ<Topic_Comment>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IAdvertisingDal: IBaseDal_HZ<Advertising>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ITopic_GoodClickDal: IBaseDal_HZ<Topic_GoodClick>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IAssetManagementDal: IBaseDal_HZ<AssetManagement>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ITrainingFilesDal: IBaseDal_HZ<TrainingFiles>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICardPriceHistoryDal: IBaseDal_HZ<CardPriceHistory>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IUserCardInfoDal: IBaseDal_HZ<UserCardInfo>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICertificateApplyDal: IBaseDal_HZ<CertificateApply>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICertificateCourseDal: IBaseDal_HZ<CertificateCourse>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IWebEnteredDal: IBaseDal_HZ<WebEntered>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICertificateExamDal: IBaseDal_HZ<CertificateExam>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICertificateListDal: IBaseDal_HZ<CertificateList>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICertificateManageDal: IBaseDal_HZ<CertificateManage>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICertificateModolDal: IBaseDal_HZ<CertificateModol>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IClassCourseDal: IBaseDal_HZ<ClassCourse>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IClassCourse_CopyDal: IBaseDal_HZ<ClassCourse_Copy>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IClickDetailDal: IBaseDal_HZ<ClickDetail>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICourseDal: IBaseDal_HZ<Course>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICourse_Catagory_DeleteDal: IBaseDal_HZ<Course_Catagory_Delete>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICourse_ChapterDal: IBaseDal_HZ<Course_Chapter>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICourse_Chapter_CopyDal: IBaseDal_HZ<Course_Chapter_Copy>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICourse_CopyDal: IBaseDal_HZ<Course_Copy>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IUpEmailListDal: IBaseDal_HZ<UpEmailList>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICourse_EvalueDal: IBaseDal_HZ<Course_Evalue>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICourse_ModolDal: IBaseDal_HZ<Course_Modol>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IPersonDocumentDal: IBaseDal_HZ<PersonDocument>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICourse_TaskRelDal: IBaseDal_HZ<Course_TaskRel>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICourse_WorkDal: IBaseDal_HZ<Course_Work>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICourse_WorkCorrectRelDal: IBaseDal_HZ<Course_WorkCorrectRel>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICouse_ResourceDal: IBaseDal_HZ<Couse_Resource>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICouse_SelsettingDal: IBaseDal_HZ<Couse_Selsetting>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICouse_SelWeekDal: IBaseDal_HZ<Couse_SelWeek>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICouse_TaskInfoDal: IBaseDal_HZ<Couse_TaskInfo>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICouse_TaskInfo_CopyDal: IBaseDal_HZ<Couse_TaskInfo_Copy>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IDBBackUpLogDal: IBaseDal_HZ<DBBackUpLog>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IEnterpriseDal: IBaseDal_HZ<Enterprise>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IsysdiagramsDal: IBaseDal_HZ<sysdiagrams>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IExam_ExamAnswerDal: IBaseDal_HZ<Exam_ExamAnswer>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IExam_ExaminationDal: IBaseDal_HZ<Exam_Examination>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IExam_ExamPaperDal: IBaseDal_HZ<Exam_ExamPaper>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IExam_ExamPaperObjQDal: IBaseDal_HZ<Exam_ExamPaperObjQ>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IExam_ExamPaperSubQDal: IBaseDal_HZ<Exam_ExamPaperSubQ>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISystem_UserOnLineDal: IBaseDal_HZ<System_UserOnLine>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IExam_ExamTypeDal: IBaseDal_HZ<Exam_ExamType>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ITrainCourseDal: IBaseDal_HZ<TrainCourse>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IExam_ObjQuestionDal: IBaseDal_HZ<Exam_ObjQuestion>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IExam_SubQuestionDal: IBaseDal_HZ<Exam_SubQuestion>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ITrainExamDal: IBaseDal_HZ<TrainExam>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IJobClassDal: IBaseDal_HZ<JobClass>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IJobTopicDal: IBaseDal_HZ<JobTopic>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IJobTopic_CommentDal: IBaseDal_HZ<JobTopic_Comment>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ILibraryListDal: IBaseDal_HZ<LibraryList>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ILibraryMenuDal: IBaseDal_HZ<LibraryMenu>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IMonitorRecordDal: IBaseDal_HZ<MonitorRecord>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IMyResourceDal: IBaseDal_HZ<MyResource>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface INotice_CourseDal: IBaseDal_HZ<Notice_Course>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IResourceReservationDal: IBaseDal_HZ<ResourceReservation>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface INotice_CourseSeeRelDal: IBaseDal_HZ<Notice_CourseSeeRel>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IPortalMenuDroitDal: IBaseDal_HZ<PortalMenuDroit>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ICouse_Resource_CopyDal: IBaseDal_HZ<Couse_Resource_Copy>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IPortalTreeDataDal: IBaseDal_HZ<PortalTreeData>
    {


		
    }
}