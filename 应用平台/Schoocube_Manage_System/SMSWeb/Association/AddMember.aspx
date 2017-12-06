<%@ Page Title="" Language="C#" MasterPageFile="~/EmptySite.Master" AutoEventWireup="true" CodeBehind="AddMember.aspx.cs" Inherits="SMSWeb.Association.AddMember" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Stu_css/common.css" rel="stylesheet" />
<link rel="stylesheet" href="../Style/iconfont.css" />
<link rel="stylesheet" href="../Stu_css/allst.css"/>
<link href="../Stu_css/layout.css" rel="stylesheet" />
<link href="../Stu_css/StuAssociate.css" rel="stylesheet" type="text/css" />
<style type="text/css">
    #memShow { margin:auto;width:680px;border: 1px solid #C1CDC1;clear:both; }
    #memShow li { float:left;margin:0px 5px; }
    .line { line-height:21px }    
    .select{ background-color:#00a1ec;height:22px;width:65px;color:white;border:0px; line-height:22px;}
</style>
<script src="../Stu_js/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
    $(function () {
        var loginNames = $("#MemberID").val();
        $(":checkbox").each(function () {
            var loginName = $(this).val();
            if (loginNames.indexOf(loginName) != -1) {
                $(this).attr("checked", "checked");
            }
        })
    });
    function selected(chk) {
        var chked = $(chk).attr("checked");
        var value = $(chk).val();
        if (chked == undefined) { //取消选中
            delItem(value);
        }
        else { //选中
            addItem(value);
        }
    }
    function isHave(value) {
        var ishav = false; var liid = $("#MemberID").val();
        if (liid.indexOf(value) != -1) {
            ishav = true;
        }
        //$("#memShow li").each(function(){
        //    liid=$(this).attr("id");
        //    if(value==liid){
        //        ishav = true;
        //    }
        //});
        return ishav;
    }
    function addItem(value) {
        if (!isHave(value)) {
            var mid = $("#MemberID").val();
            mid += value + ",";
            $("#MemberID").val(mid);
            //$("#memShow").prepend("<li id=\"" + value + "\"></li>");
        }
    }
    function delItem(value) {
        if (isHave(value)) {
            var mid = $("#MemberID").val();
            mid = mid.replace(value + ",", "");
            $("#MemberID").val(mid);
            //var li = $("#memShow li");
            //if (li.length > 0) {
            //    for (var i = 0; i < li.length; i++) {
            //        var liid = $(li[i]).attr("id");
            //        if (value == liid) {
            //            $(li[i]).remove();
            //        }
            //    }
            //}
        }
    }
    function checkMember() {
        var mid = $('#<%= MemberID.ClientID%>').val();
        if (mid == "") { return false; }
    }
</script>
<div class="writing_form">    
    <div style="padding: 10px">
        <span>
            <%--<asp:DropDownList CssClass="option" ID="DDL_Class" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DDL_Class_SelectedIndexChanged" />--%>
            <asp:DropDownList CssClass="option" ID="DDL_Type" runat="server" />
            姓名：<asp:TextBox ID="Tb_searchTitle" placeholder="请输入学生名" runat="server" Height="21px" CssClass="line" /></span>
                    <span ><asp:Button runat="server" ID="btnSearch" CssClass="select" OnClick="btnSearch_Click" Text="查询" /></span>
    </div>    
    <div id="memShow" style="display:none;">
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="MemberID" />        
    </div>
    <div class="content_list" style="min-height:365px">        
        <table class="W_form" style="margin:auto;width:680px;">
            <thead>
                <tr class="trth">
                    <th>选择</th>
                    <th>姓名</th>
                    <%--<th>性别</th>--%>
                    <th>身份</th>
                </tr>
            </thead>
            <tbody>
                <asp:ListView ID="lvRow" runat="server" OnPagePropertiesChanging="lvRow_PagePropertiesChanging">
                    <EmptyDataTemplate>
                        <tr class="Single">
                            <td colspan="4" style="text-align: center">暂无记录!</td>
                        </tr>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <tr class="Single">
                            <td><input type="checkbox" onclick="selected(this);" value='<%#Eval("ID")%>' <%#Eval("IsCun") %> ></td>
                            <td><%#Eval("Name")%></td>
                            <%--<td><%#Eval("Sex")%></td>--%>
                            <td><%#Eval("Role")%></td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
            </tbody>
        </table>
        <div class="page">
            <asp:DataPager ID="DataPager" PageSize="10" runat="server" PagedControlID="lvRow">
                <Fields>
                    <asp:NextPreviousPagerField ButtonType="Link" FirstPageText="首页" PreviousPageText="上一页"
                        ShowFirstPageButton="true" ShowPreviousPageButton="true" ShowNextPageButton="false" />
                    <asp:NumericPagerField CurrentPageLabelCssClass="number now" NumericButtonCssClass="number" />
                    <asp:NextPreviousPagerField ButtonType="Link" NextPageText="下一页" LastPageText="末页"
                        ShowLastPageButton="true" ShowPreviousPageButton="false" ShowNextPageButton="true" />
                    <asp:TemplatePagerField>
                        <PagerTemplate>
                            <span class="page">| <%#Container.StartRowIndex/Container.PageSize+1%> /
                                   <%#(Container.TotalRowCount%Container.MaximumRows)>0?Container.TotalRowCount/Container.MaximumRows+1:Container.TotalRowCount/Container.MaximumRows %>页
                                   (共<%#Container.TotalRowCount%>项)
                            </span>
                        </PagerTemplate>
                    </asp:TemplatePagerField>
                </Fields>
            </asp:DataPager>
        </div>
    </div>
    <div class="t_btn" style="margin-left: 250px">
        <asp:Button runat="server" ID="btnSave" CssClass="btn btn_sure" OnClientClick="checkMember();" OnClick="btnSave_Click" Text="保存" />
        <input type="button" class="btn btn_cancel" onclick="parent.closePages();" value="取消" />
    </div>
</div>
</asp:Content>
