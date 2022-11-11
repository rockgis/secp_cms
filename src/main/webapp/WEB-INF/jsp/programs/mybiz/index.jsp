<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
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
    <script src="/js/secp/mybiz/mybiz.js"></script>
</head>

<body>
    <div class="wrap">
        <!-- 상단 영역 //-->
        <%@ include file="/WEB-INF/jsp/programs/header.jsp" %>
        <!--// 상단 영역 -->

        <!-- 서브 헤드 //-->
        <div class="sub-head sub3">
            <div class="content-width">
                <h2>나의 신청 현황</h2>
                <ul class="linemap">
                    <li><a href="index.html"><img src="/images/secp/ico_home_w.png" alt="홈"></a></li>
                    <li>마이페이지</li>
                    <li>나의 신청 현황</li>
                </ul>
            </div>
        </div>
        <!-- // 서브헤드 -->

        <!-- 콘텐츠 영역 //-->
        <div class="sub-content">
            <div class="my-wrap">

                <div class="my-stit1 f-clear">
                    <h3>진행중인 사업</h3>
                    <div class="search-wrap">
                        <span>
                            <select>
                                <option>상태</option>
                            </select>
                            <select>
                                <option>사업명</option>
                            </select>
                        </span>
                        <span>
                            <input type="text" class="inp">
                            <button type="button" class="btn-search">검색</button>
                        </span>
                    </div>
                </div>

                <div class="scrollable">
                    <table class="tbl-list2">
                        <colgroup>
                            <col style="width: 8%;">
                            <col style="width: 25%;">
                            <col style="width: 8%;">
                            <col style="width: 8%;">
                            <col style="width: 8%;">
                            <col style="width: 25%;">
                        </colgroup>
                        <caption>진행중인 사업</caption>
                        <thead>
                            <tr>
                                <th>접수번호</th>
                                <th>사업명</th>
                                <th>사업기간</th>
                                <th>신청일자</th>
                                <th>상태</th>
                                <th>사업 진행</th>
                            </tr>
                        </thead>
                        <tbody id="prog-list">
                        	<tr>
                                <td colspan="10">진행 중인 지원사업이 없습니다.</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <br><br><br><br>

                <div class="my-stit1 f-clear">
                    <h3>완료된 사업</h3>
                    <div class="search-wrap">
                        <span>
                            <select>
                                <option>상태</option>
                            </select>
                            <select>
                                <option>사업명</option>
                            </select>
                        </span>
                        <span>
                            <input type="text" class="inp">
                            <button type="button" class="btn-search">검색</button>
                        </span>
                    </div>
                </div>

                <div class="scrollable">
                    <table class="tbl-list2">
                        <thead>
                            <tr>
                                <th>접수번호</th>
                                <th>사업명</th>
                                <th>사업기간</th>
                                <th>신청일자</th>
                                <th>상태</th>
                                <th>신청정보</th>
                                <th>첨부파일</th>
                            </tr>
                        </thead>
                        <tbody id="comp-list">
                        	<tr>
                        		<td colspan="7">완료된 지원사업이 없습니다.</td>
                        	</tr>
                        </tbody>
                    </table>
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

