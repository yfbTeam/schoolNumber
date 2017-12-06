<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdvertisingItemList.aspx.cs" Inherits="SMSWeb.Portal.Advertising.AdvertisingItemList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../PortalCss/layout.css" rel="stylesheet" />
    <link href="../../PortalCss/reset.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../../PortalJs/layout.js"></script>
    <script src="../../Scripts/Common.js"></script>
    <script src="../../Scripts/jquery.tmpl.js"></script>
    <script src="../../Scripts/PageBar.js"></script>
    <script type="text/javascript" src="../../js/menu_top.js"></script>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }
    </style>
     <script id="tr_School" type="text/x-jquery-tmpl">
         <li>
             <a href="#">
                 <div class="img_school">
                     <img src="${ImageUrl}" alt="">
                 </div>
                 <p>${Title}</p>
             </a>
         </li>
     </script>
     <script id="item_Resource" type="text/x-jquery-tmpl">
         <li>
             <a href="#">
                 <div class="img_school">
                      {{if PhotoURL==""}}
                <img src="../PortalImages/teacher_img_01.png" alt="" />
                     {{else}}
                <img src="${PhotoURL}" alt="" />
                     {{/if}}
                 </div>
                 <p>${NameLengthUpdate(Name,10)}</p>
             </a>
         </li>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField  ID="HType"  runat="server"/>
        <iframe name="htmlHeader" src="../header.html" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="480px"></iframe>
        <div class="main width clearfix mt20 mb20">
            <!--leftnav-->
            <iframe name="TreeView" src="../TreeView.html" scrolling="no" allowtransparency="true" frameborder="no" width="200px" height="570px;"></iframe>
            <div class="content fr">
                <h1 class="crumbs">您当前的位置：<a href="/Portal/index.aspx">网站首页</a> <span>&gt;</span> <a href="" id="aTypeMenu"></a>
                </h1>
                <div class="content_detail" style="padding: 10px 0px;">
                    <h1 class="title">
                    </h1>
                    <ul class="img_lists clearfix" id="tb_School">
                        
                    </ul>
                    <!--分页-->
                    <div class="page">
                        <span id="pageBar"></span>
                    </div>
                </div>
            </div>
        </div>
        <!--footer-->
        <iframe name="htmlFoot" src="../bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="175px"  style="margin-top:20px;"></iframe>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            getData(1, 10);
            $("#aTypeMenu").html(showSchollAndTeacher($("#HType").val()) + "列表");
            $(".title").html(showSchollAndTeacher($("#HType").val()));
        });
        function getData(startIndex, pageSize) {
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            if ($("#HType").val()=="0") {
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        PageName: "PortalManage/SchoolStyle.ashx",
                        Func: "GetPageList",
                        PageIndex: startIndex,
                        pageSize: pageSize
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            $("#tb_School").html('');
                            $("#tr_School").tmpl(json.result.retData.PagedData).appendTo("#tb_School");
                            makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                        }
                        else {
                            $("#tb_School").html("<tr><td colspan='5'>暂无校园风貌！</td></tr>");
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {

                    }
                });
            } else if ($("#HType").val() == "1") {
                $.ajax({
                    url: "/SystemSettings/CommonInfo.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        PageIndex: startIndex,
                        PageSize: pageSize,
                        Func: "GetTeacherPower"
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            $("#tb_School").html('');
                            var items = json.result.retData.PagedData;
                            if (items != null && items.length > 0) {
                                $("#item_Resource").tmpl(items).appendTo("#tb_School");
                                makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                            }
                        }
                        else {
                            $("#tb_School").html("暂无教师信息！");
                        }
                    },
                    error: OnError
                });
            }
            
        }

     </script>
</body>
</html>
