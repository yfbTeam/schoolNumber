using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMCommon
{
    public enum UserType
    {
        教师=0,
        学生=1
    }
    public enum UserTableType
    {
        Plat_Teacher = 0,
        Plat_Student = 1
    }

    public enum Status 
    {
        正常=0,
        删除=1,
        归档=2
    }

    public enum Plat_Teacher_State 
    {
        启动=0,
        禁用=1
    }
}
