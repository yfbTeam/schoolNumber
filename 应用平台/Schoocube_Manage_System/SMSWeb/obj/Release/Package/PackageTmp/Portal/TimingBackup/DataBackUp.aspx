<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataBackUp.aspx.cs" Inherits="SMSWeb.Portal.TimingBackup.DataBackUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="../../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../../css/onlinetest.css" />
     <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
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
</head>
<body>
    <form id="form1" runat="server">
     <%--   <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDataBound="GridView1_RowDataBound" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating"  PageSize="2" AllowPaging="True" OnRowDeleting="GridView1_RowDeleting"  DataKeyNames="id">
            <EmptyDataTemplate>
                <table border="1" style="width:100%">
                    <tbody>
                        <tr>
                            <td>Id</td>  <td>文件名称</td>  <td>文件路径</td>  <td>文件大小</td>  <td>创建时间</td>
                        </tr>
                        <tr>
                            <td colspan="5" style="text-align:center">暂无数据！</td>
                        </tr>
                    </tbody>
                </table>
                
            </EmptyDataTemplate>
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                
                <asp:TemplateField HeaderText="id">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="文件名称">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("title") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="文件路径">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("path") %>'></asp:Label></ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="文件大小">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("size") %>'></asp:Label></ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="创建时间">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("LastWriteTime", "{0:d}") %>'></asp:Label></ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>--%>
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
                        <select name="" class="select" id="selType" onchange="getData(1, 10)">
                            <option value="">请选择类型</option>
                            <option value="0">自动备份</option>
                            <option value="1">手动备份</option>
                        </select>
                    </div>
                    <div class="clearfix fl course_select">
                        <label for="">选择日期：</label>
                        <input type="text" class="Wdate" id="StarDate" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'EndDate\',{d:-1});}'})" />
                        <input type="text" class="Wdate" id="EndDate" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'StarDate\',{d:0});}'})" />
                    </div>
                    <div class="distributed fr">
                        <asp:Button ID="btnBackUp" runat="server" Text="立即备份" OnClick="btnBackUp_Click"  style="background: #207abd;
    padding: 7px 12px;
    font-size: 14px;
    color: #fff;
    border-radius: 2px;
    display: inline-block;
    margin-right: 5px;border:none;"/>
                        <a href="javascript:void(0);" onclick="query()"><i class="icon icon-plus"></i>查询</a>
                    </div>
                </div>
                <div class="wrap">
                    <table>
                        <thead>
                            <tr>
                                <th class="number">序号</th>
                                <th>备份路径</th>
                                <th>类型</th>
                                <th>备份时间</th>
                            </tr>
                        </thead>
                        <tbody id="tb_backUp"></tbody>
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
