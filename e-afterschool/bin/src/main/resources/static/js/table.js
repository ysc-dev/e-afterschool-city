/**
 * 테이블 관련 유틸
 */
$.extend( $.fn.dataTable.defaults, {
	autoWidth: false,
    dom: '<"datatable-header"fl><"datatable-scroll"t><"datatable-footer"ip>',
    language: {
		emptyTable: '데이터가 없습니다.',
		infoEmpty: "",
		info: " _TOTAL_ 개의 데이터가 있습니다.",
	    search: '<span>검색 :</span> _INPUT_',
	    searchPlaceholder: '내용 입력...',
	    lengthMenu: '<span>Show:</span> _MENU_',
	    paginate: { 'first': 'First', 'last': 'Last', 
	    	'next': $('html').attr('dir') == 'rtl' ? '&larr;' : '&rarr;', 'previous': $('html').attr('dir') == 'rtl' ? '&rarr;' : '&larr;' }
	},
	searching: false,
	lengthChange: false,
	pageLength: 10,
	ordering: false,
	info: false
});

var Datatables = {
	basic: function(id, pageLength) {
		var table = $(id).DataTable({
			pageLength: pageLength ? pageLength : 10,
			order: [[0, 'asc']]
		});
		
		return table;
	}
}