//#menubox > #box.find(".items") > .class.find("class")>class>tag 	

//email下拉
$(document).ready(function(e) {
	//下拉列表
   $(".slidedown").mouseover(function() {
       $(this).find(".slidecon").show();
	   $(this).find("dt").addClass("hover");
    });
	$(".slidedown").mouseout(function() {
       $(this).find(".slidecon").hide();
	   $(this).find("dt").removeClass("hover");
    });
});
/*百叶窗*/
$(function(){
	$("#menubox").find(".menuclick").click(function(){
		$(this).parent().toggleClass("selected").siblings().removeClass("selected");
		$(this).next().slideToggle().end().parent().siblings().find(".submenu")
		.addClass("animated flipInX")	
		.slideUp("fast").end().find("i").text("+");
		var t = $(this).find("i").text();
		$(this).find("i").text((t=="+"?"-":"+"));
	});	
});
/*tab切换*/
$(function(){
    $(".yy_tab .yy_tabheader").find("a").click(function () {
        var index = $(this).parent().index();
        $(this).parent().addClass("selected").siblings().removeClass("selected");
        $(this).parents(".yy_tab").find(".tc").eq(index).show().siblings().hide();
    });
});

//tab切换两层嵌套
$(document).ready(function () {
    $(".st_nav li").click(function () {
        $(".st_nav li").removeClass("active");
        $(this).addClass("active");
        var index = $(".st_nav li").index($(this));
        $(".tb").eq(index).show().siblings().hide();
    });
    $(".tb").eq(0).show().siblings().hide();
    $(".tb").each(function () {
        var _this = $(this);
        _this.find(".tab_tit li").click(function () {
            $(this).addClass("selected").siblings().removeClass("selected");
            var index = _this.find(".tab_tit li").index($(this));
            _this.find(".tc").eq(index).show().siblings().hide();
        });
        _this.find(".tc").eq(0).show().siblings().hide();
    });
});
$(function () {
    $(".st_zl_js .more").click(function () {
        $(this).html($(this).html() == "展开" ? "收起" : "展开");
    });
})
//收起  展开
$(function () {
    $(".listIndex .more").click(function () {
        $(this).html($(this).html() == "展开" ? "收起" : "展开");
    });

})
//$(function () {
//    TabChange(".rflf .st_nav", 'active', '.rflf', '.td');
//})
function TabChange(navcss, selectedcss, parcls, childcls) { //选项卡切换方法，navcss选项卡父级，selectedcss选中样式，parcls内容的父级样式，childcls内容样式
    $(navcss).find("a").click(function () {
        var index = $(this).parent().index();
        $(this).parent().addClass(selectedcss).siblings().removeClass(selectedcss);//为单击的选项卡添加选中样式，同时与当前选项卡同级的其他选项卡移除选中样式
        $(this).parents(parcls).find(childcls).eq(index).show().siblings().hide();//找到与选中选项卡相同索引的内容，使其展示，同时设置其他同级内容隐藏。
    });
}
/*左侧点击隐藏*/
$(function () {
    $('.aside').toggle(function () {
        //alert('aa');
        $('#sliderbox').stop(this, this).animate({ left: "-200px" });
        $('.box .right').stop(this, this).animate({ marginLeft: 0 })
    }, function () {
        $('#sliderbox').stop(this, this).animate({ left: 0 });
        $('.box .right').stop(this, this).animate({ marginLeft: "200px" })

    })

})

//岗位下拉
$(document).ready(function (e) {
    //下拉列表
    $(".Post_post").mouseover(function () {
        $(this).find(".more_info").show();
        $(this).find(".Drop_down").addClass("hover_ul");
    });
    $(".Post_post").mouseout(function () {
        $(this).find(".more_info").hide();
        $(this).find(".Drop_down").removeClass("hover_ul");
    });
});
//订餐tab切换
$(function () {
    $(".dc_tab .dc_tabheader").find("a").click(function () {
        var index = $(this).parent().index();
        $(this).parent().addClass("selected").siblings().removeClass("selected");
        $(this).parents(".dc_tab").find(".dc").eq(index).show().siblings().hide();
    });
});


//食堂公告滚动		
$(document).ready(function (e) {
    var index = 0,
       timer;
    $(".Announcement ul.lub li").mouseover(function () {
        clearInterval(timer);
        index = $(".Announcement ul.lub li").index($(this));
        img(index);
    })
    $(".tuu").hover(function () {
        clearInterval(timer)
    }, function () {
        timer = setInterval(function () {
            index++;
            if (index == $(".Announcement ul.lub li").length) {
                index = 0;
            }
            img(index)
        }, 2000)
    }).trigger("mouseleave");
    function img(index) {
        $(".Announcement ul.lub li").eq(index).addClass("hover").siblings().removeClass("hover")
        $(".tuu").stop().animate({ 'left': -360 * index }, 1000);
    };
});

//确认订单tab切换
$(function () {
    $(".Order_tab .Order_tabheader").find("a").click(function () {
        var index = $(this).parent().index();
        $(this).parent().addClass("selected");
        $(this).parents(".Order_tab").find(".tc").eq(index).show().siblings().hide();
    });
});


//分配岗位tab
$(function () {
    $(".tab_switch .sw_tabheader .nav_list").find("a").click(function () {
        var index = $(this).parent().index();
        $(this).parent().addClass("selected").siblings().removeClass("selected");
        $(this).parents(".tab_switch").find(".sw").eq(index).show().siblings().hide();
    });
});
//公司岗位查看更多
$(document).ready(function (e) {
    $("ul.nav_list li.last").mouseover(function () {
        $(this).find(".second_nav").show();
        $(this).find("a").addClass("hover");
    });
    $("ul.nav_list li.last").mouseout(function () {
        $(this).find(".second_nav").hide();
        $(this).find("a").removeClass("hover");
    });
});



/*我的订单点击展开百叶窗*/
$(function () {
    $("#slide").find(".order_click").click(function () {
        $(this).parent().toggleClass("selected").siblings().removeClass("selected");
        $(this).next().slideToggle("fast").end().parent().siblings().find(".order_con")
		.addClass("animated bounceIn")
		.slideUp("fast").end().find("i").text("+");
        var t = $(this).find("i").text();
        $(this).find("i").text((t == "+" ? "-" : "+"));
    });
});



//批量操作
$(document).ready(function (e) {
    $(".right_add .Batch_operation").mouseover(function () {
        $(this).find(".B_con").show();
    });
    $(".right_add .Batch_operation").mouseout(function () {
        $(this).find(".B_con").hide();
    });
});





//分享 下载 。。。
$(document).ready(function (e) {
    $(".J-item").hover(function () {
        $(this).find(".Operation").show().end().siblings().find('.M_con').hide();
    }, function () {
        $(this).find(".Operation").hide();
    })
});

//分享 下载 More 下拉
$(function () {
    $('.more_m').click(function () {
        $(this).siblings('.M_con').show();
    })
})






//左侧导航点击下拉
$(function () {
    $(".i-menu").each(function () {
        var _this = $(this);
        $(this).hover(function () {
            _this.find(".btn-area").show();
        }, function () {
            _this.find(".btn-area").hide();
        });
        var i_con = $(this).next(".i-con")[0];
        i_con.style.display = "none";
        $(this).click(function () {
            if (i_con.style.display == "none") {
                i_con.style.display = "block";
            } else {
                i_con.style.display = "none";
            };
        });

    });
    $(".ici-menu").each(function () {
        var _this = $(this);
        $(this).hover(function () {
            _this.find(".btn-area").show();
        }, function () {
            _this.find(".btn-area").hide();
        });
        var i_con = $(this).next(".ici-con")[0];
        i_con.style.display = "none";
        $(this).click(function () {
            if (i_con.style.display == "none") {
                i_con.style.display = "block";
            } else {
                i_con.style.display = "none";
            };
        });
    });
    $(".icic-item").each(function () {
        var _this = $(this);
        $(this).hover(function () {
            _this.find(".btn-area").show();
        }, function () {
            _this.find(".btn-area").hide();
        });
    });


})


//筛选条件经过展开

$(document).ready(function (e) {
    $("#selectList").find(".more").toggle(function () {
        $(this).parent().parent().removeClass("dlHeight");
    }, function () {
        $(this).parent().parent().addClass("dlHeight");
    });
});
//教案 习题 课件 审核 tab切换
$(function () {
    $(".Resources_tab .Resources_tabheader").find("a").click(function () {
        var index = $(this).parent().index();
        $(this).parent().addClass("selected").siblings().removeClass("selected");
        $(this).parents(".Resources_tab").find(".tc").eq(index).show().siblings().hide();
    });
});

/*组卷百叶窗*/
$(function () {
    $("#slide").find(".Topic_click").click(function () {
        $(this).parent().toggleClass("selected").siblings().removeClass("selected");
        $(this).next().slideToggle("fast").end().parent().siblings().find(".Topic_con")
		.addClass("animated bounceIn")
		.slideUp("fast").end().find("i").text("+");
        var t = $(this).find("i").text();
        $(this).find("i").text((t == "+" ? "-" : "+"));
    });
});
//右边扫二维码加关注 置顶

$(function () {

    var tophtml = "<div id=\"izl_rmenu\" class=\"izl-rmenu\"><div class=\"btn btn-wx\"><img class=\"pic\" src=\"/wpresources/dyyx/images/weixin.jpg\" /></div><div class=\"btn btn-wx1\"><img class=\"pic1\" src=\"#\" /></div><div class=\"btn btn-back\"></div><div class=\"btn btn-top\"></div></div>";
    $("#top").html(tophtml);
    $("#izl_rmenu").each(function () {
        $(this).find(".btn-wx").mouseenter(function () {
            $(this).find(".pic").fadeIn("fast");
        });
        $(this).find(".btn-wx1").mouseleave(function () {
            $(this).find(".pic1").fadeOut("fast");
        });
        $(this).find(".btn-back").mouseenter(function () {
            $(this).find(".back").fadeIn("fast");
        });
        $(this).find(".btn-back").mouseleave(function () {
            $(this).find(".back").fadeOut("fast");
        });
        $(this).find(".btn-top").click(function () {
            $("html, body").animate({
                "scroll-top": 0
            }, "fast");
        });
        $(this).find(".btn-back").click(function () {
            history.go(-1);
        });
    });
    var lastRmenuStatus = false;
    $(window).scroll(function () {//bug
        var _top = $(window).scrollTop();
        if (_top > 200) {
            $("#izl_rmenu").data("expanded", true);
        } else {
            $("#izl_rmenu").data("expanded", false);
        }
        if ($("#izl_rmenu").data("expanded") != lastRmenuStatus) {
            lastRmenuStatus = $("#izl_rmenu").data("expanded");
            if (lastRmenuStatus) {
                $("#izl_rmenu .btn-top").slideDown();
            } else {
                $("#izl_rmenu .btn-top").slideUp();
            }
        }
    });
});
//选项卡（点击切换 学生住宿安排页面）
$(document).ready(function (e) {
    $(".zsxxk dt ul li").click(function () {
        $(this).addClass("active").siblings().removeClass("active");
        $k = $(".zsxxk dt ul li").index(this);
        $(".zsxxk_nr").eq($k).css({ display: "block" }).siblings().css({ display: "none" });
        $(".zsxxk dt").css({ display: "block" });
    })
});
/////
///
$(document).ready(function (e) {
    $(".zsxxk dt span").click(function () {
        $(this).addClass("active").siblings().removeClass("active");
        $("span:last-child:not(:checked)").removeClass("active");
        $k = $(".zsxxk dt span").index(this);
        $(".zsxxk_nr").eq($k).css({ display: "block" }).siblings().css({ display: "none" });
        $(".zsxxk dt").css({ display: "block" });
    })
});
