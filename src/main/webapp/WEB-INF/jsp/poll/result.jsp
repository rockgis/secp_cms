<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
<%@ taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="<c:url value="/lib/css/board.css"/>" type="text/css" />
<script type="text/javascript" src="<c:url value="/lib/js/bbs.js"/>"></script>
</head>
<body>
<table class="board_view ca_left">
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
		<td>${view.content }</td>
	</tr> -->
	<tr>
		<th>설문기한</th>
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
			
			<ul class="survey_box_list">
				<c:set var="q_count" value="1"/>
				<c:forEach var="item" items="${question }" varStatus="i">
					<c:choose>
						<c:when test="${item.subject_yn == 'Y'}">
							<li class="survay_s">
								<p class="survey_subject">${item.question}</p>
								<p class="survey_content">${item.question_content }</p>
							</li>
						</c:when>
						<c:otherwise>
							<li class="survay_q">
								<p class="survey_question"><span id="q${item.question_seq }">${q_count }</span>.&nbsp;${item.question}</p>
								<p class="survey_content">${item.question_content }</p>
								<ul>
									<c:forEach var="sub_item" items="${answers[i.count-1] }" varStatus="x">
										<c:if test="${item.question_type == 'A' }">
											<li>${sub_item.answer }<br/><div style="background-color:lightblue;width:${sub_item.percent}%;">${sub_item.percent}%</div></li>
										</c:if>
										<c:if test="${item.question_type == 'B' }">
											<li>${sub_item.answer }<br/><div style="background-color:lightblue;width:${sub_item.percent}%;">${sub_item.percent}%</div></li>
										</c:if>
										<c:if test="${item.question_type == 'C' }">
											<li>주관식 답변</li>
										</c:if>
										<c:if test="${item.question_type == 'D' }">
											<li>${sub_item.answer }<br/><div style="background-color:lightblue;width:${sub_item.percent}%;">${sub_item.percent}%</div></li>
										</c:if>
										<c:if test="${item.question_type == 'E' }">
											<li>${sub_item.answer }<br/><div style="background-color:lightblue;width:${sub_item.percent}%;">${sub_item.percent}%</div></li>
										</c:if>
									</c:forEach>
								</ul>
							</li>
							<c:set var="q_count" value="${q_count+1 }"/>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
		</td>
	</tr>
	</tbody>
</table>
<div class="btn_area">
	<div class="right">
		<a href="list.do?cpage=${params.cpage }&amp;keyword=${params.keyword}&amp;cpage=${params.cpage}&amp;rows=${params.rows}">목록</a>
	</div>
</div>

</body>
</html>