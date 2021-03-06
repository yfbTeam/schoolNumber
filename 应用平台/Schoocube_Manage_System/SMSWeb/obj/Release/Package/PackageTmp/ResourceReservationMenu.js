﻿var UrlDate = new GetUrlDate();
function ResourceMenu() {
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
                $(json.result.retData).each(function (i,n) {
                    if (n.IsOwner == "0") {
                        //$("." + this.MenuCode).parent().remove();
                        //layer.msg("没有权限!");
                    } else {
                        if (location.toString().indexOf(this.Url) > 0) {
                            CurrentClass = " class='active'";
                            $("#HPId").val(n.Id);
                            ButtonList(n.Id);
                        }
                        else {
                            CurrentClass = "";
                        }
                        var li = "<li" + CurrentClass + "><a href=\"" + this.Url + "?ParentID=" + UrlDate.ParentID + "&PageName=" + n.Url + "\">" + n.Name + "</a></li> ";
                        $("#ResourceMenu").append(li);
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

function ButtonList(pid) {
    $.ajax({
        type: "Post",
        url: "/SystemSettings/CommonInfo.ashx",
        data: { Func: "GetLeftNavigationMenu", useridcard: $("#HUserIdCard").val(), Pid: pid },
        dataType: "json",
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                var HReservationName = "";
                var location = window.location.href;
                $(json.result.retData).each(function () {
                    if (this.Name == "审批" && this.IsOwner != "0") {
                        //$("#approvalreservation").css("display", "block");
                        //$("#myApprovalreservation").css("display", "none");
                        //$("#HApprovalreservation").attr("value", "审批");
                        $("#approvalreservation").css("display", "block");
                        $("#HApprovalreservation").attr("value", "审批");
                    }

                    if (this.Name == "修改" && this.IsOwner != "0") {
                        //$("#approvalreservation").css("display", "block");
                        //$("#myApprovalreservation").css("display", "none");
                        $("#HUpdateRecords").attr("value", "1");
                    }
                     
                });
            }
        },
        error: function (errMsg) {
            layer.msg('操作失败！');
        }
    });
}

