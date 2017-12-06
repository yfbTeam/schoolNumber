<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PhoneConrim.aspx.cs" Inherits="SMSWeb.PersonalSpace.PhoneConrim" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>修改手机号</title>
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
        function validatePhone(input) {
            var tel = $("#" + input).val();

            var reg = /^0?1[3|4|5|8][0-9]\d{8}$/;

            if (reg.test(tel)) {
                $("#Validate").val("true");
            } else {
                $("#" + input).focus();
                alert("请输入合法电话号码!");
                $("#Validate").val("false");
            };

        }
        var UrlDate = new GetUrlDate();
        function EditPhone() {
            validatePhone("PhoneNum");
            if ($("#Validate").val() == "true") {
                $.ajax({
                    url: "/SystemSettings/UserInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: true,
                    dataType: "json",
                    data: {
                        Func: "UpdateStudent", ID: UrlDate.ID, Phone: $("#PhoneNum").val()
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            parent.layer.msg('手机号码修改成功!');
                            parent.BindStuInfo();
                            parent.CloseIFrameWindow();

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
        }

    </script>
</head>
<body>

    <form id="form2" enctype="multipart/form-data" method="post" runat="server">
        <input type="hidden" id="Validate" />
        <input type="hidden" id="HUserIdCard" />
        <input type="hidden" id="HUserName" />
        <input type="hidden" id="ID" />
        <div style="background: #fff" id="EmailC">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">

                    <div class="clearfix">
                        <div class="course_form_div clearfix">
                            <label for="">手机号码：</label>
                            <input type="text" placeholder="新的手机号" class="text" id="PhoneNum" value="" />
                            <i class="stars"></i>
                        </div>
                        <%--<div class="course_form_div clearfix">
                            <label for="">邮箱密码：</label>
                            <input type="text" placeholder="邮箱密码" class="text" id="EmailPwd" />
                            <i class="stars"></i>
                        </div>--%>


                        <div style="clear: both"></div>

                        <div class="course_form_select clearfix">
                            <a style="cursor: pointer;" class="course_btn confirm_btn" onclick="EditPhone()" id="btnCreate">确定</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>


</body>
</html>