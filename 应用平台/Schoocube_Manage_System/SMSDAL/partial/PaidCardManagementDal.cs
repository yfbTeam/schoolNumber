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
    public partial class PaidCardManagementDal
    {
        public int PrepaidCardHistory(Hashtable ht)
        {
            using (SqlTransaction trans = SQLHelp.BeginTransaction())
            {
                int price = 0;//面值
                int result = 0;
                int accountBalance = 0;//账户余额
                //int ConsumptionPrice = 0;//消费金额
                //int status = 1;//状态（消费充值/充值）
                try
                {
                    StringBuilder sbSql4org = new StringBuilder();
                    List<SqlParameter> list = new List<SqlParameter>();
                    if (string.IsNullOrWhiteSpace(ht["Price"].SafeToString()))
                    {
                        price = 0;
                    }
                    else
                    {
                        price = Convert.ToInt32(ht["Price"]);
                    }
                    if (!string.IsNullOrWhiteSpace(ht["CardId"].ToString()))
                    {
                        sbSql4org.Append("update PrepaidCardManagement set [CardStatus] = '1'  where Id = " + ht["CardId"].ToString());
                        int number = SQLHelp.ExecuteNonQuery(trans, System.Data.CommandType.Text, sbSql4org.ToString(), null);
                        if (number > 0)
                        {
                            StringBuilder strUserInfo = new StringBuilder();
                            strUserInfo.AppendFormat("insert into UserCardInfo (UserName,CardId,PayTime,IdCard,Creator,CreateTime,UseStatus) values ('{0}','{1}','{2}','{3}','{4}','{5}','{6}')", ht["UserName"].SafeToString(), ht["CardId"].SafeToString(), DateTime.Now, ht["IdCard"].SafeToString(), ht["UserName"].SafeToString(), DateTime.Now, 1);
                            int upd = SQLHelp.ExecuteNonQuery(trans, System.Data.CommandType.Text, strUserInfo.ToString(), null);
                            StringBuilder strSearchAccount = new StringBuilder();
                            strSearchAccount.Append("select * from AccountInfo where IdCard=" + ht["IdCard"].SafeToString());
                            DataTable dt = SQLHelp.ExecuteDataTable(strSearchAccount.ToString(), CommandType.Text, null);
                            //if (string.IsNullOrEmpty(ht["ConsumptionPrice"].SafeToString()))
                            //{
                            //    ConsumptionPrice = 0;
                            //    status = 1;
                            //}
                            //else
                            //{
                            //    ConsumptionPrice = Convert.ToInt32(ht["ConsumptionPrice"].ToString());
                            //    //status = 2;
                            //}
                            if (dt.Rows.Count == 0)
                            {
                                accountBalance = price;
                                //accountBalance = price - ConsumptionPrice;
                                if(accountBalance >= 0)
                                {
                                    StringBuilder addAccountInfo = new StringBuilder();
                                    addAccountInfo.AppendFormat("insert into AccountInfo(UserName,IdCard,Balance,Creator,CreateTime) values ('{0}','{1}','{2}','{3}','{4}')", ht["UserName"].SafeToString(), ht["IdCard"].SafeToString(), accountBalance, ht["UserName"].SafeToString(), DateTime.Now);
                                    result = SQLHelp.ExecuteNonQuery(trans, System.Data.CommandType.Text, addAccountInfo.ToString(), null);
                                } else
                                {
                                    trans.Rollback();
                                    return -1;
                                }
                            }
                            else
                            {
                                int id = Convert.ToInt32(dt.Rows[0]["Id"].ToString());
                                if (string.IsNullOrEmpty(dt.Rows[0]["Balance"].ToString()))
                                {
                                    accountBalance = price;
                                }else
                                {
                                    accountBalance = Convert.ToInt32(dt.Rows[0]["Balance"].ToString()) + price;
                                }
                                //accountBalance = accountBalance - ConsumptionPrice;
                                if(accountBalance >=0)
                                {
                                    StringBuilder updAccountInfo = new StringBuilder();
                                    updAccountInfo.AppendFormat("update AccountInfo set [Balance] = '{0}' ,[Editor] = '{1}' , [UpdateTime] = '{2}' where [Id]={3}", accountBalance, ht["UserName"].SafeToString(), DateTime.Now, id);
                                    result = SQLHelp.ExecuteNonQuery(trans, System.Data.CommandType.Text, updAccountInfo.ToString(), null);
                                }else
                                {
                                    trans.Rollback();
                                    return -1;
                                }
                                    
                            }

                            //if (status == 2)
                            //{
                            //    StringBuilder addPriceHistory = new StringBuilder();
                            //    addPriceHistory.AppendFormat("insert into CardPriceHistory (UserName,IdCard,ConsumingTime,ConsumptionPrice,Balance,Creator,CreateTime) values ('{0}','{1}','{2}','{3}','{4}','{5}','{6}')", ht["UserName"].SafeToString(), ht["IdCard"].SafeToString(), DateTime.Now, ConsumptionPrice, accountBalance, ht["UserName"].SafeToString(), DateTime.Now);
                            //    result = SQLHelp.ExecuteNonQuery(trans, System.Data.CommandType.Text, addPriceHistory.ToString(), null);
                            //}
                            if (result > 0)
                            {
                                trans.Commit();
                                return number;
                            }
                            else
                            {
                                trans.Rollback();
                                return -1;
                            }

                        }
                        else
                        {
                            trans.Rollback();
                            return -1;
                        }
                    }
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    return -1;
                }
            }
            return 0;
        }
    }
}
