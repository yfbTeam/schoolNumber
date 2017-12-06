<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmailConrim.aspx.cs" Inherits="SMSWeb.PersonalSpace.EmailConrim" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>修改邮箱</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/onlinetest.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <link href="/Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="/Scripts/Common.js"></script>
    <script type="text/javascript">
        function CheckMail(mail) {
            var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/; if (filter.test(mail)) return true;
            else {
                alert('您的电子邮件格式不正确');
                return false;
            }
        }
        var UrlDate = new GetUrlDate();
        $(function () {
            $("#HUserIdCard").val(UrlDate.IdCard);
            $("#HUserName").val(UrlDate.Name);

            if (UrlDate.ConfirmID != undefined && UrlDate.ConfirmID != "") {
                $("#EmailC").hide();
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        PageName: "CourseManage/PersonSpaceStu.ashx",
                        Func: "GetEmailList",
                        ID: UrlDate.ConfirmID
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            var data = json.result.retData;

                            if (data[0].Isdelete == "0") {
                                EditEmail(data[0].RelationID, data[0].RelationMsg);
                            }
                            else { layer.msg("链接失效！"); }
                        }
                        else {
                            layer.msg("数据读取失败！");
                        }
                    },
                    error: function (errMsg) {

                    }
                });
            }
            else {
                $("#EmailC").show();

            }
        })
        function EditEmail(ID, Email) {
            $.ajax({
                url: "/SystemSettings/UserInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: true,
                dataType: "json",
                data: {
                    Func: "UpdateStudent", ID: ID, Email: Email
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("邮箱修改成功");
                        UpdateConrimEmail(UrlDate.ConfirmID);
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

        //发送邮件
        function sendMsg() {
            AddConrimEmail();
            if ($("#ID").val() != undefined && $("#ID").val() != "") {
                var timestamp = Date.parse(new Date());
                var ID = UrlDate.ID;
                var EmailID = $("#EmailID").val();
                var Contents = SeverUrl + "PersonalSpace/EmailConrim.aspx?ConfirmID=" + $("#ID").val();

                if (EmailID.length) {
                    var selArry = [];
                    var obj = new Object();
                    obj.Receiver = $("#HUserIdCard").val();
                    obj.ReceiverEmail = EmailID;
                    obj.ReceiverName = $("#HUserName").val();
                    selArry.push(obj);

                    $.ajax({
                        url: "/Common.ashx",
                        type: "post",
                        async: false,
                        dataType: "json",
                        data: {
                            PageName: "PortalManage/MessageHandler.ashx",
                            Func: "MoreSendMessage",
                            Title: "修改邮箱地址",
                            Receivers: JSON.stringify(selArry),
                            Creator: $("#HUserIdCard").val(),
                            CreatorName: $("#HUserName").val(),
                            Contents: Contents,
                            Timing: 0,
                            Type: 10,
                            isSendEmail: true
                        },
                        success: function (json) {
                            if (json.result.errNum.toString() == "0") {
                                layer.msg("邮件发送成功，点击链接修改邮件地址！");
                            }
                            else {
                                layer.msg("邮件发送失败！");
                            }
                        },
                        error: function (errMsg) {

                        }
                    });
                }
                else {
                    layer.msg("请输入邮箱账号");
                }
            }
        }
        function AddConrimEmail() {
            if (CheckMail($("#EmailID").val())) {
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        PageName: "CourseManage/PersonSpaceStu.ashx",
                        Func: "AddEmail",
                        Content: $("#EmailID").val(),// "http://192.168.1.101:8085//StudentHandler.ashx?func=UpdateStudent&SystemKey=xlf_self&InfKey=lhsfrz&ID=1&Email =" + $("#EmailID").val() 
                        RelationID: UrlDate.ID
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            $("#ID").val(json.result.retData);
                        }
                        else {
                            layer.msg("数据添加失败！");
                        }
                    },
                    error: function (errMsg) {

                    }
                });
            }
        }
        function UpdateConrimEmail(ID) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "CourseManage/PersonSpaceStu.ashx",
                    Func: "UpdateEmail",
                    ID: ID
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                    }
                    else {
                        layer.msg("数据添加失败！");
                    }
                },
                error: function (errMsg) {

                }
            });
        }
    </script>
</head>
<body>

    <form id="form2" enctype="multipart/form-data" method="post" runat="server">
        <input type="hidden" id="HUserIdCard" />
        <input type="hidden" id="HUserName" />
        <input type="hidden" id="ID" />
        <div style="background: #fff" id="EmailC">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">

                    <div class="clearfix">
                        <div class="course_form_div clearfix">
                            <label for="">邮箱账号：</label>
                            <input type="text" placeholder="新的邮箱账号" class="text" id="EmailID" value="" />
                            <i class="stars"></i>
                        </div>
                        <%--<div class="course_form_div clearfix">
                            <label for="">邮箱密码：</label>
                            <input type="text" placeholder="邮箱密码" class="text" id="EmailPwd" />
                            <i class="stars"></i>
                        </div>--%>


                        <div style="clear: both"></div>

                        <div class="course_form_select clearfix">
                            <a style="cursor: pointer;" class="course_btn confirm_btn" onclick="sendMsg()" id="btnCreate">确定</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>


</body>
</html>



