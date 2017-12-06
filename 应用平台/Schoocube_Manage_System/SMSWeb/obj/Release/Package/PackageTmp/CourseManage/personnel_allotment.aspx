<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="personnel_allotment.aspx.cs" Inherits="SMSWeb.CourseManage.personnel_allotment" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <title>课程管理</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />

    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="../CourseMenu.js"></script>

    <style type="text/css">
        .h-ico {
            display: inline-block;
        }
    </style>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript">
        var UrlDate = new GetUrlDate();

        $(function () {
            $("#CourseManage").attr("href", UrlDate.PageName + "?ParentID=" + UrlDate.ParentID + "&PageName=" + UrlDate.PageName)
            CourceMenu();

            GetClass();
            getData(1, 10);
            BindStu();
            BindFreeStu();
        })

        //获取数据
        function getData(startIndex, pageSize) {
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            //name = name || '';
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "GetPageList", PageIndex: startIndex, pageSize: pageSize, ID: UrlDate.ID },
                success: OnSuccess,
                error: OnError
            });
        }
        function OnSuccess(json) {
            if (json.result.errNum.toString() == "0") {
                $(json.result.retData.PagedData).each(function () {

                    $("#Name").html(this.Name);
                    $("#CourceName").html(this.Name);
                    $("#TermName").html(this.TermName);
                    $("#GradeName").html(this.GradeName);
                    var StatusName = "";
                    if (this.Status == "0") {
                        StatusName = "带激活";
                    }
                    if (this.Status == "1") {
                        StatusName = "激活";
                    } if (this.Status == "2") {
                        StatusName = "停用";
                    }
                    $("#Status").html(StatusName);
                    $("#StuMaxCount").html(this.StuMaxCount);
                    $("#CreateTime").html(DateTimeConvert(this.CreateTime, "yyyy-MM-dd"));
                    BindClass(this.Grade);
                });
            }
            else {
                layer.msg("数据加载失败");
            }
        }
        function OnError(XMLHttpRequest, textStatus, errorThrown) {
            layer.msg(errorThrown);
        }
        jsonClass = "";
        //班级
        function GetClass() {
            $.ajax({
                url: "../SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { Func: "GetClass" },
                success: function (json) {
                    jsonClass = json;
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        //获取班级信息
        function BindClass(GradeID) {
            var option = "";
            $("#Class").html("");
            if (jsonClass.result.errNum.toString() == "0") {
                $(jsonClass.result.retData).each(function () {
                    if (this.GradeID == GradeID) {
                        option += " <option value='" + this.Id + "'>" + this.ClassName + "</option>";
                    }
                });
                $("#Class1").append(option);
                $("#Class2").append(option);
            }
            else {
                layer.msg(json.result.errMsg);
            }
        }
        //已报名学生
        function BindStu() {
            $("#SelectedStu").html("");
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "GetSelStu", "CourseID": UrlDate.ID },
                success: function (json) {
                    if (json.result.errNum == "0") {

                        $(json.result.retData).each(function () {
                            var div = "<input type=\"checkbox\" name=\"check1\" id=\"\" value=\"" + this.StuNo + "\" /><label for=\"check1\">" +
                                this.CreateName + "</label> </div>";
                            $("#StuNoS").val($("#StuNoS").val() + this.StuNo + ",");
                            $("#SelectedStu").append(div);
                        });
                    }
                    else {
                        layer.msg("获取报名学生出错");

                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg(errorThrown);
                }
            });
        }
        //未报名学生
        function BindFreeStu() {
            $("#NoSelectedStu").html("");
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "GetFreeStu", "CourseID": UrlDate.ID },
                success: function (json) {
                    if (json.result.errNum == "0") {
                        var div = "";
                        $(json.result.retData).each(function () {
                            if ($("#StuNoS").val().indexOf(this.IDCard) < 0) {
                                //
                                div = "<input type=\"checkbox\" name=\"check2\" id=\"cl" + this.Id + "\" value=\"" +
                                    this.IDCard + "\" /><label for=\"cl" + this.Id + "\">" + this.Name + "</label></div>";
                            }
                            else {
                                div = "";
                            }
                            $("#NoSelectedStu").append(div);
                        });
                    }
                    else {
                        layer.msg("获取未报名学生出错");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg(errorThrown);
                }
            });
        }
        //调整报名人员
        function AdjustStu(Type) {
            if (confirm("确定要执行调整操作吗？")) {
                //未报名学生
                var FreeStuIDs = "";
                $("input[type=checkbox][name=check2]").each(function () {//查找每一个name为cb_sub的checkbox 
                    if (this.checked) {
                        FreeStuIDs += this.value + ",";
                    }
                });
                //已报名学生
                var StuIDs = "";
                $("input[type=checkbox][name=check1]").each(function () {//查找每一个name为cb_sub的checkbox 
                    if (this.checked) {
                        var ID = $(this).attr("id");
                        //var Name = $('#' + ID + '').next().html();

                        StuIDs += this.value + ",";
                    }
                });

                //添加
                if (Type == 1 && FreeStuIDs == "") {
                    layer.msg("请选择要分配的学生");
                }
                else if (Type == 2 && StuIDs == "") {
                    layer.msg("请选择要删除的学生");
                }
                else {
                    $.ajax({
                        url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                        type: "post",
                        async: false,
                        dataType: "json",
                        data: {
                            "PageName": "CourseManage/CourceManage.ashx",
                            "Func": "AdjustStu",
                            "Type": Type,
                            "FreeStuIDs": FreeStuIDs,
                            "StuIDs": StuIDs,
                            "CourseID": UrlDate.ID,
                            "CreateUID": $("#HUserIdCard").val(),
                        },
                        success: function (json) {
                            if (json.result.errNum == "0") {
                                window.location.reload();
                                //BindStu();
                                //BindFreeStu();
                            }
                            else {
                                layer.msg(jsonClass.result.errMsg);

                            }
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            layer.msg(errorThrown);
                        }
                    });
                }
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="HStuIDCard" value="" runat="server" />
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HUserName" runat="server" />
        <input type="hidden" id="HClassID" runat="server" />

        <input type="hidden" value="" id="StuNoS" />
        <input id="option" type="hidden" value=">" />
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="../HZ_Index.aspx">
                    <img src="../images/logo.png" /></a>
                <div class="wenzi_tips fl">
                    <img src="../images/coursesystem.png" />
                </div>
                <nav class="navbar menu_mid fl">
                    <ul id="CourceMenu">
                        <%-- <li currentclass="active"><a href="CourseIndex.aspx">课程首页</a></li>
                        <li class="active"><a href="#">课程管理</a></li>
                        <li currentclass="active"><a href="MyCourceManage.aspx">我的课程</a></li>
                        <li currentclass="active"><a href="Course_SelManag.aspx">选课管理</a></li>--%>
                    </ul>
                </nav>
                <div class="search_account fr clearfix">
                    <ul class="account_area fl">
                        <li>
                            <a href="javascript:;" class="dropdown-toggle">
                                <i class="icon icon-envelope"></i>
                                <span class="badge">3</span>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:;" class="login_area clearfix">
                                <div class="avatar">
                                    <img src="<%=PhotoURL %>" />
                                </div>
                                <h2><%=Name %></h2>
                            </a>
                        </li>
                    </ul>
                    <div class="settings fl pr ">
                        <a href="javascript:;">
                            <i class="icon icon-cog"></i>
                        </a>
                        <div class="setting_none">
                            <a href="/PersonalSpace/PersonalSpace_Teacher.aspx" target="_blank"><span>个人中心</span></a>
                            <span onclick="logOut()">退出</span>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <div class="onlinetest_item width pt90">
            <div class="course_manage bordshadrad">
                <div class="crumbs">
                    <a id="CourseManage">课程管理</a>
                    <span>&gt;</span>
                    <a href="#" id="CourceName"></a>
                </div>
                <div class="newcourse_select clearfix">
                    <div class="clearfix course_select fl">
                        <label for="">课程名称：</label>
                        <span id="Name"></span>
                    </div>
                    <div class="clearfix course_select fl">
                        <label for="">学年学期：</label>
                        <span id="TermName"></span>
                    </div>
                    <div class="clearfix course_select fl">
                        <label for="">班级：</label>
                        <span id="GradeName"></span>
                    </div>
                    <div class="clearfix course_select fl">
                        <label for="">状态：</label>
                        <span class="verified" id="Status"></span>
                    </div>
                    <div class="clearfix course_select fl">
                        <label for="">创建时间：</label>
                        <span id="CreateTime"></span>
                    </div>
                    <div class="clearfix course_select fl">
                        <label for="">人数：</label>
                        <span id="StuMaxCount"></span>
                    </div>
                </div>
                <!--已报名学生 未分配学生 -->
                <div class="enroll_allot mt10 clearfix">
                    <div class="enroll_students fl">
                        <div class="enroll_title">
                            已报名学生
                        </div>
                        <div class="enrollgrade_select clearfix">
                            <div class="clearfix fl course_select">
                                <label for="">班级：</label>
                                <select name="" id="Class1" class="select">
                                    <option value="">请选择</option>
                                </select>
                            </div>
                        </div>
                        <div class="students_lists" id="SelectedStu">
                            <%--<div class="">
                                <input type="checkbox" name="check" id="" value=""/><label for="check">胡文里</label>
                            </div>--%>
                        </div>
                    </div>
                    <div class="tab_btn fl">
                        <div class="tab_left">
                            <i class="icon  icon-angle-left" onclick="AdjustStu(1)"></i>
                        </div>
                        <div class="tab_right">
                            <i class="icon icon-angle-right" onclick="AdjustStu(2)"></i>
                        </div>
                    </div>
                    <div class="allot_students fr">
                        <div class="allot_title">
                            未报名学生
                        </div>
                        <div class="allotgrade_select clearfix">
                            <div class="clearfix fl course_select">
                                <label for="">班级：</label>
                                <select name="" id="Class2" class="select">
                                    <option value="">请选择</option>

                                </select>
                            </div>
                        </div>
                        <div class="students_lists" id="NoSelectedStu">
                            <%--
                            <div class="">
                                <input type="checkbox" name="check" id="" value="" /><label for="check">胡文lis</label>
                            </div>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="../js/common.js"></script>
        <script type="text/javascript">
            //$(function () {
            //人员分配左右换
            //function leftRightTab(tabObj, tarObj) {
            //    tabObj.each(function () {
            //        tabObj.each(function () {
            //            if ($(this).is(':checked')) {
            //                var $clone = $(this).parent('div');
            //                $clone.remove();
            //                $clone.prependTo(tarObj);
            //            }
            //        })
            //        tarObj.find('input').prop('checked', false);
            //    });
            //    tabObj.next().each(function () {
            //        $(this).click(function () {
            //            $(this).prev().is(':checked') ? $(this).prev().prop('checked', false) : $(this).prev().prop('checked', true);
            //        })
            //    });
            //}
            //$('.tab_right').click(function () {
            //    leftRightTab($('.enroll_students input'), $('.allot_students .students_lists'));
            //})
            //$('.tab_left').click(function () {
            //    leftRightTab($('.allot_students input'), $('.enroll_students .students_lists'));
            //})
            //})
        </script>
    </form>
</body>



</html>
