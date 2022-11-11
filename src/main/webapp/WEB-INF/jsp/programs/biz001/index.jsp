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
    <link rel="stylesheet" type="text/css" href="/css/secp/tower-file-input.css">
    
    <script src="/js/secp/jquery-1.12.4.min.js"></script>
    <script src="/js/secp/jquery.splitter.js"></script>
    <script src="/js/secp/jquery-ui.min.js"></script>
    <script src="/js/secp/tower-file-input.js"></script>
    <script src="/js/secp/common.js"></script>
    <script src="/js/secp/biz/bizCmm.js"></script>
    <script src="/js/secp/biz/biz001.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
    	window['APPLY_TYPE'] = '${applyType}';
    	window['IS_AGREE'] = '${isAgree}';
    	
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
        
        $(document).ready(function() { $('input[type=file]').fileInput(); });
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
                        	<c:choose>
                        		<c:when test="${applyType eq 'MYDATA'}">
                            		<h3>소상공인 맞춤형 종합지원 사업</h3>
                            		<h4>(소상공인 경영환경 개선 지원분야)</h4>
                            	</c:when>
                            	<c:otherwise>
                            		<h3>소상공인 경영환경 개선</h3>
                            	</c:otherwise>
                            </c:choose>
                            <p>도내 소상공인 경영안정과 자생력 강화를 위한 점포환경개선, 시스템개선, 홍보/광고 지원을 통해 지역경재 활성화 도모</p>
                        </div>
                        <div class="apply-info-body">
                            <div class="apply-info-cont">
                            	<c:choose>
                            		<c:when test="${applyType eq 'MYDATA'}">
                            			<ul class="linemap">
		                                    <li><a href="index.html"><img src="/images/secp/ico_home.png" alt="홈"></a></li>
		                                    <li>지원 신청</li>
		                                    <li>간편 접수</li>
		                                    <li>소상공인 맞춤형 종합지원 사업</li>
		                                    <li>소상공인 경영환경 개선 지원분야</li>
		                                </ul>
                            		</c:when>
                            		<c:otherwise>
		                                <ul class="linemap">
		                                    <li><a href="index.html"><img src="/images/secp/ico_home.png" alt="홈"></a></li>
		                                    <li>지원 신청</li>
		                                    <li>온라인 접수</li>
		                                    <li>소상공인 경영환경 개선</li>
		                                </ul>
                                	</c:otherwise>
                                </c:choose>
                                <h4 class="apply-info-stit">지원 정보</h4>
                                <img src="/images/secp/project_info1.jpg" alt="" class="w100p">
                            </div>
                        </div>
                    </div>
                </div>
                <!--// 지원사업 정보 -->

                <!-- 지원사업 신청 //-->
                <div class="apply-write" id="apply-write">
                    <div class="apply-write-inner">
                        <p class="txt1"><strong>개인정보 활용</strong>에 <strong>동의</strong>해 주세요.</p>
                        <ul class="step-list">
                            <li><img src="/images/secp/ico_step1.png" alt="">개인정보 활용 동의</li>
                            <c:if test="${applyType eq 'MYDATA' }">
                            <li><img src="/images/secp/ico_step2.png" alt="">자격검증</li>
                            </c:if>
                            <li id="reg-info"><img src="/images/secp/ico_step3.png" alt="">신청정보 입력</li>
                            <li><img src="/images/secp/ico_step4.png" alt="">증빙서류 제출</li>
                        </ul>
                        
                        <ul class="step-list2 none" data-main-id="reg-info">
                            <li>기본정보</li>
                            <li>신청분야 정보</li>
                            <li>추진계획 작성</li>
                            <li>시공계획 정보</li>
                        </ul>
                        <c:if test="${isAgree eq 'N' }">
                        <div class="apply-lvl-container none" data-lvl="agree" data-lvl-id="agree">
                        <!-- <div class="agree-container none"> -->
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
                        </c:if>
                        <c:if test="${applyType eq 'MYDATA' }">
                        <div class="apply-lvl-container none" data-lvl-id="">
                        	자격검증 영역
                        </div>
                        </c:if>
                        
                        <form id="form">
		                	<input type="hidden" id="csrf" name="_csrf">
		                	<input type="hidden" id="bizYr" name="BIZ_YR" value="${bizYr }">
		                	<input type="hidden" id="bizNo" name="BIZ_NO" value="${bizNo }">
		                	<input type="hidden" id="bizCycl" name="BIZ_CYCL" value="${bizCycl }">
                        
	                        <div class="apply-lvl-container none" data-lvl="sub" data-lvl-id="basic">
	                        	<div class="write-stit1 f-clear">
		                            <h3>기본정보</h3>
		                            <p>별( <span class="c-red">*</span> ) 표시는 필수 입력입니다.</p>
		                        </div>
								<div class="apply-write-item">
		                            <h4 class="write-stit2">대표자 정보</h4>
		                            <table class="tbl-basic">
		                                <colgroup>
		                                    <col style="width: 30%;">
		                                    <col>
		                                </colgroup>
		                                <caption>대표자 정보</caption>
		                                <tbody>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 대표자명</th>
		                                        <td><input type="text" class="inp w100p" id="rep-name" name="RPRSNTV"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 생년월일<span class="small">(8자리 입력)</span></th>
		                                        <td><input type="text" class="inp w100p" id="birth" name="LIFYEA"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 성별</th>
		                                        <td>
		                                            <label class="mr20"><input type="radio" id="gender-male" name="SEXDSTN" value="M"> 남</label>
		                                            <label><input type="radio" id="gender-female" name="SEXDSTN" value="F"> 여</label>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 연락처<span class="small">(- 제외)</span></th>
		                                        <td><input type="text" class="inp w100p" id="tel" name="CTTPC"></td>
		                                    </tr>
		                                </tbody>
		                            </table>
		                        </div>
		
		                        <div class="apply-write-item">
		                            <h4 class="write-stit2">사업자 정보</h4>
		                            <table class="tbl-basic">
		                                <colgroup>
		                                    <col style="width: 30%;">
		                                    <col>
		                                </colgroup>
		                                <caption>사업자 정보</caption>
		                                <tbody>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 상호명<span class="small">(법인의 경우 법인 명 기재)</span></th>
		                                        <td><input type="text" class="inp w100p" id="store-name" name="ENTRPS_NM"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 사업자등록번호<span class="small">( - 제외)</span></th>
		                                        <td><input type="text" class="inp w100p" id="bsns-num" name="BSNM_NO"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 사업장 주소</th>
		                                        <td>
		                                            <div class="flexline"><input type="text" class="inp w100p" id="bsns-addr" name="BPLC_ADRES"><button type="button" class="btn btn-gray ml5" id="addr-search">주소검색</button></div>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 과세유형</th>
		                                        <td>
		                                            <select class="w100p" id="tax-type" name="TAXT_TY">
		                                            	<option val="" selected></option>
		                                                <option val="test">OOOOO</option>
		                                            </select>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 업종</th>
		                                        <td><input type="text" class="inp w100p" id="store-cate" name="ITEM"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 업태</th>
		                                        <td><input type="text" class="inp w100p" id="store-type" name="BIZCND"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 개업일<span class="small">(사업자등록증의 개업일 기재)</span></th>
		                                        <td><input type="text" class="inp w100p datepicker" id="open-date" name="OPBIZ_DE" readonly="readonly"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 상시 종업원 수<span class="small">(대표자 제외)</span></th>
		                                        <td><input type="text" class="inp w100p" id="staff-cnt" name="EMPLY_CO"></td>
		                                    </tr>
		                                </tbody>
		                            </table>
		                        </div>
		
		                        <div class="apply-write-item">
		                            <h4 class="write-stit2">매출 정보<span class="small">(직전 2개년의 부가세 과세표준 증명의 매출정보를 기재)</span></h4>
		                            <table class="tbl-list">
		                                <colgroup>
		                                    <col style="width: 20%;">
		                                    <col style="width: 40%;">
		                                    <col>
		                                </colgroup>
		                                <caption>매출 정보</caption>
		                                <thead>
		                                    <tr>
		                                        <th>과세 구분</th>
		                                        <th><span class="i-require">*</span> 과세표준 금액</th>
		                                        <th>매출 기간</th>
		                                    </tr>
		                                </thead>
		                                <tbody>
		                                    <tr>
		                                        <th id="sell-type0"></th>
		                                        <td><div class="flexline"><input type="text" class="inp w100p" id="tax0" name="1_YY_SM_1"><span class="ml5">만원</span></div></td>
		                                        <td><input type="text" class="inp w80p" id="sell-date0"></td>
		                                    </tr>
		                                    <tr>
		                                        <th id="sell-type1"></th>
		                                        <td><div class="flexline"><input type="text" class="inp w100p" id="tax1" name="1_YY_SM_2"><span class="ml5">만원</span></div></td>
		                                        <td><input type="text" class="inp w80p" id="sell-date1"></td>
		                                    </tr>
		                                </tbody>
		                            </table>
		                        </div>
							</div> <!-- basic-container // -->
							
							<div class="apply-lvl-container none" data-lvl="sub" data-lvl-id="reqstRealm">
								<div class="write-stit1 f-clear">
		                            <h3>신청분야 정보</h3>
		                            <p>별( <span class="c-red">*</span> ) 표시는 필수 입력입니다.</p>
		                        </div>
							
								<div class="apply-write-item">
		                            <h4 class="write-stit2">신청분야 정보</h4>
		                            <table class="tbl-list">
		                                <colgroup>
		                                    <col style="width: 30%;">
		                                    <col style="width: 30%;">
		                                    <col>
		                                </colgroup>
		                                <caption>신청분야 정보</caption>
		                                <thead>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 신청분야 (1개 선택)</th>
		                                        <th>지원 금액</th>
		                                        <th>세부분야 선택(2개 이하 선택)</th>
		                                    </tr>
		                                </thead>
		                                <tbody>
		                                    <tr>
		                                        <th class="t-left"><label><input type="radio" name="REQST_REALM" class="apply-type" value="점포환경개선" data-grp="0"> 점포환경개선</label></th>
		                                        <td>공급가 100% / 최대 300만원</td>
		                                        <td class="t-left">
		                                            <label><input type="checkbox" class="apply-type-dtl" data-grp="0" disabled> 간판(불법간판 제외)</label><br>
		                                            <label><input type="checkbox" class="apply-type-dtl" data-grp="0" disabled> 상품전시 재배열, 판매대 등</label><br>
		                                            <label><input type="checkbox" class="apply-type-dtl" data-grp="0" disabled> 내부인테리어</label><br>
		                                            <label><input type="checkbox" class="apply-type-dtl" data-grp="0" disabled> 위생조리기구, 식당 좌식 테이블 입식으로 교체</label>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th class="t-left"><label><input type="radio" name="REQST_REALM" class="apply-type" value="시스템개선" data-grp="1"> 시스템개선</label></th>
		                                        <td>공급가 100% / 최대 200만원</td>
		                                        <td class="t-left">
		                                            <label><input type="checkbox" class="apply-type-dtl" data-grp="1" disabled> POS 시스템</label><br>
		                                            <label><input type="checkbox" class="apply-type-dtl" data-grp="1" disabled> 무인주문 결제시스템</label><br>
		                                            <label><input type="checkbox" class="apply-type-dtl" data-grp="1" disabled> CCTV시스템</label><br>
		                                            <label><input type="checkbox" class="apply-type-dtl" data-grp="1" disabled> 방역 소독 시스템(공기청정 살균기 등 제외)</label>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th class="t-left"><label><input type="radio" name="REQST_REALM" class="apply-type" value="홍보 및 광고" data-grp="2"> 홍보 및 광고</label></th>
		                                        <td>공급가 100% / 최대 200만원</td>
		                                        <td class="t-left">
		                                            <label><input type="checkbox" class="apply-type-dtl" data-grp="2" disabled> 홍보 판촉물</label><br>
		                                            <label><input type="checkbox" class="apply-type-dtl" data-grp="2" disabled> 제품 포장</label><br>
		                                            <label><input type="checkbox" class="apply-type-dtl" data-grp="2" disabled> 오프라인 광고</label><br>
		                                            <label><input type="checkbox" class="apply-type-dtl" data-grp="2" disabled> 상표 출원</label>
		                                        </td>
		                                    </tr>
		                                </tbody>
		                            </table>
		                            <p class="mt20 mb50 c-darkred indent">※ 1개의 분야만 신청 가능하며, 선정이후 신청분야의 변경은 불가 합니다. 또한 지원금액은 제출한 견적서 금액 이내에서 결정 됩니다.</p>
		                        </div>
							</div> <!-- type-container // -->
							
							
							<div class="apply-lvl-container none" data-lvl="sub" data-lvl-id="prtnPlan">
								<div class="write-stit1 f-clear">
		                            <h3>추진계획 작성</h3>
		                            <p>별( <span class="c-red">*</span> ) 표시는 필수 입력입니다.</p>
		                        </div>
		
		                        <div class="apply-write-item">
		                            <h4 class="write-stit2"><span class="i-require">*</span> 사업추진 계획<span class="small">(사업소개, 점포 개선할 내용, 필요성 등)</span></h4>
		                            <table class="tbl-list">
		                                <caption>신청분야 정보</caption>
		                                <tbody>
		                                    <tr>
		                                        <td><textarea class="w100p resize-none" id="biz-plan" name="BSNS_PRTN_PLAN" placeholder="※ 심사평가 자료이므로 사업소개, 점포개선 사항, 필요성을 구체적으로 작성하기시 바랍니다"></textarea></td>
		                                    </tr>
		                                </tbody>
		                            </table>
		                        </div>
								<div class="apply-write-item">
		                            <h4 class="write-stit2"><span class="i-require">*</span> 사업장 현황 사진<span class="small">(사업장 내·외부 사진 각 1장)</span></h4>
		                            <table class="tbl-basic">
		                                <colgroup>
		                                    <col style="width: 20%;">
		                                    <col>
		                                </colgroup>
		                                <caption>사업장 현황 사진</caption>
		                                <tbody>
		                                    <tr>
		                                        <th>점포 내부</th>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" id="store-inside" name="STOR_INNER" accept=".jpg, .png">
		                                                <label for="store-inside" class="tower-file-button">
		                                                    <span>사진 업로드</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th>점포 외부</th>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" id="store-outside" name="STOR_EXTRL" accept=".jpg, .png">
		                                                <label for="store-outside" class="tower-file-button">
		                                                    <span>사진 업로드</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                        </td>
		                                    </tr>
		                                </tbody>
		                            </table>
		                        </div>
		
		                        <div class="apply-write-item">
		                            <h4 class="write-stit2"><span class="i-require">*</span> 점포환경 개선할 부분 사진<span class="small">(최소 3장, 최대 6장)</span></h4>
		                            <table class="tbl-list">
		                                <colgroup>
		                                    <col style="width: 15em;">
		                                    <col>
		                                </colgroup>
		                                <caption>점포환경 개선할 부분 사진</caption>
		                                <thead>
		                                    <th>개선할 부분 사진</th>
		                                    <th>사진 설명</th>
		                                </thead>
		                                <tbody>
		                                    <tr>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" class="imprv-file" id="imprv0" name="IMPRVM_PHOTO_1" accept=".jpg, .png">
		                                                <label for="imprv0" class="tower-file-button">
		                                                    <span>사진 업로드</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                        </td>
		                                        <td><textarea class="write-photodetail resize-none" name="IMPRVM_CN_1"></textarea></td>
		                                    </tr>
		                                    <tr>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" class="imprv-file" id="imprv1" name="IMPRVM_PHOTO_2" accept=".jpg, .png">
		                                                <label for="imprv1" class="tower-file-button">
		                                                    <span>사진 업로드</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                        </td>
		                                        <td><textarea class="write-photodetail resize-none" name="IMPRVM_CN_2"></textarea></td>
		                                    </tr>
		                                    <tr>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" class="imprv-file" id="imprv2" name="IMPRVM_PHOTO_3" accept=".jpg, .png">
		                                                <label for="imprv2" class="tower-file-button">
		                                                    <span>사진 업로드</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                        </td>
		                                        <td><textarea class="write-photodetail resize-none" name="IMPRVM_CN_3"></textarea></td>
		                                    </tr>
		                                    <tr>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" class="imprv-file" id="imprv3" name="IMPRVM_PHOTO_4" accept=".jpg, .png">
		                                                <label for="imprv3" class="tower-file-button">
		                                                    <span>사진 업로드</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                        </td>
		                                        <td><textarea class="write-photodetail resize-none" name="IMPRVM_CN_4"></textarea></td>
		                                    </tr>
		                                    <tr>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" class="imprv-file" id="imprv4" name="IMPRVM_PHOTO_5" accept=".jpg, .png">
		                                                <label for="imprv4" class="tower-file-button">
		                                                    <span>사진 업로드</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                        </td>
		                                        <td><textarea class="write-photodetail resize-none" name="IMPRVM_CN_5"></textarea></td>
		                                    </tr>
		                                    <tr>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" class="imprv-file" id="imprv5" name="IMPRVM_PHOTO_6" accept=".jpg, .png">
		                                                <label for="imprv5" class="tower-file-button">
		                                                    <span>사진 업로드</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                        </td>
		                                        <td><textarea class="write-photodetail resize-none" name="IMPRVM_CN_6"></textarea></td>
		                                    </tr>
		                                </tbody>
		                            </table>
		                            <p class="mt20 mb50 c-darkred indent">※ 사진은 심사평가 자료로 활용되며 지원불가 품목 신청시 선정에서 제외될 수 있고 선정 되더라도 변경 하여야 합니다.</p>
		                        </div>
							</div> <!-- exec-plan-container // -->
							
							<div class="apply-lvl-container none" data-lvl="sub" data-lvl-id="cnstrct">
								<div class="write-stit1 f-clear">
		                            <h3>시공계획 및 견적정보</h3>
		                            <p>별( <span class="c-red">*</span> ) 표시는 필수 입력입니다.</p>
		                        </div>
								<div class="apply-write-item">
		                            <h4 class="write-stit2"><span class="i-require">*</span> 시공계획서<span class="small">(점포환경(광고·홍보,시스템개선) 시공(제작)계획)</span></h4>
		                            <table class="tbl-basic mb30">
		                                <colgroup>
		                                    <col style="width: 25%;">
		                                    <col>
		                                </colgroup>
		                                <caption>시공계획서</caption>
		                                <tbody>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 시공업체명</th>
		                                        <td><input type="text" class="inp w100p" id="cnstrt0-name" name="CNSTRCT_ENTRPS_1"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 사업자번호</th>
		                                        <td><input type="text" class="inp w100p" id="cnstrt0-bsns-num" name="BSNM_NO_1"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 전화번호</th>
		                                        <td><input type="text" class="inp w100p" id="cnstrt0-tel" name="TLPHON_1"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 시공(제작)내역</th>
		                                        <td><input type="text" class="inp w100p" id="cnstrt0-work" name="REQST_REALM_DETAIL_1"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 공급가</th>
		                                        <td><div class="flexline"><input type="text" class="inp w100p cnstrt-price" id="cnstrt0-pymt" data-idx="0" name="SPLPC_1"> <span class="pl5">원</span></div></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 부가세</th>
		                                        <td><div class="flexline"><input type="text" class="inp w100p cnstrt-price" id="cnstrt0-tax" data-idx="0" name="VAT_1"> <span class="pl5">원</span></div></td>
		                                    </tr>
		                                    <tr>
		                                        <th>합계</th>
		                                        <td><div class="flexline"><input type="text" class="inp w100p" id="cnstrt0-pymt-total" name="SUBSUM_1" readonly="readonly"> <span class="pl5">원</span></div></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 시공견적서</th>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" id="cnstrt0-estimt" name="CNSTRCT_PRQUDO_1" accept=".jpg, .png, .pdf">
		                                                <label for="cnstrt0-estimt" class="tower-file-button">
		                                                    <span>파일첨부</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th>사업자등록증</th>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" id="cnstrt0-biz-doc" name="CNSTRCT_ENTRPS_BSNM_CEREGRT_1" accept=".jpg, .png, .pdf">
		                                                <label for="cnstrt0-biz-doc" class="tower-file-button">
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
		                                    <col style="width: 25%;">
		                                    <col>
		                                </colgroup>
		                                <caption>시공계획서</caption>
		                                <tbody>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 시공업체명</th>
		                                        <td><input type="text" class="inp w100p" id="cnstrt1-name" name="CNSTRCT_ENTRPS_2"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 사업자번호</th>
		                                        <td><input type="text" class="inp w100p" id="cnstrt1-bsns-num" name="BSNM_NO_2"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 전화번호</th>
		                                        <td><input type="text" class="inp w100p" id="cnstrt1-tel" name="TLPHON_2"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 시공(제작)내역</th>
		                                        <td><input type="text" class="inp w100p" id="cnstrt1-work" name="REQST_REALM_DETAIL_2"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 공급가</th>
		                                        <td><div class="flexline"><input type="text" class="inp w100p cnstrt-price" id="cnstrt1-pymt" data-idx="1" name="SPLPC_2"> <span class="pl5">원</span></div></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 부가세</th>
		                                        <td><div class="flexline"><input type="text" class="inp w100p cnstrt-price" id="cnstrt1-tax" data-idx="1" name="VAT_2"> <span class="pl5">원</span></div></td>
		                                    </tr>
		                                    <tr>
		                                        <th>합계</th>
		                                        <td><div class="flexline"><input type="text" class="inp w100p" id="cnstrt1-pymt-total" name="SUBSUM_2" readonly="readonly"> <span class="pl5">원</span></div></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 시공견적서</th>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" id="cnstrt1-estimt" name="CNSTRCT_PRQUDO_2" accept=".jpg, .png, .pdf">
		                                                <label for="cnstrt1-estimt" class="tower-file-button">
		                                                    <span>파일첨부</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th>사업자등록증</th>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" id="cnstrt1-biz-doc" name="CNSTRCT_ENTRPS_BSNM_CEREGRT_2" accept=".jpg, .png, .pdf">
		                                                <label for="cnstrt1-biz-doc" class="tower-file-button">
		                                                    <span>파일첨부</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                        </td>
		                                    </tr>
		                                </tbody>
		                            </table>
		
		                            <p class="mt20 mb50 c-darkred indent">※ 시공업체는 2개 업체 이내로 선정해야 합니다.</p>
		                        </div>
							</div> <!-- const-plan-container -->
							
							<div class="apply-lvl-container none" data-lvl="main" data-lvl-id="doc">
								<div class="write-stit1 f-clear">
		                            <h3>증빙서류 제출</h3>
		                            <p>별( <span class="c-red">*</span> ) 표시는 필수 입력입니다.</p>
		                        </div>
		                        <div class="apply-write-item">
		                            <h4 class="write-stit2">필수 서류</h4>
		                            <table class="tbl-basic">
		                                <colgroup>
		                                    <col style="width: 30%;">
		                                    <col>
		                                </colgroup>
		                                <caption>필수 서류</caption>
		                                <tbody>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 사업자등록증</th>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" id="doc-bsns" name="BSNM_CEREGRT" accept=".jpg, .png, .pdf">
		                                                <label for="doc-bsns" class="tower-file-button">
		                                                    <span>파일첨부</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 부가가치세 과세표준증명원</th>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" id="doc-tax-std" name="VAT_CRTF" accept=".jpg, .png, .pdf">
		                                                <label for="doc-tax-std" class="tower-file-button">
		                                                    <span>파일첨부</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                            <p class="small mt10">(면세 사업자의 경우 면세사업자 수입금액증명원 첨부)</p>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 법인 증빙 추가서류</th>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" id="doc-corp" name="CPR_ADIT_PAPERS" accept=".jpg, .png, .pdf">
		                                                <label for="doc-corp" class="tower-file-button">
		                                                    <span>파일첨부</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                            <p class="small mt10">(법인의 경우 종업원수를 확인 할 수 있는 서류  필수 제출 : 4대 보험 사업장 가입자 명부 또는 소상공인 확인서(중소벤처기업부 발행 등))</p>
		                                        </td>
		                                    </tr>
		                                </tbody>
		                            </table>
		                        </div>
		
		                        <div class="apply-write-item">
		                            <h4 class="write-stit2">우대사항(가점) 서류</h4>
		                            <table class="tbl-basic">
		                                <colgroup>
		                                    <col style="width: 30%;">
		                                    <col>
		                                </colgroup>
		                                <caption>우대사항(가점) 서류</caption>
		                                <tbody>
		                                    <tr>
		                                        <th>국가유공자·기초생활수급자·북한이탈주민·장애인 증명</th>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" id="doc-cert" name="SOCTY_WKSN" accept=".jpg, .png, .pdf">
		                                                <label for="doc-cert" class="tower-file-button">
		                                                    <span>파일첨부</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th>경기도 창업(경영)교육 12시간 이상 수료증</th>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" id="doc-mng-edu" name="EDC_CNSL_1" accept=".jpg, .png, .pdf">
		                                                <label for="doc-mng-edu" class="tower-file-button">
		                                                    <span>파일첨부</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th>경기도 컨설팅 확인서</th>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" id="doc-cnslt" name="EDC_CNSL_2" accept=".jpg, .png, .pdf">
		                                                <label for="doc-cnslt" class="tower-file-button">
		                                                    <span>파일첨부</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                            <p class="small mt10">(2년 이내의 경기도시장상권진흥원의 컨설팅 확인서 
		                                                경영컨설팅, 경영환경개선사업 컨설팅, 폐업지원 컨설팅)</p>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th>탄소포인트제 가입확인서</th>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" id="doc-carbon" name="CARBON_PNT" accept=".jpg, .png, .pdf">
		                                                <label for="doc-carbon" class="tower-file-button">
		                                                    <span>파일첨부</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                            <p class="small mt10">(한국환경공단 발급, 신청마감일 이내)</p>
		                                        </td>
		                                    </tr>
		                                </tbody>
		                            </table>
		                        </div>
							</div> <!-- doc-container // -->
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