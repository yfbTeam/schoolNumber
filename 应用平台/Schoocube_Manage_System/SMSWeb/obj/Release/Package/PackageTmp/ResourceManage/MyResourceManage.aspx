<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyResourceManage.aspx.cs" Inherits="SMSWeb.CourseManage.MyResource" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>个人网盘</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/sprite.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="../Scripts/Pager.js"></script>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }
    </style>
    <!--[if IE]>
    <script src="js/html5.js"></script>
		<![endif]-->
    <script id="tr_User" type="text/x-jquery-tmpl">
        <li class="clearfix">
            <div class="checkbox fl">
                <input type='checkbox' value='${ID}' class='Check_box' name='Check_box' id='subcheck' onclick='setSelectAll()' />
            </div>
            <div class="docu_messages fl">
                <p class="docu_title">
                    <span class="ico-${postfix1}-min h-ico" onclick="FolderClick(${ID},'${FileUrl}','${code}',${IsFolder})">
                        <img <%--src='${FileIcon}'--%>style="width:100%;height:auto;" /></span>
                    <span class="docu_name" href="javascript:;" onclick="FolderClick(${ID},'${FileUrl}','${code}',${IsFolder})" title="${Name}">${cutstr(Name,30)}</span>
                </p>
            </div>
            <div class="unload_none fl">
                <span class="upload">
                    <i class="icon icon-download-alt" onclick="Down(${ID})" title="下载"></i>
                </span>
                <span class="arrow-down pr" >
                    <i class="icon" title="更多">
                        <img src="../images/xai.png" /></i>
                    <div class="arrow_downwrap">
                        <span onclick="Move(${ID})">移动到</span>
                        <%-- <span onclick="Del(${ID})">复制到</span>--%>
                        <span class="rename" onclick="cl(this,${ID},'${Name}','${FileUrl}')">重命名</span>
                        <span class="delete" onclick="Del(${ID},'${Name}')">删除</span>
                    </div>
                </span>
            </div>
            <div class="skydrive_size fl">
                <span>{{if FileSize==0}}--
                        {{else FileSize>1024*1024}}
                            ${(FileSize/1024/1024).toFixed(2)}MB
                        {{else}}
                            ${(FileSize/1024).toFixed(2)}KB
                        {{/if}}
                   
                </span>
            </div>
            <div class="date fr">
                <span>${DateTimeConvert(CreateTime,'yyyy-MM-dd')}</span>
            </div>
        </li>


    </script>
    <script id="tr_User1" type="text/x-jquery-tmpl">
        <li>
            <div class="checkbox">
                <input type='checkbox' value='${ID}' class='Check_box' name='Check_box' onclick='setSelectAll()' />
            </div>
            <div class="skydrive_grid_view">
                <a href="#" onclick="FolderClick(${ID},'${FileUrl}','${code}',${IsFolder})">
                    <em class="ico-${postfix1}-max a-ico-file">
                        <img style="width:100%; height: auto;"/></em>
                    <p class="grid_view_name" title="${Name}">${cutstr(Name,12)}</p>
                </a>
            </div>
        </li>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <input type="hidden" id="HUserIdCard" runat="server" />
            <input type="hidden" id="HUserName" runat="server" />
            <input type="hidden" id="HClassID" runat="server" />
            <input type="hidden" id="HIcons" runat="server" />
            <input id="Pid" type="hidden" value="0" />
            <input id="code" type="hidden" value="0" />
            <input id="HFoldUrl" type="hidden" value="/DriveFolder" />
            <input id="ShowType" type="hidden" value="1" />
            <input id="GroupName" type="hidden" value="" />
            <input id="Postfixs" type="hidden" value="" />
            <input id="TimeQuery" type="hidden" value="" />
            <!--header-->
            <header class="repository_header_wrap">
                <div class="width repository_header clearfix">
                    <a class="logo fl" href="../HZ_Index.aspx">
                <img src="../images/logo.png" /></a>
                    <div class="wenzi_tips fl">
                        <img src="/images/skydrive.png" /></div>
                    <div class="search_account fr clearfix">
                        <%--<div class="search fl">
                            <i class="icon  icon-search"></i>
                            <input type="text" name="" id="search_w" placeholder="请输入关键字" />
                        </div>--%>
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
                                 <a href="/PersonalSpace/PersonalSpace_Teacher.aspx" target="_blank"><span>个人中心</span></a>
                                <span onclick="logOut()">退出</span>
                            </div>
                        </div>
                    </div>
                </div>
            </header>
            <!--网盘-->
            <div class="skydrive width bordshadrad">
                <div class="modult_toolsbar clearfix">
                    <div class="list_grid_switch fr">
                        <a href="javascript:;" class="list_switch on">
                            <i class="icon icon-th-list" onclick="ShowType(1)"></i>
                        </a>
                        <a href="javascript:;" class="grid_switch">
                            <i class="icon  icon-th-large" onclick="ShowType(2)"></i>
                        </a>
                    </div>

                    <!--工具条-->
                    <div class="toolsbar fl">
                        <div class="bars">
                            <a href="#" class="upload pr">
                                <i class="icon  icon-upload-alt"></i>
                                <span class="txt" onclick="upload()">上传文件</span>
                            </a>
                            <a href="#" class="newfile">
                                <i class="icon icon-folder-close-alt"></i>
                                <span class="txt" onclick="javascript: appendAfterRow('tb_MyResource', '1')">新建文件夹</span>
                            </a>
                            <a href="javascript:;" class="operate pr">
                                <i class="icon  icon-wrench"></i>
                                <span class="txt">批量操作</span>
                                <div class="operate_wrap">
                                    <span onclick="Del('','')">删除</span>
                                    <span onclick="Move('','')">移动</span>
                                    <span onclick="Down('','')">下载</span>
                                    <%--<span>共享</span>--%>
                                </div>
                            </a>

                        </div>

                    </div>
                </div>
                <div class="selectionwrap">
                    <div class="select_nav clearfix pr">
                        <div class="select_nav_left fl">
                            文件类型:
                        </div>
                        <ul class="select_nav_right clearfix" id="ResourceType">
                            <li class="on">
                                <a href="#" onclick="serchType('',this)">不限</a>
                            </li>

                        </ul>
                    </div>
                    <div class="select_nav clearfix pr">
                        <div class="select_nav_left fl">
                            上传时间
                        </div>
                        <ul class="select_nav_right">
                            <li class="on">
                                <a href="#" onclick="SerchTime('',this)">不限</a>
                            </li>
                            <li>
                                <a href="#" onclick="SerchTime('Week',this)">一周内</a>
                            </li>
                            <li>
                                <a href="#" onclick="SerchTime('Month',this)">一月内</a>
                            </li>
                            <li>
                                <a href="#" onclick="SerchTime('Year',this)">半年内</a>
                            </li>
                        </ul>
                    </div>
                </div>

                <!--docu-->
                <div class="docu_wrap">

                    <!--面包屑-->
                    <div class="crumbs" id="Nav">
                        <a href="#" onclick="FolderClick(0, '\DriveFolder', 0,1)">全部</a>
                    </div>
                    <div class="docu_content">
                        <!--docu_list-->
                        <div class="IsCheckAll">
                            <div class="clearfix" style="padding: 10px; border-top: 1px dotted #CFCFCF;">
                                <div class="checkbox fl" style="margin-left: 1px;">
                                    <input type="checkbox" name="" id="checkAll" value="" style="width: 18px; height: 18px; border: 1px solid rgba(0,0,0,.2); border-radius: 2px; background: #fff;" />
							    </div>
                                <div class="docu_messages fl">
                                    <p class="docu_title" style="height: 24px; font-size: 15px; color: #555555; line-height: 24px; padding-left: 12px;">
                                        文件名
                                    </p>
							    </div>
                                <div class="skydrive_size fl" style="left: 61%">
                                    <span style="font-size: 15px;">大小</span>
							    </div>
                                <div class="date fr" style="line-height: 23px; margin-right: 15px;">
                                    <span style="font-size: 15px; color: #999999">修改时间</span>
							    </div>
                            </div>

                            <ul class="document_list skydrive_docu_list" style="display: block;" id="tb_MyResource">
                            </ul>
                        </div>
                        <div class="none">
                            <ul class="skydrive_grid_list clearfix" id="tb_MyResource1">
                            </ul>
                        </div>
                    </div>
                </div>
                <!--分页-->
                <div class="page">
                    <span id="pageBar"></span>
                </div>
            </div>
            <script type="text/javascript" src="../js/common.js"></script>
            <script type="text/javascript" src="../js/repository.js"></script>

        </div>
    </form>
</body>


<script type="text/javascript">
    $(document).ready(function () {
        //列表页与图标页切换
        $('.list_grid_switch').find('a').click(function () {
            $(this).addClass('on').siblings().removeClass('on');
            var n = $(this).index();
            $('.docu_content>div').eq(n).show().siblings().hide();
        })
        GetFileType()
        //获取数据
        getData(1, 10);
    });

    //获取数据
    function ShowType(Type) {
        if (Type == "1") {
            $("#ShowType").val("1");
            getData(1, 10);
        }
        if (Type == "2") {
            $("#ShowType").val("2");
            getData(1, 16);
        }
    }

    //获取数据
    function getData(startIndex, pageSize) {
        var Pid = $("#Pid").val();
        var DocName = $("#search_w").val();
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        var CreateUID = $("#HUserIdCard").val();
        //name = name || '';
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "PageName": "ResourceManage/MyResourceHander.ashx", "Func": "GetPageList", PageIndex: startIndex, pageSize: pageSize, CreateUID: CreateUID, "Pid": Pid, "DocName": DocName, "Postfixs": $("#Postfixs").val(), "CreateTime": $("#TimeQuery").val() },
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
                    //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
                    makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);

                    hoverShow($('.document_list li'), $('.unload_none'));
                    hoverShow($('.skydrive_grid_list li'), $('.checkbox'));
                    //全选
                    checkAll($('.IsCheckAll input[type=checkbox]'));
                }
                else {
                    var html = '<div style="background: url(../images/error.png) no-repeat center center; height: 500px;"></div>';
                    if (ShowType == "1") {
                        $("#tb_MyResource").html(html);
                    }
                    else {
                        $("#tb_MyResource1").html(html);
                    }
                    $(".page").hide();
                }
            },
            error: OnError
        });
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

    function OnError(XMLHttpRequest, textStatus, errorThrown) {
        var htmlBq = '<li style="text-align:center">'+json.result.errMsg.toString()+'</li>';
        if (ShowType == "1") {
            $("#tb_MyResource").html(htmlBq);
        }
        else { $("#tb_MyResource1").html(htmlBq); }
        //$("#tb_MyResource").html('无内容');
    }
    //绑定文件类型
    function GetFileType() {
        $.ajax({
            type: "Post",
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            data: { "PageName": "ResourceManage/PublicResoure.ashx", Func: "ResourceType" },
            dataType: "json",
            success: function (returnVal) {

                //var PagedData = $.parseJSON(returnVal.result.retData);

                $(returnVal.result.retData).each(function () {
                    var result = "<li><a href='#' onclick=\"serchType('" + this.ID + "',this)\">" + this.Name + "</a>";
                    $("#ResourceType").append(result);
                });
            },
            error: function (errMsg) {
                layer.msg('数据加载失败！');
            }
        });
    }
    function CheckAll(flag) {
        ////var flag = obj.checked;//判断全选按钮的状态 
        //$("input[type=checkbox][name=Check_box]").each(function () {//查找每一个name为cb_sub的checkbox 
        //    this.checked = flag;//选中或者取消选中 
        //});
        //var checked = flag.checked;
        //if(checked){
        //    $("input[type=checkbox][name=Check_box]").each(function () {//查找每一个name为cb_sub的checkbox 
        //           this.checked = true;//选中或者取消选中 
        //    });
        //} else {
        //    $("input[type=checkbox][name=Check_box]").each(function () {//查找每一个name为cb_sub的checkbox 
        //        this.checked = false;//选中或者取消选中 
        //    });
        //}
    }
    //面包屑
    function BindNav() {
        var Pid = $("#Pid").val();
        var CreateUID = $("#HUserIdCard").val();
        $("#Nav").html("<a href=\"#\" onclick=\"FolderClick(0, '\DriveFolder', 0,1)\">全部</a>");
        $.ajax({
            type: "Post",
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            data: { "PageName": "ResourceManage/MyResourceHander.ashx", Func: "BindNav", Pid: Pid, CreateUID: CreateUID },
            dataType: "json",
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $(json.result.retData).each(function () {
                        var result = "<span>></span><a href=\"#\" onclick=\"FolderClick(" + this.ID + ",'" + this.FileUrl + "', " + this.code + "," + this.IsFolder + ")\">" + this.Name + "</a>";
                        $("#Nav").append(result);
                    });
                }
            },
            error: function (errMsg) {
                layer.msg('数据加载失败！');
            }
        });
    }
    //子复选框的事件  
    function setSelectAll() {
        //当没有选中某个子复选框时，SelectAll取消选中 
        //var checkAll = $("#checkAll");
        //if (!$("input[type=checkbox][name=Check_box]").is(":checked"))
        //{
        //    checkAll.checked = false;
        //}
        //if (!$("#subcheck").is(":checked")) {
        //    checkAll.checked = false;//.attr("checked", false);
        //}
        //var chsub = $("input[type='checkbox'][id='subcheck']").length; //获取subcheck的个数  
        //var checkedsub = $("input[type='checkbox'][id='subcheck']:checked").length; //获取选中的subcheck的个数  
        //if (checkedsub >0) {
        //    $("#checkAll").attr("checked", true);
        //}
    }
    function Down(id) {
        var ids = "";
        if (id != "") {
            ids = id;
        }
        else {
            $("input[type=checkbox][name=Check_box]").each(function () {//查找每一个name为cb_sub的checkbox 
                if (this.checked) {
                    ids += this.value + ",";
                }
            });
        }
        $.ajax({
            url: "MyResourceHander.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "PageName": "ResourceManage/MyResourceHander.ashx", "Func": "Down", DownID: ids },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    window.open(json.result.retData);
                }
                else { layer.msg('下载失败！'); }
            },
            error: function (errMsg) {
                layer.msg('下载失败！');
            }
        });
    }

   
    function Move(id) {
        var pid = $("#Pid").val();
        var Pcode = $("#code").val();

        OpenIFrameWindow('文件移动', 'MyResourceContent.aspx?Pid=' + pid + "&code=" + Pcode + "&id=" + id + "&random=" + Math.random(), '450px', '300px;');

    }
    function MoveMore(url, pid, code, id) {
        if (id != "") {
            ids = id;
        }
        else {
            var ids = "";
            $("input[type=checkbox][name=Check_box]").each(function () {//查找每一个name为cb_sub的checkbox 
                if (this.checked) {
                    ids += this.value + ",";
                }
            });
        }
        if (ids == "") {
            layer.msg("请选择要移动的文件");
        }
        else {
            $.ajax({
                type: "Post",
                url: "MyResourceHander.ashx",
                data: {
                    "PageName": "ResourceManage/MyResourceHander.ashx",
                    Func: "MoveTo", "MoveIDs": ids, "Url": url,
                    "pid": pid, "code": code, CreateUID: $("#HUserIdCard").val()
                },
                dataType: "json",
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("文件移动成功");
                        getData(1, 10);
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg('操作失败！');
                }
            });
        }
    }
    function Del(id, name) {
        var len = 0;
        var ids = "";
        if (id != "") {
            ids = id;
        }
        else {
            $("input[type=checkbox][name=Check_box]").each(function () {//查找每一个name为cb_sub的checkbox 
                if (this.checked) {
                    ids += this.value + ",";// $(this).attr('value') + ",";
                    len++;
                }
            });
        }
        if (name == "") {
            name = "这" + len + "个文件/文件夹"
        }
        if (confirm("确定要删除'" + name + "'吗？")) {
        $.ajax({
            url: "MyResourceHander.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "PageName": "ResourceManage/MyResourceHander.ashx", "Func": "Del", DelID: ids },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    layer.msg("删除成功");
                    getData(1, 10);
                }
                else { layer.msg('删除失败！'); }
            },
            error: function (errMsg) {
                    layer.msg(errMsg);
            }
        });
    }
        }


    function getO(id) {
        if (typeof (id) == "string")
            return document.getElementById(id);
    }
    //删除一行（table）
    function DelRow() {
        $('ul#tb_MyResource li:eq(0)').remove();
    }
    //文件夹点击
    function FolderClick(id, FoldUrl, code, IsFolder) {
        if (IsFolder == 1) {

            $("#Pid").val(id);
            $("#HFoldUrl").val(FoldUrl);
            $("#code").val(code)
            var ShowType = $("#ShowType").val();
            if (ShowType == "1") {
                getData(1, 10);
            }
            else {
                getData(1, 16);
            }
            if (id != 0) {
                BindNav();
            }
            else {
                $("#Nav").html("<a href=\"#\" onclick=\"FolderClick(0, '\DriveFolder', 0,1)\">全部</a>");
            }
        }
        else {
            DownLoad(FoldUrl);
            //window.open(FoldUrl);
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
    //按类型搜索
    function serchType(Postfixs, em) {
        $(em).parent().addClass("on").siblings().removeClass("on");

        $("#Postfixs").val(Postfixs);
        if ($("#ShowType").val() == "1") {
            getData(1, 10);
        }
        else {
            getData(1, 16);
        }
    }
    //按时间搜索
    function SerchTime(STime, em) {
        $(em).parent().addClass("on").siblings().removeClass("on");

        $("#TimeQuery").val(STime);
        if ($("#ShowType").val() == "1") {
            getData(1, 10);
        }
        else {
            getData(1, 16);
        }
    }
    //新增文件夹
    function AddFold(em) {
        var FileName = $("#txt" + em + "").val();
        var pid = $("#Pid").val();
        var Pcode = $("#code").val();
        var CreateUID = $("#HUserIdCard").val();
        if (FileName.length > 0) {
        $.ajax({
            type: "Post",
            url: "MyResourceHander.ashx",
            data: { Func: "AddFolder", "FileName": FileName, FoldUrl: $("#HFoldUrl").val(), Pid: pid, "code": Pcode, "CreateUID": CreateUID },
            dataType: "json",
            success: function (json) {

                if (json.result.errNum.toString() == "0") {
                    layer.msg("文件夹添加成功");
                    getData(1, 10);
                }
                else { layer.msg('文件夹添加失败！'); }
            },
            error: function (errMsg) {
                layer.msg('文件夹添加失败！');
            }
        });
    }
        else { layer.msg("请输入文件夹名称"); }
    }
    function upload() {
        var pid = $("#Pid").val();
        var Pcode = $("#code").val();
        var FoldUrl = $("#HFoldUrl").val();
        var CreateUID = $("#HUserIdCard").val();

        OpenIFrameWindow('文件上传', 'MyResouceUpload.aspx?FoldUrl=' + FoldUrl + "&Pid=" + pid + "&code=" + Pcode + "&CreateUID=" + CreateUID, '400px', '300px');
    }
    //格式化时间
    Date.prototype.Format = function (fmt) { //author: meizz 
        var o = {
            "M+": this.getMonth() + 1, //月份 
            "d+": this.getDate(), //日 
            "h+": this.getHours(), //小时 
            "m+": this.getMinutes(), //分 
            "s+": this.getSeconds(), //秒 
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
            "S": this.getMilliseconds() //毫秒 
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }

    //修改文件名称
    function EditName(em, id, oldname, FileUrl) {
        var name = $("#txt" + id).val();
        $.ajax({
            url: "MyResourceHander.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "PageName": "ResourceManage/MyResourceHander.ashx", "Func": "reName", ID: id, "NewName": name, "FileUrl": FileUrl, oldname: oldname },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    layer.msg("重命名成功");
                    getData(1, 10);
                }
                else { layer.msg('重命名失败！'); }
            },
            error: function (errMsg) {
                layer.msg('重命名失败！');
                $(em).parents("li").find(".docu_name").html(oldname);
            }
        });
    }
    //取消修改文件名称
    function EditNameQ(em, name) {
        $(em).parents("li").find(".docu_name").html(name);
    }
    function cl(em, id, title, FileUrl) {
        var now = new Date();
        var nowStr = now.Format("yyyy-MM-dd");

        var name = $(em).parents("li").find(".docu_name").html();
        if (name = title) {
            var v = "<input type='text' value='" + title + "' style='float:left;line-height:10px;margin-top:5px;width:100px;' id=\"txt" + id +
    "\"/> <i class=\"icon tishi true_t icon-ok\" style=\"margin-left: 6px;margin-top:6px; color: #87c352; float: left;cursor:pointer;\" onclick=\"EditName(this,'" + id + "','" + name + "','" + FileUrl + "')\"></i> <i class=\"icon icon-remove tishi fault_t\" style=\"margin-left: 6px;margin-top:6px;color: #ff6d72; float: left;cursor:pointer;\" onclick=\"EditNameQ(this,'" + name +
    "')\"></i>";

            //var v = "<input type='text' value=\"" + name + "\" style='float:left;line-height:10px;margin-top:5px' id=\"txt" + id
            //            + "\"/> <i class=\"iconfont tishi true_t\" style=\"margin: 2px; color: #87c352;cursor:pointer; \" onclick=\"EditName(this,'" + id
            //            + "','" + name + "')\">&#xe61d;</i> <i class=\"iconfont tishi fault_t\" style=\"margin: 2px; color: #ff6d72; cursor:pointer;\" onclick=\"EditNameQ(this,'" + name
            //            + "')\">&#xe61e;</i>";

            $(em).parents("li").find(".docu_name").html(v);
            $(em).parents("li").find(".docu_name").removeAttr("onclick");
        }
    }

    //追加一行（新建文件夹）

    function appendAfterRow(tableID, RowIndex) {
        var txt1 = document.getElementById("txt1");
        if (txt1 != undefined) {
            txt1.onfocus();
        }//<img src='" + $("#HIcons").val() + "/ico-file.png' style='float:left;'>
        else {
            var li = document.createElement("li");
            li.className = "clearfix";
            var ul = document.getElementById("tb_MyResource");
            var now = new Date();
            var nowStr = now.Format("yyyy-MM-dd");
            //newRefRow.insertCell(3).innerHTML = nowStr;
            li.innerHTML = "<div class='checkbox fl'><input type='checkbox'/></div><div class='docu_messages fl'>" +
                "<p class=\"docu_title\"><span class=\"h-ico ico-file-min\"></span><a class=\"docu_name\"><input type='text' value='新建文件夹' style='float:left;line-height:10px;margin-top:5px;width:100px;' id=\"txt" + RowIndex +
                "\"/> <i class=\"icon tishi true_t icon-ok\" style=\"margin-top:6px ;margin-left:6px; color: #87c352; float: left;cursor:pointer;\" onclick=\"AddFold('" + RowIndex
                + "')\"></i> <i class=\"icon tishi fault_t icon-remove\" style=\"margin-top:6px ;margin-left:6px; color: #ff6d72; float: left;cursor:pointer;\" onclick=\"DelRow()\"></i></a></p></div><div class=\"skydrive_size fl\"><span>--</span></div><div class=\"date fr\"><span>" + nowStr + "</span></div>";
            var nodeli1 = ul.getElementsByTagName('li')[0];//获取ul下第3个节点——秋天
            ul.insertBefore(li, nodeli1);

        }
    }
</script>
</html>

