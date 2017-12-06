$(function(){
	//题库管理
	$('.test_lists li').hover(function(){
		$(this).find('.seedeletion').show();
	},function(){
		$(this).find('.seedeletion').hide();
	})
	$('.seedeletion').children('span').hover(function(){
		$(this).find('em').stop().slideDown();
	},function(){
		$(this).find('em').stop().slideUp();
	})
	//更多
	$('.moreoptions').click(function(){
		var $hidden  = $('.stytem_items .stytem_item');
		if($hidden.is(':hidden')){
			$hidden.slideDown();
			$(this).children('i').addClass('icon-angle-up').removeClass('icon-angle-down');
			$(this).children('span').text('收起');
		}else{
			$hidden.not($('.a')).slideUp();
			$(this).children('i').addClass('icon-angle-down').removeClass('icon-angle-up');
			$(this).children('span').text('更多选项');
		}
	});
	//更多收起
	$('.stytem_item').find('.stytem_items_more').click(function(){	
		if($(this).children('span').text() == '更多'){
			$(this).children('span').text('收起');
			$(this).siblings('.stytem_items_list').height('auto');
			var heig = $(this).siblings('.stytem_items_list').height();
			$(this).siblings('.stytem_items_title').height(heig).css('lineHeight',heig+'px');
		}else if($(this).children('span').text() == '收起'){
			$(this).children('span').text('更多');
			$(this).siblings('.stytem_items_list').height('44px');
			$(this).siblings('.stytem_items_title').height('43px').css('lineHeight','45px');
		}
	})
	//
	$('.stytem_items_list a').click(function(){
		$(this).addClass('on').siblings().removeClass('on');
	});
	$('.stytem_select_left a').click(function(){
		$(this).addClass('on').siblings().removeClass('on');
	});
	//
	$('.stytem_select_left a').click(function(){
		$(this).addClass('on').siblings().removeClass('on');
		var n = $(this).index();
		//发布试卷和未发布试卷
		$('.test_norelase>ul').eq(n).show().siblings().hide();
		//手动组卷和智能组卷
		$('.testassem>div').eq(n).show().siblings().hide();
		//已答试卷和未答试卷
		$('.test_norelase>ul').eq(n).show().siblings().hide();
	});
	//下拉框
	choose($('.stytem_select_right .enable'));
	choose($('.select'));
	//题型判断
	$('.exam_type .select').change(function(){
		$(this).parents('.dialog_detail').find('.checkbox').hide();
		$(this).parents('.dialog_detail').find('.radio').hide();
		$(this).parents('.dialog_detail').find('.judge').hide();
		var val = $(this).attr('value');
		if(val == '1'){
			$(this).parents('.dialog_detail').find('.checkbox').show();
		}else if(val == '2'){
			$(this).parents('.dialog_detail').find('.judge').show();
		}else if(val == '3'){
			$(this).parents('.dialog_detail').find('.radio').show();
		}
	})
	//禁用启用
	$('.stytem_select_right .enable').change(function(){
		/*var val = $(this).children('span').attr('value');
		var enable = $('.test_lists').find('.open');
		if(val == '1'){
			enable.find('i').addClass('icon-ok-circle').removeClass('icon-ban-circle');
			enable.find('em').css('background','#16be79').text('启用');
		}else if(val == '2'){
			enable.find('i').addClass('icon-ban-circle').removeClass('icon-ok-circle');
			enable.find('em').css('background','#DC1B11').text('禁用');
		}*/
		var val = $(this).attr('value');
		var enable = $('.test_lists').find('.open');
		if(val == '0'){
			enable.find('i').addClass('icon-ok-circle').removeClass('icon-ban-circle');
			enable.find('em').css('background','#16be79').text('启用');
		}else if(val == '1'){
			enable.find('i').addClass('icon-ban-circle').removeClass('icon-ok-circle');
			enable.find('em').css('background','#DC1B11').text('禁用');
		}
	})
	$('.test_lists').find('.open').click(function(){
		if($(this).children('em').text()=='禁用'){
			$(this).children('em').css('background','#16be79').text('启用');
			$(this).children('i').addClass('icon-ok-circle').removeClass('icon-ban-circle');
		}else if($(this).children('em').text()=='启用'){
			$(this).children('em').css('background','#DC1B11').text('禁用');
			$(this).children('i').addClass('icon-ban-circle').removeClass('icon-ok-circle');
		}
	})
	//dialog
	$('.addtest').hover(function(){
		$(this).find('.addtest_wrap').show();	
	},function(){
		$(this).find('.addtest_wrap').hide();
	})
	//dialog($('.addtest').find('em:eq(0)'),$('.testdialog'));
	//close($('.testdialog').find('.close'),$('.testdialog'));
	//考试发布
	dialog($('.release'),$('.newtestdialog'));
	close($('.newtestdialog').find('.close'),$('.newtestdialog'));
	//确任组卷
	dialog($('.confirm_testassem'),$('.confirm_testassemdialog'));
	close($('.confirm_testassemdialog').find('.close'),$('.confirm_testassemdialog'));
	//预览试卷
	dialog($('.test_lists li').find('.preview'),$('.previewpaper'));
	close($('.previewpaper').find('.close'),$('.previewpaper'));
})