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
    <script src="/js/secp/biz/bizCmm.js"></script>
    <script src="/js/secp/biz/biz002.js"></script>
    <script>
    	window['APPLY_TYPE'] = '${applyType}';
    
        $(function () {
            $('.apply-wrap').width('100%').height('100%').split({
                orientation: 'vertical',
                limit: 0,
                position: '50%',
                percent: true
            });
            $(window).resize(function () {
                var width = window.outerWidth;
                if (width >= 1200){
                    $('.apply-info').css({left: '0%', width: '49.4271%'});
                    $('.apply-write').css({left: '50.2083%', width: '49.7917%'});
                    $('.vsplitter').css({left: '49.4271%'});
                }
            });

            $("#ckAgreeAll").on("click", function(){
                if ($(this).is(":checked")){
                    $("input[value=Y]").prop('checked', true);
                    $("input[value=N]").prop('checked', false);
                } else {
                    $("input[value=Y]").prop('checked', false);
                    $("input[value=N]").prop('checked', true);
                }
            });
            
        });
    </script>
</head>

<body>
    <div class="wrap apply">
        <!-- 상단 영역 //-->
        <%@ include file="/WEB-INF/jsp/programs/header.jsp" %>
        <!--// 상단 영역 -->

        <!-- 콘텐츠 영역 //-->
        <div class="sub-content">
            <a href="#" class="btn-allproject"><i>+</i> 전체 <span>지원사업</span></a>
            <div class="apply-wrap">
                <!-- 지원사업 정보 //-->
                <div class="apply-info">
                    <div class="apply-info-inner">
                        <div class="apply-info-head" style="background-image: url(/images/secp/project_head1.jpg);">
                            <h3>소상공인 사업정리 재기장려금 지원</h3>
                            <p>경기 악화 등으로 폐업한 도내 소상공인을 위해 경기도가 달립니다!</p>
                        </div>
                        <div class="apply-info-body">
                            <div class="apply-info-cont">
                                <ul class="linemap">
                                    <li><a href="index.html"><img src="/images/secp/ico_home.png" alt="홈"></a></li>
                                    <li>지원 신청</li>
                                    <li>온라인 접수</li>
                                    <li>소상공인 사업정리 재기장려금 지원</li>
                                </ul>
                                <h4 class="apply-info-stit">지원 정보</h4>
                                <img src="/images/secp/project_info2.png" alt="" class="w100p">
                            </div>
                        </div>
                    </div>
                </div>
                <!--// 지원사업 정보 -->

                <!-- 지원사업 신청 //-->
                <div class="apply-write" id="apply-write">
                    <div class="apply-write-inner">
                        <p class="txt1"><strong>소상공인 사업정리 재기장려금</strong> 지원을 신청하세요</p>
                        <ul class="step-list">
                            <li data-idx="0"><img src="/images/secp/ico_step1_on.png" alt="">개인정보 활용 동의</li>
                            <c:if test="${applyType eq 'MYDATA' }">
                            <li data-idx="1"><img src="/images/secp/ico_step2.png" alt="">자격검증</li>
                            </c:if>
                            <li data-idx="2"><img src="/images/secp/ico_step3_on.png" alt="">신청정보 입력</li>
                            <li data-idx="3"><img src="/images/secp/ico_step4.png" alt="">추가서류 제출</li>
                        </ul>
                        <div class="apply-lvl-container" data-idx="0">
                        	<div class="agree-item">
	                            <h3 class="agree-tit">행정정보 공동이용 사전동의</h3>
	                            <input type="radio" name="radio1" id="radio1-1" value="Y">
	                            <label for="radio1-1">동의합니다</label>
	                            <input type="radio" name="radio1" id="radio1-2" value="N">
	                            <label for="radio1-2">동의하지 않습니다</label>
	                            <div class="agree-txt">
	                                내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 
	                                내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 
	                            </div>
	                        </div>
	                        <div class="agree-item">
	                            <h3 class="agree-tit">중소기업 지원사업 통합관리시스템 정보활용을 위한 동의</h3>
	                            <input type="radio" name="radio2" id="radio2-1" value="Y">
	                            <label for="radio2-1">동의합니다</label>
	                            <input type="radio" name="radio2" id="radio2-2" value="N">
	                            <label for="radio2-2">동의하지 않습니다</label>
	                            <div class="agree-txt">
	                                내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 
	                                내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 
	                            </div>
	                        </div>
	                        <div class="agree-item">
	                            <h3 class="agree-tit">창업 및 유지 동의 등 책임 동의</h3>
	                            <input type="radio" name="radio3" id="radio3-1" value="Y">
	                            <label for="radio3-1">동의합니다</label>
	                            <input type="radio" name="radio3" id="radio3-2" value="N">
	                            <label for="radio3-2">동의하지 않습니다</label>
	                            <div class="agree-txt">
	                                내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 
	                                내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 
	                            </div>
	                        </div>
	                        <div class="agree-item">
	                            <h3 class="agree-tit">신청서 제출관련 책임동의</h3>
	                            <input type="radio" name="radio4" id="radio4-1" value="Y">
	                            <label for="radio4-1">동의합니다</label>
	                            <input type="radio" name="radio4" id="radio4-2" value="N">
	                            <label for="radio4-2">동의하지 않습니다</label>
	                            <div class="agree-txt">
	                                내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 
	                                내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 
	                            </div>
	                        </div>
	                        <div class="agree-item">
	                            <h3 class="agree-tit">신청정보입력 동의</h3>
	                            <input type="radio" name="radio5" id="radio5-1" value="Y">
	                            <label for="radio5-1">동의합니다</label>
	                            <input type="radio" name="radio5" id="radio5-2" value="N">
	                            <label for="radio5-2">동의하지 않습니다</label>
	                            <div class="agree-txt">
	                                내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 
	                                내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 
	                            </div>
	                        </div>
	                        <div class="agree-item">
	                            <h3 class="agree-tit">기업통합 데이터 공동 활용을 위한 제3자 정보 제공 동의</h3>
	                            <input type="radio" name="radio6" id="radio6-1" value="Y">
	                            <label for="radio6-1">동의합니다</label>
	                            <input type="radio" name="radio6" id="radio6-2" value="N">
	                            <label for="radio6-2">동의하지 않습니다</label>
	                            <div class="agree-txt">
	                                내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 
	                                내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 
	                            </div>
	                        </div>
	                        <div class="agree-item">
	                            <h3 class="agree-tit">신청기업의 법 위반 사실(부존재) 동의서</h3>
	                            <input type="radio" name="radio7" id="radio7-1" value="Y">
	                            <label for="radio7-1">동의합니다</label>
	                            <input type="radio" name="radio7" id="radio7-2" value="N">
	                            <label for="radio7-2">동의하지 않습니다</label>
	                            <div class="agree-txt">
	                                내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 
	                                내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 내용이 들어가는 영역입니다. 
	                            </div>
	                        </div>
	                        
	                        <div class="ckagreeall">
	                            <input name="ckAgreeAll" type="checkbox" id="ckAgreeAll">
	                            <label for="ckAgreeAll">개인정보 수집·이용에 관하여 모두 동의합니다.</label>
	                        </div>
                        </div>
                        
                        <form id="form">
                        	<c:if test="${applyType eq 'MYDATA' }">
	                        <div class="apply-lvl-container none" data-idx="1">
	                        	자격검증 영역
	                        </div>
	                        </c:if>
                        
                        	<input type="hidden" id="csrf" name="_csrf" value="">
	                        <div class="apply-lvl-container none" data-idx="2">
		                        <div class="write-stit1 f-clear">
		                            <h3>신청정보 입력</h3>
		                            <p>별( <span class="c-red">*</span> ) 표시는 필수 입력입니다.</p>
		                        </div>
		                        <div class="apply-write-item">
		                            <h4 class="write-stit2">대표자 및 사업자 정보</h4>
		                            <table class="tbl-basic">
		                                <colgroup>
		                                    <col style="width: 20%;">
		                                    <col>
		                                </colgroup>
		                                <caption>대표자 및 사업자 정보</caption>
		                                <tbody>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 상호명<div class="small">(법인의 경우 법인 명 기재)</div></th>
		                                        <td><input type="text" class="inp w100p" id="store-name"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 사업자등록번호</th>
		                                        <td><input type="text" class="inp w100p" id="bsns-num"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 개업일<div class="small">(개업일 기재)</div></th>
		                                        <td><input type="text" class="inp w100p datepicker" id="open-date" readonly="readonly"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 폐업일<div class="small">(폐업일 기재)</div></th>
		                                        <td><input type="text" class="inp w100p datepicker" id="close-date" readonly="readonly"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 사업장 주소</th>
		                                        <td>
		                                            <input type="text" class="inp" style="width: calc( 100% - 6em );" id="store-addr"><button type="button" class="btn btn-gray ml5">주소검색</button>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 대표자명</th>
		                                        <td><input type="text" class="inp w100p" id="rep-name"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 연락처<span class="small">( - 제외)</span></th>
		                                        <td><input type="text" class="inp w100p" id="tel"></td>
		                                    </tr>
		                                    <tr>
		                                        <th>이메일</th>
		                                        <td><input type="text" class="inp w40p"> @ <input type="text" class="inp w40p"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 주소</th>
		                                        <td>
		                                            <input type="text" class="inp" style="width: calc( 100% - 6em );"><button type="button" class="btn btn-gray ml5">주소검색</button>
		                                        </td>
		                                    </tr>
		                                </tbody>
		                            </table>
		                        </div>
		
		                        <div class="apply-write-item">
		                            <h4 class="write-stit2">旣사업지원금 수혜내역(폐업관련지원사업)</h4>
		                            <table class="tbl-basic">
		                                <colgroup>
		                                    <col style="width: 20%;">
		                                    <col>
		                                </colgroup>
		                                <caption>旣사업지원금 수혜내역(폐업관련지원사업)</caption>
		                                <tbody>
		                                    <tr>
		                                        <th>지원금 지급 기관</th>
		                                        <td>
		                                            <label class="mr15"><input type="checkbox"> 경기도시장상권진흥원</label>
		                                            <label class="mr15"><input type="checkbox"> 소상공인진흥공단</label>
		                                            <label class="mr15"><input type="checkbox"> 해당없음</label>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th>지원금 수혜 연도</th>
		                                        <td>
		                                            <label class="mr15"><input type="checkbox"> 2021년</label>
		                                            <label class="mr15"><input type="checkbox"> 2022년</label>
		                                        </td>
		                                    </tr>
		                                </tbody>
		                            </table>
		                        </div>
		
		                        <div class="apply-write-item">
		                            <h4 class="write-stit2">신청자 현재 상태</h4>
		                            <table class="tbl-basic">
		                                <colgroup>
		                                    <col style="width: 20%;">
		                                    <col>
		                                </colgroup>
		                                <caption>신청자 현재 상태</caption>
		                                <tbody>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 근로현황</th>
		                                        <td>
		                                            <label class="mr15"><input type="checkbox"> 재창업 준비중</label>
		                                            <label class="mr15"><input type="checkbox"> 구직중</label>
		                                            <label class="mr15"><input type="checkbox"> 사업체운영중</label>
		                                            <label class="mr15"><input type="checkbox"> 직장 재직중</label>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 주민등록 등본상 가구원수</th>
		                                        <td>
		                                            <label class="mr15"><input type="radio" name="radio1"> 1인</label>
		                                            <label class="mr15"><input type="radio" name="radio1"> 2인</label>
		                                            <label class="mr15"><input type="radio" name="radio1"> 3인</label>
		                                            <label class="mr15"><input type="radio" name="radio1"> 4인</label>
		                                            <label class="mr15"><input type="radio" name="radio1"> 5인</label>
		                                            <label class="mr15"><input type="radio" name="radio1"> 6인</label>
		                                            <label class="mr15"><input type="radio" name="radio1"> 7인</label>
		                                            <label class="mr15"><input type="radio" name="radio1"> 8인 이상</label>
		                                        </td>
		                                    </tr>
		                                </tbody>
		                            </table>
		                        </div>
		
		                        <div class="apply-write-item">
		                            <h4 class="write-stit2">사업지원금 활용계획</h4>
		                            <table class="tbl-basic">
		                                <colgroup>
		                                    <col style="width: 20%;">
		                                    <col>
		                                </colgroup>
		                                <caption>사업지원금 활용계획</caption>
		                                <tbody>
		                                    <tr>
		                                        <th rowspan="2"><span class="i-require">*</span> 활용계획</th>
		                                        <td>
		                                            <label class="mr15"><input type="checkbox"> 생활자금</label>
		                                            <label class="mr15"><input type="checkbox"> 창업자금</label>
		                                            <label class="mr15"><input type="checkbox"> 구직자금</label>
		                                            <label class="mr15"><input type="checkbox"> 부채상환자금</label>
		                                            <label class="mr15"><input type="checkbox" class="chk-etc"> 기타</label>
		                                            <input type="text" class="inp w100p mt10 inp-etc" style="display: none;" placeholder="기타 사업지원금 활용계획을 입력 해주시기 바랍니다">
		                                        </td>
		                                    </tr>
		                                </tbody>
		                            </table>
		                        </div>
	                        </div>
	                        
	                        <div class="apply-lvl-container none" data-idx="3">
		                        <div class="write-stit1 f-clear">
		                            <h3>추가서류 제출</h3>
		                            <p>별( <span class="c-red">*</span> ) 표시는 필수 입력입니다.</p>
		                        </div>
		                        <div class="apply-write-item">
		                            <h4 class="write-stit2">구비서류 제출</h4>
		                            <table class="tbl-basic">
		                                <colgroup>
		                                    <col style="width: 30%;">
		                                    <col>
		                                </colgroup>
		                                <caption>구비서류 제출</caption>
		                                <tbody>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 폐업사실증명원 <span class="small">[발급처 : 세무서, 홈택스]</span></th>
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
		                                        <th><span class="i-require">*</span> 주민등록 등본 <span class="small">[발급처 : 주민센터, 정부24홈페이지]</span></th>
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
		                                        <th><span class="i-require">*</span> 사실증명(총사업자등록내역) <span class="small">[발급처 : 세무서, 홈택스]</span></th>
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
		                                        <th><span class="i-require">*</span> 폐업일기준 전년도 부과세과세표준증명원</th>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" id="photoinp4">
		                                                <label for="photoinp4" class="tower-file-button">
		                                                    <span>파일첨부</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                            <p class="small mt10">※ 면세사업자의경우 면세자업자수입금액증명원 첨부</p>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 신청인 통장 사본</th>
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
		                                    <tr>
		                                        <th><span class="i-require">*</span> 건강보험 자격득실 확인서 <span class="small">[발급처: 국민건강보험공단]</span></th>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" id="photoinp6">
		                                                <label for="photoinp6" class="tower-file-button">
		                                                    <span>파일첨부</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                            <p class="small mt10">※ 3개월 이상의 직장변동 이력 포함</p>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th>건강보험료 납부확인서 <span class="small">[발급처: 국민건강보험공단]</span></th>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" id="photoinp7">
		                                                <label for="photoinp7" class="tower-file-button">
		                                                    <span>파일첨부</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                            <p class="small mt10">※ 신청일 기준 직전 3개월 해당분</p>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th>건강보험 자격확인(통보)서<span class="small">[발급처: 국민건강보험공단]</span></th>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" id="photoinp8">
		                                                <label for="photoinp8" class="tower-file-button">
		                                                    <span>파일첨부</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 공동대표 여부</th>
		                                        <td>
		                                            <label class="mr20"><input type="radio"> 예</label>
		                                            <label><input type="radio"> 아니오</label>
		                                            <div class="mt10">
		                                                <table class="tbl-list">
		                                                    <colgroup>
		                                                        <!-- <col style="width: 20%;">
		                                                        <col style="width: 40%;"> -->
		                                                        <col>
		                                                    </colgroup>
		                                                    <caption>공동대표 선택시 작성표</caption>
		                                                    <tbody>
		                                                        <tr>
		                                                            <td>신청업체 공동대표 동의서<br>
		                                                                <button type="button" class="btn btn-white btn-small mt5">동의서 양식 다운로드</button></td>
		                                                            <td>
		                                                                <div class="tower-file">
		                                                                    <input type="file" id="photoinp9">
		                                                                    <label for="photoinp9" class="tower-file-button">
		                                                                        <span>파일첨부</span>
		                                                                    </label>
		                                                                    <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                                                </div>
		                                                            </td>
		                                                        </tr>
		                                                        <tr>
		                                                            <td>공동대표자 신분증 사본</td>
		                                                            <td>
		                                                                <div class="tower-file">
		                                                                    <input type="file" id="photoinp10">
		                                                                    <label for="photoinp10" class="tower-file-button">
		                                                                        <span>파일첨부</span>
		                                                                    </label>
		                                                                    <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                                                </div>
		                                                            </td>
		                                                        </tr>
		                                                    </tbody>
		                                                </table>
		                                            </div>
		                                        </td>
		                                    </tr>
		                                </tbody>
		                            </table>
		                        </div>
		
		                        <div class="apply-write-item">
		                            <h4 class="write-stit2">소득인원 확인</h4>
		                            <table class="tbl-basic">
		                                <colgroup>
		                                    <col style="width: 40%;">
		                                    <col>
		                                </colgroup>
		                                <caption>소득인원 확인</caption>
		                                <tbody>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 가구에 실제 소득이 있는 인원수를 선택해 주세요.</th>
		                                        <td>
		                                            <select class="w100p">
		                                                <option>소득가구원수 선택</option>
		                                                <option>1명(신청자)</option>
		                                                <option>2명</option>
		                                                <option>3명</option>
		                                                <option>4명</option>
		                                                <option>5명</option>
		                                                <option>6명</option>
		                                                <option>7명</option>
		                                                <option>8명 이상</option>
		                                            </select>
		                                            <p class="small mt10">※ 선택한 소득 구성원 수 전원의 추가서류  제출이 필요합니다.</p>
		                                        </td>
		                                    </tr>
		                                </tbody>
		                            </table>
		                        </div>
		
		                        <div class="apply-write-item">
		                            <h4 class="write-stit2">추가 서류</h4>
		                            <table class="tbl-basic">
		                                <colgroup>
		                                    <col style="width: 40%;">
		                                    <col>
		                                </colgroup>
		                                <caption>추가 서류</caption>
		                                <tbody>
		                                    <tr>
		                                        <th>건강보험 자격득실 확인서 <span class="small">[발급처: 국민건강보험공단]</span></th>
		                                        <td>
		                                            <p class="small mb10">※ 3개월 이상의 직장변동 이력 포함</p>
		                                            <div class="tower-file">
		                                                <input type="file" id="photoinp11">
		                                                <label for="photoinp11" class="tower-file-button">
		                                                    <span>파일첨부</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                            <button type="button" class="btn btn-white btn-ss w20 mt5">+</button>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th>건강보험료 납부확인서 <span class="small">[발급처: 국민건강보험공단]</span></th>
		                                        <td>
		                                            <p class="small mb10">※ 신청일 기준 직전 3개월 해당분</p>
		                                            <div class="tower-file">
		                                                <input type="file" id="photoinp11">
		                                                <label for="photoinp11" class="tower-file-button">
		                                                    <span>파일첨부</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                            <button type="button" class="btn btn-white btn-ss w20 mt5">+</button>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th>건강보험 자격확인(통보)서 <span class="small">[발급처: 국민건강보험공단]</sp></th>
		                                        <td>
		                                            <p class="small mb10">※ 전 항목 선택한 소득인원별  추가서류  제출이 필수 입니다.</p>
		                                            <div class="tower-file">
		                                                <input type="file" id="photoinp11">
		                                                <label for="photoinp11" class="tower-file-button">
		                                                    <span>파일첨부</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                            <button type="button" class="btn btn-white btn-ss w20 mt5">+</button>
		                                        </td>
		                                    </tr>
		                                </tbody>
		                            </table>
		                        </div>
	                        </div>
						</form>
                        <div class="btn-step-wrap">
                            <a href="#" class="btn-step-round gray none" id="list-btn"><img src="/images/secp/ico_bt_arrow_left.svg" alt=""> 목록으로</a>
                            <a href="#" class="btn-step-round gray none" id="prev-btn"><img src="/images/secp/ico_bt_arrow_left.svg" alt=""> 이전 단계</a>
                            <a href="#" class="btn-step-round btn-darkgray none" id="save-btn"><img src="/images/secp/ico_save.svg" alt=""> 임시저장</a>
                            <a href="#" class="btn-step-round none" id="next-btn">다음 <img src="/images/secp/ico_bt_arrow_right.svg" alt=""></a>
                            <a href="#" class="btn-step-round btn-red none" id="submit-btn">제출하기 <img src="/images/secp/ico_bt_arrow_right.svg" alt=""></a>
                        </div>
                        
                    </div>

                </div>
                <!-- 지원사업 신청 //-->

            </div>
        </div>
        <!--// 콘텐츠 영역 -->

        <!-- 푸터 영역 //-->
        <%@ include file="/WEB-INF/jsp/programs/footer.jsp" %>
        <!--// 푸터 영역 -->
    </div>
</body>

</html>


