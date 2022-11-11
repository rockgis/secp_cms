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

    <script type="text/javascript">
    
    $(function () {
	
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
                <h2>공지사항</h2>
                <ul class="linemap">
                    <li><a href="/web/index.html"><img src="../images/secp/ico_home_w.png" alt="홈"></a></li>
                    <li>알림 소식</li>
                    <li>공지사항</li>
                </ul>
            </div>
        </div>
        <!--// 서브헤드 -->

        <!-- 콘텐츠 영역 //-->
        <div class="sub-content">
            <div class="board-list-wrap">
                <div class="my-stit1 f-clear">
                    <p>총 <strong>${CNT}</strong>건 (${cri.page}/${pageMaker.endPage}페이지)</p>
                    
                    <form id="searchForm" action="/board/boardIndex.do">
                       	<input type='hidden' name='type' value='1'>
	                    <div class="search-wrap">
	                        <span>
		                        <select name="sch" class="form-control">
	                                <option value="1">제목</option>
	                                <option value="2">내용</option>
	                                <option value="3">제목+내용</option>
	                            </select>
	                        </span>
	                        <span>
	                            <input type="text" class="inp" name="keyword">
	                            <button type="submit" class="btn-search">검색</button>
	                        </span>
	                    </div>
	                </form>
                </div>

                <table class="tbl-list2 hoverbg">
					<colgroup>
						<col style="width: 2em;">
						<col style="width: 50%;">
						<col style="width: 4em;">
						<col style="width: 4em;">
						<col style="width: 2em;">
					</colgroup>
                    <caption>공지사항 목록 : 번호, 제목, 작성자, 작성일, 첨부파일로 구성된 표</caption>
                    <thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">제목</th>
                            <th scope="col">작성자</th>
                            <th scope="col">작성일</th>
                            <th scope="col">첨부파일</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:choose>
	                    	<c:when test="${CNT < 1}">
	                    		<tr>
	                    			<td colspan='5'> 공지사항이 존재하지 않습니다. </td>
	                    		</tr>
	                    	</c:when>
	                    	<c:otherwise> 
		                        <c:forEach var="row" items="${boardList}">
									<c:if test = "${row.RN eq '0'}">
		                        		<tr class="highlight">
		                        			<td data-label="번호"><img src="../images/secp/ico_notice.svg" alt="" class="ico-notice"></td>
		                        	</c:if>
		                        	<c:if test = "${row.RN ne '0'}">
		                        		<tr>
		                            		<td data-label="번호">${row.RN}</td>
		                            </c:if>
		                        			<td data-label="제목" class="t-left"><a href="/board/boardDetail.do?as=${row.ARTICLE_SEQ}&type=1">${row.TITLE}</a></td>
				                            <td data-label="작성자">${row.REG_NM}</td>
				                            <td data-label="작성일">${row.REG_DT2}</td>
				                            <td data-label="첨부파일"><img src="../images/secp/ico_file.jpg" alt="" class="ico-file"></td>
			                            </tr>
								</c:forEach>    
							</c:otherwise>
						</c:choose>                
                    </tbody>
                </table>

                <div class="page">
                	<c:if test="${fn:length(boardList) > 0}">
					<ul class="btn-group pagination">
                        <li><a href="/board/boardIndex.do?page=1&type=1" class="img"><img src="../images/secp/ico_page_first.svg" alt="처음으로"></a></li>
						<c:choose>
					    	<c:when test="${cri.page > pageMaker.startPage}">
					    		<li><a href="/board/boardIndex.do?page=${cri.page-1}&type=1" class="img mr10"><img src="../images/secp/ico_page_prev.svg" alt="이전으로"></a></li>
					    	</c:when>
					    	<c:when test="${cri.page <= pageMaker.startPage}">
					    		<li><a href="#" class="img mr10"><img src="../images/secp/ico_page_prev.svg" alt="이전으로"></a></li>
					    	</c:when>
					    </c:choose>
						
					    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
						    <li>
						        <a <c:if test="${cri.page eq pageNum}">class="active"</c:if> href="<c:url value='/board/boardIndex.do?page=${pageNum}&type=1'/>">${pageNum}</a>
						    </li>
					    </c:forEach>
					    
					    <c:choose>
					    	<c:when test="${cri.page < pageMaker.endPage}">
					    		<li><a href="/board/boardIndex.do?page=${cri.page+1}&type=1" class="img ml10"><img src="../images/secp/ico_page_next.svg" alt="다음으로"></a></li>
					    	</c:when>
					    	<c:when test="${cri.page >= pageMaker.endPage}">
					    		<li><a href="#" class="img ml10"><img src="../images/secp/ico_page_next.svg" alt="다음으로"></a></li>
					    	</c:when>
					    </c:choose>
					    <li><a href="<c:url value="/board/boardIndex.do?page=${pageMaker.endPage}&type=1"/>" class="img"><img src="../images/secp/ico_page_last.svg" alt="마지막으로"></a></li>
					</ul>
					</c:if>
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

