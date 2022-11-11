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
    <link rel="stylesheet" type="text/css" href="/css/secp/tower-file-input.css">

	<script src="/js/secp/jquery-1.12.4.min.js"></script>
    <script src="/js/secp/jquery.splitter.js"></script>
    <script src="/js/secp/jquery-ui.min.js"></script>
    <script src="/js/secp/tower-file-input.js"></script> 
    <script src="/js/secp/common.js"></script>
    <script>
        $(function () {
            // 파일 업로드
            $('input[type=file]').fileInput(); 
        });
	  	
		function goInsert(e){
			e.preventDefault();
			
			if ($('meta[name="_csrf"]').length !== 0) {
	    		$('#csrf').val($('meta[name="_csrf"]').attr('content'));
	    	}
		    
			const formData = new FormData($('#frm')[0]);
			$.ajax({
			  url : "/board/boardInquiryRegister.do",
			  type : "post", 
			  data : formData,
			  processData: false,
	    	  contentType: false,
			  success : function() { location.href = '/board/boardIndex.do?type=3'},
			  error : function(){
				  alert("error1234");
			  }
		  });
		}
		
    </script>
</head>

<body>
<!-- <form name="wFrm" id="wFrm" action="boardInquiryRegister.do" method="post" enctype="multipart/form-data"> -->
<form name="frm" id="frm" encType="multipart/form-data">
	<input type="hidden" id="csrf" name="_csrf" value="">
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

            <table class="tbl-write">
                <caption>1:1 문의 작성</caption>
                <colgroup>
                    <col style="width: 15%;">
                    <col>
                </colgroup>
                <tbody>
                    <tr>
                        <th>작성자</th>
                        <td>TEST BOY</td> <!-- 로그인 정보로 수정 예정 -->
                    </tr>
                    <tr>
                        <th>제목</th>
                        <td class="txt"><input name="title" id="title" type="text" class="inp w100p"></td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td><pre><textarea id="conts" name="conts" class="cont w100p"></textarea></pre></td>
                    </tr>
                    <tr>
                        <th>첨부파일</th>
                        <td>
                            <div class="tower-file">
                                <input type="file" id="file1">
                                <label for="file1" class="tower-file-button">
                                    <span>파일첨부</span>
                                </label>
                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                            </div>
                        </td>
                    </tr>

                </tbody>
            </table>

            <div class="t-right">
                <a href="/board/boardIndex.do?type=3" class="btn btn-gray">취소</a>
                <a href="#" class="btn btn-blue" onclick="goInsert(event)">저장</a>
            </div>
            
        </div>
        <!--// 콘텐츠 영역 -->

        <!-- 푸터 영역 //-->
        <%@ include file="/WEB-INF/jsp/programs/footer.jsp" %>
        <!--// 푸터 영역 -->
    </div>
</form>
</body>
</html>