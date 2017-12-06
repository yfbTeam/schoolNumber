using SMSUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSDAL
{
    public partial class PersonDocumentDal
    {
        public string AddDocList()
        {

            object obj = SQLHelp.ExecuteScalar("AddDocs", CommandType.StoredProcedure, null);
            string result = "添加成功";
            if (obj.ToString().Length > 0)
            {
                result = obj.ToString();
            }
            return result;
        }
    }
}
