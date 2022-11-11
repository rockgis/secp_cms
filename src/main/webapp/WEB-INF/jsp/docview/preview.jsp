<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="robots" content="noindex,nofollow"/>
<title>MC@CMS 미리보기</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" type="text/css" href="${context_path }/lib/css/common.css" media="all" />
<link rel="stylesheet" type="text/css" href="${context_path }/lib/css/main.css" media="all" />
<link rel="stylesheet" type="text/css" href="${context_path }/lib/css/sub.css" media="all" />
<link rel="stylesheet" type="text/css" href="${context_path }/lib/css/article.css" media="all" />
<link rel="stylesheet" href="<c:url value="/lib/css/preview.css"/>" type="text/css" />
<script type="text/javascript" src="<c:url value="/lib/js/jquery-3.5.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery-migrate-1.4.1.min.js"/>"></script>
<script type="text/javascript" src="${context_path }/lib/js/jquery.blockUI.js"></script>
<script type="text/javascript">
var viewer;
$(function(){
	viewer = new Preview();
	viewer.goPage(1);
	
	$("#page_num").on("keypress", function(e){
		if(e.keyCode === 13){
			viewer.directPage();
		}
	})
});

var Preview = function(){
	this.num_page = 2;
	this.current = null;
	this.total = "${item.page_count }"	//총 페이지수
	this.goPage = function(page){
		page = Number(page)==0?1:Number(page);
		if(page <= 0 || page > this.total){
			alert("페이지 범위를 벗어났습니다.");
			return false;
		}
		$.blockUI({
			css: { 
	            border: 'none', 
	            padding: '15px', 
	            backgroundColor: '#000', 
	            '-webkit-border-radius': '10px', 
	            '-moz-border-radius': '10px', 
	            opacity: .5, 
	            color: '#fff' 
        	},
        	message : '페이지를 불러오는 중입니다.'
		});
		
		this.current = page;
		if(this.num_page == 1){
			$(".e_content00 img").attr("src", "${context_path}/docview/page.do?path=${item.yyyy}/${item.mm}/${item.uuid}&extenstion=${item.extenstion}&page="+page).attr("alt", page + "번째 이미지");

			$(".e_content00 img").load(function(){
				$.unblockUI();
			});
		}else{
			if(page%2==0){
				page--;
			}
			if(page==0){	//페이지없음
				$(".e_content01 img").attr("src", "${context_path}/images/common/nopage.png").attr("alt", "페이지 없음");
			}else{
				$(".e_content01 img").attr("src", "${context_path}/docview/page.do?path=${item.yyyy}/${item.mm}/${item.uuid}&extenstion=${item.extenstion}&page="+page).attr("alt", page + "번째 이미지");
			}
			if(page==this.total){
				$(".e_content02 img").attr("src", "${context_path}/images/common/nopage.png").attr("alt", "페이지 없음");
			}else{
				$(".e_content02 img").attr("src", "${context_path}/docview/page.do?path=${item.yyyy}/${item.mm}/${item.uuid}&extenstion=${item.extenstion}&page="+(page+1)).attr("alt", (page+1) + "번째 이미지");
			}

			var promise1 = this.onload1();
			var promise2 = this.onload2();
			$.when(promise1, promise2).done($.unblockUI);
		}
		$("#page_num").val(this.current);
	};
	this.onload1 = function(){
		var deferred = $.Deferred();
		$(".e_content01 img").load(function(){
			deferred.resolve();
		});
		return deferred.promise();
	};
	this.onload2 = function(){
		var deferred = $.Deferred();
		$(".e_content02 img").load(function(){
			deferred.resolve();
		});
		return deferred.promise();
	};
	this.prev = function(){
		var page = this.current-this.num_page<1?1:this.current-this.num_page;
		this.goPage(page);
	};
	this.next = function(){
		var page = this.current+this.num_page>this.total?this.total:this.current+this.num_page;
		this.goPage(page);
	};
	this.directPage = function(){
		this.goPage($("#page_num").val());
	};
	this.setNumPage = function(n){
		this.num_page = Number(n);
		if(this.num_page==1){
			$(".e_content00").show();
			$(".e_content01, .e_content02").hide();
		}else{
			$(".e_content00").hide();
			$(".e_content01, .e_content02").show();
		}
		this.goPage(this.current);
	};
	if($(window).width() <= 750){
		this.setNumPage(1);
	}
}

var Browser = { a : navigator.userAgent.toLowerCase() }

Browser = {
        ie : /*@cc_on true || @*/ false,
        ie6 : Browser.a.indexOf('msie 6') != -1,
        ie7 : Browser.a.indexOf('msie 7') != -1,
        ie8 : Browser.a.indexOf('msie 8') != -1,
        opera : !!window.opera,
        safari : Browser.a.indexOf('safari') != -1,
        safari3 : Browser.a.indexOf('applewebkit/5') != -1,
        mac : Browser.a.indexOf('mac') != -1,
        chrome : Browser.a.indexOf('chrome') != -1,
        firefox : Browser.a.indexOf('firefox') != -1
    }


// 기본 Zoom
var nowZoom = 100;
// 최대 Zoom
var maxZoom = 200;
// 최소 Zoom
var minZoom = 80;

// 화면크기 확대
var jsBrowseSizeUp = function() {
    
    if( Browser.chrome ) {
        if( nowZoom < maxZoom ) {
            nowZoom += 10; // 10 = 25%씩 증가
            document.body.style.zoom = nowZoom + "%";
        }
        else{
            alert('최대 확대입니다.');
        }
    }
    else if( Browser.opera ) {
        alert('오페라는 화면크기 기능을 지원하지 않습니다.\n브라우저 내의 확대/축소 기능을 이용하시기 바랍니다.');
    }
    else if( Browser.safari || Browser.safari3 || Browser.mac ) {
        alert('사파리, 맥은 화면크기 기능을 지원하지 않습니다.\n브라우저 내의 확대/축소 기능을 이용하시기 바랍니다.');
    }
    else if( Browser.firefox ) {
        alert('파이어폭스는 화면크기 기능을 지원하지 않습니다.\n브라우저 내의 확대/축소 기능을 이용하시기 바랍니다.');
    }
    else {
        if( nowZoom < maxZoom ) {
            nowZoom += 10; //10 = 25%씩 증가
            document.body.style.position = "relative";
            document.body.style.zoom = nowZoom + "%";
        }
        else{
            alert('최대 확대입니다.');
        }
    }
};

// 화면크기 축소
var jsBrowseSizeDown = function() {
    
    if( Browser.chrome ) {
        if( nowZoom < maxZoom ) {
            nowZoom -= 10; // 10 = 25%씩 증가
            document.body.style.zoom = nowZoom + "%";
        }
        else{
            alert('최대 확대입니다.');
        }
    }
    else if( Browser.opera ) {
        alert('오페라는 화면크기 기능을 지원하지 않습니다.\n브라우저 내의 확대/축소 기능을 이용하시기 바랍니다.');
    }
    else if( Browser.safari || Browser.safari3 || Browser.mac  ) {
        alert('사파리, 맥은 화면크기 기능을 지원하지 않습니다.\n브라우저 내의 확대/축소 기능을 이용하시기 바랍니다.');
    }
    else if( Browser.firefox ) {
        alert('파이어폭스는 화면크기 기능을 지원하지 않습니다.\n브라우저 내의 확대/축소 기능을 이용하시기 바랍니다.');
    }
    else {
        if( nowZoom < maxZoom ) {
            nowZoom -= 10; //10 = 25%씩 증가
            document.body.style.position = "relative";
            document.body.style.zoom = nowZoom + "%";
        }
        else{
            alert('최대 확대입니다.');
        }
    }
};

// 화면크기 원래대로(100%)
var jsBrowseSizeDefault = function() {
    
    nowZoom = 100;
    document.body.style.zoom = nowZoom + "%";
};

</script>

<style type="text/css">
.ebook_bottom{overflow: hidden;}
.ebook_content img{width: 100%;}
.e_content01{float:left; width: 50%; max-width:900px;}
.e_content02{float:right; width:50%; max-width:900px;}
</style>
</head>
<body>     
     <div class="ebook_wrap">
     <div class="ebook_wrap01">
     	<div class="ebook_top">
     	<div class="ebook_top01">
     		<div class="ebook_title">
     			<span><img src="${context_path }/images/preview/view_icon.gif" alt="pdf" /></span>
     			<input type="text" value="${item.attach_nm}"/>
     		</div>
     		
     		<div class="ebook_page">
     			<span>Page</span>
     			<a href="javascript:viewer.prev();"><img src="${context_path }/images/preview/e_left_page.gif" alt="이전페이지" /></a><a href="javascript:viewer.next();"><img src="${context_path }/images/preview/e_right_page.gif" alt="다음페이지" /></a>
     			
     			<input type="text" class="page_t" id="page_num"/><span class="ebook_t">/ ${item.page_count }</span>
     			<a href="javascript:viewer.directPage();"><img src="${context_path }/images/preview/e_move_btn.gif" alt="이동" /></a>
     		</div>
     		
     		<div class="ebook_zoom">
     			<span class="ebook_t">Zoom</span>
     			<a href="javascript:jsBrowseSizeUp();"><img src="${context_path }/images/preview/viewer_plus.gif" alt="확대하기" /></a><a href="javascript:jsBrowseSizeDown();"><img src="${context_path }/images/preview/viewer_minus.gif" alt="축소하기" /></a>     			
     		</div>
     		
     		<div class="ebook_dwn">
     			<a href="${context_path }/download.do?uuid=${item.uuid}"><img src="${context_path }/images/preview/view_download.gif" alt="원본 다운로드" /></a>
     			<a href="javascript:window.print();"><img src="${context_path }/images/preview/view_print.gif" alt="인쇄하기" /></a>
     		</div>
     		
     		<div class="ebook_size">
     			<span><a href="javascript:viewer.setNumPage(1);">1쪽</a> ｜ </span>
     			<span><a href="javascript:viewer.setNumPage(2);">2쪽</a></span>
     		</div>
     		</div>
     		<p><a href="javascript:self.close();"><img src="${context_path }/images/preview/view_close.gif" alt="닫기" /></a></p>
     	</div>
     	</div>
     	
     	<div class="ebook_bottom">	
	     	<div class="ebook_content">
	     		<div class="e_content00" style="display: none;"><img src="${context_path }/images/common/no_image.gif" alt="임시" /></div>
	     		<div class="e_content01"><img src="${context_path }/images/common/nopage.png" alt="임시" /></div>
	     		<div class="e_content02"><img src="${context_path }/images/common/nopage.png" alt="임시" /></div>
	     	</div>
	     	<span class="page_left"><a href="javascript:viewer.prev();"><img src="${context_path }/images/preview/e_left_btn.png" alt="이전페이지"/></a></span>
   			<span class="page_right"><a href="javascript:viewer.next();"><img src="${context_path }/images/preview/e_right_btn.png" alt="다음페이지"/></a></span>
	    </div>
    </div>
</body>
</html>