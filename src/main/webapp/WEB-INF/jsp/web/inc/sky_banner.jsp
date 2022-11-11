<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %>

	<!-- banner zone -->
	<div id="sky_banner_zone" class="sky_banner" style="margin-top:-140px;">
		<div class="sb_wrap layout_wrap">
			<div class="sb_contents">
				<ul class="skyBanner_slide">
					<li>
					<c:choose>
						<c:when test="${item.link_yn == 'Y' }">
							<a href="${item.link_url }" target="${item.link_target }"><img src="${item.file_path }" alt="${item.alt }" /></a>
						</c:when>
						<c:otherwise>
							<img src="${item.file_path }" alt="${item.alt }" />
						</c:otherwise>
					</c:choose>					
					</li>
				</ul>
			</div>
			<div class="sb_footer">
				<div class="chk1">
					<input type="checkbox" id="banner_chk" value="Y">
					<label for="banner_chk">오늘 하루 열지 않기</label>
				</div>
				<button class="">닫기</button>
			</div>
		</div>
	</div>
	<!-- //banner zone -->
