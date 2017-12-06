using SMSBLL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SMSHanderler.AccountManagement
{
    /// <summary>
    /// PrepaidCardCenterHander 的摘要说明
    /// </summary>
    public class PrepaidCardCenterHander : IHttpHandler
    {
        PrepaidCardManagementService bll = new PrepaidCardManagementService();
        PaidCardManagementService pcmBll = new PaidCardManagementService();
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JsonModel pcmJsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        string result = string.Empty;

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            // HttpPostedFile hpf = HttpContext.Current.Request.Files["imgfile"];//HttpPostedFile提供对客户端已上载的单独文件的访问        string savepath = context.Server.MapPath("." + hpf.FileName);//路径,相对于服务器当前的路径        hpf.SaveAs(savepath);//保存        context.Response.Write("保存成功"+hpf.FileName);
            string FuncName = context.Request["Func"].ToString();
            

            if (FuncName != null && FuncName != "")
            {
                try
                {
                    switch (FuncName)
                    {
                        case "GetPageList":
                            GetPageList(context);
                            break;
                        case "AddCard":
                            AddCard(context);
                            break;
                        case "PayCard":
                            PayCard(context);
                            break;
                        case "DelCard":
                            DelCard(context);
                            break;
                        case "ChangeStatus":
                            ChangeStatus(context);
                            break;
                        case "ChangeCardStatus":
                            ChangeCardStatus(context);
                            break;
                        default:
                            jsonModel = new JsonModel()
                            {
                                errNum = 404,
                                errMsg = "无此方法",
                                retData = ""
                            };
                            break;
                    }
                    LogService.WriteLog("");
                }
                catch (Exception ex)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 400,
                        errMsg = ex.Message,
                        retData = ""
                    };
                    LogService.WriteErrorLog(ex.Message);
                }
                //result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
                //context.Response.Write(result);
                //context.Response.End();
            }
        }

        #region 获取充值卡信息
        /// <summary>
        /// 获取课程信息
        /// </summary>
        /// <param name="context"></param>
        private void GetPageList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("TableName", "PrepaidCardManagement");
                ht.Add("CardNo", context.Request["CardNo"].SafeToString());
                ht.Add("Pwd", context.Request["Pwd"].SafeToString());
                ht.Add("Id", context.Request["Id"].SafeToString());
                ht.Add("UserName", context.Request["UserName"].SafeToString());
                ht.Add("UseStatus", context.Request["UseStatus"].SafeToString());
                ht.Add("CardStatus", context.Request["CardStatus"].SafeToString());
                ht.Add("IdCard", context.Request["IdCard"].SafeToString());
                ht.Add("Price", context.Request["Price"].SafeToString());
                bool Ispage = true;
                if (context.Request["Ispage"].SafeToString().Length > 0)
                {
                    Ispage = Convert.ToBoolean(context.Request["Ispage"]);
                }
                jsonModel = bll.GetPage(ht, Ispage);
                result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
                context.Response.Write(result);
                context.Response.End();
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
        }
        #endregion

        #region 添加充值卡信息

        /// <summary>
        /// 添加充值卡信息
        /// </summary>
        /// <param name="context"></param>
        private void AddCard(HttpContext context)
        {
            Key key = new Key();
            try
            {
                PrepaidCardManagement pcm = new PrepaidCardManagement();
                string UserName = context.Request["UserName"].SafeToString();
                if (!string.IsNullOrEmpty(context.Request["JsonCardInfo"]))
                {
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    var arrAdd = (Dictionary<string, string>[])js.Deserialize<Dictionary<string, string>[]>(context.Request["JsonCardInfo"]);
                    for (var j = 0; j < arrAdd.Length; j++)
                    {
                        foreach (KeyValuePair<string, string> dic in arrAdd[j])
                        {
                            if (dic.Key == "CardNo")
                            {
                                pcm.CardNo = dic.Value;
                            }
                            if (dic.Key == "Pwd")
                            {
                                pcm.Pwd = Convert.ToInt32(dic.Value);
                            }
                            if (dic.Key == "Price")
                            {
                                pcm.Price = dic.Value;
                            }
                        }
                        pcm.AccountPrice = 0;
                        pcm.Creator = UserName;
                        pcm.CreateTime = DateTime.Now;
                        jsonModel = bll.Add(pcm);
                    }
                }
                result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
                context.Response.Write(result);
                context.Response.End();

            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
        }

        ///// <summary>
        ///// 更新用户使用了那张卡并激活
        ///// </summary>
        ///// <param name="context"></param>
        //private void PayCard(HttpContext context)
        //{
        //    try
        //    {
        //        PrepaidCardManagement pcm = new PrepaidCardManagement();
        //        string UserName = context.Request["UserName"].SafeToString();
        //        string IdCard = context.Request["IdCard"].SafeToString();


        //        //pcmJsonModel = bll.GetEntityListByField("IdCard", context.Request["IdCard"]);
        //        //if(pcmJsonModel.errNum == 0)
        //        //{

        //        //}else
        //        //{

        //        //}
        //        //用户激活卡进行充值
        //        //if (context.Request["UserName"].SafeToString().Length > 0)
        //        //{
        //        //    pcm.UserName = UserName;
        //        //}
        //        //if (context.Request["Id"].SafeToString().Length > 0)
        //        //{
        //        //    pcm.Id = Convert.ToInt32(context.Request["Id"]);
        //        //    //pcm.AccountPrice = Convert.ToInt32(context.Request["AccountPrice"]);
        //        //    pcm.IdCard = context.Request["IdCard"];
        //        //    pcm.UserName = UserName;
        //        //    pcm.CardStatus = 1;
        //        //    pcm.Editor = UserName;
        //        //    pcm.UpdateTime = DateTime.Now;
        //        //    pcm.PayTime = DateTime.Now;
        //        //    jsonModel = bll.Update(pcm);
        //        //}
        //    }
        //    catch (Exception ex)
        //    {
        //        jsonModel = new JsonModel()
        //        {
        //            errNum = 400,
        //            errMsg = ex.Message,
        //            retData = ""
        //        };
        //        LogService.WriteErrorLog(ex.Message);
        //    }
        //}

        /// <summary>
        /// 更新用户使用了那张卡并激活
        /// 添加账户管理表，以及添加充值历史记录
        /// </summary>
        /// <param name="context"></param>
        public void PayCard(HttpContext context)
        {
            SMSModel.JsonModel jsonModel = new SMSModel.JsonModel();
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("UserName",context.Request["UserName"].SafeToString());
                ht.Add("IdCard",context.Request["IdCard"].SafeToString());
                ht.Add("CarNo", context.Request["CarNo"].SafeToString());
                ht.Add("CardId", context.Request["CardId"].SafeToString());
                ht.Add("Price", context.Request["Price"].SafeToString());
                ht.Add("ConsumptionPrice", context.Request["ConsumptionPrice"].SafeToString());
                jsonModel = pcmBll.PrepaidCardHistory(ht);
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                jsonModel = new SMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    retData = "",
                };

                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
        }
        #endregion

        #region 删除充值卡信息

        private void DelCard(HttpContext context)
        {
            Key key = new Key();
            try
            {
                PrepaidCardManagement pcm = new PrepaidCardManagement();
                string UserName = context.Request["UserName"].SafeToString();
                if (context.Request["Id"].SafeToString().Length > 0)
                {
                    pcm.Id = Convert.ToInt32(context.Request["Id"]);
                    pcm.IsDelete = 1;
                    pcm.Editor = UserName;
                    pcm.UpdateTime = DateTime.Now;
                    jsonModel = bll.Update(pcm);
                    result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
                    context.Response.Write(result);
                    context.Response.End();
                }

            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
        }
        #endregion

        #region 更改状态
        public void ChangeStatus(HttpContext context)
        {
            PrepaidCardManagement pcm = new PrepaidCardManagement();
            pcm.Id = Convert.ToInt32(context.Request["Id"]);
            pcm.UseStatus = Convert.ToByte(context.Request["Status"]);
            pcm.Editor = context.Request["UserName"];
            pcm.UpdateTime = DateTime.Now;
            jsonModel = bll.Update(pcm);
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();
        }
        /// <summary>
        /// 更新激活状态
        /// </summary>
        /// <param name="context"></param>
        public void ChangeCardStatus(HttpContext context)
        {
            PrepaidCardManagement pcm = new PrepaidCardManagement();
            string userName = context.Request["UserName"].SafeToString();
            string IdCard = context.Request["IdCard"].SafeToString();
            if (!string.IsNullOrEmpty(context.Request["Id"]))
            {
                pcm.Id = Convert.ToInt32(context.Request["Id"]);
                pcm.CardStatus = 1;
                pcm.Editor = userName;
                pcm.UserName = userName;
                pcm.IdCard = IdCard;
                pcm.UpdateTime = DateTime.Now;
                jsonModel = bll.Update(pcm);
                result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
                context.Response.Write(result);
                context.Response.End();
            }
            //else
            //{
            //    if (!string.IsNullOrEmpty(context.Request["CardNo"]))
            //    {
            //        pcm.CardNo = context.Request["CardNo"];
            //        jsonModel = bll.GetEntityListByField("CardNo", context.Request["CardNo"]);
            //        if (jsonModel.errNum == 0)
            //        {
            //            List<PrepaidCardManagement> list = (List<PrepaidCardManagement>)jsonModel.retData;
            //            if (list.Count > 0)
            //            {
            //                for (int i = 0; i < list.Count; i++)
            //                {
            //                    pcm.Id = list[i].Id;
            //                    pcm.CardStatus = 1;
            //                    pcm.Editor = userName;
            //                    pcm.UserName = userName;
            //                    pcm.IdCard = IdCard;
            //                    pcm.UpdateTime = DateTime.Now;
            //                    jsonModel = bll.Update(pcm);
            //                }

            //            }
            //        }
            //    }
            //}
        }

        #endregion

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}