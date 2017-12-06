<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MessageView.aspx.cs" Inherits="SMSWeb.Portal.Message.MessageView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/onlinetest.css" rel="stylesheet" />
    <script src="//Scripts/jquery-1.11.2.min.js"></script>
    <script src="//Scripts/layer/layer.js"></script>
    <script src="//Scripts/bootstrap.min.js"></script>
    <script src="//Scripts/Common.js"></script>
</head>
<body>
    <form id="form1" runat="server">
         <input id="MsgId" runat="server" type="hidden" />
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                    <div class="course_form_div clearfix">
                            <label for="">标题：</label>
                            <input type="text" placeholder="标题" class="text" id="Title" value="" />
                            <i class="stars"></i>
                        </div>
                     <div class="course_form_div clearfix">
                            <label for="">内容：</label>
                            <input type="text" placeholder="内容" class="text" id="Contents" value="" />
                            <i class="stars"></i>
                        </div>
                     <div class="course_form_div clearfix">
                            <label for="">类型：</label>
                            <label id="Type"></label>
                            <i class="stars"></i>
                        </div>
                    <div class="course_form_div clearfix">
                            <label for="">发送时间：</label>
                            <label id="CreateTime"></label>
                            <i class="stars"></i>
                        </div>
                     <div class="course_form_div clearfix">
                            <label for="">发送人：</label>
                            <label id="Creator"></label>
                            <i class="stars"></i>
                        </div>
                    <div class="course_form_div clearfix">
                        <label for="">收件人：</label>
                        <label id="Receiver"></label>
                        <i class="stars"></i>
                    </div>
                    <div class="course_form_div clearfix">
                        <label for="">链接地址：</label>
                        <label id="Href"></label>
                        <i class="stars"></i>
                    </div>
                     <div class="course_form_div clearfix">
                        <label for="">状态：</label>
                        <label id="isSend"></label>
                        <i class="stars"></i>
                    </div>
                     <div class="course_form_div clearfix">
                        <label for="">收件邮箱：</label>
                        <label id="ReceiverEmail"></label>
                        <i class="stars"></i>
                    </div>

                    <div style="clear: both"></div>

                        <div class="course_form_select clearfix">
                            <a href="javscript:;" class="course_btn confirm_btn" onclick="javascript:history.go(-1)" id="btnCreate">返回</a>
                        </div>
                </div>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        $(function () {
            if ($("#MsgId").val().length > 0) initData($("#MsgId").val());
        })

        function initData(Id) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { PageName: "PortalManage/MessageHandler.ashx", Func: "GetMessage", Id: Id },
                success: function (json) {
                    if (json.result.errMsg.toString() == "success") {
                        var item = json.result.retData;
                        if (item != null) {
                            $("#Title").val(item.Title);
                            $("#Contents").val(item.Contents);
                            $("#Type").html(ShowNewsType((item.Type + "")));
                            $("#CreateTime").html(DateTimeConvert(item.CreateTime));
                            $("#Creator").html(item.Creator);
                            $("#Receiver").html(item.Receiver);
                            $("#Href").html(item.Href);
                            $("#isSend").html(showSend(item.isSend));
                            $("#ReceiverEmail").html(item.ReceiverEmail);
                        }
                    }
                },
                error: function (errMsg) {
                    layer.msg('查看失败！');
                    history.go(-1);
                }
            });
        }

        function showSend(isSend) {
            var msg = "";
            switch (isSend) {
                case 0:
                    msg = "未读";
                    break;

                case 1:
                    msg = "已读";
                    break;
            }
            return msg;
        }
    </script>
</body>
</html>
