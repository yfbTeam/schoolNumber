<%@ Page Title="" Language="C#" MasterPageFile="~/EmptySite.Master" AutoEventWireup="true" CodeBehind="AssociaeMember.aspx.cs" Inherits="SMSWeb.Association.AssociaeMember" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/Stu_css/common.css" rel="stylesheet" />
<link href="/Stu_css/allst.css" rel="stylesheet" />
<link href="/Stu_css/StuAssociate.css" rel="stylesheet" type="text/css" />
<link href="/Stu_css/ico/iconfont.css" rel="stylesheet" />
<link href="/Stu_css/list_nr.css" rel="stylesheet" />
<style type="text/css">
    .btn{ width:70px;height:25px;line-height:25px;color:#fff;text-align:center;background: #0da6ec;border-radius: 5px;margin:3px;cursor:pointer; }
</style>
<asp:ScriptManager ID="ScriptManager1" runat="server" > 
</asp:ScriptManager> 
<div style="background-color:#fff;min-height:800px">
<!-- 社团 -->
<%--<div class="left_navcon zubie_navcon" style="min-height:400px">
    <div class="select-box">
        <div style="background-color:#f6f6f6;text-align:center">
            <div class="i-menu cf">
                <span class="tit fl">全部社团</span>
            </div>
        </div>
        <asp:ListView runat="server" ID="lvGroup">
            <ItemTemplate>
                <div class="item">
                    <div class="i-menu cf">
                        <span class="tit fl" id="<%#Eval("ID")%>" onclick="selectOne(this);"><%#Eval("Associae")%></span>
                    </div>
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>
</div>--%>
<!-- 班级 -->
<div class="gl_zubienr_list fr">    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="True" RenderMode="Block">
        <ContentTemplate>
          <%--  <div style="margin: 10px;padding:10px;font-size:14px;border:1px solid #84d3f4;background-color:#e0f4fd;">
                <span>
                    社团长：<asp:Label runat="server" ID="lb_Leader"/>&nbsp;&nbsp;副团长：<asp:Label runat="server" ID="lb_SecLeader"/>
                </span>
                <span style="float:right">
                    <asp:HiddenField runat="server" ClientIDMode="Static" ID="AssociaeId" />
                    <asp:HiddenField runat="server" ClientIDMode="Static" ID="MemberID" />
                    <asp:Button ID="btnOK" runat="server" CssClass="btn" Text="添加" OnClientClick="openPage('添加成员','AddMember.aspx','700','550');return false;" />
                    <asp:Button ID="btnRem" runat="server" CssClass="btn" Text="移除" OnClientClick="getSelected();" OnClick="btnRem_Click" />
                    <span style="display:none">
                    <asp:HiddenField runat="server" ClientIDMode="Static" ID="Manager" />
                    <asp:Button ID="btnReload" runat="server" Text="刷新" OnClick="btnReload_Click" />
                    <asp:Button ID="btnManage" runat="server" Text="修改团长" OnClick="btnManage_Click" />
                    </span>
                </span>
            </div>--%>
            <div class="zb_list" style="margin:10px">
                <table class="W_form">
                    <thead>
                        <tr class="trth">
                            <th>选择</th>
                            <th>学生</th>
                            <th>性别</th>
                            <th>班级</th>
                            <th style="width:160px">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:ListView ID="lvRow" runat="server" OnPagePropertiesChanging="lvRow_PagePropertiesChanging">
                            <EmptyDataTemplate>
                                <tr class="Single">
                                    <td colspan="5" style="text-align: center">该社团暂无学生记录</td>
                                </tr>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <tr class="Single">
                                    <td><input type="checkbox" name="me" value='<%#Eval("ID")%>'></td>
                                    <td><%#Eval("Name")%></td>
                                    <td><%#Eval("Sex")%></td>
                                    <td><%#Eval("Class")%></td>
                                    <td><%#Eval("OP")%><%--<input type="button" class="select" onclick="editItem(this)" value="销假" />--%></td>
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
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
</div>
<script src="/Script/jquery-1.8.2.min.js"></script>
<script src="/Script/popwin.js"></script>
<script type="text/javascript">
    function selectOne(span) {
        var item = $(span).closest(".item");
        $(item).siblings(".item").css("background", "#ecf0f3");
        $(item).css("background", "#b3e7fd");
        var aid = $(span).attr("id");
        reloadMember(aid);
    }
    function getSelected() {
        var ids = ""; var hasLeader = false;
        var chk = $("input[name='me']:checked");
        for (var i = 0; i < chk.length; i++) {
            var identity = $(chk[i]).parent("td").siblings().eq(3).text();
            if (identity == "社团长" || identity == "副团长") {
                hasLeader = true;
            }
            ids += chk[i].value;
            if (i < chk.length - 1) {
                ids += ",";
            }
        }
        if (hasLeader) {
            if (!confirm("您确定删除社团长或副团长？")) {
                return false;
            }
        }
        if (ids != "") {
            if (confirm("您确定删除选中成员？")) {
                $("#MemberID").val(ids);
            }
        }
        else {
            alert("您没有选中要删除的项！");
            return false;
        }
    }
    function reloadMember(aid) {
        $("#AssociaeId").val(aid);
        $("input[id$='btnReload']").click();
    }
    function editItem(flag, id) {
        $("#Manager").val(flag + "," + id);
        $("input[id$='btnManage']").click();
    }
    function openPage(pageTitle, pageName, pageWidth, pageHeight) {
        var aid = $("#AssociaeId").val();
        if (aid != "") {
            var webUrl = _spPageContextInfo.webAbsoluteUrl;
            popWin.showWin(pageWidth, pageHeight, pageTitle, webUrl + pageName + "?itemid=" + aid);
        }
        else {
            alert("请您先选中社团后，再添加人员！");
        }
    }
    function closePages(assid) {
        if (assid != "") {
            reloadMember(assid);
        }
        $("#mask,#maskTop").fadeOut();
    }
</script>
</asp:Content>
