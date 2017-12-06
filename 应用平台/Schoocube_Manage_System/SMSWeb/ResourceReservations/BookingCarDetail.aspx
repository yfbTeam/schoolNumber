<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookingCarDetail.aspx.cs" Inherits="SMSWeb.ResourceReservations.BookingCarDetail" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>资源预定</title>
    <!--图标样式-->
    <link rel="stylesheet" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <%--<link rel="stylesheet" type="text/css" href="/css/fullcalendar.css"/>--%>
    <link rel="stylesheet" href="/css/repository.css" />
    <link rel="stylesheet" href="/css/plan.css" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
			<script src="/js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/ResourceReservationMenu.js"></script>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script id="tr_BookingCarList" type="text/x-jquery-tmpl">
        <tr>
            <td>${Reason}</td>
            <td>${Applicant}</td>
            <td>${CarModel}</td>
            <td>${Address}</td>
            <td>${DateTimeConvert(AppoIntmentTime)}  
            </td>
            <td>${TimeInterval}
            </td>
            <td>{{if ApprovalStutus==0}}待审核{{/if}}
                {{if ApprovalStutus==1}}审核通过{{/if}}
                {{if ApprovalStutus==2}}无需审核{{/if}}
            </td>

            <td>
                <%--<a href="javascript:;" onclick="ViewBookCar(${Id})"><i class="icon icon-eye-open"></i></a>
                <a href="javascript:;" onclick="EditBookCar(this,${Id},${ApprovalStutus})"><i class="icon">
                    <img src="/images/shenpi.png" alt="" /></i></a>--%>
            </td>
        </tr>
    </script>
</head>
<body>
    <input type="hidden" id="HUserName" value="<%=Name%>" />
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUpdateRecords" value="" />
    <input type="hidden" id="HApprovalreservation" value="" />
    <!--header-->
    <header class="repository_header_wrap manage_header">
        <div class="width repository_header clearfix">
           <a class="logo fl" href="/HZ_Index.aspx">
                <img src="/images/logo.png" /></a>
            <div class="wenzi_tips fl">
                   <img src="/images/shixuenshiguanli.png" />
                </div>
            <nav class="navbar menu_mid fl">
                <ul id="ResourceMenu">
                    <%--<li currentclass="active"><a href="ResourceReservationInfo.aspx">基础数据维护</a></li>
                    <li currentclass="active"><a href="ResourceTimesManagement.aspx">时间段维护</a></li>
                    <li currentclass="active"><a href="BookingCar.aspx">资源预定</a></li>
                    <li currentclass="active" ><a href="AssetManagement.aspx">资产管理</a></li>--%>
                </ul>
            </nav>
            <div class="search_account fr clearfix">

                <ul class="account_area fl">
                    <li>
                        <a href="" class="dropdown-toggle">
                            <i class="icon icon-envelope" style="color:#fff;"></i>
                            <span class="badge"></span>
                        </a>
                    </li>
                    <li>
                        <a href="" class="login_area clearfix">
                            <div class="avatar">
                                <img src="<%=PhotoURL %>" />
                            </div>
                            <h2><%=Name %>
                            </h2>
                        </a>
                    </li>
                </ul>
                <div class="settings fl pr">
                    <a href="javascript:;">
                        <i class="icon icon-cog"></i>
                    </a>
                    <div class="setting_none">
                        <a href="/PersonalSpace/PersonalSpace_Teacher.aspx"><span>个人中心</span></a>
                        <span onclick="logOut()">退出</span>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div class="time_wrap pt90 width">
        <div class="booking_wrap bordshadrad">
            <div class="stytem_select clearfix">
                <div class="stytem_select_left fl">
                    <a href="" id="car" class="on">车辆</a>
                    <a href="" id="meeting">会议室</a>
                    <a href="" id="proroom">专业教室</a>
                </div>
            </div>
            <div class="booking_nav mt10">
                <a href="" class="on" id="carreservation">车辆预约</a>
                <a href="javascript:;" id="myapprovalreservation" onclick="myapprovalClick()">我的预约</a>
                <a href="" id="approvalreservation" onclick="approvalClick()">预约审批</a>
                
            </div>
            <div class="booking_des clearfix">
                <div class="mess_booking fl clearfix" id="CarDetailData">
                </div>
                <div class="stytem_select_right fr" style="width: auto; position: absolute; top: 0px; right: 0;">
                    <a href="" id="goBack">
                        <i class="icon icon-reply" style="color: #fff;"></i>
                        <span>返回上级</span>
                    </a>
                </div>
            </div>
            <div class="booking_mes_wrap">
                <!--车辆预约-->
                <div class="booking_detail mt10">
                    <div id="calhead" class="clearfix">
                        <div class="cHead">
                            <div class="ftitle">预约详情</div>
                        </div>
                        <div class="calbar clearfix">
                            <div id="sfprevbtn" title="上一周" class="fbutton">
                                <span class="fprev">◀</span>
                            </div>
                            <div id="sfnextbtn" title="下一周" class="fbutton">
                                <span class="fnext">▶</span>
                            </div>
                            <div id="showtodaybtn" class="fbutton">
                                <span title='跳转到当前周 ' class="showtoday">跳转到当前周</span>
                            </div>
                        </div>
                        <div>
                            <div id="dvCalMain" style="border: 1px solid #68aeda; border-left: none; border-top: none;">
                                <div id="gridcontainer" style="overflow-y: visible;"></div>
                            </div>
                        </div>
                    </div>
                    <div class="calendar_table">
                        <table cellspacing="0" cellpadding="0" id="tab">
                            <tbody id="tbTime">
                                <tr class="toptr">
                                    <th style="">时间段</th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="booking_approval" style="display: none;">
                    <table class="table_wrap mt10">
                        <thead class="thead">
                            <th>事由名称</th>
                            <th>申请人</th>
                            <th>车辆型号</th>
                            <th>场所</th>
                            <th>预约时间</th>
                            <th>时间段</th>
                            <th>状态</th>
                            <th>操作</th>
                        </thead>
                        <tbody class="tbody" id="tb_BookingCarList">
                        </tbody>
                    </table>
                    <!--分页-->
                    <div class="page">
                        <span id="pageBar"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="/js/common.js"></script>
    <script type="text/javascript" src="/js/repository.js"></script>
    <script type="text/javascript">
        var UrlDate = new GetUrlDate();
        $(document).ready(function () {
            ResourceMenu();
            setTabClass();
            getData();
            GetTimeInterval();
            dataWeek();
            var readerArry = [];
            //禁止th中德文本被选中
            if (document.all) {
                document.onselectstart = function () { return false; };
            }
            else {
                document.onmousedown = function () { return false; };
                document.onmouseup = function () { return true; };
            }
            document.onselectstart = new Function('event.returnValue=false;');

            var flag = false;
            $("#tab tr td").mouseover(function () {
                if (flag) {
                    var x = $(this).attr("rowindex");
                    var y = $(this).attr("colindex");
                    var select = $(this).attr("isselect");
                    readerArry.push(Array(x, y));
                    //判断是否向上还是向下
                    if (readerArry.length > 0) {
                        if (readerArry[0][1] != parseInt(y)) {
                            return false;
                           // readerArry.splice(y)
                        }
                        console.log('x '+x+' y '+y)
                        if (readerArry[0][0] < parseInt(x)) {//down

                            if (readerArry[readerArry.length - 2][0] < parseInt(x)) {
                                $(this).addClass("selected");
                                $(this).attr("appoint", "true");
                            } else if (readerArry[readerArry.length - 2][0] > parseInt(x)) {
                                $(this).parent('tr').next('tr').find('td[class=selected]').removeClass("selected");
                                $(this).removeAttr("appoint");
                            }
                        } else if (readerArry[0][0] > parseInt(x)) { //up
                            if (readerArry[readerArry.length - 2][0] > parseInt(x)) {
                                $(this).addClass("selected");
                                $(this).attr("appoint", "true");
                            } else if (readerArry[readerArry.length - 2][0] < parseInt(x)) {
                                $(this).parent('tr').prev('tr').find('td[class=selected]').removeClass("selected");
                                $(this).removeAttr("appoint");
                            }
                        } else {
                            $("#tab tr td").removeClass("selected");
                            $("#tab tr td").removeAttr('appoint');
                            $(this).addClass("selected");
                            $(this).attr("appoint", "true");
                        }
                    } else {
                        if (select == "true") {
                            flag = false;
                        }
                        else {
                            $(this).addClass("selected");
                            $(this).attr("appoint", "true");
                        }
                    }
                }
            });
            $("body").mouseup(function (e) {
                if (flag) {
                    readerArry = [];
                    flag = false;
                    submitData();
                }
            })
            //鼠标按下事件
            $("#tab tr td").mousedown(function (e) {
                var e = e || window.event;
                //var target = e.target || e.srcElement;
                var x = $(this).attr("rowindex");
                var y = $(this).attr("colindex");

                $("#tab tr td").removeClass("selected");
                var select = $(this).attr("isselect");
                var ifclick = $(this).attr("ifclick");
                if (select != "true" && ifclick != "false") {
                    flag = true;
                    $(this).addClass("selected");
                    $(this).attr("appoint", "true");
                    readerArry.push(Array(x, y));
                } else {
                    flag = false;
                    $(this).removeClass("selected");
                    $(this).removeAttr("appoint");
                    if (readerArry.length > 0) {
                        var saveArry = readerArry;
                        for (var k = 0; k < saveArry.length; k++) {
                            var arrItem = saveArry[k];
                            if (arrItem[0] == x && arrItem[1] == y) {
                                readerArry = readerArry.splice(k, 1);
                                break;
                            }
                        }
                    }
                }
            });

            BindResourceReservation();
        })
        $('.booking_nav a').click(function () {
            setTabClass();
            //$(this).addClass('on').siblings().removeClass('on');
            //var n = $(this).index();
            //$('.booking_mes_wrap>div').eq(n).show().siblings().hide();
        })
        $('.stytem_select_left a').click(function () {
            var url = "";
            $(this).addClass('on').siblings().removeClass('on');
            var name = $(this).text();
            if (name == "会议室") {
                $("#carreservation").text("会议室预约");
                $("#carreservation").addClass('on').siblings().removeClass('on');
                url = "BookingCar.aspx?Type=1&ResourceTypeName=" + name;
            } else if (name == "专业教室") {
                $("#carreservation").text("专业教室预约");
                $("#carreservation").addClass('on').siblings().removeClass('on');
                 url = "BookingCar.aspx?Type=2&ResourceTypeName=" + name;
            } else {
                $("#carreservation").text("车辆预约");
                $("#carreservation").addClass('on').siblings().removeClass('on');
                 url = "BookingCar.aspx?Type=0&ResourceTypeName=" + name;
            }
            //var url = "BookingCar.aspx?Type=3&ParentID=" + UrlDate.ParentID + "&PageName=" + UrlDate.PageName+"&ResourceTypeName=" + name;
            //$("#approvalreservation").attr("href", url);
            //var name = unescape(UrlDate.ResourceTypeName);
            //BookingCar.aspx?Type=1
            //if()
            //var url = "BookingCar.aspx?Type=1&ResourceTypeName=" + name;
            $(this).attr("href", url);
        })
        $(".stytem_select_right").bind("click", function () {
            //var name = UrlDate.ResourceTypeName;
            //var url = "BookingCar.aspx?TypeName=" + escape($("#approvalreservation").text()) + "&ParentID=" + UrlDate.ParentID + "&PageName=" + UrlDate.PageName + "&ResourceTypeName=" + name;
            //$(this).find("a").attr("href", url);
            var name = unescape(UrlDate.ResourceTypeName);
            var gobackUrl = "";
            if (name == "会议室") {
                gobackUrl = "BookingCar.aspx?Type=1&TypeName=" + escape($("#approvalreservation").text()) + "&ResourceTypeName=" + name;
                
            } else if (name == "专业教室") {
                $("#carreservation").text("专业教室预约");
                $("#carreservation").addClass('on').siblings().removeClass('on');
                gobackUrl = "BookingCar.aspx?Type=2&TypeName=" + escape($("#approvalreservation").text())+"&ResourceTypeName=" + name;
            } else {
                $("#carreservation").text("车辆预约");
                $("#carreservation").addClass('on').siblings().removeClass('on');
                gobackUrl = "BookingCar.aspx?Type=0&TypeName=" + escape($("#approvalreservation").text())+"&ResourceTypeName=" + name;
            }
            $(this).find("a").attr("href", gobackUrl);
        })

        function approvalClick() {
            var name = UrlDate.ResourceTypeName;
            //var name = unescape(decodeURI(UrlDate.ResourceTypeName));
            //var name = unescape(UrlDate.ResourceTypeName);
            var url = "BookingCar.aspx?Type=3&TypeName=" + escape($("#approvalreservation").text()) + "&ResourceTypeName=" + name;
            $("#approvalreservation").attr("href", url);
        }

        function myapprovalClick() {
            var name = UrlDate.ResourceTypeName;
            //var name = unescape(decodeURI(UrlDate.ResourceTypeName));
            //var name = unescape(UrlDate.ResourceTypeName);
            var url = "BookingCar.aspx?Type=4&TypeName=" + escape($("#myapprovalreservation").text()) + "&ResourceTypeName=" + name;
            $("#myapprovalreservation").attr("href", url);
        }
        var timeArray = [];

        function dataWeek() {
            var colNum = 0;
            timeArray = [];
            var cells = $(".toptr th:not(:first)");
            var clen = cells.length;
            var currentFirstDate;
            var formatDate = function (date) {
                var year = date.getFullYear();
                var month = (date.getMonth() + 1);
                var day = date.getDate();
                var week = '(' + ['星期天', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日'][date.getDay()] + ')';
                month = month < 10 ? "0" + month : month;
                day = day < 10 ? "0" + day : day;
                colNum++;
                timeArray += year + "-" + month + "-" + day + "/" + colNum + ",";
                return year + "-" + month + "-" + day + '  ' + week;
            };
            var addDate = function (date, n) {
                date.setDate(date.getDate() + n);
                return date;
            };
            var setDate = function (date) {
                var week = date.getDay() - 1;
                date = addDate(date, week * -1);
                currentFirstDate = new Date(date);

                for (var i = 0; i < clen; i++) {
                    cells[i].innerHTML = formatDate(i == 0 ? date : addDate(date, 1));

                }
            };
            document.getElementById('sfprevbtn').onclick = function () {
                timeArray = [];
                colNum = 0;
                setDate(addDate(currentFirstDate, -7));
                delDataClass();
                BindResourceReservation();

            };
            document.getElementById('sfnextbtn').onclick = function () {
                timeArray = [];
                colNum = 0;
                setDate(addDate(currentFirstDate, 7));
                delDataClass();
                BindResourceReservation();
            };
            document.getElementById('showtodaybtn').onclick = function () {
                timeArray = [];
                colNum = 0;
                setDate(new Date());
                delDataClass();
                BindResourceReservation();
            };
            setDate(new Date());
            //BindResourceReservation();
        }
        function delDataClass() {
            $('#tab tr').find('span').remove();
            $('#tab tr td').removeClass("selected");
        }

        var readerArry = [];
        function GetRequest() {
            var url = location.search; //获取url中"?"符后的字串
            var theRequest = new Object();
            if (url.indexOf("?") != -1) {
                var str = url.substr(1);
                strs = str.split("&");
                for (var i = 0; i < strs.length; i++) {
                    theRequest[strs[i].split("=")[0]] = (strs[i].split("=")[1]);
                }
            }
            return theRequest;
        }
        function getQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;

        }
        //add code
        var chapterDiv = "";
        function getData() {
            var ID = UrlDate.Id;

            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "ResourceReservations/ResourceReservationInfoHandler.ashx", "Func": "GetPageList", "ID": ID, "ispage": "false"
                },
                success: OnSuccess,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }
        //获取数据成功显示列表
        function OnSuccess(json) {
            chapterDiv = "";
            var Image = "";
            if (json.result.errNum.toString() == "0") {
                Image = "";
                //var name = unescape(decodeURI(UrlDate.ResourceTypeName));
                var name = unescape(UrlDate.ResourceTypeName);
                if (name == "车辆") {
                    $(json.result.retData).each(function (i, n) {
                        if (n.Image == "" || n.Image == null) {
                            Image = "/images/car_01.png";
                        } else {
                            var image="/images/fpsc.jpg";
                            if (n.Image == image) {
                                Image = "/images/car_01.png";
                            } else {
                                Image = n.Image;
                            }
                        }
                        chapterDiv += "<div class=\"img_booking fl\"><img src='" + Image + "' alt=\"\"></div>"
                        chapterDiv += "<div class=\"des_booking fl\" id=" + n.Id + ">";
                        chapterDiv += "<p>名称：" + n.Name + "</p>";
                        chapterDiv += "<p>型号：" + n.Model + "</p>";
                        chapterDiv += "<p>座位数：" + n.SeatNum + "</p>";
                        chapterDiv += "</div>";
                    });
                } else if (name == "会议室") {
                    $(json.result.retData).each(function (i, n) {
                        if (n.Image == "" || n.Image == null) {
                            Image = "/images/meeting_02.jpg";
                        } else {
                            var image="/images/fpsc.jpg";
                            if (n.Image == image) {
                                Image = "/images/meeting_02.jpg";
                            } else {
                                Image = n.Image;
                            }
                        }
                        chapterDiv += "<div class=\"img_booking fl\"><img src='" + Image + "' alt=\"\"></div>"
                        chapterDiv += "<div class=\"des_booking fl\" id=" + n.Id + ">";
                        chapterDiv += "<h1 class='metting_title'>" + n.Name + "</h1>";
                        chapterDiv += "<p>地址：" + n.Address + "</p>";
                        chapterDiv += "<p>面积：" + n.Area + "</p>";
                        chapterDiv += "<p>开放时间：" + n.OpenTime + "</p>";
                        chapterDiv += "<p>限定人数：" + n.Galleryful + "</p>";
                        chapterDiv += "</div>";
                    });
                } else {
                    $(json.result.retData).each(function (i, n) {
                        if (n.Image == "" || n.Image == null) {
                            Image = "/images/meeting_01.png";
                        } else {
                            var image="/images/fpsc.jpg";
                            if (n.Image == image) {
                                Image = "/meeting_01.png";
                            } else {
                                Image = n.Image;
                            }
                        }
                        chapterDiv += "<div class=\"img_booking fl\"><img src='" + Image + "' alt=\"\"></div>"
                        chapterDiv += "<div class=\"des_booking fl\" id=" + n.Id + ">";
                        chapterDiv += "<h1 class='metting_title'>" + n.Name + "</h1>";
                        chapterDiv += "<p>专业教室名称：" + n.Name + "</p>";
                        chapterDiv += "<p>楼层：" + n.Floor + "</p>";
                        chapterDiv += "<p>地址：" + n.Address + "</p>";
                        chapterDiv += "<p>房间号:" + n.Room + "</p>";
                        chapterDiv += "<p>开放时间：" + n.OpenTime + "~" + n.ClosedTime + "</p>";
                        chapterDiv += "<p>容纳人数:" + n.Galleryful + "</p>";
                        chapterDiv += "</div>";
                    });
                }

                $("#CarDetailData").html(chapterDiv);

            } else {
                var html = '<div style="background: url(/images/error.png) no-repeat center center; height: 500px;"></div>';
                $("#CarDetailData").html(html);

                layer.msg(json.result.errMsg);

            }
        }

        //如果name不是车辆对应的tab on
        function setTabClass() {
            var Url = "";
            //var name = unescape(decodeURI(UrlDate.ResourceTypeName));
            var name = unescape(UrlDate.ResourceTypeName);
            //var name = UrlDate.ResourceTypeName;
            if (name == "会议室") {
                $(".stytem_select_left a[id=meeting]").addClass('on').siblings().removeClass('on');
                $("#carreservation").text("会议室预约");
                Url = "BookingCar.aspx?Type=1&ResourceTypeName=" + UrlDate.ResourceTypeName;
            } else if (name == "专业教室") {
                $(".stytem_select_left a[id=proroom]").addClass('on').siblings().removeClass('on');
                $("#carreservation").text("专业教室预约");
                Url = "BookingCar.aspx?Type=2&ResourceTypeName=" + UrlDate.ResourceTypeName;
            } else {
                $(".stytem_select_left a[id=car]").addClass('on').siblings().removeClass('on');
                $("#carreservation").text("车辆预约");
                Url = "BookingCar.aspx?Type=0&ResourceTypeName=" + UrlDate.ResourceTypeName;
            }
            $("#carreservation").attr("href", Url);
            if ($("#HApprovalreservation").val() == "审批") {
                $("#approvalreservation").show();
            } else {
                $("#approvalreservation").hide();
            }
        }
        var timeIntervalArry = [];
        //公共方法获取时间段
        function GetTimeInterval() {
            var timeli = "";
           // var name = getQueryString("ResourceTypeName");
            // var name = unescape(decodeURI(UrlDate.ResourceTypeName));
            var name = unescape(UrlDate.ResourceTypeName);
            var resourceId = UrlDate.ResourceId;
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "ResourceReservations/TimeManagementHandler.ashx", "Func": "GetTimeManagementList",
                    "GetTime": "1", "Name": name, "ispage": "false", "ResourceId": resourceId
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function (i, n) {
                            if (n.Id != "") {
                                var obj = new Object();
                                obj.Id = n.Id;
                                timeIntervalArry.push(obj);
                            }
                            var tr = "tr";
                            var trNum = i + 1;
                            timeli += "<tr id='" + (tr + trNum) + "'>";
                            timeli += "<th>" + n.BeginTime + "~" + n.EndTime + "</th>";
                            timeli += "<td rowindex='" + (trNum + 1) + "'colindex='1' id='" + n.Id + "'></td>";
                            timeli += "<td rowindex='" + (trNum + 1) + "'colindex='2' id='" + n.Id + "'></td>";
                            timeli += "<td rowindex='" + (trNum + 1) + "'colindex='3' id='" + n.Id + "'></td>";
                            timeli += "<td rowindex='" + (trNum + 1) + "'colindex='4' id='" + n.Id + "'></td>";
                            timeli += "<td rowindex='" + (trNum + 1) + "'colindex='5' id='" + n.Id + "'></td>";
                            timeli += "<td rowindex='" + (trNum + 1) + "'colindex='6' id='" + n.Id + "'></td>";
                            timeli += "<td rowindex='" + (trNum + 1) + "'colindex='7' id='" + n.Id + "'></td>";
                            timeli += "</tr>";
                        });

                        $("#tbTime").append(timeli);
                    } else {

                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
            if (chapterDiv.length == 0) {
                layer.msg("没有可用的时间段,请去时间段维护添加...");
            }
        }

        function submitData() {
            var para = '';
            var cells = $(".toptr th");
            var thisy = "";
            var timeManageId = "";
            var selectData = "";
            var id = "";
            var  currentTimeInterval = "";
            var arrCurrentTimeInterval = [];
            var datetime = new Date();
            var year = datetime.getFullYear();
            var month = (datetime.getMonth() + 1);
            var day = datetime.getDate();
            var hour = datetime.getHours();
            var minutes = datetime.getMinutes();
            var seconds = datetime.getSeconds();
            if (month < 10) {
                month = "0" + month;
            } else {
                month = month;
            }

            if (day < 10) {
                day = "0" + day;
            } else {
                day = day;
            }
            var today = year + "-" + month + "-" + day;
            var timeToday = hour + ":" + minutes + ":" + seconds;
            var isOpen = false;
            $("#tab tr td").each(function (i, n) {
                if ($(this).hasClass("selected")) {
                    var thisx = $(this).attr("rowindex");
                    thisy = $(this).attr("colindex");
                    timeManageId += $(this).attr("id") + ",";
                    para += "B" + thisx + "A" + thisy;
                    id = $(this).find("span").attr("id");
                }
            });
            if (thisy != "" || thisy != undefined || thisy != null) {
                var strDateTime = cells[thisy].innerText;
                if (strDateTime.indexOf(" (") > -1) {
                    var index = strDateTime.indexOf(" (");
                    selectData = strDateTime.substring(0, index);
                }
            }
            if (timeManageId != "" || timeManageId != null) {
                timeManageId = timeManageId.substring(0, timeManageId.length - 1);
            }
            if (para == '') {
                alert("你还没有预定！");
            }
            else {
                $("#tab tr").each(function (i, n) {
                    if ($(this).children("td").hasClass("selected")) {
                        var interval = $(this).children("th").text();
                        currentTimeInterval += interval + ",";
                    }
                });
                var strTimeDate = timeArray.split(",");
                for (var strdate = 0; strdate < strTimeDate.length; strdate++) {
                    //isOpen = false;
                    var index = strTimeDate[strdate].indexOf("/");
                    var time = strTimeDate[strdate].substring(0, index);
                    var colindex = strTimeDate[strdate].substring(index + 1);
                    if (thisy == colindex) {
                        if (time < today) {
                            if (id == "" || id == null || typeof (id) == "undefined") {
                                $("#tab tr td").removeClass("selected");
                                $("#tab tr td").removeAttr('appoint');
                                layer.alert("不能预约" + today + "之前的日期");
                                isOpen = false;
                                break;
                                
                            } 
                        } else if (time == today) {
                            if (id == "" || id == null) {
                            var arrTime = "";

                            var arrTimeInterval = currentTimeInterval.substring(0, currentTimeInterval.length - 1);
                            if (arrTimeInterval.length > 0) {
                                arrCurrentTimeInterval = arrTimeInterval.split(",");
                            }
                            for (var strTimeInterval = 0; strTimeInterval < arrCurrentTimeInterval.length; strTimeInterval++) {
                                var index = arrCurrentTimeInterval[strTimeInterval].indexOf("~");
                                arrTime = arrCurrentTimeInterval[strTimeInterval].substring(index + 1);
                                if (arrTime < timeToday || arrTime == timeToday) {
                                    $("#tab tr td").removeClass("selected");
                                    $("#tab tr td").removeAttr('appoint');
                                    layer.alert("您选的时间段已过时了,请重新选择！");
                                    isOpen = false;
                                    break;
                                }
                            }

                            if (arrTime > timeToday) {
                                isOpen = true;
                                break;
                            }
                            } else {
                                isOpen = true;
                                break;
                            }
                            
                            
                        }else {
                            isOpen = true;
                            break;
                        }
                    }
                }

                
                if (isOpen) {
                    $("#tab tr td").removeClass("selected");
                    $("#tab tr td").removeAttr('appoint');
                    var isUpdateRecords = "";
                    isUpdateRecords =$("#HUpdateRecords").val();
                    if (id == "" || id == null) {
                        OpenIFrameWindow('预约页面', 'ResourceReservationAdd.aspx?ReSourceInfoId=' + UrlDate.Id + '&ReSourceClassId=' + UrlDate.ResourceId + '&selectData=' + selectData + '&TimeInterval=' + timeManageId, '700px', '500px');
                    } else {
                        OpenIFrameWindow('编辑预约页面', 'ResourceReservationAdd.aspx?ID=' + id + '&isUpdateRecords=' + isUpdateRecords, '700px', '500px');
                    }
                } 
            }
        }

        var strTd = "";
        function BindResourceReservation() {
            var ID = "";
            if (GetRequest().Id != null) {
                ID = GetRequest().Id;
            }
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "ResourceReservations/ResourceReservationHandler.ashx", "Func": "GetPageList", "ReSourceInfoId": ID, "ispage": "false"
                },
                success: OnResourceReservationsSuccess,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }

        function OnResourceReservationsSuccess(json) {
            var strRr = [];//资源预定信息
            var strTimeInterval = [];//资源预定里时间段信息以，分割
            var strTime = [];//头部日期信息
            var strApprovalStutus = "";
            
            if (json.result.errNum.toString() == "0") {
                $(json.result.retData).each(function (j, m) {
                    var obj = new Object();
                    obj.Id = m.Id;
                    obj.Name = m.Name;
                    obj.AppoIntmenTime = DateTimeConvert(m.AppoIntmentTime);
                    obj.TimeInterval = m.TimeInterval;
                    obj.Telephone = m.Telephone;
                    obj.Applicant = m.Applicant;
                    obj.Address = m.Address;
                    if (m.ApprovalStutus == "0") {
                        strApprovalStutus = "待审批";
                    } else if (m.ApprovalStutus == "3")
                    {
                        strApprovalStutus = "审批未通过";
                    } else {
                        strApprovalStutus = "已预约";
                    } 
                    obj.ApprovalStutus = strApprovalStutus;
                    strRr.push(obj);
                });
            }
            //时间段
            if (timeIntervalArry.length > 0) {
                for (var i = 0; i < timeIntervalArry.length; i++) {
                    for (var j = 0; j < strRr.length; j++) {
                        if (strRr[j].TimeInterval != null || strRr[j].TimeInterval != undefined || strRr[j].TimeInterval != "") {
                            strTimeInterval = strRr[j].TimeInterval.split(",");
                            for (var k = 0; k < strTimeInterval.length; k++) {
                                //判断左侧时间段是否匹配资源预定信息的时间段
                                if (timeIntervalArry[i].Id == strTimeInterval[k]) {
                                    //行索引
                                    var rowindex = $("#" + timeIntervalArry[i].Id).attr("rowindex");
                                    if (timeArray != null || timeArray != undefined || timeArray != "") {
                                        strTime = timeArray.split(",");
                                        if (strTime.length > 0) {
                                            for (var p = 0; p < strTime.length; p++) {
                                                var index = strTime[p].indexOf("/");
                                                var time = strTime[p].substring(0, index);
                                                var colindex = strTime[p].substring(index+1);
                                                if (strRr[j].AppoIntmenTime != null || strRr[j].AppoIntmenTime != undefined || strRr[j].AppoIntmenTime != "") {
                                                    if (time == strRr[j].AppoIntmenTime) {
                                                        strTd = "";
                                                        //if ($("#approvalreservation").text() == "我的预约") {
                                                        //    strTd += "<span id=" + strRr[j].Id + " style='display:block;height:40px;padding:5px 20px 5px 5px;position:relative;font-size:12px;background:#ffb7ba;color:#fff;'>";
                                                        //    strTd += "已预约<br>";
                                                        //    strTd += "名称：" + strRr[j].Name + "<br>";
                                                        //    strTd += "电话号码：" + strRr[j].Telephone + "<br>";
                                                        //    strTd += "申请人：" + strRr[j].Applicant + "<br>";
                                                        //    //strTd += "<i class='icon icon-trash fr mr5' style='color:#fff;top:2px;position:absolute;right:0px;'></i>"
                                                        //    strTd += "</span>";
                                                        //} else {
                                                            strTd += "<span id=" + strRr[j].Id + " style='display:block;text-align:left;height:140px;padding:5px 20px 5px 5px;position:relative;font-size:12px;background:#ffb7ba;color:#fff;'>";
                                                            strTd += strRr[j].ApprovalStutus + "<br>";
                                                            strTd += "名称：" + strRr[j].Name + "<br>";
                                                            strTd += "电话号码：" + strRr[j].Telephone + "<br>";
                                                            strTd += "申请人：" + strRr[j].Applicant + "<br>";
                                                            //strTd += "<i class='icon icon-trash fr mr5' style='color:#fff;top:2px;position:absolute;right:0px;'></i>"
                                                            strTd += "</span>";
                                                        //}
                                                        
                                                        $('tr[id=tr' + (rowindex -1) + '] td[rowindex=' + rowindex + '][colindex=' + colindex + ']').html(strTd);
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                }
            }
            var e = arguments.callee.caller.arguments[0] || event; // 若省略此句，下面的e改为event，IE运行可以，但是其他浏览器就不兼容
            if (e && e.stopPropagation) {
                // this code is for Mozilla and Opera
                e.stopPropagation();
            } else if (window.event) {
                // this code is for IE
                window.event.cancelBubble = true;
            }
        }

        function delResourceReservation(id) {
            var UserName = $("#HUserName").val();
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "ResourceReservations/ResourceReservationHandler.ashx", "Func": "DelResourceReservation", "ID": id, "ispage": "false", "UserName": UserName
                },
                success: OnResourceReservationsSuccess,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }
    </script>
</body>
</html>

