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
    <script src="/js/secp/biz/biz004.js"></script>
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

        <!-- 서브 헤드 //
    <div class="sub-head sub1">
        <div class="content-width">
            <h2>지원 신청</h2>
            <ul class="linemap">
                <li><a href="index.html"><img src="images/ico_home.png" alt="홈"></a></li>
                <li>지원 신청</li>
                <li>온라인 접수</li>
                <li>소상공인 경영환경 개선</li>
            </ul>
        </div>
    </div>
	// 서브헤드 -->

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
                        			<h4>(소상공인 사업정리 컨설팅 지원분야)</h4>
                        		</c:when>
                        		<c:otherwise>
                        			<h3>소상공인 사업정리 컨설팅</h3>
                        		</c:otherwise>
                        	</c:choose>                        
                            <p>도내 소상공인 경영안정과 자생력 강화를 위한 점포환경개선, 시스템개선, 홍보/광고 지원을 통해 지역경재 활성화 도모</p>
                        </div>
                        <div class="apply-info-body">
                            <div class="apply-info-cont">
	                            <c:choose>
	                        		<c:when test="${applyType eq 'MYDATA'}">
		                                <ul class="linemap">
		                                    <li><a href="/web/index.do"><img src="/images/secp/ico_home.png" alt="홈"></a></li>
		                                    <li>지원 신청</li>
		                                    <li>간편 접수</li>
		                                    <li>소상공인 사업정리 컨설팅</li>
		                                </ul>	                        		
	                        		</c:when>
	                        		<c:otherwise>
		                                <ul class="linemap">
		                                    <li><a href="/web/index.do"><img src="/images/secp/ico_home.png" alt="홈"></a></li>
		                                    <li>지원 신청</li>
		                                    <li>온라인 접수</li>
		                                    <li>소상공인 사업정리 컨설팅</li>
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
                        <p class="txt1" id='headTxt'><strong>개인정보 활용</strong>에 <strong>동의</strong>해 주세요.</p>
                        <ul class="step-list">
	                        <li><img src="/images/secp/ico_step1.png" alt="">개인정보 활용 동의</li>
                            <c:if test="${applyType eq 'MYDATA' }">
                            <li><img src="/images/secp/ico_step2.png" alt="">자격검증</li>
                            </c:if>
                            <li id="reg-info"><img src="/images/secp/ico_step3.png" alt="">신청정보 입력</li>
                            <li><img src="/images/secp/ico_step4.png" alt="">증빙서류 제출</li>
                        </ul>
                        
                        <c:if test="${isAgree eq 'N' }">
                        <div class="apply-lvl-container none" data-lvl="main" data-lvl-id="agree">
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
                        
	                        <div class="apply-lvl-container none" data-lvl="main" data-lvl-id="basic">
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
		                                        <th><span class="i-require">*</span> 대표자명</th>
		                                        <td><input type="text" class="inp w100p" id="rep-name" name="RPRSNTV"></td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 연락처<span class="small">(- 제외)</span></th>
		                                        <td><input type="text" class="inp w100p" id="tel" name="CTTPC"></td>
		                                    </tr>
		                                    <tr>
	                                            <th><span class="i-require">*</span> 성별</th>
	                                            <td>
	                                                <label class="mr20"><input type="radio" name="sex" value='M' id="gender-male"> 남</label>
		                                            <label><input type="radio" name="sex" id="gender-female" value='F'> 여</label>
	                                            </td>
	                                        </tr>
		                                    <tr>
	                                            <th>이메일</th>
	                                            <td>
	                                                <div class="flexline">
	                                                    <input type="text" class="inp w50p" id="email-id">
	                                                    <span class="ml5 mr5">@</span>
	                                                    <select class="w50p" id="email-domain">
	                                                        <option value="naver">naver.com</option>
	                                                    </select>
	                                                </div>
	                                            </td>
	                                        </tr>
		                                  	<tr>
		                                        <th><span class="i-require">*</span> 주소</th>
		                                        <td>
		                                            <div class="flexline"><input type="text" class="inp w100p" id="bsns-addr" name="BPLC_ADRES"><button type="button" class="btn btn-gray ml5" id="addr-search">주소검색</button></div>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 상호명</th>
		                                        <td><input type="text" class="inp w100p" id="store-name" name="ENTRPS_NM">
		                                        	<div class="small">(법인의 경우 법인 명 기재)</div>
		                                        </td>
		                                    </tr>
		                                    <tr>
	                                            <th><span class="i-require">*</span> 사업자등록번호<div class="small">(- 제외)</div></th>
	                                            <td><input type="text" class="inp w100p" id="bsns-num"></td>
	                                        </tr>
	                                        <tr>
		                                        <th><span class="i-require">*</span> 개업일</th>
		                                        <td>
		                                            <div class="flexline"><input type="text" id='open-date' class="inp w100p datepicker" readonly=readonly></div>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 폐업(예정)일</th>
		                                        <td>
		                                            <div class="flexline"><input type="text" id='close-date' class="inp w100p basicdatepicker" readonly=readonly></div>
		                                        </td>
		                                    </tr>
		                                </tbody>
		                            </table>
		                        </div>
		                        
		                        <div class="apply-write-item">
		                            <h4 class="write-stit2">컨설팅 지원분야</h4>
		                            <table class="tbl-basic">
		                                <colgroup>
		                                    <col style="width: 20%;">
		                                    <col>
		                                </colgroup>
		                                <caption>컨설팅 지원분야</caption>
		                                <tbody>
		                                    <tr>
		                                        <th>구분</th>
		                                        <td>
		                                            <label class="mr20"><input type="checkbox" class='cons-grp-1' name='CONS_GRP_1' value='직업상담'> 직업상담</label>
		                                            <label class="mr20"><input type="checkbox" class='cons-grp-1' name='CONS_GRP_1' value='심리상담'> 심리상담</label>
		                                            <label class="mr20"><input type="checkbox" class='cons-grp-1' name='CONS_GRP_1' value='창업상담'> 창업상담</label>
		                                            <label class="mr20"><input type="checkbox" class='cons-grp-1' name='CONS_GRP_1' value='경영상담'> 경영상담</label>
		                                            <label class="mr20"><input type="checkbox" class='cons-grp-1' name='CONS_GRP_1' value='금용상담'> 금융상담</label>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th>정보인지경로</th>
		                                        <td>
		                                            <label class="mr20"><input type="checkbox" class='cons-grp-2' name='CONS_GRP_2' value='발굴'> 발굴</label>
		                                            <label class="mr20"><input type="checkbox" class='cons-grp-2' name='CONS_GRP_2' value='방문접수'> 방문접수</label>
		                                            <label class="mr20"><input type="checkbox" class='cons-grp-2' name='CONS_GRP_2' value='지인소개'> 지인소개</label>
		                                            <label class="mr20"><input type="checkbox" class='cons-grp-2' name='CONS_GRP_2' value='인터넷'> 인터넷</label>
		                                            <label class="mr20"><input type="checkbox" class='cons-grp-2' name='CONS_GRP_2' value='콜센터'> 콜센터</label>
		                                            <label class="mr20"><input type="checkbox" class='cons-grp-2' name='CONS_GRP_2' value='현수막'> 현수막</label>
		                                            <label class="mr20"><input type="checkbox" class='cons-grp-2' name='CONS_GRP_2' value='지역지'> 지역지</label>
		                                            <label class="mr20"><input type="checkbox" class='cons-grp-2' name='CONS_GRP_2' value='타사업연계'> 타사업연계</label>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th>애로사항</th>
		                                        <td>
		                                            <textarea class="w100p" id='errMsg' name='ERRMSG' placeholder="애로사항을 입력해 주시기 바랍니다."></textarea>
		                                        </td>
		                                    </tr>
		                                </tbody>
		                            </table>
		                        </div>
		                    </div>
							
							<div class="apply-lvl-container none" data-lvl="main" data-lvl-id="doc">
								<div class="write-stit1 f-clear">
		                            <h3>추가서류 제출</h3>
		                            <p>별( <span class="c-red">*</span> ) 표시는 필수 입력입니다.</p>
		                        </div>
		                        <div class="apply-write-item">
		                            <h4 class="write-stit2">증빙서류 제출</h4>
		                            <table class="tbl-basic">
		                                <colgroup>
		                                    <col style="width: 30%;">
		                                    <col>
		                                </colgroup>
		                                <caption>증빙서류 제출</caption>
		                                <tbody>
		                                    <tr>
		                                        <th><span class="i-require">*</span> 사업자 등록증</th>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" id="doc-bsns" name="BSNS" accept=".jpg, .png, .pdf">
		                                                <label for="doc-bsns" class="tower-file-button">
		                                                    <span>파일첨부</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
		                                        </td>
		                                    </tr>
		                                    <tr>
		                                        <th> 폐업사실 증명원</th>
		                                        <td>
		                                            <div class="tower-file">
		                                                <input type="file" id="doc-cls-cert" name="CLS_CERT" accept=".jpg, .png, .pdf">
		                                                <label for="doc-cls-cert" class="tower-file-button">
		                                                    <span>파일첨부</span>
		                                                </label>
		                                                <button type="button" class="tower-file-clear tower-file-button">삭제</button>
		                                            </div>
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