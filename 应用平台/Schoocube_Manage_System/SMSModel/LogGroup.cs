using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSModel
{
    public class LogGroup
    {
        public LogGroup()
        {
            this.GroupID = "-1111";
            this.Items = new List<MonitorRecord>();
        }
        public int number { get; set; }

        public string GroupID { get; set; }

        public List<MonitorRecord> Items { get; set; }
    }
}
