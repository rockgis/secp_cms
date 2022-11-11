<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:choose>
<c:when test="${empty footer.footer_html }">
<footer><!-- 설정된게 없는경우 기본 화면 -->
	<div class="util">
		<div class="inner">
			<ul>
				<li><a href="#"><strong>개인정보 처리방침</strong></a></li>
				<li><a href="#">이용약관</a></li>
				<li><a href="#">저작권정책</a></li>
			</ul>
			<div>
				<div class="familySite2">
					<a class="btn_family2" href="#none" title="외국어 사이트 링크 선택">관련사이트</a>
					<ul class="familyList2" style="display: none;">
						<li><a href="http://english.gg.go.kr/gyeonggi-urban-innovation-corporation/" target="_blank" title="영어 사이트 새창열림">ENGLISH</a></li>
					</ul>
					<a href="#none" class="submit">이동</a>
				</div>
				<ul>
					<li><a href="#"><img src="/images/footer/facebook.gif" alt="페이스북" /></a></li>
					<li><a href="#"><img src="/images/footer/twitter.gif" alt="트위터" /></a></li>
					<li><a href="#"><img src="/images/footer/blog.gif" alt="블로그" /></a></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="inner">
		<div class="txt">
			<p>우편번호 16556 경기도 수원시 권선로 731, 삼부르네상스 2층 &nbsp;&nbsp;tel.031.225.0272&nbsp;&nbsp;fax.031.225.0270</p>
			<p>Copyright 2014 &copy; MEDIACORESYSTEMS co. ltd., All Rights Reserved - Contact to Webmaster</p>
		</div>
	</div>
</footer>
</c:when>
<c:otherwise><!-- 사이트관리에서 변경할수있음. -->
<c:out value="${footer.footer_html }" escapeXml="false"/>
</c:otherwise>
</c:choose>
<script type="text/javascript" src="/lib/js/pgwbrowser.js" async="async"></script>
<script type="text/javascript" src="/lib/js/mc.analytics.js" async="async"></script>