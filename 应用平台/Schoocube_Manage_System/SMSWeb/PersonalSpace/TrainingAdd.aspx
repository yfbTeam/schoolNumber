<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TrainingAdd.aspx.cs" Inherits="SMSWeb.PersonalSpace.TrainingAdd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>添加培训档案</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/choosen/chosen.css" rel="stylesheet" />
    <link href="/css/choosen/prism.css" rel="stylesheet" />
    <link href="/css/choosen/style.css" rel="stylesheet" />

    <link href="/css/onlinetest.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <link href="/Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="/Scripts/choosen/chosen.jquery.js"></script>
    <script src="/Scripts/choosen/prism.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <style>
        .course_form_selecta {
            margin-bottom: 20px;
            margin-right: 16px;
        }

            .course_form_selecta label {
                float: left;
                color: #666666;
                font-size: 14px;
                line-height: 30px;
            }

            .course_form_selecta .chosen-select {
                width: 178px;
            }
    </style>
</head>
<body>
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />
        <input type="hidden" id="HUserName" value="<%=Name %>" />
        <input type="hidden" id="HClassID" value="<%=ClassID %>" />

        <!--创建课程dialog-->
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                    <div class="clearfix">
                        <div class="course_form_div fl">
                            <label for="">培训名称：</label>
                            <input type="text" placeholder="培训名称" class="text" id="TrainName" />
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_div fr">
                            <label for="">机构名称：</label>
                            <input type="text" placeholder="机构名称" class="text" id="GroupName" />
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_div fl">
                            <label for="">开始时间：</label>
                            <input type="text" placeholder="开始时间" class="text" id="BeginTime" onclick="javascript: WdatePicker({ maxDate: '#F{$dp.$D(\'EndTime\')}' });" />

                        </div>
                        <div class="course_form_div fr">
                            <label for="">结束时间：</label>
                            <input type="text" placeholder="结束时间" class="text" id="EndTime" onclick="javascript: WdatePicker({ minDate: '#F{$dp.$D(\'BeginTime\')}' });" />
                            <i class="stars"></i>
                        </div>
                        <div style="clear: both;"></div>
                        <div class="course_form_selecta fl">
                            <label for="">培训课程：</label>
                            <select class="chosen-select" data-placeholder="培训课程" multiple="multiple" id="Course">
                            </select>
                        </div>
                        <div class="course_form_selecta fr">
                            <label for="">参加考试：</label>
                            <select class="chosen-select" data-placeholder="参加考试" multiple="multiple" id="Exam">
                            </select>
                        </div>
                        <div style="clear: both;"></div>

                        <div class="course_form_div fr">
                        </div>
                        <div class="course_form_div fl" id="IsCharge">
                            <label for="">培训学时：</label>
                            <input type="text" placeholder="培训学时" class="text" id="ClassHour" />
                            <i class="stars"></i>

                        </div>
                        <div class="course_form_div fr">
                            <label for="">培训费用：</label>
                            <input type="text" placeholder="培训费用" class="text" value="0" id="TrainFee" />
                            <i class="stars"></i>
                        </div>
                        <div style="clear: both"></div>
                        <div class="course_form_div fl" id="IsOpen">
                            <label for="">授 课 人：</label>
                            <input type="text" placeholder="授课人" class="text" id="TrainMan" />
                            <i class="stars"></i>

                        </div>
                        <div class="course_form_div fr">
                            <label for="">培训结果：</label>
                            <input type="text" placeholder="培训结果" class="text" id="TrainResult" />
                            <i class="stars"></i>
                        </div>

                        <div class="course_form_select clearfix">
                            <a class="course_btn confirm_btn" onclick="AddTrain()" id="btnCreate">确定</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="/js/common.js"></script>
    <script>
        var GetUrlDate = new GetUrlDate();
        $(function () {
            BindCourse();
            BindExam();
            var config = {
                '.chosen-select': {},
                '.chosen-select-deselect': { allow_single_deselect: true },
                '.chosen-select-no-single': { disable_search_threshold: 10 },
                '.chosen-select-no-results': { no_results_text: 'Oops, nothing found!' },
                '.chosen-select-width': { width: "95%" }
            }
            for (var selector in config) {
                $(selector).chosen(config[selector]);
            }
        })
        //绑定课程
        function BindCourse() {
            $("#Course").html("<option value=\"0\">==请选择课程==</option>");
            //初始化序号 
            var ClassID = $("#Hid_ClassID").val();
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/MyLessonsHandler.ashx",
                    Func: "GetMyLessonsByType",
                    StuNo: $("#HUserIdCard").val(),
                    ClassID: ClassID,
                    CourseType: 1,
                    IsPage: false
                },
                success: function (json) {
                    $(json.result.retData).each(function () {
                        var option = "<option value='" + this.ID + "'>" + this.Name + "</option>";
                        $("#Course").append(option);
                    });
                },
                error: function (errMsg) {
                }
            });
        }
        //绑定考试
        function BindExam() {
            $("#Exam").html("<option value=\"0\">==请选择考试==</option>");
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/Exam/ExamHandler.ashx", action: "GetExamNPageList", IsPage: false, ClassID: $("#Hid_ClassID").val(), "CreateUID": $("#HUserIdCard").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            var option = "<option value='" + this.ID + "'>" + this.epname + "</option>";
                            $("#Exam").append(option);
                        });
                    }
                },
                error: function (errMsg) {
                    layer.msg('加载失败！');
                }
            });
        }
        //添加数据
        function AddTrain() {

            var CreateUID = $("#HUserIdCard").val();
            var TrainName = $("#TrainName").val().trim();
            var GroupName = $("#GroupName").val().trim();
            var BeginTime = $("#BeginTime").val();//.children('span').attr("value").trim();
            var EndTime = $("#EndTime").val();
            var ClassHour = $("#ClassHour").val();
            var TrainFee = $("#TrainFee").val();
            var TrainMan = $("#TrainMan").val()
            var TrainResult = $("#TrainResult").val();
            var Course = $("#Course").val();
            var Exam = $("#Exam").val();
            var ID = "";
            if (GetUrlDate.ID != undefined) {
                ID = GetUrlDate.ID;
            }
            if (!TrainName.length || GroupName == "0" || !ClassHour.length || !TrainFee.length || !BeginTime.length || !EndTime.length) {
                layer.msg("请填写完整信息！");
            }
            else {

                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "CourseManage/PersonSpaceStu.ashx",
                        func: "AddTrain", TrainName: TrainName, GroupName: GroupName, BeginTime: BeginTime, EndTime: EndTime,
                        ClassHour: ClassHour, TrainFee: TrainFee, TrainMan: TrainMan, TrainResult: TrainResult, CreateUID: CreateUID,
                        "CourseIDs": Course, "ExamIDs": Exam
                    },
                    success: function (json) {
                        var result = json.result;
                        if (result.errNum == 0) {
                            parent.layer.msg('操作成功!');
                            parent.getTrainingData();
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
        }
        //绑定数据
        function GetTrainByID(ID) {
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "GetPageList", PageIndex: 1, pageSize: 10, ID: ID, CourseType: "" },
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
                            $("#StudyTerm option:contains('" + this.TermName + "')").attr("selected", "selected");
                            BindClass();
                            $("#WeekName option:contains('" + this.WeekName + "')").attr("selected", true);
                            $("#AcademicDepart option:contains('" + this.CourseType + "')").attr("selected", true);
                            $("input[name='OpenRadio'][value=" + this.IsOpen + "]").attr("checked", true);
                            $("#LessonPeriod").val(this.LessonPeriod);
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

    </script>
</body>
</html>
