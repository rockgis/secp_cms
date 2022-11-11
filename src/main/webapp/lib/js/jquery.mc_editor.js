/**
 * 에디터 팩토리
 */
(function($) {
	$.fn.mcEditor = function(o) {
	    o = $.extend({
	        editorName: MC_EDITOR||"smarteditor",
	        width : '99%',
	        height : '500px',
	    }, o || {});

	    return this.each(function() {
		    	var editor = EDITOR.factory(o.editorName, $(this), o);
		    	editor.create();
			    this.getHtmlData = function(){
			    	return editor.htmlData();
			    }
			    this.getTextData = function(){
			    	return editor.textData();
			    }
			    this.focus = function(){
			    	$(this).trigger("FOCUS");
			    }
		    })
	};
	
	function EDITOR(){} 
	
	EDITOR.prototype.htmlData = function() {
		return this._htmlData;
	};
	
	EDITOR.factory = function(type, elem, option) {
	
		// 생성자가 존재하지 않으면 에러를 발생한다
		if (typeof EDITOR[type] !== "function") {
			throw Error(type + "생성자가 존재하지 않습니다.");
		};
		
		// 생성자의 존재를 확인했으므로 부모를 상속한다
		// 상속은 단 한번만 실행하도록 한다
		if (typeof EDITOR[type].prototype.create !== "function") {
			EDITOR[type].prototype = new EDITOR();
		}
		
		// 다른 메서드 호출이 필요하면 여기서 실행한 후, 인스턴스를 반환한다
		return new EDITOR[type](elem, option);
	};
	
	//스마트에디터 2.0
	EDITOR.smarteditor = function(elem, option) {
    	if($("script[smart-editor]").length==0){
    		$("head").append('<script type="text/javascript" src="'+contextPath+'/lib/se2/js/service/HuskyEZCreator.js" smart-editor></script>');
    	}
    	var s_id=elem.attr("id");
    	if(!s_id){
    		var s_id="se2_"+Math.random().toString().substring(2, 7);
    		elem.attr("id", s_id);
    	}
    	
    	if(!!option.width){
    		elem.css({width : option.width});
    	}
    	if(!!option.height){
    		elem.css({height : option.height});
    	}
    	
        this.create = function(){
    		var oEditors = [];
        	var _deferred = $.Deferred();
        	var _this = this;
        	var _on_change_event = $.Event("ON_CHANGE");
	    	setTimeout(function(){
		    	nhn.husky.EZCreator.createInIFrame({
		    		oAppRef: oEditors,
		    		elPlaceHolder: s_id,
		    		sSkinURI: contextPath + "/lib/se2/SmartEditor2Skin.html",
		    		fCreator: "createSEditor2",
		    		htParams : {
		    			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		    			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		    			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		    			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
		    			bSkipXssFilter : true,		// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용) 유튜브 링크 등
		    			fOnBeforeUnload : function(){
		    				//alert("완료!");
		    			}
		    		},
		    		fOnAppLoad : function(){
		    			_deferred.resolve();
		    		}
		    	});
	    	});
	
	    	_deferred.promise().then(function(){
	    		var _iframe = $("#".concat(s_id)).next().contents();
	    		_iframe.find("iframe#se2_iframe").contents().find("body").on("blur", updateModel);
				_iframe.find("iframe#se2_iframe").contents().find("body").on("keyup focus", updateModel);
				_iframe.find("textarea.se2_input_htmlsrc").on("keyup focus", updateModel);
				_iframe.find("textarea.se2_input_text").on("keyup focus", updateModel);
	            if(!location.pathname.startsWith("/super")){//관리자만 파일매니저 사용가능
	            	_iframe.find("li.husky_seditor_ui_filemanager").remove();
	            }
			});
	    	
	    	_deferred.promise().then(function(){
	            elem.on("UPDATE_HTML", function(e, v){
	            	oEditors.getById[s_id].setIR(v);
	            });
	            elem.on("FOCUS", function(e, v){
	            	oEditors.getById[s_id].exec("FOCUS");
	            });
	            if(!!option.onLoad){
	            	option.onLoad();
	            }
	    	});
	        function updateModel(){
	        	$("#".concat(s_id)).val(oEditors.getById[s_id].getIR());
	        	_this._htmlData = oEditors.getById[s_id].getIR();
	        	
	        	_on_change_event.value = _this._htmlData;
	        	elem.trigger(_on_change_event);
	        }
        }
	};
	
	//CK-Editor 생성
	EDITOR['ck-editor'] = function(elem, option) {
    	if($("script[ck-editor]").length==0){
    		$("head").append('<script type="text/javascript" src="'+contextPath+'/lib/ckeditor/ckeditor.js" ck-editor></script>');
    		$("head").append('<script type="text/javascript" src="'+contextPath+'/lib/ckeditor/adapters/jquery.js" ck-editor></script>');
    	}

    	var s_id=elem.attr("id");
    	if(!s_id){
    		var s_id="ck_"+Math.random().toString().substring(2, 7);
    		elem.attr("id", s_id);
    	}
    	
    	var options = {
                uiColor: '#FAFAFA',
                height: '300px',
                width: '100%',
                filebrowserBrowseUrl : contextPath+'/lib/Filemanager/index.html',
                filebrowserImageUploadUrl : contextPath+'/ckUploadImage.do'
            };

        if(!location.pathname.startsWith("/super")){//관리자만 파일매니저 사용가능
        	options.filebrowserBrowseUrl=null;
        }

    	if(!!option.width){
    		options.width = option.width;
    	}
    	if(!!option.height){
    		options.height = option.height;
    	}
    	
        this.create = function(){
        	var _deferred = $.Deferred();
        	var _this = this;
        	var _on_change_event = $.Event("ON_CHANGE");
            var ck = CKEDITOR.replace(elem[0], options);

            ck.on('instanceReady', function() {
            	_deferred.resolve();
            });
	    	
            _deferred.promise().then(function(){
	    		var _div = $("div#cke_".concat(s_id));
	    		_div.find("span.cke_top").on("click", onIframe);
	    		_div.on("keyup focus", _div, updateModel);
	    		onIframe();
    			function onIframe(){
        			_div.find("iframe").load(function(){
        				_div.find("iframe").contents().find("body").on("blur", updateModel);
        				_div.find("iframe").contents().find("body").on("keyup focus", updateModel);
        			});
    			}
	    	});
	    	
            _deferred.promise().then(function(){
	            elem.on("UPDATE_HTML", function(e, v){
	            	ck.setData(v);
	            });
	            elem.on("FOCUS", function(e, v){
	            	ck.focus();
	            });
	            if(!!option.onLoad){
	            	option.onLoad();
	            }
	    	});
            
            function updateModel() {
            	$(elem).val(ck.getData());
            	_this._htmlData = ck.getData();
	        	
            	_on_change_event.value = _this._htmlData;
	            elem.trigger(_on_change_event);
            }
        }
	};
	
	//나모 크로스에디터
	/*EDITOR.crosseditor = function(elem, option) {
    	if($("script[cross-editor]").length==0){
        	var cookielist = document.cookie.split(";");
			var expire = new Date();
			expire.setDate(expire.getDate() - 1);
        	for (var i = 0; i < cookielist.length; i++) {
        		var cookie = cookielist[i];
        		if(cookie.indexOf("CEnterkey_") > -1){
        			var cname = cookie.split("=")[0];
        			document.cookie = cname+"=;path=/;domain="+document.domain+";expires="+expire.toGMTString()+";";
        		}
			}
    		$("head").append('<script type="text/javascript" src="'+contextPath + '/lib/crosseditor/js/namo_scripteditor.js" cross-editor></script>');
        	var crosseditor_script="";
        	crosseditor_script = "<script type='text/javascript' cross-editor>";
        	crosseditor_script+= "function OnInitCompleted(e){";
        	crosseditor_script+= "	e.editorTarget.params._DEFERRED.resolve();";
        	crosseditor_script+= "}";
        	crosseditor_script+= "function CE_OnCustomMenu(e){";//파일매니저를 띄움
        	crosseditor_script+= "  if (e.type == 'custommenu_function' && e.customMenuID == 'Filemanager'){";
        	crosseditor_script+= "    window.open('/lib/Filemanager/index.html?CrossEd3_5='+e.editorName,'', 'width=1000,height=700,scrollbars=yes,status=yes,resizable=yes');";
        	crosseditor_script+= "  }";
        	crosseditor_script+= "}";
        	crosseditor_script+= "function CE_OnPaste(editorName, url){";//파일매니저에서 사용
        	crosseditor_script+= "  $('#'.concat(editorName)).trigger('INSERT_IMAGE', url)";
        	crosseditor_script+= "}";
        	crosseditor_script+= "</script>";
        	$("head").append(crosseditor_script);
    	}
    	var s_id=elem.attr("id");
    	if(!s_id){
    		var s_id="namo_"+Math.random().toString().substring(2, 7);
    		elem.attr("id", s_id);
    	}
    	var ed;
        this.create = function(){
	    	var _deferred = $.Deferred();
        	var _this = this;
        	var _on_change_event = $.Event("ON_CHANGE");
        	ed = new NamoSE(s_id);
//        	if(!!option.width){
//        		ed.params.Width = option.width;
//        	}
//        	if(!!option.height){
//        		ed.params.Height = option.height;
//        	}
        	
        	ed.params.ParentEditor = elem.parent().get(0);
        	ed.params.ImageSavePath = "/upload/editor";
        	ed.params.Width = "100%";
        	ed.params.UserLang = "auto";
        	ed.params.FullScreen = false;
        	ed.params.SetFocus = false; // 에디터 포커스 설정
        	ed.params.UploadFileNameType = "random"; // 업로드파일명 변경
        	ed.params._DEFERRED = _deferred;	//완료 알리기위한 변수
        	
            if(location.pathname.startsWith("/super")){//관리자만 파일매니저 사용가능
//            	ed.params.CreateToolbar = "newdoc|saveas|print|space|pagebreak|spacebar|undo|redo|cut|copy|paste|pastetext|search|replace|selectall|spacebar|Filemanager|image|ce_imageeditor|backgroundimage|flash|insertfile|spacebar|hyperlink|bookmark|inserthorizontalrule|specialchars|emoticon|spacebar|layout|spacebar|word_layer|enter|word_style|space|word_color|cancelattribute|spacebar|word_justify|space|word_indentset|space|txtmargin|space|word_listset|spacebar|tableinsert|tabledraginsert|spacebar|tablerowinsert|tablerowdelete|tablecolumninsert|tablecolumndelete|spacebar|tablecellmerge|tablecellsplit|spacebar|tablecellattribute|spacebar|spellchecker|enter|template|formatblock|fontname|fontsize|lineheight|spacebar|blockquote|word_script|spacebar|word_dir|spacebar|fullscreen|help|information|spacebar";
            	ed.params.CreateToolbar = "newdoc|saveas|print|space|pagebreak|spacebar|undo|redo|cut|copy|paste|pastetext|search|replace|selectall|spacebar|Filemanager|image|ce_imageeditor|backgroundimage|spacebar|hyperlink|bookmark|inserthorizontalrule|specialchars|emoticon|spacebar|layout|spacebar|word_layer|enter|word_style|space|word_color|cancelattribute|spacebar|word_justify|space|word_indentset|space|txtmargin|space|word_listset|spacebar|tableinsert|tabledraginsert|spacebar|tablerowinsert|tablerowdelete|tablecolumninsert|tablecolumndelete|spacebar|tablecellmerge|tablecellsplit|spacebar|tablecellattribute|spacebar|spellchecker|enter|template|formatblock|fontname|fontsize|lineheight|spacebar|blockquote|word_script|spacebar|word_dir|spacebar|fullscreen|help|information|spacebar";
            }else{
            	if(elem.width() <= 500){//모바일사이즈
                	ed.params.ConfigXmlURL = "mobile/config/Config_mobile.xml";
                	ed.params.CreateTab = "9|9|9";
            	}else{
//                	ed.params.CreateToolbar = "newdoc|saveas|print|space|pagebreak|spacebar|undo|redo|cut|copy|paste|pastetext|search|replace|selectall|spacebar|image|ce_imageeditor|backgroundimage|flash|insertfile|spacebar|hyperlink|bookmark|inserthorizontalrule|specialchars|emoticon|spacebar|layout|spacebar|word_layer|enter|word_style|space|word_color|cancelattribute|spacebar|word_justify|space|word_indentset|space|txtmargin|space|word_listset|spacebar|tableinsert|tabledraginsert|spacebar|tablerowinsert|tablerowdelete|tablecolumninsert|tablecolumndelete|spacebar|tablecellmerge|tablecellsplit|spacebar|tablecellattribute|spacebar|spellchecker|enter|template|formatblock|fontname|fontsize|lineheight|spacebar|blockquote|word_script|spacebar|word_dir|spacebar|fullscreen|help|information|spacebar";
                	ed.params.CreateToolbar = "newdoc|saveas|print|space|pagebreak|spacebar|undo|redo|cut|copy|paste|pastetext|search|replace|selectall|spacebar|image|ce_imageeditor|backgroundimage|spacebar|hyperlink|bookmark|inserthorizontalrule|specialchars|emoticon|spacebar|layout|spacebar|word_layer|enter|word_style|space|word_color|cancelattribute|spacebar|word_justify|space|word_indentset|space|txtmargin|space|word_listset|spacebar|tableinsert|tabledraginsert|spacebar|tablerowinsert|tablerowdelete|tablecolumninsert|tablecolumndelete|spacebar|tablecellmerge|tablecellsplit|spacebar|tablecellattribute|spacebar|spellchecker|enter|template|formatblock|fontname|fontsize|lineheight|spacebar|blockquote|word_script|spacebar|word_dir|spacebar|fullscreen|help|information|spacebar";
                }
            }
            
        	if(!!option.width){
        		ed.params.Width = option.width;
        	}
        	if(!!option.height){
        		ed.params.Height = option.height;
        	}

        	ed.params.event.CBInsertedImage = function(imgobj, insertype){//이미지 업로드후 콜백함수
        		updateModel();
	        }
            
        	ed.EditorStart();

        	_deferred.promise().then(function(){
            	var _iframe = $("iframe#NamoSE_Ifr__".concat(s_id)).contents();
            	_iframe.find("#newdoc").on("click", onIframe);
            	onIframe();
            	function onIframe(){
                	_iframe.find("iframe#NamoSE_editorframe_".concat(s_id)).contents().find("body").on("keyup", updateModel);
                	_iframe.find("iframe#NamoSE_editorframe_".concat(s_id)).contents().on("mouseleave", function(e){
            			if(!ed.IsInTable()){
            				updateModel();
            			}
                	});
                	_iframe.find("textarea#NamoSE_editorshtml_".concat(s_id)).on("keyup focus", updateModel);
            	}

        	});
	    	
            _deferred.promise().then(function(){
				if(!!elem.val()){
					ed.SetBodyValue(elem.val());
				}
	            elem.on("INSERT_IMAGE", function(e, url){
	            	ed.InsertImage(url, '이미지');
	            });
	    	});
	    	
            _deferred.promise().then(function(){
	            elem.on("UPDATE_HTML", function(e, v){
	            	ed.SetBodyValue(v);
	            });
	            elem.on("FOCUS", function(e, v){
	            	ed.SetFocusEditor();
	            });
	            if(!!option.onLoad){
	            	option.onLoad();
	            }
	    	});
        	
	        function updateModel(){
	        	$("#".concat(s_id)).val(ed.GetBodyValue());
	        	_this._htmlData = ed.GetBodyValue();
	        	
            	_on_change_event.value = _this._htmlData;
	            elem.trigger(_on_change_event);
	        }
        }
        
        this.textData = function(){
        	return ed.GetTextValue();
        }
	};*/

	
	//MI-Editor 생성
	EDITOR['mi-editor'] = function(elem, option) {
    	var s_id=elem.attr("id");
    	if(!s_id){
    		var s_id="mi_"+Math.random().toString().substring(2, 7);
    		elem.attr("id", s_id);
    	}
    	
    	var options = {
			width: '300px',
			height:'100%'
        };
    	
    	if(!!option.width){
    		options.width = option.width;
    	}
    	if(!!option.height){
    		options.height = option.height;
    	}
    	
        this.create = function(){
        	var _deferred = $.Deferred();
        	var _this = this;
        	var _on_change_event = $.Event("ON_CHANGE");
        	var _editor;
    		setTimeout(function(){
    			
    			_editor = CodeMirror.fromTextArea(document.getElementById(s_id), {
	            	lineNumbers: true,
//	            	lineWrapping: true,
	            	mode: "text/html",
	        	});
	            _editor.setSize(options.width, options.height);
	            _deferred.resolve();
    		});

        	
	    	_deferred.promise().then(function(){
	    		var _div = $("#".concat(s_id)).next(".CodeMirror");
	    		_div.on("keyup focus", updateModel);
			});
	    	
	    	_deferred.promise().then(function(){
	            elem.on("UPDATE_HTML", function(e, v){
		    		_editor.setValue(v);
	            });
	            elem.on("FOCUS", function(e, v){
	            	_editor.setFocus();
	            });
	            if(!!option.onLoad){
	            	option.onLoad();
	            }
	    	});
	        function updateModel(){
	        	$("#".concat(s_id)).val(_editor.getValue());
	        	_this._htmlData = _editor.getValue();
	        	
	        	_on_change_event.value = _this._htmlData;
	        	elem.trigger(_on_change_event);
	        }
        }
	};
})(jQuery);