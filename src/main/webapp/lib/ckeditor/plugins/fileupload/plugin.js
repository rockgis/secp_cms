CKEDITOR.plugins.add('fileupload',
{
    init: function (editor) {
        var pluginName = 'fileupload';
        editor.addCommand( 'cmd-fileupload', new CKEDITOR.dialogCommand('FileUploadDig')); 
        editor.ui.addButton('Fileupload',
            {
                label: '파일첨부',
                command: 'cmd-fileupload',
                icon: CKEDITOR.plugins.getPath('fileupload') + 'icon.png'
            });
        CKEDITOR.dialog.add('FileUploadDig', this.path + 'dialogs/FileUploadDig.js');
    }
});
