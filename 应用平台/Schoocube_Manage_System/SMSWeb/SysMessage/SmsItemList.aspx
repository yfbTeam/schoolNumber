<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SmsItemList.aspx.cs" Inherits="SMSWeb.SysMessage.SmsItemList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>短信</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <link href="/Scripts/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <style>
        .email_left {
            width: 948px;
            padding: 20px;
        }

        .email_right {
            width: 150px;
        }

        .email_row {
            margin-bottom: 15px;
            overflow: hidden;
        }

            .email_row label {
                width: 50px;
                line-height: 30px;
                color: #666;
                text-align: right;
                float: left;
                display: inline-block;
                font-size: 14px;
            }

            .email_row .recipient_wrap input {
                width: 30px;
                height: 28px;
                border: none;
            }

        .recipient_wrap {
            cursor: text;
            width: 640px;
            float: right;
            border: 1px solid #ccc;
            overflow: hidden;
            float: right;
            border-radius: 2px;
            padding-left: 10px;
        }

        .email_row .theme {
            width: 650px;
            text-indent: 10px;
            height: 28px;
            border: 1px solid #ccc;
            float: right;
            border-radius: 2px;
        }

        .email_row .textarea {
            width: 630px;
            height: 200px;
            border: 1px solid #ccc;
            border-radius: 2px;
            float: right;
            padding: 10px;
        }

        .contact h1 {
            background: #37A8E0;
            color: #fff;
            font-size: 16px;
            line-height: 34px;
            padding: 0px 10px;
            font-weight: normal;
        }

        .send {
            height: 30px;
            color: #fff;
            font-size: 14px;
            width: 80px;
            margin-left: 56px;
            border-radius: 2px;
            border: none;
            cursor: pointer;
            background: #1472b9;
        }

        .search {
            position: relative;
            width: 200px;
            height: 34px;
            background: #fff;
            border-radius: 2px;
            margin: 10px 0px;
            border: 1px solid #ccc;
        }

            .search input {
                width: 170px;
                height: 32px;
                background: #fff;
                color: #666;
                border: none;
                color: #74B5E5;
                border-radius: 2px;
                float: right;
            }

            .search i {
                color: #74B6E8;
                position: absolute;
                top: 8px;
                left: 8px;
            }

        .messages_state ul li {
            border-bottom: 1px dotted #ccc;
            padding: 5px 0px;
            line-height: 20px;
            font-size: 15px;
            overflow: hidden;
        }

            .messages_state ul li input[type=checkbox] {
                float: left;
                margin-right: 10px;
            }

            .messages_state ul li .date {
                float: right;
                line-height: 20px;
            }

            .messages_state ul li span {
                display: inline-block;
                float: left;
            }

            .messages_state ul li a {
                font-size: 15px;
                display: inline-block;
                float: left;
                width: 72%;
                text-overflow: ellipsis;
                overflow: hidden;
                white-space: nowrap;
            }

            .messages_state ul li .icon {
                width: 20px;
                height: 20px;
                float: left;
                margin-right: 10px;
                color: #999;
            }

        .tips_bar {
            border-bottom: 1px solid #ccc;
            line-height: 48px;
            background: #FBFBFB;
        }

            .tips_bar input[type=button] {
                height: 30px;
                color: #fff;
                font-size: 14px;
                border-radius: 2px;
                border: none;
                cursor: pointer;
            }

            .tips_bar .delete {
                background: #1472b9;
            }

        .send_status ul li {
            cursor: pointer;
            padding: 5px 10px;
            font-size: 14px;
            line-height: 20px;
        }

            .send_status ul li.on {
                background: #37A8E0;
                color: #fff;
            }

                .send_status ul li.on a {
                    color: #fff;
                }

        .reply {
            float: right;
            margin-right: 10px;
            background: #1472b9;
            cursor: pointer;
            border: none;
            color: #fff;
            border-radius: 2px;
            height: 20px;
        }

        .email_div_left {
            width: 708px;
            float: left;
            padding: 10px;
        }

        .email_div_right {
            width: 200px;
            float: right;
        }
    </style>
    <style type="text/css">
        .ui-upload-input {
            position: absolute;
            top: 0px;
            right: 0px;
            height: 100%;
            cursor: pointer;
            opacity: 0;
            filter: alpha(opacity:0);
            z-index: 999;
            font-size: 100px;
        }

        .ui-upload-holder {
            position: relative;
            width: 100px;
            height: 27px;
            border: 1px solid silver;
            overflow: hidden;
            border-radius: 3px;
            cursor: pointer;
        }

        .ui-upload-txt {
            position: absolute;
            top: 0px;
            left: 0px;
            width: 100px;
            height: 27px;
            line-height: 27px;
            text-align: center;
            background: #0097DD none repeat scroll 0% 0%;
            color: #fff;
            font: 12px "微软雅黑";
            vertical-align: middle;
            padding: 5px 0px;
            cursor: pointer;
        }

        .settingsd {
            padding: 20px;
        }

            .settingsd table tr td {
                border: 1px solid #ccc;
                padding: 10px;
            }

        .shgnchuanbottom {
            width: 102px;
            height: 30px;
            margin-left: 56px;
        }

        .search_none li {
            padding: 5px;
            border: 1px dotted #ccc;
            cursor: pointer;
        }

            .search_none li .name {
                color: #666;
                font-size: 15px;
                line-height: 20px;
            }

            .search_none li .name_email {
                color: #999;
                font-size: 14px;
                line-height: 20px;
            }

        .messages_detail {
            padding-left: 58px;
            padding-right: 195px;
            margin-top: 10px;
            font-size: 14px;
            display: none;
            text-indent: 2em;
        }
    </style>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/zTree/js/jquery.ztree.core-3.5.js"></script>
    <script src="/PortalJs/ajaxfileupload.js"></script>
    <script src="/Scripts/Validform_v5.3.1.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <!--[if IE]>
    <script src="js/html5.js"></script>
    <![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script type="text/x-jquery-tmpl" id="query_Name">
        <li onclick="javascript:setReceiver('${name}','${Phone}');">
            <p class="name">${name}</p>
            <p class="name_email">${Phone}</p>
        </li>
    </script>
</head>
<body>
    <form id="registerform" name="registerform" class="registerform" runat="server">
        <asp:HiddenField ID="HUserIdCard" runat="server" />
        <asp:HiddenField ID="HUserName" runat="server" />
        <asp:HiddenField ID="HRoleType" runat="server" />
        <input id="HPhoneFile" type="hidden" />
        <header class="repository_header_wrap">
            <div class="width repository_header clearfix">
                <%if (SF == "教师")
                  { %>
                <a class="logo fl" href="/HZ_Index.aspx">
                    <%}
                  else
                  { %>
                    <a class="logo fl" href="/PersonalSpace/Learning_center_portal.aspx">
                        <%} %>
                        <img src="/images/logo.png" />

                    </a>
                    <div class="wenzi_tips fl">
                        <img src="/images/duanxin.png" />
                    </div>
                    <div class="search_account fr clearfix">
                        <%--<div class="search fl">
                    <i class="icon  icon-search"></i>
                    <input type="text" name="" id="" placeholder="请输入关键字" />
                </div>--%>
                        <ul class="account_area fl">
                            <li>
                                <a href="#" class="dropdown-toggle">
                                    <i class="icon icon-envelope"></i>
                                    <span class="badge">0</span>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:;" class="login_area clearfix">
                                    <div class="avatar">
                                        <img src="<%=PhotoURL %>" />
                                    </div>
                                    <h2><%=Name %></h2>
                                </a>
                            </li>
                        </ul>
                        <div class="settings fl pr ">
                            <a href="javascript:;">
                                <i class="icon icon-cog"></i>
                            </a>
                            <div class="setting_none">
                                <%if (SF == "教师")
                                  { %>
                                <a href="/PersonalSpace/PersonalSpace_Teacher.aspx" target="_blank">
                                    <%}
                                  else
                                  { %>
                                    <a href="/PersonalSpace/PersonalSpace_Student.aspx" target="_blank">
                                        <%} %>
                                        <span>个人中心</span></a>
                                    <span onclick="logOut()">退出</span>
                            </div>
                        </div>
                    </div>
            </div>
        </header>
        <!--个人空间-->
        <div class="bordshadrad width" style="background: #fff; margin-top: 20px;">
            <div class="personal_spacea  clearfix " style="padding: 20px;">
                <div class="email_wrap">
                    <div class="email_right fl">
                        <div class="send_status bordshadrad" style="min-height: 30px;">
                            <ul>
                                <li class="on"><a href="/SysMessage/SmsItemList.aspx">写短信</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="email_left fr bordshadrad">
                        <div class="email_div">
                            <div class="email_div_left bordshadrad">
                                <%--<div class="email_row">
                                    <label for="recipient">收件人:</label>
                                    <input type="text" class="" name="Receivers" datatype="*" nullmsg="请输入收件人！"/>
                                </div>
                                <div class="email_row">
                                    <label for="theme">主题:</label>
                                    <input type="text" class="" name="Title"  id="Title" datatype="*" nullmsg="请输入主题！"/>
                                </div>--%>
                                <div class="email_row">
                                    <label for="recipient">接收人:</label>
                                    <div class="recipient_wrap">
                                        <%--<div class="add_inputwrap fl">

                                        </div>--%>
                                        <div class="add_input fl">
                                            <input type="text" class="" name="Receivers" />
                                        </div>
                                    </div>
                                </div>
                                <div class="email_row">
                                    <label for="">内容:</label>
                                    <div class="textarea">
                                        <textarea id="editor_id" name="content" style="width: 100%; height: 200px; box-sizing: border-box;"></textarea>
                                    </div>
                                </div>
                                <div class="email_row">
                                    <input type="button" class="send" value="发送" id="btnSend" />
                                    <%--<input type="button" class="send" value="定时发送" id="btnTiming" />--%>
                                    <input type="reset" id="btnreset" style="display: none" />
                                </div>
                            </div>
                            <div class="email_div_right">
                                <div class="contact">
                                   <h1>联系人</h1>
                                    <div class="search">
                                        <i class="icon  icon-search"></i>
                                        <input type="text" name="" id="personsKey" placeholder="请输入关键字" />
                                    </div>
                                    <ul id="treeDemo" class="ztree bordshadrad">
                                    </ul>
                                    <ul class="search_none" id="queryDemo">
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <script src="/js/common.js"></script>
        <script type="text/javascript">
            var setting = {
                view: {
                    showIcon: showIconForTree
                },
                data: {
                    simpleData: {
                        enable: true
                    }
                },
                callback: {
                    beforeClick: beforeClick,
                    onClick: onClick
                }
            };
            function showIconForTree(treeId, treeNode) {
                return !treeNode.isParent;
            };
            function beforeClick(treeId, treeNode, clickFlag) {

            }

            function onClick(event, treeId, treeNode, clickFlag) {
                var phone = (treeNode.Phone == null || treeNode.Phone == "") ? "" : "[" + treeNode.Phone + "]";
                var qeuryName = $(".recipient_wrap").html();
                if (phone == "" || (phone != "" && qeuryName.indexOf(phone) > -1) || qeuryName.indexOf(treeNode.name) > -1 || treeNode.pid == 0) {
                    layer.msg("此用户手机号不可用！");
                    return false;
                }
                var val = treeNode.name + phone;
                var html = '<div class="add_text fl" style="line-height: 30px;font-size:13px;" ename="' + treeNode.name + '" ephone="' + treeNode.Phone + '">' + val + ';</div>';
                $('.add_input').before(html);
            }

            //选中赋值
            function setReceiver(name, phone) {
                var phonestr = (phone == null || phone == "") ? "" : "[" + phone + "]";
                var qeuryName = $(".recipient_wrap").html();
                if ((phonestr != "" && qeuryName.indexOf(phonestr) > -1) || qeuryName.indexOf(name) > -1) {
                    return false;
                }
                var val = name + phonestr;
                var html = '<div class="add_text fl" style="line-height: 30px;font-size:13px;" ename="' + name + '" ephone="' + phone + '">' + val + ';</div>';
                $('.add_input').before(html);
            }
            ///////////////////////////////////////
            keyDownDelete();
            function keyDownDelete() {
                $('.recipient_wrap').click(function () {
                    $(this).find('input').focus();
                });
                $('.add_input input').on('keyup', function (e) {
                    var len = $(this).val().length;
                    $(this).width(len * 13 + 30);
                    var e = event || window.event || arguments.callee.caller.arguments[0];
                    if (e && (e.keyCode == 8 || e.keyCode == 46)) { // 按 Esc
                        if ($(this).val() == '') {
                            $('.recipient_wrap').children('.add_text:last').remove();
                        }
                    }
                }).on('blur', function () {
                    var val = $(this).val();

                    if (val !== '') {
                        //if (val.indexOf("@") < 0) val += "@qq.com";
                        var html = '<div class="add_text fl" style="line-height: 30px;font-size:13px;" ephone="' + val + '">' + val + ';</div>';
                    }
                    $('.add_input').before(html);
                    $(this).width(30).val("");
                })
            }

            ///////////////////////////////////////
            var PersonArry = [{ id: 8888, name: "教师", pid: 0, open: false }, { id: 7777, name: "学生", pid: 0, open: false }];
            var ChangePersonArry = [];
            var isValida = false;
            $(function () {
                initStudent();
                var valiForm = $(".registerform").Validform({
                    btnSubmit: "#btnSend",
                    btnReset: "#btnreset",
                    tiptype: 3,
                    showAllError: true,
                    beforeSubmit: function (curform) {
                        //在验证成功后，表单提交前执行的函数，curform参数是当前表单对象。
                        //这里明确return false的话表单将不会提交;	
                        //saveData();
                        isValida = true;
                    }
                })

                var valiTimingForm = $(".registerform").Validform({
                    btnSubmit: "#btnTiming",
                    btnReset: "#btnreset",
                    tiptype: 3,
                    showAllError: true,
                    beforeSubmit: function (curform) {
                        //在验证成功后，表单提交前执行的函数，curform参数是当前表单对象。
                        //这里明确return false的话表单将不会提交;	
                        //saveData();
                        isValida = true;
                    }
                })
                $('.send_status ul li').on('click', function () {
                    $(this).addClass('on').siblings().removeClass('on');
                    var n = $(this).index();
                    $('.email_left .email_div').eq(n).show().siblings().hide();
                });
                $('.reveice_div ul li .reply').click(function () {
                    $('.send_status ul li').eq(0).addClass('on').siblings().removeClass('on');
                    $('.email_left .email_div').eq(0).show().siblings().hide();
                })
                
                $("#btnSend").on("click", function () {
                    if (isValida) {
                        sendMsg();
                    }
                })

                $("#personsKey").on('change keyup', function () {
                    $("#queryDemo").html("");
                    var key = $("#personsKey").val();
                    if (key == "" || key.length == 0) {
                        $("#treeDemo").show();
                        $("#queryDemo").hide();
                        return false;
                    }
                    var nameArry = [];
                    $("#treeDemo").hide();
                    $("#queryDemo").show();
                    for (var i = 0; i < PersonArry.length; i++) {
                        var name = PersonArry[i].name;
                        var Phone = PersonArry[i].Phone;
                        if (name.indexOf(key) > -1) {
                            nameArry.push(PersonArry[i]);
                        }
                    }
                    $("#query_Name").tmpl(nameArry).appendTo("#queryDemo");
                })

            })

            function initStudent() {
                $.ajax({
                    url: "/SystemSettings/CommonInfo.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { Func: "GetTeacherPower", IDCard: $("#HUserIdCard").val() },
                    success: function (json) {
                        $("#treeDemo").html('');
                        if (json.result.errNum.toString() == "0") {
                            var items = json.result.retData;
                            if (items != null && items.length > 0) {
                                for (var i = 0; i < items.length; i++) {
                                    var student = new Object();
                                    student.id = i * 17;
                                    student.IDCard = items[i].IDCard;
                                    student.name = items[i].Name;
                                    student.Phone = items[i].Phone;
                                    student.pId = 8888;
                                    PersonArry.push(student);
                                }
                            }
                        }
                        else {
                            //$("#treeDemo").html("暂无联系人！");
                        }
                        initTeacher();
                    },
                    error: OnError
                });

            }

            function initTeacher() {
                $.ajax({
                    url: "/SystemSettings/CommonInfo.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { Func: "GetStudentByTeacher", TeacherIDCard: $("#HUserIdCard").val() },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            var items = json.result.retData;
                            var classArry = [];
                            if (items != null && items.length > 0) {
                                for (var i = 0; i < items.length; i++) {
                                    var student = new Object();
                                    student.id = i * 19;
                                    student.IDCard = items[i].IDCard;
                                    student.name = items[i].Name;
                                    student.Phone = items[i].Phone;
                                    student.pId = 7777;
                                    PersonArry.push(student);
                                }
                            }
                        }
                        $.fn.zTree.init($("#treeDemo"), setting, PersonArry);
                    },
                    error: OnError
                });
            }

            //已发送
            function getDataForYes(startIndex, pageSize) {
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        PageName: "PortalManage/MessageHandler.ashx",
                        Func: "GetPageList",
                        Creator: $("#HUserIdCard").val(),
                        type: 7,
                        PageIndex: startIndex,
                        pageSize: pageSize
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            $("#ul_ySend").html('');
                            $("#item_ySend").tmpl(json.result.retData.PagedData).appendTo("#ul_ySend");
                            makePageBar(getDataForYes, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                        }
                        else {
                            $("#ul_ySend").html("<li>暂无邮件！</li>");
                        }
                        $('.yeschk ul li').children('a').on('click', function () {
                            $(this).siblings('.messages_detail').stop().slideToggle();
                            $('.yeschk ul li').find('.messages_detail').not($(this).siblings('.messages_detail')).slideUp();
                        })
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {

                    }
                });
            }

            //发送邮件
            function sendMsg() {
                var selArry = [];
                var phone = "";
                $(".recipient_wrap .add_text").each(function (index, ele) {
                    var strPhone = $(ele).attr("ephone");
                    for (var i = 0; i < PersonArry.length; i++) {
                        if (strPhone == PersonArry[i].Phone) {
                            selArry.push(PersonArry[i].Phone);
                            //var obj = new Object();
                            //obj.Receiver = PersonArry[i].IDCard;
                            //obj.ReceiverPhone = PersonArry[i].Phone;
                            //obj.ReceiverName = PersonArry[i].name;
                            //selArry.push(obj);
                            break;
                        }
                    }
                })
                if (selArry.length > 0) {
                    phone = selArry.toString();
                } else
                {
                    layer.msg("没有需要发送的用户！");
                    return false;
                }
                var date = getNowFormatDate();
                $.ajax({
                    url: "/phone.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        accountSid: "8a7e58f2cc064f639e1e3302a0f7f2f6",
                        smsContent: "【远程教学平台网】您注册远程教学平台网站的用户" + $("#HUserName").val() + "给您发送消息：" + $("#editor_id").val() + "，请查收。",
                        to: phone,
                        timestamp: date,
                        respDataType: "JSON",
                        sig: "8a7e58f2cc064f639e1e3302a0f7f2f6" + "d00361afaa7149c5b21fb61527f33f41" + date
                    },
                    success: function (json) {
                        if (json.respCode == "00000") {
                            layer.msg("发送成功！");
                            $("#btnreset").trigger("click");
                        }
                        else {
                            layer.msg("发送失败，错误代码："+json.respCode);
                        }
                    },
                    error: function (errMsg) {

                    }
                });
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
        </script>
    </form>
</body>
</html>
