<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddAlbum.aspx.cs" Inherits="SMSWeb.Association.AddAlbum" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../Stu_css/layout.css" rel="stylesheet" />
<link rel="stylesheet" href="../Stu_css/allst.css"/>
</head>
<body>
    <form id="form1" runat="server">
    <div>
<div class="listdv">
    <table>
        <tr>
            <th>相册名：</th>
            <td>
                <asp:TextBox ID="TB_Title" runat="server" Width="250px"></asp:TextBox>
                <span style="color: red;">*
                            <asp:RequiredFieldValidator ID="RFV_Title" runat="server" ControlToValidate="TB_Title"
                                ErrorMessage="必填" ValidationGroup="ProjectSubmit" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></span>
            </td>
        </tr>
        <tr>
            <th>描 述：</th>
            <td> <asp:TextBox ID="txt_Remark" runat="server" Width="350px"></asp:TextBox></td>
        </tr>
        <tr>
            <th></th>
            <td>
                <asp:Button ID="Btn_InfoSave" OnClick="Btn_InfoSave_Click" CssClass="save" runat="server" ValidationGroup="ProjectSubmit" Text="创建" />
                <input type="button" class="cancel" value="取消" onclick="parent.closePages();" />
            </td>
        </tr>
    </table>
</div>

    </div>
    </form>
</body>
</html>
