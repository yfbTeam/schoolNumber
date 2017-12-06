<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Online_Answer.aspx.cs" Inherits="SMSWeb.analysisa.Online_Answer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>在线答疑</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css"/>
    <link rel="stylesheet" type="text/css" href="/css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="/css/repository.css"/>
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css"/>
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <!--[if IE]>
    <script src="/js/html5.js"></script> 
    <![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <%--<script>
        $(function () {
            $('.online_answera').load('http://192.168.1.101:9010/index.aspx')
        })
    </script>--%>
   
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <!--header-->
<header class="repository_header_wrap manage_header">
    <div class="width repository_header clearfix">
        <a href="/HZ_Index.aspx" class="logo fl"><img src="/images/logo.png" /></a>
        <nav class="navbar menu_mid fl">
            <ul>
                <li currentclass="active"><a href="/PersonalSpace/Learning_center_portal.aspx">学习中心门户</a></li>
                <li currentclass="active"><a href="/OnlineLearning/MyLessons.aspx">在线学习</a></li>
                <li currentclass="active"><a href="/CourseManage/Cource_OnlineChose.aspx">在线选课</a></li>
                <li currentclass="active"><a href="/OnlineLearning/MyExam.aspx">在线考试</a></li>
                <li currentclass="active"><a href="/Recommended/RecommendedStu.aspx">推荐就业</a></li>
                <li currentclass="active"><a href="/OnlineLearning/Innovation.aspx">教学互动</a></li>
                <li currentclass="active" class="active"><a href="/analysisa/student_studyprocess(4).aspx">个人学习进度</a></li>
            </ul>
        </nav>
        <div class="search_account fr clearfix">
            <ul class="account_area fl">
                <li>
                    <a href="javascript:;" class="dropdown-toggle">
                        <i class="icon icon-envelope"></i>
                        <span class="badge">3</span>
                    </a>
                </li>
                <li>
                    <a href="javascript:;" class="login_area clearfix">
                        <div class="avatar">
                                <img src="<%=PhotoURL %>" />
                            </div>
                            <h2><%=Name %>
                            </h2>
                    </a>
                </li>
            </ul> 
            <div class="settings fl pr">
                <a href="javascript:;">
                    <i class="icon icon-cog"></i>
                </a>
                <div class="setting_none">
                    <a href="/Gopay/Gopay.aspx" target="_blank"><span>账户管理</span></a>
                    <a href="/PersonalSpace/PersonalSpace_Student.aspx"><span>个人中心</span></a>
                    <span onclick="logOut()">退出</span>
                </div>
            </div>
        </div>
    </div>
</header>
        <div class="onlinetest_item width pt90 pr ">
            <div class="bordshadrad " style="background: #fff;padding:10px 20px;">
                <div class="stytem_select clearfix">
                    <div class="stytem_select_left fl">
                        <a href="student_studyprocess(4).aspx" >课时跟踪</a>
                        <a href="student_knowledgemastery(2).aspx">掌握程度</a>
                        <a href="Knowledge_track.aspx">知识点跟踪</a>
                        <a href="javascript:;" onclick="ChangeSrc('http://192.168.1.101:8072/InterfaceUser.aspx',this,'passport')" class="on">在线答疑</a>
                    </div>
                 </div>
                <div class="online_answera">
                    <iframe id="iframeContent"  src="http://192.168.1.101:9010/index.aspx" style="width:100%; height:1200px;"></iframe>
                </div>
            </div>
        </div>
         <footer>
                <div class="footer width clearfix">
                    <div class="logo fl">
                        <img src="/PortalImages/logoBefore.png" alt="" style="margin-top: 10px;" />
                    </div>
                    <div class="footer_right fr">
                        <p>地址：北京市海淀区中关村环保科技示范园内（海淀区北清路）</p>
                        <p>
                            传真：010-62463259   网址：<a href="http://www.bjybjx.cn" target="_blank" style="color: #fff;">http://www.bjybjx.cn</a>
                        </p>
                        <p>电子邮件（E-MAIL）:yqybjxzb@sohu.com </p>
                    </div>
                </div>
            </footer>
        <script src="/js/common.js"></script>
    </div>
    </form>
    <script type="text/javascript">
        function ChangeSrc(src, em, pass) {
            $(em).parent().addClass('active').siblings().removeClass("active");
            var param = "";
            if (pass != null) {
                var info = $.parseJSON($.cookie('LoginCookie_Cube'));
                var user = encrypt(info.LoginName);
                var pwd = encrypt($.cookie("PwdCookie_Cube"));
                param = "?user=" + user + "&pwd=" + pwd;
            }
            $("#iframeContent").attr("src", src + param);
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
