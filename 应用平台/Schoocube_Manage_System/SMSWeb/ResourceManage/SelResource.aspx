<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelResource.aspx.cs" Inherits="SMSWeb.ResourceManage.SelResource" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <title>资源库</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/sprite.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>

    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <!--[if IE]>
			<script src="/js/html5.js"></script>
		<![endif]-->
    <script id="tr_User" type="text/x-jquery-tmpl">
        <li class="clearfix">
            <div class="checkbox fl">
                <input type='checkbox' value='${ID}' class='Check_box' name='Check_box' id='subcheck' />
            </div>
            <div class="docu_messages fl">
                <p class="docu_title" onclick="FileClick(${ID},'${FileUrl}')">
                    <span class="ico-${postfix1}-min h-ico">
                        <img style="width: 100%; height: auto;" /></span><a class="docu_name" href="#" title="${Name}">${cutstr(Name,40)}</a>
                </p>
                <div class="down_mes">
                    <%--<span class="down_mes">${FileGroup}</span>--%>
                    <span class="down_mes_dates">
                        <i class="test_type">{{if FileGroup==""}} 
                            其他 {{else}}
                            ${FileGroup}
                             {{/if}}
                        </i>
                        <em class="download_mes_date">${DateTimeConvert(CreateTime,'yyyy-MM-dd')}</em>
                    </span>
                </div>
            </div>
            <div class="unload_none" style="display: none">
                <%--<span class="upload">
                    <i class="icon icon-download-alt"></i>
                </span>--%>
                <span class="arrow-down pr">
                    <i class="icon" title="更多">
                        <img src="/images/xai.png" /></i>
                    <div class="arrow_downwrap">
                        <span class="rename" onclick="Down(${ID})">下载</span>
                        <span class="delete" onclick="Del(${ID},'${Name}')">删除</span>
                    </div>
                </span>
            </div>
            <div class="assess" id="${ClickNum}">

                <span id="1" onclick="Evalue(1,${ID},this)"></span>
                <span id="2" onclick="Evalue(2,${ID},this)"></span>
                <span id="3" onclick="Evalue(3,${ID},this)"></span>
                <span id="4" onclick="Evalue(4,${ID},this)"></span>
                <span id="5" onclick="Evalue(5,${ID},this)"></span>
            </div>
        </li>
    </script>
    <script id="tr_User1" type="text/x-jquery-tmpl">
        <li>
            <div class="checkbox">
                <input type="checkbox" name="Check_box" id="" value="" />
            </div>
            <div class="grid_view">
                <a href="#" onclick="FileClick(${ID},'${FileUrl}')">
                    <em class="ico-${postfix1}-max grid_view_ico">
                        <img style="width: 100%; height: auto;" /></em>
                    <p class="grid_view_name" title="${Name}">${cutstr(Name,12)}</p>
                </a>
                <%--<span class="down_mes">${FileGroup}</span>--%>
                <div class="grid_view_dates">
                    <span class="grid_view_date fl">${DateTimeConvert(CreateTime,'yyyy-MM-dd')}</span>

                </div>
            </div>
        </li>
    </script>
    <script id="tr_DowDetail" type="text/x-jquery-tmpl">
        <li>
            <div class="download_messages clearfix">
                <span class="date fl">${getDateDiff(ClickTime*1000)}
                </span>
                <span class="download_message fl">${CreateName}下载了
                </span>
            </div>
            <p class="download_title">
                <span class="ico-${postfix1}-min g-ico">
                    <img style="width: 100%; height: auto;" /></span><span class="download_name" title="${Name}">${Name}</span>
            </p>
        </li>
    </script>


</head>
<body>
    <form id="form1" runat="server">
        <div>
            <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />
            <input type="hidden" id="HUserName" runat="server" />
            <input type="hidden" id="HClassID" runat="server" />

            <asp:HiddenField ID="HSchoolID" runat="server" />
            <input id="HFoldUrl" type="hidden" value="/PubFolder" />
            <input id="code" type="hidden" value="0" />
            <input id="ShowType" type="hidden" value="1" />
            <input id="GroupName" type="hidden" value="" />
            <input id="Postfixs" type="hidden" value="" />
            <input id="ID" type="hidden" value="0" />
            <%-- 学段--%>
            <input id="HPeriod" type="hidden" value="0" />
            <%-- 科目--%>
            <input id="HSubject" type="hidden" value="0" />
            <%-- 教材--%>
            <input id="HTextboox" type="hidden" value="0" />
            <%-- 目录--%>
            <input id="HChapterID" type="hidden" value="0" />

            <input id="bookVersion" type="hidden" value="0" />

            <%--<header class="repository_header_wrap">
                <div class="width repository_header clearfix">
                    <a class="logo fl" href="/HZ_Index.aspx">
                        <img src="/images/logo.png" /></a>
                    <div class="wenzi_tips fl">
                        <img src="/images/ziyuanzhongxin.png" />
                    </div>--%>
            <div class="choiceversion">
                <div class="selected clearfix" style="background: #1783c7; padding: 10px; width: 100px;">
                    <strong>教育学部</strong>
                    <em class="trigger"><i class="icon-angle-down icon"></i></em>
                </div>
                <div class="contentbox">
                    <h2 class="subtitle">教材选择</h2>
                    <div class="item">
                        <select name="" id="Period" onchange="PeriodChange()">
                        </select>
                        <%--<input type="text" name="" id="" value="" placeholder="选择学段" />--%>
                    </div>
                    <div class="item">
                        <select name="" id="Subject" onchange="SubjectChange()">
                        </select>
                    </div>
                    <div class="item">
                        <select id="TextbookVersion" onchange="VersionChange()">
                        </select>
                    </div>
                    <div class="item">
                        <select id="Textbook" onchange="TextbookChange()">
                        </select>
                    </div>

                </div>
            </div>

            <!--内容-->
            <div class="grid clearfix" style="width: 100%">
                <div class="main clearfix">
                    <section class="menu fl">
                        <div class="grade pr">
                            <div class="item">
                                <span class="icon-th-list icon icon_list"></span>
                                <span class="title" id="BookName"></span>
                                <span class="icon icon-angle-right icon_right"></span>
                            </div>

                        </div>
                        <div class="items" id="menuChapater">
                        </div>

                    </section>
                    <section class="article_content fr bordshadrad">
                        <div class="modult_toolsbar clearfix">

                            <!--工具条-->
                            <div class="toolsbar fl">
                                <div class="bars">
                                    <a href="javascript:;" class="upload pr">
                                        <i class="icon  icon-upload-alt"></i>
                                        <span class="txt" onclick="CourceResource()">确定</span>
                                    </a>

                                </div>
                            </div>
                        </div>

                        <!--docu-->
                        <div class="docu_wrap">
                            <div class="docu_item none">
                                <a href="javascript:;" class="on" onclick="FileGroup('',this)">全部</a>
                                <a href="javascript:;" onclick="FileGroup('教案',this)">教案</a>
                                <a href="javascript:;" onclick="FileGroup('课件',this)">课件</a>
                                <a href="javascript:;" onclick="FileGroup('习题',this)">习题</a>
                                <a href="javascript:;" onclick="FileGroup('微课',this)">微课</a>

                            </div>

                            <!--内容-->
                            <div class="docu_content">

                                <!--docu_list-->
                                <ul class="document_list" style="display: block;" id="tb_MyResource">
                                </ul>
                                <ul class="docu_grid clearfix" id="tb_MyResource1">
                                </ul>
                            </div>
                        </div>
                        <!--分页-->
                        <div class="page" id="pageBar">
                        </div>
                    </section>
                </div>

            </div>
            <script src="/js/common.js"></script>
            <script type="text/javascript" src="/js/repository.js"></script>
        </div>
    </form>
</body>
<script type="text/javascript">
    function ResourceGroup() {
        $(".contentbox").hide();
    }
    $(document).ready(function () {

        BindCatagory();
        Chapator();
        var IsVideo = GetUrlDate.IsVideo;
        if (IsVideo == "1") {
            serchType('8', '');
        }
        else { serchType('', ''); }
    });
    function serchType(Postfixs, em) {
        $(em).parent().addClass("on").siblings().removeClass("on");

        $("#Postfixs").val(Postfixs);
        if ($("#ShowType").val() == "1") {
            getData(1, 10);
        }
        else {
            getData(1, 12);
        }
    }
    function getData(startIndex, pageSize) {
        var DocName = $("#search_w").val();
        var CatagoryID = $("#HPeriod").val() + "|" + $("#HSubject").val() + "|" + $("#bookVersion").val() + "|" + $("#HTextboox").val();

        //var CatagoryID = $("#HTextboox").val();
        var ChapterID = $("#HChapterID").val();
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        //name = name || '';
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            dataType: "json",
            data: { "PageName": "ResourceManage/PublicResoure.ashx", "Func": "GetPageList", PageIndex: startIndex, pageSize: pageSize, "DocName": DocName, "GroupName": $("#GroupName").val(), "Postfixs": $("#Postfixs").val(), "IDCard": $("#HUserIdCard").val(), "CatagoryID": CatagoryID, "ChapterID": ChapterID },
            success: function OnSuccess(json) {
                var ShowType = $("#ShowType").val();

                if (json.result.errNum.toString() == "0") {
                    if (ShowType == "1") {
                        $("#tb_MyResource").html('');
                        $("#tr_User").tmpl(json.result.retData.PagedData).appendTo("#tb_MyResource");
                    }
                    else {
                        $("#tb_MyResource1").html('');
                        $("#tr_User1").tmpl(json.result.retData.PagedData).appendTo("#tb_MyResource1");
                    }
                    $(".page").show();
                    makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                    //列表页与图标页每项划过显示
                    hoverShow($('.document_list li'), $('.unload_none'));
                    hoverShow($('.docu_grid li'), $('.checkbox'));
                    Star();
                }
                else {
                    $(".page").hide();
                    var html = '<div style="background: url(/images/error.png) no-repeat center center; height: 500px;"></div>';
                    if (ShowType == "1") {
                        $("#tb_MyResource").html(html);
                    }
                    else { $("#tb_MyResource1").html(html); }
                }
            }
,
            error: OnError
        });
    }

    function OnError(XMLHttpRequest, textStatus, errorThrown) {
        var htmlBq = '<li style="text-align:center;">无内容</li>';
        if (ShowType == "1") {
            $("#tb_UserList").html(htmlBq);
        }
        else { $("#tb_UserList1").html(htmlBq); }
    }
    //评价
    function Star() {
        //stars评价
        $('.document_list').find(".assess").each(function () {
            var num = $(this).attr("id");
            if (num > 0) {
                $(this).find("span").eq(num - 1).siblings().removeClass('on');
                $(this).find("span").eq(num - 1).prevAll().andSelf().addClass('on');
            }
        })
    }
    function hoverShow(hoverObj, showObj) {
        showObj.find('.arrow-down').click(function () {
            $(this).find('.arrow_downwrap').show();
        });
        hoverObj.find('input[type=checkbox]').click(function () {
            if ($(this).is(':checked')) {
                $(this).parents('li').addClass('active');
            } else {
                $(this).parents('li').removeClass('active');
            }
        });
        hoverObj.hover(function () {
            $(this).find(showObj).show();
        }, function () {
            $(this).find(showObj).hide();
            showObj.find('.arrow_downwrap').hide();
            if ($(this).find('input[type=checkbox]').is(':checked')) {
                $(this).find(showObj).show();
            }
        })
    }
    var GetUrlDate = new GetUrlDate();

    //资源绑定课程
    function CourceResource() {
        var ids = "";
        $("input[type=checkbox][name=Check_box]").each(function () {//查找每一个name为cb_sub的checkbox 
            if (this.checked) {
                ids += this.value + ",";
            }
        });
        if (ids == "") {
            layer.msg("未选择任何资源");
        }
        else {
            var weikePic = "";
            var ResourcesID = ids;
            var CourceID = GetUrlDate.CourceID;
            var ChapterID = GetUrlDate.ChapterID;
            var IsVideo = GetUrlDate.IsVideo;

            $.ajax({
                url: "/CourseManage/Uploade.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    func: "AddWeike", VidoeImag: weikePic, ResourcesID: ResourcesID, CourceID: CourceID, ChapterID: ChapterID, IsVideo: IsVideo
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        parent.layer.msg('操作成功!');
                        if (IsVideo == "1") {
                            parent.BindWeikeResource();
                        }
                        else {
                            parent.BindPutongResource();
                        } parent.CloseIFrameWindow();
                    } else {
                        layer.msg(result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg("操作失败！");
                }
            });
        }
    }

    function DownLoad(FoldUrl) {
        $.ajax({
            url: "/OnlineLearning/DownLoadHandler.ashx",
            type: "post",
            async: false,
            dataType: "text",
            data: {
                filepath: FoldUrl
            },
            success: function (result) {

                if (result == "-1") {
                    layer.msg('文件不存在!');
                    return;
                }
                else {
                    location.href = "/OnlineLearning/DownLoadHandler.ashx?filepath=" + FoldUrl + "&UserIdCard=" + $("#HUserIdCard").val() + "&time=" + new Date();
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg("资源不存在！");
            }
        });
    }
    //评价
    function Evalue(star, ID, em) { //stars评价
        if ($(em).parent().find(".on").length > 0) {
            layer.msg("不允许重复评论");
        }
        else {
            $(em).siblings().removeClass('on');
            $(em).prevAll().andSelf().addClass('on');

            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                // async: false,
                dataType: "json",

                data: { "PageName": "ResourceManage/PublicResoure.ashx", "Func": "Evalue", "ID": ID, "ClickType": "2", "IDCard": $("#HUserIdCard").val(), "Evalue": star },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("评价成功");
                        getData(1, 10);
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
    }
    function Chapator() {
        $("#HChapterID").val("");

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
        if (GetUrlDate.CourceID == null) {
            getData(1, 10);
        }
    }
    var div = "";
    var TopMenuNum = 0;

    function BindleftMenu(data, id) {

        var i = 0;
        $(data).each(function () {
            if (this.TextbooxID == $("#Textbook").val()) {

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
                if (this.PID != 0 && this.PID == id) {
                    if (TopMenuNum == 0 && i == 0) {
                        div += "<ul class=\"contentbox\" style=\"display: block;\"><li class=\"active\" onclick=\"changeMenu(" + this.Id + ")\">\<span class=\"text\">" + this.Name + "</span> </li>";
                        $("#HChapterID").val(this.Id);
                        // getData(1, 10);
                    }
                    if (TopMenuNum > 0 && i == 0) {
                        div += "<ul class=\"contentbox\">";
                    }
                    if (i > 0) {
                        div += "<li>\<span class=\"text\" onclick=\"changeMenu(" + this.Id + ")\">" + this.Name + "</span> </li>";
                    }
                    i++;
                }
            }
        })
        //if ($("#HChapterID").val() != "0" && $("#HChapterID").val() != undefined) {
        //    getData(1, 10);
        //}
    }
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
                //学段
                BindPeriod();
                //版本
                TextbookVersion();
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    //学段
    function BindPeriod() {
        $("#Period").children().remove();
        option = "<option value='0'>选择学段</option>";
        $("#Period").append(option);

        if (CatagoryJson.Period.errNum.toString() == "0") {
            var num = 0;
            $(CatagoryJson.Period.retData).each(function () {
                var option = "";
                if (num == 0) {
                    option = "<option value='" + this.Id + "'  selected='selected'>" + this.Name + "</option>";
                    $("#HPeriod").val(this.Id);
                    $("#Period").append(option);

                    BindSubject()
                }
                else {
                    option = "<option value='" + this.Id + "'>" + this.Name + "</option>";
                    $("#Period").append(option);
                }
                num++;
            })
        }
        else {
            layer.msg(CatagoryJson.Period.errMsg);
        }
        //getData(1, 10);

    }
    function PeriodChange() {
        ($("#HPeriod").val($("#Period").val()));
        BindSubject();
        Textbook();
        Chapator();
    }
    //科目
    function BindSubject() {
        $("#HSubject").val("0");
        var Period = $("#Period").val();
        $("#HPeriod").val(Period);
        $("#Subject").children().remove();
        option = "<option value='0'>选择科目</option>";
        $("#Subject").append(option);

        var SelPeriod = $("#HPeriod").val();
        if (CatagoryJson.PeriodOfSubject.errNum.toString() == "0") {
            var j = 0;
            $(CatagoryJson.PeriodOfSubject.retData).each(function () {
                var option = "";
                if (this.PeriodID == SelPeriod) {
                    if (j == 0) {
                        option = "<option value='" + this.SubjectID + "' selected='selected'>" + this.SubjectName + "</option>";
                        $("#HSubject").val(this.SubjectID);
                    }
                    else {
                        option = "<option value='" + this.SubjectID + "'>" + this.SubjectName + "</option>";
                    }
                    j++;
                    $("#Subject").append(option);
                }
            })
        }
        else {
            layer.msg(CatagoryJson.PeriodOfSubject.errMsg);
        }
        TextbookVersion();
        //getData(1, 10);

    }
    function SubjectChange() {
        $("#HSubject").val($("#Subject").val());

        Textbook();
    }
    //版本
    function TextbookVersion() {
        $("#bookVersion").val("0");
        var ChapterID = $("#HPeriod").val() + "|" + $("#HSubject").val() + "|" + $("#bookVersion").val() + "|" + $("#HTextboox").val();
        $("#TextbookVersion").children().remove();
        option = "<option value='0'  selected='selected'>教材版本</option>";
        $("#TextbookVersion").append(option);
        if ($("#HSubject").val() != "0") {
            if (CatagoryJson.TextbookVersion.errNum.toString() == "0") {
                var i = 0

                $(CatagoryJson.TextbookVersion.retData).each(function () {

                    var option = "";
                    if (i == 0) {
                        option = "<option value='" + this.Id + "'>" + this.Name + "</option>";
                        $("#bookVersion").val(this.Id);
                        Textbook();
                    }
                    else {
                        option = "<option value='" + this.Id + "'>" + this.Name + "</option>";
                    }
                    $("#TextbookVersion").append(option);
                    i++;
                })
            }
            else {
                layer.msg(CatagoryJson.TextbookVersion.errMsg);
            }
        }
        //getData(1, 10);

    }
    function VersionChange() {
        $("#bookVersion").val($("#TextbookVersion").val());
        Textbook();
        Chapator();
    }
    //教材
    function Textbook() {
        $("#HTextboox").val("0");

        var currentPeriod = $("#HPeriod").val();
        var currentSubjectID = $("#HSubject").val();
        $("#Textbook").children().remove();
        option = "<option value='0' selected='selected'>选择教材</option>";
        $("#Textbook").append(option);

        var bookVersion = $("#bookVersion").val();
        if (CatagoryJson.Textbook.errNum.toString() == "0") {
            var i = 0;

            $(CatagoryJson.Textbook.retData).each(function () {
                var option = "";
                if (bookVersion == this.VersionID && currentPeriod == this.PeriodID && this.SubjectID == currentSubjectID) {
                    if (i == 0) {
                        option = "<option value='" + this.Id + "' selected='selected'>" + this.Name + "</option>";
                        $("#BookName").html(this.Name);
                        $("#HTextboox").val(this.Id);
                    }
                    else { option = "<option value='" + this.Id + "'>" + this.Name + "</option>"; }
                    i++;
                    $("#Textbook").append(option);
                }

            })
        }
        else {
            layer.msg(CatagoryJson.Textbook.errMsg);
        }
        //getData(1, 10);

        //if ($("#HTextboox").val() != "0") {
        //    getData(1, 10);
        //}
    }
    function TextbookChange() {
        $("#BookName").html($("#Textbook").text());
        Chapator();
        $("#HTextboox").val($("#Textbook").val());
        //getData(1, 10);
    }
</script>
</html>
