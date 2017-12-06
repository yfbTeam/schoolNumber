var UrlDate = new GetUrlDate();
function AccountMenu() {
    var location = window.location.href;
    var num1 = location.lastIndexOf("/");
    var num2 = location.lastIndexOf(".");
    var Pid = location.substring(num1 + 1, num2)
    var ReplaceUrl = location.substring(num1, num2)

    $.ajax({
        type: "Post",
        url: "/SystemSettings/CommonInfo.ashx",
        data: { Func: "GetLeftNavigationMenu", useridcard: $("#HUserIdCard").val(), Pid: Pid },
        dataType: "json",
        async: false,
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                var CurrentClass = "";
                var location = window.location.href;
                $(json.result.retData).each(function (i, n) {
                    if (n.IsOwner == "0") {
                        //$("." + this.MenuCode).parent().remove();
                    } else {
                        if (location.toString().indexOf(this.Url) > 0 || location.replace(ReplaceUrl, "").indexOf(this.Url) > 0) {
                            //if (location.toString().indexOf(this.Url) > 0) {
                            CurrentClass = " class='active'";
                            $("#HPId").val(n.Id);
                            //ButtonList(n.Id);
                        }
                        else {
                            CurrentClass = "";
                        }
                        var url = this.Url.replace(".aspx", "/") + Pid + ".aspx";

                        var li = "<li" + CurrentClass + "><a href=\"" + url + "\">" + this.Name + "</a></li> ";
                        $("#AccountMenu").append(li);
                    }

                });
                // layer.msg(json);
            }
        },
        error: function (errMsg) {
            layer.msg('操作失败！');
        }
    });
}

