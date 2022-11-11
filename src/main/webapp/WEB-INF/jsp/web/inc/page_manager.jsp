<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<script type="text/javascript">
//<![CDATA[
$(function(){
	$("#satisfactionFrm").submit(function(){
		if(!$("[name='score']").is(":checked")){
			alert("만족도를 선택하여 주시기 바랍니다.");
			$("[name='score']").eq(0).focus();
			return false;
		}
		$.post($(this).prop("action"), $(this).serializeObject(), function(data){
			if(data.rst=="-1"){
				alert(data.msg);
			}else{
				alert("정상적으로 등록되었습니다. 참여해주셔서 감사합니다.");
				$(".s_avg").text(data.data.average);
				$(".s_cnt").text(data.data.cnt);
				$("textarea[name='etc']").val('');
			}
		});
		return false;
	});
	
	$("#QR_code").toggle(function(){
		$(".QR_box").slideDown();
		$("#qr_img").attr("src", "<c:url value='/mc/common/qrcode.do'/>?width=100&height=97&url="+location.href);
	}, function(){
		$(".QR_box").slideUp();
	});
});
function estimate(){
	$("#satisfactionFrm").submit();
}
//]]>
</script>

<script type="text/javascript">
$(document).ready(function(){
	$("input:radio[name=score]").click(function(){
		if($("#etc_chk").prop("checked")){
			$("#eval_insert").css("display","block");
		}else{
			$("#eval_insert").css("display","none");
			$("#eval_etc_text").val("");
		}
	});
	
	$(".gtb ul li input").on("click",function(){
		if($(".gtb ul li input:radio[value=0]").prop("checked")){
			$(".gtb a").css("display","none");
		}else{
			$(".gtb a").css("display","block");
		}
	});
	
});
</script>
<!-- 만족도조사 / 페이지담당자  -->

<div class="management">
	<c:if test="${basic_view.satisfaction_yn eq 'Y'}">
	<div class="satisfaction">
		<form id="satisfactionFrm" name="satisfactionFrm" action="<c:url value="/satifaction/estimate.do"/>" method="post">
			<p><strong>만족도</strong> 현재 페이지에 대하여 얼마나 만족하십니까?</p>
			<div>
				<input type="hidden" name="cms_menu_seq" value="${param.cms_menu_seq }"/>
				<ul class="clearfix">
					<li><input type="radio" id="well" name="score" value="5" /><label for="well">매우만족</label>	</li>
					<li><input type="radio" id="satisfactorily"  name="score" value="4" /><label for="satisfactorily">만족</label></li>
					<li><input type="radio" id="normal" name="score" value="3" /><label for="normal">보통</label></li>
					<li><input type="radio" id="dissatisfaction" name="score" value="2" /><label for="dissatisfaction">불만족</label></li>
					<li><input type="radio" id="veryunsatisfactory"  name="score" value="1" /><label for="veryunsatisfactory">매우불만족</label></li>
					<li><input type="radio" id="etc_chk"  name="score" value="0" /><label for="etc_chk">기타의견</label></li>
				</ul>
				<a href="javascript:estimate()">평가하기</a>
			</div>		
			<div id="eval_insert" class="other_opinions">
				<textarea id="eval_etc_text" name="etc" placeholder="기타의견을 작성해주세요"></textarea>
				<input type="submit" value="의견제출" />
			</div>
		</form>
	</div><!-- 만족도 -->
	</c:if>
	<c:if test="${basic_view.manage_yn eq 'Y' and !empty manager_list }">
	<div class="manager clearfix">	
		<p>담당자</p>
		<ul>
		<c:forEach var="item" items="${manager_list}">		
			<li>
				<span>부서 : <b>${item.group_nm }</b></span>
				<span>담당자 : <b>${item.member_nm }</b></span>
				<span>연락처 : <b>${item.tel }</b></span>
			</li>
		</c:forEach>
		</ul>
	</div><!-- 페이지 담당자 -->
	</c:if>
</div>

<%-- 
<c:if test="${basic_view.satisfaction_yn eq 'Y'}">
	<div class="eval_sec">
		<form id="satisfactionFrm" name="satisfactionFrm" action="<c:url value="/satifaction/estimate.do"/>" method="post">
		<div class="eval_txt">
			<p><strong>만족도</strong> 현재 페이지에 대하여 얼마나 만족하십니까?</p>
		</div>
		<div class="gtb">
			<input type="hidden" name="cms_menu_seq" value="${param.cms_menu_seq }"/>
				<ul>
					<li><input type="radio" id="well" name="score" value="5" /><label for="well">매우만족</label>	</li>
					<li><input type="radio" id="satisfactorily"  name="score" value="4" /><label for="satisfactorily">만족</label></li>
					<li><input type="radio" id="normal" name="score" value="3" /><label for="normal">보통</label></li>
					<li><input type="radio" id="dissatisfaction" name="score" value="2" /><label for="dissatisfaction">불만족</label></li>
					<li><input type="radio" id="veryunsatisfactory"  name="score" value="1" /><label for="veryunsatisfactory">매우불만족</label></li>
					<li><input type="radio" id="etc_chk"  name="score" value="0" /><label for="etc_chk">기타의견</label></li>
				</ul>
				<a href="javascript:estimate()"><span>평가하기</span></a>
		</div>
		<div class="eval_insert" id="eval_insert">
			<textarea id="eval_etc_text" name="etc" placeholder="기타의견을 작성해주세요"></textarea>
			<span><input type="submit" value="의견제출" /></span>
		</div>
		</form>
	</div>
</c:if>
<c:if test="${basic_view.manage_yn eq 'Y' and !empty manager_list }">
	<div class="eval_list">
		<p>담당자</p>
		<ul>
		<c:forEach var="item" items="${manager_list}">		
			<li>
				<span>부서 : <strong>${item.group_nm }</strong></span>
				<span>담당자 : <strong>${item.member_nm }</strong></span>
				<span>연락처 : <strong>${item.tel }</strong></span>
			</li>
		</c:forEach>
		</ul>
	</div>
</c:if>
 --%>
