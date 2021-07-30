	/*유효성 검사*/
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
	
	function fnChngPwApi() { //  fnChngPwApi
		/*
		사용자 입력정보 VALIDATION 체크
		해당 열  input, select 박스가 하나라도 미기재 된 경우 validation false
		최초 미입력 된 element로 focus 이동됨
		*/
		var frstIdx = "";
		jQuery(".intList span").each(function(){
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
		if(frstIdx != ""){
			frstIdx.focus();
			return false;
		}
		
		
		var userPw = $("#curPw").val();// 현재비밀번호
		var newPw = $("#newPw").val(); 	// 새로운 비밀번호
		var newPwRe = $("#newPwRe").val();// 새로운 비밀번호 확인
		
		//alert(userPw + newPw + newPwRe);
		
		// 비밀번호1 형식 검증
		if (!gfncPatternCheck(newPw)) {
			alert('비밀번호는 영문/숫자/특수문자 조합 8~12자리까지 입력 가능합니다.');
			jQuery("#newPw").focus();
			return;
		}
		
		// 비밀번호2 형식 검증
		if (!gfncPatternCheck(newPwRe)) {
			alert('비밀번호는 영문/숫자/특수문자 조합 8~12자리까지 입력 가능합니다.');
			jQuery("#newPwRe").focus();
			return;ss
		}
	
		// 비밀번호 확인 일치 검증
		if (newPw != newPwRe) {
			alert('비밀번호 확인이 새로운 비밀번호와 일치하지 않습니다.');
			jQuery("#newPw").focus();
			return;
		}
		
		jQuery("#pwChangeform").submit();
	}