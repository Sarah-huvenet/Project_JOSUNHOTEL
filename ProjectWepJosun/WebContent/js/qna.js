var commonJs = {};
this.commonJs = commonJs;

$(document).ready(function () {

	//input에 한글만 입력되게 설정
	var name = document.querySelector('#korNm');
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
	
	//파일업로드 스크립트 호출
	commonJs.setFileUpload('.fileUpload');
	
	//개인정보이용약관
	$('.btnToggle').click(function(){
		$('.toggleList > li').toggleClass('toggleOn');
		$('.toggleCont').slideToggle();
	});
	
		
});




/*스크립트 영역***********************************************************************************************************************/
//파일 업로드, 삭제
commonJs.setFileUpload = function (uploadNode) {
    /** 파일 선택 */
    $(document).on('change', uploadNode + ' .uploadBtn', function (e) {
        if (window.FileReader) {
            if (this.files.length < 1) {
                $(this)
                    .closest(uploadNode)
                    .find('.intDel .btnDel')
                    .hide();
                $(this)
                    .closest(uploadNode)
                    .find('.intDel')
                    .eq(0)
                    .find('.fileName')
                    .val('');
                $(this)
                    .get(0)
                    .value = "";
                return;
            }
            var filename = this
                .files[0]
                .name;
            $(this)
                .closest(uploadNode)
                .find('.intDel .fileName')
                .val(filename);
        } else {
            var filename = $(this)
                .val()
                .split('/')
                .pop()
                .split('\\')
                .pop();
            $(this)
                .closest(uploadNode)
                .find('.intDel:last .fileName')
                .val(filename);
        }
        $(this)
            .closest(uploadNode)
            .find('.btnDel')
            .show();
    });

    /** 파일 삭제 */
    $(document).on('click', uploadNode + ' .btnDel', function () {
        var _t = $(this);
        _t.hide();
        if (window.FileReader) {
            _t
                .closest(uploadNode)
                .find('.uploadBtn')
                .get(0)
                .files[0]
                .value = '';
            if (_t.closest(uploadNode).find('.intDel:visible').length > 1) {
                _t
                    .closest('.intDel')
                    .hide();
            } else {
                _t
                    .siblings('.fileName')
                    .val('');
                _t
                    .closest(uploadNode)
                    .find('.uploadBtn')
                    .get(0)
                    .value = "";
            }
        } else {
            _t
                .siblings('.fileName')
                .get(0)
                .value = '';
            var uploadNodeClone = _t
                .closest(uploadNode)
                .find('.uploadBtn')
                .clone(true);
            _t
                .closest(uploadNode)
                .find('.uploadBtn')
                .replaceWith(uploadNodeClone);
        }
    });
}
