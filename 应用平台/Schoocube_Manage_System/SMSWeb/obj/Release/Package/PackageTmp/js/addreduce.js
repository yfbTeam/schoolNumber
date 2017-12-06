$(function(){
	var totalText = $('.test_number').find('i');
	$('.test_setting>div').each(function(){
		var $curInput = $(this).find('input');
		var $add = $(this).find('span:eq(0)');
		var $reduce = $(this).find('span:eq(1)');
		var $curNumber = $(this).find('em').children('i');
		$add.click(function(){
			var n = Number($curInput.val())+1;
			$curInput.val(n);
			$curNumber.text(n);
			totalText.text(sum());
			
		})
		$reduce.click(function(){
			var n = Number($curInput.val())-1;
			if(n<0){
				return;	
			};
			$curInput.val(n);
			$curNumber.text(n);
			totalText.text(sum());
		})
		$curInput.blur(function(){
			var $val =  Number($(this).val());
			$curNumber.text($val);
			totalText.text(sum());
		})
	})
	function sum(){
		var sum = 0;
		$('.test_setting').find('em').children('i').each(function(i,elem){
			
			sum+=Number($(elem).text());
		})
		return sum;
	}
})
