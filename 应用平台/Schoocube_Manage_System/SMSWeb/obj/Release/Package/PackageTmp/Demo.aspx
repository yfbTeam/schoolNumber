<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Demo.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="Scripts/jquery-1.8.2.min.js"></script>
    <script type="text/javascript">

        function get() {
            $.ajax({
                type: "Post",
                url: "../Common.ashx",
                data: { "PageName": "UserHandler.ashx", "Func": "AddCF" },
                dataType: "text",
                success: function (returnVal) {
                    alert(returnVal);
                },
                error: function (errMsg) {
                    alert('获取数据失败！');
                }
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <input id="Button1" type="button" value="接口测试" onclick="get()" />
            <asp:Button ID="Add" OnClick="Add_Click" runat="server" Text="功能测试添加"></asp:Button>
            <br />
            <asp:Button ID="Update" OnClick="Update_Click" runat="server" Text="功能测试更新"></asp:Button>
            <br />
            <asp:Button ID="Delete" OnClick="Delete_Click" runat="server" Text="功能测试删除"></asp:Button>

            <asp:Button ID="Get" OnClick="Delete_Click" runat="server" Text="功能测试获取单条数据"></asp:Button>
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Button" style="height: 21px" />
            <asp:Button ID="Button3" runat="server" Text="Button" OnClick="Button3_Click"/>
        </div>
    </form>
</body>
</html>
