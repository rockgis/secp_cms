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
        <h1>완료 보고서</h1>
        <button type="button" class="btn-close">닫기</button>
    </div>
    <div id="first">
        <div class="pop-body">

            <div class="apply-write">
                <div class="apply-write-inner">

                    <div class="apply-write-item">
                        <h4 class="write-stit2">체납내역 및 계좌 정보 확인</h4>
                        <table class="tbl-basic">
                            <colgroup>
                                <col style="width: 12%;">
                                <col style="width: 5%;">
                                <col>
                            </colgroup>
                            <caption>체납내역 및 계좌 정보 확인</caption>
                            <tbody>
                                <tr>
                                    <th colspan="2">지방세 체납 여부</th>
                                    <td>
                                        <input type="text" class="inp w100p" disabled>
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="2">국세 체납 여부</th>
                                    <td>
                                        <input type="text" class="inp w100p" disabled>
                                    </td>
                                </tr>
                                <tr>
                                    <th rowspan="3" class="bob0">지원금 지급처<p class="small">(본인계좌)</p></th>
                                    <th>예금주</th>
                                    <td colspan="3">
                                        <input type="text" class="inp w100p" disabled>
                                    </td>
                                </tr>
                                <tr>
                                    <th>은행명</th>
                                    <td colspan="3">
                                        <input type="text" class="inp w100p" disabled>
                                    </td>
                                </tr>
                                <tr>
                                    <th>계좌번호</th>
                                    <td colspan="3">
                                        <input type="text" class="inp w100p" disabled>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="notice-box t-center"><img src="/images/secp/ico_alert.svg" alt="" class="ico">
                        <strong>“지급기준”</strong>에 맞지 않는 항목이 있습니다. 해당 항목을 확인 바랍니다.</div>

                    <div class="btn-step-wrap">
                        <button type="button" class="btn-step-round">마이데이터 조회</button>
                    </div>

                    <div class="apply-write-item">
                        <div class="box-agreetxt">
                            마이데이터 개인정보 수집/이용 동의, 마이데이터 제3자 제공 동의
                        </div>
                        <div class="t-center mb20">
                            <label class="mr20"><input type="radio" name="radio1" checked> 동의합니다</label>
                            <label><input type="radio" name="radio1"> 동의하지 않습니다</label>
                        </div>
                        <table class="tbl-basic">
                            <colgroup>
                                <col style="width: 25%;">
                                <col>
                            </colgroup>
                            <caption>마이데이터 개인정보 수집/이용 동의, 마이데이터 제3자 제공 동의</caption>
                            <tbody>
                                <tr>
                                    <th>이름</th>
                                    <td>
                                        <input type="text" class="inp w100p">
                                    </td>
                                </tr>
                                <tr>
                                    <th>주민등록번호</th>
                                    <td>
                                        <div class="flexline">
                                            <input type="text" class="inp w50p">
                                            <span class="p5"> - </span>
                                            <input type="text" class="inp w50p">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>사업자등록번호</th>
                                    <td>
                                        <input type="text" class="inp w100p">
                                    </td>
                                </tr>
                                <tr>
                                    <th>은행</th>
                                    <td>
                                        <select class="w100p">
                                            <option></option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>계좌번호</th>
                                    <td>
                                        <input type="text" class="inp w100p">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="t-center pt10">
                            <button type="button" class="btn btn-black mr10">확인</button>
                            <button type="button" class="btn btn-gray">최소</button>
                        </div>
                    </div>

                </div>

                <div class="btn-step-wrap  mt0">
                    <a href="#none" class="btn-step-round gray">취소</a>
                    <a href="#none" class="btn-step-round btn-darkgray"><img src="/images/secp/ico_save.svg" alt=""> 임시저장</a>
                    <a href="#none" class="btn-step-round">다음 단계 <img src="/images/secp/ico_bt_arrow_right.svg" alt=""></a>
                </div>

            </div>
        </div>
    </div>
    <div id="second">
        <div class="pop-body">

            <div class="apply-write">
                <div class="apply-write-inner">

                    <div class="apply-write-item">
                        <h4 class="write-stit2">체납내역 및 계좌 정보 확인</h4>
                        <table class="tbl-basic">
                            <colgroup>
                                <col style="width: 12%;">
                                <col style="width: 5%;">
                                <col>
                            </colgroup>
                            <caption>체납내역 및 계좌 정보 확인</caption>
                            <tbody>
                            <tr>
                                <th colspan="2">지방세납세증명서</th>
                                <td>
                                    <div class="tower-file">
                                        <input type="file" id="photoinp1">
                                        <label for="photoinp1" class="tower-file-button">
                                            <span>파일첨부</span>
                                        </label>
                                        <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th rowspan="3" class="bob0">지원금 지급처<p class="small">(본인계좌)</p></th>
                                <th>통장사본</th>
                                <td>
                                    <div class="tower-file">
                                        <input type="file" id="photoinp2">
                                        <label for="photoinp2" class="tower-file-button">
                                            <span>파일첨부</span>
                                        </label>
                                        <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>은행명</th>
                                <td>
                                    <select class="w100p">
                                        <option></option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>계좌번호</th>
                                <td>
                                    <input type="text" class="inp w100p">
                                </td>
                            </tr>
                            </tbody>
                        </table>

                        <p>※ 신청인 본인계좌만 가능합니다 <span class="small">(*시공업체 통장, 부부명의 통장, 타인 명의 통장으로 지급 불가 합니다)</span>
                    </div>

                </div>

                <div class="btn-step-wrap mt0">
                    <a href="#none" class="btn-step-round gray">취소</a>
                    <a href="#none" class="btn-step-round btn-darkgray"><img src="/images/secp/ico_save.svg" alt=""> 임시저장</a>
                    <a href="#none" class="btn-step-round">다음 단계 <img src="/images/secp/ico_bt_arrow_right.svg" alt=""></a>
                </div>

            </div>
        </div>
    </div> <!-- second //-->

    <div id="third">
        <div class="pop-body">

            <div class="apply-write">
                <div class="apply-write-inner">

                    <div class="apply-write-item">
                        <h4 class="write-stit2">완료보고서 작성</h4>
                        <table class="tbl-basic">
                            <colgroup>
                                <col style="width: 15%;">
                                <col>
                            </colgroup>
                            <caption>완료보고서 작성</caption>
                            <tbody>
                            <tr>
                                <th>단위사업</th>
                                <td>
                                    <label class="mr20"><input type="checkbox" name=""> 점포환경 개선</label>
                                    <label class="mr20"><input type="checkbox" name=""> 시스템 개선</label>
                                    <label class="mr20"><input type="checkbox" name=""> 홍보·광고</label>
                                </td>
                            </tr>
                            <tr>
                                <th rowspan="4" class="bob0">시공(제작)내용</p></th>
                                <td class="hmax">
                                    <div class="flexline mb10">
                                        <span class="pr10">내용</span>
                                        <input type="text" class="inp w100p">
                                    </div>
                                    <div class="flexline">
                                        <span class="pr10">기간</span>
                                        <input type="text" class="inp w50p datepicker">
                                        <span class="pl5 pr5"> ~ </span>
                                        <input type="text" class="inp w50p datepicker">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="hmax">
                                    <div class="flexline mb10">
                                        <span class="pr10">내용</span>
                                        <input type="text" class="inp w100p">
                                    </div>
                                    <div class="flexline">
                                        <span class="pr10">기간</span>
                                        <input type="text" class="inp w50p datepicker">
                                        <span class="pl5 pr5"> ~ </span>
                                        <input type="text" class="inp w50p datepicker">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="hmax">
                                    <div class="flexline mb10">
                                        <span class="pr10">내용</span>
                                        <input type="text" class="inp w100p">
                                    </div>
                                    <div class="flexline">
                                        <span class="pr10">기간</span>
                                        <input type="text" class="inp w50p datepicker">
                                        <span class="pl5 pr5"> ~ </span>
                                        <input type="text" class="inp w50p datepicker">
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="apply-write-item">
                        <h4 class="write-stit2">시공(제작) 결과</h4>
                        <table class="tbl-basic">
                            <colgroup>
                                <col style="width: 50%;">
                                <col>
                            </colgroup>
                            <caption>시공(제작) 결과</caption>
                            <tbody>
                            <tr>
                                <th class="t-center">개선 전</th>
                                <th class="t-center">개선 후</th>
                            </tr>
                            <tr>
                                <td class="t-center hmax">
                                    <div class="tower-file">
                                        <input type="file" id="photoinp1">
                                        <label for="photoinp1" class="tower-file-button">
                                            <span>사진 업로드</span>
                                        </label>
                                        <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                    </div>
                                </td>
                                <td class="t-center hmax">
                                    <div class="tower-file">
                                        <input type="file" id="photoinp2">
                                        <label for="photoinp2" class="tower-file-button">
                                            <span>사진 업로드</span>
                                        </label>
                                        <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="t-center hmax">
                                    <div class="tower-file">
                                        <input type="file" id="photoinp3">
                                        <label for="photoinp1" class="tower-file-button">
                                            <span>사진 업로드</span>
                                        </label>
                                        <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                    </div>
                                </td>
                                <td class="t-center hmax">
                                    <div class="tower-file">
                                        <input type="file" id="photoinp4">
                                        <label for="photoinp2" class="tower-file-button">
                                            <span>사진 업로드</span>
                                        </label>
                                        <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="t-center hmax">
                                    <div class="tower-file">
                                        <input type="file" id="photoinp5">
                                        <label for="photoinp1" class="tower-file-button">
                                            <span>사진 업로드</span>
                                        </label>
                                        <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                    </div>
                                </td>
                                <td class="t-center hmax">
                                    <div class="tower-file">
                                        <input type="file" id="photoinp6">
                                        <label for="photoinp2" class="tower-file-button">
                                            <span>사진 업로드</span>
                                        </label>
                                        <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                    </div>
                                </td>
                            </tr>

                            </tbody>
                        </table>

                    </div>

                </div>

                <div class="btn-step-wrap mt0">
                    <a href="#none" class="btn-step-round gray"><img src="/images/secp/ico_bt_arrow_left.svg" alt=""> 이전 단계</a>
                    <a href="#none" class="btn-step-round btn-darkgray"><img src="/images/secp/ico_save.svg" alt=""> 임시저장</a>
                    <a href="#none" class="btn-step-round">다음 단계 <img src="/images/secp/ico_bt_arrow_right.svg" alt=""></a>
                </div>

            </div>
        </div>
    </div> <!-- third // -->

    <div id="fourth">
        <div class="pop-body">

            <div class="apply-write">
                <div class="apply-write-inner">

                    <div class="apply-write-item">
                        <h4 class="write-stit2">증빙서류 제출</h4>
                        <table class="tbl-basic">
                            <colgroup>
                                <col style="width: 22%;">
                                <col>
                            </colgroup>
                            <caption>필수서류 제출</caption>
                            <thead>
                            <tr>
                                <th colspan="2" class="hmin t-center">필수서류 제출</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th>시공(제작)업체 사업자등록증</th>
                                <td>
                                    <div class="tower-file">
                                        <input type="file" id="photoinp1">
                                        <label for="photoinp1" class="tower-file-button">
                                            <span>파일첨부</span>
                                        </label>
                                        <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>온라인 입금증 <span class="small">* 해당 거래시</span></th>
                                <td>
                                    <div class="tower-file">
                                        <input type="file" id="photoinp2">
                                        <label for="photoinp2" class="tower-file-button">
                                            <span>파일첨부</span>
                                        </label>
                                        <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>통자거래내역 사본 <span class="small">* 해당 거래시</span></th>
                                <td>
                                    <div class="tower-file">
                                        <input type="file" id="photoinp3">
                                        <label for="photoinp3" class="tower-file-button">
                                            <span>파일첨부</span>
                                        </label>
                                        <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>전자세금계산서 <span class="small">* 해당 거래시</span></th>
                                <td>
                                    <div class="tower-file">
                                        <input type="file" id="photoinp4">
                                        <label for="photoinp4" class="tower-file-button">
                                            <span>파일첨부</span>
                                        </label>
                                        <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>거래명세서 <span class="small">* 해당 거래시</span></th>
                                <td>
                                    <div class="tower-file">
                                        <input type="file" id="photoinp5">
                                        <label for="photoinp5" class="tower-file-button">
                                            <span>파일첨부</span>
                                        </label>
                                        <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>

                        <table class="tbl-basic">
                            <colgroup>
                                <col style="width: 22%;">
                                <col>
                            </colgroup>
                            <caption>간판시공 대상자 필수  추가서류 제출</caption>
                            <thead>
                            <tr>
                                <th colspan="2" class="hmin t-center">간판시공 대상자 필수  추가서류 제출</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th>시공업체의 옥외광고업 등록증</th>
                                <td>
                                    <div class="tower-file">
                                        <input type="file" id="photoinp6">
                                        <label for="photoinp6" class="tower-file-button">
                                            <span>파일첨부</span>
                                        </label>
                                        <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>옥외광고물신고필증 대상여부 <br>
                                    <label class="mr20"><input type="radio" name="radio1"> 예</label>
                                    <label><input type="radio" name="radio1"> 아니오</label>
                                </th>
                                <td>
                                    <div class="tower-file">
                                        <input type="file" id="photoinp7">
                                        <label for="photoinp7" class="tower-file-button">
                                            <span>파일첨부</span>
                                        </label>
                                        <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                    </div>
                                    <p class="c-blue">하단의 옥외광고물표시 신고(허가) 비대상 확인서를 작성해 주세요.</p>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <p class="mt20 c-gray">※ 필수서류 누락시 지원금 지급이 지연될수 있습니다</p>
                    </div>

                    <div class="apply-write-item">
                        <h4 class="write-stit2">옥외 광고물 표시 신고(허가) 비대상 확인서 <span class="small">(해당자의 경우 입력)</span></h4>
                        <table class="tbl-basic">
                            <colgroup>
                                <col style="width: 22%;">
                                <col>
                            </colgroup>
                            <caption>필수서류 제출</caption>
                            <tbody>
                            <tr>
                                <th>업체명</th>
                                <td>
                                    <input type="text" class="inp w100p">
                                </td>
                            </tr>
                            <tr>
                                <th>대표자</th>
                                <td>
                                    <input type="text" class="inp w100p">
                                </td>
                            </tr>
                            <tr>
                                <th>사업자등록번호</th>
                                <td>
                                    <input type="text" class="inp w100p">
                                </td>
                            </tr>
                            <tr>
                                <th>연락처</th>
                                <td>
                                    <input type="text" class="inp w100p">
                                </td>
                            </tr>
                            <tr>
                                <th>옥외광고물 종류</th>
                                <td><label class="mr20"><input type="checkbox"> 간판</label>
                                    <label><input type="checkbox"> 기타</label>
                                    <input type="text" class="inp w100p mt10" placeholder="기타 내용을 입력해 주세요">
                                </td>
                            </tr>
                            <tr>
                                <th>비대상 근거<br><p class="small">(필수기재)</p></th>
                                <td><label class="mr20"><input type="checkbox"> 신고(허가)대상의 사이즈 및 광고물이 아닌 경우</label>
                                    <label class="mr20"><input type="checkbox"> 간판 내부의 LED만 교체했을 경우</label>
                                    <label><input type="checkbox"> 기타 구체적인 사유</label>
                                    <input type="text" class="inp w100p mt10" placeholder="기타 내용을 입력해 주세요">
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                </div>

                <div class="btn-step-wrap mt0">
                    <a href="#none" class="btn-step-round gray"><img src="/images/secp/ico_bt_arrow_left.svg" alt=""> 이전 단계</a>
                    <a href="#none" class="btn-step-round btn-darkgray"><img src="/images/secp/ico_save.svg" alt=""> 임시저장</a>
                    <a href="#none" class="btn-step-round btn-red">제출하기 <img src="/images/secp/ico_bt_arrow_right.svg" alt=""></a>
                </div>

            </div>
        </div>
    </div> <!-- fourth // -->
</div>
    
</body>

</html>