<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bottom.aspx.cs" Inherits="SMSWeb.Portal.bottom" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <link href="/PortalCss/reset.css" rel="stylesheet" />
    <style>
        .width {
            width: 1024px;
            margin: 0 auto;
        }
        /*footer*/
        .footer {
            width: 100%;
            height: 175px;
            background: #595959;
        }

        .foot_left {
            padding-top: 50px;
        }

            .foot_left p {
                font-size: 12px;
                color: #fff;
                line-height: 25px;
            }

                .foot_left p a {
                    font-size: 14px;
                    color: #fff;
                }

        .erweima {
            width: 130px;
            height: 130px;
            display: block;
            margin-top: 22px;
        }

        .fot_con {
            margin-top: 22px;
            width: 160px;
            margin-left: 10px;
        }

            .fot_con .mes {
                font-size: 14px;
                color: #fff;
                line-height: 30px;
            }

        .share {
            margin-left: -8px;
            margin-top: 15px;
        }

            .share a {
                float: left;
                margin-left: 8px;
            }

        .share_a {
            display: block;
            width: 34px;
            height: 34px;
            background: url(/PortalImages/sprite.png) no-repeat;
        }

        .share_weibo {
            background-position: -32px -30px;
        }

        .share_weixin {
            background-position: -74px -30px;
        }

        .share_qq {
            background-position: -116px -30px;
        }

        .share_sina {
            background-position: -158px -30px;
        }

        .share a p {
            font-size: 12px;
            text-align: center;
            color: #fff;
            line-height: 25px;
        }
    </style>
</head>
<body>
    <div class="footer">
        <div class="footer_con width">
            <div class="foot_left fl" id="footerAdmin">
                <p>地址：北京市海淀区中关村环保科技示范园内（海淀区北清路）</p>
                <p>传真：010-62463259 网址：<a href="#" onclick="javascript: SendUrl('http://www.bjybjx.cn','_blank')">http://www.bjybjx.cn</a></p>
                <p>电子邮件（E-MAIL）:yqybjxzb@sohu.com  网站设计/技术支持：圣邦天麒 <span style="margin-left: 20px;">网站在线人数：<i><a  href="javascript:window.parent.window.location.href='/Portal/UserOnLine.aspx'" target="_blank"><label id="PersonCount">0</label> </a> </i></span></p>
                <p>本站学生注册<i class="scount"></i>人 教师注册<i class="tcount"></i>人 共计<i class="totol"></i>人</p>
            </div>
            <div class="foot_right fr clearfix">
                <span class="erweima fl">
                    <img src="/PortalImages/erweima.png" alt="" />
                </span>
                <div class="fot_con fl">
                    <div class="mes">关注我校官方微信平台实时了解最新动态</div>
                    <div class="share">
                        <a href="javscript::">
                            <i class="share_a share_weibo"></i>
                            <p>微博</p>
                        </a>
                        <a href="javscript::">
                            <i class="share_a share_weixin"></i>
                            <p>微信</p>
                        </a>
                        <a href="javscript::">
                            <i class="share_a share_qq"></i>
                            <p>QQ</p>
                        </a>
                        <a href="javscript::">
                            <i class="share_a share_sina"></i>
                            <p>新浪</p>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            if ($.cookie('LoginCookie_Cube') != null && $.cookie('LoginCookie_Cube') != "null" && $.cookie('LoginCookie_Cube') != "") {
                var info = $.parseJSON($.cookie('LoginCookie_Cube'));
            }
            refreshOnLine();
            statiscsRegist();
            //setTimeout(refreshOnLine, 300000);
            setTimeout(refreshOnLine, 180000);
        })
        function ResponstUrl() {
            window.parent.window.location.href = "/Portal/Admin/Index.aspx";
        }
        function SendUrl(url) {
            window.parent.window.location.href = url;
        }

        function statiscsRegist()
        {
            $.ajax({
                url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "Func": "RegisterCount" },
                success: function (json) {
                    var items = json.result.retData;
                    if (items!=null && items.length>0) {
                        var scount = items[0].StudentRegisterCount;
                        var tcount = items[0].TeacherRegisterCount;
                        $(".scount").html(scount);
                        $(".tcount").html(tcount);
                        var totol = parseInt(scount) + parseInt(tcount);
                        $(".totol").html(totol);
                    }
                }
            })
        }

        function refreshOnLine() {
            var ic = "";
            var UserName = "-1";
            var cookie = {};
            var Photo = "/PortalImages/defaultteacher.jpg";
            if ($.cookie('MONITORID_ONLINE') == 'undefined' || $.cookie('MONITORID_ONLINE') == null || $.cookie('MONITORID_ONLINE') == "") {
                ic = NewGuid().ToString("N");
                $.cookie('MONITORID_ONLINE', ic);
            }
            if (ic && ic.length == 32) {
                ic = ic.substr(0, 30);
            }
            else {
                ic = $.cookie('MONITORID_ONLINE').substr(0, 30);
            }
            if ($.cookie('LoginCookie_Cube') != null && $.cookie('LoginCookie_Cube') != "null" && $.cookie('LoginCookie_Cube') != "") {
                var info = $.parseJSON($.cookie('LoginCookie_Cube'));
                if (info != null) {
                    UserName = info.Name;
                    Photo = info.PhotoURL;
                }
            }
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/MonitorRecordHandler.ashx",
                    Func: "UpdateUserOnLine",
                    UserName: UserName,
                    icookie: ic,
                    Photo: Photo
                },
                success: function (json) {
                    onlineCount();
                },
                error: function (errMsg) {

                }
            });
        }

        function onlineCount()
        {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/MonitorRecordHandler.ashx",
                    Func: "GetUserOnLineList"
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var dtJson = json.result.retData;
                        if (dtJson != null) {
                            $("#PersonCount").html(dtJson.length);
                        }
                    } else {
                       
                    }
                },
                error: function (errMsg) {

                }
            });
        }

        function NewGuid() {
            var g = "";
            var i = 32;
            while (i--) {
                g += Math.floor(Math.random() * 16.0).toString(16);
            }
            return new Guid(g);
        }
        function Guid(g) {
            var arr = new Array();    // 存放32位数值的数组
            if (typeof (g) == "string") {    // 如果构造函数的参数为字符串
                InitByString(arr, g);
            }
            else {
                InitByOther(arr);
            }
            // 返回一个值，该值指示 Guid 的两个实例是否表示同一个值。
            this.Equals = function (o) {
                if (o && o.IsGuid) {
                    return this.ToString() == o.ToString();
                }
                else {
                    return false;
                }
            };
            // Guid对象的标记
            this.IsGuid = function () { };
            // 返回 Guid 类的此实例值的 String 表示形式。
            this.ToString = function (format) {
                if (typeof (format) == "string") {
                    if (format == "N" || format == "D" || format == "B" || format == "P") {
                        return ToStringWithFormat(arr, format);
                    }
                    else {
                        return ToStringWithFormat(arr, "D");
                    }
                }
                else {
                    return ToStringWithFormat(arr, "D");
                }
            };
            // 由字符串加载
            function InitByString(arr, g) {
                g = g.replace(/\{|\(|\)|\}|-/g, "");
                g = g.toLowerCase();
                if (g.length != 32 || g.search(/[^0-9,a-f]/i) != -1) {
                    InitByOther(arr);
                }
                else {
                    for (var i = 0; i < g.length; i++) {
                        arr.push(g.charAt(i));
                    }
                }
            }
            // 由其他类型加载
            function InitByOther(arr) {
                var i = 32;
                while (i--) {
                    arr.push("0");
                }
            }
            /*
            根据所提供的格式说明符，返回此 Guid 实例值的 String 表示形式。
            N  32 位： xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            D  由连字符分隔的 32 位数字 xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
            B  括在大括号中、由连字符分隔的 32 位数字：{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
            P  括在圆括号中、由连字符分隔的 32 位数字：(xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
            */
            function ToStringWithFormat(arr, format) {
                switch (format) {
                    case "N":
                        return arr.toString().replace(/,/g, "");
                    case "D":
                        var str = arr.slice(0, 8) + "-" + arr.slice(8, 12) + "-" + arr.slice(12, 16) + "-" + arr.slice(16, 20) + "-" + arr.slice(20, 32);
                        str = str.replace(/,/g, "");
                        return str;
                    case "B":
                        var str = ToStringWithFormat(arr, "D");
                        str = "{" + str + "}";
                        return str;
                    case "P":
                        var str = ToStringWithFormat(arr, "D");
                        str = "(" + str + ")";
                        return str;
                    default:
                        return new Guid();
                }
            }
        };
    </script>
</body>
</html>
