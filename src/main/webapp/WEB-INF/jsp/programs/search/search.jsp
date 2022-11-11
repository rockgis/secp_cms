<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">

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
    <script src="/js/secp/search/search.js"></script>
</head>

<body>
    <div class="wrap">
        <!-- 상단 영역 //-->
		<%@ include file="/WEB-INF/jsp/programs/header.jsp" %>
        <!--// 상단 영역 -->

        <!-- 서브 헤드 //-->
        <div class="sub-head sub5">
            <div class="content-width">
                <h2>검색결과</h2>
                <ul class="linemap">
                    <li><a href="index.html"><img src="/images/secp/ico_home_w.png" alt="홈"></a></li>
                    <li>검색결과</li>
                </ul>
            </div>
        </div>
        <!--// 서브헤드 -->

        <!-- 콘텐츠 영역 //-->
        <div class="sub-content">
            <div class="search-result-wrap">
                <div class="search-top">
                    <input type="text" class="inp-search2" id="input-keyword">
                    <button type="button" class="btn-search2">검색</button>
                    <p><strong><span id="keyword">“${keyword }”</span></strong>에 대한 검색 결과 <b><span id="total-cnt">0</span></b> 건의 결과를 찾았습니다.</p>
                </div>

                <div class="search-result-list">

                    <div class="stit-wrap">
                        <h3 class="stit">지원사업 공고 (온라인 접수) <span id="apply-cnt">(0건)</span></h3>
                        <button type="button" class="btn btn-black btn-round btn-medium">더보기</button>
                    </div>
                    
                    <ul class="list-wrap" id="apply-list">
                    	<li>
                    		<a href="#">
                    			<h4>검색된 데이터가 없습니다.</h4>
                    			<p></p>
                    		</a>
                    	</li>
                    </ul>
                    <div class="stit-wrap">
                        <h3 class="stit">게시판 <span id="board-cnt">(0건)</span></h3>
                        <button type="button" class="btn btn-black btn-round btn-medium">더보기</button>
                    </div>

                    <ul class="list-wrap" id="board-list">
                    	<li>
	                    	<a href="#">
	                    		<h4>검색된 데이터가 없습니다.</h4>
	                    		<p></p>
	                    	</a>
                    	</li>
                    </ul>

                    <div class="stit-wrap">
                        <h3 class="stit">첨부파일 <span id="file-cnt">(0건)</span></h3>
                        <button type="button" class="btn btn-black btn-round btn-medium">더보기</button>
                    </div>

                    <ul class="list-wrap" id="file-list">
                    	<li>
	                    	<a href="#">
	                    		<h4>검색된 데이터가 없습니다.</h4>
	                    		<p></p>
	                    	</a>
                    	</li>
                    </ul>
                </div>

            </div>
            
        </div>
        <!--// 콘텐츠 영역 -->

        <!-- 푸터 영역 //-->
        <%@ include file="/WEB-INF/jsp/programs/footer.jsp" %>
        <!--// 푸터 영역 -->
    </div>
</body>

</html>