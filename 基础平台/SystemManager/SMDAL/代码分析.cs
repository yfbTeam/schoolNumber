using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMDAL
{
    public class 代码分析
    {

        //0：数据库访问层，利用反射，反射出访问数据库的各种方法。

        //1：首先有一个数据库访问层的统一路口，写一个Dal的工厂，返回所有的各种各样的Dal

        //2：业务逻辑层，声明一个Dal的父类，在写一个纯抽象方法，子类继承这个类并给这个Dal赋值。

        //3：增删改查方法的实现，用对应的Dal去处理对应的方法。

        //4：Ui层的实现，写一个工厂，返回各个Bll层的实例。

        //5：用T4模板生成所有代码。
    }
}
