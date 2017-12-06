<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forgetPwd.aspx.cs" Inherits="SMSWeb.forgetPwd" %>

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
        .forget_wrap{background: #fff;}
        .retrievepwd-progress{    width: 600px;
            margin: 0 auto;
            padding: 58px 0 30px;}
        .retrievepwd-progress .progress-pwd-out {
            background: url(images/steppwd.png) no-repeat 0 0;
            width: 600px;
            height: 30px;
        }
        .retrievepwd-progress .way li.current {
            color: #0b70c0;
        }
        .retrievepwd-progress .way li {
            float: left;
            font-size:16px;
            padding-top: 13px;
            width: 180px;
            text-align: right;
        }
        .retrievepwd-progress .way li.p1 {
            width:140px;
        }
        .retrievepwd-progress .way li.p2 {
            width:120px;
        }
        .retrievepwd-cont {
            width: 600px;
            margin: 0 auto;
        }
        .retrievepwd-cont .register-process-list {
            padding-top: 20px;
            width: 600px;
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
        .retrievepwd-cont .register-process-list li{margin-top: 10px;}
        .step-content-one-select{width:210px;border-radius:2px;height:32px;border:1px solid #ccc;}
        .left{padding-left:180px;}
        .getvcode{margin-top:10px;}
        .retrievepwd-cont .a-link {
            color: #1970b4;
            text-decoration: underline;
        }
        .ui-inp{width:210px;height:28px;border-radius:2px;border:1px solid #ccc;}
        .btn-public-38 {
            display: block;
            margin:0 auto;
            font-size: 14px;
            height: 38px;
            width:100px;
            background: #0b70c0;
            color: #fff;
            border-radius:2px;
            line-height: 38px;
            text-align:center;
            margin-top: 30px;
            border:none;
        }
        .label1{display: inline;
            height: 21px;
            float: left;
            margin-top: 10px;
            text-align: right;
            margin-right: 3px;
            font-size: 14px;}
        #email,#phone{float:left;margin-top:10px;}
    </style>
    <script src="Scripts/jquery-1.11.2.min.js"></script>
    <script src="Scripts/Common.js"></script>
    <script src="Scripts/layer/layer.js"></script>
   
</head>
<body>
    <form id="form1" runat="server">
        <!--header-->
        <header class="repository_header_wrap">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="/Portal/index.aspx">
                    <img src="PortalImages/logoBefore.png" style="margin-top: 5px;" />

                </a>
                
            </div>
        </header>
        <div class="forget_wrap width" style="min-height:572px;margin-top:200px;">
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
                    <li class="clearfix">
                        <label class="label">身份证号：</label>
                        <div class="left">
                            <div class="clearfix">
                                <input id="IDCard" maxlength="50" name="validate" class="ui-inp" type="text" />
                            </div>
                        </div>
                    </li>
                    <li class="clearfix">
                        <label class="label">选择方式：</label>
                        <div class="left">
                            <div class="clearfix">
                                <input type="radio" name="senFunc" id="email" value="0"  checked/>
                                <label for="email" class="label1">邮箱</label>
                                <input type="radio" name="senFunc" id="phone" value="1" />
                                <label for="phone" class="label1">手机号</label>
                            </div>
                        </div>
                    </li>
                    <li class="clearfix">
                        <label class="label">验证码：</label>
                        <div class="left">
                            <div class="clearfix">
                                <input id="input-vcode" maxlength="6" name="validate" class="ui-inp fl" type="text" /> 
                                <div class="getvcode fl ml10">
                                    <a id="a-getvcode" href="javascript:void(0);" class="a-link">获取验证码</a>
                                </div>
                                <div class="getvcode fl ml10" >
                                    <a  class="a-link1 none" id="asecond">60秒</a>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
                <%--<a href="javascript:void(0);" id="next-vcode-btn" class="btn-public-38 next-btn">
					下一步
                </a>--%>
                <input type="button" value="下一步" class="btn-public-38 next-btn"  id="btnNext"/>
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
                    <p>传真：010-62463259   网址：<a href="" style="color: #fff;">http://www.bjybjx.cn</a></p>
                    <p>电子邮件（E-MAIL）:yqybjxzb@sohu.com </p>
                </div>
            </div>
        </footer>
    </form>
    <script type="text/javascript">
        var nums = 60;
        var codeNumber;
        var isload = false;
        var email = "";
        var phone = "";
        var sf = "";
        var loginName = "";
        $(function () {
            $(".a-link").on("click", function () {
                if (!isload) {
                    isload = true;
                    queryEmail();
                } else {
                    valiCode();
                }
                
            })
            $("#btnNext").on("click", function () {
                if ($("#IDCard").val().length==0) {
                    layer.msg("请输入身份证号！");
                    return false;
                }
                var code = $("#input-vcode").val();

                if (codeNumber == code && codeNumber!="-1") {
                    window.location.href = "rePassword.aspx?user=" + $("#IDCard").val() + "&sf=" + sf + "&loginName=" + loginName;
                } else {
                    layer.msg("请输入正确验证码！");
                }
            })
        })

        function valiCode()
        {
            $(".a-link1").show();
            $(".a-link").hide();
            sendMsg();
            clock = setInterval(doLoop, 1000); //一秒执行一次
        }

        function doLoop() {
            nums--;
            if (nums > 0) {
                $("#asecond").html(nums + '秒后可重新获取');
            } else {
                $(".a-link1").hide();
                $(".a-link").show();
                clearInterval(clock); //清除js定时器
                $("#asecond").html('点击发送验证码');
                nums = 60; //重置时间
                codeNumber = -1;
            }
        }

        function queryEmail()
        {
            $.ajax({
                url: "/SystemSettings/CommonInfo.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    IDCard: $("#IDCard").val(),
                    Func: "GetUserInfoByIDCard"
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var items = json.result.retData;
                        if (items != null && items.length > 0) {
                            email = items[0].Email;
                            phone = items[0].Phone;
                            loginName = items[0].LoginName;
                            var role = items[0].SF;
                            if (role == "教师") {
                                sf = "Teacher";
                            } else if (role=="学生") {
                                sf = "Student";
                            } else {
                                sf = "Student";
                            }
                            var valid = $("input:radio[name='senFunc']:checked").val();
                            if (valid == "0" && (email == "" || email == null)) {
                                layer.msg("系统检测：您注册时未填写邮箱，请重新验证！");
                                return false;
                            } else if (valid == "1" && (phone == "" || phone == null)) {
                                layer.msg("系统检测：您注册时未填写手机，请重新验证！");
                                return false;
                            } else {
                                valiCode();
                            }
                        }
                    }
                    else {
                        layer.msg("身份证号未注册或用户没有邮箱！");
                    }
                },
                error: OnError
            });
        }

        function sendMsg()
        {
            var valid = $("input:radio[name='senFunc']:checked").val();
            codeNumber = RndNum(4);
            if (valid=="0") {
                
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        PageName: "PortalManage/MessageHandler.ashx",
                        Func: "AdminSendMessage",
                        Title: "找回密码",
                        Contents: "验证码：" + codeNumber,
                        Email: email,
                        Phone: phone
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            //layer.msg("发送成功！");
                        }
                        else { }
                    },
                    error: function (errMsg) { }
                });
            } else if (valid == "1") {
                var date=getNowFormatDate();
                $.ajax({
                    url: "/phone.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        accountSid: "8a7e58f2cc064f639e1e3302a0f7f2f6",
                        smsContent: "【修改密码】您注册远程教学平台网站的验证码为" + codeNumber + "，请于1分钟内正确输入验证码。",
                        to: phone,
                        timestamp: date,
                        respDataType:"JSON",
                        sig: "8a7e58f2cc064f639e1e3302a0f7f2f6" + "d00361afaa7149c5b21fb61527f33f41" + date
                    },
                    success: function (json) {
                        if (json.respCode == "00000") {
                            //layer.msg("发送成功！");
                            //{"respCode":"00000","failCount":"0","failList":[],"smsId":"c04001e86c9e4e7da7f0ceba3bd9894e"}
                        }
                        else {
                            layer.msg("发送失败，错误代码：" + json.respCode);
                        }
                    },
                    error: function (errMsg) { }
                });
            }
        }

        function getNowFormatDate() {
            var date = new Date();
            var seperator1 = "";
            var seperator2 = "";
            var month = date.getMonth() + 1;
            var strDate = date.getDate();
            var hours = date.getHours();
            var min = date.getMinutes();
            var mm = date.getSeconds();
            if (month >= 1 && month <= 9) {
                month = "0" + month;
            }
            if (strDate >= 0 && strDate <= 9) {
                strDate = "0" + strDate;
            }
            if (hours >= 0 && hours <= 9) {
                hours = "0" + hours;
            }
            if (min >= 0 && min <= 9) {
                min = "0" + min;
            }
            if (mm >= 0 && mm <= 9) {
                mm = "0" + mm;
            }
            var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
                    + hours + seperator2 + min
                    + seperator2 + mm;
            return currentdate;
        }

        function RndNum(n){
            var rnd="";
            for(var i=0;i<n;i++)
                rnd+=Math.floor(Math.random()*10);
            return rnd;
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
