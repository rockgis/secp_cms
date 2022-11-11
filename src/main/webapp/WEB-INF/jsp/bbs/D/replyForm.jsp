<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<c:set var="view" value="${data }"/>
<html>
<head>
<meta name="robots" content="noindex,nofollow">
<script type="text/javascript" src="<c:url value="/lib/js/bbs.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.mc_editor.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.mc_filter.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/validation/jquery.validate.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/validation/additional-methods.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/validation/messages_ko.js"/>"></script>
<script type="text/javascript">
var contextPath = "<c:url value='/'/>".replace(/\/$/, "");
$(function(){
	$(".globalEditor").mcEditor({
		width : '99%'
	});

	$("#wFrm").validate({
		ignore: ':hidden',
        onkeyup: false,
        onfocusout: false,
        onclick: false,
        submitHandler : function(f){
        	if(f.file_yn.value == 'Y'){
    			var fileLimit = f.file_limit.value;
    			if(fileLimit != "N"){
    				var selectFileLimit = 0;
    				$("input[name=attach]").each(function(){
    					if($(this).val() != ""){
    						selectFileLimit++;
    					}
    				});
    				var oldFileLimit = $("input[name=delattach]").length;
    				var oldFileDelLimit = $("input[name=delattach]:checked").length;
    				var totalFile = 0;
    				totalFile = oldFileLimit - oldFileDelLimit + selectFileLimit;
    				if((fileLimit >= totalFile) == false){
    					alert("제한된 파일의 갯수를 초과하였습니다.\n제한된 파일 갯수는 "+fileLimit+"개 입니다.");
    					return false;
    				}
    			}
    		}
    		if($("#thumb").size()>0){
    			var img_array = $(editor[0].getHtmlData()).find('img');
    			f.thumb.value = "";
    			var domain = location.origin;
    			$.each(img_array, function(idx){
    				if(f.thumb.value != "") return;
    				if(this.src.indexOf(domain) == -1) return;
    				f.thumb.value = this.src.substring(domain.length);
    				return false;
    			});
    		}
    		
    		$("#wFrm").mcFilter({menu_seq : "${menu_seq}"}, function(f){//여기서 서브밋 시킴
    			f.submit();
    		});		
        },
        invalidHandler: function(form, validator) {
            var errors = validator.numberOfInvalids();
            if (errors) {
                alert(validator.errorList[0].message);
                validator.errorList[0].element.focus();
            }
       	},
        rules: {
        	title: {
            	required: true
            },
            member_nm :{
            	required: true
            },
            password :{
            	rangelength : [5,15],
            	required: true
            },
            conts :{
            	required: true
            }
        }, messages: {
        	title :{
            	required: '*제목을 입력하세요'
            },
            member_nm :{
            	required: '*이름을 입력하세요'
            },
            password: {
        		required : '*비밀번호를 입력하세요.',
        		rangelength: $.validator.format("비밀번호 최소 {0}글자 이상 {1}글자 이하로 입력하세요.")
            },
            conts :{
            	required: '*내용을 입력하세요'
            }
        }
    });
});
</script>
</head>
<body>
<c:out value="${boardInfo.conts }" escapeXml="false"></c:out>

<form name="wFrm" id="wFrm" action="reply.do" method="post" enctype="multipart/form-data">
<sec:csrfInput />
<double-submit:preventer/>
<input type="hidden" name="ref_num" value="${view.ref_num }"/>
<input type="hidden" name="step_num" value="${view.step_num }"/>
<input type="hidden" name="depth_num" value="${view.depth_num }"/>
<input type="hidden" name="file_yn" value="${boardInfo.file_yn }"/>
<input type="hidden" name="file_limit" value="${boardInfo.file_limit }"/>
<input type="hidden" name="limit_file_size" value="${boardInfo.limit_file_size }"/>

<input type="hidden" name="filter_yn" value="${boardInfo.filter_yn }"/>
<%-- <c:if test="${boardInfo.filter_yn == 'Y'}"> --%>
<%-- <div id="filter_result" style="display:none;"></div>
<input type="hidden" name="jumin_yn" value="${boardInfo.jumin_yn }"/> 
<input type="hidden" name="busino_yn" value="${boardInfo.busino_yn }"/>
<input type="hidden" name="bubino_yn" value="${boardInfo.bubino_yn }"/>
<input type="hidden" name="email_yn" value="${boardInfo.email_yn }"/>
<input type="hidden" name="cell_yn" value="${boardInfo.cell_yn }"/>
<input type="hidden" name="tel_yn" value="${boardInfo.tel_yn }"/>
<input type="hidden" name="card_yn" value="${boardInfo.card_yn }"/> --%>
<%-- </c:if> --%>

<c:if test="${view.cat != null }">
<input type="hidden" name="cat" value="${view.cat }"/>
</c:if>

	<p><b class="essential">＊</b>표시는 필수 입력 입니다.</p>
	<table class="board_write">
		<caption>
			<strong>${boardInfo.title } 답글 등록</strong>
			<p>제목, 이름, 비밀번호, 내용(2000자 입력가능), 첨부파일 입력을 통해 답글을 등록할 수 있습니다.</p>
		</caption>
		<colgroup>		
			<col style="width:18%;"/>
			<col style="width:32%;"/>
			<col style="width:18%;"/>
			<col style="width:32%;"/>
		</colgroup>
		<tbody>
		<tr>
			<th scope="row"><label for="title">제목 <b>*</b></label></th>
			<td colspan="3"><input type="text" id="title" name="title" value="Re:${view.title }"/></td>
		</tr>
		<c:if test="${sessionScope.member == null }">
		<tr>
			<th scope="row"><label for="member_nm">이름 <b>*</b></label></th>
			<td><input type="text" id="member_nm" name="member_nm"></td>
			<th scope="row"><label for="password">비밀번호 <b>*</b></label></th>
		 	<td><input type="password" id="password" name="password" autocomplete="off"/></td>
		</tr>
		</c:if>
		<c:if test="${boardInfo.public_yn != 'Y' }">
		<tr>
			<th scope="row"><label for="public_yn">비밀글</label></th>
			<td colspan="3">
				<ol class="select">
					<c:if test="${boardInfo.public_yn == 'N' }">
						<li class="first"><label for="public_y"><input type="radio" id="public_y" checked="checked" name="public_yn" value="Y"/> 공개</label></li>
						<li><label for="public_n"><input type="radio" id="public_n" name="public_yn" value="N"/> 비공개</label></li>
					</c:if>
					<c:if test="${boardInfo.public_yn == 'X' }">						
						<li class="first"><label for="public_n"><input type="radio" id="public_n" checked="checked" name="public_yn" value="N" /> 비공개</label></li>
					</c:if>
				</ol>
			</td>
		</tr>
		</c:if>
		<tr>
			<th scope="row" class="contents">내용 <b>*</b><br /><span>(2000자 입력가능)</span></th>
			<td colspan="3"><textarea name="conts" style="width:100%; height:350px" class="${boardInfo.editor_yn == 'Y' ? 'globalEditor' : ''}" title="내용 입력"></textarea></td>
		</tr>
		<c:if test="${boardInfo.file_yn == 'Y' }">
		<tr class="lst">
			<th scope="row"><label for="file">첨부파일</label></th>
			<td id="fileList" colspan="3">
				<div id="file1">
					<input type="file" id="file" name="attach" style="margin-bottom:5px;"/>
					<a href="javascript:fileListAdd()"><img src="/images/board/add_btn.gif" alt="추가"/></a>
				</div>
			</td>
		</tr>
		</c:if>
		</tbody>
	</table>

	<div class="btn_area">
		<div class="right">
	  		<input type="submit" value="등록"/>
	  		<a href="list.do?cpage=${param.cpage }&amp;rows=${param.rows }&amp;condition=${param.condition }&amp;keyword=${param.keyword }">취소</a>
  		</div>
	</div>
</form>
</body>
</html>