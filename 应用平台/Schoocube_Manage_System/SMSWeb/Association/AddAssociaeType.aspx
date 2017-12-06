<%@ Page Title="" Language="C#" MasterPageFile="~/EmptySite.Master" AutoEventWireup="true" CodeBehind="AddAssociaeType.aspx.cs" Inherits="SMSWeb.Association.AddAssociaeType" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="../Stu_css/iconfont.css" />
<link href="../Stu_css/common.css" rel="stylesheet" />
<style type="text/css">
    a { text-decoration:none }
    .line { line-height:0px; }
    .add_GL {width:70px;height:25px;line-height:25px;color:#fff;text-align:center;font-size:14px;background: #0da6ec;border-radius: 5px;display: block;float: right;cursor:pointer;}
    .add_GL:hover{color:#fff;}
    .setting {float:left;width:165px;height:40px;border:1px solid #C1CDC1;margin:2px;list-style:none;line-height:40px}
</style>
<div id="container" style="margin:8px;color:#363636">
    <span style="width:100%;color:red" runat="server" id="msg" visible="false"><asp:Label runat="server" ID="lbMsg"/></span>
    <div style="width: 513px; height: 24px;line-height:30px; margin: 5px auto">
        <span style="float: left">
            <asp:Label runat="server" Text="社团类型:" />
            <asp:TextBox ID="TB_Type" runat="server" Width="100px" CssClass="line"/>
            <span style="color: red;">*
                <asp:RequiredFieldValidator ID="RFV_Type" runat="server" ControlToValidate="TB_Type"
                    ErrorMessage="必填" ValidationGroup="ProjectSubmit" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></span>
        </span>
        <span style="float: right">
            <asp:LinkButton ID="btnOK" runat="server" CssClass="add_GL" Text="确定" ValidationGroup="ProjectSubmit"  OnClick="btnOK_Click" />
        </span>
    </div>
    <ul style="width: 100%;padding-top:3px">
        <asp:ListView ID="LV_TermList" runat="server"  OnItemCommand="LV_TermList_ItemCommand">
            <EmptyDataTemplate>
                <li style="margin:auto">社团类型</li>
            </EmptyDataTemplate>
            <ItemTemplate>
                <li class="setting">
                    <span style="margin-left:7px"><%# Eval("Title") %></span>
                    <asp:LinkButton runat="server" ID="LB_Del" CommandName="Del" CommandArgument='<%# Eval("Id") %>' OnClientClick="return confirm('你确定要删除吗？');"><i class="iconfont">&#xe65c;</i></asp:LinkButton>
                </li>
            </ItemTemplate>
        </asp:ListView>
    </ul>
</div>
</asp:Content>
