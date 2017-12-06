<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="SMSWeb.CourseManage.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript">
        //$(function () {
        //    AddToFavorites(4, '');
        //})
        //function AddToFavorites(courseid, coursename) {
        //    //alert(window.location);
        //    //alert(window.location.href)
        //    $.ajax({
        //        url: "/Common.ashx",
        //        type: "post",
        //        async: false,
        //        dataType: "json",
        //        data: {
        //            PageName: "PortalManage/AdminManager.ashx",
        //            func: "AddFavorites",
        //            IDCard: '',
        //            href: window.location.href,
        //            Name: coursename + "——课程详情页",
        //            Type: 1,
        //            RelationID: courseid
        //        },
        //        success: function (json) {
        //            if (json.result.errNum.toString() == "0") {
        //                alert("收藏成功！");
        //            } else {
        //                alert(json.result.errMsg);
        //            }
        //        },
        //        error: function (errMsg) {
        //            alert('收藏失败！');
        //        }
        //    });
        //}

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="TextBox1" runat="server" Text="/DriveFolder"></asp:TextBox>
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
        </div>
        <div>
            <asp:FileUpload ID="FileUpload1" runat="server" /><asp:Button ID="Button2" runat="server" Text="Button" OnClick="Button2_Click" />
        </div>
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    </form>
</body>
</html>
