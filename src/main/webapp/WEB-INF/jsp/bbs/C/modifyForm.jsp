<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<c:set var="view" value="${data.view }"/>
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
    					alert("????????? ????????? ????????? ?????????????????????.\n????????? ?????? ????????? "+fileLimit+"??? ?????????.");
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
    		
    		$("#wFrm").mcFilter({menu_seq : "${menu_seq}"}, function(f){//????????? ????????? ??????
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
            	required: '*????????? ???????????????',
            	rangelength: $.validator.format("????????? ?????? {0}?????? ?????? {1}?????? ????????? ???????????????.")
            },
            member_nm :{
            	required: '*????????? ???????????????',
            	rangelength: $.validator.format("????????? ?????? {0}?????? ?????? {1}?????? ????????? ???????????????.")
            },
            password: {
        		required : '*??????????????? ???????????????.',
        		rangelength: $.validator.format("??????????????? ?????? {0}?????? ?????? {1}?????? ????????? ???????????????.")
            },
            conts :{
            	required: '*????????? ???????????????'
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

<form name="wFrm" id="wFrm" action="modify.do" method="post" enctype="multipart/form-data">
<sec:csrfInput />
<double-submit:preventer/>
<input type="hidden" name="article_seq" value="${view.article_seq}"/>
<input type="hidden" name="file_yn" value="${boardInfo.file_yn }"/>
<input type="hidden" name="file_limit" value="${boardInfo.file_limit }"/>
<input type="hidden" name="limit_file_size" value="${boardInfo.limit_file_size }"/>

<%-- <input type="hidden" name="filter_yn" value="${boardInfo.filter_yn }"/>
<input type="hidden" name="jumin_yn" value="${boardInfo.jumin_yn }"/> 
<input type="hidden" name="busino_yn" value="${boardInfo.busino_yn }"/>
<input type="hidden" name="bubino_yn" value="${boardInfo.bubino_yn }"/>
<input type="hidden" name="email_yn" value="${boardInfo.email_yn }"/>
<input type="hidden" name="cell_yn" value="${boardInfo.cell_yn }"/>
<input type="hidden" name="tel_yn" value="${boardInfo.tel_yn }"/>
<input type="hidden" name="card_yn" value="${boardInfo.card_yn }"/> --%>

	<p><b class="essential">???</b>????????? ?????? ?????? ?????????.</p>
	<table class="board_write">
		<caption>
			<strong>${boardInfo.title } ?????????</strong>
			<p>??????, ??????, ????????????, ????????????, ??????(2000??? ????????????), ????????????, CCL, ????????????, ?????? ????????? ?????? ?????? ????????? ??? ????????????.</p>
		</caption>
		<colgroup>
			<col style="width:13;"/>
			<col style="width:32;"/>
			<col style="width:18;"/>
			<col style="width:32;"/>
		</colgroup>
		<tbody>
		<tr>
			<th scope="row"><label for="title">?????? <b>*</b></label></th>
			<td colspan="3"><input type="text" id="title" name="title" value="${suf:clearXSS(view.title, '')}"/></td>
		</tr>
		<c:if test="${sessionScope.member == null }">
		<tr>
			<th scope="row"><label for="member_nm">?????? <b>*</b></label></th>
			<td><input type="text" id="member_nm" name="member_nm" class="input_1" value="${view.reg_nm }" style="width:100px;"/></td>
		</tr>
		</c:if>
		<c:if test="${boardInfo.public_yn != 'Y' }">
		<tr>
			<th scope="row"><label for="public_yn">?????????</label></th>
			<td colspan="3">
				<ol class="select">
					<c:if test="${boardInfo.public_yn == 'N' }">
						<li><label for="public_y"><input type="radio" id="public_y" name="public_yn" value="Y" <c:if test="${view.public_yn == 'Y' }">checked="checked"</c:if> /> ??????</label></li>
						<li><label for="public_n"><input type="radio" id="public_n" name="public_yn" value="N" <c:if test="${view.public_yn == 'N' }">checked="checked"</c:if> /> ?????????</label></li>
					</c:if>
					<c:if test="${boardInfo.public_yn == 'X' }">						
						<li class="first"><label for="public_n"><input type="radio" id="public_n" checked="checked" name="public_yn" value="N" /> ?????????</label></li>
					</c:if>	
				</ol>
			</td>
		</tr>
		</c:if>
		<c:if test="${data.cat_yn == 'Y' }">
		<tr>
			<th scope="row"><label for="cat">????????????</label></th>
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
			<th scope="row" class="contents">?????? <b>*</b><br /><span>(2000??? ????????????)</span></th>
			<td colspan="3"><textarea name="conts" style="width:100%;height:350px;" class="${boardInfo.editor_yn == 'Y' ? 'globalEditor' : ''}" title="????????????">${view.conts }</textarea></td>
		</tr>
		<c:if test="${fn:length(data.files) > 0 }">
		<tr>
			<th scope="row">?????? ????????????</th>
			<td id="oldfileList" colspan="3">
				<ul>
				<c:forEach items="${data.files }" var="files" varStatus = "status">
					<li>${files.attach_nm} <input type="checkbox" name="delattach" value="${files.uuid }"/>??????</li>
				</c:forEach>
				</ul>
			</td>
		</tr>
		</c:if>
		<c:if test="${boardInfo.file_yn == 'Y' }">
		<tr class="lst">
			<th scope="row"><label for="file">????????????</label></th>
			<td id="fileList" colspan="3">
				<div id="file1"><input type="file" id="file" name="attach" style="margin-bottom:5px;" title="????????????1"/> <a href="javascript:fileListAdd()" class="btn_type_1"><img src="/images/board/add_btn.gif" alt="??????" /></a></div>
			</td>
		</tr>
		</c:if>
		
		<c:if test="${boardInfo.cclnuri_yn == 'C' or boardInfo.cclnuri_yn == 'A' }">
		<tr>
			<th>CCL</th>
			<td colspan="3">
				<ol class="select ccl_nuri">
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value=""  <c:if test="${view.ccl_type == '' }">checked="checked"</c:if>/><span alt="" style="display:block; padding:6px 6px; color:#fff; background:#abb1aa; border-radius:3px; border:solid 1px #999;">??? ???</span></label></li>
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value="1" <c:if test="${view.ccl_type == '1' }">checked="checked"</c:if> /><img src="/images/container/ccl_1.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value="2" <c:if test="${view.ccl_type == '2' }">checked="checked"</c:if> /><img src="/images/container/ccl_2.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value="3" <c:if test="${view.ccl_type == '3' }">checked="checked"</c:if> /><img src="/images/container/ccl_3.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value="4" <c:if test="${view.ccl_type == '4' }">checked="checked"</c:if >/><img src="/images/container/ccl_4.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value="5" <c:if test="${view.ccl_type == '5' }">checked="checked"</c:if> /><img src="/images/container/ccl_5.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="ccl_type" name="ccl_type" value="6" <c:if test="${view.ccl_type == '6' }">checked="checked"</c:if> /><img src="/images/container/ccl_6.png" alt="" style="display:block;" /></label></li>
				</ol>
				<div style="margin-top:5px; color:#ff7a1a; font-weight:600;">
					<div id="ccltype"  class="ccl" style ="display:none">??????????????? ???????????? ????????????.</div>
					<div id="ccltype1" class="ccl" style ="display:none">??????????????? 4.0 ??????</div>
					<div id="ccltype2" class="ccl" style ="display:none">???????????????-???????????? 4.0 ??????</div>
					<div id="ccltype3" class="ccl" style ="display:none">???????????????-???????????????????????? 4.0 ??????</div>
					<div id="ccltype4" class="ccl" style ="display:none">???????????????-????????? 4.0 ??????</div>
					<div id="ccltype5" class="ccl" style ="display:none">???????????????-?????????-???????????? 4.0 ??????</div>
					<div id="ccltype6" class="ccl" style ="display:none">???????????????-?????????-???????????????????????? 4.0 ??????</div>
				</div>
			</td>
		</tr>
		</c:if>
		<c:if test="${boardInfo.cclnuri_yn == 'P' or boardInfo.cclnuri_yn == 'A' }">
		<tr>
			<th>????????????</th>
			<td colspan="3">
				<ol class="select ccl_nuri">
					<li><label><input type="radio" id="nuri_type" name="nuri_type" value=""  <c:if test="${view.nuri_type == '' }">checked="checked"</c:if> /><span alt="" style="display:block; padding:6px 6px; color:#fff; background:#abb1aa; border-radius:3px; border:solid 1px #999;">??? ???</span></label></li>
					<li><label><input type="radio" id="nuri_type" name="nuri_type" value="1" <c:if test="${view.nuri_type == '1' }">checked="checked"</c:if> /><img src="/images/container/nuri_1.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="nuri_type" name="nuri_type" value="2" <c:if test="${view.nuri_type == '2' }">checked="checked"</c:if> /><img src="/images/container/nuri_2.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="nuri_type" name="nuri_type" value="3" <c:if test="${view.nuri_type == '3' }">checked="checked"</c:if> /><img src="/images/container/nuri_3.png" alt="" style="display:block;" /></label></li>
					<li><label><input type="radio" id="nuri_type" name="nuri_type" value="4" <c:if test="${view.nuri_type == '4' }">checked="checked"</c:if> /><img src="/images/container/nuri_4.png" alt="" style="display:block;" /></label></li>
				</ol>
				<div style="margin-top:5px; color:#ff7a1a; font-weight:600;">
					<div id="nuritype"  class="nuri" style ="display:none">??????????????? ???????????? ????????????.</div>
					<div id="nuritype1" class="nuri" style ="display:none">???????????? / ?????????, ???????????? ???????????? / ?????? ??? 2?????? ????????? ?????? ??????</div>
					<div id="nuritype2" class="nuri" style ="display:none">???????????? / ???????????? ????????? ?????? / ?????? ??? 2?????? ????????? ?????? ??????</div>
					<div id="nuritype3" class="nuri" style ="display:none">???????????? / ?????????, ???????????? ???????????? / ?????? ??? 2?????? ????????? ????????????</div>
					<div id="nuritype4" class="nuri" style ="display:none">???????????? / ???????????? ????????? ?????? / ?????? ??? 2?????? ????????? ?????? ??????</div>
				</div>
			</td>
		</tr>
		</c:if>
		<c:if test="${boardInfo.tag_yn == 'Y' }">
		<tr>
			<th>??????</th>
			<td colspan="3">
				<input type="text" class="normal" style="width:100%;" id="tag_names" name="tag_names" value="${view.tag_names }" tagnames/>
				<p style="margin-top:5px;color:#555; letter-spacing:-1px;">??? ?????? ????????? , ??? ?????? ?????? ?????????.(#??????1,#??????2,#??????3)</p>
			</td>
		</tr>
		</c:if>
		
		</tbody>
	</table>

	<div class="btn_area">
		<div class="right">
	  		<input type="submit" value="??????"/>  
	  		<a href="list.do?cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }">??????</a>
  		</div>
	</div>
</form>
</body>
</html>