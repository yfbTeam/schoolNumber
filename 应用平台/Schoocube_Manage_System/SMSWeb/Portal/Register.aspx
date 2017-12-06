<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="SMSWeb.Portal.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>用户注册</title>
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/PortalCss/layout.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <script src="/Scripts/Validform_v5.3.1.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
</head>
<body style="background: #fff;">
    <form id="registerform" name="registerform" class="registerform" runat="server">
        <!--leftnav-->
        <div class="content" style="width: auto;">
            <div class="clearfix" style="width: 483px; margin: 0 auto;">
                <div class="course_form_div clearfix">
                    <label for="">姓名：</label>
                    <input type="text" placeholder="姓名" class="text" id="Name" value="" datatype="*" nullmsg="请输入真实姓名！" />
                </div>
                <div class="course_form_div clearfix">
                    <label for="">昵称：</label>
                    <input type="text" placeholder="昵称" class="text" id="Nickname" value="" />
                </div>
                <div class="course_form_div clearfix">
                    <label for="">身份证号：</label>
                    <input type="text" placeholder="身份证号" class="text" id="IDCard" value="" datatype="*" nullmsg="请输入身份证号！" />
                </div>

                <div class="course_form_div clearfix">
                    <label for="">登录账号：</label>
                    <input type="text" placeholder="登录账号" class="text" id="LoginName" value="" datatype="*6-35" nullmsg="请输入登录账号！" />
                </div>

                <div class="course_form_div clearfix">
                    <label for="">登录密码：</label>
                    <input type="password" placeholder="登录密码" class="text" id="Password" name="Password" value="" datatype="*6-15" errormsg="密码范围在6~15位之间！" />
                </div>
                <div class="course_form_div clearfix">
                    <label for="">确认密码：</label>
                    <input type="password" placeholder="确认密码" class="text" name="confirmPassword" value="" datatype="*" recheck="Password" errormsg="您两次输入的用户密码不一致！" />
                </div>

                <%--    <div class="course_form_div clearfix">
                        <label for="">学校：</label>
                        <input type="text" placeholder="学校" class="text" id="sel_school" value="" />
                        <i class="stars"></i>
                    </div>--%>

                <%--                    <div class="course_form_div clearfix">
                        <label for="">学号：</label>
                        <input type="text" placeholder="学号" class="text" id="SchoolNO" value="" />
                        <i class="stars"></i>
                    </div>--%>

                <div class="course_form_div clearfix">
                    <label for="">性别：</label>
                    <input type="radio" id="Sex1" name="Sex" value="男" checked="checked" />男
                                                <input type="radio" id="Sex2" name="Sex" value="女" />女
                </div>

                <%--<div class="course_form_div clearfix">
                        <label for="">照片：</label>
                        <input type="text" placeholder="照片" class="text" id="Photo" value="" />
                        <i class="stars"></i>
                    </div>--%>
                <div class="course_form_div clearfix">
                    <label for="">邮箱：</label>
                    <input type="text" placeholder="邮箱" class="text" id="Email" value=""  datatype="e"/>
                </div>
                <div class="course_form_div clearfix">
                    <label for="">现住址：</label>
                    <input type="text" placeholder="现住址" class="text" id="Address" value="" />
                </div>
                <div class="course_form_div clearfix">
                    <label for="">联系电话：</label>
                    <input type="text" placeholder="联系电话" class="text" id="Phone" value=""  datatype="n6-16"/>
                </div>

                <div class="course_form_div clearfix">
                    <div style="margin-left:60px;">
                        <input type="checkbox" name="name" value="" datatype="*" nullmsg="请同意用户协议"  />
                        <a href="javascript:parent.hrefPage()" target="_blank">你同意用户协议</a>
                    </div>
                </div>
                <div class="course_form_select clearfix" style="padding-bottom:10px;">
                    <input type="button" class="course_btn confirm_btn ml10" id="btnCreate" value="确定" />
                    <input type="reset" class="course_btn quxiao_btn ml10" id="btnClear" value="取消" />
                </div>
                
            </div>
        </div>
        <input type="hidden" id="State" value="禁用" />
    </form>
    <script type="text/javascript">
        var isEdit = false;
        $(document).ready(function () {
            var valiForm = $(".registerform").Validform({
                btnSubmit: "#btnCreate",
                btnReset: "#btnClear",
                tiptype: 3,
                showAllError: true,
                beforeSubmit: function (curform) {
                    //在验证成功后，表单提交前执行的函数，curform参数是当前表单对象。
                    //这里明确return false的话表单将不会提交;	
                    //saveData();
                    saveData();
                }
            })

            $("#Name,#IDCard").on("keydown keyup", function () {
                $.ajax({
                    url: "/SystemSettings/CommonInfo.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        func: "ValidationUserByIDCardAndName",
                        IDCard: $("#IDCard").val(),
                        Name: $("#Name").val()
                    },
                    success: function (json) {
                        if (json.result.errNum==0) {
                            var items = json.result.retData;
                            if (items!=null && items.length>0) {
                                var item = items[0];
                                $("#LoginName").val(item.LoginName);
                                $("#Nickname").val(item.Nickname);
                                var sex = item.Sex == 1 ? "女" : "男";
                                $("input[name='Sex'][value=" + sex + "]").attr("checked", true);
                                $("#Email").val(item.Email);
                                $("#Address").val(item.Address);
                                $("#Phone").val(item.Phone);
                                $("#Name").attr("disabled",true);
                                $("#IDCard").attr("disabled", true);
                                
                                isEdit = true;
                            }
                        }
                        
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                       
                    }
                });
            })
        });


        function saveData() {
            var Name = $("#Name").val().trim();
            var Nickname = $("#Nickname").val().trim();
            var IDCard = $("#IDCard").val().trim();
            var LoginName = $("#LoginName").val().trim();
            //var SchoolID = $("#sel_school option:selected").val();
            //var State = $("#State").val() == "启用" ? 0 : 1;
            //var SchoolNO = $("#SchoolNO").val().trim();
            var Sex = $("input:radio[name='Sex']:checked").val();
            //var Birthday = $("#Birthday").val().trim();
            var Phone = $("#Phone").val().trim();
            var Address = $("#Address").val().trim();
            var Email = $("#Email").val().trim();
            //var Remarks = $("#Remarks").val().trim();
            var Password = $("#Password").val().trim() == "123456" ? "" : $("#Password").val().trim();
            if (isEdit) {
                $.ajax({
                    url: "/SystemSettings/CommonInfo.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        func: "RegisterUpdateStudent",
                        IDCard: IDCard,
                        LoginName: LoginName,
                        Sex: Sex,
                        Phone: Phone,
                        Address: Address,
                        Password: Password,
                        Nickname: Nickname,
                        Email: Email
                    },
                    success: function (json) {
                        var result = json.result;
                        if (result.errNum == -1) {
                            layer.msg(result.errMsg);
                        }
                        else if (result.errNum == 0) {
                            layer.msg('操作成功!');
                            logInUser(LoginName, Password);
                            //$.cookie('PwdCookie_Cube', $("#Password").val());
                            //parent.CloseIFrameWindow();
                        } else {
                            layer.msg("操作失败！");
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        layer.msg("操作失败！");
                    }
                });
            } else {
                $.ajax({
                    url: "/SystemSettings/CommonInfo.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        func: "AddStudent",
                        Name: Name,
                        Nickname: Nickname,
                        IDCard: IDCard,
                        LoginName: LoginName,
                        Sex: Sex,
                        Phone: Phone,
                        Address: Address,
                        Password: Password,
                        Email: Email
                    },
                    success: function (json) {
                        var result = json.result;
                        if (result.errMsg == -1) {
                            layer.msg(result.errMsg);
                        }
                        else if (result.errNum == 0) {
                            layer.msg('操作成功!');
                            logInUser(LoginName, Password);
                        } else {
                            layer.msg("操作失败！");
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        layer.msg("操作失败！");
                    }
                });
            }
            
        }

        function logInUser(loginName, passWord)
        {
            $.ajax({
                url: "/SystemSettings/UserInfo.ashx",
                async: false,
                dataType: "json",
                data: { "Func": "Login", "loginName": loginName, "passWord": passWord },
                success: OnSuccessLogin,
                error: OnErrorLogin
            });
        }

        function OnSuccessLogin(json) {
            var cookie = json.result;
            if (cookie.errNum == "0") {
                $.cookie('LoginCookie_Cube', JSON.stringify(cookie.retData[0]), { path: '/', secure: false });
                $.cookie('PwdCookie_Cube', $("#txt_passWord").val(), { path: '/', secure: false });
                addMonnitor(5, '', '登录', 0, cookie.retData[0].Name, cookie.retData[0].IDCard);
            } else {
                layer.msg(json.result.errMsg + "！");
            }
            parent.window.location = "/Portal/index.aspx";
            parent.CloseIFrameWindow();
        }

        function OnErrorLogin(XMLHttpRequest, textStatus, errorThrown) {
            layer.msg("登录名或密码错误！" + errorThrown);
        }
    </script>

</body>
</html>
