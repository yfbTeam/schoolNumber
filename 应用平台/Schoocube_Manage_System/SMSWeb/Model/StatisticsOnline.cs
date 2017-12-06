using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SMSWeb.Model
{
    public class StatisticsOnline 
    {
        
    }

    partial class PersonInfo
    {
        public string Photo { get; set; }
        public string UserName { get; set; }

        public string IP { get; set; }

        public DateTime Date { get; set; }

        public string GuKey { get; set; }

    }
}