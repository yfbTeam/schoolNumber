<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="SMPortalsWeb.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>用户注册</title>
    <link href="/css/style.css" rel="stylesheet" />
    <link href="/css/common.css" rel="stylesheet" />
    <link href="/css/iconfont.css" rel="stylesheet" />
    <link href="/css/animate.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="Scripts/Validform_v5.3.1.js"></script>
    <style type="text/css">
        .registerform .need {
            width: 10px;
            color: #b20202;
        }
    </style>
</head>
<body>
    <form id="registerform" name="registerform" class="registerform" runat="server">
        <ul>
            <li> <label class="label">类型：</label>
                <input type="radio" name="uType" value="1" />教室<input type="radio" name="uType" value="0" checked />学生</li>
            <li>
                <label class="label"><span class="need">*</span>用户名：</label>
                <input type="text" id="LoginName" value="" name="LoginName" placeholder="请输入用户名" sucmsg="用户名验证通过！" ajaxurl="Handler/valid.ashx" datatype="*6-35" nullmsg="请输入用户名！" errormsg="用户名已存在请重新填写！" /></li>
            <li>
                <label class="label"><span class="need">*</span>用户密码：</label>
                <input type="password" value="" name="Password" id="Password" placeholder="请输入用户密码" datatype="*6-15" />
            </li>
            <li>
                <label class="label"><span class="need">*</span>确认密码：</label>
                <input type="password" value="" name="confirmPassword" placeholder="请再次输入用户密码" datatype="*" recheck="Password" errormsg="您两次输入的用户密码不一致！" />
            </li>
            <li>
                <label class="label"><span class="need">*</span>真实姓名：</label>
                <input type="text" id="Name" value="" name="Name" datatype="*" nullmsg="请输入真实姓名！" placeholder="真实姓名" />
            </li>
            <li>
                <label class="label"><span class="need">*</span>身份证件号：</label>
                <input type="text" id="IDCard" value="" name="IDCard" datatype="*" nullmsg="请输入身份证件号！" placeholder="身份证件号" />
            </li>
            <li class="liteacher">
                <label class="label">教师工号：</label>
                <input type="text" value="" name="JobNumber" id="JobNumber" placeholder="请输入教师工号" />
            </li>
            <li class="listudent">
                 <label class="label">学号：</label>
                <input type="text" value="" name="SchoolNO" id="SchoolNO" placeholder="请输入教师工号" />
            </li>
            <li>
                <label class="label">性别：</label>
                <input type="radio" name="sex" value="1" />男<input type="radio" name="sex" value="0" checked />女
            </li>
            <li>
                <label class="label">联系电话：</label>
                <input type="text" value="" name="Phone" id="Phone" placeholder="请输入联系电话" />
            </li>
            <li>
                <label class="label">系统：</label>
                <select id="SystemKey" name="SystemKey" datatype="*" nullmsg="请选择系统"></select>
            </li>
            <li>
                <label class="label">学校：</label>
                <select name="school" id="school" datatype="*" nullmsg="请选择学校"></select>
            </li>
            <li class="listudent">
                <label class="label">年级：</label>
                <select name="grade" id="grade" datatype="*" nullmsg="请选择年级"></select>
            </li>
            <li class="listudent">
                <label class="label">班级：</label>
                <select name="classs" id="classs" datatype="*" nullmsg="请选择班级"></select>
            </li>
            <li>
                <input class="Save_and_submit" type="button" value="提交" /><input class="cancel" type="reset" value="取消" />
            </li>
        </ul>
        <input name="action" value="register" type="hidden" />
        <input name="userType" id="userType" type="hidden" value="0" />
    </form>
    <script type="text/javascript">
        var systemArry = [];
        var schoolArry = [];

        var gradeArry = [];
        var classArry = [];

        $(document).ready(function () {
            var valiForm = $(".registerform").Validform({
                btnSubmit: ".Save_and_submit",
                btnReset: ".cancel",
                tiptype: 3,
                showAllError: true,
                beforeSubmit: function (curform) {
                    //在验证成功后，表单提交前执行的函数，curform参数是当前表单对象。
                    //这里明确return false的话表单将不会提交;	
                    //saveData();
                    validaNameAndIDCard();
                    return false;
                }
            })
            Array.prototype.contains = function (item) {
                var i = this.length;
                while (i--) {
                    if (this[i].guid === item) {
                        return true;
                    }
                }
                return false;
            };

            $("input[name='uType']").on("click", function () {
                var type = $("input[name='uType']:checked").val();

            });


            initSystemSelect();

            $("select[name='SystemKey']").change(function () {
                var selected_value = $(this).val();
                $("select[name='grade']").empty();
                $("select[name='classs']").empty();
                $("select[name='grade']")[0].options.add(new Option("请选择", ""));
                $("select[name='classs']")[0].options.add(new Option("请选择", ""));
                if (selected_value == "") {
                    $("select[name='school']").empty();
                    $("select[name='school']")[0].options.add(new Option("请选择", ""));
                    return;
                }
                $("select[name='school']").empty();
                for (var i = 0; i < systemArry.length; i++) {
                    if ($("#SystemKey").val() == systemArry[i].key) {
                        for (var j = 0; j < schoolArry.length; j++) {
                            if (schoolArry[j].SysKey == systemArry[i].key) {
                                if (j == 0) {
                                    changeGradeForSchool(schoolArry[j].key);
                                }
                                $("select[name='school']")[0].options.add(new Option(schoolArry[j].val, schoolArry[j].key));
                            }
                        }
                        break;
                    }
                }
                
            })

            $("select[name='school']").change(function () {
                var selected_value = $(this).val();
                $("select[name='grade']").empty();
                $("select[name='classs']").empty();
                $("select[name='grade']")[0].options.add(new Option("请选择", ""));
                $("select[name='classs']")[0].options.add(new Option("请选择", ""));
                if (selected_value == "") {

                    return;
                }
                changeGradeForSchool(selected_value);
            });


            $("select[name='grade']").change(function () {
                var selected_value = $(this).val();
                if (selected_value == "") {
                    $("select[name='classs']").empty();
                    $("select[name='classs']")[0].options.add(new Option("请选择", ""));
                    return;
                }
                $("select[name='classs']").empty();
                for (var i = 0; i < gradeArry.length; i++) {
                    if ($("#grade").val() == gradeArry[i].key) {
                        for (var j = 0; j < classArry.length; j++) {
                            if (classArry[j].GradeID == gradeArry[i].key && classArry[j].SchoolID == $("#school").val()) {
                                $("select[name='classs']")[0].options.add(new Option(classArry[j].val, classArry[j].key));
                            }
                        }
                        break;
                    }
                }
            });
        })

        function changeGradeForSchool(school_sel)
        {
            for (var i = 0; i < gradeArry.length; i++) {
                for (var j = 0; j < classArry.length; j++) {
                    if (gradeArry[i].key == classArry[j].GradeID && school_sel==classArry[j].SchoolID) {
                        $("select[name='classs']")[0].options.add(new Option(classArry[j].val, classArry[j].key));
                    }
                }
                $("select[name='grade']")[0].options.add(new Option(gradeArry[i].val, gradeArry[i].key));
            }
        }

        function initSystemSelect() {
            $("select[name='SystemKey']").empty();
            $("select[name='school']").empty();
            $("select[name='SystemKey']")[0].options.add(new Option("请选择", ""));
            $("select[name='school']")[0].options.add(new Option("请选择", ""));
            $.ajax({
                type: "Post",
                url:  "Handler/Common.ashx",
                //url: WebServiceUrl + "/InterfaceConfig/SystemHandler.ashx",//random" + Math.random(),//方法所在页面和方法名
                async: false,
                dataType: "json",
                //jsonp: "jsoncallback",
                data: {
                    "PageName":"InterfaceConfig/SystemHandler.ashx",
                    "SystemKey":$("#SystemKey").val(),
                    "func": "GetSystemAndSchoolBySysId"
                },
                success: function (json) {
                    if (json.result.status == "ok") {
                        var dtJson = $.parseJSON(json.result.retData);
                        if (dtJson != null) {
                            var arry = dtJson.data;
                            if (arry != null && arry.length > 0) {
                                for (var i = 0; i < arry.length; i++) {
                                    if (!systemArry.contains("_" + arry[i].SystemKey + "_")) {
                                        var select = new Object();
                                        select.key = arry[i].SystemKey;
                                        select.val = arry[i].SystemName;
                                        select.guid = "_" + arry[i].SystemKey + "_";
                                        systemArry.push(select);
                                    }
                                    var schselect = new Object();
                                    schselect.key = arry[i].SchoolId;
                                    schselect.val = arry[i].SchoolName;
                                    schselect.SysKey = arry[i].SystemKey;
                                    schoolArry.push(schselect);
                                }
                                for (var j = 0; j < systemArry.length; j++) {
                                    $("select[name='SystemKey']")[0].options.add(new Option(systemArry[j].val, systemArry[j].key));
                                }
                                initTeacheSelect();
                                //for (var k = 0; k < schoolArry.length; k++) {
                                //    $("select[name='school']")[0].options.add(new Option(schoolArry[k].val, schoolArry[k].key));
                                //}
                            }
                        }
                    } else if (json.result.status == "no") {
                        layer.msg(json.result.errMsg);
                        return;
                    }

                },
                error: OnError
            });
        }

        function initTeacheSelect()
        {
            $("select[name='grade']").empty();
            $("select[name='classs']").empty();
            $("select[name='grade']")[0].options.add(new Option("请选择", ""));
            $("select[name='classs']")[0].options.add(new Option("请选择", ""));
            $.ajax({
                type: "Post",
                url: "Handler/Common.ashx",
                //url: WebServiceUrl + "/InterfaceConfig/SystemHandler.ashx",//random" + Math.random(),//方法所在页面和方法名
                async: false,
                dataType: "json",
                //jsonp: "jsoncallback",
                data: {
                    "PageName": "RegisterHandler.ashx",
                    "GradeID": $("#grade").val(),
                    "SchoolID": $("#school").val(),
                    "func": "GetGradeAndClassById"
                },
                success: function (json) {
                    if (json.result.status == "ok") {
                        var dtJson = $.parseJSON(json.result.retData);
                        if (dtJson != null) {
                            var arry = dtJson.data;
                            if (arry != null && arry.length > 0) {
                                for (var i = 0; i < arry.length; i++) {
                                    if (!gradeArry.contains("_" + arry[i].GradeID + "_")) {
                                        var select = new Object();
                                        select.key = arry[i].GradeID;
                                        select.val = arry[i].GradeName;
                                        select.guid = "_" + arry[i].GradeID + "_";
                                        gradeArry.push(select);
                                    }
                                    var schselect = new Object();
                                    schselect.key = arry[i].ClassNO;
                                    schselect.val = arry[i].ClassName;
                                    schselect.GradeID = arry[i].GradeID;
                                    schselect.SchoolID = arry[i].SchoolID;
                                    classArry.push(schselect);
                                }
                                for (var j = 0; j < gradeArry.length; j++) {
                                    $("select[name='grade']")[0].options.add(new Option(gradeArry[j].val, gradeArry[j].key));
                                }
                                //for (var k = 0; k < schoolArry.length; k++) {
                                //    $("select[name='school']")[0].options.add(new Option(schoolArry[k].val, schoolArry[k].key));
                                //}
                            }
                        }
                    } else if (json.result.status == "no") {
                        layer.msg(json.result.errMsg);
                        return;
                    }

                },
                error: OnError
            });



        }

        function validaNameAndIDCard() {
            var name = $("#Name").val();
            var idCard = $("#IDCard").val();
            var type = $("#userType").val();
            $.ajax({
                type: "Post",
                url: "Handler/Common.ashx",
                //url: WebServiceUrl + "/RegisterHandler.ashx",//random" + Math.random(),//方法所在页面和方法名
                dataType: "json",
                //jsonp: "jsoncallback",
                data: {
                    "PageName": "RegisterHandler.ashx",
                    "Name": name,
                    "IDCard": idCard,
                    "func": "ValidataIsExist",
                    "UserType": type, "reader": "reader"
                },
                success: function (json) {
                    if (json.result.status == "no") {
                        saveData();
                    } else {
                        var info = json.result.retData;
                        if (info != null && info.length > 0) {
                            var dt = $.parseJSON(info[0]);
                        }

                    }
                },
                error: OnError
            });
        }

        function saveData() {
            var type = $("#userType").val();
            $.ajax({
                type: "Post",
                url: "Handler/Common.ashx",
                //url: WebServiceUrl + "/RegisterHandler.ashx",//random" + Math.random(),//方法所在页面和方法名
                async: false,
                dataType: "json",
                //jsonp: "jsoncallback",
                data: {
                    PageName: "RegisterHandler.ashx",
                    func: "register",
                    UserType: type,
                    LoginName: $("#LoginName").val(),
                    Password: $("#Password").val(),
                    Name: $("#Name").val(),
                    IDCard: $("#IDCard").val(),
                    SchoolID: $("#school").val(),
                    JobNumber: $("#JobNumber").val(),
                    Sex: $('input:radio[name=sex]:checked').val(),
                    Phone: $("#Phone").val(),
                    SystemKey: $("#SystemKey").val()
                },
                success: function (json) {
                    if (json.result.status == "error") {
                        //layer.msg(json.result.Msg);
                        return;
                    }
                    if (json.result.status == "no") {
                        layer.msg(json.result.Msg);
                        return;
                    }
                    if (json.result.status == "ok") {
                    }
                },
                error: OnError
            });
        }

    </script>
</body>
</html>
