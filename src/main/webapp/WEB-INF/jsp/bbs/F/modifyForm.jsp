<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<c:set var="view" value="${data.view }"/>
<c:set var="cat_yn" value="N"/>
<c:set var="cat_element" value=""/>
<c:set var="title_yn" value="N"/>
<c:set var="title_element" value=""/>
<c:set var="conts_yn" value="N"/>
<c:set var="conts_element" value=""/>
<c:set var="thumb_yn" value="N"/>
<c:set var="thumbnm" value="${view.thumb }"/>
<c:set var="thumb_width" value="200"/>
<c:set var="thumb_height" value="150"/>
<c:forEach items="${custom }" var="item" varStatus="status">
	<%-- <c:if test="${item.column_name == 'cat_nm' && (fn:length(cat) != 0 || !empty cat)}">
		<c:set var="cat_yn" value="Y"/>
		<c:set var="cat_element" value="${item.element }"/>
	</c:if>
	<c:if test="${item.column_name == 'title' }">
		<c:set var="title_yn" value="Y"/>					
		<c:set var="title_element" value="${item.element }"/>
	</c:if>--%>
	<c:if test="${item.column_name == 'conts' }">
		<c:set var="conts_yn" value="Y"/>					
		<c:set var="conts_element" value="${item.element }"/>
	</c:if>
	<c:if test="${item.column_name == 'thumb' }">
		<c:set var="thumb_yn" value="Y"/>					
	</c:if>
</c:forEach>
<html>
<head>
<meta name="robots" content="noindex,nofollow">
<script type="text/javascript" src="<c:url value="/lib/js/bbs.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.mc_editor.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.mc_filter.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/jquery.ui.datepicker-ko.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/validation/jquery.validate.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/validation/additional-methods.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/validation/messages_ko.js"/>"></script>
<script type="text/javascript">
$(document).ready(function(){	
	<c:if test="${data.file_yn == 'Y'}">
	fileLimitCheck('${data.limit_file_size}');
	</c:if>
	<c:forEach items="${custom }" var="item" varStatus="status">
		<c:if test="${item.column_name == 'sdate' || item.column_name == 'edate'}">
			$("#${item.column_name}").datepicker();
		</c:if>
		<c:if test="${item.column_name == 'email'}">
			$("#email2").keyup(function(){
				emailInput($(this).val());
			});
			$("#email2").change(function(){
				emailInput($(this).val());
			});		
			$("#email2_select").change(function(){
				$("#email2").val($(this).val());
			});
		</c:if>
	</c:forEach>
	
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
	//에디터 사용 유무
	<c:if test="${boardInfo.editor_yn == 'Y'}">
	editor = $(".globalEditor").mcEditor({
		width : '99%',
		onLoad : function(){
			$(".globalEditor").trigger("FOCUS");
		}
	});
	</c:if>
	
	//전부체크
	$("#all_chk").on("change", function(){
		if($(this).prop("checked")){
			$(".chk").prop("checked", true);
		}else{
			$(".chk").prop("checked", false);
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
            },
            tel2 : {
            	number : true
            },
            tel3 : {
            	number : true
            },
            cell2 : {
            	//required: true,
            	number : true
            },
            cell3 : {
            	//required: true,
            	number : true
            },
            email1 : {
            	//required: true
            },
            email2 : {
            	//required: true
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
            },
            tel2 : {
            	required : '전화번호를 입력하여주시기 바랍니다.',
            	number : '숫자만 입력하여주시기 바랍니다.'
            },
            tel3 : {
            	required : '전화번호를 입력하여주시기 바랍니다.',
            	number : '숫자만 입력하여주시기 바랍니다.'
            },
            cell2 : {
        		required : '휴대폰번호를 입력하여주시기 바랍니다.',
            	number : '숫자만 입력하여주시기 바랍니다.'
            },
            cell3 : {
        		required : '휴대폰번호를 입력하여주시기 바랍니다.',
            	number : '숫자만 입력하여주시기 바랍니다.'
            },
            email1 : {
        		required : '이메일을 입력하여주시기 바랍니다.'
            },
            email2 : {
        		required : '이메일을 입력하여주시기 바랍니다.'
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
	}
	
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
<input type="hidden" name="thumb" id="thumb" value="${view.thumb }"/>


	<table class="board_write">
		<colgroup>
			<col width="15%"/>
			<col width="*"/>
		</colgroup>
		<tbody>
		<%-- <c:if test="${cat_yn == 'Y' }"><!-- 카테고리 필드 -->
			<tr>
				<th scope="row">${cat_element}</th>
				<td>
					<select id="cat" name="cat" class="select_1 ws_1">
						<c:forEach var="item" items="${cat }" varStatus="i">
							<option value="${item.board_cat_seq }"<c:if test="${item.board_cat_seq == view.cat}"> selected="selected"</c:if>>${item.cat_nm }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</c:if>		
		<c:if test="${title_yn == 'Y' }"><!-- 제목 필드 -->
			<tr>
				<th scope="row">${title_element }</th>
				<td><input type="text" id="title" name="title" class="input_1" value="${view.title }"/></td>
			</tr>
		</c:if> --%>
		<c:forEach items="${custom }" var="item" varStatus="status">
			<c:set var="view_yn" value="Y"/>
			<c:set var="pass_yn" value="N"/>
			<c:forEach items="${notViews }" var="notView" varStatus="notStatus">
				<c:if test="${item.column_name == notView }">
					<c:set var="view_yn" value="N"/>
				</c:if>
				<%-- <c:if test="${item.column_name == 'password' }">
					<c:set var="pass_yn" value="Y"/>
				</c:if> --%>
			</c:forEach>
			<c:if test="${view_yn == 'Y'}">
			<tr>
				<%-- <th scope="row">${pass_yn == 'Y' ? '기존 ' : ''}${item.element }</th> --%>
				<th scope="row">${item.element }</th>
				<c:choose>
					<c:when test="${item.column_name == 'cat_nm' && (fn:length(cat) != 0 || !empty cat)}">
						<td>
							<select id="cat" name="cat" class="select_1 ws_1">
								<c:forEach var="item" items="${cat }" varStatus="i">
									<option value="${item.board_cat_seq }"<c:if test="${item.board_cat_seq == view.cat}"> selected="selected"</c:if>>${item.cat_nm }</option>
								</c:forEach>
							</select>
						</td>
					</c:when>
					<%-- <c:when test="${item.column_name == 'title' }">
						<td><input type="text" id="title" name="title" class="input_1" value="${view.title }" <c:if test="${item.require_yn == 'Y' }">required</c:if> /></td>
					</c:when>
					<c:when test="${item.column_name == 'conts' }">
						<td><textarea cols="10" rows="10" name="conts" style="width:100%;" id="ckeditor" class="globalEditor" <c:if test="${item.require_yn == 'Y' }">required</c:if> >${view.conts }</textarea></td>
					</c:when> --%>
					<c:when test="${item.column_name == 'reg_nm' }"><td><input type="text" id="member_nm" name="member_nm" class="input_1" style="width:100px;" readonly="readonly" value="${view.reg_nm }" <c:if test="${item.require_yn == 'Y' }">required</c:if> /></td></c:when>
					<c:when test="${item.column_name == 'sdate' }"><td><input type="text" id="sdate" name="sdate" class="input_1" style="width:100px;" readonly="readonly" value="${view.sdate }" <c:if test="${item.require_yn == 'Y' }">required</c:if> /></td></c:when>
					<c:when test="${item.column_name == 'edate' }"><td><input type="text" id="edate" name="edate" class="input_1" style="width:100px;" readonly="readonly" value="${view.edate }" <c:if test="${item.require_yn == 'Y' }">required</c:if> /></td></c:when>
					<c:when test="${item.column_name == 'password' }"><td><input type="password" id="passowd" name="password" class="input_1" style="width:100px;" readonly="readonly" value="${view.password }" autocomplete="off"/></td></c:when>
					
					<c:when test="${item.column_name == 'public_yn' }">
						<td>
							<c:if test="${boardInfo.public_yn == 'N' }">
								<label for="public_y"><input type="radio" id="public_y" <c:if test="${view.public_yn == 'Y' }">checked="checked"</c:if> name="public_yn" value="Y"/>공개</label> / 
							<label for="public_n"><input type="radio" id="public_n" <c:if test="${view.public_yn == 'N' }">checked="checked"</c:if> name="public_yn" value="N"/>비공개</label>
							</c:if>
							<c:if test="${boardInfo.public_yn == 'X' }">						
								<label for="public_n"><input type="radio" id="public_n" checked="checked" name="public_yn" value="N"/>비공개</label>
							</c:if>
						</td>
					</c:when>
					
					<c:when test="${item.column_name == 'notice_yn' }"><td><label for="notice_n"><input type="radio" id="notice_n" <c:if test="${view.notice_yn == 'N' }">checked="checked"</c:if> name="notice_yn" value="N"/>일반</label> / <label for="notice_y"><input type="radio" id="notice_y" <c:if test="${view.notice_yn == 'Y' }">checked="checked"</c:if> name="notice_yn" value="Y"/>공지</label></td></c:when>
					<c:when test="${item.column_name == 'tel' }">
						<td>
							<select id="tel" name="tel1" class="select_1 ws_1">
								<c:forEach var="itemtel" items="${tellist }" varStatus="i">
									<option value="${itemtel.code }"<c:if test="${itemtel.code == view.tel1}"> selected="selected"</c:if>>${itemtel.code }</option>
								</c:forEach>
							</select>
							- <input type="text" id="tel2" name="tel2" maxlength="4" class="input_1" value="${view.tel2 }" style="width:50px;" <c:if test="${item.require_yn == 'Y' }">required</c:if> />
							- <input type="text" id="tel3" name="tel3" maxlength="4" class="input_1" value="${view.tel3 }" style="width:50px;" <c:if test="${item.require_yn == 'Y' }">required</c:if> /> 
						</td>
					</c:when>
					<c:when test="${item.column_name == 'cell' }">
						<td>
							<select id="cell1" name="cell1" class="select_1 ws_1">
								<c:forEach var="itemcell" items="${celllist }" varStatus="i">
									<option value="${itemcell.code }"<c:if test="${itemcell.code == view.cell1}"> selected="selected"</c:if>>${itemcell.code }</option>
								</c:forEach>
							</select>
							- <input type="text" id="cell2" name="cell2" maxlength="4" class="input_1" value="${view.cell2 }" style="width:50px;" <c:if test="${item.require_yn == 'Y' }">required</c:if> />
							- <input type="text" id="cell3" name="cell3" maxlength="4" class="input_1" value="${view.cell3 }" style="width:50px;" <c:if test="${item.require_yn == 'Y' }">required</c:if> /> 
						</td>
					</c:when>
					<c:when test="${item.column_name == 'email' }">
						<td>
							<input type="text" id="email1" name="email1" class="email_t" value="${view.email1 }" style="width:100px;" <c:if test="${item.require_yn == 'Y' }">required</c:if> /> @
							<input type="text" id="email2" name="email2" class="email_t" value="${view.email2 }" style="width:150px;" <c:if test="${item.require_yn == 'Y' }">required</c:if> />
							<select id="email2_select" name="email2_select" class="select_1 ws_1">
								<option value="" selected="selected">직접입력</option>
								<c:forEach var="item" items="${emaillist }" varStatus="i">
									<option value="${item.code }"<c:if test="${item.code == view.email2 }"> selected="selected"</c:if>>${item.code_nm }</option>
								</c:forEach>
							</select>
						</td>
					</c:when>
					
					<c:otherwise>
						<td>
							<input type="text" id="${item.column_name }" name="${item.column_name }" class="input_1" value="${view[item.column_name] }" <c:if test="${item.require_yn == 'Y' }">required</c:if>  <c:if test="${item.col_edit == 'N' }">disabled</c:if>/>
						</td>
					</c:otherwise>
				</c:choose>
			</tr>
			</c:if>
		</c:forEach>
		
		<c:if test="${conts_yn == 'Y' }">
			<tr>
				<th scope="row">${conts_element}</th>
				<%-- <td colspan="3"><textarea name="conts" id="conts" style="width:100%;" class="globalEditor" title="내용입력">${view.conts }</textarea></td> --%>
				<td><textarea cols="10" rows="10" name="conts" id="conts" style="width:100%;"  class="${boardInfo.editor_yn == 'Y' ? 'globalEditor' : ''}" title="내용입력">${view.conts }</textarea></td>
			</tr>
		</c:if>
		
		<c:if test="${thumb_yn == 'Y' }">
		<tr>
       		<th rowspan="2">썸네일이미지 </th>
       		<td>
       			<span>※ 썸네일 이미지는 리스트페이지에 보여지는 이미지를 등록 할 수 있습니다.<br>(썸네일 이미지를 등록하지 않으면 내용에 등록된 첫번째 이미지가 자동으로 보여집니다.)</span>
       			<input type="file" name="thumbfile" id="thumbfile" title="썸네일 이미지 선택"/>
       		</td>
     	</tr>
     	<tr> 
       		<td class="tddiv" id="attach_div">
        		<c:if test="${!empty thumbnm }">
        		<div id="image_preview">
        			<img id="thumb_img" src="${thumbnm}" style="width:${thumb_width}px;height:${thumb_height}px;" alt="썸네일 이미지"/>
					<a href="#"><img src="<c:url value="/images/super/contents/s_btn_1.gif"/>" alt="삭제" style="vertical-align:bottom;"/></a>
				</div>
        		</c:if>
    		</td>
     	</tr>
     	</c:if>
     	
		
		<c:if test="${boardInfo.file_yn == 'Y' }">
			<c:if test="${fn:length(data.files) > 0 }">
			<tr>
				<th scope="row">기존 첨부파일</th>
				<td id="oldfileList">
					<ul>
					<c:forEach items="${data.files }" var="files" varStatus = "status">
						<li>${files.attach_nm} <input type="checkbox" name="delattach" value="${files.uuid }"/>삭제</li>
					</c:forEach>
					</ul>
				</td>
			</tr>
			</c:if>
			<tr class="last">
				<th scope="row"><label for="file">첨부파일</label></th>
				<td id="fileList">
					<div id="file1"><input type="file" id="file" name="attach" style="margin-bottom:5px;" title="첨부파일1"/> <a href="javascript:fileListAdd()"><img src="/images/board/add_btn.gif" alt="추가" /></a></div>
				</td>
			</tr>
		</c:if>
		<c:if test="${boardInfo.tag_yn == 'Y' }">
		<tr>
			<th>태그</th>
			<td>
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