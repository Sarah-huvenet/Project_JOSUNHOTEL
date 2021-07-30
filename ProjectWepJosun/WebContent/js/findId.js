$(document).ready(function () { 
	
	//input에 한글만 입력되게 설정
	var name = document.querySelector('#tab01 #nameId');
	var onlyKorean = function() {
	  var pattern = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
	  this.value = this.value.replace(pattern, '');
	};
	name.addEventListener('keyup', onlyKorean);
	
	//input에 한글만 입력되게 설정
	var name = document.querySelector('#tab02 #namePw');
	var onlyKorean = function() {
	  var pattern = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
	  this.value = this.value.replace(pattern, '');
	};
	name.addEventListener('keyup', onlyKorean);
	
	//전화번호  maxlength만큼 입력 시 다음 input 으로 이동
	jQuery("input[id^='idPhone']").keyup(function(idx){
        var charLimit = jQuery(this).attr("maxlength");
        if(jQuery(this).attr("role") != "last"){
	        if(this.value.length >= charLimit) {
	        	jQuery(this).parent().next().next().find("input").focus();
	            return false;
	        }
        }
    });
	
	//이메일 도메인 선택 이벤트
	jQuery("#emailType").on("change", function(){
		$("#eDomain").val($(this).val());
		if($(this).val() == ""){
			$("#eDomain").prop("readonly", false);
		}else{
			$("#eDomain").prop("readonly", true);
		}
	});
	
	//id 박스 닫기
	$("#findIdBox a.close").on("click",function(event){
		event.preventDefault();
		$('#findIdBox').fadeOut("fast").children().hide();
		$('#tab01 input').val('');
		if($("#eDomain").val() == ""){
			$("#eDomain").prop("readonly", false);
		}else{
			$("#eDomain").prop("readonly", true);
		}
		$('#tab01 #emailType option:eq(0)').prop("selected", true);
	});
	
	//pw 박스 닫기
	$("#findPwBox a.close").on("click",function(event){
		event.preventDefault();
		$('#findPwBox').fadeOut("fast").children().hide();
		$('#tab02 input').val('');
		$('#tab02 #pwHintType option:eq(0)').prop("selected", true);
	});
	
});

//비밀번호 찾기용 변경 페이지이동
var tabSe = "";
function tabChange(tabSe) {
     jQuery("#tabSe").val(tabSe);
     //클릭하는 탭별로 제어
     if(tabSe=='id') {	  
         $('#tabId').removeClass('on').addClass('on');
         $('#tab01').attr('style',"display: block");
         $('#tabPw').removeClass('on').addClass('off');
         $('#tab02').attr('style',"display: none");
    }else {
    	 $('#tabId').removeClass('on').addClass('off');
    	 $('#tab01').attr('style',"display: none");
         $('#tabPw').removeClass('on').addClass('on');
         $('#tab02').attr('style',"display: block");
     }
} 