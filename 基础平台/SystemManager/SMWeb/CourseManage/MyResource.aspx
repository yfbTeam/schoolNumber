<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyResource.aspx.cs" Inherits="SMSWeb.CourseManage.MyResource" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>个人网盘</title>
    <link href="/css/style.css" rel="stylesheet" />
    <link href="/css/common.css" rel="stylesheet" />
    <link href="/css/iconfont.css" rel="stylesheet" />
    <link href="/css/animate.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <%--<script type="text/javascript">
        //追加一行（新建文件夹）

        function appendAfterRow(tableID, RowIndex) {
            var txt1 = document.getElementById("txt1");
            if (txt1 != undefined) {
                txt1.onfocus();
            }
            else {
                var o = document.getElementById(tableID);
                var refRow = RowIndex;
                if (refRow == "") refRow = getO("nRow").value;
                var v = "<img src='/_layouts/15/images/folder.gif?rev=23' style='float:left; margin-left:10px; margin-top:4px;'>" +
                    "<input type='text' value='新建文件夹' style='float:left;line-height:10px;margin-top:5px;width:100px;' id=\"txt" + RowIndex +
                    "\"/> <i class=\"iconfont tishi true_t\" style=\"margin: 2px; color: #87c352; float: left;cursor:pointer;\" onclick=\"AddFold('" + RowIndex
                    + "')\">&#xe61d;</i> <i class=\"iconfont tishi fault_t\" style=\"margin: 2px; color: #ff6d72; float: left;cursor:pointer;\" onclick=\"DelRow()\">&#xe61e;</i>";
                var newRefRow = o.insertRow(refRow);
                newRefRow.insertCell(0).innerHTML = "";

                newRefRow.insertCell(1).innerHTML = v;
                newRefRow.insertCell(2).innerHTML = "--";
                var now = new Date();
                //var nowStr = now.Format("yyyy-MM-dd");
                newRefRow.insertCell(3).innerHTML = now;
            }
        }
        function getO(id) {
            if (typeof (id) == "string")
                return document.getElementById(id);
        }
        //删除一行（table）
        function DelRow() {
            $('table tr:eq(1)').remove();
        }
        //新增文件夹
        function AddFold(em) {
            var FileName = $("#txt" + em + "").val();
            $.ajax({
    
                url: "MyResource.ashx",
                data: { Func: "AddFolder", "FileName": FileName, FoldUrl: $("#HFoldUrl").val() },
                dataType: "text",
                success: function (returnVal) {
                    getData(1);
                },
                error: function (errMsg) {
                    alert('数据加载失败！');
                }
            });
        }

    </script>--%>
    <script id="tr_User" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>${DocName}</td>
            <td>${DocSize}</td>
            <td>${CreateTime}</td>
            <td>${EditTime}</td>

            <%--<td>
                <input type="button" class="Topic_btn" value="编辑" onclick="javascript: OpenIFrameWindow('编辑教师', 'UserEdit.aspx?itemid=${Id}', '560px', '450px');" />
                <input type="button" class="Topic_btn" value="启用" onclick="javascript: ChangeUseStatus(this, '${Id}', 0, 'UserInfo');" />
                <input type="button" class="Topic_btn" value="禁用" onclick="javascript: ChangeUseStatus(this, '${Id}', 1, 'UserInfo');" />
            </td>--%>
        </tr>

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input id="HFoldUrl" type="hidden" value="DriveFolder/" />
        <div class="Teaching_plan_management">
            <h1 class="Page_name">个人网盘</h1>
            <div class="Operation_area">
                <div class="left_choice fl">
                    <ul>
                        <li class="Sear">
                            <input type="text" id="search_w" name="search_w" class="search_w" placeholder="请输入姓名" value="" /><a class="sea" href="#" onclick="getData(1);">搜索</a>
                        </li>
                    </ul>
                </div>
                <div class="right_add fr">
                    <a href="#" class="add" onclick="uploader()"><i class="iconfont">&#xe65a;</i>上传文件</a>
                    <a href="#" class="add" onclick="javascript: appendAfterRow('tb_MyResource', '1')"><i class="iconfont">&#xe601;</i>新建文件夹</a>
                    <div class="Batch_operation fl">
                        <a href="#" class="add"><i class="iconfont">&#xe602;</i>批量操作</a>
                        <ul class="B_con" style="display: none;" id="B_con">
                            <li><a href="#" onclick="Move('')">移动到</a></li>
                            <li><a href="#" onclick="Move()">复制到</a></li>
                            <li><a href="#" onclick="DelMore()">删除</a></li>
                            <li><a href="#" onclick="Down('')">下载</a></li>
                        </ul>
                    </div>
                    <div class="Batch_operation fl">
                        <a href="#" class="add"><i class="iconfont">&#xe62a;</i>分享到</a>
                        <ul class="B_con" style="display: none; width: 76px;">
                            <li><a href="#" onclick="ShareTolibrary('')">资源库</a></li>
                            <li><a href="#" onclick="openShare()">校本资源库</a></li>
                            <li><a href="#" onclick="ShareToPerson()">指定人</a></li>

                        </ul>
                    </div>

                </div>

            </div>
            <div class="Honor_management">
                <table class="W_form" id="tb_MyResource">
                    <thead>
                        <tr class="trth">
                            <th class="number">序号</th>
                            <th>文件名称</th>
                            <th>文件大小</th>
                            <th>创建时间</th>
                            <th>修改时间</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
            <!--分页页码开始-->
            <div class="paging">
                <span id="pageBar"></span>
            </div>
            <!--分页页码结束-->
        </div>
    </form>
</body>
<script type="text/javascript">
    $(document).ready(function () {
        //获取数据
        getData(1);
    });
    //获取数据
    function getData(startIndex) {
        //var name = $("#search_w").val();
        //初始化序号 
        pageNum = (startIndex - 1) * 10 + 1;
        //name = name || '';
        $.ajax({
            url: "MyResource.ashx",//random" + Math.random(),//方法所在页面和方法名

            async: false,
            dataType: "json",
            data: { "Func": "GetPageList", PageIndex: startIndex, pageSize: 10 },
            success: OnSuccess,
            error: OnError
        });
    }

    function OnSuccess(json) {
        if (json.result.errNum.toString() == "100") {
            $("#tb_MyResource tbody").html('无内容');
        } else {
            var PagedData = $.parseJSON(json.result.retData.PagedData);
            $("#tb_MyResource tbody").html('');
            $("#tr_User").tmpl(PagedData.data).appendTo("#tb_MyResource");
            //隔行变色以及鼠标移动高亮
            $(".main-bd table tbody tr").mouseover(function () {
                $(this).addClass("over");
            }).mouseout(function () {
                $(this).removeClass("over");
            })
            $(".main-bd table tbody tr:odd").addClass("alt");
            //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
            makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 8, json.result.retData.RowCount);
        }
    }
    function OnError(XMLHttpRequest, textStatus, errorThrown) {
        $("#tb_UserList tbody").html('无内容');
    }
    /*
    function DeleteUser(id) {
        layer.msg("确定要删除该用户?", {
            time: 0 //不自动关闭
            , btn: ['确定', '取消']
            , yes: function (index) {
                layer.close(index);
                $.ajax({
                    url: "MyResource.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { "intID": id },
                    success: OnSuccessDelete,
                    //error: OnErrorDelete
                });
            }
        });
        function OnSuccessDelete(json) {
            if (json.result != "0") {
                layer.msg("删除成功！");
                getData(1);
            } else {
                layer.msg("删除失败！");
            }
        }
    }*/
</script>
</html>
