$(function () {
    initAddVisitRecord();
})



function initAddVisitRecord() {
    var ic = "";
    var UserName = "-1";
    var cookie = {};
    cookie.set = function (n, v, t) {
        var exp = new Date();
        exp.setTime(exp.getTime() + (t || 24) * 60 * 60 * 1000);
        document.cookie = n + "=" + escape(v) + ";expires=" + exp.toGMTString() + ';domain=' + document.domain + ';path=/';
    };
    cookie.get = function (n) {
        var arr = document.cookie.match(new RegExp("(^| )" + n + "=([^;]*)(;|$)"));
        if (arr != null) return unescape(arr[2]);
        return null;
    };
    if (cookie.get('MONITORID') == 'undefined' || cookie.get('MONITORID') == null) {
        ic = NewGuid().ToString("N");
        cookie.set('MONITORID', ic);
    }
    if (ic && ic.length == 32) {
        ic = ic.substr(0, 30);
    }
    else {
        ic = cookie.get('MONITORID').substr(0, 30);
    }
    if ($.cookie('LoginCookie_Cube') != null && $.cookie('LoginCookie_Cube') != "null" && $.cookie('LoginCookie_Cube') != "") {
        var info = $.parseJSON($.cookie('LoginCookie_Cube'));
        if (info != null) UserName = info.Name;
    }
    var user_agent = navigator.userAgent;
    var Url = window.location.href;
    $.ajax({
        url: "/Common.ashx",
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "PortalManage/MonitorRecordHandler.ashx",
            Func: "EditVisitRest",
            UserName: UserName,
            user_agent: user_agent,
            icookie: ic,
            Url: Url
        },
        success: function (json) {
            if (json.result.errMsg) {

            }
        },
        error: function (errMsg) {

        }
    });

}

function NewGuid() {
    var g = "";
    var i = 32;
    while (i--) {
        g += Math.floor(Math.random() * 16.0).toString(16);
    }
    return new Guid(g);
}
function Guid(g) {
    var arr = new Array();    // 存放32位数值的数组
    if (typeof (g) == "string") {    // 如果构造函数的参数为字符串
        InitByString(arr, g);
    }
    else {
        InitByOther(arr);
    }
    // 返回一个值，该值指示 Guid 的两个实例是否表示同一个值。
    this.Equals = function (o) {
        if (o && o.IsGuid) {
            return this.ToString() == o.ToString();
        }
        else {
            return false;
        }
    };
    // Guid对象的标记
    this.IsGuid = function () { };
    // 返回 Guid 类的此实例值的 String 表示形式。
    this.ToString = function (format) {
        if (typeof (format) == "string") {
            if (format == "N" || format == "D" || format == "B" || format == "P") {
                return ToStringWithFormat(arr, format);
            }
            else {
                return ToStringWithFormat(arr, "D");
            }
        }
        else {
            return ToStringWithFormat(arr, "D");
        }
    };
    // 由字符串加载
    function InitByString(arr, g) {
        g = g.replace(/\{|\(|\)|\}|-/g, "");
        g = g.toLowerCase();
        if (g.length != 32 || g.search(/[^0-9,a-f]/i) != -1) {
            InitByOther(arr);
        }
        else {
            for (var i = 0; i < g.length; i++) {
                arr.push(g.charAt(i));
            }
        }
    }
    // 由其他类型加载
    function InitByOther(arr) {
        var i = 32;
        while (i--) {
            arr.push("0");
        }
    }
    /*
    根据所提供的格式说明符，返回此 Guid 实例值的 String 表示形式。
    N  32 位： xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    D  由连字符分隔的 32 位数字 xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    B  括在大括号中、由连字符分隔的 32 位数字：{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
    P  括在圆括号中、由连字符分隔的 32 位数字：(xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
    */
    function ToStringWithFormat(arr, format) {
        switch (format) {
            case "N":
                return arr.toString().replace(/,/g, "");
            case "D":
                var str = arr.slice(0, 8) + "-" + arr.slice(8, 12) + "-" + arr.slice(12, 16) + "-" + arr.slice(16, 20) + "-" + arr.slice(20, 32);
                str = str.replace(/,/g, "");
                return str;
            case "B":
                var str = ToStringWithFormat(arr, "D");
                str = "{" + str + "}";
                return str;
            case "P":
                var str = ToStringWithFormat(arr, "D");
                str = "(" + str + ")";
                return str;
            default:
                return new Guid();
        }
    }
};
