<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:choose>
<c:when test="${empty footer.footer_html || fn:trim(footer.footer_html)=='' }">
<!-- 설정된게 없는경우 기본 화면 -->
<footer>
<div class="inner">
    <h2><img src="/images/new/footer/f_logo.png" alt="미디어코어시스템즈" /></h2>
    <div class="f_txt">
        <div class="f_utill">
            <a href="/web/lay1/S1T434C435/contents.do" class="strong">개인정보취급방침</a>
            <a href="/web/lay1/S1T434C436/contents.do">서비스이용약관</a>
            <a href="/web/lay1/S1T434C437/contents.do" class="third">이메일주소무단수집거부</a>
        </div>
        <div class="f_add">
            <p>경기도 수원시 팔달구 권선로 731, 삼부르네상스빌딩 207&nbsp;&nbsp;&nbsp;대표전화 : 031-546-8855</p>
            <p>Copyright(c)2019 By Pressmedia. All rights reserved.</p>
        </div>
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
