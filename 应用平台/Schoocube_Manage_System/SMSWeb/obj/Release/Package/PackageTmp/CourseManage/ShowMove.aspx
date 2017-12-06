<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowMove.aspx.cs" Inherits="SMSWeb.CourseManage.ShowMove" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <%--<script src="http://html5media.googlecode.com/svn/trunk/src/html5media.min.js"></script>--%>
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script type="text/javascript">
        var UrlDate = new GetUrlDate();
        $(function () {
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                dataType: "json",
                data: { "PageName": "CourseManage/CouseResource.ashx", "Func": "getWeikeByID", ID: UrlDate.ID },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            $("#weike").html("<video width=\"570\" height=\"330\" src=\"" + this.FileUrl + "\" poster=\"" + this.vidoeImag + "\" autoplay=\"autoplay\" preload=\"none\" controls=\"controls\"></video>");
                        })
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }

                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            })
        })
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="weike">
            <%--<video src="../PubFolder/微课/1、倒计时的UI设计.mp4" controls="controls" width="520" height="400"/>--%>
        </div>
    </form>
</body>
</html>
