<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmailtemList.aspx.cs" Inherits="SMSWeb.SysMessage.EmailtemList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>电子邮件</title>
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
            height: 600px;
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
    <script src="/Scripts/KindUeditor/kindeditor.js"></script>
    <script src="/Scripts/KindUeditor/plugins/code/prettify.js"></script>
    <script src="/Scripts/KindUeditor/lang/zh_CN.js"></script>
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
    <script type="text/x-jquery-tmpl" id="item_ySend">
        <li>
            <input type="checkbox" onclick="checkItem(this)" class="Check_box" />
            <i class="icon icon-envelope"></i>
            <a href="javascript:;">${NameLengthUpdate(Title,30)}</a>
            <span class="fr date">${DateTimeConvert(CreateTime)}</span>
            <div class="messages_detail clearfix">
                {{html Contents}}
            </div>
        </li>
    </script>
    <script type="text/x-jquery-tmpl" id="item_nSend">
        <li>
            <input type="checkbox" onclick="checkItem(this)" class="Check_box" />
            <i class="icon icon-envelope"></i>
            <a href="javascript:;">${NameLengthUpdate(Title,30)}</a>
            <span class="fr date">${DateTimeConvert(CreateTime)}</span>
            <input type="button" name="reply" value="回复" class="reply" replyid="${Id}" />
            <div class="messages_detail clearfix">
                {{html Contents}}
            </div>
        </li>
    </script>
    <script type="text/x-jquery-tmpl" id="query_Name">
        <li onclick="javascript:setReceiver('${name}','${Email}');">
            <p class="name">${name}</p>
            <p class="name_email">${Email}</p>
        </li>
    </script>
</head>
<body>
    <form id="registerform" name="registerform" class="registerform" runat="server">
        <asp:HiddenField ID="HUserIdCard" runat="server" />
        <asp:HiddenField ID="HUserName" runat="server" />
        <asp:HiddenField ID="HRoleType" runat="server" />
        <input id="HEmailFile" type="hidden" />
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
                        <img src="/images/dianziyoujian.png" />
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
                        <div class="send_status bordshadrad" style="min-height: 300px;">
                            <ul>
                                <li class="on"><a href="/SysMessage/EmailtemList.aspx">写信</a></li>
                                <li>已发送</li>
                                <li>已接受</li>
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
                                    <label for="recipient">收件人:</label>
                                    <div class="recipient_wrap">
                                        <%--<div class="add_inputwrap fl">

                                        </div>--%>
                                        <div class="add_input fl">
                                            <input type="text" class="" name="Receivers" />
                                        </div>
                                    </div>
                                </div>
                                <div class="email_row">
                                    <label for="theme">主题:</label>
                                    <input type="text" class="theme" name="Title" id="Title" datatype="*" nullmsg="请输入主题！" />
                                </div>
                                <div class="email_row">
                                    <label for="theme">附件:</label>
                                    <div class="shangchuan">
                                        <div class="shgnchuantop" id="imgshow1">
                                            <a href="#" target="_blank"></a>
                                        </div>
                                        <div class="shgnchuanbottom">
                                            <div class="ui-upload-holder">
                                                <div class="ui-upload-txt">
                                                    点击上传
                                                </div>
                                                <input id="fileToUpload1" type="file" size="45" name="fileToUpload1" class="input ui-upload-input bluebutton dianjisc"
                                                    uploadattr="EmailFile" style="margin-top: 0;" />
                                            </div>
                                        </div>
                                        <div id="divUpload1" class="none">
                                            <img id="loading1" src="/PortalImages/ajaxfileloading.gif" class="none" class="img-rounded" />
                                        </div>
                                    </div>
                                </div>
                                <div class="email_row">
                                    <label for="">正文:</label>
                                    <div class="textarea">
                                        <textarea id="editor_id" name="content" style="width: 100%; height: 600px; box-sizing: border-box;">
                                    </textarea>
                                    </div>
                                </div>
                                <div class="email_row">
                                    <input type="button" class="send" value="发送" id="btnSend" />
                                    <input type="button" class="send" value="定时发送" id="btnTiming" />
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
                        <div class="email_div none messages_state yeschk">
                            <div class="tips_bar">
                                <input type="checkbox" />
                                <input type="button" value="删除所选" class="delete" />
                            </div>
                            <ul id="ul_ySend">
                            </ul>
                            <div class="page">
                                <span id="pageBar"></span>
                            </div>
                        </div>
                        <div class="email_div none messages_state reveice_div nochk">
                            <div class="tips_bar">
                                <input type="checkbox" />
                                <input type="button" value="删除所选" class="delete" />
                            </div>
                            <ul id="ul_nSend">
                            </ul>
                            <div class="page">
                                <span id="pageBar1"></span>
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
                var email = (treeNode.Email == null || treeNode.Email == "") ? "" : "[" + treeNode.Email + "]";
                var qeuryName = $(".recipient_wrap").html();
                if (email == "" || (email != "" && qeuryName.indexOf(email) > -1) || qeuryName.indexOf(treeNode.name) > -1 || treeNode.pid == 0) {
                    layer.msg("此用户邮箱不可用！");
                    return false;
                }
                var val = treeNode.name + email;
                var html = '<div class="add_text fl" style="line-height: 30px;font-size:13px;" ename="' + treeNode.name + '" eemail="' + treeNode.Email + '">' + val + ';</div>';
                $('.add_input').before(html);
            }

            //选中赋值
            function setReceiver(name, email) {
                var emailstr = (email == null || email == "") ? "" : "[" + email + "]";
                var qeuryName = $(".recipient_wrap").html();
                if ((emailstr != "" && qeuryName.indexOf(emailstr) > -1) || qeuryName.indexOf(name) > -1) {
                    return false;
                }
                var val = name + emailstr;
                var html = '<div class="add_text fl" style="line-height: 30px;font-size:13px;" ename="' + name + '" eemail="' + email + '">' + val + ';</div>';
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
                        if (val.indexOf("@") < 0) val += "@qq.com";
                        var html = '<div class="add_text fl" style="line-height: 30px;font-size:13px;" eemail="' + val + '">' + val + ';</div>';
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
                getDataForYes(1, 10);
                getDataForNo(1, 10);
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
                $("#fileToUpload1").on("change", function () {
                    ajaxFileUpload($(this));
                });
                $('.send_status ul li').on('click', function () {
                    $(this).addClass('on').siblings().removeClass('on');
                    var n = $(this).index();
                    $('.email_left .email_div').eq(n).show().siblings().hide();
                });
                $('.reveice_div ul li .reply').click(function () {
                    $('.send_status ul li').eq(0).addClass('on').siblings().removeClass('on');
                    $('.email_left .email_div').eq(0).show().siblings().hide();
                })
                checkAll($('.yeschk input[type=checkbox]'));
                checkAll($('.nochk input[type=checkbox]'));
                KindEditor.ready(function (K) {
                    window.editor = K.create('#editor_id', {
                        uploadJson: '/UploadImage.ashx?action=UploadImgForAdvertContent',
                        allowFileManager: false,//true时显示浏览服务器图片功能。
                        allowImageRemote: false,//网络图片
                        resizeType: 0,
                        items: [
                        'source', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline', "strikethrough",
                    'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                    'insertunorderedlist', '|', 'undo', 'redo', '|', 'emoticons', 'image', 'link'],
                        afterFocus: function () {
                            self.edit = edit = this; var strIndex = self.edit.html().indexOf("请添加你的描述..."); if (strIndex != -1) { self.edit.html(self.edit.html().replace("请添加你的描述...", "")); }
                        },
                        //失去焦点事件
                        afterBlur: function () { this.sync(); self.edit = edit = this; if (self.edit.isEmpty()) { self.edit.html("请添加你的描述..."); } },
                        afterUpload: function (data) {
                            if (data.result) {
                                //data.url 处理
                            } else {

                            }
                        },
                        afterError: function (str) {
                            //alert('error: ' + str);
                        }
                    });


                });

                $("#btnSend").on("click", function () {
                    if (isValida) {
                        sendMsg(0);
                    }
                })




                $("#btnTiming").on("click", function () {
                    layer.open({
                        type: 1,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['420px', '240px'], //宽高
                        content: "<div><input type=\"text\" class=\"Wdate\" id=\"CreateTime\" onfocus=\"WdatePicker({minDate:'%y-%M-{%d+1}',dateFmt:'yyyy-MM-dd HH:mm'})\" /> <input type=\"button\" class=\"send\" value=\"发送\" id=\"btnTimingSend\" /></div>"
                    });
                    $("#btnTimingSend").on("click", function () {
                        var date = $("#CreateTime").val();
                        if (date == "" || date.length < 0) {
                            layer.msg("请选择定时时间！");
                            return false;
                        }
                        sendMsg(1, date);
                    })
                })

                $("input[name='reply']").on("click", function () {
                    $("#btnreset").trigger("click");
                    var msgid = $(this).attr("replyId");
                    $.ajax({
                        url: "/Common.ashx",
                        type: "post",
                        async: false,
                        dataType: "json",
                        data: {
                            PageName: "PortalManage/MessageHandler.ashx",
                            Func: "GetMessage",
                            Id: msgid,
                        },
                        success: function (json) {
                            if (json.result.errMsg == "success") {
                                var item = json.result.retData;
                                var email = "";
                                if (item != null) {
                                    for (var i = 0; i < PersonArry.length; i++) {
                                        if (PersonArry[i].IDCard == item.Creator) {
                                            email = PersonArry[i].Email;
                                            break;
                                        }
                                    }
                                    setReceiver(item.CreatorName, email);
                                    $("#Title").val("回复主题：" + item.Title);
                                    editor.html("<br/><br/><br/>------------------ 原始邮件 ------------------<br/>" + item.Contents);
                                }
                            }
                            else {
                                layer.msg("读取邮件失败！");
                            }
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {

                        }
                    });
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
                        var email = PersonArry[i].Email;
                        if (name.indexOf(key) > -1) {
                            nameArry.push(PersonArry[i]);
                        }
                    }
                    $("#query_Name").tmpl(nameArry).appendTo("#queryDemo");
                    //if (key == "" || key.length == 0);
                    //    for (var i = 0; i < ChangePersonArry.length; i++) {

                    //}
                })

            })

            function initStudent() {
                //var data;
                //if ($("#HRoleType").val() == "学生") {
                //    data = { };
                //} else if ($("#HRoleType").val() == "教师") {
                //    data = { Func: "GetStudentByTeacher", TeacherIDCard: $("#HUserIdCard").val() };
                //}
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
                                    student.Email = items[i].Email;
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
                                    student.Email = items[i].Email;
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

            //已接受
            function getDataForNo(startIndex, pageSize) {
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        PageName: "PortalManage/MessageHandler.ashx",
                        Func: "GetPageList",
                        Receiver: $("#HUserIdCard").val(),
                        type: 7,
                        PageIndex: startIndex,
                        pageSize: pageSize
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            $("#ul_nSend").html('');
                            $("#item_nSend").tmpl(json.result.retData.PagedData).appendTo("#ul_nSend");
                            makePageBar(getDataForNo, document.getElementById("pageBar1"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                        }
                        else {
                            $("#ul_nSend").html("<li>暂无邮件！</li>");
                        }
                        $('.nochk ul li').children('a').on('click', function () {
                            $(this).siblings('.messages_detail').stop().slideToggle();
                            $('.nochk ul li').find('.messages_detail').not($(this).siblings('.messages_detail')).slideUp();
                        })
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {

                    }
                });
            }

            //发送邮件
            function sendMsg(timing, timingDate) {
                var desc = editor.html() == "请添加你的描述..." ? "" : encodeURIComponent(editor.html());
                var selArry = [];
                $(".recipient_wrap .add_text").each(function (index, ele) {
                    var strEmail = $(ele).attr("eemail");
                    for (var i = 0; i < PersonArry.length; i++) {
                        if (strEmail == PersonArry[i].Email) {
                            var obj = new Object();
                            obj.Receiver = PersonArry[i].IDCard;
                            obj.ReceiverEmail = PersonArry[i].Email;
                            obj.ReceiverName = PersonArry[i].name;
                            selArry.push(obj);
                            break;
                        }
                    }
                })
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        PageName: "PortalManage/MessageHandler.ashx",
                        Func: "MoreSendMessage",
                        Title: $("#Title").val(),
                        Receivers: JSON.stringify(selArry),
                        Creator: $("#HUserIdCard").val(),
                        CreatorName: $("#HUserName").val(),
                        Contents: desc,
                        Timing: timing,
                        isSendEmail: true,
                        Type: 7,
                        CreateTime: timingDate,
                        FilePath: $("#HEmailFile").val()
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            layer.msg("发送成功！");
                        }
                        else {

                        }
                    },
                    error: function (errMsg) {

                    }
                });
            }

            //上传
            function ajaxFileUpload(event) {
                var e = event ? event : (window.event ? window.event : null);
                var uploadId = $(e).attr("id");
                var upattr = $(e).attr("uploadattr");
                if (!/\.(JPEG|jpeg|JPG|jpg|BMP|bmp|PNG|png|doc|docx|DOC|DOCX|xlsx|XLSX|xls|XLS|ppt|PPT|pptx|PPTX|txt|TXT|mpp|MPP|ZIP|zip|rar|RAR)$/.test($(e).val())) {
                    art.alert("请上传图片或文档类型附件！");
                    return false;
                }
                var fileTool = '';
                var url = '';
                if (uploadId == "fileToUpload1") {
                    fileTool = 'fileToUpload1';
                    $("#loading1").ajaxStart(function () {
                        $(this).show();
                    }).ajaxComplete(function () {
                        $(this).hide();
                    });
                }
                $.ajaxFileUpload(
                    {
                        url: '/SysMessage/EmailUpload.ashx',
                        secureuri: false,
                        fileElementId: fileTool,
                        dataType: 'json',
                        data: { action: upattr },
                        success: function (data, status) {
                            $("#HEmailFile").val("");
                            if (data.result) {
                                if (uploadId == "fileToUpload1") {
                                    $("#imgshow1>:first-child").attr("href", data.path);
                                    $("#imgshow1>:first-child").html(data.name);
                                    $("#HEmailFile").val(data.path);
                                    $("#fileToUpload1").on("change", function () {
                                        ajaxFileUpload($(this));
                                    })
                                }

                            } else {
                                layer.msg(data.desc);
                            }

                        },
                        error: function (data, status, e) {
                            layer.msg(e);
                        }
                    }
                )
            }

            var UrlDate = new GetUrlDate();
            $(function () {
                if (UrlDate.Type == "0") {
                    $(".repository_header_wrap").hide();
                }
                else {
                    $(".repository_header_wrap").show();
                }
            })
        </script>
    </form>
</body>
</html>
