<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourceCheck.aspx.cs" Inherits="SMSWeb.CourseManage.CourceCheck" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>创建课程</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/onlinetest.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/Power.js"></script>
    <%--<style type="text/css">
        .course_form_div .text {
            float: left;
            height: 26px;
            border: 0;
            border-radius: 2px;
            width: 178px;
            padding-left: 0;
        }
    </style>--%>
</head>
<body>
    <input type="hidden" id="HStuIDCard" value="" runat="server" />
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />
    <input type="hidden" id="HClassID" runat="server" />

    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <!--创建课程dialog-->
        <div style="background: #fff">

            <div class="newcourse_dialog_detail">
                <div class="clearfix pr">
                    <div class="course_form_div">
                        <label for="">课程名称：</label>
                        <input type="text" placeholder="" class="text" id="CourceName" />

                    </div>
                    <div class="course_form_select fl">
                        <label for="">所属学科：</label>

                        <select class="select" id="Subject" onchange="Textbook()">
                        </select>

                    </div>
                    <div style="clear: both"></div>
                    <div class="course_form_select fl">
                        <label for="">使用教材：</label>
                        <select class="select" id="Textbook">
                        </select>

                    </div>
                    <div class="course_form_img">
                        <img id="img_Pic" alt="" src="" />
                    </div>
                </div>
                <div class="clearfix">
                    <div class="course_form_select fl">
                        <label for="">学年学期：</label>
                        <select class="select" id="StudyTerm">
                        </select>

                    </div>
                    <div class="course_form_select fr">
                        <label for="">课程类型：</label>
                        <select class="select" id="CourceType">
                            <option value="1">必修课</option>
                            <option value="2">选修课</option>
                        </select>

                    </div>
                    <div class="course_form_select fl">
                        <label for="">学生年级：</label>
                        <select id="Grade" onchange="GradSelChange()">
                        </select>
                    </div>
                    <div class="course_form_select fr">
                        <label for="">上课周：</label>
                        <select id="WeekName">
                            <option value="1">周一</option>
                            <option value="2">周二</option>
                            <option value="3">周三</option>
                            <option value="4">周四</option>
                            <option value="5">周五</option>
                            <option value="6">周六</option>
                            <option value="7">周日</option>

                        </select>

                    </div>
                    <div style="clear: both;"></div>
                    <div class="course_form_select clearfix">
                        <label for="">学生班级：</label>
                        <div id="Class">
                        </div>
                    </div>
                    <div class="clearfix">
                        <div class="course_form_div fl">
                            <label for="">人数限制：</label>
                            <input type="text" placeholder="" class="text" id="StuMaxCount" value="0" />

                        </div>
                        <div class="course_form_div fr">
                            <label for="">上课地点：</label>
                            <input type="text" placeholder="" class="text" id="StudyPlace" />

                        </div>
                        <div class="course_form_select fl" id="IsCharge">
                            <label for="">是否收费：</label>
                            <input type="radio" name="ChargeRadio" id="" value="1" />
                            <label for="">收费</label>
                            <input type="radio" name="ChargeRadio" id="" value="0" checked="checked" />
                            <label for="">免费</label>
                        </div>
                        <div class="course_form_div fr">
                            <label for="">课程费用：</label>
                            <input type="text" placeholder="" class="text" value="0" id="CoursePrice" />

                        </div>
                        <div style="clear: both"></div>
                        <div class="course_form_select">
                            <label for="">课程简介：</label>
                            <textarea name="" rows="" cols="" id="CourseIntro"></textarea>
                        </div>

                        <div class="course_form_select">
                            <label for="">是否通过：</label>
                            <input type="radio" name="CheckRadio" id="" value="1" checked="checked" />
                            <label for="">是</label>
                            <input type="radio" name="CheckRadio" id="" value="2" />
                            <label for="">否</label>
                        </div>

                        <div class="course_form_div fr">
                            <label for="">审核意见：</label>
                            <input type="text" placeholder="" class="text" value="" id="CheckMsg" />

                        </div>
                        <div style="clear: both"></div>
                        <div class="course_form_select fl clearfix">
                            <a href="javscript:;" class="course_btn confirm_btn" onclick="CheckCource()">课程审核</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="/js/common.js"></script>

    <script type="text/javascript">
        var GetUrlDate = new GetUrlDate();

        $(function () {

            BindCatagory();
            GetTerm();
            GetGrade();
            GetClass();
            var ID = GetUrlDate.ID;
            if (ID != undefined) {
                GetCourceByID(ID);
            }
        })
        function GetCourceByID(ID) {
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "GetPageList", PageIndex: 1, pageSize: 10, ID: ID },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData.PagedData).each(function () {
                            $("#CourceName").val(this.Name);
                            if (this.CatagoryID.length > 3) {
                                $("#Subject").val(this.CatagoryID.toString().substring(0, 3));//.children('span').attr("value", this.CatagoryID.toString().substring(0, 3));
                                Textbook();
                                $("#Textbook").val(this.CatagoryID.toString().substring(4, 7));
                            }
                            $("#CourceType").val(this.CourceType);//.children('span').attr("value", this.CourceType)
                            $("input[name='ChargeRadio'][value=" + this.IsCharge + "]").attr("checked", true);
                            $("#CourseIntro").val(this.CourseIntro);
                            $("#CoursePrice").val(this.CoursePrice);
                            $("#img_Pic").attr("src", this.ImageUrl);
                            $("#StudyPlace").val(this.StudyPlace);
                            $("#Grade").val(this.Grade);
                            BindClass();
                            $("#StudyTerm").val(this.StudyTerm);
                            $("#WeekName option:contains('" + this.WeekName + "')").attr("selected", true);

                        });

                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        function CheckCource() {
            var CheckMsg = $("#CheckMsg").val();
            var Status = $("input[name='CheckRadio']:checked").val();
            var ID = GetUrlDate.ID;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "CourseManage/CourceManage.ashx", func: "CourceCheck", CheckMsg: CheckMsg, Status: Status, ID: ID
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        parent.layer.msg('操作成功!');
                        parent.getData(1, 10);
                        parent.CloseIFrameWindow();
                    } else {
                        layer.msg(result.errMsg);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }
        function GradSelChange() {
            BindClass();
        }
        function subjectChange() {
            Textbook();
        }
        function BindCatagory() {
            $.ajax({
                url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",

                data: { "Func": "Period" },
                success: function (json) {
                    CatagoryJson = json;
                    //科目
                    BindSubject();
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }

        //科目
        function BindSubject() {
            var option = "";
            if (CatagoryJson.PeriodOfSubject.errNum.toString() == "0") {
                $(CatagoryJson.PeriodOfSubject.retData).each(function () {
                    var ID = this.PeriodID + "|" + this.SubjectID;
                    option += "<option value='" + ID + "'>" + this.SubjectName + "(" + this.PeriodName + ")</option>";
                })
                $("#Subject").append(option);
            }
            else {
                layer.msg(CatagoryJson.PeriodOfSubject.errMsg);
            }
            Textbook();

        }

        //教材
        function Textbook() {
            var option = "";
            var currentPeriod = $("#Subject").val().split("|")[0]; //$("#HPeriod").val();
            var currentSubjectID = $("#Subject").val().split("|")[1];// $("#HSubject").val();
            if (CatagoryJson.Textbook.errNum.toString() == "0") {

                $(CatagoryJson.Textbook.retData).each(function () {
                    if (currentPeriod == this.PeriodID && this.SubjectID == currentSubjectID) {

                        var ID = this.VersionID + "|" + this.Id;
                        option += "<option value='" + ID + "'>" + this.VersionName + "(" + this.Name + ")</option>";
                    }
                })
            }
            else {
                layer.msg(CatagoryJson.Textbook.errMsg);
            }
            $("#Textbook").append(option);

        }
        //学年学期
        function GetTerm() {
            var option = "";// "<span value=\"0\">请选择学期</span><i class=\"icon icon-angle-down\"></i><div class=\"enable_wrap none\"><span value=\"0\" class=\"active\">请选择学期</span>";

            $.ajax({
                url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { Func: "GetTerm" },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            option += "<option value='" + this.Id + "'>" + this.Academic + '-' + this.Semester + "</option>";
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
        //年级
        function GetGrade() {
            //$("#Grade").html("");
            var option = "";// "<span value=\"0\">请选择年级</span><i class=\"icon icon-angle-down\"></i><div class=\"enable_wrap none\"><span value=\"0\" class=\"active\">请选择年级</span>";

            $.ajax({
                url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { Func: "GetGrade" },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            option += "<option value='" + this.Id + "'>" + this.GradeName + "</option>";
                        })
                        //option += "</div>";
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                    $("#Grade").append(option);
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        jsonClass = "";
        //班级
        function GetClass() {
            $.ajax({
                url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { Func: "GetClass" },
                success: function (json) {
                    jsonClass = json;
                    //if (json.result.errNum.toString() == "0") {
                    //    jsonClass = json.result.retData;
                    //}
                    //else {
                    //    layer.msg(json.result.errMsg);
                    //}
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        function BindClass() {
            var option = "";

            $("#Class").html("");
            if (jsonClass.result.errNum.toString() == "0") {
                var GradeID = $("#Grade").val();//.children('span').attr("value").trim()

                $(jsonClass.result.retData).each(function () {
                    if (this.GradeID == GradeID) {
                        option += "<input type=\"checkbox\" name=\"Ckclass\" id=\"\" value=\"" + this.Id
                            + "\" checked=\"checked\" /><label>" + this.ClassName + "</label>";
                    }
                });
                $("#Class").html(option);

            }
            else {
                layer.msg(json.result.errMsg);
            }
        }
    </script>
</body>
</html>
