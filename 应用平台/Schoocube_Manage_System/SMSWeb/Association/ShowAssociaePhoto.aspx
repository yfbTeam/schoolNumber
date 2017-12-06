<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowAssociaePhoto.aspx.cs" Inherits="SMSWeb.Association.ShowAssociaePhoto" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
     <link rel="stylesheet" href="../Stu_css/allst.css"/>
<link rel="stylesheet" href="../Stu_css/ico/iconfont.css"/>
<script src="../Stu_js/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
    function delPhoto(photo) {
        $("input[id$='hfPhoto']").val(photo);
        $("input[id$='btnDelPhoto']").click();
    }
</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
   
<div class="st_xc" style="width: 100%; overflow-y: auto;">
    <ul style="margin-left:10px;">
        <asp:ListView ID="PhotosList" runat="server">
            <EmptyDataTemplate>
                <table class="W_form" id="emptyAlbum">
                    <tr>
                        <td>相册暂无照片</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <ItemTemplate>
                <li style="margin: 10px 10px;">
                    <img src='<%# Eval("PhotoUrl") %>' title='<%# Eval("Title") %>'>
                    <h3 style="left: 5px;"><%# Eval("Title") %></h3>
                    <h3 style="display:<%=Limit %>;text-align: right;" onclick="delPhoto('<%# Eval("Photo_ID") %>')">删除</h3>
                </li>
            </ItemTemplate>
        </asp:ListView>
    </ul>
    <div style="display: none">
        <asp:HiddenField runat="server" ID="hfPhoto" />
        <asp:Button runat="server" ID="btnDelPhoto" OnClick="btnDelPhoto_Click" />
    </div>
</div>

    </div>
    </form>
</body>
</html>
