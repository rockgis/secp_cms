CKEDITOR.dialog.add('FileUploadDig', function (editor) {
    return {
        title: '파일업로드', // text shown titlebar.
        minWidth: 400,
        minHeight: 200,

        contents: [
            {
                id: 'tab-link',
                label: '링크속성',
                elements: [
                    {
                        type: 'text',
                        id: 'link',
                        label: '링크',
                        validate: CKEDITOR.dialog.validate.notEmpty("링크가 없습니다.")
                    }
                ]
            },
            {
                id: 'tab-upload',
                label: '파일업로드',
                elements: [
                    {
                        type: 'file',
                        id: 'upload',
//                        action: editor.config.mediacore_uploader_url,
                        onChange : function(){
                        	var dialog = CKEDITOR.dialog.getCurrent();
                        	var frm = this.getInputElement().getParent().$;

                    		$(frm).ajaxSubmit({
                        		url : editor.config.mediacore_uploader_url,
                        		data : {},
                        		iframe: false,
                        		dataType : "json",
                        		success : function(data){
                        			var url = document.location.origin + editor.config.root_path+"/direct_download.do?path=/upload/editor/"+data.yyyy+"/"+data.mm+"&file_nm="+data.uuid+"&rfile_nm="+data.attach_nm;
                        			var html = "<a href='"+url+"'>"+data.attach_nm+"</a>";
                        			dialog.getContentElement('tab-link','link').setValue(html);
                        			dialog.selectPage('tab-link');
                        		},
                        		error: function(e){
                        			alert(e.responseText);
                        		},
                        		complete : function(){
                        		}
                        	});
                        }
                    }
                ]
            }
        ],
        onOk: function () {
            var dialog = this;
            editor.insertHtml(dialog.getValueOf('tab-link', 'link')); // at now just testing purpose.
        },
        onShow : function(){
        	this.selectPage('tab-upload');
        }
    };
});