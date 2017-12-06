using SMSDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSBLL
{
    public partial class LibraryMenuService
    {
        LibraryMenuDal dal = new LibraryMenuDal();
        public string BindtvNodes()
        {
            return dal.BindtvNodes();
        }
        #region  删除知识库导航信息
        /// <summary>
        /// 删除知识库导航信息
        /// </summary>
        /// <param name="MenuID"></param>
        /// <returns></returns>
        public string DelMenu(string MenuID)
        {
            return dal.DelMenu(MenuID);
        }
        #endregion
    }
}
