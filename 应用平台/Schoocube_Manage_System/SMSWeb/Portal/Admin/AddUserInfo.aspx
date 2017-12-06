<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddUserInfo.aspx.cs" Inherits="SMSWeb.Portal.Admin.AddUserInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/css/onlinetest.css" rel="stylesheet" />
    <script src="//Scripts/jquery-1.11.2.min.js"></script>
    <script src="//Scripts/Common.js"></script>
    <script src="//Scripts/layer/layer.js"></script>
    <script src="//Scripts/jquery.cookie.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script id="tr_data" type="text/x-jquery-tmpl">
        {{if likeUser(LoginName)==false}}
        <tr>
            <td>
                <input type="checkbox" name="cbkmessage" value="${Id}" onclick="checkItem(this)" /></td>
            <td>${pageIndex()}
            </td>
            <td>${LoginName}</td>
            <td>${Name}</td>
            <td>${Age}</td>
            <td>{{if Sex==0}}男
                {{else Sex==1}}女
                {{else}}未知
                 {{/if}}
            </td>
        </tr>
         {{/if}}
    </script>
</head>
<body style="background:#fff;">
    <form id="form1" runat="server">
        <asp:HiddenField ID="MenuId" runat="server" />
        <div class="onlinetest_item">
            <div class="course_manage bordshadrad">
                <div class="newcourse_select clearfix">
                    <div class="clearfix fl course_select">
                        <label for="">选择身份：</label>
                        <select name="" class="select" id="selType" onchange="getData(1, 10)">
                            <option value="1">教师</option>
                            <option value="0">学生</option>
                        </select>
                    </div>
                    <div class="distributed fr">
                      <%--  <a href="javascript:void(0);" onclick="query()"><i class="icon icon-plus"></i>查询</a>--%>
                    </div>
                </div>
                <div class="wrap">
                    <table class="PL_form">
                        <thead>
                            <tr>
                                <th>
                                    <input type="checkbox" name="cbkAllmessage" class="Check_box" onclick="checkItem(this);" />
                                </th>
                                <th class="number">序号</th>
                                <th>登录名</th>
                                <th>姓名</th>
                                <th>年龄</th>
                                <th>性别</th>
                            </tr>
                        </thead>
                        <tbody id="tb_data"></tbody>
                    </table>
                    
                </div>
            </div>
        </div>
        <!--分页-->
        <div class="page">
            <span id="pageBar"></span>
        </div>
        <div style="clear: both"></div>

        <div class="course_form_select clearfix" style="text-align:center">
            <a href="javscript:;" class="course_btn confirm_btn" onclick="saveData()" id="btnCreate">确定</a>
        </div>
    </form>
    <script type="text/javascript">
        var arryUsers = [];
        var redLoginNames = "";
        $(document).ready(function () {
            getUsers();
        });

        function getUsers() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/PortalManage/AdminManager.ashx",
                    Func: "GetUserInfoList",
                    MenuId:$("#MenuId").val(),
                    isPage:false
                },
                success: function (json)
                {
                    redLoginNames = "";
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData;
                        if (items!=null && items.length>0) {
                            for (var i = 0; i < items.length; i++) {
                                redLoginNames += "," + items[i].LoginName;
                            }
                            if (redLoginNames != "") redLoginNames = redLoginNames + ",";
                        }
                    }
                    getData(1, 10);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function likeUser(LoginName)
        {
            var newLogInNames = "," + LoginName + ",";
            if (redLoginNames != "" && redLoginNames.indexOf(newLogInNames) > -1) {
                return true;
            }
            return false;
        }

        function getData(startIndex, pageSize) {
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            var func = "";
            if ($("#selType").val() == "1") {
                func = "GetTeacherPageData";
            } else {
                func = "GetStudentPageData";
            }
            $.ajax({
                url: "/SystemSettings/CommonInfo.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    Func: func,
                    PageIndex: startIndex,
                    pageSize: pageSize
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_data").html('');
                        arryUsers = [];
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) arryUsers = items;
                        $("#tr_data").tmpl(items).appendTo("#tb_data");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                    }
                    else {
                        arryUsers = [];
                        $("#tb_data").html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });

        }

        function checkItem(obj) {
            var checkArry = $(".PL_form").find("input[type='checkbox']");
            checkAll(checkArry);
        }

        function checkAll(oInput) {
            var isCheckAll = function () {
                for (var i = 1, n = 0; i < oInput.length; i++) {
                    oInput[i].checked && n++
                }
                oInput[0].checked = n == oInput.length - 1;
            };
            //全选
            oInput[0].onchange = function () {
                for (var i = 1; i < oInput.length; i++) {
                    oInput[i].checked = this.checked
                }
                isCheckAll()
            };
            //根据复选个数更新全选框状态
            for (var i = 1; i < oInput.length; i++) {
                oInput[i].onchange = function () {
                    isCheckAll()
                }
            }
        }

        function saveData()
        {
            var ids = "";
            $("input[name='cbkmessage']").each(function () {
                if ($(this).is(':checked')) {
                    var vals = $(this).val();
                    ids += vals + ",";
                }
            });
            if (ids == "") {
                layer.msg("请选择人员！");
                return false;
            }
            ids=","+ids;
            var selArry = [];
            var selJson = "";
            for (var i = 0; i < arryUsers.length; i++) {
                var userId = ","+arryUsers[i].Id+",";
                if (ids.indexOf(userId) > -1) {
                    var item = new Object();
                    item.MenuId = $("#MenuId").val();
                    item.LoginName = arryUsers[i].LoginName;
                    item.Name = arryUsers[i].Name;
                    item.Email = arryUsers[i].Email;
                    item.IsDelete = 0;
                    item.CreateTime = '';
                    item.RoleType = $("#selType").val();
                    selArry.push(item);
                }
            }
            if (selArry.length > 0) {
                selJson = JSON.stringify(selArry);
            }
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "PortalManage/AdminManager.ashx",
                    "func": "AddUserInfoForMenu",
                    "Users": selJson
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        layer.msg('操作成功!');
                        parent.getData(1,10);
                        parent.CloseIFrameWindow();
                        
                    }
                },
                error: OnError
            });
        }

    </script>
</body>
</html>
