<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CertificateManage.aspx.cs" Inherits="SMSWeb.PersonalSpace.CertificateManage" %>

<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>证书管理</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <link href="/css/certificateT.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="Term.js"></script>
    <script type="text/javascript" src="http://html2canvas.hertzen.com/build/html2canvas.js"></script>
    <link href="/Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="/Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->

    <script id="li_Modol" type="text/x-jquery-tmpl">
        <li class="cert_li">
            <div class="cert_imgs">
                <img style="cursor: pointer" onclick="bzCertificateGet(this)" src="${ImageUrl}" width="95">
                <i class="selected"></i>
            </div>
            <div class="cert_name">${Name}</div>
        </li>
    </script>
    <script id="tr_Certificate" type="text/x-jquery-tmpl">
        <tr>
            <td>${cName}</td>
            <td>${CreateName}</td>
            <td>${CompleteTime}</td>
            <td>{{if Status==1}}<span>审核通过</span>{{else}}<span>待审核</span>{{/if}}
            </td>
            <td>{{if Status==1}}
                {{else}}
                <a onclick="CheckCertificate(${ID})">审核</a>
                {{/if}}
            </td>
        </tr>
    </script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />

    <form id="form1" runat="server">
        <input id="option" type="hidden" value=">" />
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="/HZ_Index.aspx">
                    <img src="/images/logo.png" /></a>

                <div class="wenzi_tips fl">
                    <img src="/images/zhengshuguanli.png" />
                </div>

                <nav class="navbar menu_mid fl">

                    <ul id="CourceMenu">
                        <li class="active"><a href="#">证书管理</a></li>
                        <%--<li class="active"><a href="#">课程管理</a></li>
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
                <div class="stytem_select clearfix">
                    <div class="stytem_select_left fl">
                        <a href="javascript:;" class="on" onclick="Tab(1)" id="TabModel">证书模板</a>
                        <a href="javascript:;" onclick="Tab(2)" id="TabContent">证书管理</a>
                        <a href="javascript:;" onclick="Tab(3)" id="TabCheck">证书审核</a>
                    </div>
                </div>
                <div class="newcourse_select clearfix none" id="Search">
                    <%--<div class="clearfix fl course_select">
                        <label for="">学年学期：</label>
                        <select name="" class="select" id="StudyTerm" onchange="getData(1, 10)">
                            <option value="">==请选择==</option>
                        </select>
                    </div>--%>

                    <div class="stytem_select_right fr">
                        <a href="javascript:;" class="newcourse" onclick="UploadAttach()">上传附件
                        </a>
                        <a href="javascript:;" class="newcourse" onclick="AddCertificate()" id="icon-plus">
                            <i class="icon icon-plus"></i>新建证书
                        </a>
                    </div>
                </div>
                <div class="spacecenter">

                    <div class="wrap">
                        <div id="CerTemplate" class="certificate">
                            <div class="cert_l">
                                <div class="cert_tit">
                                    <p class="h4t">模板选择</p>
                                </div>
                                <div class="cert_all">
                                    <h5 style="width: 200px;">全部模板</h5>
                                    <ul id="Certificate" class="cert_ul">
                                    </ul>
                                </div>

                            </div>
                            <div class="cert_r" id="CerList">
                                <div class="cert_tit">
                                    <p class="h4t">模板预览</p>
                                </div>
                                <script type="text/javascript">
                                    $(function () {
                                        $("#GenerateImg").on("click", function (event) {
                                            event.preventDefault();
                                            html2canvas($(".viewimg"), {
                                                allowTaint: true,
                                                taintTest: false,
                                                onrendered: function (canvas) {
                                                    canvas.id = "mycanvas";
                                                    var dataUrl = canvas.toDataURL();
                                                    var newImg = document.createElement("img");
                                                    newImg.src = dataUrl;
                                                    var w = window.open('about:blank', 'image from canvas');
                                                    w.document.write("<img src='" + dataUrl + "' alt='from canvas'/>");
                                                    //document.body.appendChild(newImg);

                                                }
                                            });
                                        });
                                    })

                                </script>
                                <input type="button" id="GenerateImg" value="生成图片" style="display: none;" />
                                <div class="cert_view">
                                    <div id="PreviewCer" class="viewimg">
                                        <div id="ccpic">
                                            <img src="/images/template/template01.jpg" style="height: 340px;" id="Modole_show">
                                        </div>
                                        <div id="CerName" style="position: absolute; z-index: 1; width: 460px; height: 30px; margin-top: -260px; text-align: center;">
                                            <span style="font-size: 22px; color: #902226; letter-spacing: 3px;">课程中心证书</span>
                                        </div>
                                        <div id="StuName" style="position: absolute; z-index: 1; width: 460px; height: 30px; margin-top: -215px; text-align: center;">
                                            <span style="font-size: 22px; letter-spacing: 3px;">张三</span>
                                        </div>
                                        <div id="CerInfo" style="position: absolute; z-index: 1; width: 360px; margin-left: 60px; height: 60px; margin-top: -180px; text-align: left;">
                                            <span id="cInfo" style="font-size: 20px; letter-spacing: 2px; color: #707070; font-family: ''">顺利完成
                                <span id="CourseName">课程中心的</span>课程
                                            课程的学习,成绩[<span id="Score">100</span>分],颁发此证书.</span>
                                        </div>
                                        <div id="oSign" style="display: none; position: absolute; z-index: 1; margin-left: 85px; margin-top: -110px;">
                                            <span id="oSign1" style="font-size: 12px; color: #707070; float: left;"></span>
                                            <div id="SIign1Pic" style="float: left; margin-top: -10px;"></div>
                                        </div>
                                        <div id="tSign" style="position: absolute; z-index: 1; margin-left: 330px; margin-top: -110px; display: block;">
                                            <span id="tSign1" style="font-size: 12px; color: #707070; float: left;"></span>
                                            <div id="SIign2Pic" style="float: left; margin-top: -10px;"></div>
                                        </div>
                                        <div id="oSign22" style="display: none; position: absolute; z-index: 1; margin-left: 330px; margin-top: -110px;">
                                            <span id="oSign2" style="font-size: 12px; color: #707070; float: left;"></span>
                                            <div id="SIign3Pic" style="float: left; margin-top: -10px;"></div>
                                        </div>
                                        <div id="CercNo" style="position: absolute; z-index: 1; margin-top: -73px; margin-left: 110px;">
                                            <span style="font-size: 12px; color: #707070;">5201507290000</span>
                                        </div>
                                        <div id="qrcode" style="position: absolute; z-index: 1; height: 30px; margin-top: -110px; margin-left: 208px;" title="http://www.baidu.com">
                                            <canvas width="50" height="50" style="display: none;"></canvas>
                                            <img alt="Scan me!" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAChklEQVRoQ+1Z7XKDMAyD939oenANZ4Iky5Rubbb+2kpIIn/IsjtP07RMhc+yLNM8z9sb69/rp/0ft0HP1HfxXbRfdsX1Rks7QC3uLx8BqPfX99hz9gydxe7W1o4JxAmRaN24Xlm9t2YWYldC9+CRPwdEWcxJ8rgGefLHPYKYpr9Yluwo7P6BXKXfZs2M95GXWh3q30V1yikLL9HvxwHJqmZfsVEM90mOEtp9L/Mwuu/mkSGAWPqkgvS5NlpfWZh5snrkHIE4h7NkZJSJlICqIxldM+IYEwhMIiHZme6KEl+pZKTVlH5T6w8e+WogqB+JcaoKlmqkHG+hfEBnqwZur2WMfp264FTcSA5qvQNcaTtaR74SCKM01pc7rnYsfEerewitYYG4gwWnH3HXONUf7SU9MgyQjH57+Z6Ng9TwodJRRgP3e9LhQ4W1XOCof0HnsDCTBosFUUkAV+ihAnqy3lP2IFZUdccG4loMrWPhg/It01htLyfs2l6w1XU8o+I1E41vAcL6ESYnVL+g6BHpsooxVHhu+wwDJEt2lQ/OlFDlCEvsKp3vHunbVFUQswlHJUEz1lL9/Km1XkNrCCCssWLJjqzIvuvZy6Ftda46J6VftDGS8UzaqzzKLu2efWItd2NHqVbCVeUke9bf4dKkUQHOyIAVy1jN1YyM7T8WEMXbfYJG7lctr5MbqB2u1qb9fld+nmauZzKEsdXbgKD4U/2Ckvbx8hWPZ4TD5guXftVFHmGXvUNkKk9DGe96JFOiWYghqyO6RvnJPPaSR9CF1YjVbWvVeCrSdKwxYwJxCl3GNE7+qBCOVkbWp0ORK/SrYvdXgWSUx5LX6b3dqUiVaG7VWp8E5AGcK2oZBWLIXQAAAABJRU5ErkJggg==" style="display: block;">
                                        </div>
                                        <div id="CerTime" style="position: absolute; z-index: 1; margin-top: -73px; margin-left: 315px;">
                                            <span style="font-size: 12px; letter-spacing: 2px; color: #707070;">2016-7-10</span>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="wrap none">
                        <table>
                            <thead>
                                <th>证书名称</th>
                                <th>包含课程</th>
                                <th>考试(分数)</th>
                                <th>创建时间</th>
                                <th>操作</th>
                            </thead>
                            <tbody id="tbCertificates">
                            </tbody>
                        </table>

                    </div>
                    <div class="wrap none">
                        <table>
                            <thead>
                                <th>证书名称</th>
                                <th>申请人</th>
                                <th>申请时间</th>
                                <th>状态</th>
                                <th>操作</th>
                            </thead>
                            <tbody id="tbCheck">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!--分页-->
        <div class="page none">
            <span id="pageBar"></span>
        </div>
    </form>
</body>
<script type="text/javascript" src="/js/common.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
        $('.stytem_select_left a').click(function () {
            $(this).addClass('on').siblings().removeClass('on');
            var n = $(this).index();
            $('.spacecenter .wrap').eq(n).show().siblings().hide();
        })
        bindModol();
        BindPlatCertificate(1, 10);
        CertificateCheck(1, 10);
    });
    //删除证书
    function DelCertificate(ID) {
        if (confirm("确定要删除证书吗？")) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                dataType: "json",
                async: false,
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "DelPlatCertificate",
                    ID: ID,
                    UserIdCard: $("#HUserIdCard").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("删除成功");
                        BindPlatCertificate(1, 10);
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
    //修改证书
    function EditCertificate(ID) {
        OpenIFrameWindow('修改平台证书', '/PersonalSpace/AddCertificate.aspx?ID=' + ID, '380px', '480px');
    }
    //证书
    function CertificateCheck(startIndex, pageSize) {
        $.ajax({
            url: "/Common.ashx",
            type: "post",
            dataType: "json",
            data: {
                PageName: "/Certificate/Certificate.ashx",
                Func: "GetCertificates",
                Ispage: true,
                NStatus: 1,
                PageIndex: startIndex,
                pageSize: pageSize

            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $("#tbCheck").html('');
                    $("#tr_Certificate").tmpl(json.result.retData.PagedData).appendTo("#tbCheck");
                }
                else {
                    $("#NCertificateList").html("暂无证书！");
                }
            },
            error: function (errMsg) {
                $("#tbCheck").html(errMsg);
            }
        });
    }
    function Tab(type) {
        if (type == 2) {
            $(".stytem_select_right").show();
            $("#Search").show();
            $(".page").show();
        }
        else {
            $(".stytem_select_right").hide();
            $("#Search").hide();
            $(".page").hide();
        }
    }

    //证书模板
    function bindModol() {
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
                    $("#Certificate").html('');
                    $("#li_Modol").tmpl(json.result.retData).appendTo("#Certificate");
                }
                else {
                    $("#Certificate").html("暂无证书模板！");
                }
            },
            error: function (errMsg) {
                $("#Certificate").html(errMsg);
            }
        });
    }
    function bzCertificateGet(em) {

        var src = $(em).attr('src');
        src = src.replace('_s.jpg', '.jpg');
        $("#Modole_show").attr("src", src);
    }
    //获取数据
    function BindPlatCertificate(startIndex, pageSize) {
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        $.ajax({
            url: "/Common.ashx",
            type: "post",
            dataType: "json",
            async: false,
            data: {
                PageName: "/Certificate/Certificate.ashx",
                Func: "GetPlatCertificate",
                PageIndex: startIndex,
                pageSize: pageSize
            },
            success: function (json) {
                var tr = "";
                var ExamName = "";
                var CourseName = "";

                if (json.CertificateManage.errNum.toString() == "0") {
                    $("#page").show();
                    $("#tbCertificates").html('');
                    //$("#tr_Certificates").tmpl(json.CertificateManage.retData.PagedData).appendTo("#tbCertificates");
                    $.each(json.CertificateManage.retData.PagedData, function (n, value) {
                        var CertificateID = this.ID;
                        var ExamName = "";
                        var CourseName = "";
                        //考试
                        $.each(json.Exam.retData, function (n, value) {
                            if (this.CertificateID == CertificateID) {
                                ExamName += "[" + this.Title + "(" + this.Score + ")]";
                            }
                        });
                        //课程
                        $.each(json.Course.retData, function (n, value) {
                            if (this.CertificateID == CertificateID) {
                                CourseName += "[" + this.CourseName + "]";
                            }
                        });
                        var alink = "<a onclick=\"StuDetail(" + this.ID + ")\">学员信息</a>&nbsp;<a onclick=\"EditCertificate(" + this.ID +
                            ")\">证书修改</a>&nbsp;<a onclick=\"DelCertificate(" + this.ID + ")\">证书删除</a>&nbsp;<a onclick=\"ShowCertificate(" + this.ID + ",'" + encodeURI( CourseName)
                            + "','" + encodeURI(ExamName) + "','" + this.ImageUrl + "','" + encodeURI(this.Name) + "')\">证书预览</a>";
                        tr += "<tr> <td>" + this.Name + "</td><td>" + CourseName.trim('-') + "</td><td>" + ExamName.trim('-') + "</td><td>" + DateTimeConvert(this.CreateTime, 'yyyy-MM-dd') + "</td><td>"
                        + alink + "</td>";
                    })


                    $("#tbCertificates").html(tr);
                    makePageBar(BindPlatCertificate, document.getElementById("pageBar"), json.CertificateManage.retData.PageIndex, json.CertificateManage.retData.PageCount, pageSize, json.CertificateManage.retData.RowCount);
                }
                else {
                    $("#page").hide();
                    $("#tbCertificates").html(json.result.errMsg);
                    layer.msg(json.CertificateManage.errMsg);
                }
            },
            error: function (errMsg) {
                $("#page").hide();
                layer.msg(errMsg);
            }
        });
    }
    function AddCertificate() {
        OpenIFrameWindow('新建平台证书', '/PersonalSpace/AddCertificate.aspx', '380px', '480px');
    }
    //学员信息
    function StuDetail(ID) {
        OpenIFrameWindow('学员信息', '/PersonalSpace/StuDetail.aspx?CertiID=' + ID, '480px', '460px');
    }
    function CheckCertificate(ID) {
        if (ID == "") {
            layer.msg("重复审核");
        }
        else {
            OpenIFrameWindow('证书申请审核', '/PersonalSpace/CheckApply.aspx?ID=' + ID, '540px', '330px');
        }
    }
    function ShowCertificate(ID, CourseName, ExamName, ImageUrl, Name) {
        OpenIFrameWindow('证书预览', '/PersonalSpace/CertificateShow.aspx?ID=' + ID + "&CourseName=" + CourseName + "&ExamName=" + ExamName + "&ImageUrl=" + ImageUrl + "&Name=" + Name + "&Type=1", '480px', '480px');
    }
    function UploadAttach() {
        OpenIFrameWindow('上传附件', '/PersonalSpace/CertificateAttach.aspx?Type=2', '320px', '300px');
    }
</script>
</html>
