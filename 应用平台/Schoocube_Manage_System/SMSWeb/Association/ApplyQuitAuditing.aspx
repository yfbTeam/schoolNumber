<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplyQuitAuditing.aspx.cs" Inherits="SMSWeb.Association.ApplyQuitAuditing" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="../Script/jquery-1.8.0.js"></script>
<link href="../Stu_css/common.css" rel="stylesheet" />
<link href="../Stu_css/StuAssociate.css" rel="stylesheet" type="text/css" />
<style type="text/css">    
    td{
        vertical-align:middle;
    }
</style>
</head>
<body>
    <form id="form1" runat="server">
    <div>

<div class="windowDiv">
    <table class="winTable">
        <tr>
            <td class="wordsinfo">姓名：</td>
            <td class="ku"><asp:Label runat="server" ID="lbName"></asp:Label> </td>
        </tr>
        <tr>
            <td class="wordsinfo">申请日期：</td>
            <td class="ku"><asp:Label runat="server" ID="lbDate"></asp:Label></td>
        </tr>        
        <tr>
            <td class="wordsinfo">说明：</td>
            <td class="ku" style="min-height:10px;" ><asp:Label runat="server" ID="lbContent" Width="380px" ></asp:Label></td>
        </tr>
        <tr>
            <td class="wordsinfo">审批结果：</td>           
            <td>
                <asp:RadioButton ID="RB_Pass" Checked="true" GroupName="Exam" runat="server" Text="审核通过" />
                <asp:RadioButton ID="RB_Refuse" GroupName="Exam" runat="server" Text="审核拒绝" />
                <asp:Label runat="server" ID="lbStatus" Visible="false"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="wordsinfo">审批人：</td>
            <td class="ku"><asp:Label runat="server" ID="lbExamer"></asp:Label></td>
        </tr>
        <tr>
            <td class="wordsinfo">审核意见：</td>
            <td class="ku">            
               <asp:TextBox ID="txtExamineSuggest" TextMode="MultiLine"  class="unvaliwidth" Width="380px" runat="server"></asp:TextBox>
                <span style="color:red">*<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtExamineSuggest"
                   ErrorMessage="必填" ValidationGroup="ProjectSubmit" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></span>
            </td>
        </tr>
    </table>
    <div class="t_btn">
        <asp:Button ID="Btn_Sure" CssClass="btn btn_sure" runat="server"  Text="确定" ValidationGroup="ProjectSubmit" OnClick="Btn_Sure_Click"/>
        <input type="button" class="btn btn_cancel" value="取消" onclick="parent.closePages();" />
    </div>
</div>

    </form>
</body>
</html>
