using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSDAL
{
    public partial class AdminManagerDal
    {
        public DataTable GetLeftNavigationMenu(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append("select * from PortalTreeData where 1=1");
                if (ht.ContainsKey("Display") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["Display"])))
                {
                    sbSql4org.Append(" and [Display]=@Display");
                    List.Add(new SqlParameter("@Display", ht["Display"].ToString()));
                }
                if (ht.ContainsKey("IsDelete") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["IsDelete"])))
                {
                    sbSql4org.Append(" and IsDelete=@IsDelete");
                    List.Add(new SqlParameter("@IsDelete", ht["IsDelete"].ToString()));
                }
                if (ht.ContainsKey("BeforeAfter") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["BeforeAfter"])))
                {
                    sbSql4org.Append(" and (BeforeAfter=@BeforeAfter or BeforeAfter=" + (int)BeforeAfter.前后台展示 + ")");
                    List.Add(new SqlParameter("@BeforeAfter", ht["BeforeAfter"].ToString()));
                }
                sbSql4org.Append(" Order by SortId desc,CreateTime asc");
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public int UpdatePortalTreeData(Hashtable ht, SqlTransaction trans)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append("update PortalTreeData ");
                if (ht.ContainsKey("IsDelete") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["IsDelete"])))
                {
                    sbSql4org.Append("set IsDelete=@IsDelete ");
                    List.Add(new SqlParameter("@IsDelete", ht["IsDelete"].ToString()));
                }
                else if (ht.ContainsKey("Display") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["Display"])))
                {
                    sbSql4org.Append("set Display=@Display ");
                    List.Add(new SqlParameter("@Display", ht["Display"].ToString()));
                }
                sbSql4org.Append(" where 1=1 ");
                if (ht.ContainsKey("ids") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["ids"])))
                {
                    sbSql4org.Append(" and Id in (" + ht["ids"].ToString() + ") ");
                }
                int number = SQLHelp.ExecuteNonQuery(trans, CommandType.Text, sbSql4org.ToString(), List.ToArray());
                return number;
            }
            catch (Exception)
            {
                return -1;
            }

        }

        public DataTable GetPortalTreeData(Hashtable ht, SqlTransaction trans)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();

                sbSql4org.Append("select * from PortalTreeData where PId=@Id ");
                sbSql4org.Append("  Order by SortId desc,CreateTime asc");
                SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@Id",ht["Id"])
            };
                DataTable dt = SQLHelp.ExecuteDataTable(trans, sbSql4org.ToString(), CommandType.Text, param);
                return dt;
            }
            catch (Exception)
            {

                return null;
            }
        }

        public DataTable GetPortalTreeDataForChildId(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();

                sbSql4org.Append(" select * from PortalTreeData where IsDelete!=" + ((int)SMSUtility.SysStatus.删除) + " and Display=" + ((int)SMSUtility.Display.显示) + "  and (ID in (select Pid from PortalTreeData where ID=@Id and IsDelete!=" + ((int)SMSUtility.SysStatus.删除) + "  and Display=" + ((int)SMSUtility.Display.显示) + ")");
                sbSql4org.Append(" or pid in (select Pid from PortalTreeData where ID=@Id and  IsDelete!=" + ((int)SMSUtility.SysStatus.删除) + " and Display=" + ((int)SMSUtility.Display.显示) + "))");
                SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@Id",ht["Id"])
            };
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, param);
                return dt;
            }
            catch (Exception)
            {
                return null;
            }


        }

        public int AddUserInfos(List<SMSModel.PortalMenuDroit> list)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                //SqlParameter[] pars = new SqlParameter[]{
                // new SqlParameter("@IsDelete",(int)SysStatus.正常),
                // new SqlParameter("@CreateTime",DateTime.Now)
                //};
                sbSql4org.Append("INSERT INTO PortalMenuDroit (MenuId,LoginName,Name,Email,IsDelete,CreateTime,RoleType)");
                for (int i = 0; i < list.Count; i++)
                {
                    if (i + 1 == list.Count)//最后一条
                        sbSql4org.Append(" select " + list[i].MenuId + ",'" + list[i].LoginName + "','" + list[i].Name + "','" + list[i].Email + "',@IsDelete" + i + ",@CreateTime" + i + "," + list[i].RoleType + " ");
                    else
                        sbSql4org.Append(" select " + list[i].MenuId + ",'" + list[i].LoginName + "','" + list[i].Name + "','" + list[i].Email + "',@IsDelete" + i + ",@CreateTime" + i + "," + list[i].RoleType + " union all ");
                    List.Add(new SqlParameter("@IsDelete" + i, ((int)SysStatus.正常).ToString()));
                    List.Add(new SqlParameter("@CreateTime" + i, DateTime.Now));
                }
                int number = SQLHelp.ExecuteNonQuery(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return number;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }

        public DataTable GetCourseForStatisc(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append("select case when CourceType=1 then '线上课程' when CourceType=2 then '线下课程' else '线上课程' end as CourseName,COUNT(*) AS [COUNT] from  [dbo].[Course] where 1=1");
                if (!string.IsNullOrWhiteSpace(Convert.ToString(ht["CourseType"])))
                {
                    sbSql4org.Append(" and CourceType=@CourceType");
                    List.Add(new SqlParameter("@CourceType", ht["CourseType"].ToString()));
                }
                if (!string.IsNullOrWhiteSpace(Convert.ToString(ht["IsCharge"])))
                {
                    sbSql4org.Append(" and IsCharge=@IsCharge");
                    List.Add(new SqlParameter("@IsCharge", ht["IsCharge"].ToString()));
                }
                sbSql4org.Append("  group by CourceType");
                //sbSql4org.Append(@"select count(1) 总记录数");
                //if (!string.IsNullOrWhiteSpace(Convert.ToString(ht["CourceType"])))
                //{
                //    switch (ht["CourceType"].ToString())
                //    {
                //        case "1":
                //            sbSql4org.Append(",sum(case when CourceType=1 then 1 else 0 end)线上课程");
                //            break;
                //        case "2":
                //            sbSql4org.Append(",sum(case when CourceType=2 then 1 else 0 end)线下课程");
                //            break;
                //        default:
                //            sbSql4org.Append(",sum(case when CourceType=1 then 1 else 0 end)线上课程");
                //            break;
                //    }
                //    sbSql4org.Append(" from [dbo].[Course]");
                //}
                //else
                //{
                //    sbSql4org.Append(@",sum(case when CourceType=1 then 1 else 0 end)线上课程,sum(case when CourceType=2 then 1 else 0 end)线下课程 from [dbo].[Course]");
                //}
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable ExportExcel(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append("select ID as 序号,[Name] as 课程名称,case when CourceType=1 then '线上课程' when CourceType=2 then '线下课程' else '线上课程' end as 课程类型,CoursePrice as 课程价格,case when IsCharge=1 then '收费' when IsCharge=0 then '免费' else '免费' end as 是否收费,GradeName as 年级 from [dbo].[Course] where 1=1");
                if (!string.IsNullOrWhiteSpace(Convert.ToString(ht["CourseType"])))
                {
                    sbSql4org.Append(" and CourceType=@CourceType");
                    List.Add(new SqlParameter("@CourseType", ht["CourseType"].ToString()));
                }
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable GetEnterprisePageList(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                return null;
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        public DataTable GetPageItemList(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append(@"select distinct ej.*,(spcd.ProvinceName+'-'+CityName+'-'+DistrictName) PCD,exrj.JobName from [dbo].[EnterpriseJob] ej
left join[dbo].[JobClass] jc on ej.ID = jc.JobID
left join[dbo].[S_PCDInfo] spcd on ej.Region = spcd.Id
left join[dbo].[NT_Ex_Resumes_Jobs] exrj on ej.[Type] = exrj.JobId  where 1=1 ");
                string where = string.Empty;
                if (ht.ContainsKey("NameIntro") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["NameIntro"])))
                    where += " and (ej.Name+ej.Introduction like '%" + ht["NameIntro"].ToString() + "%') ";
                if (ht.ContainsKey("CreateTime") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["CreateTime"])))
                {
                    switch (Convert.ToInt32(ht["CreateTime"]))
                    {
                        case (int)enumTimeInterval.今日:
                            where += " and ( CONVERT(varchar(100),ej.CreateTime, 23)='" + DateTime.Now.ToString("yyyy-MM-dd") + "' ";
                            break;
                        case (int)enumTimeInterval.三天前:
                            where += " and ( CONVERT(varchar(100),ej.CreateTime, 23) between '" + DateTime.Now.AddDays(-3).ToString("yyyy-MM-dd") + " 00:00:00' and '" + DateTime.Now.ToString("yyyy-MM-dd") + " 23:59:59')";
                            break;
                        case (int)enumTimeInterval.一周之内:
                            where += " and ( CONVERT(varchar(100),ej.CreateTime, 23) between '" + DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd") + " 00:00:00' and '" + DateTime.Now.ToString("yyyy-MM-dd") + " 23:59:59')";
                            break;
                        case (int)enumTimeInterval.一个月之内:
                            where += " and ( CONVERT(varchar(100),ej.CreateTime, 23) between '" + DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd") + " 00:00:00' and '" + DateTime.Now.ToString("yyyy-MM-dd") + " 23:59:59')";
                            break;
                    }
                }
                else
                {
                    where += " and (ej.CreateTime<='" + DateTime.Now + "')";
                }
                if (ht.ContainsKey("StarMoney") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["StarMoney"])) && ht.ContainsKey("EndMoney") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["EndMoney"])))
                {
                    if (Convert.ToInt32(ht["StarMoney"]) > Convert.ToInt32(ht["EndMoney"]))
                        where += " and (ej.Money!='面议' and CAST(ej.Money AS INT)>=" + Convert.ToInt32(ht["EndMoney"]) + " and CAST(ej.Money AS INT)<=" + Convert.ToInt32(ht["StarMoney"]) + ")";
                    else
                        where += " and (ej.Money!='面议' and CAST(ej.Money AS INT)>=" + Convert.ToInt32(ht["StarMoney"]) + " and CAST(ej.Money AS INT)<=" + Convert.ToInt32(ht["EndMoney"]) + ")";
                }
                else if (ht.ContainsKey("StarMoney") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["StarMoney"])))
                {
                    where += " and (ej.Money!='面议' and CAST(ej.Money AS INT)>=" + Convert.ToInt32(ht["StarMoney"]) + ")";
                }
                else if (ht.ContainsKey("EndMoney") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["EndMoney"])))
                {
                    where += " and (ej.Money!='面议' and CAST(ej.Money AS INT)<=" + Convert.ToInt32(ht["EndMoney"]) + ")";
                }
                if (ht.ContainsKey("ID") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["ID"])))
                {
                    where += " and (ej.ID=@ID)";
                    List.Add(new SqlParameter("@ID", ht["ID"].ToString()));
                }

                sbSql4org.Append(" and ej.IsDelete=@IsDelete ");
                List.Add(new SqlParameter("@IsDelete", ((int)SysStatus.正常).ToString()));
                string sql = sbSql4org.ToString() + where + " order by ej.CreateTime desc";
                DataTable dt = SQLHelp.ExecuteDataTable(sql, CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable GetCourseListByJobIds(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append(@"select c.ID,c.Name,c.ImageUrl,c.IsCharge,jc.JobID,SubjectName=(select ps.Name from [BasePlatform].[dbo].[Plat_Subject] ps 
where dbo.GetSplitOfIndex(c.CatagoryID,'|',2)=ps.ID) from Course c inner join [dbo].[JobClass] jc
on c.ID=jc.CourseID where 1=1");
                if (ht.ContainsKey("JobIDs") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["JobIDs"])))
                {
                    sbSql4org.Append(" and jc.JobID in (" + ht["JobIDs"].ToString() + ")");
                }
                sbSql4org.Append(" and c.IsDelete=@IsDelete");
                List.Add(new SqlParameter("@IsDelete", ((int)SysStatus.正常).ToString()));
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable GetThisWebList(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                string type = ht["CourseType"].ToString();
                
                switch (type)
                {
                    case "0":
                        //sbSql4org.Append("select '精品课程' name,count(1) [count],'0' [Type] from [dbo].[Course] where 1=1 ");

                        sbSql4org.Append("select Name,ClickNum from [dbo].[Course] where 1=1");
                        sbSql4org.Append(" and Boutique=1");//精品
                        break;

                    case "1":
                        //sbSql4org.Append("select '热门课程' name,count(1) [count],'1' [Type] from [dbo].[Course] where 1=1 ");
                        sbSql4org.Append("select Name,ClickNum from [dbo].[Course] where 1=1");
                        sbSql4org.Append(" and ClickNum>=10");//热门
                        break;
                    case "2":
                        //sbSql4org.Append("select '最新课程' name,count(1) [count],'2' [Type] from [dbo].[Course] where 1=1 ");
                        sbSql4org.Append("select Name,ClickNum from [dbo].[Course] where 1=1");
                        sbSql4org.Append(" and CreateTime>=" + DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd") + "00:00:01");
                        break;
                }
                sbSql4org.Append(" and IsDelete=@IsDelete");
                List.Add(new SqlParameter("@IsDelete",((int)SysStatus.正常).ToString()));
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable GetThisWebPageList(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                string type = ht["CourseType"].ToString();

                switch (type)
                {
                    case "0":
                        sbSql4org.Append("select '精品课程' name,count(1) [count],'0' [Type] from [dbo].[Course] where 1=1 ");

                        
                        sbSql4org.Append(" and Boutique=1");//精品
                        break;

                    case "1":
                        sbSql4org.Append("select '热门课程' name,count(1) [count],'1' [Type] from [dbo].[Course] where 1=1 ");
                       
                        sbSql4org.Append(" and ClickNum>=10");//热门
                        break;
                    case "2":
                        sbSql4org.Append("select '最新课程' name,count(1) [count],'2' [Type] from [dbo].[Course] where 1=1 ");
                        
                        sbSql4org.Append(" and CreateTime>=" + DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd") + "00:00:01");
                        break;
                }
                sbSql4org.Append(" and IsDelete=@IsDelete");
                List.Add(new SqlParameter("@IsDelete", ((int)SysStatus.正常).ToString()));
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable ExportExcelWebSite(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                DataTable dt = null;
                sbSql4org.Append("select ID as 序号,[Name] as 课程名称,case when CourceType=1 then '线上课程' when CourceType=2 then '线下课程' else '线上课程' end as 课程类型,CoursePrice as 课程价格,case when IsCharge=1 then '收费' when IsCharge=0 then '免费' else '免费' end as 是否收费,GradeName as 年级 from [dbo].[Course] where 1=1");
                if (!string.IsNullOrWhiteSpace(Convert.ToString(ht["CourseType"])))
                {
                    string type = ht["CourseType"].ToString();

                    switch (type)
                    {
                        case "0":
                            sbSql4org.Append(" and Boutique=1");//精品
                            break;

                        case "1":
                            sbSql4org.Append(" and ClickNum>=10");//热门
                            break;
                        case "2":
                            sbSql4org.Append(" and CreateTime>=" + DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd") + "00:00:01");
                            break;
                    }
                    sbSql4org.Append(" and IsDelete=@IsDelete");
                    List.Add(new SqlParameter("@IsDelete", ((int)SysStatus.正常).ToString()));
                    dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                }
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable GetCostPageList(Hashtable ht) 
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                DataTable dt = null;
                sbSql4org.Append("select f.*,ps.Name from FinanceDetail f inner join [BasePlatform].[dbo].[Plat_Student] ps on ps.IDCard=f.Creator ");
                if (!string.IsNullOrWhiteSpace(Convert.ToString(ht["Type"])))
                {
                    sbSql4org.Append(" and Type=@Type");
                    List.Add(new SqlParameter("@Type", ht["Type"].ToString()));
                }
                if (!string.IsNullOrWhiteSpace(Convert.ToString(ht["EndDate"])) && !string.IsNullOrWhiteSpace(Convert.ToString(ht["StarDate"])))
                {
                    sbSql4org.Append(" and ([CreateTime]>=@StarDate and [CreateTime]<=@EndDate)");
                    List.Add(new SqlParameter("@StarDate", ht["StarDate"].ToString()));
                    List.Add(new SqlParameter("@EndDate", ht["EndDate"].ToString()));
                }
                dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception)
            {
                return null;
            }
        }
        public DataTable QueryCertificateForCourse(Hashtable ht) 
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                DataTable dt = null;
//                sbSql4org.Append(@"select * from CertificateModol where id in (select ModelID from CertificateManage 
//where ID in (select CertificateID from CertificateCourse a,Course b 
//where a.CourseID=b.ID and b.Name like '%" + ht["Name"].ToString() + "%' and b.IsDelete=@IsDelete))");
                sbSql4org.Append(@"select cf.*,c.ID CID,c.Name CNAME from CertificateModol cf inner join 
CertificateManage cm on cf.ID=cm.ModelID inner join 
CertificateCourse cc on cm.ID=cc.CertificateID inner join 
Course c on  cc.CourseID=c.ID where c.Name like '%" + ht["Name"].ToString() + "%' and c.IsDelete=@IsDelete");
                List.Add(new SqlParameter("@IsDelete", ((int)SysStatus.正常).ToString()));
                dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable GetCostForStatisc(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append("select case when Type=0 then '线上购买' when Type=1 then '线上充值' when  Type=2 then '充值卡消费'  else '线上购买' end as CostName,COUNT(*) AS [COUNT] from  [dbo].[FinanceDetail] where 1=1");
                if (!string.IsNullOrWhiteSpace(Convert.ToString(ht["Type"])))
                {
                    sbSql4org.Append(" and Type=@Type");
                    List.Add(new SqlParameter("@Type", ht["Type"].ToString()));
                }
                if (!string.IsNullOrWhiteSpace(Convert.ToString(ht["EndDate"])) && !string.IsNullOrWhiteSpace(Convert.ToString(ht["StarDate"])))
                {
                    sbSql4org.Append(" and ([CreateTime]>=@StarDate and [CreateTime]<=@EndDate)");
                    List.Add(new SqlParameter("@StarDate", ht["StarDate"].ToString()));
                    List.Add(new SqlParameter("@EndDate", ht["EndDate"].ToString()));
                }
                sbSql4org.Append("  group by Type");
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

    }
}
