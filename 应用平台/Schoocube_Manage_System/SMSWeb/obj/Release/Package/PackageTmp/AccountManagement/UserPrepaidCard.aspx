<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserPrepaidCard.aspx.cs" Inherits="SMSWeb.AccountManagement.UserPrepaidCard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>充值</title>
    <!--图标样式-->
    <link rel="stylesheet" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />
    <link rel="stylesheet" href="../css/plan.css" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
			<script src="../js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../Scripts/Common.js"></script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />
    <input type="hidden" id="HId" runat="server" />
    <input type="hidden" id="HPrice" runat="server" value="0" />
    <input type="hidden" id="HPayTime" runat="server" />
    <div class="MenuDiv">
        <table class="tbEdit">
            <tbody>
                <tr>
                    <td class="mi">卡号：
                    </td>
                    <td class="ku">
                        <input name="" type="text" id="cardNo" maxlength="19">
                        <span style="color: red;">*卡号为19位</span>
                    </td>
                </tr>
                <tr>
                    <td class="mi">密码：
                    </td>
                    <td class="ku">
                        <input name="" type="password" id="pwd" maxlength="6">
                        <span style="color: red;">*密码为6位数</span>
                    </td>
                </tr>
                <td class="ku t_btn" colspan="2">
                    <input type="submit" name="" value="充值" class="btn" id="BtnPay" onclick="AccountPay()">
                </td>
                </tr>
            </tbody>
        </table>
    </div>
    <script src="../js/common.js"></script>
    <script>
        $(document).ready(function () {
            //回车提交事件
            $("body").keydown(function () {
                if (event.keyCode == "13") {//keyCode=13是回车键
                    $("#BtnPay").click();
                }
            });
        });

        function AccountPay() {
            var cardNo = "";
            var pwd = "";
            var HId = "";
            cardNo = $("#cardNo").val();
            pwd = $("#pwd").val();
            if (cardNo == "" || pwd == "") {
                layer.alert("请输入完整信息");
                return;
            }
            if (cardNo.length != 19) {
                layer.alert("卡号位数不对,请重新输入");
                $("#carNo").focus();
                return;
            }
            if (pwd.length != 6) {
                layer.alert("密码位数不对,请重新输入");
                $("#pwd").focus();
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
                    "PageName": "AccountManagement/PrepaidCardCenterHander.ashx", "Func": "GetPageList", "CardNo": cardNo, "Pwd": pwd, "Ispage": false, "CardStatus": 0, "UserStatus": 0
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
</body>
</html>


