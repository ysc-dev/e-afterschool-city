/*******************************************************************************************************
 * 위젯 공통 기능
*******************************************************************************************************/
var CommonWidget = function() {
	var _componentSelect2 = function() {
		if (!$().select2) {
        	console.warn('Warning - select2.min.js is not loaded.');
            return;
        }
    	
    	// Initialize
        var $select = $('.form-control-select2').select2({
            minimumResultsForSearch: Infinity,
            width: '100%'
        });
        
        $('.select2-size').select2({
            minimumResultsForSearch: Infinity,
            width: '100'
        });
        
        // Select with search
        $('.select-search').select2();
        
        // Trigger value change when selection is made
        $select.on('change', function() {
            $(this).trigger('blur');
        });
    };
    
    var _componentSwal = function() {
    	/** Sweet Alerts Defaults */
    	swal.setDefaults({
	        buttonsStyling: false,
	        confirmButtonClass: 'btn btn-primary',
	        cancelButtonClass: 'btn btn-light'
	    });
    };
    
    // Uniform
    var _componentUniform = function() {
        if (!$().uniform) {
            console.warn('Warning - uniform.min.js is not loaded.');
            return;
        }

        $('.form-check-input-styled').uniform();
    };
    
    var _componentInputFormatter = function() {
    	 if (!$().formatter) {
             console.warn('Warning - formatter.min.js is not loaded.');
             return;
         }

         $('.format-jumin1').formatter({
             pattern: '{{999999}}'
         });
         
         $('.format-jumin2').formatter({
             pattern: '{{9999999}}'
         });
    };
    
    var _commonProcess = function() {
    	// 주민번호 검증 확인
    	function validate() {
    	    var re = /^[a-zA-Z0-9]{4,12}$/ // 아이디와 패스워드가 적합한지 검사할 정규식
    	    var re2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    	    // 이메일이 적합한지 검사할 정규식

    	    var num1 = document.getElementById("jumin1");
    	    var num2 = document.getElementById("jumin2");

    	    var arrNum1 = new Array(); // 주민번호 앞자리숫자 6개를 담을 배열
    	    var arrNum2 = new Array(); // 주민번호 뒷자리숫자 7개를 담을 배열

    	    // -------------- 주민번호 -------------
    	    for (var i=0; i<num1.value.length; i++) {
    	        arrNum1[i] = num1.value.charAt(i);
    	    } // 주민번호 앞자리를 배열에 순서대로 담는다.

    	    for (var i=0; i<num2.value.length; i++) {
    	        arrNum2[i] = num2.value.charAt(i);
    	    } // 주민번호 뒷자리를 배열에 순서대로 담는다.

    	    var tempSum = 0;

    	    for (var i=0; i<num1.value.length; i++) {
    	        tempSum += arrNum1[i] * (2+i);
    	    } // 주민번호 검사방법을 적용하여 앞 번호를 모두 계산하여 더함

    	    for (var i=0; i<num2.value.length-1; i++) {
    	        if (i>=2) {
    	            tempSum += arrNum2[i] * i;
    	        }
    	        else {
    	            tempSum += arrNum2[i] * (8+i);
    	        }
    	    } // 같은방식으로 앞 번호 계산한것의 합에 뒷번호 계산한것을 모두 더함

    	    if ((11-(tempSum%11))%10!=arrNum2[6]) {
    	        //alert("올바른 주민번호가 아닙니다.");
    	        num1.value = "";
    	        num2.value = "";
    	        num1.focus();
    	        return false;
    	    } else{
    	    	//alert("올바른 주민등록번호 입니다.");
    	    	return true;
    	    }
    	}
    }
    
    return {
        init: function() {
        	_componentSelect2();
        	_componentSwal();
        	_componentUniform();
        	_componentInputFormatter();
        	_commonProcess();
        }
    }
}();

document.addEventListener('DOMContentLoaded', function() {
	CommonWidget.init();
});