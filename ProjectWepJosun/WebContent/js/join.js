$(document).ready(function () {
	//개인정보이용약관
	$('.btnToggle').click(function(){
		$('.toggleList > li').toggleClass('toggleOn');
		$('.toggleCont').slideToggle();
	});
	
	//input에 한글만 입력되게 설정
	var name = document.querySelector('#name');
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
	
});

function gfncPatternCheck(str){
    var checkNumber = str.search(/[0-9]/g);
    var checkEnglish = str.search(/[a-z]/ig);
    var checkExp = str.search(/[~!@#$%^&*()_+|<>?:{}]/gi);
 
    if(!/^(?=.*[a-zA-Z])(?=.*[~!@#$%^&*()_+|<>?:{}])(?=.*[0-9]).{8,12}$/.test(str)){            
        return false;
    }else if(checkNumber < 0 || checkEnglish < 0 || checkExp < 0){
        return false;
    }else{
    	return true;
    }
}

//회원가입 버튼 클릭 시,
function fncRegist() {
	var userName = jQuery.trim(jQuery("#name").val()); // 이름
	var userId = jQuery.trim(jQuery("#id").val()); // 아이디
	var userPw = jQuery.trim(jQuery("#pw").val()); // 비밀번호
	var userPwRe = jQuery.trim(jQuery("#pwRe").val()); // 비밀번호 확인
	
	var userPwHintQ = jQuery.trim(jQuery("#pwHintType option:selected").val()); // 비밀번호 힌트 질문
	var userPwHintA = jQuery.trim(jQuery("#userPwHint").val()); // 비밀번호 힌트 답
	
	var postcode = jQuery.trim(jQuery("#postcode").val()); // 우편번호
	var addr = jQuery.trim(jQuery("#addr").val()); // 기본주소
	var detailAddr = jQuery.trim(jQuery("#detailAddr").val()); // 상세주소
	var address = postcode + "//" + addr + "//" + detailAddr; //형식 (우편주소)기본주소 상세주소
	
	var phone1 = jQuery.trim(jQuery("#idPhone1").val()); // 010
	var phone2 = jQuery.trim(jQuery("#idPhone2").val()); // 0000
	var phone3 = jQuery.trim(jQuery("#idPhone3").val()); // 0000
	var phone = phone1 + "-" + phone2 + "-" + phone3; // 형식 : 010-0000-0000
	
	var emailId = jQuery.trim(jQuery("#emailId").val()); // 이메일 아이디
	var emailDo = jQuery.trim(jQuery("#eDomain").val()); // 이메일 도메인 주소
	var email = emailId + "@" + emailDo; // 형식 : email@email.com
	
	//주소, 핸드폰, 이메일 합치고 input:hidden에 value로 담기
	jQuery("#address").val(address);
	jQuery("#phone").val(phone);
	jQuery("#email").val(email);
	
	/*
		사용자 입력정보 VALIDATION 체크
		해당 열  input, select 박스가 하나라도 미기재 된 경우 validation false
		최초 미입력 된 element로 focus 이동됨
	 */
	var frstIdx = "";
	jQuery(".intList li").each(function(){
		var $this = jQuery(this);
		var validYn = true;
		$this.find("input[type='text'],input[type='password']").each(function(idx){
			var value = jQuery(this).val();
			var id = jQuery(this).attr("id");
			if(value == "" && id != "emailType"){
				validYn = false;
				if(frstIdx == ""){
					frstIdx = jQuery(this);
				}
			}
		});

		if(!validYn){
			$this.addClass("error");
			$this.find(".alertMessage").show();
		}else{
			$this.removeClass("error");
			$this.find(".alertMessage").hide();
		}
	});
	
	//전체 값들이 들어갈때까지
	if(frstIdx != ""){
		frstIdx.focus();
		return false;
	}
	
	// 개인정보 수집ㆍ이용 동의
	if ($("input:checkbox[id='frmChk02']").is(":checked") == false) {
		alert("개인정보 수집ㆍ이용에 동의해 주세요.");
		jQuery("#frmChk02").focus();
		return;
	}
	
	// 비밀번호1 형식 검증
	if (!gfncPatternCheck(userPw)) {
		alert('비밀번호는 영문/숫자/특수문자 조합 8~12자리까지 입력 가능합니다.');
		jQuery("#pw").focus();
		return;
	}
	
	// 비밀번호2 형식 검증
	if (!gfncPatternCheck(userPwRe)) {
		alert('비밀번호는 영문/숫자/특수문자 조합 8~12자리까지 입력 가능합니다.');
		jQuery("#pwRe").focus();
		return;
	}

	// 비밀번호 확인 일치 검증
	if (userPw != userPwRe) {
		alert('비밀번호 확인이 일치하지 않습니다.');
		jQuery("#pwRe").focus();
		return;
	}
	
	if(userPwHintQ == 'none'){
		alert('비밀번호 힌트 질문을 선택해주세요.');
		jQuery("#pwHintType").focus();
		return;
	}
	
	// 우편번호 체크
	if (postcode.length > 0) {

	}else{
		alert("주소입력은 필수 입니다.");
		jQuery("#postcode").focus();
		return;
	}

	// 주소 체크
	if (address.length > 0) {

	}else{
		alert("주소입력은 필수 입니다.");
		jQuery("#addr").focus();
		return;
	}

	// 상세주소 체크
	if (detailAddr.length > 0) {

	}else{
		alert("상세주소입력은 필수 입니다.");
		jQuery("#detailAddr").focus();
		return;
	}

	//아이디 중복체크 여부
	var idCheck  = jQuery("#idCheck").val();
	if(idCheck!='Y') { 
		alert("아이디 중복체크가 필요합니다.");	
		return;
	}
	
	jQuery("#joinform").submit();
}
