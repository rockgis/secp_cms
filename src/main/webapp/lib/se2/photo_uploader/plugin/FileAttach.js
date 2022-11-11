/**
 * @use 간단 포토 업로드용으로 제작되었습니다.
 * @author cielo
 * @See nhn.husky.SE2M_Configuration 
 * @ 팝업 마크업은 SimplePhotoUpload.html과 SimplePhotoUpload_html5.html이 있습니다. 
 */

nhn.husky.SE_FileAttach = jindo.$Class({		
	name : "SE_FileAttach",

	$init : function(){},
	
	$ON_MSG_APP_READY : function() {
		this.oApp.exec("REGISTER_UI_EVENT", [ "fileattach", "click", "SE_OPEN_ATTACH" ]);
	},
	
	$LOCAL_BEFORE_FIRST : function(sMsg){
		if(!!this.oPopupMgr){ return; }
		// Popup Manager에서 사용할 param
		this.htPopupOption = {
			oApp : this.oApp,
			sName : this.name,
			bScroll : false,
			sProperties : "",
			sUrl : ""
		};
		this.oPopupMgr = nhn.husky.PopUpManager.getInstance(this.oApp);
	},
	
	$ON_SE_OPEN_ATTACH : function() {
		this.htPopupOption.sUrl = this.makePopupURL();
		this.htPopupOption.sProperties = "left=200,top=100,width=403,height=359,scrollbars=yes,status=yes,resizable=yes";

		this.oPopupWindow = this.oPopupMgr.openWindow(this.htPopupOption);
		
		// 처음 로딩하고 IE에서 커서가 전혀 없는 경우
		// 복수 업로드시에 순서가 바뀜	
		this.oApp.exec('FOCUS');
		return (!!this.oPopupWindow ? true : false);
	},
	
	/**
	 * 서비스별로 팝업에  parameter를 추가하여 URL을 생성하는 함수	 
	 * nhn.husky.SE2M_AttachQuickPhoto.prototype.makePopupURL로 덮어써서 사용하시면 됨.
	 */
	makePopupURL : function(){
		var sPopupUrl = "/lib/FileAttach/index.html?SE2=Y";
		
		return sPopupUrl;
	},
	
	/**
	 * 팝업에서 호출되는 메세지.
	 */
	$ON_SET_ATTACH : function(aPhotoData){
		this.oApp.exec("PASTE_HTML", [aPhotoData]);
	},
});