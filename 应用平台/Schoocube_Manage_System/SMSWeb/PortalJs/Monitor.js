
function MonitorRecord(RequestType, RequestSourceID, RequestUserType, Creator) {
    $.ajax({
        url: "/Common.ashx",
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "PortalManage/MonitorRecordHandler.ashx",
            Func: "AddRecord",
            RequestType: RequestType,
            RequestSourceID: RequestSourceID,
            RequestUrl: window.location.search,
            RequestUserType: RequestUserType,
            Creator: Creator
        },
        success: function (json) {
            if (json.result.errMsg) {

            }
        },
        error: function (errMsg) {

        }
    });
}

