<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MyInfo.ascx.cs" Inherits="SMSWeb.MyInfo" %>
<style type="text/css">
    .myimg{
        width:50px;
        height:50px;
    }
</style>
<span style="line-height:50px;margin-left:10px;">
    <asp:Image ID="Img_MyImg" CssClass="myimg" runat="server" ImageUrl="~/images/student.jpg" style="float:left;"/>
    <asp:Literal ID="Literal1" runat="server"></asp:Literal>
    <i>></i></span>
<div class="account_area">
    
    <a href="/Login.aspx">注销</a>
</div>
