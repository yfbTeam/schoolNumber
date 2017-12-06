
var speed = 1000;
var wait = 120;


$(document).ready(function () {
    $("input[id^='txt']").click(function () {
        $("#div_errmsg").hide();
    });


});

function getEmailVerify() {

    var email = $.trim($("#txtEmail").val());
    if (!isEmail(email)) {
        $("#div_errmsg").fadeOut(200).fadeIn(200).fadeOut(200).fadeIn(200);
        $("#span_errmsg").html("请输入正确的Email");
        return;
    }

    $("#btnsendemail").attr("disabled", true);
    jQuery.post(
                        "/Ashx/LoginHandle.ashx",
                        {
                            ajaxmethod: "sendemailcode",
                            email: email,
                            VerifyCode: $.trim($("#txtCode").val())
                        },
                        function (data) {
                            if (data == -1) {
                                $.jBox.info("请输入正确的Email");
                            }
                            else if (data == 1) {
                                $.jBox.tip("Email发送成功,请注意查收。");
                                $("#btnsendemail").attr("disabled", true);
                            } else if (data == 2) {
                                $.jBox.tip("验证码错误，请重新输入！");
                                $("#btnsendemail").attr("disabled", false);
                                $("#imgVerifyCode").click();
                            } else {
                                $.jBox.tip("发送Email错误，请稍候再试。谢谢。");
                            }
                        },
                        "json"
                    );
}


function getOrderVerify() {
    var phone = $.trim($("#txtPhone").val());
    if (!isPhone(phone)) {
        $.jBox.info("请输入正确的手机号码");
        return;
    }
    $("#btnsendsms").attr("disabled", true);
    getCode(phone);
}


function getVerify() {

    var phone = $.trim($("#txtPhone").val());
    if (!isPhone(phone)) {
        $("#div_errmsg").fadeOut(200).fadeIn(200).fadeOut(200).fadeIn(200);
        $("#span_errmsg").html("请输入正确的手机号码");
        return;
    }

    $("#btnsendsms").attr("disabled", true);
    getCode(phone);
}


function getCode(phone) {
    phone = RemoveHtmlTag(phone);
    jQuery.post(
                      "/Ashx/LoginHandle.ashx",
                      {
                          ajaxmethod: "sendsmscode",
                          phone: phone,
                          VerifyCode: $.trim($("#txtCode").val())
                      },
                      function (data) {
                          if (data == 1) {
                              wait = 120;
                              waitReSend();
                          } else if (data == 2) {
                              //$("#div_errmsg").fadeOut(200).fadeIn(200).fadeOut(200).fadeIn(200);
                              //$("#span_errmsg").html("验证码错误");
                              $.jBox.info("验证码错误");
                              $("#btnsendsms").attr("disabled", false);
                              $("#imgVerifyCode").click();
                          }
                          else {
                              $.jBox.tip("发送短信错误，请稍候再试。谢谢。");
                          }
                      },
                      "json"
                  );
}

function getSmSCode(phone) {
    phone = RemoveHtmlTag(phone);
    $("#btnsendsms").attr("disabled", true);
    jQuery.post(
                      "/Ashx/LoginHandle.ashx",
                      {
                          ajaxmethod: "SendSMSCodeNoVerifyCode",
                          phone: phone
                      },
                      function (data) {
                          if (data == 1) {
                              wait = 120;
                              waitReSend();
                          } else {
                              $.jBox.tip("发送短信错误，请稍候再试。谢谢。");
                          }
                      },
                      "json"
                  );
}

// 倒计时
function waitReSend(txt) {
    if (wait == 0) {
        if (txt) {
            $("#btnsendsms").val(txt);
        } else {
            $("#btnsendsms").val("获取激活码");
        }
        $("#btnsendsms").attr("disabled", false);
    }
    else {
        //if (wait <= 30) { // 防止30秒还未收到短信，提示51liucheng 可以登录
        //    //console.log(wait);
        //    $("#span_1orangeinfo").show();
        //}
        $("#btnsendsms").val("重发(" + wait + ")");
        wait--;
        window.setTimeout("waitReSend()", speed);
    }
}


// 切换类型
function switchVerifyMethod(a) {
    $("input[type='text']").each(function () {
        $(this).attr("value", "");
    });//切换即清空所有输入框内容
    $("#div_normal_name").hide(); //input
    $("#div_phone_num").hide();
    $("#p_btnPhone").hide(); // 验证码按钮
    $("#p_btnEmail").hide();
    $("#vr1").next().attr("class", ""); //样式
    $("#vr2").next().attr("class", "");
    $("#btnsendsms").hide();
    if (a == 1) { //phone
        $("#vr1").next().attr("class", "active");
        $("#div_phone_num").show();
        $("#p_btnPhone").show();
        $("#txtVerifyCode").attr("placeholder", "请输入获取的激活码");
        $("#btnsendsms").show();
        $("#forgetPwd").hide();
    } else {
        $("#vr2").next().attr("class", "active");
        $("#div_normal_name").show();
        $("#p_btnEmail").show();
        $("#txtVerifyCode").attr("placeholder", "请输入密码");
        $("#forgetPwd").show();
    }
    if ($("#hid_pagetype").val() == "reg")
        $("#txtVerifyCode").attr("placeholder", "");

    $("#div_errmsg").hide();
    $("#span_errmsg").html("");
}



// 弹出登录对话框 参数1： 完整的方法调用名  参数2：用于注册后的ReturnUrl
function LoginDialog(methodName, returnUrl) {
    jQuery.post(
           "/Ashx/LoginHandle.ashx",
           {
               ajaxmethod: "islogin"
           },
           function (data) {
               if (data.IsLogin) {
                   try {
                       if (methodName != "") {
                           setTimeout(methodName, 0);
                       }
                   } catch (e) {
                   }
               } else {
                   var jBoxConfig = {};
                   jBoxConfig.defaults = {
                       border: 0,
                       draggable: false,
                       top: '20%',
                       buttons: {}
                   };
                   $.jBox.setDefaults(jBoxConfig);

                   var html = "<div style='width:400px;'><span id='info'></span><input type=\"hidden\" id=\"hid_Method\" value=\"" + methodName + "\"/><input type=\"hidden\" id=\"hid_returnUrl\" value=\"" + returnUrl + "\"/></div>";
                   var submit = function (v, h, f) {

                   };

                   $.jBox(html, { title: "登录", submit: submit });
                   $('div.jbox-title-panel').hide();
                   $("#info").load("/Template/LoginDialog.html");
               }
           },
           "json"
       );
}


// <a>我的订单</a><a>我的申请</a><a href="javascript:void(0);" onclick="LoginDialog();">登陆|注册</a><a>帮助中心</a><br />
function CheckLogin() {
    var html = "";
    try {
        jQuery.post(
               "/Ashx/LoginHandle.ashx",
               {
                   ajaxmethod: "islogin"
               },
               function (data) {
                   if (data.IsLogin) {
                       html += "&nbsp;&nbsp;欢迎您：" + data.UserId + "<a href=\"/Logout.aspx\" title=\"退出\">&nbsp;退出</a>&nbsp;";
                   } else {
                       html += "<a href=\"" + data.href + "/Login.aspx\" title=\"登录\"><span>登录</span></a>&nbsp;|&nbsp;<a href=\"" + data.href + "/Reg.aspx\" title=\"注册\">注册</a>";
                   }
                   $("#span_headlogin").html(html);
               },
               "json"
           );
    } catch (e) {
        html = "<a href=\"/Login.aspx\" title=\"登录\"><span>登录</span></a><a href=\"/Reg.aspx\" title=\"注册\">注册</a>";
        $("#span_headlogin").html(html);
    }

}



// 如页面刷新 则重新加载倒计时
jQuery.post(
        "/Ashx/LoginHandle.ashx",
        {
            ajaxmethod: "getremaintime"
        },
        function (data) {
            if (data.Time > 0) {
                $("#btnsendsms").attr("disabled", true);
                wait = data.Time;
            }
            else {
                wait = 0;
            }
            waitReSend($("#btnsendsms").val());
        },
        "json"
    );



if ($("#vr1").is(":checked")) {
    switchVerifyMethod(1);
} else if ($("#vr2").is(":checked")) {
    switchVerifyMethod(2);
}


