<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>경기도 소상공인 종합지원 플랫폼</title>

	<link rel="stylesheet" type="text/css" href="/css/secp/tower-file-input.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/jquery.splitter.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/common.css">
    <link rel="stylesheet" type="text/css" href="/css/secp/ptmEnv.css">
    
    <script src="/js/secp/jquery-1.12.4.min.js"></script>
    <script src="/js/secp/jquery.splitter.js"></script>
    <script src="/js/secp/jquery-ui.min.js"></script>
    <script src="/js/secp/tower-file-input.js"></script>
    <script src="/js/secp/common.js"></script>
    <script src="/js/secp/biz/bizCmm.js"></script>
    <script src="/js/secp/biz/biz005.js"></script> 
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

            $(".chk-etc").click(function(){
                if ($(this).is(":checked")){
                    $(".inp-etc").fadeIn();
                } else {
                    $(".inp-etc").hide();
                }
            })
            
            //파일 업로드
            $('input[type=file]').fileInput();
            
        });
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
                            <h3>소상공인 판로개척 지원</h3>
                            <p>비대면 소비패턴에 맞춰 소상공인 온라인 시장 진입 유도 및 각종 전시회 참여 등 온오프라인 판로 지원 다양화 추진</p>
                        </div>
                        <div class="apply-info-body">
                            <div class="apply-info-cont">
                                <ul class="linemap">
                                    <li><a href="index.html"><img src="/images/secp/ico_home.png" alt="홈"></a></li>
                                    <li>지원 신청</li>
                                    <li>온라인 접수</li>
                                    <li>소상공인 경영환경 개선</li>
                                </ul>
                                <h4 class="apply-info-stit">지원 정보</h4>
                                <img src="/images/secp/project_info3.jpg" alt="" class="w100p">
                            </div>
                        </div>
                    </div>
                </div>
                <!--// 지원사업 정보 -->

                <!-- 지원사업 신청 //-->
                <div class="apply-write" id="apply-write">
                    <div class="apply-write-inner">
                        <p class="txt1"><strong>소상공인 판로개척 지원</strong> 지원을 신청하세요</p>
                        <ul class="step-list">
                            <li><img src="/images/secp/ico_step1.png" alt="">개인정보 활용 동의</li>
                            <c:if test="${applyType eq 'MYDATA' }">
                            <li><img src="/images/secp/ico_step2.png" alt="">자격검증</li>
                            </c:if>
                            <li><img src="/images/secp/ico_step3.png" alt="">신청정보 입력</li>
                            <li><img src="/images/secp/ico_step4.png" alt="">증빙서류 제출</li>
                        </ul>
                        
                        <ul class="step-list2 none"">
                            <li>기본정보</li>
                            <li>추진계획서</li>
                        </ul>
                        <div class="apply-lvl-container none" data-idx="0">
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
                        
                        <c:if test="${applyType eq 'MYDATA' }">
                        <div class="apply-lvl-container none" data-idx="1">
                        	자격검증 영역
                        </div>
                        </c:if>
                        
                        <div class="apply-lvl-container none" data-idx="2">
                            <div class="write-stit1 f-clear">
                                <h3>기본정보</h3>
                                <p>별( <span class="c-red">*</span> ) 표시는 필수 입력입니다.</p>
                            </div>
                            <div class="apply-write-item">
                                <h4 class="write-stit2">대표자 정보</h4>
                                <table class="tbl-basic">
                                    <colgroup>
                                        <col style="width: 20%;">
                                        <col>
                                    </colgroup>
                                    <caption>대표자 정보</caption>
                                    <tbody>
                                        <tr>
                                            <th><span class="i-require">*</span> 대표자명</th>
                                            <td><input type="text" class="inp w100p" id="rep-name"></td>
                                        </tr>
                                        <tr>
                                            <th><span class="i-require">*</span> 성별</th>
                                            <td>
                                                <label class="mr20"><input type="radio" name="sex" id="gender-male"> 남</label>
	                                            <label><input type="radio" name="sex" id="gender-female"> 여</label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span class="i-require">*</span> 연락처<span class="small">( - 제외)</span></th>
                                            <td><input type="text" class="inp w100p" id="tel"></td>
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
                                    </tbody>
                                </table>
                            </div>
    
                            <div class="apply-write-item">
                                <h4 class="write-stit2">신청인 정보</h4>
                                <table class="tbl-basic">
                                    <colgroup>
                                        <col style="width: 20%;">
                                        <col>
                                    </colgroup>
                                    <caption>신청인 정보</caption>
                                    <tbody>
                                        <tr>
                                            <th><span class="i-require">*</span> 신청인명</th>
                                            <td><input type="text" class="inp w100p" id="apply-rep-name"></td>
                                        </tr>
                                        <tr>
                                            <th><span class="i-require">*</span> 성별</th>
                                            <td>
                                                <label class="mr20"><input type="radio" name="gender" id="apply-gender-male"> 남</label>
	                                            <label><input type="radio" name="gender" id="apply-gender-female"> 여</label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span class="i-require">*</span> 연락처<span class="small">( - 제외)</span></th>
                                            <td><input type="text" class="inp w100p" id="apply-tel"></td>
                                        </tr>
                                        <tr>
                                            <th>이메일</th>
                                            <td>
                                                <div class="flexline">
                                                    <input type="text" class="inp w50p" id="apply-email-id">
                                                    <span class="ml5 mr5">@</span>
                                                    <select class="w50p" id="apply-email-domain">
                                                        <option value="naver">naver.com</option>
                                                    </select>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
    
                            
                            <div class="apply-write-item">
                                <h4 class="write-stit2">사업자 정보</h4>
                                <table class="tbl-basic">
                                    <colgroup>
                                        <col style="width: 20%;">
                                        <col>
                                    </colgroup>
                                    <caption>대표자 정보</caption>
                                    <tbody>
                                        <tr>
                                            <th><span class="i-require">*</span> 상호명</th>
                                            <td><input type="text" class="inp w100p" id="store-name">
                                                <div class="small">(법인의 경우 법인 명 기재)</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span class="i-require">*</span> 사업자등록번호<div class="small">(- 제외)</div></th>
                                            <td><input type="text" class="inp w100p" id="bsns-num"></td>
                                        </tr>
                                        <tr>
                                            <th><span class="i-require">*</span> 업태</th>
                                            <td><input type="text" class="inp w100p" id="store-type"></td>
                                        </tr>
                                        <tr>
                                            <th><span class="i-require">*</span> 종목</th>
                                            <td><input type="text" class="inp w100p" id="store-cate"></td>
                                        </tr>
                                        <tr>
                                            <th><span class="i-require">*</span> 개업일</th>
                                            <td><input type="text" class="inp w100p datepicker" id="open-date" readonly="readonly"></td>
                                                <div class="small">(사업자등록증의 개업일 기재)</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span class="i-require">*</span> 종업원 수(상시)</th>
                                            <td>
                                                <input type="text" class="inp w100p" id="staff-cnt"></td>
                                                <div class="small">(대표자 제외)</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>홈페이지</th>
                                            <td><input type="text" class="inp w100p" id="homepage"></td>
                                        </tr>
                                        <tr>
                                            <th><span class="i-require">*</span> 사업장 주소</th>
                                            <td>
                                                <div class="flexline"><input type="text" class="inp w100p" id="bsns-addr"><button type="button" class="btn btn-gray ml5" id="bsns-addr-search">주소검색</button></div>
                                                <div class="small">(경기도 소재 사업장만 신청 가능 합니다)</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span class="i-require">*</span> 공장 등록 구분</th>
                                            <td>
                                                <label class="mr20"><input type="radio" name="registerFactory" id="reg-fac-true"> 등록</label>
                                                <label><input type="radio" name="registerFactory" id="reg-fac-false"> 미등록</label>
                                                <br>
                                                <div class="small">(경기도 소재 시 입력)</div>
                                            </td>
                                        </tr>
                                        <tr class="fac-addr">
                                            <th><span class="i-require">*</span> 공장 주소</th>
                                            <td>
                                                <div class="flexline"><input type="text" class="inp w100p" id="factory-addr"><button type="button" class="btn btn-gray ml5" id="factory-addr-search">주소검색</button></div>
                                                <div class="small">(경기도 소재공장 주소지 입력)</div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
						</div> <!-- basic-container // -->
						
						<div class="apply-lvl-container none" data-idx="3">
                            <div class="write-stit1 f-clear">
                                <h3>추진계획서</h3>
                                <p><span class="c-red">*</span> 온라인 또는 오프라인 판로개척지원 분야를 선택하여 작성해주시기 바랍니다. (필수)</p>
                            </div>
                            <div class="apply-write-item">
                                <h4 class="write-stit2">온라인 판로개척 지원 <span class="small">[전시회 참가비, 지식재산권 비용 등 지원]</span></h4>
                                <table class="tbl-basic">
                                    <colgroup>
                                        <col style="width: 20%;">
                                        <col>
                                    </colgroup>
                                    <caption>온라인 판로개척 지원 </caption>
                                    <tbody>
                                        <tr>
                                            <th>온라인 마켓 입점 <p class="small">(현황 및 입점 계획서)</p></th>
                                            <td>
                                                <div class="tower-file">
                                                    <input type="file" id="onlineFile">
                                                    <label for="onlineFile" class="tower-file-button">
                                                        <span>파일첨부</span>
                                                    </label>
                                                    <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                                    <button type="button" class="btn btn-white btn-medium" id="ptm-online">양식 다운로드</button>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
    
                            <div class="apply-write-item">
                                <h4 class="write-stit2">오프라인 판로개척 지원 <span class="small">[전시회 참가비, 지식재산권 비용 등 지원]</span></h4>
                                <table class="tbl-basic">
                                    <colgroup>
                                        <col style="width: 20%;">
                                        <col>
                                    </colgroup>
                                    <caption>오프라인 판로개척 지원</caption>
                                    <tbody>
                                        <tr>
                                            <th>전시회 참가 신청 계획서</th>
                                            <td>
                                                <div class="tower-file">
                                                    <input type="file" id="offlineFile">
                                                    <label for="offlineFile" class="tower-file-button">
                                                        <span>파일첨부</span>
                                                    </label>
                                                    <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                                    <button type="button" class="btn btn-white btn-medium" id="ptm-offline">양식 다운로드</button>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
						</div> <!-- type-container // -->
						
						<div class="apply-lvl-container none" data-idx="4">
                            <div class="write-stit1 f-clear">
                                <h3>추가서류 제출</h3>
                                <p>별( <span class="c-red">*</span> ) 표시는 필수 입력입니다.</p>
                            </div>
                            <div class="apply-write-item">
                                <h4 class="write-stit2">필수 서류</h4>
                                <table class="tbl-basic">
                                    <colgroup>
                                        <col style="width: 20%;">
                                        <col>
                                    </colgroup>
                                    <caption>필수 서류</caption>
                                    <tbody>
                                        <tr>
                                            <th><span class="i-require">*</span> 사업자등록증</th>
                                            <td>
                                                <div class="tower-file">
                                                    <input type="file" id="licenseFile">
                                                    <label for="licenseFile" class="tower-file-button">
                                                        <span>파일첨부</span>
                                                    </label>
                                                    <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span class="i-require">*</span> 소상공인 확인서</th>
                                            <td>
                                                <div class="tower-file">
                                                    <input type="file" id="atmaFile">
                                                    <label for="atmaFile" class="tower-file-button">
                                                        <span>파일첨부</span>
                                                    </label>
                                                    <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                                </div>
                                                <p class="small mt5">(중소기업현황정보시스템 발급)</p>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
    
                            <div class="apply-write-item">
                                <h4 class="write-stit2">우대사항(가점) 서류</h4>
                                <table class="tbl-basic">
                                    <colgroup>
                                        <col style="width: 20%;">
                                        <col>
                                    </colgroup>
                                    <caption>우대사항(가점) 서류</caption>
                                    <tbody>
                                        <tr>
                                            <th>최근 3년 간 가점 대상 수혜 사업</th>
                                            <td>
                                                <div class="tower-file">
                                                    <input type="file" id="benefitFile">
                                                    <label for="benefitFile" class="tower-file-button">
                                                        <span>파일첨부</span>
                                                    </label>
                                                    <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                                </div>
                                                <p class="small mt5">(소상공인 청년사관학교 수료증)</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>소공인 집적지구 입점 기업</th>
                                            <td>
                                                <div class="tower-file">
                                                    <input type="file" id="launchFile">
                                                    <label for="launchFile" class="tower-file-button">
                                                        <span>파일첨부</span>
                                                    </label>
                                                    <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                                </div>
                                                <p class="small mt5">(경기도 소재 공장 등록증)</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>최근 2년 간 일자리 창출기업</th>
                                            <td>
                                                <div class="tower-file">
                                                    <input type="file" id="createFile">
                                                    <label for="createFile" class="tower-file-button">
                                                        <span>파일첨부</span>
                                                    </label>
                                                    <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                                </div>
                                                <p class="small mt5">(4대 사회보험 사업장 가입자 가입명부)</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>경기도 창업 <p class="small">(경영교육 12시간 이상 수료)</p></th>
                                            <td>
                                                <div class="tower-file">
                                                    <input type="file" id="eduFile">
                                                    <label for="eduFile" class="tower-file-button">
                                                        <span>파일첨부</span>
                                                    </label>
                                                    <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                                </div>
                                                <p class="small mt5">(경기도 자영업아카데미 12 시간 수료증)</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>기타 우대 서류</th>
                                            <td>
                                                <div class="tower-file">
                                                    <input type="file" id="etcFile">
                                                    <label for="etcFile" class="tower-file-button">
                                                        <span>파일첨부</span>
                                                    </label>
                                                    <button type="button" class="tower-file-clear tower-file-button">삭제</button>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
						</div> <!-- exec-plan-container // -->
                        
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