<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<style>
  .ui-tooltip, .arrow:after {
    background: black;
    border: 2px solid white;
  }
  .ui-tooltip {
    padding: 3px 6px;
    color: white;
    border-radius: 10px;
    font: bold 12px "Helvetica Neue", Sans-Serif;
    text-transform: uppercase;
    box-shadow: 0 0 7px black;
  }
  .arrow {
    width: 70px;
    height: 16px;
    overflow: hidden;
    position: absolute;
    left: 50%;
    margin-left: -35px;
    bottom: -16px;
  }
  .arrow.top {
    top: -16px;
    bottom: auto;
  }
  .arrow.left {
    left: 20%;
  }
  .arrow:after {
    content: "";
    position: absolute;
    left: 20px;
    top: -20px;
    width: 25px;
    height: 25px;
    box-shadow: 6px 5px 9px -9px black;
    -webkit-transform: rotate(45deg);
    -ms-transform: rotate(45deg);
    transform: rotate(45deg);
  }
  .arrow.top:after {
    bottom: -20px;
    top: auto;
  }
  
</style>
<script type="text/javascript" src="/lib/js/jquery.mc_filter.js"></script>
<script type="text/javascript">
$(function(){
	$.ajaxSetup ({
		cache: false
	});

	$.blockUI.defaults = {
			message : "<img src='/images/common/ajax-loader.gif' alt='로딩중...'/> 페이지 로딩중입니다.",
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
	
	
	sns_box();
	write_field();
	comment_list(9999, 1);
	
	$(".sub_contents").tooltip({
      position: {
          my: "center bottom-20",
          at: "center top",
          using: function( position, feedback ) {
            $( this ).css( position );
            $( "<div>" )
              .addClass( "arrow" )
              .addClass( feedback.vertical )
              .addClass( feedback.horizontal )
              .appendTo( this );
          }
        }
	});
	
	$(document).on("click", ".comment_wrap textarea,#comment_list textarea", function(){
		if($("#comment_target").val() == "U"){
			if("${empty member}"=="true"){
				alert("사용자 로그인이 필요합니다.");
				$(this).blur();
			}
		}
	})
});
function comment_list(rows, page){
	$("#comment_list").load("/comment_list.do?cms_menu_seq=${param.cms_menu_seq}&article_seq=${param.article_seq }&rows="+rows+"&cpage="+page, function(){
		$(".re_insert, .modify_form").textlimit({
			count_e : '.count_box'
		});
	});
}
function sns_box(){
	$("#sns_box").load("/comments/sns_box.do");
}
function write_field(){
	$("#write_field").load("/comments/write_field.do", function(){
		$(".comment_insert").textlimit({
			count_e : '.count_box'
		});
	});
}

function comment_reg(event){
	event.preventDefault();
	var params = {};
	$.extend(params, $("#commentFrm").serializeObject());
	$.extend(params, {
		url : shorturl(location.href)
	});

	$("#write_field").block();
	var promise = null;
	var promise0 = getSyncJSON("/filter/check.do", params);
	promise0.then(function(data){
		if(data.clean!="Y" && data.textList.length>0){
			alert("내용에 비속어가 포함되어있습니다.\n("+data.textList+")");
			return false;
		}else{
			promise = getJSON("/comment_reg.do", params);
			promise.then(function(data){
				if(data.rst == "-1"){
					alert(data.msg);
				}else{
					$("textarea[name='conts']").val('');
					comment_list(10, 1);
				}
			});
		}
	});

	$.when(promise0, promise).done(function(){
		setTimeout(function(){$("#write_field").unblock()}, 500);
	});
}

function re_comment_reg(event, seq){
	event.preventDefault();
	var params = {};
	$.extend(params, $("#commentFrm").serializeObject());
	$.extend(params, {
		conts : $("#re_comment_"+seq).find("textarea[name='conts']").val(),
		parent_seq : seq
	});
	if(params.conts == ""){
		alert("글을 입력하여 주시기 바랍니다.");
		return false;
	}

	$(".re_insert").block();
	var promise = null;
	var promise0 = getSyncJSON("/filter/check.do", params);
	promise0.then(function(data){
		if(data.clean!="Y" && data.textList.length>0){
			alert("내용에 비속어가 포함되어있습니다.\n("+data.textList+")");
			return false;
		}else{
			promise = getJSON("/re_comment_reg.do", params);
			promise.then(function(data){
				if(data.rst == "-1"){
					alert(data.msg);
				}else{
					$("textarea[name='conts']").val('');
					comment_list(10, 1);
				}
			});
		}
	});

	$.when(promise0, promise).done(function(){
		setTimeout(function(){$(".re_insert").unblock()}, 500);
	});
}

function twtlogin(){
	window.open('/twitter.do', 'twtlogin', 'width=850, height=650, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
}
function facelogin(){
	window.open('/facebook.do', 'twtlogin', 'width=850, height=650, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
}
function navlogin(){
	window.open('/naver.do', 'twtlogin', 'width=850, height=650, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
}
function kaologin(){
	window.open('/kakao.do', 'twtlogin', 'width=850, height=650, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
}
function googlelogin(){ 
	window.open('/google.do', 'twtlogin', 'width=850, height=650, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
}
function instalogin(){ 
	window.open('/insta.do', 'twtlogin', 'width=850, height=650, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
}
function updateAccount(){
	write_field();
	sns_box();
	comment_list(10, 1);
}

function reComment(event, seq){
	event.preventDefault();
	$("[id^=re_comment_]").hide();
	$("#re_comment_"+seq).show();
}

function modifyComment(event, o, seq){
	event.preventDefault();
	$(o).closest("ul").find(".comment_body").show();
	$(o).closest("ul").find("div.modify_form").hide();
	$(o).closest("li.comment_line").find(".comment_body").hide();
	$(o).closest("li.comment_line").find("div.modify_form").show();
}

function cancelModify(event, o){
	event.preventDefault();
	$(o).closest("li.comment_line").find(".comment_body").show();
	$(o).closest("li.comment_line").find("div.modify_form").hide();
}

function modifyCommentProc(event, o, seq){
	var val = $.trim($(o).closest("li.comment_line").find("div.modify_form textarea").val());
	if(val==""){
		alert("내용을 입력하여 주시기 바랍니다.")
		return;
	}
	event.preventDefault();
	var params = {
		site_id : ${site_id },
		comment_seq : seq,
		conts : val
	};

	$(o).closest("li.comment_line").block();
	var promise = null;
	var promise0 = getSyncJSON("/filter/check.do", params);
	promise0.then(function(data){
		if(data.clean!="Y" && data.textList.length>0){
			alert("내용에 비속어가 포함되어있습니다.\n("+data.textList+")");
			return false;
		}else{
			promise = getJSON("/comment_mod.do", params);
			promise.then(function(data){
				if(data.rst == "-1"){
					alert(data.msg);
				}else if(data.rst == "0"){
					alert("실패");
				}else{
					comment_list(10, 1);
				}
			});
		}
	});

	$.when(promise0, promise).done(function(){
		setTimeout(function(){$(o).closest("li.comment_line").unblock()}, 500);
	});
	
}

function deleteComment(event, seq){
	event.preventDefault();
	if(!confirm("삭제하시겠습니까?")) return false;
	
	$.getJSON('/comment_del.do', {comment_seq:seq}, function(data){
		if(data.rst == '1'){
			comment_list(10, 1);
		}
	})
}
</script>
<div class="comment_wrap">
	<form id="commentFrm" name="commentFrm" method="post">
	<sec:csrfInput />
	<input type="hidden" name="site_id" value="${site_id }">
	<input type="hidden" name="cms_menu_seq" value="${param.cms_menu_seq }">
	<input type="hidden" name="article_seq" value="${param.article_seq }">
	<input type="hidden" name="board_seq" value="${boardInfo.board_seq }">
	<input type="hidden" id="comment_target" name="comment_target" value="${param.comment_target }">
	
	<div id="write_field"></div>
	<p class="comment_cnt">전체댓글수 <span id="total_count">0</span></p>
	
	</form>
</div>

<div id="comment_list"></div> <!-- 코멘트  -->


