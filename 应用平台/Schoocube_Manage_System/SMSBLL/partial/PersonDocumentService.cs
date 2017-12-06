using SMSDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSBLL
{
    public partial class PersonDocumentService
    {
        PersonDocumentDal dal = new PersonDocumentDal();
        public string AddDocList()
        {
            return dal.AddDocList();
        }
    }
}
