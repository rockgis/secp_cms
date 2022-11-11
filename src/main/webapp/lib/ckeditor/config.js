/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {

	var root_path = "";
	config.root_path = root_path;

	config.uiColor = '#FAFAFA';
	
	config.extraPlugins = 'fileupload';//사용자 정의 플러그인
	
	config.toolbar = [
  	{ name: 'document', groups: [ 'mode', 'document', 'doctools' ], items: [ 'Source', '-', 'Save', 'NewPage', 'Preview', 'Print', '-', 'Templates' ] },
//  	{ name: 'clipboard', groups: [ 'clipboard', 'undo' ], items: [ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo' ] },
//  	{ name: 'forms', items: [ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField' ] },
  	{ name: 'insert', items: [ 'Image', 'Fileupload', 'Flash', 'Table', 'HorizontalRule', 'Smiley', 'SpecialChar', 'PageBreak', 'Iframe' ] },
//  	'/',
  	{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ], items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', 'CreateDiv', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl', 'Language' ] },
//  	{ name: 'links', items: [ 'Link', 'Unlink', 'Anchor' ] },
  	'/',
  	{ name: 'styles', items: [ 'Styles', 'Format', 'Font', 'FontSize' ] },
  	{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat' ] },
  	{ name: 'colors', items: [ 'TextColor', 'BGColor' ] },
  	{ name: 'others', items: [ '-' ] },
  	{ name: 'editing', groups: [ 'find', 'selection', 'spellchecker' ], items: [ 'Find', 'Replace', '-', 'SelectAll' ] },
  	{ name: 'tools', items: [ 'Maximize', 'ShowBlocks' ] },
  	{ name: 'about', items: [ 'About' ] }
  ];

	// Remove some buttons provided by the standard plugins, which are
	// not needed in the Standard(s) toolbar.
	config.removeButtons = 'Underline,Subscript,Superscript,Save,ShowBlocks,Iframe,Flash,Language';

	// Set the most common block elements.
	config.format_tags = 'p;h1;h2;h3;pre';

	// Simplify the dialog windows.
	config.removeDialogTabs = 'image:advanced;link:advanced';
	config.language = 'ko';
	config.allowedContent = true; //Editor 안에서 CSS사용 가능
//	config.enterMode = CKEDITOR.ENTER_BR;       // 엔터를 <br/> 태그로 AngularJS에서 에러남
//	config.font_names ='맑은 고딕; 돋움; 바탕; 돋음; 궁서; Nanum Gothic Coding; Quattrocento Sans;'+config.font_names;
	config.filebrowserImageUploadUrl = root_path+'/ckUploadImage.do';
	config.mediacore_uploader_url = root_path+'/ckFileUpload.do'; 
};
