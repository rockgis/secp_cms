<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
<c:choose>
	<c:when test="${social_session.main_sns_account eq 'twt'}">
		<input type="hidden" name="userid" value="${twitter_userid }">
		<input type="hidden" name="sns_link" value="https://twitter.com/${twitter_userid }">
	</c:when>
	<c:when test="${social_session.main_sns_account eq 'face'}">
		<input type="hidden" name="userid" value="${facebook.id }">
		<input type="hidden" name="sns_link" value="https://www.facebook.com/${facebook.id }">
	</c:when>
	<c:when test="${social_session.main_sns_account eq 'nav'}">
		<input type="hidden" name="userid" value="${naver.email }">
	</c:when>
	<c:when test="${social_session.main_sns_account eq 'kao'}">
		<input type="hidden" name="userid" value="${kakao.userid }">
		<input type="hidden" name="sns_link" value="${kakao.sns_link }">
	</c:when>
	<c:when test="${social_session.main_sns_account eq 'google'}">
		<input type="hidden" name="userid" value="${google.userid }">
	</c:when>
	<c:when test="${social_session.main_sns_account eq 'insta'}">
		<input type="hidden" name="userid" value="${insta.userid }">
	</c:when>
</c:choose>

<c:if test="${!empty sns_account.twt_consumer_key || !empty sns_account.face_appid || !empty sns_account.nav_client_id || !empty sns_account.kao_client_id || !empty sns_account.google_client_id || !empty sns_account.insta_client_id }">
	<%-- 
	<div class="sns_tit">소셜로그인</div>
	 --%>
	<div class="sns_sel">
		<ul>		
			<c:if test="${!empty sns_account.twt_consumer_key }">
			<li <c:if test="${social_session.main_sns_account eq 'twt'}">class="on"</c:if>>
			 	<a onclick="twtlogin()" title="Twitter 을(를) 대표계정으로 설정">	<img src="/images/board/twitter.gif" alt=""></a>
			 	<c:if test="${!empty twitter }">
		 		<span><input type="checkbox" name="twt_yn" value="Y" title="트위터로 전송"></span>
		 		</c:if>
		 	</li>
		 	</c:if>
			<c:if test="${!empty sns_account.face_appid }">
			<li <c:if test="${social_session.main_sns_account eq 'face'}">class="on"</c:if>>
			 	<a onclick="facelogin()" title="Facebook 을(를) 대표계정으로 설정">
				 	<img src="/images/board/facebook.gif" alt="">
			 	</a>
			 	<c:if test="${!empty facebook }">
		 		<span>
		 			<input type="checkbox" name="face_yn" value="Y" title="페이스북으로 전송">
		 		</span>
		 		</c:if>
		 	</li>
		 	</c:if>
			<c:if test="${!empty sns_account.nav_client_id }">
			<li <c:if test="${social_session.main_sns_account eq 'nav'}">class="on"</c:if>>
				 <a onclick="navlogin()" title="Naver 을(를) 대표계정으로 설정">
				 	<img src="/images/board/naver.gif" alt="">
			 	</a>
		 	</li>
		 	</c:if>
			<c:if test="${!empty sns_account.kao_client_id }">
			<li <c:if test="${social_session.main_sns_account eq 'kao'}">class="on"</c:if>>
			 	<a onclick="kaologin()" title="Kakao 을(를) 대표계정으로 설정">
				 	<img src="/images/board/kakao.gif" alt="">
			 	</a>
			 	<c:if test="${!empty kakao }">
		 		<span>
		 			<input type="checkbox" name="kao_yn" value="Y" title="카카오톡으로 전송">
		 		</span>
		 		</c:if>
		 	</li>
		 	</c:if>
			<c:if test="${!empty sns_account.google_client_id }">
		 	<li <c:if test="${social_session.main_sns_account eq 'google'}">class="on"</c:if>>
			 	<a onclick="googlelogin()" title="google 을(를) 대표계정으로 설정">
				 	<img src="/images/board/google.gif" alt="">
			 	</a>
		 	</li>
		 	</c:if>
			<c:if test="${!empty sns_account.insta_client_id }">
		 	<li <c:if test="${social_session.main_sns_account eq 'insta'}">class="on"</c:if>>
			 	<a onclick="instalogin()" title="인스타그램 을(를) 대표계정으로 설정">
				 	<img src="/images/board/insta.gif" alt="">
			 	</a>
		 	</li>
		 	</c:if>
	 	</ul>
 	</div>
</c:if>