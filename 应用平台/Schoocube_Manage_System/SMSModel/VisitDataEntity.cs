using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSModel
{
    public class VisitDataEntity
    {
        public string Name { get; set; }
        public int Total { get; set; }

        public string RequestDate { get; set; }
        public int InternalCount { get; set; }
        public int ExternalCount { get; set; }
    }
}
