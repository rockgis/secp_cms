<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
<c:set var="color_class"/>
<c:choose>
	<c:when test="${sessionScope.social_session.main_sns_account eq 'twt' }"><c:set var="color_class" value="twitter_color"/></c:when>
	<c:when test="${sessionScope.social_session.main_sns_account eq 'face' }"><c:set var="color_class" value="facebook_color"/></c:when>
	<c:when test="${sessionScope.social_session.main_sns_account eq 'nav' }"><c:set var="color_class" value="naver_color"/></c:when>
	<c:when test="${sessionScope.social_session.main_sns_account eq 'google' }"><c:set var="color_class" value="google_color"/></c:when>
	<c:when test="${sessionScope.social_session.main_sns_account eq 'insta' }"><c:set var="color_class" value="insta_color"/></c:when>
	<c:when test="${sessionScope.social_session.main_sns_account eq 'kao' }"><c:set var="color_class" value="kakao_color"/></c:when>
	<c:otherwise><c:set var="color_class" value="no_color"/></c:otherwise>
</c:choose>
    <fieldset> <!-- 코멘트 입력 -->
    	<div id="name_color" class="${color_class }">
    		<c:if test="${sessionScope.member != null}">
			<p id="user_nm">${sessionScope.social_session.name }</p>
	    	<div class="comment_insert">
	    		<%-- 
	    		<p><img id="profile_img_src" src="${empty sessionScope.social_session.profile_img ? '/images/board/profile_defalut.gif' : sessionScope.social_session.profile_img}" alt="프로필이미지"></p>
	    		 --%>
	    		<div class="txt_insert">
	    			<textarea name="conts" placeholder="댓글을 작성해주세요" required="required" class="post_t"></textarea>
	    			<div>
		    			<span class="count_box"><b>0</b></span>/300
		    			<span class="cmt_register"><a href="#" onclick="comment_reg(event);">등록</a></span>
	    			</div>
	    		</div>
	      	</div>
	      	</c:if>
	      	<c:if test="${sessionScope.member == null}">로그인 후 댓글을 작성하실 수 있습니다.</c:if>
      	</div>
    </fieldset>