<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookingCarView.aspx.cs" Inherits="SMSWeb.ResourceReservations.BookingCarView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>预约审批</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <link href="../css/plan.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript">
    </script>
</head>
<body>
    <form id="carResource">
        <div class="MenuDiv">
            <table class="tbEdit">
                <tbody>
                    <tr>
                        <td class="mi">
                            <span class="m">原因事由：</span>
                        </td>
                        <td class="ku">
                            <span class="Reason"></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">预定时间：
                        </td>
                        <td class="ku">
                            <span class="AppoIntmentTime"></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">时间段：
                        </td>
                        <td class="ku">
                            <span class="TimeInterval"></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">限定人数：</td>
                        <td class="ku">
                            <span class="LimitPeople"></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">预定车辆型号：</td>
                        <td class="ku">
                            <span class="CarModel"></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="mi">场所：
                        </td>
                        <td class="ku">
                            <span class="Address"></span>
                        </td>
                    </tr>

                    <tr>
                        <td class="mi">申请人：
                        </td>
                        <td class="ku">
                            <span class="Applicant"></span>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </form>
    <script src="../js/common.js"></script>
    <script type="text/javascript">
        var GetUrlDate = new GetUrlDate();
        $(function () {
            getData();
        })
        //获取数据
        function getData() {
            var ID = "";
            if (GetUrlDate.ID != undefined) {
                ID = GetUrlDate.ID;
            }

            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "ResourceReservations/ResourceReservationHandler.ashx",
                    Func: "GetPageList", ID: ID
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        $("#Reason").val(this.Reason);
                        $("#AppoIntmentTime").val(this.AppoIntmentTime);
                        $("#TimeInterval").val(this.TimeInterval);
                        $("#LimitPeople").val(this.LimitPeople);
                        $("#CarModel").val(this.CarModel);
                        $("#Address").val(this.Address);
                        $("#Applicant").val(this.Applicant);
                    } else {
                        layer.msg(result.errMsg);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }

    </script>
</body>
</html>
