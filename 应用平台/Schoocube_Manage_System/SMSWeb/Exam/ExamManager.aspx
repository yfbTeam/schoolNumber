<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExamManager.aspx.cs" Inherits="SMSWeb.Exam.ExamManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>试卷管理</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
			<script src="/js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/CourseMenu.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />

        <%-- 学年--%>
        <input id="HPeriod" type="hidden" value="0" />
        <%-- 科目--%>
        <input id="HSubject" type="hidden" value="0" />
        <%-- 教材--%>
        <input id="HTextboox" type="hidden" value="0" />
        <%-- 目录--%>
        <input id="HChapterID" type="hidden" value="0" />
        <%-- 版本--%>
        <input id="bookVersion" type="hidden" value="0" />
        <%-- 试卷发布状态--%>
        <input id="HIsRelease" type="hidden" value="1" />
        <input id="hName" type="hidden" runat="server" />
        <div>
            <!--header-->
            <header class="repository_header_wrap manage_header">
                <div class="width repository_header clearfix">
                    <a class="logo fl" href="/HZ_Index.aspx">
                        <img src="/images/logo.png" /></a>
                    <div class="wenzi_tips fl">
                         <img src="/images/testsystem.png" /></div>
                    <nav class="navbar menu_mid fl">
                        <ul id="CourceMenu">
                            <%--<li currentclass="active"><a href="ExamQManager.aspx">题库管理</a></li>
                            <li currentclass="active"><a href="ExamManager.aspx">试卷管理</a></li>
                            <li currentclass="active"><a href="MyExam.aspx">我的试卷</a></li>
                            <li currentclass="active"><a href="charts.aspx">分析统计</a></li>--%>
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
            <div class="onlinetest_item width pt90 pr">
                <div class="stytem_items">
                    <div class="stytem_item clearfix a">
                        <div class="stytem_items_title fl">
                            学年
                        </div>
                        <div class="stytem_items_list fl" id="Period"></div>
                        <a href="javascript:;" class="stytem_items_more fr" style="visibility: hidden;">
                            <span>更多</span>
                            <i class="icon icon-angle-down"></i>
                        </a>
                    </div>
                    <div class="stytem_item clearfix a">
                        <div class="stytem_items_title fl">
                            科目
                        </div>
                        <div class="stytem_items_list fl" id="Subject"></div>
                        <a href="javascript:;" class="stytem_items_more fr">
                            <span>更多</span>
                            <i class="icon icon-angle-down"></i>
                        </a>
                    </div>
                    <div class="stytem_item clearfix none" id="textbookv">
                        <div class="stytem_items_title fl">
                            版本
                        </div>
                        <div class="stytem_items_list fl" id="TextbookVersion"></div>
                        <a href="javascript:;" class="stytem_items_more fr" style="visibility: hidden;">
                            <span>更多</span>
                            <i class="icon icon-angle-down"></i>
                        </a>
                    </div>
                    <div class="stytem_item clearfix none" id="text">
                        <div class="stytem_items_title fl">
                            教材
                        </div>
                        <div class="stytem_items_list fl" id="Textbook"></div>
                        <a href="javascript:;" class="stytem_items_more fr" style="visibility: hidden;">
                            <span>更多</span>
                            <i class="icon icon-angle-down"></i>
                        </a>
                    </div>
                </div>
                <a href="javascript:;" class="moreoptions">
                    <span id="sput">更多选项</span><i id="angle-down" class="icon icon-angle-down fr"></i>
                </a>
            </div>
            <div class="width clearfix testsystem_wrap  pt20">
                <section class="menu fl">
                    <div class="grade pr">
                        <div class="item">
                            <span class="icon-th-list icon icon_list"></span>
                            <span class="title" id="textbook">全部</span>
                            <span class="icon icon-angle-right icon_right"></span>
                        </div>
                    </div>
                    <div class="items" id="menuChapater">
                    </div>
                </section>
                <div class="onlinetest_right fr bordshadrad pr">
                    <!---->

                    <div class="stytem_select clearfix">
                        <div class="stytem_select_left fl">
                            <a href="javascript:;" class="on" onclick="ChangeRelease(1);">已发布试卷</a>
                            <a href="javascript:;" onclick="ChangeRelease(2);">未发布试卷</a>
                        </div>
                        <div class="stytem_select_right fr">
                            <div class="search_exam fl pr">
                                <input type="text" name="Title" id="Title" value="" onblur="getData(1, 10);" placeholder="试卷" />
                                <i class="icon  icon-search"></i>
                            </div>
                            <span class="enable">
                                <span value="1" id="Status">启用 </span><i class="icon icon-angle-down"></i>
                                <div class="enable_wrap none">
                                    <span value="1" class="active" onclick="selectstatus(1)">启用</span>
                                    <span value="2" onclick="selectstatus(2)">禁用</span>
                                </div>
                            </span>
                            <span class="enable" style="width: 75px;">
                                <span value="1" id="sel_Type">考试</span><i class="icon icon-angle-down"></i>
                                <div class="enable_wrap none">
                                    <span value="1" class="active" onclick="ChangePaperType(1)">考试</span>
                                    <span value="2" onclick="ChangePaperType(2)">测试</span>
                                    <span value="3" onclick="ChangePaperType(3)">作业</span>
                                    <span value="4" onclick="ChangePaperType(4)">问卷调查</span>
                                </div>
                            </span>
                            <a href="javascript:;" class="newtest" onclick="MakeExamPaper()">
                                <i class="icon icon-plus"></i>新建试卷
							<%--<div class="addtest_wrap none">
								<em>新建试卷</em>
								<em>上传文档</em>
							</div>--%>
                            </a>
                        </div>
                    </div>
                    <div class="test_norelase">
                        <ul class="test_lists exam_lists" id="examdiv">
                        </ul>
                        <!--未发布试卷-->
                        <ul class="test_lists exam_lists none" id="neverexamdiv">
                        </ul>
                    </div>
                    <!--分页-->
                    <div class="page">
                        <span id="pageBar"></span>
                        <span id="neverpageBar"></span>
                    </div>

                    <!--预览试卷-->

                </div>
                <script src="/js/common.js" type="text/javascript" charset="utf-8"></script>
                <script src="/js/system.js" type="text/javascript" charset="utf-8"></script>
                <script>
                    $(function () {
                        //menu显示隐藏
                        $('.grade').find('.item').click(function () {
                            clickTab($('.grade'), '.icon_right');
                        });
                        //预览试卷 手风琴
                        $('.paper_numer h1').find('.icon').click(function () {
                            var $next = $(this).parents('h1').next();
                            $next.stop().slideToggle();
                            $('.paper_numer').find('.paper_number_mes').not($next).slideUp();
                        });
                    })
                </script>
            </div>
        </div>
    </form>
</body>
</html>
<script type="text/javascript">
    //function accountManagement() {
    //    window.location.href = "/Gopay/Gopay.aspx";
    //}
    //function Mycenter() {
    //    window.open("/PersonalSpace/PersonalSpace_Student.aspx", "_blank")
    //}
    var book = "";
    //var HanderServiceUrl = "/Exam/";
    $(function () {
        CourceMenu();
        BindCatagory();
        $("#Title").attr("value", "");
        $("#HChapterID").attr("value", "");
        $("#sel_Type").attr("value", "");
        getData(1, 10);
    });
    function ChangeRelease(relvalue) {
        $("#HIsRelease").val(relvalue);
        getData(1, 10);
    }
    function ChangePaperType(type) {
        $("#sel_Type").attr("value", type);
        getData(1, 10);
    }
    function selectstatus(status) {
        $("#Status").attr("value", status);
        getData(1, 10);
    }
    //获取数据
    function getData(startIndex, pageSize) {
        //var Period = $("#HPeriod").val();
        //var Subject = $("#HSubject").val();
        //var MajorID = Period.trim() == "" ? "" : (Subject.trim() == "" ? Period : (Period + "|" + Subject));
        //var bookVersion = $("#bookVersion").val();
        //var Textboox = $("#HTextboox").val();
        //MajorID = bookVersion.trim() == "" ? MajorID : (Textbook.trim() == "" ? MajorID + "&" + bookVersion : (MajorID + "&" + bookVersion + "|" + TextBook));
        var Chapter = $("#HChapterID").val();
        var Status = $("#Status").attr("value");
        var TypeId = $("#sel_Type").attr("value");
        var Title = $("#Title").val();
        var IsRelease = $("#HIsRelease").val();
        //初始化序号 
        // pageNum = (startIndex - 1) * pageSize + 1;
        //name = name || '';
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "GetExamQPageList",
                PageIndex: startIndex,
                pageSize: pageSize,
                //"Period": Period,
                //"Subject": Subject,
                //"bookVersion": bookVersion,
                //"Textboox": Textboox,
                "KlpointID": Chapter,
                "Status": Status,
                "Type": TypeId,
                "Title": Title,
                "IsRelease": IsRelease,
                "Book": book,
            },
            success: OnSuccess,
            //error: OnError
        });
    }
    function OnSuccess(json) {
        //debugger;
        var IsRelease = $("#HIsRelease").val();
        if (json.result.errNum.toString() == "0") {
            var html = "";
            $.each(json.result.retData.PagedData, function () {
                html += "<li class=\"clearfix\">"
							+ "<div class=\"exam_img fl\">"
								+ "<img src=\"/images/exam_img.png\"/></div>"
                + "</div><div class=\"test_description exam_description fl\">"
								+ "<h2><a href='#' onclick=\"LookQuestion(" + this.ID + ")\">" + this.Title + "</a></h2>"
								+ "<p><span class=\"test_type\">" + this.TypeShow + "</span>";
                if (this.Difficulty == 1) {
                    html += "<span class=\"test_easy\">" + this.DifficultyShow + "</span>";
                } else if (this.Difficulty == 2) {
                    html += "<span class=\"test_normal\">" + this.DifficultyShow + "</span>";
                } else if (this.Difficulty == 3) {
                    html += "<span class=\"test_trouble\">" + this.DifficultyShow + "</span>";
                }
                html += "</p></div>"
							+ "<div class=\"test_lists_right fr clearfix\">"
								+ "<div class=\"public_name fl\">"
									+ "创建人：" + this.Author
								+ "</div>"
                                + "<div class=\"dates_a dates_b fr\">"
									+ "<div class=\"seedeletion none\">"
										+ "<i class=\"icon icon-eye-open\" onclick=\"LookQuestion(" + this.ID + ")\"></i>";
                html += "<i class=\"icon " + (this.Status != 1 ? " icon-ok-circle\"" : "icon-ban-circle\"");
                html += " onclick=\"ChangQstatus(this," + this.ID + "," + this.Template + "," + this.QType + ")\"></i>";
                if (IsRelease == 2) {
                    html += "<i class=\"releate\" onclick=\"ChangPaperStatus(" + this.ID + "," + this.Type + ",this)\" id=\"" + this.Title + "\"></i>";
                }
                //html+= "<i class=\"icon " + (this.Status != 1 ? " icon-ok-circle\"" : "icon-ban-circle\" onclick=\"ChangQstatus(this," + this.ID + ")\"></i>";
                html += "</div>"
                                                    + "<div class=\"data\">"
                                                    + "创建时间：" + this.CreateTime_Format
                                                    + "</div></div></div></li>";
            });
            if (IsRelease == 1) {
                $("#examdiv").html(html);
                $("#neverpageBar").hide();
                $("#pageBar").show();
                makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 8, json.result.retData.RowCount);
            } else {
                $("#neverexamdiv").html(html);
                $("#pageBar").hide();
                $("#neverpageBar").show();
                makePageBar(getData, document.getElementById("neverpageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 8, json.result.retData.RowCount);
            }
            HoverPaper();
            //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
        } else {
            var html = '<div style="background: url(/images/error.png) no-repeat center center; height: 500px;"></div>';
            if (IsRelease == 1) {
                $("#pageBar").hide();
                $("#neverpageBar").hide();
                $("#examdiv").html(html);
            } else {
                $("#pageBar").hide();
                $("#neverpageBar").hide();
                $("#neverexamdiv").html(html);
            }
        }

    }
    function HoverPaper() {
        //试卷管理
        $('.test_lists li').hover(function () {
            $(this).find('.seedeletion').show();
            //发步图标划过文字显示
            $(this).find('.release').hover(function () {
                $(this).find('em').slideDown();
            }, function () {
                $(this).find('em').slideUp();
            })
        }, function () {
            $(this).find('.seedeletion').hide();
        })
    }
    function ChangQstatus(obj, Id, Template, Qtype) {
        var status = 2;
        if ($(obj).hasClass("icon-ok-circle")) { status = 1; }
        var str = "";
        if (status == 1) {
            str = "启";
        } else {
            str = "禁";
        }
        layer.msg("确定要" + str + "用该试圈?", {
            time: 0 //不自动关闭
           , btn: ['确定', '取消']
           , yes: function (index) {
               layer.close(index);
               $.ajax({
                   url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                   type: "post",
                   async: false,
                   dataType: "json",
                   data: {
                       PageName: "/Exam/ExamHandler.ashx",
                       "action": "ChangPaperStatus", "PaperID": Id, "Status": status
                   },
                   success: function (json) {
                       if (json.result.errNum.toString() == "0") {
                           //if (status == 1) {
                           //    alert('启用成功');
                           //} else {
                           //    alert('禁用成功');
                           //}
                           getData(1, 10);
                       }
                   },
                   error: function (errMsg) {

                   }
               });
           }
        });
    }
    function LookQuestion(id) {
        OpenIFrameWindow('预览试卷', '/Exam/ExamPaperDetail.aspx?id=' + id, '900px', '70%');
    }
    function ChangPaperStatus(Id, qtype, em) {
        OpenIFrameWindow('发布试卷', '/Exam/ReleaseExam.aspx?Id=' + Id + '&name=' + em.id + '&qtype=' + qtype, '780px', '70%');
    }
    function MakeExamPaper() {
        var Period = $("#HPeriod").val();
        var Subject = $("#HSubject").val();
        //var MajorID = Period.trim() == "" ? "" : (Subject.trim() == "" ? Period : (Period + "|" + Subject));
        var bookVersion = $("#bookVersion").val();
        var Textboox = $("#HTextboox").val();
        //MajorID = bookVersion.trim() == "" ? MajorID : (Textbook.trim() == "" ? MajorID + "&" + bookVersion : (MajorID + "&" + bookVersion + "|" + TextBook));
        var Chapter = $("#HChapterID").val();
        var parm = Period.trim() != "" ? (Subject.trim() != "" ? (bookVersion.trim() != "" ? (Textboox.trim() != "" ? (Chapter.trim() != "" ? ("?Period=" + Period + "&Subject=" + Subject + "&Textboox=" + Textboox + "&bookVersion=" + bookVersion + "&Chapter=" + Chapter) : ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&Textboox=" + Textboox)) : ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion)) : ("?Period=" + Period + "&Subject=" + Subject)) : "?Period=" + Period) : "";
        location.href = "/Exam/ManualChooseQ.aspx" + parm;
    }

    function Chapator() {
        $.ajax({
            url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "Func": "Chapator" },
            success: function (json) {
                //BindleftMenu(json);
                if (json.result.errNum.toString() == "0") {
                    div = "";
                    BindleftMenu(json.result.retData, 0);
                    $("#menuChapater").html("");
                    $("#menuChapater").append(div);
                    menuSel();
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
    var div = "";
    var TopMenuNum = 0;

    function BindleftMenu(data, id) {
        var i = 0;
        $(data).each(function () {
            if (this.TextbooxID == $("#HTextboox").val()) {

                if (this.PID == 0 && this.PID == id) {
                    div += "<div class=\"units\">";
                    div += " <div class=\"item_title\"><span class=\"text\">" + this.Name + "</span><span class=\"icon icon-angle-down\"></span></div>";
                    BindleftMenu(data, this.Id);
                    if (i > 0) {
                        div += "</ul>";
                    }
                    i = 0;
                    div += "</div>";
                    TopMenuNum++;
                }
                else if (this.PID != 0 && this.PID == id) {
                    if (TopMenuNum == 0 && i == 0) {
                        div += "<ul class=\"contentbox\" style=\"display: block;\"><li class=\"active\" onclick=\"changeMenu(" + this.Id + ")\">\<span class=\"text\">" + this.Name + "</span> </li>";
                        $("#HChapterID").val(this.Id);
                    }
                    else if (TopMenuNum > 0 && i == 0) {
                        div += "<ul class=\"contentbox\">";
                    }
                    else if (i > 0) {
                        div += "<li onclick=\"changeMenu(" + this.Id + ")\">\<span class=\"text\">" + this.Name + "</span> </li>";
                    }
                    i++;
                }
            }
        })
        //getData(1, 10);
    }
    $(function () {
        if ($("#HChapterID").val() != "0" && $("#HChapterID").val() != undefined) {
            getData(1, 10);
        }
    });

    function changeMenu(id) {
        $("#HChapterID").val(id);
        getData(1, 10);
    }
    function menuSel()//menu折叠展开 选中切换
    {
        $('.items').find('.units').each(function () {
            var oLi = $('.items').find('li')
            oLi.click(function () {
                oLi.removeClass('active');
                $(this).addClass('active');
            });
            $(this).find('.item_title').click(function () {
                var $next = $(this).next();
                var $icon = $(this).find('.icon');
                $icon.toggleClass('active');
                $next.stop().slideToggle();
                $('.items').find('.contentbox').not($next).slideUp();
                $('.items').find('.icon').not($icon).removeClass('active');
            })
        })
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
                //学年
                BindPeriod();
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    //学年
    function BindPeriod() {
        $("#Period").children().remove();
        option = "<a href=\"javascript:;\" id='0' class=\"on\" onclick=' PeriodChangeall(0,this)' value=\"全部\">全部</a>";
        $("#Period").append(option);
        $("#HChapterID").val(0);
        if (CatagoryJson.GradeOfSubject.errNum.toString() == "0") {
            for (var i = 0, nm = CatagoryJson.GradeOfSubject.retData; i < nm.length; i++) {

                if (i == 0) {
                    option = "<a href=\"javascript:;\" id=\"gradename\" onclick=' PeriodChange(" + nm[i].GradeID + ",this)'>" + nm[i].GradeName + "</a>";
                    $("#HPeriod").val(0);
                    $("#Period").append(option);
                    BindSubject();
                }
                else if (nm[i].GradeName != nm[i - 1].GradeName) {
                    option = "<a href=\"javascript:;\" id=\"gradename\"' onclick='PeriodChange(" + nm[i].GradeID + ",this)'>" + nm[i].GradeName + "</a>";
                    $("#Period").append(option);
                }

            }
        }
        else {
            layer.msg(CatagoryJson.Period.errMsg);
        }
    }
    var gradeid = 0;
    var booo = "";
    function PeriodChangeall(GradeID, em) {
        $("#textbook").html("全部");
        gradeid = GradeID;
        $("#HTextboox").val(0);
        $("#HPeriod").val(GradeID);
        BindSubject();
        if ($("#HTextboox").val() == "0") {
            Chapator();
        }
        $("#Title").attr("value", "");
        $(em).addClass("on").siblings().removeClass("on");
        $("#HChapterID").attr("value", "");
        $("#sel_Type").attr("value", "");
        book = "";
        booo = book;
        getData(1, 10);
    }

    function PeriodChange(GradeID, em) {
        $("#textbook").html("全部");
        gradeid = GradeID;
        book = "" + GradeID + "|%|%|%";
        $("#HTextboox").val(0);
        TopMenuNum = 0;
        $("#HPeriod").val(GradeID);
        $(em).addClass("on").siblings().removeClass("on");
        $("#HChapterID").attr("value", "");
        if ($("#HTextboox").val() == "0") {
            Chapator();
        }
        BindSubject();
        booo = book;
        getData(1, 10);
    }
    //科目
    function BindSubject() {

        //var Period = $("#Period").val();
        //$("#HPeriod").val();
        $("#Subject").children().remove();
        var SelPeriod = $("#HPeriod").val();
        $("#HChapterID").attr("value", "");

        if (SelPeriod == "0") {
            option = "<a id='0'  class='on' onclick='SubjectChange(this)'>全部</a>";
            $("#Subject").append(option);
            $("#HChapterID").attr("value", "");
            //版本
            TextbookVersion();
            return;
        }

        option = "<a id='0' class='on' onclick='SubjectChangeall(this)'>全部</a>";
        $("#Subject").append(option);
        if (CatagoryJson.GradeOfSubject.errNum.toString() == "0") {
            var j = 0;
            $(CatagoryJson.GradeOfSubject.retData).each(function () {

                var option = "";
                if (this.GradeID == SelPeriod) {
                    if (j == 0) {

                        option = "<a id='" + this.SubjectID + "'  onclick='SubjectChange(this," + this.GradeID + ")'>" + this.SubjectName + "</a>";
                        $("#HSubject").val(0);
                        //版本
                        TextbookVersion();
                    }
                    else {
                        option = "<a id='" + this.SubjectID + "'onclick='SubjectChange(this)'> " + this.SubjectName + "</a>";
                    }
                    j++;
                    $("#Subject").append(option);
                }

            })
        }
        else {
            layer.msg(CatagoryJson.PeriodOfSubject.errMsg);
        }
    }
    var emid = 0;
    var bok = "";
    function SubjectChangeall(em) {
        $("#sput").html("收起");
        $("#textbookv").attr("style", "display: block;");
        $("#text").attr("style", "display: block;");
        $("#angle-down").attr("class", "icon fr icon-angle-up");
        $("#textbook").html("全部");
        emid = em.id;
        book = booo;
        $("#HSubject").val(em.id);
        TextbookVersion();
        $("#HTextboox").val(0);
        if ($("#HTextboox").val() == "0") {
            Chapator();
        }
        //版本
        $(em).addClass("on").siblings().removeClass("on");
        $("#HChapterID").attr("value", "");
        $("#sel_Type").attr("value", "");
        $("#Title").attr("value", "");
        bok = book;
        getData(1, 10);
    }

    function SubjectChange(em, GradeID) {
        $("#sput").html("收起");
        $("#textbookv").attr("style", "display: block;");
        $("#text").attr("style", "display: block;");
        $("#angle-down").attr("class", "icon fr icon-angle-up");
        $("#textbook").html("全部");
        emid = em.id;
        book = "" + GradeID + "|" + em.id + "|%|%";
        TopMenuNum = 0;
        $("#HSubject").val(em.id);
        $(em).addClass("on").siblings().removeClass("on");
        $("#HChapterID").attr("value", "");
        $("#HTextboox").val(0);
        if ($("#HTextboox").val() == "0") {
            Chapator();
        }
        //版本
        TextbookVersion();
        bok = book;
        getData(1, 10);
    }
    //版本
    function TextbookVersion() {
        $("#TextbookVersion").children().remove();
        var currentPeriod = $("#HPeriod").val();
        var currentSubjectID = $("#HSubject").val();
        $("#HChapterID").attr("value", "");
        $("#HTextboox").val(0);
        if (currentPeriod == "0" || currentSubjectID == "0") {
            option = "<a id='0' class='on' onclick='VersionChangeall(this)'>全部</a>";
            $("#TextbookVersion").append(option);
            $("#HChapterID").attr("value", "");
            Textbook();
            return;
        }
        option = "<a id='0'  class='on' onclick='VersionChangeall(this)'>全部</a>";
        $("#TextbookVersion").append(option);
        if (CatagoryJson.TextbookVersion.errNum.toString() == "0") {
            var i = 0

            $(CatagoryJson.TextbookVersion.retData).each(function () {

                var option = "";
                if (i == 0) {

                    option = "<a id='" + this.Id + "'  onclick='VersionChange(this)'>" + this.Name + "</a>";
                    $("#bookVersion").val(0);
                    Textbook();
                }
                else {
                    option = "<a id='" + this.Id + "' onclick='VersionChange(this)'>" + this.Name + "</a>";
                }
                $("#TextbookVersion").append(option);
                i++;
            })
        }
        else {
            layer.msg(CatagoryJson.TextbookVersion.errMsg);
        }
    }
    var vcid = 0;
    var bk = "";
    function VersionChangeall(em) {
        $("#textbook").html("全部");
        vcid = em.id;
        book = bok;
        $("#bookVersion").val(em.id);
        Textbook();
        $("#HTextboox").val(0);
        if ($("#HTextboox").val() == "0") {
            Chapator();
        }
        //版本
        $(em).addClass("on").siblings().removeClass("on");
        $("#HChapterID").attr("value", "");
        $("#sel_Type").attr("value", "");
        $("#Title").attr("value", "");
        bk = book;
        getData(1, 10);
    }

    function VersionChange(em) {
        $("#textbook").html("全部");
        vcid = em.id;
        book = "" + gradeid + "|" + emid + "|" + vcid + "|%";
        i = 0;
        TopMenuNum = 0;
        $("#bookVersion").val(em.id);
        $(em).addClass("on").siblings().removeClass("on");
        $("#HTextboox").val(0);
        $("#HChapterID").attr("value", "");
        if ($("#HTextboox").val() == "0") {
            Chapator();
        }
        Textbook();
        bk = book;
        getData(1, 10);
    }
    //教材
    function Textbook() {
        $("#HTextboox").val(0);
        var currentPeriod = $("#HPeriod").val();
        var currentSubjectID = $("#HSubject").val();
        $("#Textbook").children().remove();
        var bookVersion = $("#bookVersion").val();
        if (currentPeriod == "0" || currentSubjectID == "0" || bookVersion == "0") {
            option = "<a id='0' class='on' onclick=' TextbookChangeall(this)'>全部</a>";
            $("#Textbook").append(option);
            $("#BookName").html("全部");
            $("#HTextboox").val("0");
            return;
        }
        option = "<a id='0'  class='on' onclick=' TextbookChangeall(this)'>全部</a>";
        $("#Textbook").append(option);
        if (CatagoryJson.Textbook.errNum.toString() == "0") {

            var i = 0;
            $(CatagoryJson.Textbook.retData).each(function () {
                var option = "";
                if (bookVersion == this.VersionID && currentPeriod == this.GradeID && currentSubjectID == this.SubjectID) {

                    if (i == 0) {
                        option = "<a id='" + this.Id + "' onclick=' TextbookChange(this)' name='" + this.Name + "'>" + this.Name + "</a>";
                        $("#BookName").html(this.Name);
                        $("#HTextboox").val(0);
                        Chapator();
                    }
                    else {
                        option = "<a id='" + this.Id + "' onclick='TextbookChange(this)' name='" + this.Name + "'>" + this.Name + "</a>";
                    }
                    $("#Textbook").append(option);
                    i++;
                }

            })
        }
        else {
            layer.msg(CatagoryJson.Textbook.errMsg);
        }
        if ($("#HTextboox").val() == "0") {
            Chapator();
        }
    }
    var tbid = 0;
    var btk = "";
    function TextbookChangeall(em) {
        $("#textbook").html("全部");
        tbid = em.id;
        book = bk;
        $("#HTextboox").val(em.id);
        //版本
        $(em).addClass("on").siblings().removeClass("on");
        $("#HChapterID").attr("value", "");
        $("#sel_Type").attr("value", "");
        $("#Title").attr("value", "");
        btk = book;
        Chapator();
        getData(1, 10);
    }

    function TextbookChange(em, name) {
        $("#textbook").html(em.name);
        tbid = em.id;
        book = "" + gradeid + "|" + emid + "|" + vcid + "|" + tbid + "";
        TopMenuNum = 0;
        $(em).addClass("on").siblings().removeClass("on");
        $("#BookName").html($("#Textbook").text());
        $("#HTextboox").val(em.id);
        $("#HChapterID").attr("value", "");
        Chapator();
        btk = book;
        getData(1, 10);
    }

</script>
