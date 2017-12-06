<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddCertificate.aspx.cs" Inherits="SMSWeb.PersonalSpace.AddCertificate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>平台证书添加修改</title>
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
    <style>
        .course_form_selecta {
            margin-bottom: 20px;
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

        <!--创建课程dialog-->
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                    <div class="course_form_div clearfix">
                        <label for="">证书名称：</label>
                        <input type="text" id="Name" class="text" />
                    </div>
                    <div class="course_form_select clearfix">
                        <label for="">证书模板 ：</label>
                        <select id="Model">
                        </select>
                    </div>
                    <div class="course_form_selecta clearfix">
                        <label for="">相关课程：</label>
                        <select class="chosen-select" data-placeholder="相关课程" multiple="multiple" id="Course">
                        </select>
                    </div>
                    <div class="clearfix">
                        <div class="course_form_select clearfix">
                            <label for="">考 试 一 ：</label>
                            <select id="Exam1">
                            </select>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">最低分数：</label>
                            <input type="text" placeholder="学生最多选课数" class="text" id="Scor1" value="0" />
                        </div>
                        <div class="course_form_select clearfix">
                            <label for="">考 试 二 ：</label>
                            <select id="Exam2">
                            </select>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">最低分数：</label>
                            <input type="text" placeholder="学生最多选课数" class="text" id="Scor2" value="0" />
                        </div>
                        <div class="course_form_select clearfix">
                            <label for="">考 试 三 ：</label>
                            <select id="Exam3">
                            </select>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">最低分数：</label>
                            <input type="text" placeholder="学生最多选课数" class="text" id="Scor3" value="0" />
                        </div>
                        <div style="clear: both"></div>

                        <div class="course_form_select clearfix">
                            <a class="course_btn confirm_btn" onclick="CertificateAdd()" id="btnCreate">确定</a>
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
            BindExam();
            BindCourse();
            bindModol();
            if (GetUrlDate.ID != undefined && GetUrlDate.ID!="") {
                GetPlatCertByID();
            }
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
        //添加数据
        function CertificateAdd() {
            var Name = $("#Name").val();
            var Course = $("#Course").val();
            var Exam = "";
            var Exam1 = $("#Exam1").val();
            var Exam2 = $("#Exam2").val();
            var Exam3 = $("#Exam3").val();
            if (Exam1 != "0") {
                Exam += Exam1;
            }
            if (Exam2 != "0") {
                Exam += Exam2;
            }
            if (Exam3 != "0") {
                Exam += Exam3;
            }
            var Scor1 = $("#Scor1").val();
            var Scor2 = $("#Scor2").val();
            var Scor3 = $("#Scor3").val();
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                dataType: "json",
                data: {
                    "PageName": "Certificate/Certificate.ashx", func: "AddPlatCertificate", Name: Name, "Course": Course, Exam1: Exam1, Scor1: Scor1,
                    Exam2: Exam2, Scor2: Scor2, Exam3: Exam3, Scor3: Scor3, UserIdCard: $("#HUserIdCard").val(), ModelID: $("#Model").val(), ID: GetUrlDate.ID
                },
                success: function (json) {

                    var result = json.result;
                    if (result.errNum == 0) {
                        parent.layer.msg('操作成功!');
                        parent.BindPlatCertificate(1, 10);
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
        function GetPlatCertByID() {
            var ID = GetUrlDate.ID;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                dataType: "json",
                async: false,
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "GetPlatCertificate",
                    ID: ID,
                    Ispage:false
                },
                success: function (json) {
                    var CourseID = "";

                    if (json.CertificateManage.errNum.toString() == "0") {
                        $.each(json.CertificateManage.retData, function (n, value) {
                            $("#Name").val(this.Name);
                            $("#Model").val(this.ModelID)
                            var CertificateID = this.ID;
                            var ExamName = "";
                            var CourseName = "";
                            var i = 1;
                            //考试
                            $.each(json.Exam.retData, function (n, value) {
                                if (this.CertificateID == CertificateID) {
                                    $("#Scor" + i).val(this.Score);
                                    $("#Exam" + i).val(this.ExamID);
                                    i++;
                                }
                            });
                            //课程
                            $.each(json.Course.retData, function (n, value) {
                                if (this.CertificateID == CertificateID) {
                                    $("#Course").val(this.CourseID);
                                    //CourseID += this.CourseID + ",";
                                }
                            });
                            //if (CourseID.length>0) {
                            //    CourseID = CourseID.substring(0, CourseID.length - 1);
                            //}
                            //$("#Course").val(CourseID);
                        })
                    }
                    else {
                        layer.msg(json.CertificateManage.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        //绑定数据
        function GetCourceByID(ID) {
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CourseManage/CourseSet.ashx", "Func": "GetPageList", PageIndex: 1, pageSize: 10, ID: ID },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData.PagedData).each(function () {
                            $("input[name='WeekSet'][value=" + this.WeekSet + "]").attr("checked", true);
                            $("#StudyTerm").val(this.TermID);
                            $("#SelType").val(this.SelType);
                            $("#Status").val(this.Status);
                            $("#SelMaxNum").val(this.SelMaxNum);
                            $("#SelMinNum").val(this.SelMinNum);
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
        function BindExam() {
            $("#Exam1").html("<option value=\"0\">==请选择考试==</option>");
            $("#Exam2").html("<option value=\"0\">==请选择考试==</option>");
            $("#Exam3").html("<option value=\"0\">==请选择考试==</option>");
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/Exam/ExamHandler.ashx", action: "GetExamQPageList",IsPage: false,
                    //PageIndex: 1, pageSize: 10,  Type: 1, IsRelease: 1
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            var option = "<option value='" + this.ID + "'>" + this.Name + "</option>";
                            $("#Exam1").append(option);
                            $("#Exam2").append(option);
                            $("#Exam3").append(option);
                        });

                    }
                },
                error: function (errMsg) {
                    layer.msg('加载失败！');
                }
            });
        }
        function BindCourse() {
            $("#Course").html("<option value=\"0\">==请选择课程==</option>");
            //$("#Course2").html("<option value=\"0\">==请选择课程==</option>");
            //$("#Course3").html("<option value=\"0\">==请选择课程==</option>");
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "/CourseManage/CourceManage.ashx", "Func": "GetPageList", Ispage: false
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            var option = "<option value='" + this.ID + "'>" + this.Name + "</option>";
                            $("#Course").append(option);
                            //$("#Course2").append(option);
                            //$("#Course3").append(option);
                        });

                    }
                },
                error: function (errMsg) {
                    layer.msg('加载失败！');
                }
            });
        }
        function bindModol() {
            $("#Model").html("<option value=\"0\">==请选择模板==</option>");
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                dataType: "json",
                async: false,
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "GetModolList",
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            var option = "<option value='" + this.ID + "'>" + this.Name + "</option>";
                            $("#Model").append(option);
                        });
                    }
                    else {
                        $("#Model").html("暂无证书模板！");
                    }
                },
                error: function (errMsg) {
                    $("#Certificate").html(errMsg);
                }
            });
        }
    </script>
</body>
</html>
