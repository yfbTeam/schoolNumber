<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormOptionEdit.aspx.cs" Inherits="SMSWeb.Questionnaire.FormOptionEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>选问卷组卷</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
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
</head>
<body>
    <form id="form1" runat="server">
        <%-- 学段--%>
        <input id="HPeriod" type="hidden" value="0" />
        <%-- 科目--%>
        <input id="HSubject" type="hidden" value="0" />
        <%-- 教材--%>
        <input id="HTextboox" type="hidden" value="0" />
        <%-- 目录--%>
        <input id="HChapterID" type="hidden" value="0" />
         <input id="hidQuestionsID" type="hidden" value="0" />
        <input id="bookVersion" type="hidden" value="0" />
        <!--难度-->
        <input id="Difficult" type="hidden" value="0" />
        <!--题型-->
        <input id="hf_TypeId" type="hidden" value="0" />
        <!--题型分类-->
        <input id="hf_Type" type="hidden" value="2" />
        <input id="Status" type="hidden" value="1" />
        <asp:HiddenField ID="HPeriodid" runat="server" />
            <asp:HiddenField ID="HSubjectid" runat="server" />
            <asp:HiddenField ID="HTextbooxid" runat="server" />
            <asp:HiddenField ID="bookVersionid" runat="server" />
            <asp:HiddenField ID="HChapterIDid" runat="server" />
        <div>
            
            <header class="repository_header_wrap manage_header">
                <div class="width repository_header clearfix">
                    <a class="logo fl" href="/HZ_Index.aspx">
                <img src="/images/logo.png" /></a>
                    <div class="wenzi_tips fl">
                         <img src="/images/wenjuandiaocha.png" /></div>
                    <nav class="navbar menu_mid fl">
                        <ul>
                            <li currentclass="active"><a href="FormOption.aspx">问卷项管理</a></li>
                            <li currentclass="active" class="active"><a href="ExamManager.aspx">问卷管理</a></li>
                            <li currentclass="active"><a href="/analysisa/question.aspx">问卷调查统计</a></li>
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
                            问卷项类型
                        </div>
                        <div class="stytem_items_list fl" id="QuestionsID">
                            <a href="javascript:;" id='qb' class="on" onclick=' PeriodChangealls(0,this)' value="全部">全部</a>
                            <a href="javascript:;" id='sh'  onclick=' PeriodChangealls(1,this)' value="生活类">生活类</a>
                            <a href="javascript:;" id='xy' onclick=' PeriodChangealls(2,this)' value="校园类">校园类</a>
                        </div>
                    </div>

                </div>

            </div>
            <div class="width clearfix testsystem_wrap  pt20 pr">
                 <!--试题篮返回顶部-->
                <div class="testbask_backtop">
                    <div class="test_bask">
                        <span class="icon icon-shopping-cart"></span>
                        <i class="test_num" id="i_test_num">0
                        </i>
                        <div class="test_basket_wrap none">
                            <h1>试题篮
							<span class="fr">共计<span id="tcount">0</span>题</span>
                            </h1>
                            <div class="test_basklists">
                                <ul id="baskul">
                                   
                                </ul>
                                <div class="releasebtn">
                                    <a href="javascript:;" onclick="ClearTestbask();">清空全部</a>
                                    <a href="javascript:;" onclick="MakeExamPaper()">组卷</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="backTop mt10">
                        <span class="icon  icon-angle-up"></span>
                    </div>
                </div>
               
                <div class="bordshadrad" style="background: #fff;padding:20px;">
                    
                    <!---->
                    <div class="stytem_select clearfix">
                     
                        <div class="stytem_select_right fr">
                            <a href="FormOption.aspx">
                                <i class="icon icon-reply"></i>
                                <span>问卷管理</span>
                            </a>
                        </div>
                    </div>
                    <div class="selectionwrap">
                        <div class="select_nav clearfix pr">
                            <div class="select_nav_left fl">
                                题型:
                            </div>
                            <ul class="select_nav_right clearfix" id="qtypeul">
                                <%--<li class="on">
								<a href="javascript:;">全部</a>
							</li>
							<li>
								<a href="javascript:;">单选题</a>
							</li>
							<li>
								<a href="javascript:;">多选题</a>
							</li>
							<li>
								<a href="javascript:;">判断题</a>
							</li>
							<li>
								<a href="javascript:;">计算题</a>
							</li>
							<li>
								<a href="javascript:;">简答题</a>
							</li>
							<li>
								<a href="javascript:;">操作题</a>
							</li>
							<li>
								<a href="javascript:;">阅读题</a>
							</li>--%>
                            </ul>
                        </div>
                      
                    </div>
                    <div class="testbasket_top clearix">
                        <div class="test_total fl">
                            总计<span id="Qcount">0</span>道试题
                        </div>
                        <div class="test_tips fl">
                            提示：单击题面可显示答案和解析 
                        </div>
                        <div class="testbasket_topright fr cleafix">
                            <div class="labelcheck fl pr">
                                <input type="checkbox" name="" id="checkAll"/>
                                <label for="checkAll">显示答案与解析</label>
                            </div>
                           
                        </div>
                    </div>
                    <!--试题篮list-->
                    <div class="test_lists_basket">
                        <ul id="qDiv">
                           
                        </ul>
                    </div>
                    <!--分页-->
                    <div class="page">
                        <span id="pageBar"></span>

                    </div>
                    <!--fenye-->
                </div>
               
            </div>
            <script src="/js/common.js"></script>
            <script>
                $(function () {
                    //menu显示隐藏
                    $('.grade').find('.item').click(function () {
                        clickTab($('.grade'), '.icon_right');
                    });
                })
                //点击checkbox显示隐藏答案
                $('.labelcheck').click(function () {
                    var $check = $(this).find('input[type=checkbox]');
                    var $hidden = $('.test_lists_basket').find('.ques_answer');
                    if ($check.is(':checked')) {
                        $hidden.show();
                    } else {
                        $hidden.hide();
                    }
                })
                //试题库总数，右边显示 隐藏
                $('.test_bask').click(function () {
                    var $hidden = $(this).find('.test_basket_wrap');
                    if ($hidden.is(':hidden')) {
                        $hidden.show();
                    } else {
                        $hidden.hide();
                    }
                })
                //返回顶部
                backTop($('.backTop'), 400);
                //
                onscroll($('.testsystem_wrap>.menu'));
            </script>
       
    </form>
</body>
</html>
<script type="text/javascript">
    function accountManagement() {
        window.location.href = "/Gopay/Gopay.aspx";
    }
    function Mycenter() {
        window.open("/PersonalSpace/PersonalSpace_Student.aspx", "_blank")
    }
    function PeriodChangealls(QuestionsID, em) {
        $("#hidQuestionsID").val(QuestionsID);
        getData(1, 10);
    }

    function MakeExamPaper() {
        var Period = $("#HPeriod").val();
        var Subject = $("#HSubject").val();
        //var MajorID = Period.trim() == "" ? "" : (Subject.trim() == "" ? Period : (Period + "|" + Subject));
        var bookVersion = $("#bookVersion").val();
        var Textboox = $("#HTextboox").val();
        //MajorID = bookVersion.trim() == "" ? MajorID : (Textbook.trim() == "" ? MajorID + "&" + bookVersion : (MajorID + "&" + bookVersion + "|" + TextBook));
        var Chapter = $("#HChapterID").val();
        var parm = Period.trim() != "" ? (Subject.trim() != "" ? (bookVersion.trim() != "" ? (Textboox.trim() != "" ? (Chapter.trim() != "" ? ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&Textboox=" + Textboox + "&Chapter=" + Chapter + "&url=ManualChooseQ.aspx") : ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&Textboox=" + Textboox + "&url=ManualChooseQ.aspx")) : ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&url=ManualChooseQ.aspx")) : ("?Period=" + Period + "&Subject=" + Subject + "&url=ManualChooseQ.aspx")) : "?Period=" + Period + "&url=ManualChooseQ.aspx") : "?url=ManualChooseQ.aspx";
        location.href = "GenerateQption.aspx" + parm;
    }
    function MakeExamPaperintelligent() {
        var Period = $("#HPeriod").val();
        var Subject = $("#HSubject").val();
        //var MajorID = Period.trim() == "" ? "" : (Subject.trim() == "" ? Period : (Period + "|" + Subject));
        var bookVersion = $("#bookVersion").val();
        var Textboox = $("#HTextboox").val();
        //MajorID = bookVersion.trim() == "" ? MajorID : (Textbook.trim() == "" ? MajorID + "&" + bookVersion : (MajorID + "&" + bookVersion + "|" + TextBook));
        var Chapter = $("#HChapterID").val();
        var parm = Period.trim() != "" ? (Subject.trim() != "" ? (bookVersion.trim() != "" ? (Textboox.trim() != "" ? (Chapter.trim() != "" ? ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&Textboox=" + Textboox + "&Chapter=" + Chapter) : ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&Textboox=" + Textboox)) : ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion)) : ("?Period=" + Period + "&Subject=" + Subject)) : "?Period=" + Period) : "";
        location.href = "IntelligenceChooseQ.aspx" + parm;
    }

    var book = "";
    var HPeriodid = $("#HPeriodid").val();
    var HSubjectid = $("#HSubjectid").val();
    var HTextbooxid = $("#HTextbooxid").val();
    var bookVersionid = $("#bookVersionid").val();
    var HChapterIDid = $("#HChapterIDid").val();
    if (HSubjectid != "0") {
        $("#sput").html("收起");
    }
    $(function () {
        book = "" + HPeriodid + "|" + HSubjectid + "|" + bookVersionid + "|" + HTextbooxid + "";
        $("#HPeriod").val(HPeriodid);
        $("#HSubject").val(HSubjectid);
        $("#bookVersion").val(bookVersionid);
        $("#HTextboox").val(HTextbooxid);
        $("#HChapterID").val(HChapterIDid);
        BindCatagory();
        //Chapator();
        getBaskTypedata();
        getBaskdata();
        getType();
        getData(1, 10);
    });
    var baskdatajson = "";
    function getBaskdata() {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "getTestBasket"
            },
            success: function (json) {
                baskdatajson = json;
            }
            // error: OnError
        });
    }
    function getBaskTypedata() {

        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "getTextBasketTypeQ"
            },
            success: function (json) {
                var html = "";
                var count = 0;
                $.each(json.result.retData, function () {
                    count = parseInt(this.Count) + parseInt(count);
                    html += "<li><span>" + this.Type + "</span><span>" + this.Count + " 题 </span><span><i class=\"icona icon-trash\" onclick=\"deletetype(" + this.TypeID + ")\"></i></span></li>";


                });
                $("#baskul").html(html);
                $("#tcount").html(count);
                $("#i_test_num").html(count);
            },
            // error: OnError
        });
    }
    function ClearTestbask() {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "DelTestBasket"
            },
            success: function (json) {
                getData(1, 10);
                getBaskTypedata();
                var $btn = $('#qDiv li .ques_releasemes a');

                if ($btn.hasClass('ques_removebtn')) {
                    $btn.addClass('ques_addbtn').removeClass('ques_removebtn').html('加入试题');
                }

            },
            // error: OnError
        });
    }
    function deletetype(typeid) {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "DelTestBasket", "Type": typeid
            },
            success: function (json) {
                getData(1, 10);
                var $btn = $('#qDiv li .ques_releasemes a');

                if ($btn.hasClass('ques_removebtn')) {
                    $btn.addClass('ques_addbtn').removeClass('ques_removebtn').html('加入问卷');
                }
                getBaskTypedata();

            }
            // error: OnError
        });
    }
    function getType() {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                OptionType: 1,
                "action": "GetQuestionTypeList"
            },
            success: function (json) {
                var html = "";//"<li class=\"on\" ><a href=\"javascript:void(0);\" onclick='typesearch(\"\",\"\")'>全部</a></li>";
                var count = 0;
                $.each(json.result.retData, function () {
                    count = 1 + parseInt(count);
                    if (count == 1) {
                        html += "<li class='on'><a href=\"javascript:void(0);\" onclick='typesearch(" + this.ID + "," + this.QType + ")'>" + this.Title + "</a></li>";
                        $("#hf_TypeId").val(this.ID);
                    } else {
                        html += "<li><a href=\"javascript:void(0);\" onclick='typesearch(" + this.ID + "," + this.QType + ")'>" + this.Title + "</a></li>";
                    }
                    //$("#hf_TypeId").val(this.ID);
                    //$("#hf_Type").val(this.Template);
                });
                $("#qtypeul").html(html);
            },
            // error: OnError
        });
    }
    //获取数据
    function getData(startIndex, pageSize) {
        var QuestionsID = $("#hidQuestionsID").val() == "0" ? "0" : $("#hidQuestionsID").val();
        if (HPeriodid == 0) { book = ""; }
        var Period = $("#HPeriod").val();
        var Subject = $("#HSubject").val();
        var MajorID = book;
        var bookVersion = $("#bookVersion").val();
        var boox = $("#HTextboox").val();
        //MajorID = bookVersion == "" || bookVersion == "0" ? MajorID : (boox == "" || boox == "0" ? MajorID + "|" + bookVersion : (MajorID + "|" + bookVersion + "|" + boox));
        var Chapter = $("#HChapterID").val();
        var Status = $("#Status").attr("value");
        var TypeId = $("#hf_TypeId").val();
        var Difficult = "";// $("#Difficult").val();
        var Title = $("#Title").val();
        var qtype = $("#hf_Type").val();
        var action = "GetExamObjQList";
        if (qtype == 1) {
            action = "GetExamSubQList";
        }
        //初始化序号 
        pageNum = (startIndex - 1) * 8 + 1;
        //name = name || '';
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": action, PageIndex: startIndex, pageSize: pageSize,
                "KlpointID": Chapter, "Status": Status, "Type": TypeId, "Title": Title, "Difficult": Difficult, "MajorID": MajorID,
                "Questions": QuestionsID,  "Style": 1
            },
            success: OnSuccess,
            error: function (json) {
                $("#Qcount").text(0);
                $("#qDiv").html(json.result.errMsg.toString());
            }
        });
    }
    function OnSuccess(json) {
        if (json.result.errNum.toString() == "0") {
            var PagedData = json.result.retData.PagedData;
            var html = "";
            var count = 0;
            $.each(PagedData, function () {
                count++;
                html += "<li><div class=\"quesdiv\"><div class=\"ques_body\">";
                html += "<h1 class=\"ques_title\">";
                html += "	<em>" + this.Title + "</em>";
                html += "	<span class=\"test_type\">" + this.Type + "</span>";
                if (this.Difficult == 1) {
                    html += "<span class=\"test_easy\">" + this.Difficult + "</span>"
                } else if (this.Difficult == 2) {
                    html += "<span class=\"test_normal\">" + this.Difficult + "</span>"
                } else if (this.Difficult == 3) {
                    html += "<span class=\"test_trouble\">" + this.Difficult + "</span>"
                }
                html += "	</h1><div class=\"ques_detail\">";
                if (this.QType == 2) {
                    if (this.OptionA != "") {
                        var OptionA = "";
                        OptionA = "" + this.OptionA + "";
                        OptionA = OptionA.substr(OptionA.lastIndexOf("."), OptionA.length);
                        if (OptionA == ".png" || OptionA == ".jpeg" || OptionA == ".jpg") {
                            html += "A.<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionA + "\" style=\"width: 100px; height: auto;\" />";
                        } else { html += "<p>A：" + this.OptionA + "</p>"; }

                    }
                    if (this.OptionB != "") {
                        var OptionB = "";
                        OptionB = "" + this.OptionB + "";
                        OptionB = OptionB.substr(OptionB.lastIndexOf("."), OptionB.length);
                        if (OptionB == ".png" || OptionB == ".jpeg" || OptionB == ".jpg") {
                            html += "B.<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionB + "\" style=\"width: 100px; height: auto;\" />";
                        } else { html += "<p>B：" + this.OptionB + "</p>"; }

                    }
                    if (this.OptionC != "") {
                        var OptionC = "";
                        OptionC = "" + this.OptionC + "";
                        OptionC = OptionC.substr(OptionC.lastIndexOf("."), OptionC.length);
                        if (OptionC == ".png" || OptionC == ".jpeg" || OptionC == ".jpg") {
                            html += "C.<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionC + "\" style=\"width: 100px; height: auto;\" />";
                        } else { html += "<p>C：" + this.OptionC + "</p>"; }

                    }
                    if (this.OptionD != "") {
                        var OptionD = "";
                        OptionD = "" + this.OptionD + "";
                        OptionD = OptionD.substr(OptionD.lastIndexOf("."), OptionD.length);
                        if (OptionD == ".png" || OptionD == ".jpeg" || OptionD == ".jpg") {
                            html += "<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionD + "\" style=\"width: 100px; height: auto;\" />";
                        } else { html += "<p>D：" + this.OptionD + "</p>"; }

                    }
                    if (this.OptionE != "") {
                        var OptionE = "";
                        OptionE = "" + this.OptionE + "";
                        OptionE = OptionE.substr(OptionE.lastIndexOf("."), OptionE.length);
                        if (OptionE == ".png" || OptionE == ".jpeg" || OptionE == ".jpg") {
                            html += "<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionE + "\" style=\"width: 100px; height: auto;\" />";
                        } else { html += "<p>E：" + this.OptionE + "</p>"; }

                    }
                    if (this.OptionF != "") {
                        var OptionF = "";
                        OptionF = "" + this.OptionF + "";
                        OptionF = OptionF.substr(OptionF.lastIndexOf("."), OptionF.length);
                        if (OptionF == ".png" || OptionF == ".jpeg" || OptionF == ".jpg") {
                            html += "<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionF + "\" style=\"width: 100px; height: auto;\" />";
                        } else { html += "<p>F：" + this.OptionF + "</p>"; }

                    }
                }
                html += "</div></div>";
                html += "<div class=\"ques_answer none\">";
                if (this.QType == 2) {
                    html += "	<p>答案：</p>";
                } else { html += "	<p>参考答案：</p>"; }
                html += "	" + this.Answer + "";
                html += "	</div>";
                html += "	</div>";
                html += "<div class=\"ques_releasemes\">";
                html += "	<span class=\"ques_releasename fl\">添加人：" + this.Author + " </span>";
                html += "	<span class=\"ques_releasetime fl\">发布时间：" + this.CreateTime + "</span>";
                var isadd = false;
                var typeid = this.TypeID;
                var qid = this.ID;
                if (baskdatajson.result.errNum.toString() == "0") {
                    var baskjson = baskdatajson.result.retData;
                    $(baskjson).each(function () {
                        if (this.Type == typeid && this.ID == qid) {
                            isadd = true;
                        }
                    });
                }
                idcss = idcss.substr(0, idcss.length - 1);
                idcss.split(",");
                if (isadd) {
                    html += "	<a href=\"javascript:;\" class=\"ques_removebtn fr\"  onclick=\"DelqTextBasketbal(this," + this.ID + "," + this.TypeID + "," + this.QType + "," + this.Score + ")\">移除问卷</a>";

                } else {
                    html += "	<a href=\"javascript:;\" class=\"ques_addbtn fr\"  onclick=\"AddTextBasketbal(this," + this.ID + "," + this.TypeID + "," + this.QType + "," + this.Score + ")\">加入问卷</a>";

                }
                html += "</div>";
                html += "</li>";
            });
            if (html == "") { html = '<div style="background: url(/images/error.png) no-repeat center center; height: 500px;"></div>' }
            $("#Qcount").text(count);
            $("#qDiv").html(html);
            //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
            makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 8, json.result.retData.RowCount);
            //试题篮 添加移除试题动画调用


        } else {
            $("#Qcount").text(0);
            $("#qDiv").html('<div style="background: url(/images/error.png) no-repeat center center; height: 500px;"></div>');
            $('.page').hide();
        }
        //试题答案隐藏显示
        $('.test_lists_basket ul li').find('.quesdiv').click(function () {
            var $hidden = $(this).children('.ques_answer');
            if ($hidden.is(':hidden')) {
                $hidden.show();
            } else {
                $hidden.hide();
            }
        });
        liveAddquesBtn();
        liveDelquesBtn();
    }
    //添加到试题篮动画
    function liveAddquesBtn() {
        $('.test_lists_basket ul li').on('click', '.ques_addbtn', function () {
            console.log(1)
            var ques = $(this).parents('li').find('.ques_body');
            var ttop = ques.offset().top, tleft = ques.offset().left, width = ques.offset().width
            twidth = ques.width(), theight = ques.height();
            //得到试题篮的位置
            var cart = $(".test_bask");
            var top = cart.offset().top, left = cart.offset().left;

            var cloneQues = ques.clone().appendTo('body');
            cloneQues.css("position", "absolute")
            .css('top', top)
            .css('left', left)
            .css('background-color', '#F2F2F2')
            .css('border', '1px solid #00A2E6')
            .css('width', cart.width())
            .css('overflow', 'hidden')
            .css('height', cart.height());

            cloneQues.animate({
                left: (tleft) + "px", top: ttop + "px", opacity: "1",
                width: twidth, height: theight
            }, 800,
            function () {
                //将clone删除掉
                cloneQues.remove();
            });
        })
    }
    //移出试题篮动画
    function liveDelquesBtn() {
        //移除试题
        $('.test_lists_basket ul li').on("click", '.ques_removebtn', function () {
            console.log(2)
            var ques = $(this).parents('li').find('.ques_body');
            var top = ques.offset().top, left = ques.offset().left,
                    width = ques.width(), height = ques.height();
            var cart = $('.test_bask');
            var ttop = cart.offset().top, tleft = cart.offset().left,
                    twidth = cart.width(), theight = cart.height();
            var cloneQues = ques.clone().appendTo('body');
            cloneQues.css("position", "absolute")
            .css('top', top + (height - 80))
            .css('left', left)
            .css('border', '1px solid #00A2E6')
            .css('background-color', '#F2F2F2')
            .css('width', width)
            .css('overflow', 'hidden')
            .css('height', height);
            cloneQues.animate({
                left: (tleft) + "px", top: ttop + "px", opacity: "0",
                width: twidth, height: theight
            },
                    800,
                    function () {
                        //将clone删除掉
                        cloneQues.remove();
                    });
        });
    }
    function typesearch(id, QType) {
        $("#hf_TypeId").val(id);
        $("#hf_Type").val(QType);
        if (QType == "") {
            $("#hf_Type").val(2);
            getData(1, 10);
            $("#hf_Type").val(1);
        } getData(1, 10);
        siblingSelect();
    }
    function SelectDifficult(difficult) {
        $("#Difficult").val(difficult);
        getData(1, 10);
        siblingSelect();

    }
    function siblingSelect() {
        $('.select_nav_right li').on('click', function () {
            $(this).addClass('on').siblings().removeClass('on');
        })
    }
    function LookQuestion(Id, Qtype) {
        OpenIFrameWindow('查看问卷', 'LookQuestion.aspx?Id=' + Id + "&type=" + Qtype, '450px', '70%');
    }
    function ChangQstatus(obj, Id, Qtype) {
        var status = 1;
        if ($(this).hasClass("active")) { status = 2; }
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "ChangeQuestionStatus", DelID: ids, "Qtype": Qtype, "Status": status
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    if ($(this).hasClass("active")) { $(this).removeClass("active"); }
                }
            },
            error: function (errMsg) {

            }
        });
    }
    var idcss = "";
    function AddTextBasketbal(obj, id, typeid, Qtype, Score) {

        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "AddQToTesstBasket", "ID": id, "Type": typeid, "QType": Qtype, "Score": Score
            },
            success: function (json) {
                liveAddquesBtn();
                var html = "";
                var count = 0;
                if (json.result.errNum == 0) {

                    //$(obj).attr("disabled", "disabled");
                    $(obj).removeClass("ques_addbtn").addClass("ques_removebtn").html("移除问卷");
                    $(obj).attr("onclick", "DelqTextBasketbal(this," + id + ", " + typeid + ", " + Qtype + "," + Score + ")");
                    idcss += id + ",";
                    getBaskTypedata();
                }

            }
            // error: OnError
        });
        //}
        //var BookID = $("#hf_Book").val();
        //var KlpointID = $("#hf_Klpoint").val();
        //var parm = BookID.trim() != "" ? (KlpointID.trim() != "" ? ("?BookID=" + BookID + "&KlpointID=" + KlpointID) : "?BookID=" + BookID) : "";
        //OpenIFrameWindow('新增试题', 'AddQuestion.aspx' + parm, '450px', '70%');
    }
    function DelqTextBasketbal(obj, id, typeid, Qtype, Score) {
        var isadd = $(obj).attr("disabled");

        //if (isadd != "disabled") {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "DelTestBasket", "ID": id, "Type": typeid, "QType": Qtype, "Score": Score
            },
            success: function (json) {
                var html = "";
                liveDelquesBtn();
                var count = 0;
                if (json.result.errNum == 0) {

                    // $(obj).attr("disabled", "disabled");
                    $(obj).removeClass("ques_removebtn");
                    $(obj).addClass("ques_addbtn");
                    $(obj).html("加入问卷");
                    $(obj).attr("onclick", "AddTextBasketbal(this," + id + ", " + typeid + ", " + Qtype + "," + Score + ")");
                    getBaskTypedata();
                }

            },
            // error: OnError
        });
        //}
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
                    $("#chartp").find("#" + HChapterIDid + "").attr("class", "active");
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
                    div += "<div id=\"chartp\" class=\"units\">";
                    div += " <div class=\"item_title\"><span class=\"text\">" + this.Name + "</span><span class=\"icon icon-angle-down\"></span></div>";
                    BindleftMenu(data, this.Id);
                    if (i > 0) {
                        div += "</ul>";
                    }
                    i = 0;
                    div += "</div>";
                    TopMenuNum++;
                }
                if (this.PID != 0 && this.PID == id) {
                    if (TopMenuNum == 0 && i == 0) {
                        div += "<ul class=\"contentbox\" style=\"display: block;\"><li id=\"" + this.Id + "\" onclick=\"changeMenu(" + this.Id + ")\">\<span class=\"text\">" + this.Name + "</span> </li>";
                        $("#HChapterID").val(HChapterIDid);
                    }
                    if (TopMenuNum > 0 && i == 0) {
                        div += "<ul class=\"contentbox\">";
                    }
                    if (i > 0) {
                        div += "<li id=\"" + this.Id + "\" onclick=\"changeMenu(" + this.Id + ")\">\<span class=\"text\">" + this.Name + "</span> </li>";
                    }
                    i++;
                }
            }
        })
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
    //var CatagoryJson = "";
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
        option = "<a href=\"javascript:;\" id='0' onclick=' PeriodChangeall(0,this)' value=\"全部\">全部</a>";
        $("#Period").append(option);
        $("#HChapterID").val(0);
        if (CatagoryJson.GradeOfSubject.errNum.toString() == "0") {
            for (var i = 0, nm = CatagoryJson.GradeOfSubject.retData; i < nm.length; i++) {

                if (i == 0) {
                    option = "<a href=\"javascript:;\" id=\"" + nm[i].GradeID + "\" onclick=' PeriodChange(" + nm[i].GradeID + ",this)'>" + nm[i].GradeName + "</a>";
                    $("#HPeriod").val(HPeriodid);
                    $("#Period").append(option);
                    BindSubject();
                }
                else if (nm[i].GradeName != nm[i - 1].GradeName) {
                    option = "<a href=\"javascript:;\" id=\"" + nm[i].GradeID + "\"' onclick='PeriodChange(" + nm[i].GradeID + ",this)'>" + nm[i].GradeName + "</a>";
                    $("#Period").append(option);
                }

            }
            $('#Period').find("#" + HPeriodid + "").attr("class", "on");
            //$("#Period").find("a[id=" + HPeriodid + "]").attr("class", "on");
        }
        else {
            layer.msg(CatagoryJson.Period.errMsg);
        }
    }
    var gradeid = 0;
    var booo = "";
    function PeriodChangeall(GradeID, em) {
        HPeriodid = "0";
        HSubjectid = "0";
        HTextbooxid = "0";
        bookVersionid = "0";
        HChapterIDid = "0";
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
        HPeriodid = "0";
        HSubjectid = "0";
        HTextbooxid = "0";
        bookVersionid = "0";
        HChapterIDid = "0";
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
            option = "<a id='0' onclick='SubjectChangeall(this)'>全部</a>";
            $("#Subject").append(option);
            $("#HChapterID").attr("value", "");
            //版本
            TextbookVersion();
            $('#Subject').find("#" + HSubjectid + "").attr("class", "on");
            return;
        }

        option = "<a id='0' onclick='SubjectChangeall(this)'>全部</a>";
        $("#Subject").append(option);
        if (CatagoryJson.GradeOfSubject.errNum.toString() == "0") {
            var j = 0;
            $(CatagoryJson.GradeOfSubject.retData).each(function () {
                var option = "";
                if (this.GradeID == SelPeriod) {
                    if (j == 0) {

                        option = "<a id='" + this.SubjectID + "'  onclick='SubjectChange(this," + this.GradeID + ")'>" + this.SubjectName + "</a>";
                        $("#HSubject").val(HSubjectid);
                        //版本
                        TextbookVersion();
                    }
                    else {
                        option = "<a id='" + this.SubjectID + "'onclick='SubjectChange(this," + this.GradeID + ")'> " + this.SubjectName + "</a>";
                    }
                    j++;
                    $("#Subject").append(option);
                }

            });

            //$(this).parents('.dialog_detail').find('.checkbox').hide();
            //$("#Subject").find("a[id=" + HSubjectid + "]").attr("class", "on");
            if (HSubjectid > 0) {
                $("#textbookv").attr("style", "display: block;");
                $("#text").attr("style", "display: block;");
                $("#angle-down").attr("class", "icon fr icon-angle-up");
            }
        }
        else {
            layer.msg(CatagoryJson.PeriodOfSubject.errMsg);
        }
        $('#Subject').find("#" + HSubjectid + "").attr("class", "on");
    }
    var emid = 0;
    var bok = "";
    function SubjectChangeall(em) {
        $("#sput").html("收起");
        HPeriodid = "0";
        HSubjectid = "0";
        HTextbooxid = "0";
        bookVersionid = "0";
        HChapterIDid = "0";
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
        HPeriodid = "0";
        HSubjectid = "0";
        HTextbooxid = "0";
        bookVersionid = "0";
        HChapterIDid = "0";
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
            option = "<a id='0' onclick='VersionChangeall(this)'>全部</a>";
            $("#TextbookVersion").append(option);
            $("#HChapterID").attr("value", "");
            Textbook();
            $("#TextbookVersion").find("#" + bookVersionid + "").attr("class", "on");
            return;
        }
        option = "<a id='0' onclick='VersionChangeall(this)'>全部</a>";
        $("#TextbookVersion").append(option);
        if (CatagoryJson.TextbookVersion.errNum.toString() == "0") {
            var i = 0

            $(CatagoryJson.TextbookVersion.retData).each(function () {

                var option = "";
                if (i == 0) {

                    option = "<a id='" + this.Id + "'  onclick='VersionChange(this)'>" + this.Name + "</a>";
                    $("#bookVersion").val(bookVersionid);
                    Textbook();
                }
                else {
                    option = "<a id='" + this.Id + "' onclick='VersionChange(this)'>" + this.Name + "</a>";
                }
                $("#TextbookVersion").append(option);
                i++;
            });

        }
        else {
            layer.msg(CatagoryJson.TextbookVersion.errMsg);
        }
        $("#TextbookVersion").find("#" + bookVersionid + "").attr("class", "on");
    }
    var vcid = 0;
    var bk = "";
    function VersionChangeall(em) {
        HPeriodid = "0";
        HSubjectid = "0";
        HTextbooxid = "0";
        bookVersionid = "0";
        HChapterIDid = "0";
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
        HPeriodid = "0";
        HSubjectid = "0";
        HTextbooxid = "0";
        bookVersionid = "0";
        HChapterIDid = "0";
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
            option = "<a id='0' onclick=' TextbookChangeall(this)'>全部</a>";
            $("#Textbook").append(option);
            $("#BookName").html("全部");
            $("#HTextboox").val("0");
            $("#Textbook").find("#" + HTextbooxid + "").attr("class", "on");
            return;
        }
        option = "<a id='0' onclick=' TextbookChangeall(this)'>全部</a>";
        $("#Textbook").append(option);
        if (CatagoryJson.Textbook.errNum.toString() == "0") {

            var i = 0;
            $(CatagoryJson.Textbook.retData).each(function () {
                var option = "";
                if (bookVersion == this.VersionID && currentPeriod == this.GradeID && currentSubjectID == this.SubjectID) {

                    if (i == 0) {
                        option = "<a id='" + this.Id + "' onclick='TextbookChange(this)' name='" + this.Name + "'>" + this.Name + "</a>";
                        $("#BookName").html(this.Name);
                        $("#HTextboox").val(HTextbooxid);
                        Chapator();
                    }
                    else {
                        option = "<a id='" + this.Id + "' onclick='TextbookChange(this)' name='" + this.Name + "'>" + this.Name + "</a>";
                    }
                    $("#Textbook").append(option);
                    i++;
                }

            });

            //$("#Textbook").find("a[id=" + HTextbooxid + "]").attr("class", "on");
        }
        else {
            layer.msg(CatagoryJson.Textbook.errMsg);
        }
        $("#Textbook").find("#" + HTextbooxid + "").attr("class", "on");
        if ($("#HTextboox").val() == "0") {
            Chapator();
        }
    }
    var tbid = 0;
    var btk = "";
    function TextbookChangeall(em) {
        HPeriodid = "0";
        HSubjectid = "0";
        HTextbooxid = "0";
        bookVersionid = "0";
        HChapterIDid = "0";
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
        HPeriodid = "0";
        HSubjectid = "0";
        HTextbooxid = "0";
        bookVersionid = "0";
        HChapterIDid = "0";
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
    $("#textbook").html($("#Textbook").find("a[class=on]").val());
</script>
<script src="/js/common.js" type="text/javascript" charset="utf-8"></script>
<script src="/js/system.js" type="text/javascript" charset="utf-8"></script>
