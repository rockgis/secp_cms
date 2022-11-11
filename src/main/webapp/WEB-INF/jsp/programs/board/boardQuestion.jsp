<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta property="og:image" content="">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <sec:csrfMetaTags/>
    <title>경기도 소상공인 종합지원 플랫폼</title>

    <link rel="stylesheet" type="text/css" href="/css/secp/jquery.splitter.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/common.css">

	<script src="/js/secp/jquery-1.12.4.min.js"></script>
    <script src="/js/secp/jquery.splitter.js"></script>
    <script src="/js/secp/jquery-ui.min.js"></script>
    <script src="/js/secp/common.js"></script>
    <script>
	$(function () {
		//FAQ
	    $('li.q').on('click', function(){
	        $(this).next().slideToggle(300).siblings('li.a').slideUp();
	        $(this).toggleClass('rotate');
	    });
		
	});
    </script>
</head>

<body>
    <div class="wrap">
        <!-- 상단 영역 //-->
        <%@ include file="/WEB-INF/jsp/programs/header.jsp" %>
        <!--// 상단 영역 -->

        <!-- 서브 헤드 //-->
        <div class="sub-head sub4">
            <div class="content-width">
                <h2>자주 묻는 질문</h2>
                <ul class="linemap">
                    <li><a href="index.html"><img src="../images/secp/ico_home_w.png" alt="홈"></a></li>
                    <li>알림 소식</li>
                    <li>자주 묻는 질문</li>
                </ul>
            </div>
        </div>
        <!--// 서브헤드 -->

        <!-- 콘텐츠 영역 //-->
	    <div class="sub-content">
	    	<ul class="faq">
	        	<c:choose>
			  		<c:when test="${fn:length(boardList) > 0}"> 
	            		<c:forEach var="list" items="${boardList}">
	                		<li class="q">${list.TITLE}</li>
	                		<li class="a">${list.CONTS}</li>
						</c:forEach> 				
	 		   		</c:when>
				<c:otherwise>
					<li class='q'>등록된 질문이 없습니다.</li>
				</c:otherwise>
		 		</c:choose>
			</ul>
	    </div>
        <!--// 콘텐츠 영역 -->

        <!-- 푸터 영역 //-->
        <%@ include file="/WEB-INF/jsp/programs/footer.jsp" %>
        <!--// 푸터 영역 -->
    </div>
</body>
</html>