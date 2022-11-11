<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<c:set var="view" value="${data.view }"/>
<c:set var="thumbnm" value="${view.thumb }"/>
<c:set var="thumb_width" value="200"/>
<c:set var="thumb_height" value="150"/>
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
	<c:if test="${!empty view.ccl_type}">
		$(".ccl").hide();
		$("#ccltype"+"${view.ccl_type}").show();
	</c:if>
	
	/* NURI Change */
	<c:if test="${!empty view.nuri_type}">
		$(".nuri").hide();
		$("#nuritype"+"${view.nuri_type}").show();
	</c:if>
});
</script>

<script type="text/javascript">
var contextPath = "<c:url value='/'/>".replace(/\/$/, "");
$(function(){
	editor = $(".globalEditor").mcEditor({
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
    			//f.thumb.value = "";
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
            	rangelength : [5,15],
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
        		rangelength: $.validator.format("비밀번호는 최소 {0}글자 이상 {1}글자 이하로 입력하세요.")
            },
            conts :{
            	required: '*내용을 입력하세요'
            }
        }
    });
	
	
	/* 썸네일 업로드 */
	$('#thumbfile').on('change', function() {
	    
		var width = "200";
		var height = "150";
		
		var filename = $("#thumbfile").val();
		filename = filename.slice(filename.indexOf(".") + 1).toLowerCase();
		if(filename == ""){
			return false;
		}
		if($.inArray(filename, ["gif", "jpg", "jpeg", "png", "bmp"]) < 0 ){
			alert("gif, jpg, jpeg, png, bmp 파일만 올려주시기 바랍니다.");
			resetFormElement($('#thumbfile')); //전달한 양식 초기화
			return false;
		}
		/* if($scope.param.file_limit != 'N'){
			if(parseInt($scope.form.files.length) >= parseInt($scope.param.file_limit)){
				alert("최대 파일 갯수는 "+$scope.param.file_limit+"개 입니다.");
				return false;
			}			
		} */
		$("#wFrm").ajaxSubmit({
			url : '<c:url value="/ajaxThumbUpload.do"/>',
			iframe: true,
			dataType : "json",
			uploadProgress : function(event, position, total, percentComplete){
			},
			success : function(data){
				//if((parseInt(data.size)/1024/1024) >= parseInt($scope.param.limit_file_size)){
				//	alert("최대 용량을 초과하였습니다.\n최대 용량은 "+$scope.param.limit_file_size+"MB 입니다.");
				//}else{
				//$scope.addThumbFile(data);
				//}
				var thumburl = "/upload/thumb/" + data.uuid;
				var domain = location.origin;
				$("#thumb").val(thumburl);
				$('#thumb_img').attr('src', domain + thumburl);
				$('#image_preview').show(); //업로드한 이미지 미리보기 
				
			},
			error: function(e){
				alert(e.responseText);
			}
		});
	});

	/* 썸네일 삭제 */
	$('#image_preview a').bind('click', function() {
	    resetFormElement($('#thumbfile')); //전달한 양식 초기화
	    $('#thumbfile').show(); //파일 양식 보여줌
	    $(this).parent().hide(); //미리 보기 영역 감춤
	    $("#thumb").val('');
	});
	    

	/* 썸네일 초기화 */
	function resetFormElement(e) {
	    e.wrap('<form>').closest('form').get(0).reset(); 
	    e.unwrap(); //감싼 <form> 태그를 제거
	};
	
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

<form name="wFrm" id="wFrm" action="modify.do" method="post" enctype="multipart/form-data">
<sec:csrfInput />
<double-submit:preventer/>
<input type="hidden" name="article_seq" value="${view.article_seq}"/>
<input type="hidden" name="file_yn" value="${boardInfo.file_yn }"/>
<input type="hidden" name="file_limit" value="${boardInfo.file_limit }"/>
<input type="hidden" name="limit_file_size" value="${boardInfo.limit_file_size }"/>
<input type="hidden" name="thumb" id="thumb" value="${view.thumb }" style="width:500px;" />

<%-- <input type="hidden" name="filter_yn" value="${boardInfo.filter_yn }"/>
<input type="hidden" name="jumin_yn" value="${boardInfo.jumin_yn }"/> 
<input type="hidden" name="busino_yn" value="${boardInfo.busino_yn }"/>
<input type="hidden" name="bubino_yn" value="${boardInfo.bubino_yn }"/>
<input type="hidden" name="email_yn" value="${boardInfo.email_yn }"/>
<input type="hidden" name="cell_yn" value="${boardInfo.cell_yn }"/>
<input type="hidden" name="tel_yn" value="${boardInfo.tel_yn }"/>
<input type="hidden" name="card_yn" value="${boardInfo.card_yn }"/> --%>
	
	<p><b class="essential">＊</b>표시는 필수 입력 입니다.</p>
	<table class="board_write">
		<caption>
			<strong>${boardInfo.title } 글등록</strong>
			<p>제목, 이름, 비밀번호, 내용(2000자 입력가능), 썸네일이미지, 첨부파일, CCL, 공공누리, 태그 입력을 통해 글을 수정할 수 있습니다.</p>
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
			<td colspan="3"><input type="text" id="title" name="title" value="${suf:clearXSS(view.title, '')}"/></td>
		</tr>
		<c:if test="${sessionScope.member == null }">
		<tr>
			<th scope="row"><label for="member_nm">이름 <b>*</b></label></th>
			<td><input type="text" id="member_nm" name="member_nm" value="${view.reg_nm }" style="width:100px;"/></td>
		</tr>
		</c:if>
		<c:if test="${boardInfo.public_yn != 'Y' }">
		<tr>
			<th scope="row"><label for="public_yn">비밀글</label></th>
			<td colspan="3">
				<ol class="select">
					<c:if test="${boardInfo.public_yn == 'N' }">
						<li><label for="public_y"><input type="radio" id="public_y" name="public_yn" value="Y" <c:if test="${view.public_yn == 'Y' }">checked="checked"</c:if> /> 공개</label></li>
						<li><label for="public_n"><input type="radio" id="public_n" name="public_yn" value="N" <c:if test="${view.public_yn == 'N' }">checked="checked"</c:if> /> 비공개</label></li>
					</c:if>
					<c:if test="${boardInfo.public_yn == 'X' }">						
						<li class="first"><label for="public_n"><input type="radio" id="public_n" checked="checked" name="public_yn" value="N" /> 비공개</label></li>
					</c:if>					
				</ol>
			</td>
		</tr>
		</c:if>
		<c:if test="${data.cat_yn == 'Y' }">
		<tr>
			<th scope="row"><label for="cat">카테고리</label></th>
			<td colspan="3">
				<p>
					<select id="cat" name="cat">
						<c:forEach var="item" items="${cat }" varStatus="i">
							<option value="${item.board_cat_seq }"<c:if test="${item.board_cat_seq == view.cat }"> selected="selected"</c:if>>${item.cat_nm }</option>
						</c:forEach>
					</select>
				</p>
			</td>
		</tr>
		</c:if>
		<tr>
			<th scope="row" class="contents">내용 <b>*</b><br /><span>(2000자 입력가능)</span></th>
			<td colspan="3"><textarea name="conts" id="conts" style="width:100%;height:350px;" class="${boardInfo.editor_yn == 'Y' ? 'globalEditor' : ''}" title="내용입력">${view.conts }</textarea></td>
		</tr>
		
		<tr>
       		<th rowspan="2">썸네일이미지 <b>*</b></th>
       		<td colspan="3">
       			<p>※ 썸네일 이미지는 리스트페이지에 보여지는 이미지를 등록 할 수 있습니다.<br>(썸네일 이미지를 등록하지 않으면 내용에 등록된 첫번째 이미지가 자동으로 보여집니다.)</p>
       			<input type="file" name="thumbfile" id="thumbfile" title="썸네일 이미지 선택"/>
       		</td>
     	</tr>
     	<tr> 
       		<td class="tddiv" id="attach_div" colspan="3">
        		<c:if test="${!empty thumbnm }">
        		<div id="image_preview">
        			<img id="thumb_img" src="${thumbnm}" style="width:${thumb_width}px;height:${thumb_height}px;" alt="썸네일 이미지"/>
					<a href="#"><img src="<c:url value="/images/super/contents/s_btn_1.gif"/>" alt="삭제" style="vertical-align:bottom;"/></a>
				</div>
        		</c:if>
    		</td>
     	</tr>
		
		
		<c:if test="${fn:length(data.files) > 0 }">
		<tr>
			<th scope="row">기존 첨부파일</th>
			<td id="oldfileList" colspan="3">
				<ul>
				<c:forEach items="${data.files }" var="files" varStatus = "status">
					<li>${files.attach_nm} <input type="checkbox" name="delattach" value="${files.uuid }"/>삭제</li>
				</c:forEach>
				</ul>
			</td>
		</tr>
		</c:if>
		<c:if test="${boardInfo.file_yn == 'Y' }">
		<tr class="lst">
			<th scope="row"><label for="file">첨부파일</label></th>
			<td id="fileList" colspan="3">
				<div id="file1"><input type="file" id="file" name="attach" style="margin-bottom:5px;" title="첨부파일1"/> <a href="javascript:fileListAdd()"><img src="/images/board/add_btn.gif" alt="추가" /></a></div>
			</td>
		</tr>
		</c:if>
		
		<c:if test="${boardInfo.cclnuri_yn == 'C' or boardInfo.cclnuri_yn == 'A' }">
		<tr>
			<th>CCL</th>
			<td colspan="3">
				<ol class="select ccl_nuri">
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value=""  <c:if test="${view.ccl_type == '' }">checked="checked"</c:if>/><span alt="" style="display:block; padding:6px 6px; color:#fff; background:#abb1aa; border-radius:3px; border:solid 1px #999;">없 음</span></label></li>
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value="1" <c:if test="${view.ccl_type == '1' }">checked="checked"</c:if> /><img src="/images/container/ccl_1.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value="2" <c:if test="${view.ccl_type == '2' }">checked="checked"</c:if> /><img src="/images/container/ccl_2.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value="3" <c:if test="${view.ccl_type == '3' }">checked="checked"</c:if> /><img src="/images/container/ccl_3.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value="4" <c:if test="${view.ccl_type == '4' }">checked="checked"</c:if >/><img src="/images/container/ccl_4.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value="5" <c:if test="${view.ccl_type == '5' }">checked="checked"</c:if> /><img src="/images/container/ccl_5.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value="6" <c:if test="${view.ccl_type == '6' }">checked="checked"</c:if> /><img src="/images/container/ccl_6.png" alt="" style="display:block;" /></label></li>
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
					<li><label><input type="radio" id="nuri_type" name="nuri_type" value=""  <c:if test="${view.nuri_type == '' }">checked="checked"</c:if> /><span alt="" style="display:block; padding:6px 6px; color:#fff; background:#abb1aa; border-radius:3px; border:solid 1px #999;">없 음</span></label></li>
					<li><label><input type="radio" id="nuri_type" name="nuri_type" value="1" <c:if test="${view.nuri_type == '1' }">checked="checked"</c:if> /><img src="/images/container/nuri_1.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="nuri_type" name="nuri_type" value="2" <c:if test="${view.nuri_type == '2' }">checked="checked"</c:if> /><img src="/images/container/nuri_2.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="nuri_type" name="nuri_type" value="3" <c:if test="${view.nuri_type == '3' }">checked="checked"</c:if> /><img src="/images/container/nuri_3.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="nuri_type" name="nuri_type" value="4" <c:if test="${view.nuri_type == '4' }">checked="checked"</c:if> /><img src="/images/container/nuri_4.png" alt="" style="display:block;" /></label></li>
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
				<input type="text" class="normal" style="width:100%;" id="tag_names" name="tag_names" value="${view.tag_names }" tagnames/>
				<p style="margin-top:5px;color:#555; letter-spacing:-1px;">※ 태그 작성시 , 로 구분 해야 합니다.(#태그1,#태그2,#태그3)</p>
			</td>
		</tr>
		</c:if>
		
		</tbody>
	</table>

	<div class="btn_area">
		<div class="right">
	  		<input type="submit" value="수정"/>  
	  		<a href="list.do?cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }">취소</a>
  		</div>
	</div>
</form>
</body>
</html>