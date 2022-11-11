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
    
	<script src="js/secp/jquery-1.12.4.min.js"></script>
	<script src="js/secp/jquery-ui.min.js"></script>
	<script src="js/secp/tower-file-input.js"></script>
	<script src="js/secp/common.js"></script>
	<script>
	    $(function () {
	        // 파일 업로드
	        $('input[type=file]').fileInput({
	            imagePreview: false
	        });
	    });
	</script>    
</head>

<body>
<div class="pop-wrap">
    <div class="pop-head">
        <h1>지원금 지급신청</h1>
        <button type="button" class="btn-close">닫기</button>
    </div>    
    <div class="pop-body">

        <div class="apply-write">
            <div class="apply-write-inner">
                
                <div class="apply-write-item">
                    <h4 class="write-stit2">지급신청서 제출</h4>
                    <table class="tbl-basic">
                        <colgroup>
                            <col style="width: 15%;">
                            <col style="width: 20%;">
                            <col>
                        </colgroup>
                        <caption>지급신청서 제출</caption>
                        <tbody>
                            <tr>
                                <th rowspan="3">시공업체 <br>총 소요비용</th>
                                <th>공급가</th>
                                <td><div class="flexline"><input type="text" class="inp w100p" value="3,000,000"><span class="pl5">원</span></div></td>
                            </tr>
                            <tr>
                                <th>부가세</th>
                                <td><div class="flexline"><input type="text" class="inp w100p" value="300,000"><span class="pl5">원</span></div></td>
                            </tr>
                            <tr>
                                <th>총 비용</th>
                                <td><div class="flexline"><input type="text" class="inp w100p" value="3,300,000"><span class="pl5">원</span></div></td>
                            </tr>
                            <tr>
                                <th rowspan="4">신청자 부담<br>총 소요비용</th>
                                <th>지원 신청금</th>
                                <td><div class="flexline"><input type="text" class="inp w100p" value="3,000,000"><span class="pl5">원</span></div></td>
                            </tr>
                            <tr>
                                <th>자부담금</th>
                                <td><div class="flexline"><input type="text" class="inp w100p" value="0"><span class="pl5">원</span></div></td>

                            </tr>
                            <tr>
                                <th>부가세</th>
                                <td><div class="flexline"><input type="text" class="inp w100p" value="300,000"><span class="pl5">원</span></div></td>

                            </tr>
                            <tr>
                                <th>신청인 총부담금</th>
                                <td><div class="flexline"><input type="text" class="inp w100p" value="3,300,000"><span class="pl5">원</span></div></td>

                            </tr>
                            <tr>
                                <th rowspan="4">시공업체</th>
                                <th>시공업체명1</th>
                                <td><input type="text" class="inp w100p"></td>
                            </tr>
                            <tr>
                                <th>시공업체 연락처</th>
                                <td><input type="text" class="inp w100p"></td>
                            </tr>
                            <tr>
                                <th>시공업체명2</th>
                                <td><input type="text" class="inp w100p"></td>
                            </tr>
                            <tr>
                                <th>시공업체 연락처</th>
                                <td><input type="text" class="inp w100p"></td>
                            </tr>
                            <tr>
                                <th rowspan="3" class="bob0">지원금 지급처 <p class="small">(본인계좌)</p></th>
                                <th>은행명</th>
                                <td><input type="text" class="inp w100p"></td>
                            </tr>
                            <tr>
                                <th>예금주</th>
                                <td><input type="text" class="inp w100p"></td>
                            </tr>
                            <tr>
                                <th>계좌번호</th>
                                <td><input type="text" class="inp w100p"></td>
                            </tr>
                            
                        </tbody>
                    </table>
                    
                </div>
                
            </div>

            <div class="btn-step-wrap mt0">
                <a href="#none" class="btn-step-round gray">취소</a>
                <a href="#none" class="btn-step-round btn-red">신청하기</a>
            </div>
            

        </div>
    </div>
</div>


    
</body>

</html>
