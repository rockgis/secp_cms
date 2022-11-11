<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
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
$(document).ready(function(){	
	/* CCL Change */
	$(".ccl").hide();
	$("#ccltype").show();
	
	/* NURI Change */
	$(".nuri").hide();
	$("#nuritype").show();
});
</script>

<script type="text/javascript">
var contextPath = "<c:url value='/'/>".replace(/\/$/, "");
$(function(){
	$(".globalEditor").mcEditor({
		width : '99%',
		onLoad : function(){
			$(".globalEditor").trigger("FOCUS");
		}
	});

	$("#wFrm").validate({
		ignore: ':hidden',
        onkeyup: false,
        onfocusout: false,
        onclick: false,
        submitHandler : function(f){
			var member = "${sessionScope.member}";
			if (!/^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*()`~+=-_]).*$/.test($("#password").val()) && member === "") {
				alert("비밀번호는 영문, 숫자, 특수문자 포함 8글자 이상 20글자 이하로 입력하세요.");
				$("#password").focus();
				return false;
			}

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
        		rangelength : [1,256],
            	required: true
            },
            member_nm :{
            	rangelength : [1,16],
            	required: true
            },
            password :{
            	rangelength : [8,20],
            	required: true
            },
            conts :{
            	required: true
            }
        }, messages: {
        	title :{
            	required: '*제목을 입력하세요',
            	rangelength: $.validator.format("제목은 최소 {0}글자 이상 {1}글자 이하로 입력하세요.")
            },
            member_nm :{
            	required: '*이름을 입력하세요',
            	rangelength: $.validator.format("이름은 최소 {0}글자 이상 {1}글자 이하로 입력하세요.")
            },
            password: {
        		required : '*비밀번호를 입력하세요.',
				rangelength: $.validator.format("비밀번호는 영문, 숫자, 특수문자 포함 {0}글자 이상 {1}글자 이하로 입력하세요.")
            },
            conts :{
            	required: '*내용을 입력하세요'
            }
        }
    });
	
	/* CCL Change */
	$("input[name=ccl_type]").click(function() {
		var ccl_value = $(this).val();
		$(".ccl").hide();
		$("#ccltype"+ccl_value).show();	    
	});
	
	/* NURI Change */
	$("input[name=nuri_type]").click(function() {
		var nuri_value = $(this).val();
		$(".nuri").hide();
		$("#nuritype"+nuri_value).show();	    
	});
	
	$("input[name=tag_names]").keyup(function(e) {
		if(e.keyCode==8){
			return;
		}
		var rst = [];
        var list = $(this).val().split(",");
        $.each(list, function(i, o){
        	var v = $.trim(o);
			if(v.startsWith("#")){
				rst.push(v);
			}else{
				rst.push("#"+v);
			}
		});
        if(rst.join(",")!=$(this).val()){
        	$(this).val(rst.join(","));
        }
	});
	$("input[name=tag_names]").focusin(function() {
		if($(this).val()==""){
        	$(this).val("#");
        }
	});
	$("input[name=tag_names]").focusout(function() {
		var list = $(this).val().split(",");
        var lsatVal = $.trim(list[list.length-1]);
        if(lsatVal=="" || lsatVal=="#"){
        	list.splice(list.length-1, 1);
        }
        $(this).val(list.join(","));
	});
	
});
</script>
</head>
<body>
<c:out value="${boardInfo.conts }" escapeXml="false"></c:out>

<form name="wFrm" id="wFrm" action="insert.do" method="post" enctype="multipart/form-data" >
<sec:csrfInput />
<double-submit:preventer/>
<input type="hidden" name="file_yn" value="${boardInfo.file_yn }"/>
<input type="hidden" name="file_limit" value="${boardInfo.file_limit }"/>
<input type="hidden" name="limit_file_size" value="${boardInfo.limit_file_size }"/>

<input type="hidden" name="filter_yn" value="${boardInfo.filter_yn }"/>
<%-- <c:if test="${boardInfo.filter_yn == 'Y'}"> --%>
<%-- <div id="filter_result" style="display:none;"></div>
<input type="hidden" name="editor_name" value=".input_1,#ckeditor"/>
<input type="hidden" name="jumin_yn" value="${boardInfo.jumin_yn }"/> 
<input type="hidden" name="busino_yn" value="${boardInfo.busino_yn }"/>
<input type="hidden" name="bubino_yn" value="${boardInfo.bubino_yn }"/>
<input type="hidden" name="email_yn" value="${boardInfo.email_yn }"/>
<input type="hidden" name="cell_yn" value="${boardInfo.cell_yn }"/>
<input type="hidden" name="tel_yn" value="${boardInfo.tel_yn }"/>
<input type="hidden" name="card_yn" value="${boardInfo.card_yn }"/> --%>
<%-- </c:if> --%>

	<p><b class="essential">＊</b>표시는 필수 입력 입니다.</p>
	<table class="board_write">
		<caption>
			<strong>${boardInfo.title } 글등록</strong>
			<p>제목, 이름, 비밀번호, 내용(2000자 입력가능), 첨부파일, CCL, 공공누리, 태그 입력을 통해 글을 등록할 수 있습니다.</p>
		</caption>
		<colgroup>
			<col style="width:13%;"/>
			<col style="width:32%;"/>
			<col style="width:18%;"/>
			<col style="width:32%;"/>
		</colgroup>
		<tbody>
		<tr>
			<th scope="row"><label for="title">제목 <b>*</b></label></th>
			<td colspan="3"><input type="text" id="title" name="title"/></td>
		</tr>
		<c:if test="${sessionScope.member == null }">
		<tr>
			<th scope="row"><label for="member_nm">이름 <b>*</b></label></th>
			<td><input type="text" id="member_nm" name="member_nm"/></td>
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
		<c:if test="${boardInfo.cat_yn == 'Y' }">
		<tr>
			<th scope="row"><label for="cat">카테고리</label></th>
			<td colspan="3">
				<p>
					<select id="cat" name="cat" class="select_1 ws_1">
						<c:forEach var="item" items="${cat }" varStatus="i">
							<option value="${item.board_cat_seq }"<c:if test="${i.count == 1}"> selected="selected"</c:if>>${item.cat_nm }</option>
						</c:forEach>
					</select>
				</p>
			</td>
		</tr>
		</c:if>
		<tr>
			<th scope="row" class="contents">내용 <b>*</b><br /><span>(2000자 입력가능)</span></th>
			<td colspan="3"><textarea name="conts" style="width:100%;height:350px;" class="${boardInfo.editor_yn == 'Y' ? 'globalEditor' : ''}" title="내용 입력"></textarea></td>
		</tr>
		<c:if test="${boardInfo.file_yn == 'Y' }">
		<tr class="lst">
			<th scope="row"><label for="file">첨부파일</label></th>
			<td id="fileList" colspan="3">
				<div id="file1">
					<input type="file" id="file" name="attach" style="margin-bottom:5px;" title="첨부파일1"/>
					<a href="javascript:fileListAdd()"><img src="/images/board/add_btn.gif" alt="추가"/></a>
				</div>
			</td>
		</tr>
		</c:if>
		
		<c:if test="${boardInfo.cclnuri_yn == 'C' or boardInfo.cclnuri_yn == 'A' }">
		<tr>
			<th>CCL</th>
			<td colspan="3">
				<ol class="select ccl_nuri">
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value="" checked="checked"/><span alt="" style="display:block; padding:6px 6px; color:#fff; background:#abb1aa; border-radius:3px; border:solid 1px #999;">없 음</span></label></li>
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value="1" /><img src="/images/container/ccl_1.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value="2" /><img src="/images/container/ccl_2.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value="3" /><img src="/images/container/ccl_3.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value="4" /><img src="/images/container/ccl_4.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value="5" /><img src="/images/container/ccl_5.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value="6" /><img src="/images/container/ccl_6.png" alt="" style="display:block;" /></label></li>
				</ol>
				<div style="margin-top:5px; color:#ff7a1a; font-weight:600;">
					<div id="ccltype"  class="ccl" style ="display:none">라이선스를 적용하지 않습니다.</div>
					<div id="ccltype1" class="ccl" style ="display:none">저작자표시 4.0 국제</div>
					<div id="ccltype2" class="ccl" style ="display:none">저작자표시-변경금지 4.0 국제</div>
					<div id="ccltype3" class="ccl" style ="display:none">저작자표시-동일조건변경허락 4.0 국제</div>
					<div id="ccltype4" class="ccl" style ="display:none">저작자표시-비영리 4.0 국제</div>
					<div id="ccltype5" class="ccl" style ="display:none">저작자표시-비영리-변경금지 4.0 국제</div>
					<div id="ccltype6" class="ccl" style ="display:none">저작자표시-비영리-동일조건변경허락 4.0 국제</div>
				</div>
			</td>
		</tr>
		</c:if>
		<c:if test="${boardInfo.cclnuri_yn == 'P' or boardInfo.cclnuri_yn == 'A' }">
		<tr>
			<th>공공누리</th>
			<td colspan="3">
				<ol class="select ccl_nuri">
					<li><label><input type="radio" id="nuri_type" name="nuri_type" value="" checked="checked"/><span alt="" style="display:block; padding:6px 6px; color:#fff; background:#abb1aa; border-radius:3px; border:solid 1px #999;">없 음</span></label></li>
					<li><label><input type="radio" id="nuri_type" name="nuri_type" value="1" /><img src="/images/container/nuri_1.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="nuri_type" name="nuri_type" value="2" /><img src="/images/container/nuri_2.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="nuri_type" name="nuri_type" value="3" /><img src="/images/container/nuri_3.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="nuri_type" name="nuri_type" value="4" /><img src="/images/container/nuri_4.png" alt="" style="display:block;" /></label></li>
				</ol>
				<div style="margin-top:5px; color:#ff7a1a; font-weight:600;">
					<div id="nuritype"  class="nuri" style ="display:none">라이선스를 적용하지 않습니다.</div>
					<div id="nuritype1" class="nuri" style ="display:none">출처표시 / 상업적, 비상업적 이용가능 / 변형 등 2차적 저작물 작성 가능</div>
					<div id="nuritype2" class="nuri" style ="display:none">출처표시 / 비상업적 이용만 가능 / 변형 등 2차적 저작물 작성 가능</div>
					<div id="nuritype3" class="nuri" style ="display:none">출처표시 / 상업적, 비상업적 이용가능 / 변형 등 2차적 저작물 작성금지</div>
					<div id="nuritype4" class="nuri" style ="display:none">출처표시 / 비상업적 이용만 가능 / 변형 등 2차적 저작물 작성 금지</div>
				</div>
			</td>
		</tr>
		</c:if>
		<c:if test="${boardInfo.tag_yn == 'Y' }">
		<tr>
			<th>태그</th>
			<td colspan="3">
				<input type="text" class="normal" style="width:100%;" id="tag_names" name="tag_names" tagnames/>
				<p style="margin-top:5px;color:#555; letter-spacing:-1px;">※ 태그 작성시 , 로 구분 해야 합니다(#태그1,#태그2,#태그3).</p>
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