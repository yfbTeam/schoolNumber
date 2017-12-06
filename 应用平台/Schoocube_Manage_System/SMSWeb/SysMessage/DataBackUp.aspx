<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataBackUp.aspx.cs" Inherits="SMSWeb.SysMessage.DataBackUp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>数据备份</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <!--[if IE]>
    <script src="/js/html5.js"></script>
    <![endif]-->
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <script id="tr_backUp" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>${Path}</td>
            <td>{{if Type==1}}手动备份
                {{else}}自动备份
                {{/if}}</td>
            <td>${CreateTime}</td>
        </tr>
    </script>
    <style>
        .wrap table tbody tr td a {
            display: inline-block;
            background: none;
            color: #5493d7;
        }

        * {
            box-sizing: border-box;
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
</head>
<body>
     <form id="form1" runat="server">

    <div class="onlinetest_item pr ">
        <div class=" chartsdiv" style="background: #fff; padding: 10px;">
            <div class="stytem_select clearfix" style="height:auto;">
                <div class="fl" style="margin-top: 5px;">
                    <label style="float: left; line-height: 38px; display: block;">选择类型：</label>
                    <select name="" class="select" id="selType" onchange="getData(1, 10)">
                        <option value="">请选择类型</option>
                        <option value="0">自动备份</option>
                        <option value="1">手动备份</option>
                    </select>
                </div>
                <div class="clearfix fl course_select">
                    <label for="">选择日期：</label>
                    <input type="text" class="Wdate" id="StarDate" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'EndDate\',{d:-1});}'})" style="width:90px;"/>
                    <input type="text" class="Wdate" id="EndDate" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'StarDate\',{d:0});}'})" style="width:90px;" />
                </div>
            </div>
            <div class="wrap">
                <div class="distributed fr">
                    <asp:Button ID="btnBackUp" runat="server" Text="立即备份" OnClick="btnBackUp_Click" Style="background: #207abd; padding: 7px 12px; font-size: 14px; color: #fff; border-radius: 2px; display: inline-block; margin-right: 5px; border: none;" />
                    <a href="javascript:void(0);" onclick="query()">查询</a>
                </div>
               
                    <table>
                        <thead>
                            <tr>
                                <th class="number">序号</th>
                                <th>备份路径</th>
                                <th>类型</th>
                                <th>备份时间</th>
                            </tr>
                        </thead>
                        <tbody id="tb_backUp">
                        </tbody>
                    </table>
            </div>
        </div>
    </div>
           <!--分页-->
        <div class="page">
            <span id="pageBar"></span>
        </div>
         </form>
    <script>
        $(function () {
            getData(1, 10);
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
                    PageName: "PortalManage/AdminManager.ashx",
                    Func: "GetDbBackUpPageList",
                    type: $("#selType").val(),
                    StarDate: $("#StarDate").val(),
                    EndDate: $("#EndDate").val(),
                    PageIndex: startIndex,
                    pageSize: pageSize
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_backUp").html('');
                        $("#tr_backUp").tmpl(json.result.retData.PagedData).appendTo("#tb_backUp");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                    }
                    else {
                        $("#tb_backUp").html("<tr><td colspan='4'>暂无数据备份！</td></tr>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function query() {
            getData(1, 10);
        }

    </script>
</body>
</html>

