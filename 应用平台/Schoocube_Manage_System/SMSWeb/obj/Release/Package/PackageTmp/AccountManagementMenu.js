var UrlDate = new GetUrlDate();
function AccountMenu() {
    $.ajax({
        type: "Post",
        url: "/SystemSettings/CommonInfo.ashx",
        data: { Func: "GetLeftNavigationMenu", useridcard: $("#HUserIdCard").val(), Pid: UrlDate.ParentID, PageName: UrlDate.PageName },
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
                        if (location.toString().indexOf(this.Url) > 0) {
                            CurrentClass = " class='active'";
                            $("#HPId").val(n.Id);
                            //ButtonList(n.Id);
                        }
                        else {
                            CurrentClass = "";
                        }
                        var li = "<li" + CurrentClass + "><a href=\"" + this.Url + "?ParentID=" + UrlDate.ParentID + "&PageName=" + n.Url + "\">" + n.Name + "</a></li> ";
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

