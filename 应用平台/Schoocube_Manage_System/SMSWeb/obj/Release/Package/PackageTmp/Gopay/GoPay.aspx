<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoPay.aspx.cs" Inherits="SMSWeb.ziaxianzhifu.GoPay" %>

<!DOCTYPE html>

<html>
<head>
    <meta name="viewport" content="width=device-width" />
    <title>账户管理</title>
    <!--支付-->
    <link href="http://img.51liucheng.com/u/wwwv3/style/lcw-index2015.css" type="text/css" rel="stylesheet" />
    <link type="text/css" rel="stylesheet" href="http://img.51liucheng.com/u/js/jBox/Skins2/blue/jbox.css" />
    <script type="text/javascript" src="http://img.51liucheng.com/u/js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="http://img.51liucheng.com/u/js/jBox/jquery.jBox-2.3.min.js"></script>
    <script type="text/javascript" src="http://img.51liucheng.com/u/js/jBox/i18n/jquery.jBox-zh-CN.js"></script>
    <script src="common.js"></script>
    <link href="lcpay0521.css" rel="stylesheet" />
    <script src="ShopCart.js"></script>
    <script src="Login.js"></script>
    <link href="zxbank.css" rel="stylesheet" />
    <link rel="stylesheet" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
    
    <style>
        .navbar ul li a{text-decoration:none;}
        .hide {
            display: none;
        }

        .SelectPayType {
            overflow: hidden;
        }
    </style>
    <!--支付-->
</head>
<body>
    <header class="repository_header_wrap manage_header">
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HUserName" runat="server" />
        <input type="hidden" id="HId" runat="server" />
        <input type="hidden" id="HPrice" runat="server" value="0" />
        <input type="hidden" id="HPayTime" runat="server" />
        <input type="hidden" id="HSF" runat="server" />
        <div class="width repository_header clearfix">
            <a href="../HZ_Index.aspx" class="logo fl">
                <img src="../images/logo.png" /></a>
            <div class="wenzi_tips fl ">
                <img src="../images/zhanghuguanli.png" />
             </div>
            <nav class="navbar menu_mid fl">
                <ul>
                    <li currentclass="active"><a href="/GoPay/Pay_Index.aspx">我的账户</a></li>
                        <li currentclass="active" class="active"><a href="/GoPay/GoPay.aspx">充值</a></li>
                        <li currentclass="active"><a href="/AccountManagement/PrepaidStatistics.aspx?type=1">消费统计</a></li>
                    <%--<li currentclass="active"><a href="/AccountManagement/CardHistory.aspx?type=1">充值记录</a></li>
                    <li currentclass="active"><a href="/AccountManagement/PrepaidCardHistory.aspx?type=1">消费记录</a></li>
                    <li currentclass="active"><a href="/AccountManagement/PrepaidStatistics.aspx?type=1">消费统计</a></li>--%>
                </ul>
            </nav>
            <div class="search_account fr clearfix">
                <ul class="account_area fl">
                    <li>
                        <a href="javascript::" class="dropdown-toggle">
                            <i class="icon icon-envelope"></i>
                            <span class="badge">3</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript::" class="login_area clearfix">
                            <div class="avatar">
                                <img src="<%=PhotoURL %>" />
                            </div>
                            <h2><%=Name %>
                            </h2>
                        </a>
                    </li>
                </ul>
                <div class="settings fl pr ">
                    <a href="javascript:;">
                        <i class="icon icon-cog"></i>
                    </a>
                    <div class="setting_none">
                        <%--<a href="/Gopay/GoPay.aspx"><span>账户管理</span></a>
                        <a href="/PersonalSpace/PersonalSpace_Teacher.aspx" target="_blank"><span>个人中心</span></a>
                        <span onclick="logOut()">退出</span>--%>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div class="onlinetest_item width pt90 pr">
        <div style="width: 100%; background: #fff;" class="bordshadrad clearfix">
            <div style="padding: 20px 20px 20px 10px;">
                
                <span style="font-size: 20px; margin-left: 15px;">选择我的支付方式</span>
                <%--<span class="manage-address">
                    <a href="/Home/Address" target="_blank" title="选择我的支付方式"
                        class="J_MakePoint" data-point-url="">选择我的支付方式</a>
                </span>--%>
                <div class="paymain">
                    <!--银行卡支付-->
                    <div id="PayInfo_PayControls_BankDiv" class="paylist focusborder" style="display: block;">
                        <div onclick="SelectPayType(0,'ul_bankPay',this,'div_bankPay')" class="SelectPayType" id="SelectPayType1">
                            <div class="iconRadio checkIconRadio"></div>
                            <div class="typepay cardbank">银行卡</div>
                            <div class="payPrompt"><span class="payPromptIcon"></span>支付金额3000元下建议使用快捷支付，3000元以上可使用在线支付。</div>
                        </div>
                        <ul class="cardbank_info" id="ul_bankPay">
                            <!--<li class="kjzfimg focusIcon" onclick="SelectPayMent(7,'div_bankPay','ul_bankPay',0)">
                        <img src="http://img.51liucheng.com/u/pay/bankcard_03.jpg" title="快捷支付" />
                    </li>-->
                            <li class="zxzfimg focusIcon" onclick="SelectPayMent(4,'div_bankPay','ul_bankPay',0)">
                                <img src="http://img.51liucheng.com/u/pay/bankcard_05.jpg" title="在线支付" />
                            </li>
                        </ul>
                        <!--在线支付S-->
                        <div class="wgpay" id="div_bankPay">
                            <ul id="tags" class="tags">
                                <li class="selectTag"><a onclick="selectTag('tagContent0',this)" href="javascript:void(0)">储蓄卡支付</a></li>
                                <li><a onclick="selectTag('tagContent1',this)" href="javascript:void(0)">信用卡支付</a> </li>
                            </ul>
                            <div id="tagContent">
                                <div class="tagContent selectTag" id="tagContent0">
                                    <ul class="wyzf_con">
                                        <li>
                                            <input type="radio" value="ICBC" name="BankType" checked="checked" class="lcwallet_radio" />
                                            <span class="bank_logo gszf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="CCB" name="BankType" class="lcwallet_radio" />
                                            <span class="bank_logo jsyy"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="COMM" name="BankType" class="lcwallet_radio" />
                                            <span class="bank_logo jtzf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="ABC" name="BankType" class="lcwallet_radio" />
                                            <span class="bank_logo nyzf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="CMB" name="BankType" class="lcwallet_radio" />
                                            <span class="bank_logo zszf"></span>
                                        </li>

                                        <li>
                                            <input type="radio" value="BOC" name="BankType" class="lcwallet_radio" />
                                            <span class="bank_logo zgzf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="CEB" name="BankType" class="lcwallet_radio" />
                                            <span class="bank_logo gdzf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="CMBC" name="BankType" class="lcwallet_radio" />
                                            <span class="bank_logo mszf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="CITIC" name="BankType" class="lcwallet_radio" />
                                            <span class="bank_logo zxzf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="CIB" name="BankType" class="lcwallet_radio" />
                                            <span class="bank_logo xyzf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="cgb" name="BankType" class="lcwallet_radio" />
                                            <span class="bank_logo gfzf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="SPDB" name="BankType" class="lcwallet_radio" />
                                            <span class="bank_logo pfzf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="pingan" name="BankType" class="lcwallet_radio" />
                                            <span class="bank_logo pazf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="BOS" name="BankType" class="lcwallet_radio" />
                                            <span class="bank_logo shzf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="PSBC" name="BankType" class="lcwallet_radio" />
                                            <span class="bank_logo yzzf"></span>
                                        </li>
                                    </ul>
                                </div>
                                <div class="tagContent" id="tagContent1">
                                    <ul class="wyzf_con">
                                        <li>
                                            <input type="radio" value="ICBC" name="CreditCardType" checked="checked" class="lcwallet_radio" />
                                            <span class="bank_logo gszf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="CCB" name="CreditCardType" class="lcwallet_radio" />
                                            <span class="bank_logo jsyy"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="COMM" name="CreditCardType" class="lcwallet_radio" />
                                            <span class="bank_logo jtzf"></span>
                                        </li>

                                        <li>
                                            <input type="radio" value="ABC" name="CreditCardType" class="lcwallet_radio" />
                                            <span class="bank_logo nyzf"></span>
                                        </li>
                                        <li style="display: none;">
                                            <input type="radio" value="CMB" name="CreditCardType" class="lcwallet_radio" />
                                            <span class="bank_logo zszf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="BOC" name="CreditCardType" class="lcwallet_radio" />
                                            <span class="bank_logo zgzf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="CEB" name="CreditCardType" class="lcwallet_radio" />
                                            <span class="bank_logo gdzf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="CMBC" name="CreditCardType" class="lcwallet_radio" />
                                            <span class="bank_logo mszf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="CITIC" name="CreditCardType" class="lcwallet_radio" />
                                            <span class="bank_logo zxzf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="CIB" name="CreditCardType" class="lcwallet_radio" />
                                            <span class="bank_logo xyzf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="cgb" name="CreditCardType" class="lcwallet_radio" />
                                            <span class="bank_logo gfzf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="SPDB" name="CreditCardType" class="lcwallet_radio" />
                                            <span class="bank_logo pfzf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="pingan" name="CreditCardType" class="lcwallet_radio" />
                                            <span class="bank_logo pazf"></span>
                                        </li>
                                        <li>
                                            <input type="radio" value="BOS" name="CreditCardType" class="lcwallet_radio" />
                                            <span class="bank_logo shzf"></span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!--在线支付E-->
                    </div>

                    <!--支付平台-->
                    <div id="PayInfo_PayControls_AliPayDiv" class="paylist" style="display: block;">
                        <div onclick="SelectPayType(1,'ul_payment',this,'div_zfbpay')" class="SelectPayType" id="SelectPayType2">
                            <div class="iconRadio"></div>
                            <div class="typepay paypt">支付平台</div>
                            <div class="payPrompt zhifubaopt"><span class="payPromptIcon"></span>支付宝余额支付单笔5万；支付宝快捷支付：储蓄卡单笔5千-2万，信用卡单笔2万-5万；微信零钱支付单笔不限；支付宝手机钱包支付请选用支付宝余额。</div>
                        </div>
                        <ul class="pingtpay hide" id="ul_payment">
                            <li class="zfbimg focusIcon" onclick="SelectPayMent(1,'div_zfbpay','ul_payment',0)">
                                <img src="http://img.51liucheng.com/u/pay/bankcard_09.jpg" title="支付宝支付" />
                            </li>
                            <li class="wxzfimg" onclick="SelectPayMent(2,'div_weixinpay','ul_payment',1)">
                                <img src="http://img.51liucheng.com/u/pay/bankcard_11.jpg" title="微信支付" />
                            </li>
                            <li class="wxzfimg" onclick="SelectPayMent(3,'div_czkpay','ul_payment',2)">
                                <img src="../images/czk.jpg" title="充值卡支付" />
                            </li>
                            <li class="wxzfimg" onclick="SelectPayMent(4,'div_yqkpay','ul_payment',3)">
                                <img src="../images/yqk.jpg" title="邀请卡支付" />
                            </li>
                        </ul>
                        <div class="payzfbBox hide" id="div_weixinpay">
                            <div class="payzfb">
                                <div class="weixinpay">
                                    <p class="weixinpay_des"><span>请使用微信扫描右侧二维码以完成支付</span></p>
                                    <div class="weixinpay_ewm">
                                        <h2>
                                            <img src="/Content/mimaqiangruo/images/%e5%be%ae%e4%bf%a1.png" />
                                            <div class="prompt">
                                                <img src="../images/weixinttcipone.png" />
                                            </div>
                                        </h2>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <form name="" id="" action="#">
                            <div class="payzfbBox hide" style="text-align: center" id="div_zfbpay">
                                <div class="payzfb">
                                    <div class="weixinpay">
                                        <div style="width: 290px; float: left;" class="weixinpay_des"><span>请正确输入支付宝账号和密码以完成支付</span></div>
                                        <div class="weixinpay_ewm" style="float: left;">
                                            <table style="margin-top: 50px; border-collapse: separate; border-spacing: 5px;">
                                                <tr>
                                                    <td><span>支付宝账号:</span></td>
                                                    <td>
                                                        <input type="text" style="width: 200px; border: 1px solid #ccc; height: 30px;" name="ZFBNumbers" id="ZFBNumbers" value="" /></td>
                                                </tr>
                                                <tr>
                                                    <td><span>支付宝密码:</span></td>
                                                    <td>
                                                        <input type="password" style="width: 200px; border: 1px solid #ccc; height: 30px;" name="ZFBPwds" id="ZFBPwds" value="" /></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" style="text-align: center">
                                                        <input type="submit" value="确认支付" style="border: none; color: #fff; width: 80px; height: 30px; background: #0488C9; border-radius: 2px; font-size: 14px; margin-top: 10px;" /></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <%--<form name="" id="" action="#">--%>
                        <div class="payzfbBox hide" style="text-align: center" id="div_czkpay">
                            <div class="payzfb">
                                <div class="weixinpay">
                                    <div style="width: 290px; float: left;" class="weixinpay_des"><span>请正确输入充值卡账号与密码</span></div>
                                    <div class="weixinpay_ewm" style="float: left;">
                                        <table style="margin-top: 50px; border-collapse: separate; border-spacing: 5px;">
                                            <tr>
                                                <td><span>充值卡账号:</span></td>
                                                <td>
                                                    <input type="text" style="width: 200px; border: 1px solid #ccc; height: 30px;" name="cardNo" id="cardNo" value="" maxlength="18" /></td>
                                            </tr>
                                            <tr>
                                                <td><span>充值卡密码:</span></td>
                                                <td>
                                                    <input type="password" style="width: 200px; border: 1px solid #ccc; height: 30px;" name="pwd" id="pwd" value="" maxlength="6" /></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: center">
                                                    <input type="submit" value="确认充值" id="BtnPay" onclick="AccountPay()" style="border: none; color: #fff; width: 80px; height: 30px; background: #0488C9; border-radius: 2px; font-size: 14px; margin-top: 10px;" /></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%--</form>--%>
                        <form name="" id="" action="#">
                            <div class="payzfbBox hide" style="text-align: center" id="div_yqkpay">
                                <div class="payzfb">
                                    <div class="weixinpay">
                                        <div style="width: 290px; float: left;" class="weixinpay_des"><span>请正确输入邀请卡账号与密码</span></div>
                                        <div class="weixinpay_ewm" style="float: left;">
                                            <table style="margin-top: 50px; border-collapse: separate; border-spacing: 5px;">
                                                <tr>
                                                    <td><span>邀请卡账号:</span></td>
                                                    <td>
                                                        <input type="text" style="width: 200px; border: 1px solid #ccc; height: 30px;" name="YQKNumbers" id="YQKNumbers" value="" /></td>
                                                </tr>
                                                <tr>
                                                    <td><span>邀请卡密码:</span></td>
                                                    <td>
                                                        <input type="password" style="width: 200px; border: 1px solid #ccc; height: 30px;" name="YQKPwds" id="YQKPwds" value="" /></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" style="text-align: center">
                                                        <input type="submit" value="确认支付" style="border: none; color: #fff; width: 80px; height: 30px; background: #0488C9; border-radius: 2px; font-size: 14px; margin-top: 10px;" /></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<script src="../js/common.js"></script>
    <script src="../js/system.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

    $(function () {
        if ($("#HSF").val() == "学生") {
            $("div[class='setting_none']").append("<a href=\"/Gopay/GoPay.aspx\"><span>账户管理</span></a><a href=\"/PersonalSpace/PersonalSpace_Teacher.aspx\" target=\"_blank\"><span>个人中心</span></a> <span onclick=\"logOut()\">退出</span>")
        } else {
            $("div[class='setting_none']").append("<a href=\"/PersonalSpace/PersonalSpace_Teacher.aspx\" target=\"_blank\"><span>个人中心</span></a> <span onclick=\"logOut()\">退出</span>")
        }
        //清空支付宝账号和密码
        $("#ZFBNumbers").val("");
        $("#ZFBPwds").val("");
        $(".wyzf_con li").click(function () {

            var li = $(this).find(".lcwallet_radio");
            li.attr("checked", "true");
        })
        $(".paylist").eq(2).find("div").eq(0).click()

    })
    var PayType = 0;
    var CardType = 1;
    var weixin;
    function SelectPayType(a, b, c, d) {
        if (a == 0) {
            $('#ul_payment').hide();
            $('#div_zfbpay').hide();
            $('#div_weixinpay').hide();
            $('#div_czkpay').hide();
            $('#div_yqkpay').hide();
            $('#SelectPayType2').find(".iconRadio").removeClass("checkIconRadio");
        }
        if (a == 1) {
            $('#ul_bankPay').hide();
            $('#div_bankPay').hide();
            $('#SelectPayType1').find(".iconRadio").removeClass("checkIconRadio");
        }
        $("#" + b).slideDown();
        $('#' + d).slideDown();
        $("#" + b).find("li").removeClass("focusIcon");
        $("#" + b).find("li").eq(0).addClass("focusIcon");
        $(".focusborder").removeClass("focusborder");
        $(c).find(".iconRadio").addClass("checkIconRadio");
        $(c).parent().addClass("focusborder");
        /* $(".hide").hide();
         $(".payPrompt").hide();
         $(".recharge").hide();
         $(".iconRadio").removeClass("checkIconRadio")
         $(".focusborder").removeClass("focusborder");
 
         PayType = a;
 
         $(c).find(".iconRadio").addClass("checkIconRadio");
         $(c).find(".payPrompt").fadeIn();
         //如果是余额支付，则显示余额
         if (a == 1) {
             $(c).find(".recharge").fadeIn();
         }
         $(c).parent().addClass("focusborder")
         $("#" + b).slideDown();
         $('#' + d).slideDown();
         $("#" + b).find("li").removeClass("focusIcon");
         $("#" + b).find("li").eq(0).addClass("focusIcon");*/
    }
    function SelectPayMent(a, b, c, d) {
        //被选中样式变化
        $("#" + c + " li").removeClass("focusIcon");
        $("#" + c + " li").eq(d).addClass("focusIcon");
        //支付宝
        if (a == 1 && d == 0) {
            $("#" + b).show();
            $('#div_weixinpay').hide();
            $('#div_czkpay').hide();
            $('#div_yqkpay').hide();
        }
        if (a == 2 && d == 1) {
            $("#" + b).show();
            $('#div_zfbpay').hide();
            $('#div_czkpay').hide();
            $('#div_yqkpay').hide();
        }
        if (a == 3 && d == 2) {
            $("#" + b).show();
            $('#div_weixinpay').hide();
            $('#div_zfbpay').hide();
            $('#div_yqkpay').hide();
        }
        if (a == 4 && d == 3) {
            $("#" + b).show();
            $('#div_weixinpay').hide();
            $('#div_zfbpay').hide();
            $('#div_czkpay').hide();
        }
        /*if (a == 6 && d == 1)   //微信
        {
            $("#div_zfbpay").css('display', 'none');
            $("#" + b).slideDown();
        }
        if(a == 1 && d ==2){
            $("#div_czkpay").css('display', 'none');
            $("#" + b).slideDown();
        }
        if (a == 3 && d == 0)    //支付宝
        {
            $("#div_weixinpay").css('display', 'none');
            $("#" + b).slideDown();
            //location.href = '../Pay/index.asp';
        }
        if (a == 4 && d == 1)   //在线支付
        {
            $("#" + b).slideDown();
        }
        if (a == 7 && d == 0) {
            $("#div_bankPay").slideUp();
        }*/

    }
    function selectTag(showContent, selfObj) {
        var tag = document.getElementById("tags").getElementsByTagName("li");
        var taglength = tag.length;
        for (i = 0; i < taglength; i++) {
            tag[i].className = "";
        }
        selfObj.parentNode.className = "selectTag";
        for (i = 0; j = document.getElementById("tagContent" + i) ; i++) {
            j.style.display = "none";
        }
        document.getElementById(showContent).style.display = "block";
        if (showContent == "tagContent1")
            CardType = 2;
        else
            CardType = 1;
    }

    jQuery(document).ready(function ($) {
        $('.theme-poptit .close').click(function () {
            $('.theme-popover-mask').fadeOut(500);
            $('.theme-popover').slideUp(200);
        })
    })
    function AccountPay() {
        var cardNo = "";
        var pwd = "";
        var HId = "";
        cardNo = $("#cardNo").val();
        pwd = $("#pwd").val();

        if (cardNo.length != 18) {
            layer.alert("卡号位数不对,请重新输入!");
            $("#carNo").focus();
            return;
        }
        if (pwd.length != 6) {
            layer.alert("密码位数不对,请重新输入!");
            $("#pwd").focus();
            return;
        }
        if (cardNo == "" || pwd == "") {
            layer.alert("请输入完整信息");
            return;
        }
        getData(cardNo, pwd);
        HId = $("#HId").val();
        if (HId.length > 0) {
            addCardInfo(cardNo, HId);
        } else {
            layer.alert("卡号或密码不对,请重新输入");
        }
    }
    //查询用户密码
    function getData(cardNo, pwd) {
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "AccountManagement/PrepaidCardCenterHander.ashx", "Func": "GetPageList", "CardNo": cardNo, "Pwd": pwd, "Ispage": false, "CardStatus": 0
            },
            success: OnSuccess,
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg("操作失败！");
            }
        });
    }
    //获取数据成功显示列表
    function OnSuccess(json) {
        if (json.result.errNum.toString() == "0") {
            var id = "";
            var price = "";
            $(json.result.retData).each(function (i, n) {
                id = n.Id;
                price = n.Price;
            });
            $("#HId").attr("value", id);
            $("#HPrice").attr("value", price);//面值
        } else {
            layer.msg("用户名或密码不正，请重新输入！");
        }
    }

    //充值卡激活，添加用户
    function addCardInfo(carNo, id) {
        var consumptionPrice = "";
        var username = "";
        var idcard = "";
        var price = "";
        username = $("#HUserName").val();
        idcard = $("#HUserIdCard").val();
        price = $("#HPrice").val();
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "AccountManagement/PrepaidCardCenterHander.ashx", "Func": "PayCard", "CardId": id, "UserName": username, "IdCard": idcard, "Price": price, "CarNo": carNo, "ConsumptionPrice": consumptionPrice
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    layer.msg("充值成功！");
                    $("#carNo").val('');
                    $("#pwd").val('');

                } else {
                    layer.msg("充值失败！");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg("充值失败！");
            }
        });
    }
</script>

