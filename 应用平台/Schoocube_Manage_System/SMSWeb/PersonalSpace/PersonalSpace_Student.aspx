<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonalSpace_Student.aspx.cs" Inherits="SMSWeb.PersonalSpace.PersonalSpace_Student" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>个人中心</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <!--证书-->
    <link rel="stylesheet" href="/css/certificate.css">
    <link rel="stylesheet" href="/css/certificateT.css">
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <link href="/Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <%--<script src="/Scripts/jquery-1.11.2.min.js"></script>--%>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="/js/jquery.jqprint.js"></script>
    <script src="/js/jquery-migrate-1.1.0.js"></script>
    <script type="text/javascript" src="http://html2canvas.hertzen.com/build/html2canvas.js"></script>
    <script src="/CourseManage/Term.js"></script>
    <script src="/js/common.js"></script>
    <style type="text/css">
        .btncss {
            float: right;
            background: rgb(150, 191, 226);
            border-radius: 2px;
            border: 1px solid rgb(207, 216, 223);
            border-image: none;
            width: 81px;
            height: 26px;
            text-align: center;
            color: white;
            line-height: 28px;
            font-size: 12px;
            display: inline-block;
        }

        .edit_password {
            border-bottom: 2px solid #1776BD;
            overflow: hidden;
            text-align: center;
        }

            .edit_password span {
                width: 80px;
                height: 28px;
                line-height: 28px;
                cursor: pointer;
                background: #E7F1F8;
                margin-right: 10px;
                display: block;
                float: left;
                color: #666;
                font-size: 14px;
                text-align: center;
            }

                .edit_password span.on {
                    background: #1776BD;
                    color: #fff;
                }
    </style>
    <script type="text/javascript">
        $(function () {
            GetTerm();
            BindStuInfo();

        })
        function UpEmail(id) {
            OpenIFrameWindow('修改邮箱', 'EmailConrim.aspx?ID=' + id + "&IDCard=" + $("#HUserIdCard").val() + "&Name=" + $("#HUserName").val(), '350px', '180px');

        }
        function UpPhone(id) {
            OpenIFrameWindow('修改手机号', 'PhoneConrim.aspx?ID=' + id + "&IDCard=" + $("#HUserIdCard").val() + "&Name=" + $("#HUserName").val(), '350px', '180px');
        }
        // 学生详细信息
        function BindStuInfo() {

            $.ajax({
                url: "/SystemSettings/UserInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: true,
                dataType: "json",
                data: {
                    Func: "StudentInfo",
                    IDCard: $("#HUserIdCard").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var data = json.result.retData;
                        $("#SchoolName").html(data[0].SchoolName);
                        $("#SchoolName1").html(data[0].SchoolName);
                        $("#ClassName").html(data[0].ClassName);
                        $("#ClassName1").html(data[0].ClassName);
                        $("#GradeName").html(data[0].GradeName);
                        $("#accounts_txt").val(data[0].Name);
                        $("#StuSex").val(data[0].Sex);
                        //$("input[name='sex'][value=" + data[0].Sex + "]").attr("checked", true);
                        $("#Birthday").val(DateTimeConvert(data[0].Birthday, 'yyyy-MM-dd'));
                        $("#fixPhone").val(data[0].fixPhone);
                        $('#email_wrap').html('<span style="color:black;" id="Email"></span><a href="javascript:;" style="color:red;margin-left:10px;" onclick="UpEmail(' + data[0].Id + ')">修改>></a>')
                        $("#Email").html(data[0].Email);
                        $('#phone_wrap').html('<span style="color:black;" id="Phone"></span><a href="javascript:;" style="color:red;margin-left:10px;" onclick="UpPhone(' + data[0].Id + ')">修改>></a>')
                        $("#Phone").html(data[0].Phone);
                        $("#Address").val(data[0].Address);
                        $("#HUserId").val(data[0].Id)
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        function EditStu() {

            var Name = $("#accounts_txt").val();
            var Sex = $("#StuSex").val();
            var Birthday = $("#Birthday").val();
            var fixPhone = $("#fixPhone").val();
            var Email = $("#Email").val();
            var Address = $("#Address").val();
            var LoginName = $("#LoginName1").val();
            $.ajax({
                url: "/SystemSettings/UserInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: true,
                dataType: "json",
                data: {
                    Func: "UpdateStudent", ID: $("#HUserId").val(), Name: Name, Sex: Sex,
                    Birthday: Birthday, fixPhone: fixPhone, Email: Email, Address: Address, LoginName: LoginName
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("修改成功");
                        if (LoginName != $("#LoginName").val()) {
                            logOut();
                        }
                        else {
                            BindStuInfo();
                        }
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }


        //$('#edit_phone').click(function () {
        //    edit();
        //    BindStuInfo();
        //})
    </script>
    <script id="li_mylessons" type="text/x-jquery-tmpl">
        <li>
            <div class="allcourse_img">
                <img src="${ImageUrl}" alt="" />
            </div>
            <div class="course_type course_bixiu">
                {{if CourceType==1}}<span>必修课</span>{{else}}<span>选修课</span>{{/if}}
            </div>
            <div class="couese_title">
                ${Name}
            </div>
            <p class="course_name"><span>${LecturerName}</span></p>
        </li>

    </script>
    <script id="trTran" type="text/x-jquery-tmpl">
        <tr>
            <td>${GroupName}</td>
            <td>${TrainName}</td>
            <td>${DateTimeConvert(BeginTime, 'yyyy-MM-dd')}</td>
            <td>${DateTimeConvert(EndTime, 'yyyy-MM-dd')}</td>
            <td>${ClassHour}</td>
            <td>${TrainMan}</td>
            <td>￥${TrainFee}</td>
            <td>${TrainResult}</td>
            <td>
                <a style="cursor: pointer;" onclick="javascript:OpenIFrameWindow('查看考试档案', 'TrainExam.aspx?trainID=${ID}', '600px', '410px')">考试</a>
                <a style="cursor: pointer;" onclick="javascript:OpenIFrameWindow('查看课程档案', 'TrainCouse.aspx?trainID=${ID}', '600px', '410px')">课程</a>
            </td>
        </tr>

    </script>
    <script id="li_Modol" type="text/x-jquery-tmpl">
        <li class="cert_li">
            <div class="cert_imgs">
                <img style="cursor: pointer" onclick="bzCertificateGet(this)" src="${ImageUrl}" width="95">
                <i class="selected"></i>
            </div>
            <div class="cert_name">${Name}</div>
        </li>
    </script>
    <script id="tr_Certificate" type="text/x-jquery-tmpl">
        <tr>
            <td>${Identifier}</td>
            <td>${cName}</td>
            <td>${IssuingUnit}</td>
            <td>${DateTimeConvert(CompleteTime, 'yyyy-MM-dd')}</td>
            <td>${IssuedWebSite}</td>
            <td>{{if Status==1}}<span>审核通过</span>{{else}}<span>待审核</span>{{/if}}
            </td>
            <td>{{if Status==1}}<a onclick="ShowCertificate(${ID})">预览</a>{{/if}}</td>
        </tr>
    </script>
    <%-- <script type="text/x-jquery-tmpl" id="li_Message">
        <li><a href="javascript:;" title="${Contents}">${cutstr(Contents,20)}</a></li>

    </script>--%>
    <script type="text/x-jquery-tmpl" id="tr_CertImg">
        <li><a onclick="ShowCertificate(${ID})">{{if Attachment==""}}<img src="/Attatchment/Certificates/默认证书.png">
            {{else}}<img src="${Attachment}">
            {{/if}}
        </a></li>
    </script>

    <script id="tr_Favorite" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>${Name}</td>
            <td>{{if Type==0}}课程展示
                     {{else Type==1}}课程详细
                     {{else}}暂无
                     {{/if}}
            </td>
            <td>${CreateTime}</td>
            <td><a href="javascript:;" onclick="javascript:delFavorites('${ID}')"><i class="icon icon-edit"></i>删除</a>
                <a href="javascript:;" onclick="javascript:window.location='${Href}'" target="_blank"><i class="icon icon-edit"></i>查看</a>
            </td>

        </tr>
    </script>
</head>
<body>

    <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />
    <input type="hidden" id="Hid_ClassID" value="<%=ClassID %>" />
    <input type="hidden" id="HStuName" value="<%=Name %>" />
    <input type="hidden" id="PhotoName" value="<%=PhotoName %>" />
    <input type="hidden" id="HUserId" />
    <input type="hidden" id="LoginName" value="<%=LoginName %>" />
    <input type="hidden" id="HUserName" value="<%=Name %>" />


    <!--header-->
    <header class="repository_header_wrap">
        <div class="width repository_header clearfix">
            <a class="logo fl" href="/HZ_Index.aspx">
                <img src="/images/logo.png" /></a>
            <div class="wenzi_tips fl">
                <img src="/images/gerenzhongxin.png" />
            </div>
            <div class="search_account fr clearfix">
                <ul class="account_area fl">
                    <li>
                        <a href="" class="dropdown-toggle">
                            <i class="icon icon-envelope"></i>
                            <span class="badge">3</span>
                        </a>
                    </li>
                    <li>
                        <a class="login_area clearfix">
                            <div class="avatar">
                                <img src="<%=PhotoURL %>" />
                            </div>
                            <h2><%=Name %></h2>
                        </a>
                    </li>
                </ul>
                <div class="settings fl pr">
                    <a href="">
                        <i class="icon icon-cog"></i>
                    </a>
                    <div class="setting_none">
                        <a href="/Gopay/Gopay.aspx" target="_blank"><span>账户管理</span></a>
                        <a href="/PersonalSpace/PersonalSpace_Student.aspx" target="_blank"><span>个人中心</span></a>
                        <span onclick="logOut()">退出</span>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!--个人空间-->
    <div class="personal_spacewrap">
        <div class="personal_spacea width pt20 clearfix" style="min-height: 790px;">
            <div class="space_left fl" style="min-height: 750px;">
                <div class="personal_img">
                    <img src="<%=PhotoURL %>" />
                </div>
                <div class="personal_a"></div>
                <div class="personal_btn clearfix">
                    <%--<a href="javascript:;" class="fl">更换头像</a>--%>

                    <div onclick="$('#uploadify').click();" style="border-radius: 2px; float: left; overflow: hidden; width: 83px; height: 28px; text-align: center; font-size: 12px; z-index: 2; cursor: pointer;" class="un_reposity">

                        <input name="uploadify" id="uploadify" style="display: none;" type="file" multiple="multiple">
                    </div>
                    <style>
                        .un_reposity .uploadify-button {
                            border: 1px solid #cfd8df;
                            background: #fff;
                            font-size: 12px;
                            color: #666666;
                            height: 30px;
                            border-radius: 2px;
                        }

                        .un_reposity .swfupload {
                            left: 0;
                            top: 0;
                        }
                    </style>
                    <a href="javascript:;" class="fr edit_mes">编辑资料</a>
                </div>
                <div class="personal_detail">
                    <p class="people"><i class="icon icon-user"></i><%=Name%></p>
                    <p class="school">所在学校：<span id="SchoolName1"></span></p>
                    <p class="class">所在班级：<span id="ClassName1"></span></p>
                </div>
                <ul class="personal_link">
                    <li class="active">
                        <a href="javascript:;">
                            <i class="icon icon_home"></i>
                            首页
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <i class="icon icon_mess"></i>
                            个人资料
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <i class="icon icon_dossier" style="background-position: 0px -145px;"></i>
                            个人档案
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <i class="icon icon_qualification" style="background-position: 0px -123px;"></i>
                            个人证书
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <i class="icon icon_train" style="width: 23px; background-position: 0px -102px;"></i>
                            培训档案
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <i class="icon icon_train" style="width: 23px; background-position: 0px -102px;"></i>
                            我的收藏
                        </a>
                    </li>
                    <%--<li>
                        <a href="javascript:;">
                            <i class="icon icon_train" style="width: 23px; background-position: 0px -102px;"></i>
                            安全设置
                        </a>
                    </li>--%>
                    <%--<li>
                        <a href="javascript:;">
                            <i class="icon icon_board"></i>
                            我的消息
                        </a>
                    </li>--%>
                </ul>
            </div>
            <div class="space_center fl">
                <div class="space_centerwrap">
                    <div class="stytem_select clearfix">
                        <div class="stytem_select_left fl">
                            <a href="javascript:;" class="on">已学课程</a>
                        </div>
                        <div class="stytem_select_right fr clearfix">
                            <select name="" id="StudyTerm" class="select" onchange="geCoursetData()">
                                <option value="">==请选择==</option>

                            </select>
                        </div>
                    </div>
                    <ul class="allcourses clearfix" id="ul_mylessons">
                    </ul>
                </div>
                <div class="space_centerwrap none">
                    <div class="edit_password">
                        <span class="on">个人资料</span>
                        <span>修改密码</span>
                    </div>
                    <%--<div class="mess_succprecess">
                        <span class="left fl">信息完整度： </span>
                        <div class="progressbar fl">
                            <span style="width: 20%"></span>
                        </div>
                        <span class="left mr15 ml5 fr" id="progressNum">20%</span>
                    </div>--%>
                    <div class="mess_wraps">
                        <div class="mess_wrap">
                            <h4 class="set-mold">学校信息</h4>
                            <table class="set-mold-table">
                                <tbody>
                                    <tr>
                                        <td class="w85">所在学校：</td>
                                        <td id="SchoolName"></td>
                                    </tr>
                                    <tr>
                                        <td class="w85">所在班级：</td>
                                        <td>
                                            <div class="class-list">
                                                <p id="ClassName"></p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="w85">所在年级：</td>
                                        <td id="GradeName"></td>
                                    </tr>
                                </tbody>
                            </table>
                            <h4 class="set-mold">基本信息</h4>
                            <form id="myform">
                                <table class="set-mold-table">
                                    <tbody>
                                        <tr>
                                            <td class="w85">学生姓名：</td>
                                            <td>
                                                <input type="text" name="accounts_txt" id="accounts_txt" class="input">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="w85">用户名：</td>
                                            <td>
                                                <input type="text" name="accounts_txt" id="LoginName1" class="input" value="<%=LoginName %>">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="w85 fl">学生性别：</td>
                                            <td>
                                                <select name="sex" class="select" id="StuSex">
                                                    <option value="0">男</option>
                                                    <option value="1">女 </option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="w85">出生日期：</td>
                                            <td>
                                                <input type="text" name="birthday" id="Birthday" value="" title="生日" class="input" onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd' })">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="w85">固定电话：</td>
                                            <td>
                                                <input type="text" class="input" value="" id="fixPhone">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="w85">邮箱账号:</td>
                                            <td>
                                                <span id="email_wrap" style="color: red; cursor: pointer;">绑定邮箱号</span>
                                                <%--<input type="text" class="input" value="" id="Email">--%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="w85">手机号:</td>
                                            <td>
                                                <span id="phone_wrap" style="color: red; cursor: pointer;">绑定手机号</span>
                                                <%-- <input type="text" class="input" value="" id="Phone">--%>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td class="w85 fl">家庭住址：</td>
                                            <%--
                                            <td>
                                                <select name="" class="select">
                                                    <option value=""></option>
                                                </select>
                                                <select name="" class="select">
                                                    <option value=""></option>
                                                </select>
                                                <select name="" class="select">
                                                    <option value=""></option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>--%>
                                            <td>
                                                <textarea name="contact.address" class="w285" id="Address"></textarea>
                                                <%--<span class="ml5" id="nb60">(<span class="counter">0</span>/<span class="counter">60</span>)</span>--%>
                                                <%--<span class="addressname ml5">街道地址对其他人是保密的</span>--%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td><a href="javascript:void(0)" class="xiugai" onclick="EditStu()" style="float: left; width: 80px; margin-right: 4px;">确认修改</a>&nbsp;&nbsp;
                                                <a href="javascript:void(0)" class="xiugai" onclick="DrStu()" style="float: left; width: 60px; margin-right: 4px;">导入</a>
                                                &nbsp;&nbsp;
                                                <a href="javascript:void(0)" class="xiugai" onclick="DcStu()" style="float: left; width: 60px; margin-right: 4px;">导出</a>
                                            </td>
                                        </tr>

                                    </tbody>
                                </table>
                            </form>
                            <%--<h4 class="set-mold">个人信息</h4>--%>
                            <%--<ul class="personal-list pt10 pb10">
                            <li class="clearfix">
                                <p class="peronal-title">我的座右铭：</p>
                                <div class="peronal-cont">
                                    <input class="" name="personal.motto" value="" type="text">
                                    <span class=""></span>
                                </div>
                            </li>
                            <li class="clearfix">
                                <p class="peronal-title">我喜欢的书籍：</p>
                                <div class="peronal-cont">
                                    <input class="" name="personal.motto" value="" type="text">
                                    <span class=""></span>
                                </div>
                            </li>
                            <li class="clearfix">
                                <p class="peronal-title">我喜欢的游戏：</p>
                                <div class="peronal-cont">
                                    <input class="" name="personal.motto" value="" type="text">
                                    <span class=""></span>
                                </div>
                            </li>
                            <li class="clearfix">
                                <p class="peronal-title">我喜欢的动漫：</p>
                                <div class="peronal-cont">
                                    <input class="" name="personal.motto" value="" type="text">
                                    <span class=""></span>
                                </div>
                            </li>
                            <li class="clearfix">
                                <p class="peronal-title">我喜欢的运动：</p>
                                <div class="peronal-cont">
                                    <input class="" name="personal.motto" value="" type="text">
                                    <span class=""></span>
                                </div>
                            </li>
                            <li class="clearfix">
                                <p class="peronal-title">我最近的愿望：</p>
                                <div class="peronal-cont">
                                    <input class="" name="personal.motto" value="" type="text">
                                    <span class=""></span>
                                </div>
                            </li>
                            <li class="clearfix">
                                <input type="button" value="确定" />
                            </li>
                        </ul>--%>
                        </div>
                        <div class="mess_wrap none">
                            <h4 class="set-mold">修改密码</h4>
                            <table class="set-mold-table">
                                <tbody>
                                    <tr>
                                        <td class="w85">学生账号：</td>
                                        <td><%=LoginName %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="w85">旧密码：</td>
                                        <td>
                                            <input type="text" name="OldPassword" id="OldPassword" class="input">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="w85">新密码：</td>
                                        <td>
                                            <input type="text" name="NewPassword" id="NewPassword" class="input">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="w85">再次输入：</td>
                                        <td>
                                            <input type="text" name="NewPassword1" id="NewPassword1" class="input">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><a href="javascript:void(0)" class="xiugai" onclick="UpdatePwd()">提交</a></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="space_centerwrap  none">
                    <div class="hr_messbtn clearfix fr">
                        <input type="button" class="btn fl" onclick="EditMyDoc()" value="确定">
                        <input type="button" class="btn fl" id="print" value="打印">
                        <input type="button" class="btn fl" onclick="ExportMyDoc()" value="导出">
                    </div>
                    <div class="hr_messwrap clearfix">
                        <div class="title">个人档案表</div>
                        <div class="number">
                            <div class="fl number1">
                                档案编号：<span id="DocumentID">002</span><input type="hidden" id="MyDocID" />
                            </div>
                            <%--<div class="fr number2">
                                打印时间：<span>2016/7/6 14:18</span>
                            </div>--%>
                        </div>

                        <table class="hr_mess">
                            <tbody>
                                <tr>
                                    <td>
                                        <span>姓　名</span>
                                    </td>
                                    <td>
                                        <span id="Name"></span>
                                    </td>
                                    <td>
                                        <span>性　别</span>
                                    </td>
                                    <td>
                                        <span>
                                            <input type="text" id="Sex"></span>
                                    </td>
                                    <td>
                                        <span>民　族</span>
                                    </td>
                                    <td>
                                        <span>
                                            <input type="text" id="Nation"></span>
                                    </td>
                                    <td rowspan="5" colspan="2" style="vertical-align: middle; width: 158px;" class="imgbsa">
                                        <span>
                                            <img id="Photo"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span>身份证号</span>
                                    </td>
                                    <td colspan="3">
                                        <span id="IDCart"></span>
                                    </td>
                                    <td>
                                        <span>籍　贯</span>
                                    </td>
                                    <td>
                                        <span>
                                            <input type="text" id="Origion"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span>出生日期</span>
                                    </td>
                                    <td colspan="2">
                                        <span>
                                            <input type="text" id="BirsDay" style="width: 135px;"></span>
                                    </td>
                                    <td>
                                        <span>婚姻状况</span>
                                    </td>
                                    <td colspan="2">
                                        <span>
                                            <input type="text" id="MaritalStatus" style="width: 165px;"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span>政治面貌</span>
                                    </td>
                                    <td colspan="2">
                                        <span>
                                            <input type="text" id="PoliticalStatus" style="width: 135px;"></span>
                                    </td>
                                    <td>
                                        <span>入党团日期</span>
                                    </td>
                                    <td colspan="2">
                                        <span>
                                            <input type="text" id="joinTime" style="width: 165px;"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span>文化程度</span>
                                    </td>
                                    <td colspan="2">
                                        <span>
                                            <input type="text" id="HalfEdudate" style="width: 135px;"></span>
                                    </td>
                                    <td>
                                        <span>所学专业</span>
                                    </td>
                                    <td colspan="2">
                                        <span>
                                            <input type="text" id="Major" style="width: 165px;"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span>单位性质</span>
                                    </td>
                                    <td>
                                        <span>
                                            <input type="text" id="CompnyType"></span>
                                    </td>
                                    <td>
                                        <span>人员身份</span>
                                    </td>
                                    <td>
                                        <span>
                                            <input type="text" id="PersonIdentity"></span>
                                    </td>
                                    <td>
                                        <span>现任职务</span>
                                    </td>
                                    <td>
                                        <span>
                                            <input type="text" id="CurrentJob"></span>
                                    </td>
                                    <td>
                                        <span>职务级别</span>
                                    </td>
                                    <td>
                                        <span>
                                            <input type="text" id="JobDegree"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span>参加工作时间</span>
                                    </td>
                                    <td>
                                        <span>
                                            <input type="text" id="JobTime"></span>
                                    </td>
                                    <td>
                                        <span>工龄</span>
                                    </td>
                                    <td>
                                        <span>
                                            <input type="text" id="JobYear"></span>
                                    </td>

                                    <td>
                                        <span>年龄</span>
                                    </td>
                                    <td>
                                        <span>
                                            <input type="text" id="Age"></span>
                                    </td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>

                                    <td>
                                        <span>生肖</span>
                                    </td>
                                    <td>
                                        <span>
                                            <input type="text" id="SymbolicAnimals"></span>
                                    </td>
                                    <td colspan="2">
                                        <span>现工作单位</span>
                                    </td>
                                    <td colspan="4">
                                        <span>
                                            <input type="text" id="ComponyName" style="width: 230px;"></span>
                                    </td>
                                    <%--<td></td><td></td>--%>
                                </tr>
                                <tr>
                                    <td>
                                        <span>毕业院校（时间）</span>
                                    </td>
                                    <td colspan="7"><span>
                                        <textarea name="" id="SchoolExperience"></textarea></span></td>
                                </tr>
                                <tr>
                                    <td>
                                        <span>工作经历</span>
                                    </td>
                                    <td colspan="7"><span>
                                        <textarea name="" id="WorkExperience">
                                            </textarea></span></td>
                                </tr>
                                <tr>
                                    <td><span>家庭成员</span></td>
                                    <td colspan="7"><span>
                                        <textarea name="" id="FamilyPeople"></textarea></span></td>
                                </tr>
                                <tr>
                                    <td><span>学习培训情况</span></td>
                                    <td colspan="7"><span>
                                        <textarea name="" id="TrainExperience"></textarea></span></td>
                                </tr>

                                <tr>
                                    <td><span>奖励情况</span></td>
                                    <td colspan="7"><span>
                                        <textarea name="" id="RewardExperience"></textarea></span></td>
                                </tr>

                            </tbody>
                        </table>
                        <table class="hr_mess" id="Print_mess" style="display: none">
                            <tbody>
                                <tr>
                                    <td>
                                        <span>姓　名</span>
                                    </td>
                                    <td>
                                        <span id="Name1"></span>
                                    </td>
                                    <td>
                                        <span>性　别</span>
                                    </td>
                                    <td>
                                        <span id="Sex1"></span></td>
                                    <td>
                                        <span>民　族</span>
                                    </td>
                                    <td>
                                        <span id="Nation1"></span></td>
                                    <td rowspan="5" colspan="2" style="vertical-align: middle; width: 158px;" class="imgbsa">
                                        <span>
                                            <img id="Photo1"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span>身份证号</span>
                                    </td>
                                    <td colspan="3">
                                        <span id="IDCart1"></span>
                                    </td>
                                    <td>
                                        <span>籍　贯</span>
                                    </td>
                                    <td>
                                        <span id="Origion1"></span></td>
                                </tr>
                                <tr>
                                    <td>
                                        <span>出生日期</span>
                                    </td>
                                    <td colspan="2">
                                        <span id="BirsDay1"></td>
                                    <td>
                                        <span>婚姻状况</span>
                                    </td>
                                    <td colspan="2">
                                        <span id="MaritalStatus1"></td>
                                </tr>
                                <tr>
                                    <td>
                                        <span>政治面貌</span>
                                    </td>
                                    <td colspan="2">
                                        <span id="PoliticalStatus1"></td>
                                    <td>
                                        <span>入党团日期</span>
                                    </td>
                                    <td colspan="2">
                                        <span id="joinTime1"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span>文化程度</span>
                                    </td>
                                    <td colspan="2">
                                        <span id="HalfEdudate1"></span>
                                    </td>
                                    <td>
                                        <span>所学专业</span>
                                    </td>
                                    <td colspan="2">
                                        <span id="Major1"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span>单位性质</span>
                                    </td>
                                    <td>
                                        <span id="CompnyType1"></span>
                                    </td>
                                    <td>
                                        <span>人员身份</span>
                                    </td>
                                    <td>
                                        <span id="PersonIdentity1"></span>
                                    </td>
                                    <td>
                                        <span>现任职务</span>
                                    </td>
                                    <td>
                                        <span id="CurrentJob1"></span>
                                    </td>
                                    <td>
                                        <span>职务级别</span>
                                    </td>
                                    <td>
                                        <span id="JobDegree1"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span>参加工作时间</span>
                                    </td>
                                    <td>
                                        <span id="JobTime1"></span>
                                    </td>
                                    <td>
                                        <span>工龄</span>
                                    </td>
                                    <td>
                                        <span id="JobYear1"></span>
                                    </td>

                                    <td>
                                        <span>年龄</span>
                                    </td>
                                    <td>
                                        <span id="Age1"></span>
                                    </td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>

                                    <td>
                                        <span>生肖</span>
                                    </td>
                                    <td>
                                        <span id="SymbolicAnimals1"></span>
                                    </td>
                                    <td colspan="2">
                                        <span>现工作单位</span>
                                    </td>
                                    <td colspan="4">
                                        <span id="ComponyName1"></span>
                                    </td>
                                    <%--<td></td><td></td>--%>
                                </tr>
                                <tr>
                                    <td>
                                        <span>毕业院校（时间）</span>
                                    </td>
                                    <td colspan="7"><span id="SchoolExperience1"></span></td>
                                </tr>
                                <tr>
                                    <td>
                                        <span>工作经历</span>
                                    </td>
                                    <td colspan="7"><span id="WorkExperience1"></span></td>
                                </tr>
                                <tr>
                                    <td><span>家庭成员</span></td>
                                    <td colspan="7"><span id="FamilyPeople1"></span></td>
                                </tr>
                                <tr>
                                    <td><span>学习培训情况</span></td>
                                    <td colspan="7"><span id="TrainExperience1"></span></td>
                                </tr>

                                <tr>
                                    <td><span>奖励情况</span></td>
                                    <td colspan="7"><span id="RewardExperience1"></td>
                                </tr>

                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="space_centerwrap none">
                    <%--<div>
                        <a class="fr" style="background: rgb(150, 191, 226); border-radius: 2px; border: 1px solid rgb(207, 216, 223); border-image: none; width: 81px; height: 26px; text-align: center; color: white; line-height: 28px; font-size: 12px; display: inline-block;"
                            href="javascript:;">添加证书</a>
                        <a class="fr" style="background: rgb(150, 191, 226); border-radius: 2px; border: 1px solid rgb(207, 216, 223); border-image: none; width: 81px; height: 26px; text-align: center; color: white; line-height: 28px; font-size: 12px; display: inline-block;"
                            href="javascript:;">导出证书</a>
                    </div>--%>
                    <%--  <div  class="ng-scope">
							<div class="certificate_wrap">--%>
                    <%-- <div class="stg_tit">
                        <span id="spaceitem1" class="action" onclick="SpaceChange(this,1)"><a href="javascript:;">证书模板</a></span>
                        <span id="spaceitem2" onclick="SpaceChange(this,2)"><a href="javascript:;">学生证书</a></span>
                        <div style="float: right; margin-right: 20px; margin-top: 5px; border: 1px solid #E2E2E2; width: 80px; text-align: center; background-color: #374760;">
                            <a rel="external nofollow" style="color: #fff;" href="javascript:;" onclick="ExportCertificate()">证书下载</a>
                        </div>
                    </div>--%>
                    <div class="stytem_select clearfix">
                        <div class="stytem_select_left fl">
                            <a href="javascript:;" class="on" id="spaceitem1" onclick="SpaceChange(this,1)">证书申请</a>
                            <a href="javascript:;" id="spaceitem2" onclick="SpaceChange(this,2)">学生证书</a>
                        </div>
                    </div>
                    <div id="CerTemplate" class="certificate">
                        <div id="CertificateApply" class="certificate_list">
                            <div class="wrap">
                                <table>
                                    <thead>
                                        <th>证书名称</th>
                                        <th>包含课程</th>
                                        <th>考试(分数)</th>
                                        <th>创建时间</th>
                                        <th>操作</th>
                                    </thead>
                                    <tbody id="tbApply">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="page">
                            <span id="pageBar"></span>
                        </div>
                    </div>
                    <div id="GrantCer" style="display: none;">
                        <div id="NCertificateList" class="certificate_list">
                            <div class="newcourse_select clearfix" id="CourseSel">
                                <div class="stytem_select_right fr">
                                    <a href="javascript:;" class="newcourse" onclick="UploadAttach()" id="icon-plus">上传附件
                                    </a>
                                </div>
                            </div>
                            <div class="wrap">
                                <table>
                                    <thead>
                                        <th>证书编号</th>
                                        <th>证书名称</th>
                                        <th>发证单位</th>
                                        <th>结束时间</th>
                                        <th>查询网址</th>
                                        <th>状态</th>
                                        <th>操作</th>
                                    </thead>
                                    <tbody id="tbCertificate">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="space_centerwrap wrap none">
                    <div class="clearfix fr">
                        <input type="button" class="btn fl" onclick="AddTrain()" value="添加培训档案">
                        <input type="button" class="btn fl ml10" onclick="ExportTrain()" value="导出培训档案" style="margin-left: 10px;" />
                    </div>
                    <%--<div>
                        <a class="btncss">添加培训档案</a>
                        <a class="btncss" onclick="ExportTrain()">导出培训档案</a>

                    </div>--%>
                    <div class="wrap">
                        <table>
                            <thead>
                                <th>机构名称</th>
                                <th>培训名称</th>
                                <th>开始时间</th>
                                <th>结束时间</th>
                                <th>培训学时</th>
                                <th>授课人</th>
                                <th>培训费用</th>
                                <th>培训结果</th>
                                <th>操作</th>

                            </thead>
                            <tbody id="tbTran">
                            </tbody>
                        </table>
                    </div>
                </div>
               
                 <div class="space_centerwrap none">
                        <div class="wrap">
                            <table>
                                <thead>
                                    <th>序号</th>
                                    <th>收藏名称</th>
                                    <th>收藏类型</th>
                                    <th>收藏时间</th>
                                    <th>操作</th>
                                </thead>
                                <tbody id="tbFavorite">
                                </tbody>
                            </table>
                        </div>
                        <!--分页-->
                    <div class="page">
                        <span id="pageBar5"></span>
                    </div>
                    </div>
            </div>
            <div class="space_right fr">
                <div class="wait_for" style="background: #f6fafc; border: 1px solid #d1e3f2; height: 288px;">
                    <h1>最新消息</h1>
                    <ul id="NewMessage">
                    </ul>
                </div>
                <div class="qualifications mt20 mb20">
                    <h1>证书</h1>
                    <div class="qualifications_slide">
                        <ul class="sides" id="CertImg">
                        </ul>
                        <div class="num">
                            <ul></ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer>
        <div class="footer width clearfix">
            <div class="logo fl">
                <img src="/images/footer_logo.png" alt="" style="margin-top: 10px;" />
            </div>
            <div class="footer_right fr">
                <p>地址：北京市海淀区中关村环保科技示范园内（海淀区北清路）</p>
                <p>
                    传真：010-62463259   网址：<a
                        href="http://www.bjybjx.cn" target="_blank" style="color: #fff;">http://www.bjybjx.cn</a>
                </p>
                <p>电子邮件（E-MAIL）:yqybjxzb@sohu.com </p>
            </div>
        </div>
    </footer>
    <script type="text/javascript" src="/js/common.js"></script>
    <script src="/js/jquery.SuperSlide.2.1.1.js"></script>
    <script type="text/javascript">
        $('.edit_password span').on('click', function () {
            $(this).addClass('on').siblings().removeClass('on');
            var n = $(this).index();
            $('.mess_wraps .mess_wrap').eq(n).show().siblings().hide();
        })
        $(function () {
            $("#uploadify").uploadify({
                'auto': true,                      //是否自动上传
                'swf': '/Scripts/Uploadyfy/uploadify/uploadify.swf',
                'uploader': 'http://192.168.1.101:9005/ImageUpLoadHandler.ashx',

                'formData': { Func: "StudentImage", ImageName: $("#PhotoName").val() }, //参数
                //'fileTypeDesc': '',
                'fileTypeExts': '*.jpg;*.jpeg;*.png',   //文件类型限制,默认不受限制
                'buttonText': '更换头像',//按钮文字
                // 'cancelimg': 'uploadify/uploadify-cancel.png',
                'width': 83,
                'height': 28,
                //最大文件数量'uploadLimit':
                'multi': false,//单选            
                'fileSizeLimit': '20MB',//最大文档限制
                'queueSizeLimit': 1,  //队列限制
                'removeCompleted': true, //上传完成自动清空
                'removeTimeout': 0, //清空时间间隔
                //'overrideEvents': ['onDialogClose', 'onUploadSuccess', 'onUploadError', 'onSelectError'],
                'onUploadSuccess': function (file, data, response) {
                    //location.reload();
                    var json = $.parseJSON(data);
                    var errNum = json.result.errMsg;
                    if (errNum == "0") {
                        layer.msg("更新成功！");
                        location.reload();
                    }
                    if (errNum == "1") {
                        layer.msg("更新失败！");
                    }
                },

            });
            geCoursetData();
            getTrainingData();
            bindModol();
            Certificate();
            PersonDocument();
            BindCertificate(1, 10);
            GetMessge(1, 9);
            $("#print").click(function () {
                $("#Print_mess").show();
                $("#Print_mess").jqprint({
                    debug: false, //如果是true则可以显示iframe查看效果（iframe默认高和宽都很小，可以再源码中调大），默认是false
                    importCSS: true, //true表示引进原来的页面的css，默认是true。（如果是true，先会找$("link[media=print]")，若没有会去找$("link")中的css文件）
                    printContainer: true, //表示如果原来选择的对象必须被纳入打印（注意：设置为false可能会打破你的CSS规则）。
                    operaSupport: true//表示如果插件也必须支持歌opera浏览器，在这种情况下，它提供了建立一个临时的打印选项卡。默认是true
                });
                $("#Print_mess").hide();

            })
        })

        function GetMessge(startIndex, pageSize) {
            pageNum = (startIndex - 1) * pageSize + 1;

            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/PortalManage/MessageHandler.ashx",
                    Func: "GetPageList",
                    Ispage: true,
                    Receiver: $("#HUserIdCard").val(),
                    PageIndex: startIndex,
                    pageSize: pageSize,
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#NewMessage").html('');
                        $.each(json.result.retData.PagedData, function () {
                            var Content = this.Contents.toString().replace(/<[^>]+>/g, "");//RegExp.Replace(this.Contents, "<[^>]*>", "");
                            $("#NewMessage").append("<li><a href=\"javascript:;\" title=\"" + Content + "\">" + cutstr(Content, 20) + "</a></li>");
                        })


                        //$("#li_Message").tmpl(json.result.retData.PagedData).appendTo("#NewMessage");
                    }
                    else {
                        $("#NewMessage").html("");
                    }
                },
                error: function () {
                    $("#NewMessage").html();
                }
            });
        }
        //平台证书
        function BindCertificate(startIndex, pageSize) {
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                dataType: "json",
                async: false,
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "GetPlatCertificate",
                    PageIndex: startIndex,
                    pageSize: pageSize,
                },
                success: function (json) {
                    var tr = "";
                    var ExamName = "";
                    var CourseName = "";

                    if (json.CertificateManage.errNum.toString() == "0") {
                        $("#page").show();
                        $("#tbApply").html('');
                        //$("#tr_Certificates").tmpl(json.CertificateManage.retData.PagedData).appendTo("#tbCertificates");
                        $.each(json.CertificateManage.retData.PagedData, function (n, value) {
                            var CertificateID = this.ID;
                            ExamName = "";
                            CourseName = "";

                            //考试
                            $.each(json.Exam.retData, function (n, value) {
                                if (this.CertificateID == CertificateID) {
                                    ExamName += "[" + this.Title + "(" + this.Score + ")]";
                                }
                            });
                            //课程
                            $.each(json.Course.retData, function (n, value) {
                                if (this.CertificateID == CertificateID) {
                                    CourseName += "[" + this.CourseName + "]";
                                }
                            });
                            tr += "<tr> <td>" + this.Name + "</td><td>" + CourseName.trim('-') + "</td><td>" + ExamName.trim('-') + "</td><td>" + DateTimeConvert(this.CreateTime, 'yyyy-MM-dd') + "</td><td>"
                            + "<a onclick=\"Apply(" + this.ID + ")\">申请</a></td>";
                        })

                        $("#tbApply").html(tr);
                        makePageBar(BindCertificate, document.getElementById("pageBar"), json.CertificateManage.retData.PageIndex, json.CertificateManage.retData.PageCount, pageSize, json.CertificateManage.retData.RowCount);
                    }
                    else {
                        var html = '<div style="background: url(/images/error.png) no-repeat center center; height: 500px;"></div>';
                        $("#page").hide();
                        $("#tbApply").html(html);
                        layer.msg(json.result.errMsg);
                    }
                },
                error: function (errMsg) {
                    $("#page").hide();
                    layer.msg(errMsg);
                }
            });
        }
        //证书申请
        function Apply(ID) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "ApplyCert",
                    ClassID: $("#Hid_ClassID").val(),
                    StuNo: $("#HUserIdCard").val(),
                    StuName: $("#HStuName").val(),
                    CertificateID: ID
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("申请成功");
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        //添加培训档案
        function AddTrain() {
            OpenIFrameWindow('添加培训档案', 'TrainingAdd.aspx', '600px', '410px');
        }
        function bzCertificateGet(em) {

            var src = $(em).attr('src');
            src = src.replace('_s.jpg', '.jpg');
            $("#Modole_show").attr("src", src);
        }
        function SpaceChange(em, Type) {
            if (Type == 1) {
                $("#spaceitem1").addClass("on");
                $("#spaceitem2").removeClass("on");

                $("#GrantCer").hide();
                $("#CerTemplate").show();
            }
            else {
                $("#spaceitem1").removeClass("on");
                $("#spaceitem2").addClass("on");

                $("#GrantCer").show();
                $("#CerTemplate").hide();
            }
            $(em).addClass("action").siblings().removeClass("action");
        }
        //获取课程数据
        function geCoursetData() {

            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/MyLessonsHandler.ashx",
                    Func: "GetMyLessonsDataPage",
                    ClassID: $("#Hid_ClassID").val(),
                    StuNo: $("#HUserIdCard").val(),
                    StudyTerm: $("#StudyTerm").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#ul_mylessons").html('');
                        $("#li_mylessons").tmpl(json.result.retData.PagedData).appendTo("#ul_mylessons");
                    }
                    else {
                        $("#ul_mylessons").html("暂无课程！");
                    }
                },
                error: function () {
                    $("#ul_mylessons").html(errMsg);
                }
            });
        }
        //获取培训信息
        function getTrainingData() {

            $("#tbTran").html("");
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                dataType: "json",
                data: {
                    PageName: "/CourseManage/PersonSpaceStu.ashx",
                    Func: "GetPageList"
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var data = json.result.retData;
                        $("#trTran").tmpl(data).appendTo("#tbTran");
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        //导出
        function ExportTrain() {
            window.open('/PersonalSpace/ToExcelHandler.ashx?Func=TrainDoc', "myIframe");
        }
        //导出
        function ExportMyDoc() {
            window.open('/PersonalSpace/ToExcelHandler.ashx?Func=MyDoc&IDCarD=' + $("#HUserIdCard").val(), "myIframe");
        }

        //证书模板
        function bindModol() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                dataType: "json",
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "GetModolList",
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#Certificate").html('');
                        $("#li_Modol").tmpl(json.result.retData).appendTo("#Certificate");
                    }
                    else {
                        $("#Certificate").html("暂无证书模板！");
                    }
                },
                error: function (errMsg) {
                    $("#Certificate").html(errMsg);
                }
            });
        }
        //证书
        function Certificate() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                dataType: "json",
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "GetCertificates",
                    Ispage: false,
                    IDCard: $("#HUserIdCard").val(),
                    Status: 1
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#tbCertificate").html('');
                        $("#tr_Certificate").tmpl(json.result.retData).appendTo("#tbCertificate");
                        $("#tr_CertImg").tmpl(json.result.retData).appendTo("#CertImg");
                        //.append(" <li><a><img src=\"" + this.Attachment + "\"></a></li>")

                    }
                    else {
                        $("#tbCertificate").html("暂无证书！");
                    }
                    $(".qualifications_slide").slide({ mainCell: ".sides", titCell: ".num ul", effect: "leftLoop", autoPlay: true, delayTime: 700, autoPage: true });
                },
                error: function (errMsg) {
                    $("#tbCertificate").html(errMsg);
                }
            });
        }
        //修改个人档案
        function EditMyDoc() {
            var ID = $("#MyDocID").val();
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                dataType: "json",
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "EditPersonDocument",
                    IDCard: $("#HUserIdCard").val(),
                    ID: ID,
                    Sex: $("#Sex").val(),
                    Nation: $("#Nation").val(),
                    Nation: $("#Nation").val(),
                    Origion: $("#Origion").val(),
                    BirsDay: $("#BirsDay").val(),
                    joinTime: $("#joinTime").val(),
                    HalfEdudate: $("#HalfEdudate").val(),
                    Major: $("#Major").val(),
                    CompnyType: $("#CompnyType").val(),
                    PoliticalStatus: $("#PoliticalStatus").val(),
                    PersonIdentity: $("#PersonIdentity").val(),
                    CurrentJob: $("#CurrentJob").val(),
                    JobDegree: $("#JobDegree").val(),
                    JobTime: $("#JobTime").val(),
                    JobYear: $("#JobYear").val(),
                    Age: $("#Age").val(),
                    SymbolicAnimals: $("#SymbolicAnimals").val(),
                    //SchoolName: $("#SchoolName").val(),
                    WorkExperience: $("#WorkExperience").val(),
                    FamilyPeople: $("#FamilyPeople").val(),
                    TrainExperience: $("#TrainExperience").val(),
                    ComponyName: $("#ComponyName").val(),
                    RewardExperience: $("#RewardExperience").val(),
                    SchoolExperience: $("#SchoolExperience").val()

                }, success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("修改成功");
                        PersonDocument();
                    }
                    else {
                        layer.msg("修改失败");
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        //个人档案
        function PersonDocument() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                dataType: "json",
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "PersonDocument",
                    IDCart: $("#HUserIdCard").val(),
                    Ispage: false
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            $("#MyDocID").val(this.ID);
                            $("#DocumentID").html(this.DocumentID);
                            $("#Name").html(this.Name);
                            $("#Sex").val(this.Sex);
                            $("#Nation").val(this.Nation);
                            $("#Photo").attr("src", this.Photo);
                            $("#Nation").val(this.Nation);
                            $("#Origion").val(this.Origion);
                            $("#BirsDay").val(DateTimeConvert(this.BirsDay, "yyyy-MM-dd"));
                            //if (this.MaritalStatus == 0) {
                            $("#MaritalStatus").val(this.MaritalStatus);
                            //}
                            //else {
                            //    $("#MaritalStatus").val("已婚");
                            //}
                            $("#joinTime").val(DateTimeConvert(this.joinTime, "yyyy-MM-dd"));
                            $("#HalfEdudate").val(this.HalfEdudate);
                            $("#Major").val(this.Major);
                            $("#CompnyType").val(this.CompnyType);
                            $("#PoliticalStatus").val(this.PoliticalStatus);
                            $("#PersonIdentity").val(this.PersonIdentity);
                            $("#CurrentJob").val(this.CurrentJob);
                            $("#JobDegree").val(this.JobDegree);
                            $("#JobTime").val(DateTimeConvert(this.JobTime, "yyyy-MM-dd"));
                            $("#JobYear").val(this.JobYear);
                            $("#IDCart").html(this.IDCart);
                            $("#Age").val(this.Age);
                            $("#SymbolicAnimals").val(this.SymbolicAnimals);
                            // $("#SchoolName").val(this.SchoolName);
                            $("#WorkExperience").val(this.WorkExperience);
                            $("#FamilyPeople").val(this.FamilyPeople);
                            $("#TrainExperience").val(this.TrainExperience);
                            $("#ComponyName").val(this.ComponyName);
                            $("#RewardExperience").val(this.RewardExperience);
                            $("#SchoolExperience").val(this.SchoolExperience);


                            $("#DocumentID1").html(this.DocumentID);
                            $("#Name1").html(this.Name);
                            $("#Sex1").html(this.Sex);
                            $("#Nation1").html(this.Nation);
                            $("#Photo1").attr("src", this.Photo);
                            $("#Nation1").html(this.Nation);
                            $("#Origion1").html(this.Origion);
                            $("#BirsDay1").html(DateTimeConvert(this.BirsDay, "yyyy-MM-dd"));
                            // if (this.MaritalStatus == 0) {
                            $("#MaritalStatus1").html(this.MaritalStatus);
                            //}
                            //else {
                            //    $("#MaritalStatus1").html("已婚");
                            //}
                            $("#joinTime1").html(DateTimeConvert(this.joinTime, "yyyy-MM-dd"));
                            $("#HalfEdudate1").html(this.HalfEdudate);
                            $("#Major1").html(this.Major);
                            $("#CompnyType1").html(this.CompnyType);
                            $("#PoliticalStatus1").html(this.PoliticalStatus);
                            $("#PersonIdentity1").html(this.PersonIdentity);
                            $("#CurrentJob1").html(this.CurrentJob);
                            $("#JobDegree1").html(this.JobDegree);
                            $("#JobTime1").html(DateTimeConvert(this.JobTime, "yyyy-MM-dd"));
                            $("#JobYear1").html(this.JobYear);
                            $("#IDCart1").html(this.IDCart);
                            $("#Age1").html(this.Age);
                            $("#SymbolicAnimals1").html(this.SymbolicAnimals);
                            //$("#SchoolName1").html(this.SchoolName);
                            $("#WorkExperience1").html(this.WorkExperience);
                            $("#FamilyPeople1").html(this.FamilyPeople);
                            $("#TrainExperience1").html(this.TrainExperience);
                            $("#ComponyName1").html(this.ComponyName);
                            $("#RewardExperience1").html(this.RewardExperience);
                            $("#SchoolExperience1").html(this.SchoolExperience);
                        })

                    }
                    else {
                        layer.msg("获取档案信息失败");
                    }
                },
                error: function (errMsg) {
                    layer.msg("获取档案信息失败");
                }
            });
        }

        function ShowCertificate(ID) {
            OpenIFrameWindow('证书预览', 'CertificateShow.aspx?ID=' + ID + "&Type=2", '480px', '480px');
        }
        function UpdatePwd() {
            var LoginName = $("#LoginName").val();
            var OldPassword = $("#OldPassword").val();
            var NewPassword = $("#NewPassword").val();
            var NewPassword1 = $("#NewPassword1").val();

            if (!OldPassword.length || !NewPassword.length || !NewPassword1.length) {
                layer.msg("所有数据不可为空");
            }
            else {
                if (NewPassword != NewPassword1) {
                    layer.msg("新密码和确认密码不一致");
                }
                else {
                    $.ajax({
                        url: "/SystemSettings/CommonInfo.ashx",
                        type: "post",
                        dataType: "json",
                        data: {
                            Func: "UpStuPass",
                            LoginName: LoginName,
                            OldPassword: OldPassword,
                            NewPassword: NewPassword
                        },
                        success: function (json) {
                            if (json.result.errNum.toString() == "0") {
                                layer.msg("密码修改成功");
                                logOut();
                            }
                            else {
                                layer.msg(json.result.errMsg)
                            }
                        },
                        error: function (errMsg) {
                            $("#tbCertificate").html(errMsg);
                        }
                    });
                }
            }

        }
        function DrStu() {
            OpenIFrameWindow('导入学生', 'ImportStudent.aspx', '600px', '260px');
        }
        function DcStu() {
            window.open('/PersonalSpace/ToExcelHandler.ashx?Func=StuDoc&IDCard=' + $("#HUserIdCard").val(), "myIframe");
        }
        function UploadAttach() {
            OpenIFrameWindow('上传附件', 'CertificateAttach.aspx?Type=1', '320px', '300px');
        }
    </script>

    <script type="text/javascript">
        function getDataF(startIndex, pageSize) {
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/AdminManager.ashx",
                    Func: "GetPageFavoritesList",
                    PageIndex: startIndex,
                    PageSize: pageSize,
                    isPage: true,
                    IDCard: $("#HUserIdCard").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tbFavorite").html('');
                        $("#tr_Favorite").tmpl(json.result.retData.PagedData).appendTo("#tbFavorite");
                        makePageBar(getDataF, document.getElementById("pageBar5"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                    }
                    else {
                        $("#tbFavorite").html("<tr><td colspan=5>暂无收藏！</td></tr>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function delFavorites(id) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/AdminManager.ashx",
                    Func: "DelFavorites",
                    ID: id
                },
                success: function (json) {
                    if (json.result.errNum == 0) {
                        layer.msg("删除成功！")
                    } else {
                        layer.msg(json.result.errMsg);
                    }
                    getDataF(1, 10)
                }
            })
        }
    </script>

    <script>
        $(function () {
            //hoverEnlarge($('.personal_img img'));
            //hoverEnlarge($('.comments_list li img'));

            $('.personal_link>li').click(function () {
                $(this).addClass('active').siblings().removeClass('active');
                var n = $(this).index();
                $('.space_center .space_centerwrap').eq(n).show().siblings().hide();
            })
            $('.edit_mes').click(function () {
                $('.personal_link>li').removeClass('active');
                $('.personal_link>li').eq(1).addClass('active');
                $('.space_center .space_centerwrap').hide();
                $('.space_center .space_centerwrap').eq(1).show();
            })
            /*SuperSlide图片切换*/

            getDataF(1, 10);
        })
    </script>
</body>
</html>
