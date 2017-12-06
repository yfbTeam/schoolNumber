var UrlDate = new GetUrlDate();

function CourceMenu() {
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
                $(json.result.retData).each(function () {
                    if (this.IsOwner >0) {

                        if (location.toString().indexOf(this.Url) > 0) {
                            CurrentClass = " class='active'";
                            $("#HPId").val(this.Id);
                            //ButtonList(this.Id);
                        }
                        else {
                            CurrentClass = "";
                        }
                        var li = "<li" + CurrentClass + "><a href=\"" + this.Url + "?ParentID=" + UrlDate.ParentID + "&PageName=" + this.Url + "\">" + this.Name + "</a></li> ";
                        $("#CourceMenu").append(li);
                    }
                });
            }
        },
        error: function (errMsg) {
            layer.msg('操作失败！');
        }
    });
}

    function ButtonList(pid) {
        $.ajax({
            type: "Post",
            url: "/SystemSettings/CommonInfo.ashx",
            data: { Func: "GetLeftNavigationMenu", useridcard: $("#HUserIdCard").val(), Pid: pid },
            dataType: "json",
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    var ButtonCode = "";
                    var location = window.location.href;
                    $(json.result.retData).each(function () {
                        if (this.IsOwner == "0") {
                            if (this.MenuCode.toString() != "") {
                                $("." + this.MenuCode).parent().remove();
                            }
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

