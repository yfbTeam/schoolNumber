using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Discuz.Toolkit;

namespace SMSUtility.DiscuzToolkit
{
    public class DiscuzSessionHelper
    {
        private static string apikey, secret, url;
        private static DiscuzSession ds;
        static DiscuzSessionHelper()
        {
            apikey = "a9536298e2c7c396d32727b15513a530";
            secret = "4aab8edb1985b48123cb1470fdb4ebc4";
            url = "http://192.168.1.229:9010/";
            ds = new DiscuzSession(apikey, secret, url);
        }

        public static DiscuzSession GetSession()
        {
            return ds;
        }
    }
}
