<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Query.aspx.cs" Inherits="SMSWeb.Portal.Certificate.Query" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>证书搜索</title>
    <link href="//PortalCss/reset.css" rel="stylesheet" />
    <link href="/PortalCss/layout.css" rel="stylesheet" id="mystylesheet" runat="server" />
    <link href="/PortalCss/left.css" rel="stylesheet" id="myskin" runat="server" />

    <style>
        .certificate_dan {
            padding: 5px;
            margin: 0 auto;
        }

            .certificate_dan img {
                width: 461px;
                height: 338px;
            }

        .certificate_type {
            font-size: 14px;
            color: #555;
        }

        .certicate_lists {
        }

            .certicate_lists li {
                margin-top: 10px;
                width: 238px;
                padding: 5px;
                border: 1px solid #ccc;
                float: left;
                margin-left: 10px;
                margin-bottom: 0px;
            }

                .certicate_lists li a img {
                    overflow: hidden;
                    width: 100%;
                    height: 180px;
                }

                .certicate_lists li a p {
                    line-height: 32px;
                    color: #666;
                    font-size: 14px;
                    text-align: center;
                }

        .search_wrap {
            margin: 0px 10px;
            position: relative;
        }

            .search_wrap input[type=text] {
                float: left;
                height: 26px;
                border: 1px solid #9ec5e2;
                border-radius: 2px;
                width: 248px;
                padding-left: 90px;
                outline: none;
            }

            .search_wrap input[type=button] {
                background: #1472b9;
                padding: 7px 10px;
                font-size: 14px;
                color: #fff;
                border-radius: 0px 0px 2px 2px;
                border: none;
            }

        .search_select {
            width: 80px;
            height: 28px;
            background: #f5f5f5;
            position: absolute;
            top: 1px;
            left: 1px;
            border: 1px solid #EBEBEB;
        }

        .course_type {
            width: 70px;
            height: 70px;
            color: #fff;
            font-size: 14px;
            position: absolute;
            left: -35px;
            top: -35px;
            line-height: 120px;
            text-align: center;
            transform: rotate(-45deg);
            -webkit-transform: rotate(-45deg);
            -moz-transform: rotate(-45deg);
            -ms-transform: rotate(-45deg);
        }

        .course_bixiu {
            background: #19c857;
        }

        .course_xuanxiu {
            background: #f6a20f;
        }

        .btn {
            width: 118px;
            height: 30px;
            border: 1px solid #02609c;
            background: #1783c7;
            border-radius: 2px;
            display: block;
            margin: 10px auto;
            text-align: center;
            font-size: 14px;
            color: #fff;
        }
    </style>
    <script src="//Scripts/jquery-1.11.2.min.js"></script>
    <script src="//PortalJs/layout.js"></script>
    <script src="//Scripts/Common.js"></script>
    <script src="//Scripts/layer/layer.js"></script>
    <script src="//Scripts/jquery.tmpl.js"></script>
    <script src="//Scripts/PageBar.js"></script>
    <script type="text/javascript" src="//js/menu_top.js"></script>
    <script src="//Scripts/jquery.cookie.js"></script>
    <script src="//PortalJs/syslogin.js"></script>
    <script src="//PortalJs/header.js"></script>

    <script src="/js/jquery.jqprint.js"></script>
    <script src="/Scripts/jquery-migrate-1.1.0.js"></script>
    <script src="/Scripts/html2canvas.js"></script>



    <script id="tr_data" type="text/x-jquery-tmpl">
        <li><a href="javascript:OpenCertificate('${Attachment}')">
            <img src="${Attachment}" /><p>${cName}</p>
        </a></li>
    </script>
    <script id="tr_data2" type="text/x-jquery-tmpl">
        <li><a href="javascript:OpenCertificate('${ModelImage}')">
            <img src="${ModelImage}" /><p>${Name}</p>
        </a></li>
    </script>

    <script id="tr_leftTree" type="text/x-jquery-tmpl">
        {{if PId!=0}}
        {{if Id!=$("#HMenuId").val()}}
        <a href="#" data-url="${BeforeUrl}">${Name}</a>
        {{else}}
        <a href="#" class="on" data-url="${BeforeUrl}">${Name}</a>
        {{/if}}
        {{/if}}
    </script>

    <script type="text/x-jquery-tmpl" id="tr_course">
        <li class="clearfix">
            <div class="l-s fl" style="width: 238px; height: 175px; position: relative;">
                <a href="#">{{if ImageUrl==""}}
               <img src="/PortalImages/defaultimg.jpg" width="238" height="175" />
                    {{else}}
                <img src="${ImageUrl}" width="238" height="175" />
                    {{/if}}
                </a>
                <div class="course_type course_bixiu">
                    {{if IsCharge==1}}收费
                   {{else}}免费
                   {{/if}}

                </div>
            </div>
            <div class="r-s fl" style="height: 175px; overflow: hidden;">
                <h3 class="n"><a href="#">${Name}</a><span id="seedetail_${ID}" style="color: #1472b9; cursor: pointer; margin-left: 20px;" class="seedetail">查看证书</span></h3>
                <p>${CourseIntro}</p>
            </div>
            <div class="clear"></div>
            <div class="login_cer" id="cource_${ID}" style="display: none;">
                <h1 class="certificate_type" id="hlistCertificate"></h1>
                <ul id="tb_data" class="certicate_lists clearfix">
                    <%-- <li>
                        <a href="">
                            <img src="" /><p>dfadawd</p>
                        </a>
                    </li>
                     <li>
                        <a href="">
                            <img src="" /><p>dfadawd</p>
                        </a>
                    </li>--%>
                </ul>
            </div>
        </li>
    </script>
    <script id="tr_Certificate" type="text/x-jquery-tmpl">
        <li>
            <a href="javascript:OpenCertificate('${ModelImage}')">
                <img src="${ModelImage}" /><p>${Name}</p>
            </a>
        </li>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="HMenuId" runat="server" />
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HUserName" runat="server" />
        <input type="hidden" id="Hid_ClassID" runat="server" />
        <input type="hidden" id="HRoleType" runat="server" />
        <input type="hidden" id="HCertificateName" />
        <div class="top">
            <div class="top_con width clearfix">
                <h1 class="fl"><span class="tel"></span>全国咨询热线： 010- 62460887   &nbsp;  62461764    &nbsp; 62463259</h1>
                <div class="top_right fr clearfix">
                    <a href="#htmlFoot" name="#htmlFoot">
                        <div class="weixin fl" style="color: #fff">
                            <span></span>
                            官方微信

                        </div>
                    </a>
                    <a href="/Portal/Certificate/Query.aspx?id=11" class="fl" style="color: #fff; margin-left: 20px;">证书搜索</a>
                    <a href="#" class="fl" style="color: #fff; margin-left: 20px;" id="divSude" target="_blank">进入教育平台</a>
                    <a href="#" target="_blank" id="GoBBS" class="fl" style="color: #fff; margin-left: 20px;">进入论坛</a>
                    <div class="fr login_resig" id="loginItem">
                    </div>
                </div>
            </div>
        </div>
        <%-- <iframe name="htmlHeader" src="/headerTop.html" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="480px"></iframe>--%>
        <%--<div id="htmlHeader" style="min-height:155px;"></div>--%>
        <div id="header">
            <!--logo-->
            <div class="logo_search width clearfix">
                <div class="logo fl">
                    <img src="/PortalImages/logo.png" />
                </div>
                <!--<div class="search fr">
                <input type="text" placeholder="请输入关键词" />
                <input type="submit" value="搜索" />
            </div>-->
            </div>
            <!--nav-->
            <div class="nav">
                <div class="nav_a width">
                    <ul class="nav_b" id="menuList"></ul>
                </div>
            </div>
        </div>
        <div class="main width clearfix  mb20" style="margin-top: 20px;">
            <!--leftnav-->
            <div class="leftnav">
                <h1>
                    <span class="school_zn" id="hTitle"></span>
                    <span class="school_zy" id="szTitle"></span>
                </h1>
                <div class="leftnav_detail" style="min-height: 480px;" id="div_leftTree">
                </div>
            </div>
            <div class="content">
                <h1 class="crumbs">您当前的位置：<a href="/Portal/index.aspx">网站首页</a> <span>&gt;</span> <a href="" id="aTypeMenu"></a>
                </h1>
                <div class="content_detail" style="padding: 10px 0px; min-height: 484px;">
                    <div class="search_wrap">
                        <select class="search_select">
                            <option value="1" selected>证书编号</option>
                            <option value="2">课程</option>
                        </select>
                        <input type="text" placeholder="" id="StuNo" />
                        <input type="button" id="queryCertificate" value="搜索 " />
                    </div>
                    <div>
                        <div class="course_certificate mt10">
                            <ul class="o-list" id="courseList">
                                <%--   <li class="clearfix">            
                                     <div class="l-s fl" style="width:238px;height:175px;position:relative;">       
                                            <a href="/CourseManage/CourseDetail.aspx?itemid=86&amp;ParentID=20&amp;PageName=/CourseManage/CourseIndex.aspx">                                             <img src="/PortalImages/defaultimg.jpg" alt="" width="238" height="175" />           

                                            </a>     
                                            <div class="course_type course_bixiu">免费</div>         
                                     </div>          
                                    <div class="r-s fl" style="height:175px;overflow:hidden;"> 
                                            <h3 class="n"><a href="/CourseManage/CourseDetail.aspx?itemid=86&amp;ParentID=20&amp;PageName=/CourseManage/CourseIndex.aspx">诗歌鉴赏</a></h3>  
                                            <p></p>            
                                    </div>        
                                </li>--%>
                            </ul>
                        </div>
                        <%-- <div class="login_cer">
                            <%--登录成功之后
                            <h1 class="certificate_type" id="hlistCertificate"></h1>
                            <ul id="tb_data" class="certicate_lists clearfix">

                            </ul>
                        </div>--%>
                        <div class="nologin_cer mt10">
                            <h1 class="certificate_type" id="hCertificate"></h1>
                            <div class="certificate_dan">
                            </div>
                        </div>
                    </div>
                    <div class="page">
                        <span id="pageBar"></span>
                    </div>
                    <!--分页-->
                </div>
            </div>
        </div>
        <div id="certificateImg" style="display: none">
            <div class="preview_certificate" style="padding: 20px;">
                <img src="#" alt="" id="imgCertificate" style="width: 100%; margin: 10px auto;" />
                <div class="clearfix" style="width: 130px; margin: 0 auto;">
                    <input type="button" class="btn fl print" id="print" value="打印" style="width: 50px; float: left; margin-right: 10px;" />
                </div>
            </div>
        </div>
        <!--footer-->
        <iframe name="htmlFoot" id="htmlFoot" src="/bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="175px" style="margin-top: 20px;"></iframe>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            //$("#htmlHeader").load("/Portal/headerTop.html");
            getUserInfoCookie();
            initDisplay();
            initData(1, 10);
            leftTree();
            $(".leftnav_detail a").on('click', function () {
                var obj = $(this).attr("data-url");
                window.location.href = obj;
            })
            $("#queryCertificate").on('click', function () {
                Query();
            })


        });

        function initDisplay() {
            if ($("#HUserIdCard").val() != "" && $("#HRoleType").val() == "学生") {
                $(".search_wrap").hide();
            } else {
                $(".search_wrap").show();
            }
        }

        function initData(startIndex, pageSize) {
            if ($("#HRoleType").val() == "学生") {
                pageNum = (startIndex - 1) * pageSize + 1;
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        PageName: "/Certificate/Certificate.ashx",
                        Func: "GetCertificates",
                        IsPage: true,
                        PageIndex: startIndex,
                        PageSize: pageSize,
                        StuNo: $("#HUserIdCard").val(),
                        NStatus: 1
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            $("#courseList").html('');
                            var items = json.result.retData.PagedData;
                            if (items != null && items.length > 0) {
                                if (items.length == 1) {
                                    $("#hCertificate").html("已获得证书");
                                    $(".certificate_dan").html("<a href=\"javascript::\"><img src=\"" + items[0].Attachment + "\" style='display:block;margin:0 auto;'><p style=\"text-align:center;\">" + items[0].cName + "</p></a>");
                                } else {
                                    $("#hlistCertificate").html("已获得证书");
                                    $("#tr_data").tmpl(items).appendTo("#courseList");
                                    makePageBar(initData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                                }
                            }

                        }
                        else {
                            $("#courseList").html(" <li> 暂无数据！ </li>");
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {

                    }
                });
            }
        }



        function Query() {
            var sNo = $("#StuNo").val();
            if (sNo == "" || sNo.length == 0) {
                layer.msg("查询条件不能为空！");
                return false;
            };
            var selValue = $(".search_select").val();
            if (selValue == "1") {//证书编号
                getData(1, 10)
            } else {//课程
                getData2(1, 10);
            }
        }

        function getData(startIndex, pageSize) {
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "GetCertificates",
                    IsPage: true,
                    PageIndex: startIndex,
                    pageSize: pageSize,
                    Identifier: $("#StuNo").val(),
                    NStatus: 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_data").html('');
                        $("#courseList").html('');
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            if (items.length == 1) {
                                $("#hCertificate").html("");
                                $(".certificate_dan").html("<a href=\"javascript::\"><img src=\"" + items[0].Attachment + "\" style='display:block;margin:0 auto;'><p style=\"text-align:center;\">" + items[0].cName + "</p></a>");
                            } else {
                                $("#hlistCertificate").html("");
                                $("#tr_data").tmpl(items).appendTo("#tb_data");
                                makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                            }
                        }
                    }
                    else {
                        $("#courseList").html('');
                        $("#hCertificate").html("");
                        $("#hlistCertificate").html("");
                        $("#courseList").html("<li> 暂无数据！</li>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function getData2(startIndex, pageSize) {
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/PortalManage/AdminManager.ashx",
                    Func: "QueryCertificateForCourse",
                    PageIndex: startIndex,
                    pageSize: pageSize,
                    CourseName: $("#StuNo").val()
                },
                success: function (jsons) {
                    if (jsons != null && jsons.result.length > 0) {
                        $("#tb_data").html('');
                        $("#courseList").html('');
                        var json = jsons.result[0];//证书
                        var json2 = jsons.result[1];//课程
                        //if (json.errMsg == "success") {
                        //    var items = jsons.result[0].retData.PagedData;
                        //    if (items != null && items.length > 0) {
                        //        if (items.length == 1) {
                        //            $("#hCertificate").html("相关证书");
                        //            $(".certificate_dan").html("<a href=\"javascript::\"><img src=\"/images/template/template11_s.jpg\"></a>");
                        //        } else {
                        //            $("#hlistCertificate").html("相关证书");
                        //            $("#tr_data2").tmpl(items).appendTo("#tb_data");
                        //        }
                        //    }
                        //}
                        //else {
                        //    $("#hCertificate").html("");
                        //    $("#hlistCertificate").html("");
                        //    $("#tb_data").html(" <li> 暂无数据！ </li>");
                        //}
                        if (json.errMsg == "success") {
                            var items2 = jsons.result[1].retData.PagedData;//课程
                            var items = jsons.result[0].retData.PagedData;//证书
                            if (items != null && items.length > 0) {
                                var trueArry = [];
                                var idstrue = [];
                                for (var i = 0; i < items2.length; i++) {
                                    for (var j = 0; j < items.length; j++) {
                                        var ccid = items[j].CID;
                                        if (ccid == items2[i].ID) {
                                            if (idstrue.length == 0) {
                                                idstrue.push(ccid);
                                                trueArry.push(items2[i]);
                                            } else {
                                                var idstr = "," + idstrue.toString() + ",";
                                                if (idstr.indexOf("," + ccid + ",") > -1) {
                                                    break;
                                                } else {
                                                    idstrue.push(ccid);
                                                    trueArry.push(items2[i]);
                                                }
                                            }
                                        }
                                    }
                                }


                                $("#tr_course").tmpl(trueArry).appendTo("#courseList");
                                makePageBar(getData2, document.getElementById("pageBar"), json2.retData.PageIndex, json2.retData.PageCount, 10, trueArry.length);

                                $.each(trueArry, function (index, obj) {
                                    var evetID = obj.ID;
                                    var objUL = $("#cource_" + evetID).find("ul");

                                    var arry = [];

                                    for (var i = 0; i < items.length; i++) {
                                        if (evetID == items[i].CID) {
                                            arry.push(items[i]);
                                        }
                                    }
                                    $("#tr_Certificate").tmpl(arry).appendTo(objUL);
                                    if (arry.length == 0) {
                                        $('#seedetail_' + evetID).hide();
                                    }
                                })
                            }

                        } else {
                            $("#courseList").html('<li> 暂无证书！</li>');
                        }
                    }
                    //
                    $('#courseList>li').find('.seedetail').click(function () {
                        console.log(1)
                        var $slide = $(this).parents('div').siblings('.login_cer')
                        $slide.stop().slideToggle();
                        $('#courseList li .login_cer').not($slide).slideUp();
                    })
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function leftTree() {
            var html = "<a href=\"#\" data-url=\"/Portal/Certificate/Query.aspx?id=" + $("#HMenuId").val() + "\" class=\"on\" >证书搜索</a>";
            //html += "<a href=\"#\" data-url=\"/Portal/Certificate/Template.aspx?id=" + $("#HMenuId").val() + "\" >证书模板</a>";
            $("#div_leftTree").html(html);
            $("#aTypeMenu").html("证书搜索");
            $("#hTitle").html("证书搜索");
            $("#szTitle").html("Certificate");

            //$.ajax({
            //    url: "/Common.ashx",
            //    type: "post",
            //    async: false,
            //    dataType: "json",
            //    data: {
            //        PageName: "PortalManage/AdminManager.ashx",
            //        Func: "GetPortalTreeDataForChildId",
            //        MenuId: $("#HMenuId").val()
            //    },
            //    success: function (json) {
            //        if (json.result.errMsg == "success") {
            //            $("#div_leftTree").html('');
            //            var items = json.result.retData;
            //            $("#tr_leftTree").tmpl(items).appendTo("#div_leftTree");
            //            if (items != null) {
            //                for (var i = 0; i < items.length; i++) {
            //                    if (items[i].PId == "0") {
            //                        $("#hTitle").html(items[i].Name);
            //                        $("#szTitle").html(items[i].EnName);
            //                    }
            //                    if (items[i].Id == $("#HMenuId").val()) {
            //                        $("#aTypeMenu").html("证书搜索");
            //                        //$("#aTypeMenu").html(items[i].Name);
            //                    }
            //                }
            //            }
            //        }
            //        else {
            //            $("#div_leftTree").html("暂无数据！");
            //        }
            //    },
            //    error: function (XMLHttpRequest, textStatus, errorThrown) {

            //    }
            //});
        }

        function getUserInfoCookie() {
            if ($.cookie('LoginCookie_Cube') != null && $.cookie('LoginCookie_Cube') != "null" && $.cookie('LoginCookie_Cube') != "") {
                var UserInfo = $.parseJSON($.cookie('LoginCookie_Cube'));
                if (UserInfo != null) {
                    $("#HUserIdCard").val(UserInfo.IDCard);
                    $("#HUserName").val(UserInfo.LoginName);
                    $("#Hid_ClassID").val(UserInfo.ClassID);
                    $("#HRoleType").val(UserInfo.SF);
                }
            }
        }

        function OpenCertificate(imgSrc) {
            $(".preview_certificate").show();
            $("#imgCertificate").attr("src", "");
            $("#imgCertificate").attr("src", imgSrc);
            //OpenIFrameWindow('证书', 'AfterImgEdit.aspx?Id=${Id}&MenuId=${MenuId}', '700px', '500px');
            layer.open({
                type: 1,
                skin: 'layui-layer-rim', //加上边框
                area: ['480px', '480px'], //宽高
                content: $("#certificateImg").html()
            });
            $(".print").on('click', function () {
                $("#certificateImg").jqprint({
                    debug: false, //如果是true则可以显示iframe查看效果（iframe默认高和宽都很小，可以再源码中调大），默认是false
                    importCSS: true, //true表示引进原来的页面的css，默认是true。（如果是true，先会找$("link[media=print]")，若没有会去找$("link")中的css文件）
                    printContainer: true, //表示如果原来选择的对象必须被纳入打印（注意：设置为false可能会打破你的CSS规则）。
                    operaSupport: true//表示如果插件也必须支持歌opera浏览器，在这种情况下，它提供了建立一个临时的打印选项卡。默认是true
                });
            })
        }
    </script>
</body>
</html>
