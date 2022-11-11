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
        <h1>사업 변경승인 신청</h1>
        <button type="button" class="btn-close">닫기</button>
    </div>    
    <div class="pop-body">

        <div class="apply-write">
            <div class="apply-write-inner">

                <div class="apply-write-item">
                    <h4 class="write-stit2">변경신청서 작성</h4>
                    <table class="tbl-basic">
                        <colgroup>
                            <col style="width: 12%;">
                            <col style="width: 12%;">
                            <col>
                        </colgroup>
                        <caption>변경신청서 작성</caption>
                        <tbody>
                            <tr>
                                <th colspan="2">신청분야</th>
                                <td>
                                    <label class="mr20"><input type="checkbox" name="category" checked> 재기 장려금</label>
                                    <label class="mr20"><input type="checkbox" name="category"> 점포 철거비</label>
                                </td>
                            </tr>
                            <tr>
                                <th rowspan="2">구분</th>
                                <th>변경 전</th>
                                <td><textarea class="w100p" placeholder="내용을 입력해 주세요" style="height: 8em;"></textarea></td>
                            </tr>
                            <tr>
                                <th>변경 후</th>
                                <td><textarea class="w100p" placeholder="내용을 입력해 주세요" style="height: 8em;"></textarea></td>
                            </tr>
                            <tr>
                                <th colspan="2">변경 사유</th>
                                <td><textarea class="w100p" placeholder="사업 변경 사유를 입력해 주세요" style="height: 8em;"></textarea></td>
                            </tr>
                        </tbody>
                    </table>
                    <p>※ 상기 본인은 위와 같이 <strong>2022년 경기도 소상공인 사업정리 지원사업</strong>의 변경 승인을 요청합니다.</p>
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