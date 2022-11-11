<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
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

    <link rel="stylesheet" type="text/css" href="/css/secp/tower-file-input.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/jquery.splitter.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/common.css">
    
    <script src="/js/secp/jquery-1.12.4.min.js"></script>
    <script src="/js/secp/jquery.splitter.js"></script>
    <script src="/js/secp/jquery-ui.min.js"></script>
    <script src="/js/secp/tower-file-input.js"></script>
    <script src="/js/secp/common.js"></script>
    <script src="/js/secp/biz/bizCmm.js"></script>
    <script src="/js/secp/biz/biz006.js"></script> 
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

            $(".chk-etc").click(function(){
                if ($(this).is(":checked")){
                    $(".inp-etc").fadeIn();
                } else {
                    $(".inp-etc").hide();
                }
            })


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
                        			<h4>(청년사관학교 지원분야)</h4>
                        		</c:when>
                        		<c:otherwise>
                        			<h3>청년사관학교 지원</h3>
                        		</c:otherwise>
                        	</c:choose>
                            <p>청년사관학교 지원 사업에 대한 간략한 설명이 들어가는 자리입니다.</p>
                        </div>
                        <div class="apply-info-body">
                            <div class="apply-info-cont">
	                            <c:choose>
	                        		<c:when test="${applyType eq 'MYDATA'}">
		                                <ul class="linemap">
		                                    <li><a href="/web/index.do"><img src="/images/secp/ico_home.png" alt="홈"></a></li>
		                                    <li>지원 신청</li>
		                                    <li>간편 접수</li>
		                                    <li>청년사관학교 지원</li>
		                                </ul>	                        		
	                        		</c:when>
	                        		<c:otherwise>
		                                <ul class="linemap">
		                                    <li><a href="/web/index.do"><img src="/images/secp/ico_home.png" alt="홈"></a></li>
		                                    <li>지원 신청</li>
		                                    <li>온라인 접수</li>
		                                    <li>청년사관학교 지원</li>
		                                </ul>	                        		
	                        		</c:otherwise>
	                        	</c:choose>

                                <h4 class="apply-info-stit">지원 정보</h4>
                                <!-- 사업설명이미지 -->
                                <img src="" alt="" class="w100p">
                            </div>
                        </div>
                    </div>
                </div>
                <!--// 지원사업 정보 -->

                <!-- 지원사업 신청 //-->
                
                <div class="apply-write" id="apply-write">
                    <div class="apply-write-inner" >
<!-- 	                        <p class="txt1"><strong>청년사관학교 </strong> 지원을 신청하세요</p> -->
	                        <p class="txt1" id='headTxt'><strong>개인정보 활용</strong>에 <strong>동의</strong>해 주세요.</p>
	                        <ul class="step-list">
	                            <li><img src="/images/secp/ico_step1.png" alt="">개인정보 활용 동의</li>
	                            <c:if test="${applyType eq 'MYDATA' }">
	                            <li><img src="/images/secp/ico_step2.png" alt="">자격검증</li>
	                            </c:if>
	                            <li id="reg-info">
	                            <img src="/images/secp/ico_step3.png" alt="">신청정보 입력</li>
	                            <li><img src="/images/secp/ico_step4.png" alt="">추가서류 제출</li>
	                        </ul>
	                        <ul class="step-list2 none" data-main-id="reg-info">
	                            <li>기본정보</li>
	                            <li>창업계획서</li>
	                        </ul>
	                        <!-- 개인정보활용 동의 -->
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
                        
                    <!-- apply4_1 // -->
                    <form id="form">
                    	<input type="hidden" id="csrf" name="_csrf">
	                	<input type="hidden" id="bizYr" name="BIZ_YR" value="${bizYr }">
	                	<input type="hidden" id="bizNo" name="BIZ_NO" value="${bizNo }">
	                	<input type="hidden" id="bizCycl" name="BIZ_CYCL" value="${bizCycl }">
	                	
                	 <!--apply4_1 // -->
					 <div class="apply-lvl-container none" data-lvl="sub" data-lvl-id="basic">                  
	                        <div class="write-stit1 f-clear ">
	                            <h3>기본정보</h3>
	                            <p>별( <span class="c-red">*</span> ) 표시는 필수 입력입니다.</p>
	                        </div>
	                        <div class="apply-write-item">
	                            <h4 class="write-stit2">창업 분야</h4>
	                            <table class="tbl-basic">
	                                <colgroup>
	                                    <col style="width: 20%;">
	                                    <col>
	                                </colgroup>
	                                <caption>창업 분야</caption>
	                                <tbody>
	                                    <tr>
	                                        <th><span class="i-require">*</span> 창업 분야</th>
	                                        <td>
	                                            <label class="mr20"><input type="radio" name="STUPTYPE" class="sttuType"> 서양식</label>
	                                            <label class="mr20"><input type="radio" name="STUPTYPE" class="sttuType"> 한식</label>
	                                            <label class="mr20"><input type="radio" name="STUPTYPE" class="sttuType"> 커피</label>
	                                            <label class="mr20"><input type="radio" name="STUPTYPE" class="sttuType"> 제과</label>
	                                            <label class="mr20"><input type="radio" name="STUPTYPE" class="sttuType" value="etc"> 기타</label>
	                                            <input type="text" class="inp w100p mt5" placeholder="기타 창업분야를 입력해 주세요" name="STUPTYPE" id="etc-detail" disabled>
	                                        </td>
	                                    </tr>
	                                    <tr>
	                                        <th><span class="i-require">*</span> 아이템명</th>
	                                        <td><input type="text" class="inp w100p" id="item-name" name="ITEMNM"></td>
	                                    </tr>
	                                    <tr>
	                                        <th><span class="i-require">*</span> 창업예정지<span class="small" >(시/군)</span></th>
	                                        <td>
											<select class="w100p" id="region-type" name="SIDO">
											    <option value="시군 선택">시/군 선택</option>
											    <option value="부천시">부천시</option>
											</select>
	                                        </td>
	                                    </tr>
	                                </tbody>
	                            </table>
	                        </div>
	
	                        <div class="apply-write-item">
	                            <h4 class="write-stit2">신청자 정보</h4>
	                            <table class="tbl-basic">
	                                <colgroup>
	                                    <col style="width: 20%;">
	                                    <col>
	                                </colgroup>
	                                <caption>신청자 정보</caption>
	                                <tbody>
	                                    <tr>
	                                        <th><span class="i-require" >*</span> 성명</th>
	                                        <td><input type="text" class="inp w100p" id="rep-name" name="NAME"></td>
	                                    </tr>
	                                    <tr>
	                                        <th><span class="i-require" >*</span> 생년월일</th>
	                                        <td><input type="text" class="inp w100p" id="birth" name="LIFYEA"></td>
	                                    </tr>
	                                    <tr>
	                                        <th><span class="i-require">*</span> 연락처<span class="small">( - 제외)</span></th>
	                                        <td><input type="text" class="inp w100p" id="tel" name="TEL"></td>
	                                    </tr>
	                                    <tr>
	                                        <th>이메일</th>
	                                        <td>
	                                            <div class="flexline">
	                                                <input type="text" class="inp w50p" id="email-id">
	                                                <span class="ml5 mr5">@</span>
	                                                <select class="w50p" id="email-domain">
	                                                    <option value="naver.com">naver.com</option>
	                                                </select>
	                                            </div>
	                                        </td>
	                                    </tr>
	                                    <tr>
	                                        <th><span class="i-require">*</span> 자택 주소</th>
	                                        <td>
	                                            <div class="flexline">
	                                            	<input type="text" class="inp w100p" id="addr" name="ADDR">
	                                            	<input type="hidden" class="inp w100p" id="sido">
	                                            	<button type="button" class="btn btn-gray ml5" id="addr-search">주소검색</button>
	                                            	</div>
	                                        </td>
	                                    </tr>
	                                </tbody>
	                            </table>
	                        </div>
	
	                        <div class="apply-write-item">
	                            <h4 class="write-stit2"  style="display: block; float: left; ">경력 사항</h4>
	                            <button type="button" class="btn btn-gray" id="addrowBtn1" style="display: block; float: right ;margin: 0 0.7em 0.5em 0;">+</button>
	                            <div class="scrollable">
	                                <table class="tbl-list" id="tbl-career">
	                                    <colgroup>
	                                        <col style="width: 16em;">
	                                        <col style="width: 20%;">
	                                        <col style="width: 15%;">
	                                        <col>
	                                        <col style="width: 3.75em;">
	                                    </colgroup>
	                                    <caption>경력 사항</caption>
	                                    <thead>
	                                        <tr>
	                                            <th>기간</th>
	                                            <th>단체명</th>
	                                            <th>관련분야</th>
	                                            <th>상세내용</th>
	                                            <th>삭제</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody>
	                                        <tr class="career-row">
	                                            <td>
	                                                <input type="text" class="inp datepicker cars-date career career-date" name="CSDATE" data-th='시작일' style="width: 6em;" id="cars-date" readonly='readonly'>
	                                                <span class="ml5 mr5" style="width: 1em;">-</span>
	                                                <input type="text" class="inp datepicker care-date career career-date" name="CEDATE" data-th='종료일' style="width: 6em;" id="care-date" readonly='readonly'>
	                                            </td>
	                                            <td><input type="text" class="inp w100p career-org career" name="CORG" data-th='단체명'></td>
	                                            <td><input type="text" class="inp w100p career-type career" name="CTYPE" data-th='관련분야'></td>
	                                            <td><input type="text" class="inp w100p career-cont career" name="CCONTENT" data-th='상세내용'></td>
	                                            <td></td>
	                                        </tr>

	                                    </tbody>
	                                </table>
	                            </div>
	                        </div>
	
	                        <div class="apply-write-item">
	                            <h4 class="write-stit2">유사사업 신청·지원 여부</h4>
	                            <button type="button" class="btn btn-gray" id="addrowBtn2" style="display: block; float: right ;margin: 0 0.7em 0.5em 0;">+</button>
	                            <div class="scrollable">
	                                <table class="tbl-list" id="tbl-simbiz">
	                                    <colgroup>
	                                        <col>
	                                        <col style="width: 16em;">
	                                        <col style="width: 20%;">
	                                        <col style="width: 3.75em;">
	                                    </colgroup>
	                                    <caption>유사사업 신청·지원 여부</caption>
	                                    <thead>
	                                        <tr>
	                                            <th>사업명</th>
	                                            <th>사업년도</th>
	                                            <th>주관기관</th>
	                                            <th>삭제</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody>
	                                        <tr class="simbiz-row">
	                                            <td><input type="text" class="inp w100p simbiz simbiz-name" name="SBIZNAME" data-th="사업명"></td>
	                                            <td>
	                                                <input type="text" class="inp datepicker simbizDate simbiz sims-date" name="SBIZSTART" data-th="시작년도" style="width: 6em;" readonly="readonly">
	                                                <span class="ml5 mr5" style="width: 1em;">-</span>
	                                                <input type="text" class="inp datepicker simbizDate simbiz sime-date" name="SBIZEND" data-th="종료년도" style="width: 6em;" readonly="readonly">
	                                            </td>
	                                            <td><input type="text" class="inp w100p simbiz-org" name="SMIZORG" data-th="주관기관"></td>
	                                            <td></td>
	                                        </tr>

	                                    </tbody>
	                                </table>
	                            </div>
	                        </div>
	                      </div>  <!-- // apply4_1 -->
	                      
                      <!--apply4_2 // -->
                      <div class="apply-lvl-container none" data-lvl="sub" data-lvl-id="startUpPlan">
                        <div class="write-stit1 f-clear">
                            <h3>창업계획서</h3>
                            <p>별(<span class="c-red">*</span>) 표시는 필수 입력입니다.</p>
                        </div>	      
                        <div class="apply-write-item">
                            <h4 class="write-stit2">창업 계획</h4>
                            <table class="tbl-basic">
                                <colgroup>
                                    <col style="width: 30%;">
                                    <col>
                                </colgroup>
                                <caption>창업 계획</caption>
                                <tbody>
                                    <tr>
                                        <th><span class="i-require">*</span> 소상공인 청년사관학교 창업계획서</th>
                                        <td>
                                            <div class="tower-file">
                                                <input type="file" id="doc-plan" name="PLANFILE">
                                                <label for="doc-plan" class="tower-file-button">
                                                    <span>파일첨부</span>
                                                </label>
                                                <button type="button" class="btn btn-white btn-medium">양식 다운로드</button>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                      </div><!--// apply4_2  -->
                      
                      <!-- apply4_3 // -->
					  <div class="apply-lvl-container none" data-lvl="main" data-lvl-id="doc">
                        <div class="write-stit1 f-clear">
                            <h3>추가서류 제출</h3>
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
                                        <th><span class="i-require">*</span> 주민등록 초본</th>
                                        <td>
                                            <div class="tower-file">
                                                <input type="file" id="doc-reg" name="REGFILE">
                                                <label for="doc-reg" class="tower-file-button">
                                                    <span>파일첨부</span>
                                                </label>
                                            </div>
                                            <p class="small mt5">주민등록번호 뒷자리 포함/ 과거의 주소변동 사항(최근 5년, 발생일/신고일, 변동사유 필수)</p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th><span class="i-require">*</span> 사실증명(총사업자등록내역)</th>
                                        <td>
                                            <div class="tower-file">
                                                <input type="file" id="doc-fact" name="FACTFILE">
                                                <label for="doc-fact" class="tower-file-button">
                                                    <span>파일첨부</span>
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        
                        <div class="apply-write-item">
                            <h4 class="write-stit2">우대사항(가점) 서류 <span class="small">2022.01.01 이후 발급분을 첨부해 주세요.</span></h4>
                            <table class="tbl-basic">
                                <colgroup>
                                    <col style="width: 30%;">
                                    <col>
                                </colgroup>
                                <caption>우대사항(가점) 서류</caption>
                                <tbody id = "add_file">
                                    <tr>
                                        <th>조리학 관련 학위 보유</th>
                                        <td>
                                            <div class="tower-file">
                                                <input type="file" id="doc-cook" name="COOKFILE">
                                                <label for="doc-cook" class="tower-file-button">
                                                    <span>파일첨부</span>
                                                </label>
                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                                <button type="button" class="btn btn-white btn-small">+</button>
                                            </div>

                                        </td>
                                    </tr>
                                    <tr>
                                        <th>창업아이템 관련 경력 3년 이상</th>
                                        <td>
                                            <div class="tower-file">
                                                <input type="file" id="doc-item" name="ITEMFILE">
                                                <label for="doc-item" class="tower-file-button">
                                                    <span>파일첨부</span>
                                                </label>
                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                                <button type="button" class="btn btn-white btn-small">+</button>
                                            </div>

                                        </td>
                                    </tr>
                                    <tr>
                                        <th>음식조리 관련 자격증 보유</th>
                                        <td>
                                            <div class="tower-file">
                                                <input type="file" id="doc-food" name="FOODFILE">
                                                <label for="doc-food" class="tower-file-button">
                                                    <span>파일첨부</span>
                                                </label>
                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                                <button type="button" class="btn btn-white btn-small">+</button>
                                            </div>

                                        </td>
                                    </tr>
                                    <tr>
                                        <th>정부/지자체 시행 음식 경진대회 입상 경력</th>
                                        <td>
                                            <div class="tower-file">
                                                <input type="file" id="doc-award" name="AWARDFILE">
                                                <label for="doc-award" class="tower-file-button">
                                                    <span>파일첨부</span>
                                                </label>
                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                                <button type="button" class="btn btn-white btn-small">+</button>
                                            </div>

                                        </td>
                                    </tr>
                                    <tr>
                                        <th>기타 우대조건</th>
                                        <td>
                                            <div class="tower-file">
                                                <input type="file" id="doc-etc" name="ETCFILE">
                                                <label for="doc-etc" class="tower-file-button">
                                                    <span>파일첨부</span>
                                                </label>
                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                                <button type="button" class="btn btn-white btn-small">+</button>
                                            </div>

                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>                                                                    
                      </div><!--// apply4_3 -->
					
					</form>
					
                    <div class="btn-step-wrap">
                   	 	<a href="#" class="btn-step-round gray none" id="list-btn"><img src="/images/secp/ico_bt_arrow_left.svg" alt=""> 목록으로</a>
                   		<a href="#" class="btn-step-round gray none" id="prev-btn"><img src="/images/secp/ico_bt_arrow_left.svg" alt=""> 이전 단계</a>
                        <a href="#" class="btn-step-round btn-darkgray none" id="save-btn"><img src="/images/secp/ico_save.svg" alt=""> 임시저장</a>
                        <a href="#" class="btn-step-round none" id="next-btn">다음 단계 <img src="/images/secp/ico_bt_arrow_right.svg" alt=""></a>
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

