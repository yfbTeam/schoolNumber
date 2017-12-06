function GetTerm() {
    var option = "";

    $.ajax({
        url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "json",
        data: { Func: "GetTerm" },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                $(json.result.retData).each(function () {
                    option += "<option value='" + this.Id+"'>" + this.Academic + '-' + this.Semester + "</option>";
                })
                //option += "</div>";
            }
            else {
                layer.msg(json.result.errMsg);
            }
            $("#StudyTerm").append(option);
        },
        error: function (errMsg) {
            layer.msg(errMsg);
        }
    });



}
function GetTermAndTime() {
    var option = "";

    $.ajax({
        url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
        type: "post",
        async: false,
        dataType: "json",
        data: { Func: "GetTerm" },
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                $(json.result.retData).each(function () {
                    option += "<option value='" + this.Id + "-" + this.SStartDate + "-" + this.SEndDate + "'>" + this.Academic + '-' + this.Semester + "</option>";
                })
                //option += "</div>";
            }
            else {
                layer.msg(json.result.errMsg);
            }
            $("#StudyTerm").append(option);
        },
        error: function (errMsg) {
            layer.msg(errMsg);
        }
    });

}

