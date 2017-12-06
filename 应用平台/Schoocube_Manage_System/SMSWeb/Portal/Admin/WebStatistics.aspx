<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebStatistics.aspx.cs" Inherits="SMSWeb.Portal.Admin.WebStatistics" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="//PortalCss/reset.css" rel="stylesheet" />
    <link href="//PortalCss/layout.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="//css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="//css/common.css" />
    <link rel="stylesheet" type="text/css" href="//css/repository.css" />
    <link rel="stylesheet" type="text/css" href="//css/onlinetest.css" />
    
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/PortalJs/layout.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>

    <script id="tr_Course" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>${name}</td>
            <td>${count}</td>
            <td><a href="javascript:;" onclick="javascript: OpenIFrameWindow('查看数据', 'WebSiteQuery.aspx?type=${Type}', '880px', '660px');"><i class="icon icon-edit"></i>查看</a></td>
        </tr>
    </script>
</head>
<body>
         <form id="form2" runat="server">
        <div class="onlinetest_item">
            <div class="course_manage bordshadrad">
                <script type="text/javascript">
                    var ptitle = getQueryString("ptitle");
                    var title = getQueryString("title");
                    document.write("<div class=\"crumbs\" style=\"padding: 0; background: #fff;\"><a href=\"\">" + ptitle + "</a> <span>&gt;</span><a href=\"\">" + title + "</a></div>");
                </script>

                <div class="newcourse_select clearfix">
                    <div class="clearfix fl course_select">
                        <label for="">选择课程类型：</label>
                        <select name="" class="select" id="CourseType" onchange="query();">
                            <option value="0">精品课程</option>
                            <option value="1">热门课程</option>
                            <option value="2">最新课程</option>
                        </select>
                    </div>
                  <%--  <div class="clearfix fl course_select">
                        <label for="">选择统计图类型：</label>
                        <select name="" class="select" id="ChartType" onchange="query();">
                            <option value="1">2D</option>
                            <option value="0">3D</option>
                        </select>
                    </div>--%>
                </div>
                <div class="wrap">
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
         <!--分页-->
        <div class="page">
            <span id="pageBar"></span>
        </div>
        
    </form>
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
                 //$('.allcourses li .allcourse_img img')
             });
         }


        
         function query() {
             getData(1, 10);
             //getChart();
         }


    </script>
  
</body>
</html>
