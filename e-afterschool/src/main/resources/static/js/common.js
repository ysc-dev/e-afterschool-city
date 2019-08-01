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
    
    return {
        init: function() {
        	_componentSelect2();
        	_componentSwal();
        	_componentUniform();
        	_componentInputFormatter();
        }
    }
}();

document.addEventListener('DOMContentLoaded', function() {
	CommonWidget.init();
});