$(function () {
	//menu折叠展开 选中切换
    $('.items').find('.units').each(function () {
		var oLi = $('.items').find('li')
        oLi.click(function () {
			oLi.removeClass('active');
			$(this).addClass('active');
		});
        $(this).find('.item_title').click(function () {
			var $next = $(this).next();
			var $icon = $(this).find('.icon');
			$icon.toggleClass('active');
			$next.stop().slideToggle();
			$('.items').find('.contentbox').not($next).slideUp();
			$('.items').find('.icon').not($icon).removeClass('active');
		})
	})
});
//点击切换显示
function clickTab(tabObj,transformObj,tarObj){
	var $contentbox = tabObj.find('.contentbox');
	if ($contentbox.is(':hidden')) {
		$contentbox.show();
        tabObj.find(transformObj).css('transform', 'rotate(180deg)');
    } else {
		$contentbox.hide();
        tabObj.find(transformObj).css('transform', 'rotate(0deg)');
	}
}
//下拉框
function choose(obj) {
    obj.click(function () {
		var $hidden = $(this).find('div');
        if ($hidden.is(':hidden')) {
			$hidden.show();
        } else {
			$hidden.hide();
		}
        $hidden.children('span').click(function () {
			var $select = $(this).parent().parent().children('span');
			$select.text($(this).text());
            $select.attr('value', $(this).attr('value'));
		});	
	})		
}

//dialog弹出关闭
function dialog(clickObj, dialogObj) {
    clickObj.click(function () {
		$('body').append('<div id="mask"></div>');
		dialogObj.fadeIn();
	})
}
function close(clickObj, closeObj) {
    clickObj.click(function () {
		closeObj.fadeOut();
		$('#mask').remove();
	})
}
//滚动 ，左边侧边栏定位
function onscroll(obj) {
	var offsetTop = obj.offset().top;
    var tarHeight = parseInt(offsetTop) - 70;
    $(window).scroll(function () {
		var scrollTop = parseInt($(window).scrollTop());
        if (scrollTop > tarHeight) {
            obj.css({ 'position': 'fixed', 'top': '70px', 'zIndex': '999' });
        } else {
            obj.css('position', 'static');
		}
	})
}
//返回顶部
function backTop(backObj, speed) {
    backObj.click(function () {
        $('html,body').animate({ scrollTop: 0 }, speed);
	})
}
function checkAll(oInput) {
    var isCheckAll = function () {
        for (var i = 1, n = 0; i < oInput.length; i++) {
            oInput[i].checked && n++
        }
        oInput[0].checked = n == oInput.length - 1;
    };
    //全选
    oInput[0].onchange = function () {
        for (var i = 1; i < oInput.length; i++) {
            oInput[i].checked = this.checked
        }
        isCheckAll()
    };
    //根据复选个数更新全选框状态
    for (var i = 1; i < oInput.length; i++) {
        oInput[i].onchange = function () {
            isCheckAll()
        }
    }
}
function stopEvent() { // 阻止冒泡事件
    // 取消事件冒泡
    var e = arguments.callee.caller.arguments[0] || event; // 若省略此句，下面的e改为event，IE运行可以，但是其他浏览器就不兼容
    if (e && e.stopPropagation) {
        // this code is for Mozilla and Opera
        e.stopPropagation();
    } else if (window.event) {
        // this code is for IE
        window.event.cancelBubble = true;
    }
}
function logOut() {
    window.location.href = "/HZ_Index.aspx?action=loginOut";
}
//退出
$('.settings').hover(function () {
    $(this).find('.setting_none').show();
}, function () {
    $(this).find('.setting_none').hide();
})
//图片划过放大
function hoverEnlarge(obj) {
    obj.hover(function () {
        $(this).addClass('hover').css({ 'transition': ' all 0.6s 0.3s' });
    }, function () {
        $(this).removeClass('hover');
    })
}
//时间转换
function DateTimeConvert(date, format, iseval) {
    iseval = iseval == false ? false : true;
    if (iseval) {
        date = date.replace(/(^\s*)|(\s*$)/g, "");
        if (date == "") {
            return "";
        }
        if (date.indexOf("Date") != -1) {
            date = eval(date.replace(/\/Date\((\d+)\)\//gi, "new Date($1)"));
        } else {
            date = new Date(Date.parse(date));
        }
    }
    var year = date.getFullYear();
    var month = (date.getMonth() + 1).toString();
    var twoMonth = month.length == 1 ? "0" + month : month; //月份为1位数时，前面加0
    var day = (date.getDate()).toString();
    var twoDay = day.length == 1 ? "0" + day : day; //天数为1位数时，前面加0
    var hour = (date.getHours()).toString();
    var twoHour = hour.length == 1 ? "0" + hour : hour; //小时数为1位数时，前面加0
    var minute = (date.getMinutes()).toString();
    var twoMinute = minute.length == 1 ? "0" + minute : minute; //分钟数为1位数时，前面加0
    var second = (date.getSeconds()).toString();
    var twoSecond = second.length == 1 ? "0" + second : second; //秒数为1位数时，前面加0
    var dateTime;
    if (format == "yyyy-MM-dd HH:mm:ss") {
        dateTime = year + "-" + twoMonth + "-" + twoDay + " " + twoHour + ":" + twoMinute + ":" + twoSecond;
    } else if (format == "yyyy-MM-dd HH:mm") {
        dateTime = year + "-" + twoMonth + "-" + twoDay + " " + twoHour + ":" + twoMinute;
    } else if (format == "年月日") {
        dateTime = year + "年" + month + "月" + day + "日";
    } else if (format == "yyyy-MM") {
        dateTime = year + "-" + twoMonth
    } else if (format == "dd") {
        dateTime = twoDay;
    }
    else {
        dateTime = year + "-" + twoMonth + "-" + twoDay
    }
    return dateTime;
}

$(function () {
    initMsgCount();
})

function initMsgCount() {
    $('.account_area li:eq(0) a').attr("href", "/SysMessage/UsersMessage.aspx");
    $.ajax({
        url: "/Common.ashx",
        type: "post",
        async: false,
        dataType: "json",
        data: {
            PageName: "PortalManage/MessageHandler.ashx",
            Func: "GetPageList",
            Receiver: $("#HUserIdCard").val(),
            Status: 0,
            Ispage: false
        },
        success: function (json) {
            if (json.result.errMsg == "success") {
                var items = json.result.retData;
                if (items != null && items.length > 0) {
                    $(".badge").html(items.length);

                } else {
                    $(".badge").html("0");
                }
            }
            else {
                $(".badge").html("0");
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {

        }
    });
}