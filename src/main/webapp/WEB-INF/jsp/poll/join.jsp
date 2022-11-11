<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="<c:url value="/lib/css/board.css"/>" type="text/css" />
<script type="text/javascript">
	function pollJoin(){
		var pollCheck = false;
		$.each($("#survey_data>li"),function(i,v){
			if($(v).attr("data-required") == "Y"){
				var question_type = $(v).find("ul").attr("data-question-type");
				if(question_type == "A" ||question_type == "D"){//단일 || 비활성화
					if($(v).find("input").attr("disabled") != "disabled"){
						if($(v).find("input:checked").length == 0){
							alert($(v).attr("data-count")+"번 문항을 작성하시기 바랍니다.");
							$(v).find("input:eq(0)").focus();
							pollCheck = true;
							return false;
						}
					}
				}else if(question_type == "B"){// 중복
					var check_count = $(v).attr("data-required-count");//0 : 제한없음, n : 제한
					var count_controll = $(v).attr("data-required-count-controll");//U : 이상, D : 이하, E : n개 선택
					if(check_count == "0"){//제한 없음
						if($(v).find("input").attr("disabled") != "disabled"){
							if($(v).find("input:checked").length == 0){
								alert($(v).attr("data-count")+"번 문항을 작성하시기 바랍니다.");
								$(v).find("input:eq(0)").focus();
								pollCheck = true;
								return false;
							}
						}
					}else{
						if($(v).find("input").attr("disabled") != "disabled"){
							if($(v).find("input:checked").length == 0){
								alert($(v).attr("data-count")+"번 문항을 선택하시기 바랍니다.");
								$(v).find("input:eq(0)").focus();
								pollCheck = true;
								return false;
							}else{
								var checkedBoxLength = $(v).find("input:checked").length;
								if(checkedBoxLength != check_count){
									if(count_controll == "U" && checkedBoxLength < check_count){//이상 선택
										alert($(v).attr("data-count")+"번 문항을 "+check_count+"개 이상 선택하시기 바랍니다.");
										$(v).find("input:eq(0)").focus();
										pollCheck = true;
										return false;
									}
									if(count_controll == "D" && checkedBoxLength > check_count){//이하 선택
										alert($(v).attr("data-count")+"번 문항을 "+check_count+"개 이하 선택하시기 바랍니다.");
										$(v).find("input:eq(0)").focus();
										pollCheck = true;
										return false;
									}
									if(count_controll == "E" && checkedBoxLength != check_count){//n개 선택
										alert($(v).attr("data-count")+"번 문항을 "+check_count+"개 선택하시기 바랍니다.");
										$(v).find("input:eq(0)").focus();
										pollCheck = true;
										return false;
									}
								}
							}
						}
					}
				}else if(question_type == "C"){//주관식
					if($(v).find("textarea").attr("disabled") != "disabled"){
						if($(v).find("textarea").val() == ""){
							alert($(v).attr("data-count")+"번 문항을 작성하시기 바랍니다.");
							$(v).find("textarea").focus();
							pollCheck = true;
							return false;
						}
					}
				}else if(question_type == "E"){//혼합형
					if($(v).find("input").attr("disabled") != "disabled"){
						if($(v).find("input:checked").length == 0){
							alert($(v).attr("data-count")+"번 문항을 작성하시기 바랍니다.");
							$(v).find("input:eq(0)").focus();
							pollCheck = true;
							return false;
						}else{
							if($(v).find("input:checked").siblings("textarea").val() == ""){
								alert($(v).attr("data-count")+"번 문항을 작성하시기 바랍니다.");
								$(v).find("input:checked").siblings("textarea").focus();
								pollCheck = true;
								return false;
							}
						}
					}
				}
			}
		});
		
		if(pollCheck){
			return false;
		}
		
		if($("input[name=lot_yn]").val() == "Y"){
			if($("input[name=reg_nm]").val() == ""){
				alert("이름을 입력하시기 바랍니다.");
				$("input[name=reg_nm]").focus();
				return false;
			}
			if($("select[name=reg_tel1]").val() == "" || $("input[name=reg_tel2]").val() == "" || $("input[name=reg_tel3]").val() == ""){
				alert("전화번호를 입력하시기 바랍니다.");
				$("select[name=reg_tel1]").focus();
				return false;
			}
			if($("input[name=reg_email]").val() == "" || $("input[name=reg_email2]").val() == ""){
				alert("이메일을 입력하시기 바랍니다.");
				$("input[name=reg_email]").focus();
				return false;
			}
		}
		
		if($("input[name=f_yn]:checked").val() != 'Y'){
			alert("필수적 정보 동의를 해야합니다.");
			jQuery("#f_yn1").focus();
			return false;
		}
		
		return confirm("참여하시겠습니까?");
	}
	
	function nextDisable(obj){
		var current_index = $(obj).closest("ul").closest("li").index();
		$.each($(obj).closest("ul").closest("li").siblings(),function(i,v){
			if($(v).attr("data-subject") == "N"){
				if(i >= current_index){
					if($(obj).attr("data-disabled") == "Y"){
						$(v).find("textarea").val("");
						$(v).find("input").prop("checked",false);
						$(v).find("input,textarea").attr("disabled",true)
						return false;
					}else{
						$(v).find("input,textarea").attr("disabled",false)
						return false;
					}
				}
			}
		})
	}
	
	function ShowHide(obj){
		$(obj).closest("ul").find("textarea").css("display","none");
		if($(obj).attr("data-show-hide") == "Y"){
			$(obj).next().css("display","block");
			$(obj).closest("ul").find("textarea").val("");
		}else{
			$(obj).closest("ul").find("textarea").val("");
			$(obj).closest("ul").find("textarea").css("display","none");
		}
	}
	
	$(document).ready(function(){
		$.each($("#survey_data>li"),function(i,v){
			var question_type = $(v).find("ul").attr("data-question-type");
			if(question_type == "B"){// 중복
				var check_count = $(v).attr("data-required-count");//0 : 제한없음, n : 제한
				var count_controll = $(v).attr("data-required-count-controll");//U : 이상, D : 이하, E : n개 선택
				if(check_count != "0"){
					if(count_controll == "E" || count_controll == "D"){
						var inputCheckBoxName = Number($(v).attr("data-count"))-1;
						$("input[type=checkbox][name="+inputCheckBoxName+"]").change(function(){
							if($("input[type=checkbox][name="+inputCheckBoxName+"]:checked").length == check_count){
								$("input[type=checkbox][name="+inputCheckBoxName+"]").not(":checked").attr("disabled","disabled");
							}else{
								$("input[type=checkbox][name="+inputCheckBoxName+"]").attr("disabled", false);
							}
						})
					}
				}
			}
		});
		
	<c:if test="${view.lot_yn == 'Y' }">
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
	});
</script>
</head>
<body>
<form action="join.do" onsubmit="return pollJoin();" id="poll" method="post" >
<sec:csrfInput />
<double-submit:preventer/>
<input type="hidden" name="cms_menu_seq" value="${params.cms_menu_seq }" />
<input type="hidden" name="poll_seq" value="${params.poll_seq }" />
<input type="hidden" name="lot_yn" value="${view.lot_yn }" />
<input type="hidden" name="cpage" value="${params.cpage }" />
<input type="hidden" name="rows" value="${params.rows }" />
<input type="hidden" name="condition" value="${params.condition }" />
<input type="hidden" name="keyword" value="${params.keyword }" />
<table class="board_view ui_style_1 ca_left">
	<colgroup>
		<col class="col_header" />
		<col class="col_title" />
	</colgroup>
	<thead>
	<tr>
		<th>제목</th>
		<td>${fn:escapeXml(view.title) }</td>
	</tr>
	<!-- <tr>
		<th>내용</th>
		<td class="left"></td>
	</tr> -->
	<tr>
		<th>참여기한</th>
		<td>${view.start_dt } ~ ${view.end_dt }</td>
	</tr>
	<tr>
		<th>참여자수</th>
		<td>${(view.join_cnt == '' || view.join_cnt == null) ? 0 : view.join_cnt}</td>
	</tr>
	</thead>
	<tbody>
	<tr>
		<td colspan="2" class="contents">
			<div class="survey_con">
				<p>${view.content }</p>
			</div>
			
			<ul class="survey_box_list" id="survey_data">
				<c:set var="q_count" value="1"/>
				<c:forEach var="item" items="${question }" varStatus="i">
					<c:choose>
						<c:when test="${item.subject_yn == 'Y'}">
							<li class="survay_s" data-required="${item.required_yn }" data-subject="${item.subject_yn}">
								<p class="survey_subject">${item.question}</p>
								<p class="survey_content">${item.question_content }</p>
							</li>
						</c:when>
						<c:otherwise>
							<li class="survay_q" data-required="${item.required_yn }"  data-subject="${item.subject_yn}" data-count="${q_count }" data-required-count="${item.required_count }" data-required-count-controll="${item.required_count_controll }">
								<p class="survey_question"><span id="q${item.question_seq }">${q_count }</span>.&nbsp;${item.question}<c:if test="${item.required_yn == 'Y' }"><b><span style="color: rgb(255, 0, 0); font-size: 8pt;">&nbsp;*필수</span></b></c:if></p>
								<c:if test="${item.question_content != null && item.question_content != ''}"><p class="survey_content">${item.question_content }</p></c:if>
								<ul data-question-type="${item.question_type}">
									<c:forEach var="sub_item" items="${answers[i.count-1] }" varStatus="x">
										<c:if test="${item.question_type == 'A' }">
											<li><input type="radio" name="${sub_item.question_seq }" value="${sub_item.answer_seq }" id="${sub_item.question_seq }_${sub_item.answer_seq }" />
											<label for="${sub_item.question_seq }_${sub_item.answer_seq }">${sub_item.answer }</label></li>
										</c:if>
										<c:if test="${item.question_type == 'B' }">
											<li><input type="checkbox" name="${sub_item.question_seq }" value="${sub_item.answer_seq }" id="${sub_item.question_seq }_${sub_item.answer_seq }" />
											<label for="${sub_item.question_seq }_${sub_item.answer_seq }">${sub_item.answer }</label></li>
										</c:if>
										<c:if test="${item.question_type == 'C' }">
											<li><textarea id="${sub_item.null_chk }${sub_item.question_seq }" name="${sub_item.question_seq }" class="inp11 size6"></textarea></li>
										</c:if>
										<c:if test="${item.question_type == 'D' }">
											<li><label><input type="radio" name="${sub_item.question_seq }" value="${sub_item.answer_seq }" onchange="nextDisable(this)" data-disabled="${sub_item.jump_chk }" data-question-seq="${sub_item.question_seq }"/>${sub_item.answer }</label></li>
										</c:if>
										<c:if test="${item.question_type == 'E' }">
											<li><label class="tta_${sub_item.question_seq }"><input type="radio" name="${sub_item.question_seq }" value="${sub_item.answer_seq }" onchange="ShowHide(this)" data-show-hide="${sub_item.jump_chk }"/>${sub_item.answer }
											<c:if test="${sub_item.jump_chk == 'Y' }"><textarea name="${sub_item.question_seq }_t_${sub_item.answer_seq }" style="display:none;"></textarea></c:if></label></li>
										</c:if>
									</c:forEach>
								</ul>
							</li>
							<c:set var="q_count" value="${q_count+1 }"/>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
			<c:if test="${view.lot_yn == 'Y' }">
			<div class="survey_input">
				<p><span>이름 :</span> <input type="text" name="reg_nm" value="${sessionScope.member.member_nm }" class="si_name inp2 size1"/></p>
				<p><span>휴대전화 :</span> 
				<select name="reg_tel1" class="ws_2 sel1" title="휴대전화 앞자리 선택">
					<option value="">선택</option>
					<c:forEach var="item" items="${celllist }" varStatus="i">
						<option value="${item.code }">${item.code }</option>
					</c:forEach>
					<%-- <c:forEach var="item" items="${tellist }" varStatus="i">
						<option value="${item.code }">${item.code }</option>
					</c:forEach> --%>
				</select>
				 - 	
				<input type="text" name="reg_tel2" value="" maxlength="4" class="ws_2 si_tel inp3" /> - <input type="text" name="reg_tel3" value="" maxlength="4" class="ws_2 si_tel inp3" /></p>
				<p>
				<span>이메일 :</span> 
				<input type="text" name="reg_email" value="" id="email1" class="ws_3 si_mail inp1" /> @ <input type="text" name="reg_email2" value="" id="email2" class="ws_3 si_mail inp1 size3" /> 
				<select id="email2_select" name="email2_select" class="ws_2 si_mail2 size3">
					<option value="">직접입력</option>
					<c:forEach var="item" items="${emaillist }" varStatus="i">
						<option value="${item.code }">${item.code_nm }</option>
					</c:forEach>
				</select>
				</p>
				<%--
				<p>
				<span>등록 URL :</span> 
				<input type="text" name="reg_url" value="" id="reg_url" class="ws_3 si_mail inp2 size1" />
				</p>
				 --%>
			</div>
			</c:if>
		</td>
	</tr>
	</tbody>
</table>

<div class="certication">
	<div class="check">
		<ul>
			<li>
				<h4>개인정보의 수집,활용 동의서</h4>
				<div class="cert_box">
					■ 개인정보의 수집 및 이용목적
  국가암정보센터는 정보제공을 위하여 최소한의 정보를 수집하고 있습니다.

■ 개인정보의 보유 및 이용기간
  개인정보 처리및 보유기간은 1년입니다.

■ 기본 개인정보 수집 · 활용
  성명, 이메일, 전화번호, 휴대전화번호, 주소

■ 개인정보 수집 동의 거부와 불이익
  정보주체는 개인정보 수집 동의를 거부할 권리가 있으며,
  이미 수집된 정보의 열람, 수정, 파기를 요청할 경우 지체 없이 정보의 열람, 수정, 파기 등의 조치가 이루어집니다.
  또한, 이에 따라 요청하신 서비스를 제공해드릴 수가 없는 경우가 발생할 수 있습니다.
				</div>
				<p>
					<span class="essential"><strong>(필수)</strong> 동의하십니까?</span>
					<input type="radio" name = "f_yn" id = "f_yn1" value = "Y" />
					<label for = "f_yn1">동의함</label>
					<input type="radio" id = "f_yn2" name = "f_yn" value = "N"/>
					<label for = "f_yn2">동의하지 않음</label>
				</p>
			</li>
		</ul>
	</div>
</div>

<div class="view_buttons">
	<div class="right">
		<input type="submit" value="참여" class="btn type_1 lightblue " />
		<a class="btn type_1 lightgray btn_list" href="list.do?cpage=${params.cpage }&amp;keyword=${params.keyword}&amp;cpage=${params.cpage}&amp;rows=${params.rows}">목록</a>
	</div>
</div>

</form>


</body>
</html>