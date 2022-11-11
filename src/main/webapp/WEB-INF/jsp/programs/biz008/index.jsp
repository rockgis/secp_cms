<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf"%>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf"%>
<!DOCTYPE HTML>
<html lang="ko">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta property="og:image" content="">
	<meta name="keywords" content="">
	<meta name="description" content="">
	<sec:csrfMetaTags />
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
	<script src="/js/secp/biz/biz008.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		window['APPLY_TYPE'] = '${applyType}';
		window['IS_AGREE'] = '${isAgree}';
		
		$(function() {
			$('.apply-wrap').width('100%').height('100%').split({
				orientation : 'vertical',
				limit : 0,
				position : '50%',
				percent : true
			});
			$(window).resize(function() {
				var width = window.outerWidth;
				if (width >= 1200) {
					$('.apply-info').css({left : '0%', width : '49.4271%'});
					$('.apply-write').css({left : '50.2083%', width : '49.7917%'});
					$('.vsplitter').css({left : '49.4271%'});
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
		
		$(document).ready(function() {
			$('input[type=file]').fileInput();
			
			// 합계자동계산 -> input id값 : priceAndVat
			function fnReplace(val){	// 이거 안하면 10 + 10 -> 1010으로 나와 알지?
				let ret = 0;
				if(typeof val != "undefined" && val != null && val != ''){
					ret = Number(val.replace(/, /gi, ''));
				}
				return ret;
			}
			// 간판 합계
			$("#supplyPrice").on("propertychange change paste input" ,function(){
				let supplyPrice = fnReplace($("#supplyPrice").val()); 
				let vat = fnReplace($("#vat").val());
				
				$("#priceAndVat").val(supplyPrice + vat);
			});
			$("#vat").on("propertychange change paste input" ,function(){
				let supplyPrice = fnReplace($("#supplyPrice").val()); 
				let vat = fnReplace($("#vat").val());
				
				$("#priceAndVat").val(supplyPrice + vat);
			});
			
			// 인테리어 합계
			$("#supplyPrice2").on("propertychange change paste input" ,function(){
				let supplyPrice2 = fnReplace($("#supplyPrice2").val()); 
				let vat2 = fnReplace($("#vat2").val());
				
				$("#priceAndVat2").val(supplyPrice2 + vat2);
			});
			$("#vat2").on("propertychange change paste input" ,function(){
				let supplyPrice2 = fnReplace($("#supplyPrice2").val()); 
				let vat2 = fnReplace($("#vat2").val());
				
				$("#priceAndVat2").val(supplyPrice2 + vat2);
			});
		});
	</script>
	
	<style>
		#tap_group {
			text-align: center;
            background-color: Gray;
            padding-top: 3px;
            padding-left: 3px;
            padding-right: 3px;
            width: 205px;
            border-top-left-radius: 5px;
            border-top-right-radius: 5px;
            border: 0px solid transparent;
            float: left;
        }
	
		#tap_1 {
			width: 120px;
            font-size: 15px;
            font-weight: bold;
            border-top-left-radius: 5px;
            border-top-right-radius: 5px;
            border: 0px solid;
            margin-right: 1px;
            vertical-align: bottom;
        }
        
        #tap_2 {
        	background-color: white;
        	font-size: 14px;
        	margin-bottom: 2px;
        	width: 70px;
        	border: 0.5px solid;
        	vertical-align: bottom;
        }

        #tap_1:hover {
            background-color: skyblue;
        }
	</style>
</head>

<body>
	<div class="wrap apply">
		<!-- 상단 영역 //-->
		<%@ include file="/WEB-INF/jsp/programs/header.jsp"%>
		<!--// 상단 영역 -->

		<!-- 콘텐츠 영역 //-->
		<div class="sub-content">
			<a href="#" class="btn-allproject"><i>+</i> 전체 <span>지원사업</span></a>
			<div class="apply-wrap">
				<!-- 지원사업 정보 //-->
				<div class="apply-info">
					<div class="apply-info-inner">
						<div class="apply-info-head" style="background-image: url(/images/secp/project_head1.jpg);">
							<h3>명품점포 육성 지원</h3>
							<p>명품점포 육성 지원에 대한 간략한 설명이 들어가는 자리입니다.</p>
						</div>
						<div class="apply-info-body">
							<div class="apply-info-cont">
								<ul class="linemap">
									<li><a href="index.html"><img src="/images/secp/ico_home.png" alt="홈"></a></li>
									<li>지원 신청</li>
									<li>온라인 접수</li>
									<li>명품점포 육성 지원</li>
								</ul>
								<h4 class="apply-info-stit">지원 정보</h4>
								<!-- 추후 이미지 넣을거 <img alt="" src=""> -->
							</div>
						</div>
					</div>
				</div>
				<!--// 지원사업 정보 -->

				<!-- 지원사업 신청 //-->
				<div class="apply-write" id="apply-write">
					<div class="apply-write-inner">
						<p class="txt1"><strong>명품점포 육성 지원</strong>을 신청하세요.</p>
						<ul class="step-list">
							<li><img src="/images/secp/ico_step1.png" alt="">개인정보활용 동의</li>
							<c:if test="${applyType eq 'MYDATA' }">
							<li><img src="/images/secp/ico_step2.png" alt="">자격검증</li>
							</c:if>
							<li id="reg-info"><img src="/images/secp/ico_step3.png" alt="">신청정보 입력</li>
							<li><img src="/images/secp/ico_step4.png" alt="">증빙서류 제출</li>
						</ul>
						
						<ul class="step-list2 none" data-main-id="reg-info">
							<li>기본정보</li>
							<li>신청항목 정보</li>
							<li>추진계획 작성</li>
							<li>시공제작 정보</li>
						</ul>

						<!-- 개인정보 활용 동의 ***********************************************-->
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
										<input type="radio"name="radio2" id="radio2-2" value="N">
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
						<!-- 개인정보 활용 동의 ***********************************************-->

						<!-- apply7_0 ***000000000000000000000000000000000000000000000자격검증 -->
						<c:if test="${applyType eq 'MYDATA' }">
						<div class="apply-lvl-container none" data-lvl-id="">
							자격검증 영역
						</div>
						</c:if>
  						<!-- apply7_0 ***000000000000000000000000000000000000000000000자격검증 -->

						<form id="form">
							<input type="hidden" id="csrf" name="_csrf">
							<input type="hidden" id="bizYr" name="BIZ_YR" value="${bizYr }">
		                	<input type="hidden" id="bizNo" name="BIZ_NO" value="${bizNo }">
		                	<input type="hidden" id="bizCycl" name="BIZ_CYCL" value="${bizCycl }">
						
						<!-- apply7_1 ***11111111111111111111111111111111111111111111111111 -->
	 					<div class="apply-lvl-container none" data-lvl="sub" data-lvl-id="basic">
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
											<td><input id="repNm" type="text" class="inp w100p"></td>
										</tr>
										<tr>
											<th>
												<span class="i-require">*</span>연락처
												<span class="small">( - 제외)</span>
											</th>
											<td><input id="tel" type="text" class="inp w100p"></td>
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
									<caption>사업자 정보</caption>
									<tbody>
										<tr>
											<th><span class="i-require">*</span> 상호명</th>
											<td>
												<input id="storeNm" type="text" class="inp w100p">
												<div class="small">(법인의 경우 법인 명 기재)</div>
											</td>
										</tr>
										<tr>
											<th>
												<span class="i-require">*</span> 사업자등록번호
												<div class="small">(- 제외)</div>
											</th>
											<td><input id="bsnsNum" type="text" class="inp w100p"></td>
										</tr>
										<tr>
											<th><span class="i-require">*</span> 업태</th>
											<td><input id="storeType" type="text" class="inp w100p"></td>
										</tr>
										<tr>
											<th><span class="i-require">*</span> 종목</th>
											<td><input id="storeType_type" type="text" class="inp w100p"></td>
										</tr>
										<tr>
											<th><span class="i-require">*</span> 개업일</th>
											<td><input type="text" class="inp w100p datepicker" id="openDate" name="OPBIZ_DE" readonly="readonly"></td>
											<!-- <td>
												<div class="flexline">
													<input type="text" class="inp w100p datepicker">
												</div>
												<div class="small">(사업자등록증의 개업일 기재)</div>
											</td> -->
										</tr>
										<tr>
											<th><span class="i-require">*</span> 세부아이템</th>
											<td><input id="detailItem" type="text" class="inp w100p"></td>
										</tr>
										<tr>
											<th><span class="i-require">*</span> 소속시장명</th>
											<td><input id="belongMarket" type="text" class="inp w100p"></td>
										</tr>
										<tr>
											<th><span class="i-require">*</span> 사업장 주소</th>
											<td>
												<!-- <div class="flexline">
													<input type="text" class="inp w100p" id="bsns-addr" name="BPLC_ADRES">
													<button type="button" class="btn btn-gray ml5" id="addr-search">주소검색</button>
												</div> -->
												<div class="flexline">
													<input id="bsnsAddr" type="text" class="inp w100p"name="BPLC_ADRES">
													<button type="button" class="btn btn-gray ml5" id="addr-search">주소검색</button>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="apply-write-item">
								<h4 class="write-stit2">사업운영 현황</h4>
								<table class="tbl-basic">
									<colgroup>
										<col style="width: 20%;">
										<col>
									</colgroup>
									<caption>사업운영 현황</caption>
									<tbody>
										<tr>
											<th><span class="i-require">*</span> 점포형태</th>
											<td>
												<label class="mr20"><input id="self" type="radio" name="radio1"> 자가</label>
												<label><input id="hire" type="radio" name="radio1"> 임차</label>
											</td>
										</tr>
										<tr>
											<th>
												<span class="i-require">*</span> 점포면적
												<div class="small">(m2/평)</div>
											</th>
											<td><input id="storeArea" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" type="text" class="inp w100p"></td>
										</tr>
										<tr>
											<th><span class="i-require">*</span> 점포운영형태</th>
											<td>
												<label class="mr20"><input id="independentStore" type="radio"name="radio2"> 독립건물 점포</label>
												<label class="mr20"><input id="communalStore" type="radio" name="radio2"> 공동건물 점포</label>
												<label class="mr20"><input id="storeInStore" type="radio" name="radio2"> 점포 內 점포 (Shop in Shop)</label>
											</td>
										</tr>
										<tr>
											<th><span class="i-require">*</span> 종업원 수 (상시)</th>
											<td>
												<input id="staffCnt" type="text" class="inp w100p">
												<div class="small">(대표자 제외)</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="apply-write-item">
								<h4 class="write-stit2">매출 정보</h4>
								<p class="mb10 small">
									※ 직전 3개년의 부가세 과세표준 증명의 매출정보를 기재 <span class="small">(면세사업자의 경우 면세사업자 수입금액증명 기준)</span>
								</p>
								<table class="tbl-list">
									<colgroup>
										<col style="width: 10%;">
										<col style="width: 45%;">
										<col>
									</colgroup>
									<caption>매출 정보</caption>
									<thead>
										<th>과세구분</th>
										<th><span class="i-require">*</span> 과세표준금액</th>
										<th>매출기간</th>
									</thead>
									<tbody>
										<tr>
											<th>2019</th>
											<td>
												<div class="flexline">
													<input id="TaxBaseAmount1" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" type="text" class="inp w100p">
													<span class="ml5">만원</span>
												</div>
											</td>
											<td><input id="salesPeriod1" type="text" class="inp w100p"></td>
										</tr>
										<tr>
											<th>2020</th>
											<td>
												<div class="flexline">
													<input id="TaxBaseAmount2" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" type="text" class="inp w100p">
													<span class="ml5">만원</span>
												</div>
											</td>
											<td><input id="salesPeriod2" type="text" class="inp w100p"></td>
										</tr>
										<tr>
											<th>2021</th>
											<td>
												<div class="flexline">
													<input id="TaxBaseAmount3" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" type="text" class="inp w100p">
													<span class="ml5">만원</span>
												</div>
											</td>
											<td><input id="salesPeriod3" type="text" class="inp w100p"></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
							<!-- apply7_1 ***11111111111111111111111111111111111111111111111111 -->

							<!-- apply7_2 ***22222222222222222222222222222222222222222222222222 -->
						<div class="apply-lvl-container none" data-lvl="sub" data-lvl-id="applicationItems">
							<div class="write-stit1 f-clear">
								<h3>신청항목 정보</h3>
								<p>별( <span class="c-red">*</span> ) 표시는 필수 입력입니다.</p>
							</div>

							<div class="apply-write-item">
								<h4 class="write-stit2">지원신청 내용</h4>
								<table class="tbl-list">
									<colgroup>
										<col style="width: 15%;">
										<col style="width: 30%;">
										<col>
									</colgroup>
									<caption>지원신청 내용</caption>
									<thead>
										<th><span class="i-require">*</span> 신청구분</th>
										<th>지원 금액</th>
										<th><span class="i-require">*</span> 환경개선 지원항목</th>
									</thead>
									<tbody>
										<tr>
											<th class="t-left">
												<label>
													<input id="newApplication" type="radio" name="radio1" > 신규
												</label>
											</th>
											<td>[ 공급가 100% / 최대 800만원 ]</td>
											<td rowspan="2" class="t-left">
												<label>
													<input name="environImprove" type="checkbox"> 간판제작 <span class="small">(LED간판, 판형 FLEX, 네온류 등)</span>
												</label><br> 
												<label>
													<input name="environImprove" type="checkbox"> 점포 내부인테리어 <span class="small">(도배, 도색, 바닥공사, 전기공사 등)</span>
												</label><br>
												<label>
													<input name="environImprove" type="checkbox"> 상품재배열 <span class="small">(진열대 구입, 진열 소도구 및 냉장 진열대 구입 등)</span>
												</label><br>
												<label>
													<input name="environImprove" type="checkbox"> 온라인 환경개선 <span class="small">(홈페이지제작 ·고도화 등)</span>
												</label><br>
												<label>
													<input id="environImproveEtc" name="environImprove" type="checkbox"> 기타
												</label><br>
													<input id="environImproveEtcInput" type="text" class="inp w100p" placeholder="기타 사업지원금 활용계획을 입력 해주시기 바랍니다">
											</td>
										</tr>
										<tr>
											<th class="t-left">
												<label>
													<input id="reCertification" type="radio" name="radio1"> 재인증
												</label>
											</th>
											<td>[ 공급가 100% / 최대 400만원 ]</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
							<!-- apply7_2 ***22222222222222222222222222222222222222222222222222 -->

							<!-- apply7_3 ***33333333333333333333333333333333333333333333333333 -->
						<div class="apply-lvl-container none" data-lvl="sub" data-lvl-id="implementationPlans">
							<div class="write-stit1 f-clear">
								<h3>추진계획 작성</h3>
								<p>별( <span class="c-red">*</span> ) 표시는 필수 입력입니다.</p>
							</div>

							<div class="apply-write-item">
								<h4 class="write-stit2">추진계획서 작성</h4>
								<table class="tbl-basic">
									<colgroup>
										<col style="width: 30%;">
										<col>
									</colgroup>
									<caption>추진계획서 작성</caption>
									<tbody>
										<th><span class="i-require">*</span> 맞춤형 환경개선사업 추진계획서</th>
										<td>
											<div class="tower-file">
												<input type="file" id="file1">
													<label for="file1" class="tower-file-button">
														<span>파일첨부</span>
													</label>
												<button type="button" class="btn btn-white btn-medium">양식 다운로드</button>
											</div>
										</td>
									</tbody>
								</table>
							</div>
	 					</div>
							<!-- apply7_3 ***33333333333333333333333333333333333333333333333333 -->

							<!-- apply7_4 ***44444444444444444444444444444444444444444444444444 -->
						<div class="apply-lvl-container none" data-lvl="sub" data-lvl-id="productionInformation">
							<div class="write-stit1 f-clear">
								<h3>시공(제작) 정보</h3>
								<p>별( <span class="c-red">*</span> ) 표시는 필수 입력입니다.</p>
							</div>
							<div class="apply-write-item">
								<h4 class="write-stit2">
									<span class="i-require">*</span> 시공(제작) 계획
								</h4>
								
								<div class="buttonbox" id="tap_group">
							        <button type="button" id="tap_1">간판제작</button>
							        <!-- <button type="button" id="tap_2">+ 추가하기</button> -->
							    </div>
								<table class="tbl-basic mb30">
									<colgroup>
										<col style="width: 25%;">
										<col>
									</colgroup>
									<caption>시공(제작) 계획</caption>
									<tbody>
										<tr>
											<th><span class="i-require">*</span> 시공업체명</th>
											<td><input id="companyNm" type="text" class="inp w100p"></td>
										</tr>
										<tr>
											<th><span class="i-require">*</span> 사업자번호</th>
											<td><input id="bsnsNum2" type="text" class="inp w100p"></td>
										</tr>
										<tr>
											<th><span class="i-require">*</span> 전화번호</th>
											<td><input id="tel2" type="text" class="inp w100p"></td>
										</tr>
										<tr>
											<th><span class="i-require">*</span> 시공(제작)내역</th>
											<td><input id="productionHistory" type="text" class="inp w100p"></td>
										</tr>
										<tr>
											<th><span class="i-require">*</span> 공급가</th>
											<td>
												<div class="flexline">
													<input id="supplyPrice" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" type="text" class="inp w100p" placeholder="공급가액은 부가세를 제외한 금액입니다."><span class="pl5">원</span>
												</div>
											</td>
										</tr>
										<tr>
											<th><span class="i-require">*</span> 부가세</th>
											<td>
												<div class="flexline">
													<input id="vat" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" type="text" class="inp w100p" placeholder="부가세는 공급가액의 10% 입니다."><span class="pl5">원</span>
												</div>
											</td>
										</tr>
										<tr>
											<th>합계</th>
											<td>
												<div class="flexline">
													<input readonly="readonly" id="priceAndVat" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" type="text" class="inp w100p"><span class="pl5">원</span>
												</div>
											</td>
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
													<input type="file" id="photoinp8"> 
													<label for="photoinp8" class="tower-file-button">
														<span>파일첨부</span>
													</label>
													<button type="button" class="tower-file-clear tower-file-button">삭제</button>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
								
								<div class="buttonbox" id="tap_group">
							        <button type="button" id="tap_1">점포내부 인테리어</button>
							        <!-- <button type="button" id="tap_2">+ 추가하기</button> -->
							    </div>
								<table class="tbl-basic">
									<colgroup>
										<col style="width: 25%;">
										<col>
									</colgroup>
									<caption>시공계획서</caption>
									<tbody>
										<tr>
											<th><span class="i-require">*</span> 시공업체명</th>
											<td><input id="companyNm2" type="text" class="inp w100p"></td>
										</tr>
										<tr>
											<th><span class="i-require">*</span> 사업자번호</th>
											<td><input id="bsnsNum3" type="text" class="inp w100p"></td>
										</tr>
										<tr>
											<th><span class="i-require">*</span> 전화번호</th>
											<td><input id="tel3" type="text" class="inp w100p"></td>
										</tr>
										<tr>
											<th><span class="i-require">*</span> 시공(제작)내역</th>
											<td><input id="productionHistory2" type="text" class="inp w100p"></td>
										</tr>
										<tr>
											<th><span class="i-require">*</span> 공급가</th>
											<td>
												<div class="flexline">
													<!-- <input type="text" class="inp w100p"><span class="pl5">원</span> -->
													<input id="supplyPrice2" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" type="text" class="inp w100p" placeholder="공급가액은 부가세를 제외한 금액입니다."><span class="pl5">원</span>
												</div>
											</td>
										</tr>
										<tr>
											<th><span class="i-require">*</span> 부가세</th>
											<td>
												<div class="flexline">
													<!-- <input type="text" class="inp w100p"><span class="pl5">원</span> -->
													<input id="vat2" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" type="text" class="inp w100p" placeholder="부가세는 공급가액의 10% 입니다."><span class="pl5">원</span>
												</div>
											</td>
										</tr>
										<tr>
											<th>합계</th>
											<td>
												<div class="flexline">
													<!-- <input type="text" class="inp w100p"><span class="pl5">원</span> -->
													<input readonly="readonly" id="priceAndVat2" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" type="text" class="inp w100p"><span class="pl5">원</span>
												</div>
											</td>
										</tr>
										<tr>
											<th><span class="i-require">*</span> 시공견적서</th>
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
											<th><span class="i-require">*</span> 사업자등록증</th>
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
						</div>
							<!-- apply7_4 ***44444444444444444444444444444444444444444444444444 -->

							<!-- apply7_5 ***55555555555555555555555555555555555555555555555555 -->
						<!-- <div class="apply-lvl-container none" data-lvl="sub" data-lvl-id=""> -->
						<div class="apply-lvl-container none" data-lvl="sub" data-lvl-id="documentaryEvidence">
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
											<th>
												<span class="i-require">*</span> 사업자등록증<br>
												<p class="small">(발급처 : 세무서, 홈택스)</p></th>
											<td>
												<div class="tower-file">
													<input type="file" id="photoinp_1">
													<label for="photoinp_1" class="tower-file-button">
														<span>파일첨부</span>
													</label>
													<button type="button" class="tower-file-clear tower-file-button">삭제</button>
												</div>
											</td>
										</tr>
										<tr>
											<th><span class="i-require">*</span> 4대 보험 사업장 가입자명부<br>
												<p class="small">(발급처 : 국민건강보험공단)</p></th>
											<td>
												<div class="tower-file">
													<input type="file" id="photoinp_2">
													<label for="photoinp_2" class="tower-file-button">
														<span>파일첨부</span>
													</label>
													<button type="button" class="tower-file-clear tower-file-button">삭제</button>
												</div>
											</td>
										</tr>
										<tr>
											<th>
												<span class="i-require">*</span> 건강보험 자격득실 확인서<br>
												<p class="small">(발급처 : 국민건강보험공단)</p></th>
											<td>
												<div class="tower-file">
													<input type="file" id="photoinp_3">
													<label for="photoinp_3" class="tower-file-button">
														<span>파일첨부</span>
													</label>
													<button type="button" class="tower-file-clear tower-file-button">삭제</button>
												</div>
											</td>
										</tr>
										<tr>
											<th>
												<span class="i-require">*</span> 직전 3개년도 부과세과세표준증명원<br>
												<p class="small">(발급처 : 세무서, 홈택스)</p>
											</th>
											<td>
												<div class="tower-file">
													<input type="file" id="photoinp_4">
													<label for="photoinp_4" class="tower-file-button">
														<span>파일첨부</span>
													</label>
													<button type="button" class="tower-file-clear tower-file-button">삭제</button>
												</div>
												<p class="small mt10">※ 면세사업자의경우 면세자업자수입금액증명원 첨부</p>
											</td>
										</tr>
										<tr>
											<th>
												<span class="i-require">*</span> 지방세 납세증명서<br>
												<p class="small">(발급처 : 주민센터, 민원24)</p>
											</th>
											<td>
												<div class="tower-file">
													<input type="file" id="photoinp_5">
													<label for="photoinp_5" class="tower-file-button">
														<span>파일첨부</span>
													</label>
													<button type="button" class="tower-file-clear tower-file-button">삭제</button>
												</div>
											</td>
										</tr>
										<tr>
											<th>
												<span class="i-require">*</span> (국세) 납세증명서<br>
												<p class="small">(발급처 : 세무서, 홈택스)</p>
											</th>
											<td>
												<div class="tower-file">
													<input type="file" id="photoinp_6">
													<label for="photoinp_6" class="tower-file-button">
														<span>파일첨부</span>
													</label>
													<button type="button" class="tower-file-clear tower-file-button">삭제</button>
												</div>
											</td>
										</tr>
										<tr>
											<th>
												<span class="i-require">*</span> 심사·선정에 관한 점포대표 동의서
											</th>
											<td>
												<div class="tower-file">
													<input type="file" id="photoinp_7">
													<label for="photoinp_7" class="tower-file-button">
														<span>파일첨부</span>
													</label>
													<button type="button" class="tower-file-clear tower-file-button">삭제</button>
													<button type="button" class="btn btn-white btn-medium">양식 다운로드</button>
												</div>
											</td>
										</tr>
										<tr>
											<th>
												<span class="i-require">*</span> 상인회 추천서
											</th>
											<td>
												<div class="tower-file">
													<input type="file" id="photoinp_8">
													<label for="photoinp_8" class="tower-file-button">
														<span>파일첨부</span>
													</label>
													<button type="button" class="tower-file-clear tower-file-button">삭제</button>
													<button type="button" class="btn btn-white btn-medium">양식 다운로드</button>
												</div>
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
											<th>경기도 지사 표창</th>
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
											<th>착한 가격업소 선정점포</th>
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
											<th>기타 우수성 입증 서류</th>
											<td>
												<div class="tower-file">
													<input type="file" id="photoinp6">
													<label for="photoinp6" class="tower-file-button">
														<span>파일첨부</span>
													</label>
													<button type="button" class="tower-file-clear tower-file-button">삭제</button>
													<button type="button" class="btn btn-gray btn-medium">+</button>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
							<!-- apply7_5 ***55555555555555555555555555555555555555555555555555 -->

							<div class="btn-step-wrap">
								<a href="#" class="btn-step-round gray none" id="list-btn"><img src="/images/secp/ico_bt_arrow_left.svg" alt="">목록으로</a>
								<a href="#" class="btn-step-round gray none" id="prev-btn"><img src="/images/secp/ico_bt_arrow_left.svg" alt="">이전 단계</a>
								<a href="#" class="btn-step-round btn-darkgray none" id="save-btn"><img src="/images/secp/ico_save.svg" alt=""> 임시저장</a>
								<a href="#" class="btn-step-round none" id="next-btn">다음 단계 <img src="/images/secp/ico_bt_arrow_right.svg" alt=""></a>
								<a href="#" class="btn-step-round btn-red none" id="submit-btn">제출하기 <img src="/images/secp/ico_bt_arrow_right.svg" alt=""></a>
							</div>
						</form>
					</div>
				</div>
				<!-- 지원사업 신청 //-->

			</div>
		</div>
		<!--// 콘텐츠 영역 -->

		<!-- 푸터 영역 //-->
		<%@ include file="/WEB-INF/jsp/programs/footer.jsp"%>
		<!--// 푸터 영역 -->
	</div>
</body>
</html>