<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisitRate.aspx.cs" Inherits="SMSWeb.SysMessage.VisitRate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>网站统计</title>
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
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script id="tr_Course" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>${name}</td>
            <td>${count}</td>
            <td><a href="javascript:;" onclick="javascript: OpenIFrameWindow('查看数据', 'VisitRateQuery.aspx?type=${Type}', '880px', '660px');"><i class="icon icon-edit"></i>查看</a></td>
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

        .main {
            height: 400px;
            /* width: 778px !important; */
            overflow: hidden;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #e3e3e3;
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
            -moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
            box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
        }
    </style>
</head>
<body>
    <div class="onlinetest_item pr ">
        <div class=" chartsdiv" style="background: #fff; padding: 10px;">
            <div class="stytem_select clearfix">
                <div class="fl" style="margin-top: 5px;">
                    <label for="">选择课程类型：</label>
                    <select name="" class="select" id="CourseType" onchange="query();">
                        <option value="0">精品课程</option>
                        <option value="1">热门课程</option>
                        <option value="2">最新课程</option>
                    </select>
                </div>
            </div>
            <div class="wrap">
                <div class="distributed fr">
                    <a href="javascript:void(0);" onclick="query()"><i class="icon icon-plus"></i>查询</a>
                </div>
                <table class="hr_mess">
                    <thead>
                        <tr>
                            <th class="number">序号</th>
                            <th>名称</th>
                            <th>数量</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody id="tb_Course"></tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="page">
        <span id="pageBar"></span>
    </div>
    <script type="text/javascript">
        $(function () {
            getData(1, 10);
        })
        function getData(startIndex, pageSize) {
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "PortalManage/AdminManager.ashx",
                    "Func": "GetThisWebPageList",
                    PageIndex: startIndex,
                    PageSize: pageSize,
                    CourseType: $("#CourseType").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#tb_Course").html('');
                        $("#tr_Course").tmpl(json.result.retData.PagedData).appendTo("#tb_Course");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        function query() {
            getData(1, 10);
        }

    </script>
</body>
</html>
