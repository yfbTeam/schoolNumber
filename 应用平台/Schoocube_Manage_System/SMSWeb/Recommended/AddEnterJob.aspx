<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddEnterJob.aspx.cs" Inherits="SMSWeb.Recommended.AddEnterJob" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>添加岗位信息</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/onlinetest.css" rel="stylesheet" />
    <link href="/css/choosen/chosen.css" rel="stylesheet" />
    <link href="/css/choosen/prism.css" rel="stylesheet" />
    <link href="/css/choosen/style.css" rel="stylesheet" />
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
    <script src="/Scripts/Common.js"></script>
</head>
<body>
    <form id="form1" enctype="multipart/form-data" method="post" runat="server">
        <input type="hidden" id="HUserIdCard" value="<%=IDCard %>"/>

        <!--创建课程dialog-->
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                    <div class="course_form_div clearfix">
                        <label for="">岗位名称：</label>
                        <input type="text" placeholder="岗位名称" class="text" id="Name" />
                        <i class="stars"></i>
                    </div>
                    <div class="course_form_selecta clearfix">
                        <label for="">相关专业：</label>
                        <select class="chosen-select" data-placeholder="相关专业" multiple="multiple" id="Major">
                        </select>

                    </div>
                    <div class="course_form_selecta clearfix">
                        <label for="">相关课程：</label>
                        <select class="chosen-select" data-placeholder="相关课程" multiple="multiple" id="Course">
                        </select>
                    </div>

                    <div class="clearfix">
                        <div class="course_form_div clearfix">
                            <label for="">岗位简介：</label>
                            <input type="text" placeholder="岗位简介" class="text" id="Introduction" />
                        </div>
                        <div style="clear: both"></div>
                        <div class="course_form_select clearfix">
                            <a class="course_btn confirm_btn" onclick="JobAdd()" id="btnCreate">确定</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
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
    <script src="/js/common.js"></script>
    <script>
        var UrlDate = new GetUrlDate();
        $(function () {
            BindMajor();
            BindCourse();
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

        //专业
        function BindMajor() {
            var option = "<option value=\"0\">选择专业</option>";
            $.ajax({
                url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { Func: "GetMajor" },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            option += "<option value='" + this.Id + "'>" + this.Name + "</option>";
                        })
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                    $("#Major").append(option);
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        function BindCourse() {
            $("#Course").html("<option value=\"0\">==请选择课程==</option>");
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
                        });

                    }
                },
                error: function (errMsg) {
                    layer.msg('加载失败！');
                }
            });
        }
       
        //添加数据
        function JobAdd() {
            var EnterID = UrlDate.EnterID;
            var Name = $("#Name").val();
            var MajorIDs = $("#Major").val();
            var CourseIDs = $("#Course").val();
            var Introduction = $("#Introduction").val();
            if (Name.length <= 0 ) {
                layer.msg("请填写完整信息！");
            }
            else {
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    dataType: "json",
                    data: {
                        "PageName": "/Recommended/Recommended.ashx", func: "AddJob", Name: Name, EnterID: EnterID,
                        CourseIDs: CourseIDs, MajorIDs: MajorIDs, Introduction: Introduction, CreateUID: $("#HUserIdCard").val()
                    },
                    success: function (json) {
                        var result = json.result;
                        if (result.errNum == 0) {
                            parent.layer.msg('添加成功!');
                            parent.BindJob(EnterID);
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
    </script>
</body>
</html>
