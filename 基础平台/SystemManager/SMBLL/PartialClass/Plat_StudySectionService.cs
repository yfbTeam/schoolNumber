using SMIBLL;
using SMModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMBLL
{
    public partial class Plat_StudySectionService : BaseService<Plat_StudySection>, IPlat_StudySectionService
    {
        public JsonModel AddStudySection(Hashtable ht)
        {
            JsonModel JM = new SMModel.JsonModel();
            try 
	        {	        
		        
                SMModel.Plat_StudySection model = new Plat_StudySection();
                model.Academic = ht["Academic"].ToString();
                model.Semester = ht["Semester"].ToString();
                model.SEndDate = Convert.ToDateTime(ht["SEndDate"].ToString());
                model.SStartDate = Convert.ToDateTime(ht["SStartDate"].ToString());
                model.SchoolID = Convert.ToInt32(ht["SchoolID"].ToString());

                int result = CurrentDal.Add(model);
                if (result > 0)
                {
                    JM.errNum = 0;
                    JM.errMsg = "添加成功";
                }
                else
                {
                    JM.errNum = 1;
                    JM.errMsg = "添加失败";
                }
                return JM;
	        }
	        catch (Exception)
	        {
		
		        throw;
	        }
            
        }

        public JsonModel UpdateStudySection(Hashtable ht)
        {
            JsonModel JM = new SMModel.JsonModel();
            try
            {
                SMModel.Plat_StudySection model = new Plat_StudySection();
                model = CurrentDal.GetEntityById(model, Convert.ToInt32(ht["Id"].ToString()));
                model.Academic = ht["Academic"].ToString();
                model.Semester = ht["Semester"].ToString();
                model.SEndDate = Convert.ToDateTime(ht["SEndDate"].ToString());
                model.SStartDate = Convert.ToDateTime(ht["SStartDate"].ToString());
                model.SchoolID = Convert.ToInt32(ht["SchoolID"].ToString());

                bool result = CurrentDal.Update(model);
                if (result)
                {
                    JM.errNum = 0;
                    JM.errMsg = "修改成功";
                }
                else
                {
                    JM.errNum = 1;
                    JM.errMsg = "修改失败";
                }
                return JM;
            }
            catch (Exception)
            {

                throw;
            }

        }
    }
}
