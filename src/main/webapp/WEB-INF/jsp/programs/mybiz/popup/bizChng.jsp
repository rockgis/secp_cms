<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta property="og:image" content="">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>경기도 소상공인 종합지원 플랫폼</title>

    <link rel="stylesheet" type="text/css" href="/css/secp/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/tower-file-input.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/common.css">
    
	<script src="/js/secp/jquery-1.12.4.min.js"></script>
	<script src="/js/secp/jquery-ui.min.js"></script>
	<script src="/js/secp/tower-file-input.js"></script>
	<script src="/js/secp/common.js"></script>
	<script>
	    $(function () {
	        // 파일 업로드
	        $('input[type=file]').fileInput();
	    });
	</script>
</head>

<body>
<div class="pop-wrap">
    <div class="pop-head">
        <h1>사업변경 승인 신청</h1>
        <button type="button" class="btn-close">닫기</button>
    </div>    
    <div class="pop-body">

        <div class="apply-write">
            <div class="apply-write-inner">

                <div class="apply-write-item">
                    <h4 class="write-stit2">변경신청 개요</h4>
                    <table class="tbl-basic">
                        <colgroup>
                            <col style="width: 25%;">
                            <col>
                        </colgroup>
                        <caption>변경신청 개요</caption>
                        <tbody>
                            <tr>
                                <th>신청분야</th>
                                <td>
                                    <label class="mr20"><input type="checkbox" name="category" checked> 점포환경 개선</label>
                                    <label class="mr20"><input type="checkbox" name="category"> 시스템 개선</label>
                                    <label class="mr20"><input type="checkbox" name="category"> 홍보·광고</label>
                                </td>
                            </tr>
                            <tr>
                                <th>포기사유</th>
                                <td><textarea class="w100p" placeholder="사업 변경사유를 입력해 주세요" style="height: 8em;"></textarea></td>
                            </tr>
                            <tr>
                                <th>변경내용</th>
                                <td>
                                    <label class="mr20"><input type="checkbox" name="" checked> 시공업체 변경</label>
                                    <label class="mr20"><input type="checkbox" name=""> 소요비용 변경</label>
                                    <label class="mr20"><input type="checkbox" name=""> 시공내용 변경</label>
                                    <label class="mr20"><input type="checkbox" name=""> 기타 변경</label>
                                </td>
                            </tr>
                            <tr>
                                <th>변경 후 시공완료 예정일</th>
                                <td><div class="flexline2"><input type="text" class="inp datepicker w100p"> <span class="ml5">까지</span></div></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <div class="apply-write-item">
                    <h4 class="write-stit2">변경 전 정보</h4>
                    <table class="tbl-basic mb30">
                        <colgroup>
                            <col style="width: 25%;">
                            <col>
                        </colgroup>
                        <caption>변경 전 정보</caption>
                        <tbody>
                            <tr>
                                <th>시공업체명</th>
                                <td><input type="text" class="inp w100p" value="가나다라마바사회사" disabled></td>
                            </tr>
                            <tr>
                                <th>사업자번호</th>
                                <td><input type="text" class="inp w100p" value="123-45-67890" disabled></td>
                            </tr>
                            <tr>
                                <th>전화번호</th>
                                <td><input type="text" class="inp w100p" value="02-123-4567" disabled></td>
                            </tr>
                            <tr>
                                <th>시공(제작)내역</th>
                                <td><input type="text" class="inp w100p" value="블라블라" disabled></td>
                            </tr>
                            <tr>
                                <th>공급가</th>
                                <td><div class="flexline"><input type="text" class="inp w100p" value="10,000,000" disabled><span class="pl5">원</span></div></td>
                            </tr>
                            <tr>
                                <th>부가세</th>
                                <td><div class="flexline"><input type="text" class="inp w100p" value="1,000,000" disabled><span class="pl5">원</span></div></td>

                            </tr>
                            <tr>
                                <th>합계</th>
                                <td><div class="flexline"><input type="text" class="inp w100p" value="11,000,000" disabled><span class="pl5">원</span></div></td>

                            </tr>
                            <tr>
                                <th>시공견적서</th>
                                <td>
                                    <img alt="" src="/images/secp/thumb1.jpg" alt="" class="w200">
                                </td>
                            </tr>
                            <tr>
                                <th>사업자등록증</th>
                                <td>
                                    <img alt="" src="/images/secp/thumb1.jpg" alt="" class="w200">
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <h4 class="write-stit2">변경 후 정보</h4>
                    <table class="tbl-basic">
                        <colgroup>
                            <col style="width: 25%;">
                            <col>
                        </colgroup>
                        <caption>변경 후 정보</caption>
                        <tbody>
                            <tr>
                                <th><span class="i-require">*</span> 시공업체명</th>
                                <td><input type="text" class="inp w100p"></td>
                            </tr>
                            <tr>
                                <th><span class="i-require">*</span> 사업자번호</th>
                                <td><input type="text" class="inp w100p"></td>
                            </tr>
                            <tr>
                                <th><span class="i-require">*</span> 전화번호</th>
                                <td><input type="text" class="inp w100p"></td>
                            </tr>
                            <tr>
                                <th><span class="i-require">*</span> 시공(제작)내역</th>
                                <td><input type="text" class="inp w100p"></td>
                            </tr>
                            <tr>
                                <th><span class="i-require">*</span> 공급가</th>
                                <td><div class="flexline"><input type="text" class="inp w100p"><span class="pl5">원</span></div></td>
                            </tr>
                            <tr>
                                <th><span class="i-require">*</span> 부가세</th>
                                <td><div class="flexline"><input type="text" class="inp w100p"><span class="pl5">원</span></div></td>
                            </tr>
                            <tr>
                                <th>합계</th>
                                <td><div class="flexline"><input type="text" class="inp w100p"><span class="pl5">원</span></div></td>
                            </tr>
                            <tr>
                                <th><span class="i-require">*</span> 시공견적서</th>
                                <td>
                                    <div class="tower-file">
                                        <input type="file" id="photoinp7">
                                        <label for="photoinp7" class="tower-file-button">
                                            <span>파일첨부</span>
                                        </label>
                                        <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th><span class="i-require">*</span> 사업자등록증</th>
                                <td>
                                    <div class="tower-file">
                                        <input type="file" id="photoinp7">
                                        <label for="photoinp7" class="tower-file-button">
                                            <span>파일첨부</span>
                                        </label>
                                        <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <p class="mt20 mb50 c-darkred indent">※ 시공업체 변경, 주요 시공내용 변경시에는 사전에 승인을 받아야 합니다.</p>
                </div>

                <div class="btn-step-wrap mt0">
                    <a href="apply1_4.html#apply-write" class="btn-step-round gray">취소</a>
                    <a href="apply1_6.html#apply-write" class="btn-step-round">신청하기</a>
                </div>
                
            </div>

        </div>
    </div>
</div>
    
</body>

</html>

