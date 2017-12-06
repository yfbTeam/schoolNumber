<%@ Page Title="" Language="C#" MasterPageFile="~/SMS.Master" AutoEventWireup="true" CodeBehind="AssociaeList.aspx.cs" Inherits="SMSWeb.Association.AssociaeList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Stu_css/common.css" rel="stylesheet" />
<link href="../Stu_css/allst.css" rel="stylesheet" />
<link rel="stylesheet" href="../Stu_css/list_nr.css"/>
<style type="text/css">    
    .line {line-height:21px}
    .asearch { display: inline-block }
</style>
<div class="writingform">
    <div class="writing_title">
        <h2>
            <span class="title_left fl"><asp:Label runat="server" ID="lb_Title" /></span>
        </h2>
    </div>
    <div class="writing_form">
        <div class="content_list">
            <div class="zs_beizhu" style="padding-left: 10px">
                <span style="margin:0px;">社团：<asp:DropDownList CssClass="option" Height="22px" ID="DDL_Associae" runat="server" /></span>
                <span style="margin:0px;"><asp:TextBox ID="Tb_searchTitle" placeholder="请输入关键字" runat="server" Height="21px" CssClass="line" /></span>
                <span>
                    <asp:LinkButton runat="server" ID="btnSearch" CssClass="asearch" Text="查询" OnClick="btnSearch_Click" />
                    <%--<a href="javascript:void(0)" style="display: inline-block" onclick="serachData(1,'');"></a>--%></span>
            </div>
            <table class="W_form">
                <thead>
                    <tr class="trth">
                        <asp:ListView runat="server" ID="lvColumn">
                            <ItemTemplate>
                                <th><%#Eval("Title")%></th>
                            </ItemTemplate>
                        </asp:ListView>
                    </tr>
                </thead>
                <tbody>
                    <asp:ListView ID="lvRow" runat="server" OnPagePropertiesChanging="lvRow_PagePropertiesChanging">
                        <EmptyDataTemplate>
                            <tr class="Single">
                                <td colspan="5" style="text-align: center">暂无查询的记录</td>
                            </tr>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <tr class="Single">
                                <td style="text-align:left;text-indent:1em;"><a href='<%# Eval("Url") %>'><%#Eval("Title")%></a></td>
                                <td style="display:<%=this.newCol%>"><%#Eval("Activity")%></td>
                                <td><%#Eval("Associae")%></td>
                                <td><%#Eval("Author")%></td>
                                <td><%#Eval("Created")%></td>
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
    </div>
</div>
</asp:Content>
