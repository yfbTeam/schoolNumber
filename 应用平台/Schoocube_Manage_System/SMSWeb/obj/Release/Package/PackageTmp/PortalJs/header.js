$(function () {
    $.ajax({
        type: "Post",
        url: "/Common.ashx",
        async: false,
        dataType: "json",
        data: {
            "PageName": "PortalManage/AdminManager.ashx",
            "func": "GetBeforeMenu",
            "IsDelete": 0,
            "Display": 0,
            "BeforeAfter": 0
        },
        success: function (json) {
            if (json.result.errMsg == "success") {
                $("#menuList").html("");
                $("#menuList").html(json.result.retData);
                $('.xiala').hover(function () {
                    $(this).find('dt').addClass('hover');
                    $(this).find(".lie").show();
                }, function () {
                    $(this).find('dt').removeClass('hover');
                    $(this).find(".lie").hide();
                })
            }
        },
        error: OnError
    });
})

function redirect() {
    window.location.href = "/Portal/index.aspx";
}

function ResponstUrl(url) {
    window.location.href = url;
}
