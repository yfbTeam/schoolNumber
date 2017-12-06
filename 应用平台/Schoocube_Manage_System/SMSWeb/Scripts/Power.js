$(function () {
    var location = window.location.href;
    var num1 = location.lastIndexOf("/");
    var num2 = location.lastIndexOf(".");
    var location2 = location.substring(num1, num2)

    var i = 0;
    $.ajax({
        type: "Post",
        url: "/SystemSettings/CommonInfo.ashx",
        data: { Func: "GetLeftNavigationMenu", useridcard: $("#HUserIdCard").val() },
        dataType: "json",
        async: false,
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                var CurrentClass = "";
                $(json.result.retData).each(function () {
                    if (this.IsOwner > 0) {
                        if (location.toString().indexOf(this.Url) > 0 || location.replace(location2, "").indexOf(this.Url) > 0) {//this.Url
                            i++;
                        }
                    }
                });
            }
            if (i <= 0) {
                if (confirm("无权限访问,是否跳转登录页面")) {
                   // window.location.href = "/Login_hz.aspx";
                }
                else {
                    //window.location.href = "/NoPower.html";
                }
            }

        },
        error: function (errMsg) {
            //window.location.href = "/NoPower.html";
        }
    });
})