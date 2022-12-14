if(window.console == undefined) console = {log:function(){}};
/*
var console_text = "";
console_text +="   __  _____________  _______  _______		\n";
console_text +="  /  |/  / ___/ ___ \\/ ___/  |/  / __/		\n";
console_text +=" / /|_/ / /__/ / _ `/ /__/ /|_/ /\\ \\  	\n";
console_text +="/_/  /_/\\___/\\ \\_,_/\\___/_/  /_/___/  	\n";
console_text +="              \\___/                   		\n";
console.log("%c"+console_text, "color:blue;font-size:10pt;");
*/
console.log
("%c   __  ________%c_____%c  _______  _______		\
\n%c  /  |/  / ___%c/ ___ \\%c/ ___/  |/  / __/		\
\n%c / /|_/ / /__%c/ / _ \\%c/ /__/ /|_/ /\\ \\  	\
\n%c/_/  /_/\\___/%c\\ \\_/_/%c\\___/_/  /_/___/  	\
\n%c              \\___/                   		\n", 
 "color:#1d82c4", "color:#53ac2b", "color:#f7b113",
 "color:#1d82c4", "color:#53ac2b", "color:#f7b113",
 "color:#1d82c4", "color:#53ac2b", "color:#f7b113",
 "color:#1d82c4", "color:#53ac2b", "color:#f7b113",
 "color:#53ac2b");

var DEBUG = true;
var MC_EDITOR = "smarteditor";//ck-editor,smarteditor,crosseditor
function ajaxPost(url, json) {
	var deferred = $.Deferred();
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajax({
		method: "POST",
		contentType: "application/json",
		url: url,
		data: JSON.stringify(json),
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token)
		},
		success: function(data) {
			deferred.resolve(data);
		},
		error: function() {
			deferred.reject();
		}
	});
	return deferred.promise();
}
function getJSON(targetURL, params, callback){
	var promise = $.ajax({
		url : targetURL, 
		type: "POST", 
		data : params, 
		dataType : "json", 
		async: true,
		cache : false
	}).fail(errorProc);
	
	promise.done(function(data){
		if(!!callback){
			callback(data);
		}
	});
	return promise;
}
function getSyncJSON(targetURL, params, callback){
	var promise = $.ajax({
		url : targetURL, 
		type: "POST", 
		data : params, 
		dataType : "json", 
		async: false,
		cache : false
	}).fail(errorProc);
	
	promise.done(function(data){
		if(!!callback){
			callback(data);
		}
	});
	return promise;
}
function errorProc(jqXHR,textStatus,errorThrown){
	if(jqXHR.status == 401){
		var returnURL = location.pathname + location.search;
		if(confirm("????????? ??????????????????.\n????????? ??? ?????? ????????? ?????????.\n????????????????????? ?????????????????????????")){
			window.top.location.href = "/super/login/index.do?returnURL="+returnURL;
		}
	}else if(jqXHR.status == 403){
		var returnURL = location.pathname + location.search;
		if(confirm("????????? ???????????? ?????????????????????, ???????????????????????????.\n????????????????????? ?????????????????????????")){
			window.top.location.href = "/super/login/index.do?returnURL="+returnURL;
		}
	}else if(jqXHR.status == 404){
		alert("???????????? ???????????? ????????? ????????????.");
	}else{
		var msg = $.parseJSON(jqXHR.responseText);
		if("Y"==msg.debug){
			alert("=================????????????("+jqXHR.status+")=================\n"+jqXHR.statusText+" ????????? ??????????????? ????????????\n====================END====================");
			console.error(msg.error_message);
		}else{
			alert("==============="+jqXHR.statusText+"================\n??????????????? ??????????????????\n=====================END====================");
		}
	}
}
if(!String.prototype.startsWith) {
	String.prototype.startsWith = function(str){
		if (this.length < str.length) { return false; }
		return this.indexOf(str) == 0;
	}
}
if(!String.prototype.endsWith) {
	String.prototype.endsWith = function(str){
		if (this.length < str.length) { return false; }
		return this.lastIndexOf(str) + str.length == this.length;
	}
}
if (!window.location.origin) {
    window.location.origin  = window.location.protocol + "//" + window.location.hostname + ( window.location.port ? ':'+window.location.port : '' );
}

if(!!$.blockUI){
	$.blockUI.defaults = {
			message : "<img src='/images/common/ajax-loader.gif' alt='?????????...'/> ????????? ??????????????????.",
		    overlayCSS:  { 
		        backgroundColor: '#968d8d', 
		        opacity:         0.6, 
		        cursor:          'wait' ,
				'z-index' : 200000
		    }, 
		    centerX: true, // <-- only effects element blocking (page block controlled via css above) 
		    centerY: true,
		    bindEvents: true,
		    constrainTabKey : true,
		    showOverlay : true,
			css : {
			    border: 'none', 
			    padding: '5px', 
			    backgroundColor: '#676767', 
			    '-webkit-border-radius': '10px', 
			    '-moz-border-radius': '10px', 
			    opacity: .6, 
			    color: '#fff',
				'z-index' : 200001
			}
	}
}

function submitHiddenForm(b,e){
	var a=$("#_hidden_iframe_");
	if(!a[0]){
		a=$('<iframe id="_hidden_iframe_" name="_hidden_iframe_" style="display: none;"></iframe>');
		$("body").append(a)
	}
	var d=$("#_hidden_form_");
	if(!d[0]){
		d=$('<form method="post" id="_hidden_form_" target="_hidden_iframe_" style="display: none;"></form>');
		$("body").append(d)
	}
	d.empty();
	d.attr("action",b);
	for(var c in e){
		if(e.hasOwnProperty(c)){
			$('<input type="hidden">').attr("name",c).attr("value",e[c]).appendTo(d)
		}
	}
	d.submit();
}

//????????????(????????????,?????????)
function capture(captureObj,file_name) {
	html2canvas($(captureObj), {
		//allowTaint: true,
		//taintTest: false,
		useCORS: true,
		//proxy: '/etc/proxy_image',
		onrendered: function(canvas) {
			var image = canvas.toDataURL();
			submitHiddenForm("/etc/bypass_image", { image : image, filename:file_name+".png"});
		}
	});
}

function popOpen(url, title, width, height) {
	var w = width; // ????????? ??????
	var h = height; // ????????? ??????
	var winl = (screen.width - w) / 2;
	var wint = (screen.height - h) / 2;
	var settings = 'height=' + h + ',';
	settings += 'width=' + w + ',';
	settings += 'top=' + wint + ',';
	settings += 'left=' + winl + ',';
	settings += 'scrollbars=yes,';
	settings += 'resizable=yes';
	window.open(url, title, settings);
}

function twtLink(){
	var shortUrl = shorturl(location.href);
	var title = encodeURIComponent($("title").text());
	window.open("https://twitter.com/intent/tweet?text=" + encodeURIComponent("[CMS??????]") + title + ":" + "&url=" + shortUrl);
}

function fbLink(){
	var title = encodeURIComponent($("title").text());
	window.open("https://www.facebook.com/sharer/sharer.php?u=" + encodeURIComponent(location.href));
}
function ksLink(){
	var title = $("title").text();
	var shortUrl = shorturl(location.href);
	Kakao.Story.share({
		url: shortUrl,
		text: $("title").text()
	});
}

function shorturl(url){
	var rst = url;
	$.ajax({
		type : "POST",
		url : "/shorturl.do",
		async: false,
		data : {
			longUrl : encodeURIComponent(url),
			login : "o_3qojukp8ip",
			apiKey : "R_c52d594730d94c058959c1e12efa17da",
			format : "xml"
		},
		dataType : "text",
		success : function(transUrl){
			rst = transUrl;
		}
	});	
	return rst;
}
function copyLink(){
	window.prompt('????????? URL??? ???????????? ??????????????? ????????????.', location.href);
}

function capLock(e){
	var keyCode = 0;
	var shiftKey = false;
	keyCode = e.keyCode;
	shiftKey = e.shiftKey;
	if (((keyCode >= 65 && keyCode <= 90) && !shiftKey)	|| ((keyCode >= 97 && keyCode <= 122) && shiftKey)) {
		if($('#capslock').is(":visible")==false){
			$('#capslock').show(100).delay( 2800 ).hide(100);
		}
	}
}

function fileSizeCheck(id, limit){
	var iSize = 0;
	if (!!$.browser.msie && $.browser.version<10) {
		var objFSO;
		try{
			objFSO = new ActiveXObject("Scripting.FileSystemObject");
		}catch(event){
			alert("ie10?????? ???????????? ???????????? ????????? ?????????????????????. ????????????????????? ??????????????? ???????????? chrome ??????????????? ?????????????????? ??????????????? ????????????.");
			return false;
		}
		var sPath = $(id)[0].value;
		var objFile = objFSO.getFile(sPath);
		var iSize = objFile.size;
		iSize = iSize / 1024;
	} else {
		iSize = ($(id)[0].files[0].size / 1024);
	}
	iSize = (Math.round((iSize / 1024) * 100) / 100)
	if(iSize > limit){
		return false;
	}else{
		return true;
	}
}

(function($) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");

    $.ajaxSetup({
           beforeSend: function(xhr) {
        	if( token && header ){
        		xhr.setRequestHeader(header, token);
        		xhr.setRequestHeader("AJAX", true);
        	}
        },
        statusCode : {
            403: function() {    
              	//alert("sorry! session or csrf token invalid ...");
            	location.reload();
            }
        }
    });
})(jQuery);

if(location.href.indexOf("#currentview")>0){
//	delete window.alert;
//	delete window.location;
	window.alert = function(){};
	history.pushState(null, null, location.href);
	window.onpopstate = function(event) {
		history.go(1);
	};
}