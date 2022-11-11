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

    <link rel="stylesheet" type="text/css" href="/css/secp/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/tower-file-input.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/common.css">
    
    <script src="/js/secp/jquery-1.12.4.min.js"></script>
	<script src="/js/secp/jquery-ui.min.js"></script>
	<script src="/js/secp/tower-file-input.js"></script>
	<script src="/js/secp/common.js"></script>
	<script src="/js/secp/mybiz/popup/biz001/bizGiveup.js"></script>
</head>

<body>
<div class="pop-wrap">
    <div class="pop-head">
        <h1>사업 포기 신청</h1>
        <button type="button" class="btn-close">닫기</button>
    </div>    
    <div class="pop-body">

        <div class="apply-write">
            <div class="apply-write-inner">
                
                <div class="apply-write-item">
                    <h4 class="write-stit2">포기신청서 작성</h4>
                    <table class="tbl-basic">
                        <colgroup>
                            <col style="width: 20%;">
                            <col>
                        </colgroup>
                        <caption>포기신청서 작성</caption>
                        <tbody>
                            <tr>
                                <th>신청분야</th>
                                <td>
                                    <label class="mr20"><input type="radio" name="category" readonly="readonly" value=""> 점포환경 개선</label>
                                    <label class="mr20"><input type="radio" name="category" readonly="readonly" value=""> 시스템 개선</label>
                                    <label class="mr20"><input type="radio" name="category" readonly="readonly" value=""> 홍보·광고</label>
                                </td>
                            </tr>
                            <tr>
                                <th>포기사유</th>
                                <td><textarea class="w100p" id="reason" placeholder="사업 포기사유를 입력해 주세요" style="height: 8em;"></textarea></td>
                            </tr>
                        </tbody>
                    </table>
                    <p class="t-center">상기 본인은 위와 같이 <strong>2022년 경기도 소상공인 경영환경 개선사업</strong> 의 (신청)포기를 확인합니다.</p>
                </div>

                <div class="btn-step-wrap mt0">
                    <a href="#" class="btn-step-round gray" id="btn-cancel">취소</a>
                    <a href="#" class="btn-step-round" id="btn-submit">신청하기</a>
                </div>
                
            </div>

        </div>
    </div>
</div>
    
</body>

</html>

