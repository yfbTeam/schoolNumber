// JavaScript Document



//nav下拉
$(document).ready(function(e) {
	//下拉列表
   //$(".xiala").mouseover(function() {
   //    $(this).find(".lie").show();
   //    $(this).find("dt").addClass("hover");
   // });
   // $(".xiala").mouseout(function() {
   //    $(this).find(".lie").hide();
   //    $(this).find("dt").removeClass("hover");
   // });
});

$(document).ready(function(e) {
	//banner_top滚动
	var index=0,
		   timer;
	$(".banner_top ul.lub li").mouseover(function(){
		clearInterval(timer);
		index=$(".banner_top ul.lub li").index($(this));
		img(index);
		})
	$(".tuu").hover(function(){
		clearInterval(timer)
		},function(){
		timer=setInterval(function(){
		index++;
		if(index== $(".banner_top ul.lub li").length){
			index=0;
			}
		img(index)
		},1000)	
		}).trigger("mouseleave");
	function img(index){
		$(".banner_top ul.lub li").eq(index).addClass("hover").siblings().removeClass("hover")
		$(".tuu").stop().animate({'left':-1366*index},500);
		};
});


$(document).ready(function(e) {
	//banner_bottom滚动
	var index=0,
		timer,
		abc;
	$(".banner_bottom ul.shuzi li").mouseover(function(){
		clearInterval(timer);
		abc=$(".banner_bottom ul.shuzi li").index($(this));
		img(abc);
		})
	$(".tupian").hover(function(){
		clearInterval(timer)
		},function(){
		timer=setInterval(function(){
		index++;
		if(index== $(".banner_bottom ul.shuzi li").length){
			index=0;
			}
		img(index)
		},2000)	
		}).trigger("mouseleave");
	function img(index){
		$(".banner_bottom ul.shuzi li").eq(index).addClass("hover").siblings().removeClass("hover")
		$(".tupian").stop().animate({'left':-627*index},500);
		};
});



// 图片经过上拉
$(document).ready(function(e) {
	$(".tu_moral li").mouseover(function(){
		$(this).find(".layer").stop().animate({"top":0},"fast")
	})
	$(".tu_moral li").mouseout(function(){
		$(this).find(".layer").stop().animate({"top":148},"fast")
	})


});
