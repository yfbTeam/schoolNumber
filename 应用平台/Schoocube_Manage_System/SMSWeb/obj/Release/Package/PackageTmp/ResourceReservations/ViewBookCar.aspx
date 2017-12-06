﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewBookCar.aspx.cs" Inherits="SMSWeb.ResourceReservations.ViewBookCar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>预约详情查看</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <link href="../css/plan.css" rel="stylesheet"/>
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script type="text/javascript" src="../js/menu_top.js"></script>
</head>
<body>
    <form id="officeResource">
        <div class="MenuDiv">
            <table class="tbEdit">
                <tbody>
                	<tr>
	                    <td class="mi">
	                        <span class="m">名称：</span>
	                    </td>
	                    <td class="ku">
	                        <span id="Name"></span>
	                    </td>
                	</tr>
                	<tr>
	                    <td class="mi">
	                       	 申请人：
	                    </td>
	                    <td class="ku">
	                       <span id="Applicant"></span>
	                    </td>
                	</tr>
	                <tr>
	                    <td class="mi">
	                        	场所：
	                    </td>
	                    <td class="ku">
	                       <span id="Address"></span>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="mi">预约时间：</td>
	                    <td class="ku">
	                        <span id="AppoIntmentTime"></span>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="mi">所属学校：</td>
	                    <td class="ku">
	                        <span id="School"></span>
	                    </td>
	                </tr>
	                <tr>
                    <td class="mi">审批人：</td>
                    <td class="ku">
                        <span id="ApprovalPeople"></span>
                    </td>
                </tr>
                <tr>
                    <td class="mi">审批意见：</td>
                    <td class="ku">
                        <span id="ApprovalOpinion"></span>
                    </td>
                </tr>
            	</tbody>
        	</table>
        </div>
    </form>
    <script src="../js/common.js"></script>
     <script type="text/javascript">

         var UrlDate = new GetUrlDate();
         $(function () {
             getData();

         })
         function getData() {
             var ID = UrlDate.ID;

             $.ajax({
                 url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                 type: "post",
                 async: false,
                 dataType: "json",
                 data: {
                     "PageName": "ResourceReservations/ResourceReservationHandler.ashx", "Func": "GetPageList", "ID": ID, "ispage": "false"
                 },
                 success: OnSuccess,
                 error: OnError
             });
         }
         //获取数据成功显示列表
         function OnSuccess(json) {
             if (json.result.errNum.toString() == "0") {
                 $(json.result.retData).each(function (i, n) {
                     $("#Name").text(n.Name);
                     $("#Applicant").text(n.Applicant);
                     $("#Address").text(n.Address);
                     $("#AppoIntmentTime").text(n.AppoIntmentTime);
                     $("#School").text(n.School);
                     $("#ApprovalPeople").text(n.ApprovalPeople);
                     $("#ApprovalOpinion").text(n.ApprovalOpinion);
                 })
                 
             }
         }
    </script>
	</body>
</html>
