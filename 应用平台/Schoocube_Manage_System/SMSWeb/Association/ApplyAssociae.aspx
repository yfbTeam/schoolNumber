<%@ Page Title="" Language="C#" MasterPageFile="~/EmptySite.Master" AutoEventWireup="true" CodeBehind="ApplyAssociae.aspx.cs" Inherits="SMSWeb.Association.ApplyAssociae" EnableEventValidation="true"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="../Stu_js/jquery-1.8.0.js"></script>
<link href="../Stu_css/common.css" rel="stylesheet" />
<link href="../Stu_css/layout.css" rel="stylesheet" />
<link href="../Stu_css/StuAssociate.css" rel="stylesheet" type="text/css" />
<script src="../Stu_js/uploadFile1.js"></script>
<style type="text/css">
    td {
        vertical-align: middle;
    }
</style>
<div class="windowDiv">
    <div class="assoimgdiv">
        <div style="float:left;">
             <asp:Image runat="server" ID="A_Pic" CssClass="imgradius" ImageUrl="../Stu_images/nopic.png" />
        </div>       
        <div class="assoinfodiv">
            <h3>
                <asp:Literal ID="Lit_Title" runat="server"></asp:Literal></h3>
            <p>
                <asp:Literal ID="Lit_Slogans" runat="server"></asp:Literal></p>
        </div>
    </div>
    <table class="winTable">
        <tr>
            <td class="wordsinfo" style="width: 70px;"><asp:Literal ID="Lit_ConWord" runat="server" Text="个人介绍："></asp:Literal></td>
            <td class="ku">
                <asp:TextBox ID="TB_Content" TextMode="MultiLine" class="unvaliwidth" Height="160px" runat="server"></asp:TextBox>
            </td>
            <td style="width: 42px;">
                <span class="wstar">*
               <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TB_Content"
                   ErrorMessage="必填" ValidationGroup="ProjectSubmit" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></span>
            </td>
        </tr>
    </table>
    <div class="t_btn">
        <asp:Button ID="Btn_InfoSave" OnClick="Btn_InfoSave_Click" CssClass="btn btn_sure" Width="120px" runat="server" ValidationGroup="ProjectSubmit" Text="申请加入" />
        <input type="button" class="btn btn_cancel" value="取消" onclick="parent.closePages();" />
    </div>
    <div style="display: none">
        <asp:HiddenField runat="server" ID="A_Id" />
    </div>
</div>

</asp:Content>
