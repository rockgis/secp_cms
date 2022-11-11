/**
 * 유틸 디렉티브
 * @param ang
 */
(function(ang){
	ang.module('myUtil', [])
	.directive('onlyNumber', function () {
	    return {
	        require: 'ngModel',
	        link: function (scope, elem, attrs, ngModelCtrl) {
	        	ngModelCtrl.$parsers.push(function (inputValue) {
	        		var transformedInput = inputValue;
	        		if(attrs.onlyNumber=="decimal"){
	        			transformedInput = inputValue.replace(/^\./g, "0.");
	        			transformedInput = transformedInput.replace(/^00/g, '0');
	        			transformedInput = transformedInput.replace(/[^0-9+.-]/g, '');
	        			transformedInput = transformedInput.replace(/([0-9]\.[0-9]*)\./g, '$1');
	        			
	        			if (transformedInput!==inputValue) {
		                	ngModelCtrl.$setViewValue(transformedInput);
		                	ngModelCtrl.$render();
	        			}
		                return transformedInput; 
	        		}else{
	        			if((typeof inputValue)=="string"){
		        			transformedInput = inputValue.replace(/[^0-9+]/g, '');
		        			transformedInput = transformedInput.length>1 ? transformedInput.replace(/^0/, ''): transformedInput;
		        		}
	        			if (transformedInput!==inputValue) {
		                	ngModelCtrl.$setViewValue(Number(transformedInput));
		                	ngModelCtrl.$render();
		                }
		                return Number(transformedInput); 
	        		}
	            });
	        }
	    };
	})
	.directive('myHref', function($location) {
		return {
	        link: function(scope, elem, attrs) {
	        	elem.on('click', function() {
	                scope.$apply(function() {
	                    $location.path(attrs.myHref);
	                });
	            });
	        }
	    }
	})
	//렌더링 끝나면 실행하는 함수
	.directive('onFinishRender', function ($timeout) {
		return {
	        restrict: 'A',
	        link: function (scope, elem, attrs) {
	            if (scope.$last === true) {
	            	$timeout(function () {
	            		var id = attrs['onFinishRender'];
	        			scope.$emit(id);
	            	}, 100);
//	            	$timeout(function() { 
//	            		scope.$eval(attrs.onFinishRender);
//	            	}, 100);
	            }
	        }
    	}
	})
	.directive('pwCheck', [function () {
	    return {
	        require: 'ngModel',
	        link: function (scope, elem, attrs, ctrl) {
	            var firstPassword = '#' + attrs.pwCheck;
	            elem.add(firstPassword).on('keyup', function () {
	                scope.$apply(function () {
	                    ctrl.$setValidity('pwmatch', elem.val() === $(firstPassword).val());
	                });
	            });
	        }
	    }
	}]).directive('ngChecklist', function() {
		  return {
			    scope : {
				all : '=ngCheckall',
				list : '=ngChecklist',
				value : '@'
			},
			link : function(scope, elem, attrs) {
				$(elem).on('change', function() {
					scope.$apply(function() {
						var checked = $(elem).prop('checked');
						var index = $.inArray(scope.value, scope.list);

						if (checked && index == -1) {
							scope.list.push(scope.value);
						} else if (!checked && index != -1) {
							scope.list.splice(index, 1);
						}
					});
				});

				scope.$watch('list', function() {
					var checked = $(elem).prop('checked');
					var index = $.inArray(scope.value, scope.list);

					if (checked && index == -1) {
						$(elem).prop('checked', false);
					} else if (!checked && index != -1) {
						$(elem).prop('checked', true);
					}
				}, true);
				
				scope.$watch('all', function(newValue, oldValue) {
					if(angular.equals(newValue, oldValue)){
					    return;
					}
					if(newValue){
						for ( var i in scope.list) {
							var item = scope.list[i];
							$(item).prop('checked', true);
						}
					}else{
						for ( var i in scope.list) {
							var item = scope.list[i];
							$(item).prop('checked', false);
						}
					}
				}, true);
			}
		};
	}).directive('bindHtmlUnsafe', function( $compile ) {
	    return function(scope, elem, attr ) {

	        var compile = function( newHTML ) { // Create re-useable compile function
	            newHTML = $compile(newHTML)(scope); // Compile html
	            elem.html('').append(newHTML); // Clear and append it
	        };

	        var htmlName = attr.bindHtmlUnsafe; // Get the name of the variable 
	                                              // Where the HTML is stored

	        scope.$watch(htmlName, function( newHTML ) { // Watch for changes to 
	                                                      // the HTML
	            if(!newHTML) return;
	            compile(newHTML);   // Compile it
	        });

	    };
	}).directive('datepicker', function () {
		return {
	        restrict: 'A',
	        require : 'ngModel',
	        link : function (scope, elem, attrs, ctrl) {
	        	var options = {
	        			monthNames : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], 
	        			monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], 
	        			dayNames : ['일', '월', '화', '수', '목', '금', '토'],
	        			dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],
	        			dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
	        			dateFormat:'yy-mm-dd',
	                    showOn: "button",      
	            		buttonImage: "/images/super/contents/calendar.png",
	                    onSelect:function (date) {
	                        scope.$apply(function () {
	                            ctrl.$setViewValue(date);
	                        });
	                    }
                    };
	        	options = ang.extend(options, scope[attrs.datepicker]);
                elem.datepicker(options);
	        }
	    }
	}).directive('datetimepicker', function ($compile) {
		return {
	        restrict: 'A',
	        require : 'ngModel',
	        scope:{
	        	datetimepicker : '=',
	        	dateMaxModel : '=',
		        dateMinModel : '='
	        },
	        link : function (scope, elem, attrs, ctrl) {
	        	var options = {
	    				inline:false,
	    				format:	'Y-m-d',
	    				timepicker : false,
	    				onChangeYear : changeDate,
	    				onChangeMonth : changeDate,
	    				onChangeDateTime : changeDate,
	    				onSelectDate : changeDate
                    };
	        	options = ang.extend(options, scope.datetimepicker);
	        	if(!!attrs.dateMaxModel){
		        	options = ang.extend(options, {
		        		onShow : function(){
		        			this.setOptions({
		        				maxDate : scope.dateMaxModel
		        			})
		        		}
		        	});
	        	}
	        	if(!!attrs.dateMinModel){
	        		options = ang.extend(options, {
	        			onShow : function(){
	        				this.setOptions({
	        					minDate : scope.dateMinModel
	        				})
	        			}
	        		});
	        	}
                elem.datetimepicker(options);
                var btn = $("<img class='cal_icon' src='/images/super/contents/calendar.png'>");
                btn.on("click", function(){
                	elem.datetimepicker('show');
                });
                elem.after(btn);

    			function changeDate(date, o) {
    				scope.$apply(function () {
                        ctrl.$setViewValue($(o).val());
                    });
    			}
	        }
	    }
	}).directive('errSrc', function() {
		return {
		    link: function(scope, elem, attrs) {
		    	elem.bind('error', function() {
			        if (attrs.src != attrs.errSrc) {
			        	attrs.$set('src', attrs.errSrc);
			        }
		    	});
		    }
		}
	}).directive('bookmark', function ($timeout) {
		return {
	        restrict: 'E',
	        transclude: true,
	        template : '<div class="bookmark"><p class="bm_tit">즐겨찾기</p><ul></ul></div>',
	        replace : true,
	        link : function (scope, elem, attrs, ctrl) {
	        	var topBar = $(".titlebar").offset();
				$(window).scroll(function(){
					var docScrollY = $(document).scrollTop()
					var barThis = $("#topBar")
		
					if( docScrollY > topBar.top ) {
						barThis.addClass("top_bar_fix");
					}else{
						barThis.removeClass("top_bar_fix");
					}
				});
				$timeout(function(){
					$(".booker>a.favorite").on("click", favorites);
					var data = localStorage.getItem("favorites_"+attrs.userid);
					if(data != null){
						$.each($.parseJSON(data).list, function(i, o){
							$(".bookmark>ul").append("<li><a href='"+o.url+"'>"+o.title+"</a></li>");
							$(".booker[menu_seq='"+o.menu_seq+"']>a:first").swapClass("on", "off");
							$(".booker[menu_seq='"+o.menu_seq+"']>a:first").closest("span").swapClass("in", "out");
						});
					}
				}, 100);
				
				function favorites(e){
					e.preventDefault();
					$(this).swapClass("on", "off");
					$(this).closest("span").swapClass("in", "out");
					if($(".menu_scroll span.booker>a.on").size()>15){
						alert("더이상 즐겨찾기를 추가하실수 없습니다.");
						$(this).swapClass("on", "off");
						return false;
					}
					var rst = $.map($(".menu_scroll span.booker>a.on"), function(o){
						return {
							menu_seq : $(o).closest("span.booker").attr("menu_seq")
							, title : $(o).closest("div").children("span.name").text()
							, url : $(o).closest("div").children("span.name").children("a").attr("href")
						};
					});
					
					localStorage.setItem("favorites_"+attrs.userid, JSON.stringify({list : rst}));
					$(".bookmark>ul").empty();
					$.each(rst, function(i, o){
						$(".bookmark>ul").append("<li><a href='"+o.url+"'>"+o.title+"</a></li>");
					});
				}
	        }
	    }
	}).directive('checklistModel', ['$parse', '$compile', function($parse, $compile) {// HELP : http://vitalets.github.io/checklist-model/
		  // contains
		  function contains(arr, item, comparator) {
		    if (angular.isArray(arr)) {
		      for (var i = arr.length; i--;) {
		        if (comparator(arr[i], item)) {
		          return true;
		        }
		      }
		    }
		    return false;
		  }

		  // add
		  function add(arr, item, comparator) {
		    arr = angular.isArray(arr) ? arr : [];
		      if(!contains(arr, item, comparator)) {
		          arr.push(item);
		      }
		    return arr;
		  }  

		  // remove
		  function remove(arr, item, comparator) {
		    if (angular.isArray(arr)) {
		      for (var i = arr.length; i--;) {
		        if (comparator(arr[i], item)) {
		          arr.splice(i, 1);
		          break;
		        }
		      }
		    }
		    return arr;
		  }

		  // http://stackoverflow.com/a/19228302/1458162
		  function postLinkFn(scope, elem, attrs) {
		    // compile with `ng-model` pointing to `checked`
		    $compile(elem)(scope);

		    // getter / setter for original model
		    var getter = $parse(attrs.checklistModel);
		    var setter = getter.assign;
		    var checklistChange = $parse(attrs.checklistChange);

		    // value added to list
		    var value = $parse(attrs.checklistValue)(scope.$parent);


		  var comparator = angular.equals;

		  if (attrs.hasOwnProperty('checklistComparator')){
		    comparator = $parse(attrs.checklistComparator)(scope.$parent);
		  }

		    // watch UI checked change
		    scope.$watch('checked', function(newValue, oldValue) {
		      if (newValue === oldValue) { 
		        return;
		      } 
		      var current = getter(scope.$parent);
		      if (newValue === true) {
		        setter(scope.$parent, add(current, value, comparator));
		      } else {
		        setter(scope.$parent, remove(current, value, comparator));
		      }

		      if (checklistChange) {
		        checklistChange(scope);
		      }
		    });
		    
		    // declare one function to be used for both $watch functions
		    function setChecked(newArr, oldArr) {
		        scope.checked = contains(newArr, value, comparator);
		    }

		    // watch original model change
		    // use the faster $watchCollection method if it's available
		    if (angular.isFunction(scope.$parent.$watchCollection)) {
		        scope.$parent.$watchCollection(attrs.checklistModel, setChecked);
		    } else {
		        scope.$parent.$watch(attrs.checklistModel, setChecked, true);
		    }
		  }

		  return {
		    restrict: 'A',
		    priority: 1000,
		    terminal: true,
		    scope: true,
		    compile: function(tElement, tAttrs) {
		      if (tElement[0].tagName !== 'INPUT' || tAttrs.type !== 'checkbox') {
		        throw 'checklist-model should be applied to `input[type="checkbox"]`.';
		      }

		      if (!tAttrs.checklistValue) {
		        throw 'You should provide `checklist-value`.';
		      }

		      // exclude recursion
		      tElement.removeAttr('checklist-model');
		      
		      // local scope var storing individual checkbox model
		      tElement.attr('ng-model', 'checked');

		      return postLinkFn;
		    }
		  };
		}]);
})(angular);