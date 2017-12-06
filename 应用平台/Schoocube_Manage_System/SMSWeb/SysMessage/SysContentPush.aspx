<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SysContentPush.aspx.cs" Inherits="SMSWeb.SysMessage.SysContentPush" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>内容发布</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link href="/css/reset.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <style>
        .wrap table tbody tr td a {
            display: inline-block;
            background: none;
            color: #5493d7;
        }

        .wrap table tbody tr td .icon {
            width: 16px;
            height: 16px;
            display: inline-block;
            font-size: 16px;
            line-height: 16px;
            cursor: pointer;
            margin: 0px 2px;
            vertical-align: middle;
            color: #5493d7;
        }
    </style>
    <style type="text/css">
        .ui-upload-input {
            position: absolute;
            top: 0px;
            right: 0px;
            height: 100%;
            cursor: pointer;
            opacity: 0;
            filter: alpha(opacity:0);
            z-index: 999;
            font-size: 100px;
        }

        .ui-upload-holder {
            position: relative;
            width: 100px;
            height: 27px;
            border: 1px solid silver;
            overflow: hidden;
            border-radius: 3px;
            cursor: pointer;
        }

        .ui-upload-txt {
            position: absolute;
            top: 0px;
            left: 0px;
            width: 100px;
            height: 27px;
            line-height: 27px;
            text-align: center;
            background: #0097DD none repeat scroll 0% 0%;
            color: #fff;
            font: 12px "微软雅黑";
            vertical-align: middle;
            padding: 5px 0px;
            cursor: pointer;
        }

        .settingsd {
            padding: 20px;
        }

            .settingsd table tr td {
                border: 1px solid #ccc;
                padding: 10px;
            }

        .shgnchuanbottom {
            width: 102px;
            height: 30px;
            margin: 0 auto;
        }


        .h-ico {
            display: inline-block;
        }

        .imgShow {
            width: 80px;
            height: 100px;
        }

        .course_manage .crumbs {
            border: none;
        }
    </style>
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
    <script src="/js/html5.js"></script>
    <![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="/PortalJs/ajaxfileupload.js"></script>
    <script id="tr_notice" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>${Title}</td>
            <td>{{if Hot==1}}是
                {{else}}否
                {{/if}}</td>
            <td>${SortId}</td>
            <td>${ClickNum}</td>
            <td>
                {{if Type==0}}通知公告
                {{else Type==1}}学校新闻
                {{else Type==2}}媒体报道
                {{else Type==3}}招聘信息
                {{else}}暂无
                {{/if}}
            </td>
            <td>
                {{if Root==0}}所有人
                {{else Root==1}}教师
                {{else Root==2}}学生
                {{else}}暂无
                {{/if}}
            </td>
             <td>${DateTimeConvert(CreateTime)}</td>
            <td>${Creator}</td>
            <td>
                {{if Hot==1}}
                 <a  href="javascript:;" onclick="UpOrDown('${Id}','0')"><i class="icon icon-road"></i>取消置顶</a>
                {{else}}
                <a  href="javascript:;" onclick="UpOrDown('${Id}','1')"><i class="icon icon-road"></i>置顶</a>
                {{/if}}
                <a href="javascript:;" onclick="javascript: OpenIFrameWindow('修改通知', 'SysContentPushEdit.aspx?Id=${Id}', '700px', '500px');"><i class="icon icon-edit"></i>修改</a>
                <a href="javascript:;" onclick="DeleteNotice('${Id}')"><i class="icon icon-trash"></i>删除</a>
            </td>
        </tr>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HUserName" runat="server" />
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <%if (SF == "教师")
                  { %>
                <a class="logo fl" href="/HZ_Index.aspx">
                    <%}
                  else
                  { %>
                    <a class="logo fl" href="/PersonalSpace/Learning_center_portal.aspx">
                        <%} %>
                        <img src="/images/logo.png" />
                    </a>
                    <div class="wenzi_tips fl">
                        <img src="/images/neirongfabu.png" />
                    </div>
                    <nav id="teacher" class="navbar menu_mid fl">
                        <ul id="navtab">
                            <li class="active">
                                <a href="javascript:;">信息管理</a>
                            </li>
                            <li >
                                <a href="javascript:;">个性化环境</a>
                            </li>
                            <li><a href="javascript:;" class="on">网站页面模板</a></li>
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
                                <%if (SF == "教师")
                                  { %>
                                <a href="/PersonalSpace/PersonalSpace_Teacher.aspx" target="_blank">
                                    <%}
                                  else
                                  { %>
                                    <a href="/PersonalSpace/PersonalSpace_Student.aspx" target="_blank">
                                        <%} %>
                                        <span>个人中心</span></a>
                                    <span onclick="logOut()">退出</span>
                            </div>
                        </div>
                    </div>
            </div>
        </header>

        <div class="onlinetest_item width pt90 pr ">
           
            <div class="bordshadrad" style="background: #fff; padding: 20px;" id="tabbox_wrap">
                <div class="tabbox">
                    <div class="newcourse_select clearfix">
					    <div class="clearfix fl course_select">
						    <label for="">选择类型：</label>
						    <select name="" class="select" id="selType" onchange="query()">
                                <option value="">请选择类型</option>
                                <option value="0">通知公告</option>
                                <option value="1">学校新闻</option>
                                <option value="2">媒体报道</option>
                                <option value="3">招聘信息</option>
                            </select>
					    </div>
					    <div class="clearfix fl course_select">
						    <label for="">选择日期：</label>
						    <input type="text" class="Wdate text" id="StarDate" value="<%=DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd") %>" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'EndDate\',{d:-1});}'})"  style="height: 26px;border: 1px solid #9ec5e2;border-radius: 2px;width: 178px;"/>
                            <input type="text" class="Wdate text" id="EndDate" value="<%=DateTime.Now.ToString("yyyy-MM-dd") %>" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'StarDate\',{d:0});}'})" style="height: 26px;border: 1px solid #9ec5e2;border-radius: 2px;width: 178px;"/>
					    </div>
                        <div class="clearfix fl course_select">
						    <label for="">选择条数：</label>
						    <select name="" class="select" id="selNum" onchange="query()">
                                <option value="10">10</option>
                                <option value="30">30</option>
                                <option value="50">50</option>
                                <option value="100">100</option>
                                <option value="300">300</option>
                                <option value="500">500</option>
                                <option value="500">1000</option>
                            </select>
					    </div>
					    <div class="stytem_select_right fr">
						     <a href="javascript:void(0);" onclick="javascript: OpenIFrameWindow('添加数据','SysContentPushEdit.aspx', '700px', '500px');"><i class="icon icon-plus"></i>添加</a>
                               <a href="javascript:void(0);" onclick="query()">查询</a>
					    </div>
				    </div>
                    <div class="wrap">
                        <table>
                            <thead>
                                <tr>
                                    <th class="number">序号</th>
                                    <th>标题</th>
                                    <th>是否置顶</th>
                                    <th>排序</th>
                                    <th>点击量</th>
                                    <th>类型</th>
                                    <th>范围</th>
                                    <th>创建时间</th>
                                    <th>创建人</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody id="tb_notice">
                            
                            </tbody>
                        </table>
                    </div>
                    <div class="page">
                        <span id="pageBar"></span>
                    </div>
                </div>
                <div class="tabbox none">
                    <table>
                   <%--     <tr>
                            <td>登录页面LOGO</td>
                            <td>
                                <div class="shangchuan">
                                    <div class="shgnchuantop" id="imgshow1">
                                        <img src="/PortalImages/logo.png" />
                                    </div>
                                    <div class="shgnchuanbottom">
                                        <div class="ui-upload-holder">
                                            <div class="ui-upload-txt">
                                                点击上传
                                            </div>
                                            <input id="fileToUpload1" type="file" size="45" name="fileToUpload1" class="input ui-upload-input bluebutton dianjisc"
                                                uploadattr="loginLogo" style="margin-top: 0;" />
                                        </div>
                                    </div>
                                    <div id="divUpload1" class="none">
                                        <img id="loading1" src="/PortalImages/ajaxfileloading.gif" class="none" class="img-rounded" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>页面Banner</td>
                            <td>
                                <div class="shangchuan">
                                    <div class="shgnchuantop" id="imgshow2">
                                        <img src="/PortalImages/logo.png" />
                                    </div>
                                    <div class="shgnchuanbottom">
                                        <div class="ui-upload-holder">
                                            <div class="ui-upload-txt">
                                                点击上传
                                            </div>
                                            <input id="fileToUpload2" type="file" size="45" name="fileToUpload2" class="input ui-upload-input bluebutton dianjisc"
                                                uploadattr="pageBanner" style="margin-top: 0;" />
                                        </div>
                                    </div>
                                    <div id="divUpload2" class="none">
                                        <img id="loading2" src="/PortalImages/ajaxfileloading.gif" class="none" class="img-rounded" />
                                    </div>
                                </div>
                            </td>
                        </tr>--%>
                   <%--                        <tr>
                            <td>个人网盘</td>
                            <td>
                                <div class="shangchuan">
                                    <div class="shgnchuantop" id="imgshow3">
                                        <img src="/PortalImages/logo.png" />
                                    </div>
                                    <div class="shgnchuanbottom">
                                        <div class="ui-upload-holder">
                                            <div class="ui-upload-txt">
                                                点击上传
                                            </div>
                                            <input id="fileToUpload3" type="file" size="45" name="fileToUpload3" class="input ui-upload-input bluebutton dianjisc"
                                                uploadattr="myResource" style="margin-top: 0;" />
                                        </div>
                                    </div>
                                    <div id="divUpload3" class="none">
                                        <img id="loading3" src="/PortalImages/ajaxfileloading.gif" class="none" class="img-rounded" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>资源中心</td>
                            <td>
                                <div class="shangchuan">
                                    <div class="shgnchuantop" id="imgshow4">
                                        <img src="/PortalImages/logo.png" />
                                    </div>
                                    <div class="shgnchuanbottom">
                                        <div class="ui-upload-holder">
                                            <div class="ui-upload-txt">
                                                点击上传
                                            </div>
                                            <input id="fileToUpload4" type="file" size="45" name="fileToUpload4" class="input ui-upload-input bluebutton dianjisc"
                                                uploadattr="publicResoure" style="margin-top: 0;" />
                                        </div>
                                    </div>
                                    <div id="divUpload4" class="none">
                                        <img id="loading4" src="/PortalImages/ajaxfileloading.gif" class="none" class="img-rounded" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>考试系统</td>
                            <td>
                                <div class="shangchuan">
                                    <div class="shgnchuantop" id="imgshow5">
                                        <img src="/PortalImages/logo.png" />
                                    </div>
                                    <div class="shgnchuanbottom">
                                        <div class="ui-upload-holder">
                                            <div class="ui-upload-txt">
                                                点击上传
                                            </div>
                                            <input id="fileToUpload5" type="file" size="45" name="fileToUpload5" class="input ui-upload-input bluebutton dianjisc"
                                                uploadattr="examQManager" style="margin-top: 0;" />
                                        </div>
                                    </div>
                                    <div id="divUpload5" class="none">
                                        <img id="loading5" src="/PortalImages/ajaxfileloading.gif" class="none" class="img-rounded" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>选课系统</td>
                            <td>
                                <div class="shangchuan">
                                    <div class="shgnchuantop" id="imgshow6">
                                        <img src="/PortalImages/logo.png" />
                                    </div>
                                    <div class="shgnchuanbottom">
                                        <div class="ui-upload-holder">
                                            <div class="ui-upload-txt">
                                                点击上传
                                            </div>
                                            <input id="fileToUpload6" type="file" size="45" name="fileToUpload6" class="input ui-upload-input bluebutton dianjisc"
                                                uploadattr="selCourse" style="margin-top: 0;" />
                                        </div>
                                    </div>
                                    <div id="divUpload6" class="none">
                                        <img id="loading6" src="/PortalImages/ajaxfileloading.gif" class="none" class="img-rounded" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>推荐就业</td>
                            <td>
                                <div class="shangchuan">
                                    <div class="shgnchuantop" id="imgshow7">
                                        <img src="/PortalImages/logo.png" />
                                    </div>
                                    <div class="shgnchuanbottom">
                                        <div class="ui-upload-holder">
                                            <div class="ui-upload-txt">
                                                点击上传
                                            </div>
                                            <input id="fileToUpload7" type="file" size="45" name="fileToUpload7" class="input ui-upload-input bluebutton dianjisc"
                                                uploadattr="enter" style="margin-top: 0;" />
                                        </div>
                                    </div>
                                    <div id="divUpload7" class="none">
                                        <img id="loading7" src="/PortalImages/ajaxfileloading.gif" class="none" class="img-rounded" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>问卷调查</td>
                            <td>
                                <div class="shangchuan">
                                    <div class="shgnchuantop" id="imgshow8">
                                        <img src="/PortalImages/logo.png" />
                                    </div>
                                    <div class="shgnchuanbottom">
                                        <div class="ui-upload-holder">
                                            <div class="ui-upload-txt">
                                                点击上传
                                            </div>
                                            <input id="fileToUpload8" type="file" size="45" name="fileToUpload8" class="input ui-upload-input bluebutton dianjisc"
                                                uploadattr="questionnaire" style="margin-top: 0;" />
                                        </div>
                                    </div>
                                    <div id="divUpload8" class="none">
                                        <img id="loading8" src="/PortalImages/ajaxfileloading.gif" class="none" class="img-rounded" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>教学统计</td>
                            <td>
                                <div class="shangchuan">
                                    <div class="shgnchuantop" id="imgshow9">
                                        <img src="/PortalImages/logo.png" />
                                    </div>
                                    <div class="shgnchuanbottom">
                                        <div class="ui-upload-holder">
                                            <div class="ui-upload-txt">
                                                点击上传
                                            </div>
                                            <input id="fileToUpload9" type="file" size="45" name="fileToUpload9" class="input ui-upload-input bluebutton dianjisc"
                                                uploadattr="mark" style="margin-top: 0;" />
                                        </div>
                                    </div>
                                    <div id="divUpload9" class="none">
                                        <img id="loading9" src="/PortalImages/ajaxfileloading.gif" class="none" class="img-rounded" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>电子邮件</td>
                            <td>
                                <div class="shangchuan">
                                    <div class="shgnchuantop" id="imgshow10">
                                        <img src="/PortalImages/logo.png" />
                                    </div>
                                    <div class="shgnchuanbottom">
                                        <div class="ui-upload-holder">
                                            <div class="ui-upload-txt">
                                                点击上传
                                            </div>
                                            <input id="fileToUpload10" type="file" size="45" name="fileToUpload10" class="input ui-upload-input bluebutton dianjisc"
                                                uploadattr="email" style="margin-top: 0;" />
                                        </div>
                                    </div>
                                    <div id="divUpload10" class="none">
                                        <img id="loading10" src="/PortalImages/ajaxfileloading.gif" class="none" class="img-rounded" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                         <tr>
                            <td>实训室管理</td>
                            <td>
                                <div class="shangchuan">
                                    <div class="shgnchuantop" id="imgshow11">
                                        <img src="/PortalImages/logo.png" />
                                    </div>
                                    <div class="shgnchuanbottom">
                                        <div class="ui-upload-holder">
                                            <div class="ui-upload-txt">
                                                点击上传
                                            </div>
                                            <input id="fileToUpload11" type="file" size="45" name="fileToUpload11" class="input ui-upload-input bluebutton dianjisc"
                                                uploadattr="bookingCar" style="margin-top: 0;" />
                                        </div>
                                    </div>
                                    <div id="divUpload11" class="none">
                                        <img id="loading11" src="/PortalImages/ajaxfileloading.gif" class="none" class="img-rounded" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                         <tr>
                            <td>班级管理</td>
                            <td>
                                <div class="shangchuan">
                                    <div class="shgnchuantop" id="imgshow12">
                                        <img src="/PortalImages/logo.png" />
                                    </div>
                                    <div class="shgnchuanbottom">
                                        <div class="ui-upload-holder">
                                            <div class="ui-upload-txt">
                                                点击上传
                                            </div>
                                            <input id="fileToUpload12" type="file" size="45" name="fileToUpload12" class="input ui-upload-input bluebutton dianjisc"
                                                uploadattr="class" style="margin-top: 0;" />
                                        </div>
                                    </div>
                                    <div id="divUpload12" class="none">
                                        <img id="loading12" src="/PortalImages/ajaxfileloading.gif" class="none" class="img-rounded" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                         <tr>
                            <td>档案管理</td>
                            <td>
                                <div class="shangchuan">
                                    <div class="shgnchuantop" id="imgshow13">
                                        <img src="/PortalImages/logo.png" />
                                    </div>
                                    <div class="shgnchuanbottom">
                                        <div class="ui-upload-holder">
                                            <div class="ui-upload-txt">
                                                点击上传
                                            </div>
                                            <input id="fileToUpload13" type="file" size="45" name="fileToUpload13" class="input ui-upload-input bluebutton dianjisc"
                                                uploadattr="training" style="margin-top: 0;" />
                                        </div>
                                    </div>
                                    <div id="divUpload13" class="none">
                                        <img id="loading13" src="/PortalImages/ajaxfileloading.gif" class="none" class="img-rounded" />
                                    </div>
                                </div>
                            </td>
                        </tr>--%>
                    </table>
                </div>
                <div class="tabbox none">
                    B
                </div>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            getData(1, $("#selNum").val());
            $('#navtab li').click(function () {
                $(this).addClass('active').siblings().removeClass('active');
                var n = $(this).index();
                $('#tabbox_wrap .tabbox').eq(n).show().siblings().hide();
            })
        })

        function getData(startIndex, pageSize) {
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/NoticesHandler.ashx",
                    Func: "GetPageList",
                    type: $("#selType").val(),
                    StarDate: $("#StarDate").val(),
                    EndDate: $("#EndDate").val(),
                    PageIndex: startIndex,
                    pageSize: pageSize,
                    keyWord: $("#keyWord").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_notice").html('');
                        $("#tr_notice").tmpl(json.result.retData.PagedData).appendTo("#tb_notice");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, $("#selNum").val(), json.result.retData.RowCount);
                    }
                    else {
                        $("#tb_notice").html("<tr><td colspan='9'>暂无系统通知！</td></tr>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $("#ul_notice_course").html(json.result.errMsg.toString());
                }
            });
        }

        function DeleteNotice(delid) {
            layer.msg("确定要删除该通知?", {
                time: 0 //不自动关闭
               , btn: ['确定', '取消']
               , yes: function (index) {
                   layer.close(index);
                   $.ajax({
                       url: "/Common.ashx",
                       type: "post",
                       async: false,
                       dataType: "json",
                       data: { PageName: "PortalManage/NoticesHandler.ashx", Func: "UpdateNotice", Id: delid, IsDelete: 1 },
                       success: function (json) {
                           if (json.result.errNum.toString() == "0") {
                               layer.msg("删除成功");
                               getData(1, 10);
                           }
                           else { layer.msg('删除失败！'); }
                       },
                       error: function (errMsg) {
                           layer.msg('删除失败！');
                       }
                   });
               }
            });
        }

        function UpOrDown(id, status) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { PageName: "PortalManage/NoticesHandler.ashx", Func: "UpdateNotice", Id: id, Hot: status },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("操作成功！");
                        getData(1, 10);
                    }
                    else { layer.msg('操作失败！'); }
                },
                error: function (errMsg) {
                    layer.msg('操作失败！');
                }
            });
        }

        function query() {
            var pNum = $("#selNum").val();
            getData(1, pNum);
        }

    </script>
</body>
</html>
