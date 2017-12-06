using SMSIDAL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSDAL
{
    public partial class CardPriceHistoryDal : HZ_BaseDal<CardPriceHistory>, ICardPriceHistoryDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage, string where)
        {
            RowCount = 0;
            DataTable dt = new DataTable();
            int StartIndex = 0;
            int EndIndex = 0;

            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                //识别是不是消费统计
                if (ht.ContainsKey("HistoryStatistics") && !string.IsNullOrEmpty(ht["HistoryStatistics"].SafeToString()))
                {
                    sbSql4org.Append(@"select sum(ConsumptionPrice) as ConsumptionPrice,Month(ConsumingTime) as ConsumingTime from CardPriceHistory cph where 1=1 and cph.IsDelete=0");
                }
                else if (ht.ContainsKey("TypeHistoryStatistics") && !string.IsNullOrEmpty(ht["TypeHistoryStatistics"].SafeToString()))
                {
                    sbSql4org.Append(@"select sum(ConsumptionPrice) as ConsumptionPrice,CardPriceUse,Month(ConsumingTime) as ConsumingTime,CardId from CardPriceHistory cph where 1=1 and cph.IsDelete=0");

                }
                else
                {
                    sbSql4org.Append(@"select *  from CardPriceHistory cph where 1=1 and cph.IsDelete=0");
                }


                if (ht.ContainsKey("Id") && !string.IsNullOrEmpty(ht["Id"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and cph.Id ='{0}' ", ht["Id"].ToString());
                }

                if (ht.ContainsKey("IdCard") && !string.IsNullOrEmpty(ht["IdCard"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and cph.IdCard ='{0}' ", ht["IdCard"].ToString());
                }

                if (ht.ContainsKey("CardPriceUse") && !string.IsNullOrEmpty(ht["CardPriceUse"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and cph.CardPriceUse ='{0}' ", ht["CardPriceUse"].ToString());
                }
                if (ht.ContainsKey("HistoryStatistics") && !string.IsNullOrEmpty(ht["HistoryStatistics"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" group by {0}", ht["HistoryStatistics"].ToString());
                }

                if (ht.ContainsKey("TypeHistoryStatistics") && !string.IsNullOrEmpty(ht["TypeHistoryStatistics"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" group by {0},Month(ConsumingTime)", ht["TypeHistoryStatistics"].ToString());
                }
                if (IsPage)
                {
                    StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                dt = SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", where, "ConsumingTime", StartIndex, EndIndex, IsPage, null, out RowCount);
            }
            catch (Exception ex)
            {
                //写入日志
                //throw 
                return null;
            }

            return dt;

        }
    }
}
