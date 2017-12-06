<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NoticeManager.aspx.cs" Inherits="SMSWeb.Portal.Notice.NoticeManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="//css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="//css/reset.css" />
    <link rel="stylesheet" type="text/css" href="//css/common.css" />
    <link rel="stylesheet" type="text/css" href="//css/repository.css" />
    <link rel="stylesheet" type="text/css" href="//css/onlinetest.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="//js/menu_top.js"></script>
    <script src="//Scripts/My97DatePicker/WdatePicker.js"></script>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }
    </style>
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

                {{if isPush==0}}
                 <a  href="javascript:;" onclick="ShowOrClose('${Id}','1')"><i class="icon icon-road"></i>发布</a>
                {{else}}
                <a  href="javascript:;" onclick="ShowOrClose('${Id}','0')"><i class="icon icon-road"></i>取消发布</a>
                {{/if}}

                <a href="javascript:;" onclick="javascript: OpenIFrameWindow('修改通知', 'NoticeEdit.aspx?Id=${Id}', '700px', '500px');"><i class="icon icon-edit"></i>修改</a>
                <a href="javascript:;" onclick="DeleteNotice('${Id}')"><i class="icon icon-trash"></i>删除</a>
            </td>
        </tr>
    </script>
    <script id="tr_keyword" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td><td>{{html Contents}}</td>
        </tr>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HUserName" runat="server" />
        <!--header-->
       
        <div class="onlinetest_item">
            <div class="course_manage bordshadrad">
                <script type="text/javascript">
                    var ptitle = getQueryString("ptitle");
                    var title = getQueryString("title");
                    document.write("<div class=\"crumbs\" style=\"padding: 0; background: #fff;\"><a href=\"\">" + ptitle + "</a> <span>&gt;</span><a href=\"\">" + title + "</a></div>");
                </script>
                <div class="newcourse_select clearfix">
                     <div class="clearfix fl course_select">
                        <label for="">选择类型：</label>
                        <select name="" class="select" id="selType" onchange="queryTab()">
                            <option value="">请选择类型</option>
                            <option value="0">通知公告</option>
                            <option value="1">学校新闻</option>
                            <option value="2">媒体报道</option>
                            <option value="3">招聘信息</option>
                        </select>
                    </div>
                    <div class="clearfix fl course_select">
                        <label for="">选择日期：</label>
                        <input type="text" class="Wdate text" id="StarDate" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'EndDate\',{d:-1});}'})"  style="height: 26px;border: 1px solid #9ec5e2;border-radius: 2px;width: 178px;"/>
                        <input type="text" class="Wdate text" id="EndDate" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'StarDate\',{d:0});}'})" style="height: 26px;border: 1px solid #9ec5e2;border-radius: 2px;width: 178px;"/>
                    </div>
                     <div class="clearfix fl course_select">
                        <label for="">选择条数：</label>
                         <select name="" class="select" id="selNum" onchange="queryTab()">
                            <option value="10">10</option>
                            <option value="30">30</option>
                            <option value="50">50</option>
                            <option value="100">100</option>
                            <option value="300">300</option>
                            <option value="500">500</option>
                             <option value="500">1000</option>
                        </select>
                    </div>
                    <div class="clearfix fl course_select">
                        <label for="">关键字：</label>
                        <input type="text"  id="keyWord" class="text" style="height: 26px;border: 1px solid #9ec5e2;border-radius: 2px;width: 178px;"/>
                    </div>
                    <div class="distributed fr">
                        <a href="javascript:void(0);" onclick="queryTab('q')">查询</a>
                        <a href="javascript:void(0);" onclick="queryTab('key')">全文检索</a>
                        <a href="javascript:void(0);" onclick="javascript: OpenIFrameWindow('添加数据','NoticeEdit.aspx', '700px', '500px');"><i class="icon icon-plus"></i>添加</a>
                        <a href="javascript:getCode()">获取新闻代码</a>
                    </div>
                </div>
                <div id="tabA">
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
                            <tbody id="tb_notice"></tbody>
                        </table>
                    </div>
                    <div class="page">
                        <span id="pageBar"></span>
                    </div>
                </div>
                <div id="tabB">
                    <div class="wrap">
                        <div id=""></div>
                        <table>
                            <thead>
                                <tr>
                                    <th colspan="2">搜索结果</th>
                                </tr>
                            </thead>
                            <tbody id="bindData"></tbody>
                        </table>
                    </div>
                    <div class="page">
                        <span id="pageBar2"></span>
                    </div>
                </div>
            </div>
        </div>
        <!--分页-->
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            getData(1, $("#selNum").val());
            $("#tabA").show();
            $("#tabB").hide();
        });
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

        function ShowOrClose(id, status)
        {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { PageName: "PortalManage/NoticesHandler.ashx", Func: "UpdateNotice", Id: id, isPush: status },
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
            $("#tabA").show();
            $("#tabB").hide();
            var pNum = $("#selNum").val();
            getData(1, pNum);
        }

        function keyQuery() {
            $("#tabA").hide();
            $("#tabB").show();
            var pNum = $("#selNum").val();
            keyWordquery(1, pNum);
        }

        function keyWordquery(startIndex, pageSize)
        {
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/SystemSettings/CommonInfo.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageIndex: startIndex,
                    PageSize: $("#selNum").val(),
                    Pageing: true,
                    Func: "NoticesForKeyWord",
                    SearchKey: $("#keyWord").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#bindData").html('');
                        var items=json.result.retData.PagedData;
                        if (items!=null && items.length>0) {
                            //$("#tr_keyword").tmpl(items).appendTo("#bindData");
                            for (var i in items) {
                                var contents = items[i]["Contents"];
                                $("#bindData").append("<tr><td>" + contents + "</td></td>")
                            }
                        }
                        makePageBar(keyWordquery, document.getElementById("pageBar2"), json.result.retData.PageIndex, json.result.retData.PageCount, $("#selNum").val(), json.result.retData.RowCount);
                    }
                    else {
                        $("#bindData").html("<tr><td colspan='9'>暂无数据！</td></tr>");
                    }
                },
                error: OnError
            });
        }

        function queryTab(eve)
        {
            if (eve != "" && eve == "key") {
                keyQuery();
                $("#tabA").hide();
                $("#tabB").show();
            } else if (eve != "" && eve == "q") {
                query();
                $("#tabA").show();
                $("#tabB").hide();
            } else {
                if ($("#tabA").is("hidden")) {
                    keyQuery();
                } else {
                    query();
                }
            }
        }

        function getCode()
        {
            var strCode = "<script type=\"text/javascript\">$(function () {initNotice();})function initNotice() {$.ajax({";
            strCode += "type: \"Post\",url: \"/Common.ashx\",async: false,dataType: \"json\",data: {\"PageName\": \"PortalManage/NoticesHandler.ashx\",";
            strCode += "\"func\": \"GetNoticeAll\",\"top\": \"3\",\"isPush\":1},success: function (json) {if (json.result.status == \"ok\") {";
            strCode += "var table=\" < ul > \";var dtJson = json.result.retData;if (dtJson != null && dtJson.length > 0) {for(var i=0;i<dtJson.length;i++){";
            strCode += "table+=\"<li>\"+dtJson[i].Title+\"</li>\"}table+=\"</ul>\";document.write(table);}}},error: function(error){} }); }<\/script>";
            layer.open({
                type: 1,
                skin: 'layui-layer-rim', //加上边框
                area: ['480px', '230px'], //宽高
                content: "<textarea id=\"editor_id\" name=\"content\" style=\"width: 100%; height: 600px; box-sizing: border-box;\">" + strCode + "</textarea>"
            });
        }

    </script>
</body>
</html>
