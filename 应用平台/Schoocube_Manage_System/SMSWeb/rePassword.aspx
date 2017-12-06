<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="rePassword.aspx.cs" Inherits="SMSWeb.rePassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="css/reset.css" />
    <link rel="stylesheet" type="text/css" href="css/common.css" />
    <link rel="stylesheet" type="text/css" href="css/index.css" />
    <style>
        .forget_wrap {
            background: #fff;
        }

        .retrievepwd-progress {
            width: 600px;
            margin: 0 auto;
            padding: 58px 0 30px;
        }

            .retrievepwd-progress .progress-pwd-out {
                background: url(images/steppwd.png) no-repeat 0 0px;
                width: 600px;
                height: 30px;
            }

                .retrievepwd-progress .progress-pwd-out .progress-pwd-inwidth2 {
                    width: 300px;
                }

                .retrievepwd-progress .progress-pwd-out .progress-pwd-in {
                    background: url(images/steppwd.png) no-repeat 0 -40px;
                    height: 30px;
                }

            .retrievepwd-progress .way li.current {
                color: #0b70c0;
            }

            .retrievepwd-progress .way li {
                float: left;
                font-size: 16px;
                padding-top: 13px;
                width: 180px;
                text-align: right;
            }

                .retrievepwd-progress .way li.p1 {
                    width: 140px;
                }

                .retrievepwd-progress .way li.p2 {
                    width: 120px;
                }

        .retrievepwd-cont {
            width: 600px;
            margin: 0 auto;
        }

            .retrievepwd-cont .register-process-list {
                padding-top: 20px;
                width: 600px;
            }

                .retrievepwd-cont .register-process-list li {
                    margin-top: 10px;
                }
                 .register-process-list li{position:relative;}
         .register-process-list li .label {
            display: inline;
            height: 21px;
            float: left;
            width: 172px;
            margin-top: 10px;
            text-align: right;
            margin-right: 3px;
            font-size: 14px;
            position:absolute;
            top:0;left:0;
        }

        .step-content-one-select {
            width: 210px;
            border-radius: 2px;
            height: 32px;
            border: 1px solid #ccc;
        }

        .left {
            padding-left: 180px;
        }

        .getvcode {
            margin-top: 10px;
        }

        .retrievepwd-cont .a-link {
            color: #1970b4;
            text-decoration: underline;
        }

        .ui-inp {
            width: 210px;
            height: 28px;
            border-radius: 2px;
            border: 1px solid #ccc;
        }

        .btn-public-38 {
            display: block;
            margin: 0 auto;
            font-size: 14px;
            height: 38px;
            width: 100px;
            background: #0b70c0;
            color: #fff;
            border-radius: 2px;
            line-height: 38px;
            text-align: center;
            margin-top: 20px;
        }
    </style>
    <script src="Scripts/jquery-1.11.2.min.js"></script>
    <script src="Scripts/Common.js"></script>
    <script src="Scripts/layer/layer.js"></script>
  
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="HIDCard" runat="server" />
        <asp:HiddenField ID="HSF" runat="server" />
        <asp:HiddenField ID="HLoginName" runat="server" />
        <!--header-->
        <header class="repository_header_wrap">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="/Portal/index.aspx">
                    <img src="PortalImages/logoBefore.png" style="margin-top: 5px;" />

                </a>

            </div>
        </header>
        <div class="forget_wrap width" style="min-height:578px;margin-top:200px;">
            <div class="retrievepwd-progress clearfix">
                <div class="progress-pwd-out png24">
                    <div class="progress-pwd-in progress-pwd-inwidth2 png24"></div>
                </div>
                <ul class="clearfix way">
                    <li class="current">选择方式</li>
                    <li class="p1">重置密码</li>
                    <li class="p2">完成</li>
                </ul>
                <div class="retrievepwd-cont">
                    <ul class="register-process-list">
                        <li class="clearfix mb20">
                            <label class="label">新密码：</label>
                            <div class="left">
                                <div class="clearfix">
                                    <input id="input-password" maxlength="20"  name="validate" class="ui-inp" type="password" />
                                </div>
                            </div>
                        </li>
                        <li class="clearfix mb20">
                            <label class="label">再次输入密码：</label>
                            <div class="left">
                                <div class="clearfix">
                                    <input id="input-repassword" maxlength="20" name="validate" class="ui-inp" type="password" />
                                </div>
                            </div>
                        </li>
                    </ul>
                    <a href="javascript:void(0);" id="next-vcode-btn" class="btn-public-38 next-btn">下一步
                    </a>
                </div>
            </div>
        </div>
        <footer class="mt10">
            <div class="footer width clearfix">
                <div class="logo fl">
                    <img src="PortalImages/logoBefore.png" style="margin-top: 10px;" />
                </div>
                <div class="footer_right fr">
                    <p>地址：北京市海淀区中关村环保科技示范园内（海淀区北清路）</p>
                    <p>传真：010-62463259   网址：<a href="#" style="color: #fff;">http://www.bjybjx.cn</a></p>
                    <p>电子邮件（E-MAIL）:yqybjxzb@sohu.com </p>
                </div>
            </div>
        </footer>
    </form>
    <script type="text/javascript">
        $(function () {
            $("#next-vcode-btn").on("click", function () {
                var pwd = $("#input-password").val();
                var repwd = $("#input-repassword").val();
                if (pwd != repwd) {
                    layer.msg("密码不一致！");
                    return false;
                }
                upPwd();
            })
        })

        function upPwd()
        {
            $.ajax({
                url: "/SystemSettings/CommonInfo.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    IDCard: $("#HIDCard").val(),
                    Password: $("#input-password").val(),
                    SF: $("#HSF").val(),
                    Func: "SavePassword"
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("重置密码成功！");

                        window.location = "successPwd.aspx?user=" + encrypt($("#HLoginName").val()) + "&pwd=" + encrypt($("#input-password").val());
                    }
                    else {
                        layer.msg("重置密码失败！");
                    }
                },
                error: OnError
            });
        }
        /*
*功能：对url加密算法（只针对window.location.href跳转，不针对post表单提交及ajax方式）
*算法：对于暴露在浏览器地址栏中的属性值进行加密，如一个属性为agentID=1，
*     若对1加密后为k230101io934jksd32r4，说明如下：
*     前三位为随机数；
*     第四到第五位为要加密字符转换成16进制的位数，
*       如：要加密字符为15转换成16进制为f，位数为1，则第四、五位为01；
*     第六位标识要加密字符为何种字符，0：纯数字，1：字符
*       若是字符和数字的混合，则不加密；
*     从第七位开始为16进制转换后的字符（字母和非数字先转换成asc码）；
*     若加密后的字符总位数不足20位，则用随机数补齐到20位，若超出20位，则不加随机数。
*     即加密后总位数至少为20位。
*/
        function encode16(str) {
            str = str.toLowerCase();
            if (str.match(/^[-+]?\d*$/) == null) {//非整数字符，对每一个字符都转换成16进制，然后拼接
                var s = str.split("");
                var temp = "";
                for (var i = 0; i < s.length; i++) {
                    s[i] = s[i].charCodeAt();//先转换成Unicode编码
                    s[i] = s[i].toString(16);
                    temp = temp + s[i];
                }
                return temp + "{" + 1;//1代表字符
            } else {//数字直接转换成16进制
                str = parseInt(str).toString(16);
            }
            return str + "{" + 0;//0代表纯数字
        }


        function produceRandom(n) {
            var num = "";
            for (var i = 0; i < n; i++) {
                num += Math.floor(Math.random() * 10);
            }
            return num;
        }

        //主加密函数
        function encrypt(str) {
            var encryptStr = "";//最终返回的加密后的字符串
            encryptStr += produceRandom(3);//产生3位随机数

            var temp = encode16(str).split("{");//对要加密的字符转换成16进制
            var numLength = temp[0].length;//转换后的字符长度
            numLength = numLength.toString(16);//字符长度换算成16进制
            if (numLength.length == 1) {//如果是1，补一个0
                numLength = "0" + numLength;
            } else if (numLength.length > 2) {//转换后的16进制字符长度如果大于2位数，则返回，不支持
                return "";
            }
            encryptStr += numLength;

            if (temp[1] == "0") {
                encryptStr += 0;
            } else if (temp[1] == "1") {
                encryptStr += 1;
            }

            encryptStr += temp[0];

            if (encryptStr.length < 20) {//如果小于20位，补上随机数
                var ran = produceRandom(20 - encryptStr.length);
                encryptStr += ran;
            }
            return encryptStr;
        }
    </script>
</body>
</html>
