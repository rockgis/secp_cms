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
        	var as = ${list[0].ARTICLE_SEQ};
        	var MAXas = ${list[0].MAXas};
    		var MINas = ${list[0].MINas};
    		
    		function display(){
    			if(as === MAXas){
    				$("#nextPage").css("display", "none");
    			}else if(as === MINas){
    				$("#beforePage").css("display", "none");
    			}	
    		}
    		display();
    		
        	function replyDisplay(){
        		let rd = "${list[0].REPLY_DT}";
        		if(rd === ''){
        			$("#replyTable").css("display", "none");
        		}
        	}
        	replyDisplay();
        	
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
                <h2>1:1 문의</h2>
                <ul class="linemap">
                    <li><a href="/web/index.html"><img src="../images/secp/ico_home_w.png" alt="홈"></a></li>
                    <li>알림 소식</li>
                    <li>1:1 문의</li>
                </ul>
            </div>
        </div>
        <!--// 서브헤드 -->

        <!-- 콘텐츠 영역 //-->
        <div class="sub-content">

            <table class="tbl-view">
                <colgroup>
                    <col style="width: 8%">
                    <col style="">
                    <col style="width: 8%">
                    <col style="">
                    <col style="width: 8%">
                    <col style="">
                </colgroup>
                <caption>1:1 문의 상세페이지</caption>
                <thead>
                    <tr>
                        <th colspan="6" class="title">${list[0].TITLE}</th>
                    </tr>
                    <tr>
	                    <th>작성일</th>
	                    <td>${list[0].REG_DT}</td>
	                    <th>작성자</th>
	                    <td>${list[0].REG_NM}</td>
	                    <th>조회</th>
	                    <td>${list[0].VIEW_CNT}</td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <%-- <td colspan="6" class="tbl-content">${list[0].CONTS}</td> --%>
                        <td colspan="6" class="tbl-content"><pre><c:out value="${list[0].CONTS}" /></pre></td>
                    </tr>
                    <tr>
                        <th>첨부파일</th>
                        <td colspan="5"><p class="file-download c-gray">첨부파일이 없습니다</p></td>
                    </tr>
                </tbody>
            </table>

            <!-- 답변글 //-->
            <table class="tbl-view reply" id="replyTable">
                <colgroup>
                    <col style="width: 8%">
                    <col style="">
                    <col style="width: 8%">
                    <col style="">
                </colgroup>
                <caption>1:1 문의 상세페이지</caption>
                <thead>
                    <tr>
                        <th colspan="4" class="title"><img src="../images/secp/ico_reply.svg" class="ico-reply">${list[0].TITLE}</th>
                    </tr>
                    <tr>
                        <th>작성일</th>
                        <td>${list[0].REPLY_DT}</td>
                        <th>작성자</th>
                        <td>${list[0].REPLY_NM}</td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="4" class="tbl-content">
                            ${list[0].REPLY_CONTS}
                        </td>
                    </tr>
                    <tr>
                        <th>첨부파일</th>
                        <td colspan="3"><p class="file-download"><img src="../images/secp/ico_file.svg" alt="" class="ico"><a href="#">첨부파일.hwp</a><small>(8KB)</small></p></td>
                    </tr>
                </tbody>
            </table>
            <!--// 답변글 -->

            <div class="t-right mb30">
                <a href="/board/boardIndex.do?type=3" class="btn btn-gray">목록</a>
            </div>

            <table class="tbl-view prevnext">
                <colgroup>
                    <col style="width: 15%">
                    <col>
                </colgroup>
                <caption>1:1문의 이전글 다음글</caption>
                <tbody>
                    <tr id="nextPage">
                        <th>다음글 <img src="../images/secp/ico_page_next.svg" alt="" class="ico-up"></th>
                        <td><a href="/board/boardDetail.do?as=${list[0].plus}&type=3">${list[0].plusTITLE}</a></td>
                    </tr>
                    <tr id="beforePage">
                        <th>이전글 <img src="../images/secp/ico_page_prev.svg" alt="" class="ico-down"></th>
                        <td><a href="/board/boardDetail.do?as=${list[0].minus}&type=3">${list[0].minusTITLE}</a></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <!--// 콘텐츠 영역 -->

        <!-- 푸터 영역 //-->
        <%@ include file="/WEB-INF/jsp/programs/footer.jsp" %>
        <!--// 푸터 영역 -->
    </div>
</body>

</html>