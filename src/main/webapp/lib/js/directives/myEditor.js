/**
 * 다중 에디터 디렉티브
 */
(function(ang){
	ang.module('myEditor', []).directive('globalEditor', function($timeout) {
	    return {
	        restrict: 'A',
			require: 'ngModel',
			scope : {
				width : '=ngWidth',
				height : '=ngHeight'
			},
	        link: function(scope, elem, attrs, ctrl) {
	        	if($("script[my-editor]").size()==0){
	        		$("head").append('<script type="text/javascript" src="'+contextPath + '/lib/js/jquery.mc_editor.js" my-editor></script>');
	        	}
	        	var editor_name = elem.attr('global-editor');
	        	if(!editor_name){
	        		editor_name = MC_EDITOR;
	        	}
	        	elem.mcEditor({
	        		editorName : editor_name,
	        		width : scope.width,
	        		height : scope.height,
	        		onLoad : function(){
	        			scope.$apply(function() {
	        				elem.trigger("UPDATE_HTML", ctrl.$modelValue||"");
	        			});
	        		}
	        	});
	        	elem.on("ON_CHANGE", function(e){
	        		scope.$apply(function(){
	        			ctrl.$setViewValue(e.value);
	        		});
	        	});
	        	ctrl.$render = function() {
	        		elem.trigger("UPDATE_HTML", ctrl.$modelValue);
				};
	        }
	    };
	});
})(angular);