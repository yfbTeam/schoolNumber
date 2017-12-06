<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsersMessage.aspx.cs" Inherits="SMSWeb.SysMessage.UsersMessage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>消息</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <style type="text/css">
        .messages_state ul li {
            border-bottom: 1px dotted #ccc;
            padding: 5px 0px;
            line-height: 20px;
            font-size: 15px;
            overflow: hidden;
        }

            .messages_state ul li input {
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
                width: 70%;
                text-overflow: ellipsis;
                overflow: hidden;
                white-space: nowrap;
            }

            .messages_state ul li .icon {
                width: 20px;
                height: 20px;
                float: left;
                margin-right: 10px;
                color: #ea5666;
            }

            .messages_state ul li.readed .icon {
                color: #999;
            }

            .messages_state ul li.readed a {
                color: #999;
            }

            .messages_state ul li.readed .messages_detail, .messages_state ul li.readed .catagory {
                color: #999;
            }

        .tips_bar {
            border-top: 1px solid #ccc;
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

        .messages_state ul li .messages_detail {
            padding-left: 58px;
            padding-right: 195px;
            margin-top: 10px;
            font-size: 14px;
            display: none;
            text-indent: 2em;
        }
    </style>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/js/common.js"></script>
    <script type="text/javascript">
        $(function () {
            $('.stytem_select_left a').on('click', function () {
                $(this).addClass('on').siblings().removeClass('on');
                var n = $(this).index();
                $('.messages_wrap>.messages_state').eq(n).show().siblings().hide();
            })
        })
    </script>
    <script id="tr_message" type="text/x-jquery-tmpl">
        {{if Status==0}}
            <li>{{else}}<li class="readed">{{/if}}
                        <input type="checkbox" name="cbkmessage" value="${Id}" onclick="checkItem(this)" />
                <i class="icon icon-envelope"></i>
                <a href="javascript:" msgid="${Id}" status="${Status}">
                    <span class="catagory">{{if Type==0}}[待批改作业]
                    {{else Type==1}}[待批试卷]
                    {{else Type==2}}[调查问卷]
                    {{else Type==3}}[资源审核]
                                {{else Type==4}}[学生报名]
                                {{else Type==5}}[学生考试]
                                {{else Type==6}}[学生任务]
                        {{else Type==7}}[邮件消息]
                        {{else Type==8}}[系统消息]
                        {{else Type==9}}[发布作业]
                        {{else Type==10}}[邮箱验证]
                    {{else}}[暂无]
                    {{/if}}
                    </span>
                    ${NameLengthUpdate(Title,30)}

                </a>
                <span class="fr date">${DateTimeConvert(CreateTime)}</span>
                <span class="fr" style="float: right; margin-right: 10px">发件人：${CreatorName}</span>
                <div class="messages_detail clearfix">
                    {{html Contents}}
                </div>
            </li>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="HUserIdCard" runat="server" />
        <header class="repository_header_wrap">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="HZ_Index.aspx">
                    <img src="/PortalImages/logoBefore.png" style="margin-top: 5px;" />

                </a>
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
                            <span onclick="logOut()">退出</span>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!--个人空间-->
        <div class="bordshadrad width" style="background: #fff; margin-top: 20px;">
            <div class="personal_spacea  clearfix " style="padding: 20px;">
                <div class="messages_wrap">
                    <div class="messages_state">
                        <div class="tips_bar">
                            <input type="checkbox" name="cbkAllmessage" class="Check_box" onclick="checkItem(this);" />
                            <input type="button" value="标记所选为已读" class="mark_readed" onclick="javascript: readerMessage('red');" />
                            <input type="button" value="删除所选" class="delete" onclick="javascript: readerMessage('del');" />
                        </div>
                        <ul id="tb_message">
                        </ul>
                        <div class="page">
                            <span id="pageBar"></span>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </form>
    <script src="/js/common.js"></script>
    <script type="text/javascript">
        var UrlDate = new GetUrlDate();
        $(function () {
            if (UrlDate.Type == "0") {
                $(".repository_header_wrap").hide();
            }
            else {
                $(".repository_header_wrap").show();
            }
            getData(1, 10);
            checkAll($('.messages_state input[type=checkbox]'));
            $('.messages_state ul li').children('a').on('click', function () {
                $(this).siblings('.messages_detail').slideToggle();
                $('.messages_state ul li').find('.messages_detail').not($(this).siblings('.messages_detail')).slideUp();
                $(this).parent('li').addClass('readed');
                var msgid = $(this).attr("msgid");
                var status = $(this).attr("status");
                if (msgid != "" && status == 0) {
                    UpdateMessage(msgid);
                }
            })
        })

        function getData(startIndex, pageSize) {
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/MessageHandler.ashx",
                    Func: "GetPageList",
                    Receiver: $("#HUserIdCard").val(),
                    PageIndex: startIndex,
                    pageSize: pageSize
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_message").html('');
                        $("#tr_message").tmpl(json.result.retData.PagedData).appendTo("#tb_message");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                    }
                    else {
                        $("#tb_message").html("<li>暂无消息！</li>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function readerMessage(param) {
            var messages = "";
            var optValDel = "";
            var optValStus = "";
            $("input[name='cbkmessage']").each(function () {
                if ($(this).is(':checked')) {
                    var vals = $(this).val();
                    messages += vals + ",";
                }
            });
            if (param == "del") {
                optValDel = 1;
            } else {
                optValStus = 1;
            }
            if (messages != "") {
                messages = messages.substring(0, messages.length - 1);
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { PageName: "PortalManage/MessageHandler.ashx", Func: "ReaderMessage", Ids: messages, IsDelete: optValDel, Status: optValStus, Receiver: $("#HUserIdCard").val() },
                    success: function (json) {
                        if (json.result.errMsg.toString() == "success") {
                            layer.msg('更新成功！');
                        }
                        getData(1, 10);
                    },
                    error: function (errMsg) {
                        layer.msg('更新失败！');
                    }
                });
            }
        }

        function UpdateMessage(id) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { PageName: "PortalManage/MessageHandler.ashx", Func: "UpdateMessage", Id: id, Status: 1 },
                success: function (json) {

                },
                error: function (errMsg) {

                }
            });
        }

        //function checkItem(obj) {
        //    var checkArry = $(".messages_state").find("input[type='checkbox']");
        //    checkAll(checkArry);
        //}

        //function checkAll(oInput) {
        //    var isCheckAll = function () {
        //        for (var i = 1, n = 0; i < oInput.length; i++) {
        //            oInput[i].checked && n++
        //        }
        //        oInput[0].checked = n == oInput.length - 1;
        //    };
        //    //全选
        //    oInput[0].onchange = function () {
        //        for (var i = 1; i < oInput.length; i++) {
        //            oInput[i].checked = this.checked
        //        }
        //        isCheckAll()
        //    };
        //    //根据复选个数更新全选框状态
        //    for (var i = 1; i < oInput.length; i++) {
        //        oInput[i].onchange = function () {
        //            isCheckAll()
        //        }
        //    }
        //}
    </script>


</body>
</html>
