<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- <link rel="stylesheet" type="text/css" href="/css/secp/common.css"> -->


<style type="text/css">

	/* 커스텀 칼럼 스타일 정의 */
	.my-column {
		text-align:right;
	}
	.my-color {
		color: #00aa00;
	}

	/* 커스텀 칼럼 스타일 정의*/
	.myLinkStyle {
		text-decoration: underline;
		color: #4374D9;
	}

	.myLinkStyle :hover {
		color: #FF0000;
	}

</style>

<script type="text/javascript" src="<c:url value="/js/admin/common.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/admin/biz003/introB.js"/>"></script>


<script type="text/javascript">

	// AUIGrid 생성 후 반환 ID
	var myGridID;


	// document ready (jQuery 의 $(document).ready(function() {}); 과 같은 역할을 합니다.
	function documentReady() {

		// AUIGrid 그리드를 생성합니다.

		//columnLayoutTemp = createColumnData();

		console.log("########################### columnLayoutTemp #######################");
		//console.log(columnLayoutTemp);

		var headerUrl = "/super/bizmanage/getHeader.do";


		createAUIGrid(columnLayout);





		// ajax 요청 전 그리드에 로더 표시
		//AUIGrid.showAjaxLoader(myGridID);

		// ajax (XMLHttpRequest) 로 그리드 데이터 요청
		ajax({
			url : headerUrl,

			onSuccess : function(data) {
				//console.log("data:::"+data);
				// 그리드에 데이터 세팅
				// data 는 JSON 을 파싱한 Array-Object 입니다.
				//AUIGrid.setGridData(myGridID, data);


				//data = "-";
				//createAUIGrid(data);


				// 로더 제거
				//AUIGrid.removeAjaxLoader(myGridID);
			},
			onError : function(status, e) {
				alert("데이터 요청에 실패하였습니다.\r\n status : " + status + "\r\nWAS 를 IIS 로 사용하는 경우 json 확장자가 web.config 의 handler 에 등록되었는지 확인하십시오.");
				// 로더 제거
				//AUIGrid.removeAjaxLoader(myGridID);
			}
		});







	};

	var columnLayout = [{
		"headerText" : "접수정보",
		"children": [{
			"dataField": "SN",
			"headerText": "순번",
			"editable": false
		}, {
			"dataField" : "RCEPT_NO",
			"headerText" : "접수번호",
			"editable": false,
			"width" : 130
		}, {
			"dataField" : "RCEPT_SE",
			"headerText" : "접수구분",
			"editable": false
		}, {
			"dataField" : "DSTRCT",
			"headerText" : "권역",
			"editable": false
		}, {
			"dataField" : "RCEPT_DT",
			"headerText" : "접수일시",
			"editable": false,
			"dataType": "date",
			"formatString": "yyyy. mm. dd"
		}, {
			"dataField" : "CHANGE_DT",
			"headerText" : "변경일시",
			"editable": false,
			"dataType": "date",
			"formatString": "yyyy. mm. dd"
		}] // end of 접수정보 "children"
	}, {
		"headerText" : "진행상태",
		"children": [{
			"dataField": "STEP",
			"headerText": "단계",
			"editable": false
		}, {
			"dataField" : "STTUS",
			"headerText" : "상태",
			"editable": false
		}] // end of 진행상태 "children"
	}, {
		"headerText" : "사업체 신청 정보",
		"children": [{
			"dataField" : "REQST_REALM",
			"headerText" : "신청분야",
			"editable": false
		}, {
			"dataField" : "AREA",
			"headerText" : "지역",
			"editable": false
		}, {
			"dataField" : "ENTRPS_NM",
			"headerText" : "업체명",
			"editable": false
		}, {
			"dataField" : "BSNM_NO",
			"headerText" : "사업자 번호",
			"editable": false,
			"width" : 120
		},{
			"dataField" : "TAXT_TY",
			"headerText" : "과세유형",
			"editable": false
		},{
			"dataField" : "BIZCND",
			"headerText" : "업태",
			"editable": false
		},{
			"dataField" : "ITEM",
			"headerText" : "종목",
			"editable": false
		},{
			"dataField" : "OPBIZ_DE",
			"headerText" : "개업일자",
			"editable": false,
			"dataType": "date",
			"formatString": "yyyy. mm. dd "
		},{
			"dataField" : "BPLC_ADRES",
			"headerText" : "사업장 주소",
			"editable": false,
			"width" : 200
		},{
			"dataField" : "EMPLY_CO",
			"headerText" : "종업원 수",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}] // end of 사업체 신청 정보 "children"
	}, {
		"headerText" : "대표자 정보",
		"children": [{
			"dataField" : "RPRSNTV",
			"headerText" : "대표자명",
			"editable": false
		}, {
			"dataField" : "LIFYEA",
			"headerText" : "생년월일",
			"editable": false,
			"dataType": "date",
			"formatString": "yyyy. mm. dd"
		}, {
			"dataField" : "SEXDSTN",
			"headerText" : "성별",
			"editable": false
		},{
			"dataField" : "CTTPC",
			"headerText" : "연락처",
			"editable": false,
			"width" : 120
		}] // end of 대표자 정보 "children"
	}, {
		"headerText" : "필수 서류",
		"children": [{
			"dataField" : "SPORT_REQSTDOC",
			"headerText" : "지원신청서",
			"editable": false,
			"style": "myLinkStyle",
			// LinkRenderer 를 활용하여 javascript 함수 호출로 사용하고자 하는 경우
			"renderer": {
				"type": "LinkRenderer",
				"baseUrl": "javascript", // 자바스크립 함수 호출로 사용하고자 하는 경우에 baseUrl 에 "javascript" 로 설정
				// baseUrl 에 javascript 로 설정한 경우, 링크 클릭 시 callback 호출됨.
				"jsCallback": function (rowIndex, columnIndex, value, item) {
					alert("( " + rowIndex + ", " + columnIndex + " ) " + item.SPORT_REQSTDOC + "  Link 클릭\r\n자바스크립트 함수 호출하고자 하는 경우로 사용하세요!");
				}
			}
		}, {
			"dataField" : "INDVDLINFO_WRTCNS",
			"headerText" : "개인정보 동의서",
			"editable": false,
			"width": 120,
			"style": "myLinkStyle",
			// 전체 URL 은 baseUrl + linkField 의 값으로 결정됨.
			// baseUrl 설정하지 않으면 linkField 의 값이 URL임(즉, linkField 의 값은 온전한 URL형태를 갖는 데이터여야함)
			"renderer": {
				"type": "LinkRenderer",
				"linkField": "개인정보 동의서",
				"baseUrl": "https://en.wikipedia.org/wiki/" // 기본 URL
			}
		}, {
			"dataField" : "CNFIRM_PROMS_PAPERS",
			"headerText" : "확약서",
			"editable": false,
			"style": "myLinkStyle",
			// LinkRenderer 를 활용하여 javascript 함수 호출로 사용하고자 하는 경우
			"renderer": {
				"type": "LinkRenderer",
				"baseUrl": "javascript", // 자바스크립 함수 호출로 사용하고자 하는 경우에 baseUrl 에 "javascript" 로 설정
				// baseUrl 에 javascript 로 설정한 경우, 링크 클릭 시 callback 호출됨.
				"jsCallback": function (rowIndex, columnIndex, value, item) {
					alert("( " + rowIndex + ", " + columnIndex + " ) " + item.CNFIRM_PROMS_PAPERS + "  Link 클릭\r\n자바스크립트 함수 호출하고자 하는 경우로 사용하세요!");
				}
			}
		}, {
			"dataField" : "PRTN_ACTPLN",
			"headerText" : "추진계획서",
			"editable": false,
			"style": "myLinkStyle",
			// LinkRenderer 를 활용하여 javascript 함수 호출로 사용하고자 하는 경우
			"renderer": {
				"type": "LinkRenderer",
				"baseUrl": "javascript", // 자바스크립 함수 호출로 사용하고자 하는 경우에 baseUrl 에 "javascript" 로 설정
				// baseUrl 에 javascript 로 설정한 경우, 링크 클릭 시 callback 호출됨.
				"jsCallback": function (rowIndex, columnIndex, value, item) {
					alert("( " + rowIndex + ", " + columnIndex + " ) " + item.PRTN_ACTPLN + "  Link 클릭\r\n자바스크립트 함수 호출하고자 하는 경우로 사용하세요!");
				}
			}
		}, {
			"dataField" : "BSNM_CEREGRT",
			"headerText" : "사업자 등록증",
			"editable": false,
			"width": 120,
			"style": "myLinkStyle",
			// LinkRenderer 를 활용하여 javascript 함수 호출로 사용하고자 하는 경우
			"renderer": {
				"type": "LinkRenderer",
				"baseUrl": "javascript", // 자바스크립 함수 호출로 사용하고자 하는 경우에 baseUrl 에 "javascript" 로 설정
				// baseUrl 에 javascript 로 설정한 경우, 링크 클릭 시 callback 호출됨.
				"jsCallback": function (rowIndex, columnIndex, value, item) {
					alert("( " + rowIndex + ", " + columnIndex + " ) " + item.BSNM_CEREGRT + "  Link 클릭\r\n자바스크립트 함수 호출하고자 하는 경우로 사용하세요!");
				}
			}
		}, {
			"dataField" : "VAT_CRTF",
			"headerText" : "부가세 증명",
			"editable": false,
			"style": "myLinkStyle",
			// LinkRenderer 를 활용하여 javascript 함수 호출로 사용하고자 하는 경우
			"renderer": {
				"type": "LinkRenderer",
				"baseUrl": "javascript", // 자바스크립 함수 호출로 사용하고자 하는 경우에 baseUrl 에 "javascript" 로 설정
				// baseUrl 에 javascript 로 설정한 경우, 링크 클릭 시 callback 호출됨.
				"jsCallback": function (rowIndex, columnIndex, value, item) {
					alert("( " + rowIndex + ", " + columnIndex + " ) " + item.VAT_CRTF + "  Link 클릭\r\n자바스크립트 함수 호출하고자 하는 경우로 사용하세요!");
				}
			}
		}, {
			"dataField" : "CPR_ADIT_PAPERS",
			"headerText" : "법인추가 서류",
			"editable": false,
			"width": 120,
			"style": "myLinkStyle",
			// LinkRenderer 를 활용하여 javascript 함수 호출로 사용하고자 하는 경우
			"renderer": {
				"type": "LinkRenderer",
				"baseUrl": "javascript", // 자바스크립 함수 호출로 사용하고자 하는 경우에 baseUrl 에 "javascript" 로 설정
				// baseUrl 에 javascript 로 설정한 경우, 링크 클릭 시 callback 호출됨.
				"jsCallback": function (rowIndex, columnIndex, value, item) {
					alert("( " + rowIndex + ", " + columnIndex + " ) " + item.CPR_ADIT_PAPERS + "  Link 클릭\r\n자바스크립트 함수 호출하고자 하는 경우로 사용하세요!");
				}
			}
		}] // end of 필수 서류 "children"
	}, {
		"headerText" : "2021년 부가세과세 증명",
		"children": [{
			"dataField" : "FRHFYR_1",
			"headerText" : "상반기",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "SHYY_1",
			"headerText" : "하반기",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "1_YY_SM_1",
			"headerText" : "1년 계",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		},{
			"dataField" : "SELNG_MT_1",
			"headerText" : "매출월",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "RM_1",
			"headerText" : "비고"
		}] // end of 2021년 부가세과세 증명 "children"

	},{
		"headerText" : "2022년 부가세과세 증명",
		"children": [{
			"dataField" : "FRHFYR_2",
			"headerText" : "상반기",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "SHYY_2",
			"headerText" : "하반기",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "1_YY_SM_2",
			"headerText" : "1년 계",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		},{
			"dataField" : "SELNG_MT_2",
			"headerText" : "매출월",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "RM_2",
			"headerText" : "비고"
		}] // end of 2022년 부가세과세 증명 "children"

	},{
		"headerText" : "(월환산) 매출액",
		"children": [ {
			"dataField" : "21_YY_SELNG",
			"headerText" : "21년 매출",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "22_YY_SELNG",
			"headerText" : "22년 매출",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}] // end of (월환산) 매출액 "children"

	}, {
		"headerText" : "신청 및 지원 한도",
		"children": [{
			"dataField" : "REQST_REALM",
			"headerText" : "신청분야",
			"editable": false
		}, {
			"dataField" : "SPORT_LMT",
			"headerText" : "지원한도",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}] // end of 지원결정액 "children"
	}, {
		"headerText" : "견적서 1",
		"children": [{
			"dataField" : "CNSTRCT_ENTRPS_1",
			"headerText" : "시공업체",
			"editable": false
		}, {
			"dataField" : "BSNM_NO_1",
			"headerText" : "사업자 번호"
		}, {
			"dataField" : "REQST_REALM_DETAIL_1",
			"headerText" : "전화",
			"editable": false,
			"width" : 100
		}, {
			"dataField" : "REQST_REALM_DETAIL_1",
			"headerText" : "신청분야 세부내역",
			"editable": false,
			"width" : 120
		}, {
			"dataField" : "SPLPC_1",
			"headerText" : "공급가",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "VAT_1",
			"headerText" : "부가세 ",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "SUBSUM_1",
			"headerText" : "소계",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}] // end of 견적서 1 "children"
	}, {
		"headerText" : "견적서 2",
		"children": [{
			"dataField" : "CNSTRCT_ENTRPS_2",
			"headerText" : "시공업체",
			"editable": false
		}, {
			"dataField" : "BSNM_NO_2",
			"headerText" : "사업자 번호",
			"editable": false,
		}, {
			"dataField" : "TLPHON_2",
			"headerText" : "전화",
			"editable": false,
			"width" : 100
		}, {
			"dataField" : "REQST_REALM_DETAIL_2",
			"headerText" : "신청분야 세부내역",
			"editable": false,
			"width" : 120

		}, {
			"dataField" : "SPLPC_2",
			"headerText" : "공급 가액",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "VAT_2",
			"headerText" : "부가세 ",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "SUBSUM_2",
			"headerText" : "소계",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}] // end of 견적서 2 "children"
	},  {
		"headerText" : "견적합계",
		"children": [ {
			"dataField" : "ESTMT_TOT_SM",
			"headerText" : "견적 총 합계",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}] // end of 견적합계 "children"
	}, {
		"headerText" : "지원결정액",
		"children": [{
			"dataField" : "SPORT_DECSN_AM",
			"headerText" : "지원결정액<br/>(공급가 90%)",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "SELF_AM",
			"headerText" : "자담액<br/>(부가세포함)",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}] // end of 지원결정액 "children"
	}, {
		"headerText" : "서류메모",
		"children": [{
			"dataField" : "JDGMN_REFER",
			"headerText" : "심사참고"
		}, {
			"dataField" : "INPUT_MEMO",
			"headerText" : "입력메모"
		}, {
			"dataField" : "UPRPD_PAPERS",
			"headerText" : "추가,미비서류"
		}, {
			"dataField" : "WLSBM_INPUT",
			"headerText" : "검수입력"
		}] // end of 서류메모 "children"
	}, {
		"headerText" : "①교육, 컨설팅 ",
		"children": [{
			"dataField" : "EDC_CNSL",
			"headerText" : "내용",
			"editable": false
		}] // end of ①교육, 컨설팅 "children"
	}, {
		"headerText" : "②사회 배려자",
		"children": [{
			"dataField" : "SOCTY_WKSN",
			"headerText" : "내용",
			"editable": false
		}] // end of ②사회 배려자 "children"
	}, {
		"headerText" : "③4대보험 고용",
		"children": [{
			"dataField" : "FEINSR_EMPLYM",
			"headerText" : "인원",
			"editable": false,
			"dataType": "numeric",
			"style": "my-column",
			"width": 100,
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}] // end of ③4대보험 고용 "children"
	}, {
		"headerText" : "④탄소포인트",
		"children": [{
			"dataField" : "CARBON_PNT",
			"headerText" : "내용",
			"editable": false
		}] // end of ④탄소포인트 "children"
	},{
		"headerText" : "데이터 확인",
		"children": [{
			"dataField" : "OPBIZ_DE_RESULT",
			"headerText" : "개업일자",
			"editable": false
		}, {
			"dataField" : "BSN_DAYCNT",
			"headerText" : "영업일수"
		}] // end of 데이터 확인 "children"
	}, {
		"headerText" : "정량점수(60)",
		"children": [{
			"dataField" : "BSN_DAY",
			"headerText" : "업력",
			"dataType": "numeric",
			"style": "my-column",
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "SELNG",
			"headerText" : "매출",
			"dataType": "numeric",
			"style": "my-column",
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "DCRS_RT",
			"headerText" : "감소율",
			"dataType": "numeric",
			"style": "my-column",
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}] // end of 정량점수(60) "children"
	}, {
		"headerText" : "가산점(촤대 10, 각 2 ~5점)",
		"children": [{
			"dataField" : "EDC_CNSL_CNT",
			"headerText" : "교육, 컨설팅",
			"dataType": "numeric",
			"style": "my-column",
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "SOCTY_WKSN_CNT",
			"headerText" : "사회배려",
			"dataType": "numeric",
			"style": "my-column",
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "CARBON_PNT_CNT",
			"headerText" : "탄소점수",
			"dataType": "numeric",
			"style": "my-column",
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}] // end of 가산점(촤대 10, 각 2 ~5점) "children"
	}, {
		"headerText" : "합계(정량+가산)",
		"children": [{
			"dataField" : "FEINSR_EMPLYM_CNT",
			"headerText" : "종업원",
			"dataType": "numeric",
			"style": "my-column",
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "FDQNT_CNT",
			"headerText" : "정량",
			"dataType": "numeric",
			"style": "my-column",
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "ADDI_CNT",
			"headerText" : "가산점",
			"dataType": "numeric",
			"style": "my-column",
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "PROPER_YM",
			"headerText" : "적격여부"
		}, {
			"dataField" : "SUM_SCORE",
			"headerText" : "합계점수",
			"dataType": "numeric",
			"style": "my-column",
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}] // end of 합계(정량+가산) "children"
	}, {
		"headerText" : "정성평가",
		"children": [{
			"dataField" : "JDGMM1",
			"headerText" : "심사1",
			"dataType": "numeric",
			"style": "my-column",
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "JDGMM2",
			"headerText" : "심사2",
			"dataType": "numeric",
			"style": "my-column",
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "JDGMM3",
			"headerText" : "심사3",
			"dataType": "numeric",
			"style": "my-column",
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "AVRG",
			"headerText" : "평균",
			"dataType": "numeric",
			"style": "my-column",
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}] // end of 정성평가 "children"
	}, {
		"headerText" : "최종",
		"children": [{
			"dataField" : "SCORE",
			"headerText" : "점수",
			"dataType": "numeric",
			"style": "my-column",
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}, {
			"dataField" : "RANK",
			"headerText" : "순위",
			"dataType": "numeric",
			"style": "my-column",
			"editRenderer": {
				"type": "InputeditRenderer",
				"onlyNumeric": true,
				"textAlign": "right",
				"autoThousandSeparator": true
			}
		}] // end of 최종 "children"
	}, {
		"headerText" : "최종선정",
		"children": [{
			"dataField" : "DECSN",
			"headerText" : "결정"
		}] // end of 최종선정 children
	}, {
		"headerText" : "비고",
		"children": [{
			"dataField" : "SLCTN_EXCL",
			"headerText" : "선정제외"
		}, {
			"dataField" : "REQUST",
			"headerText" : "보안요청"
		}, {
			"dataField" : "ETC",
			"headerText" : "기타"
		}] // end of 정성평가 "children"
	} ];



	// AUIGrid 를 생성합니다.
	function createAUIGrid(columnLayout) {

		// 그리드 속성 설정
		var gridPros = {

			headerHeights : [30, 40],

			// 고정칼럼 카운트 지정
			fixedColumnCount: 3,

			// 편집 가능 여부 (기본값 : false)
			editable: true,

			// 셀 병합 실행
			enableCellMerge: true,

			// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
			enterKeyColumnBase: true,

			// 셀 선택모드 (기본값: singleCell)
			selectionMode: "multipleCells",

			// 컨텍스트 메뉴 사용 여부 (기본값 : false)
			useContextMenu: true,

			// 필터 사용 여부 (기본값 : false)
			enableFilter: true,


			// 상태 칼럼 사용
			showStateColumn: true,

			// 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
			displayTreeOpen: true,

			// 칼럼 리사아징 false 설정
			enableColumnResize: false,

			noDataMessage: "출력할 데이터가 없습니다."
			// 그룹핑 패널 사용
			//useGroupingPanel: true,

			//groupingMessage: "여기에 칼럼을 드래그하면 그룹핑이 됩니다."
		};

		// 실제로 #grid_wrap 에 그리드 생성
		myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);


		// 데이터 요청, 요청 성공 시 AUIGrid 에 데이터 삽입합니다.
		requestJsonData();

	}

	function requestJsonData() {

		// 요청 URL
		//var url = "/AUIGrid/data/normal_500.json";
		//var url = "/AUIGrid/data/gridDataList.json";
		var url = "/super/bizmanage/gridData.do";

		requestData(url);

		// ajax 요청 전 그리드에 로더 표시
// 	AUIGrid.showAjaxLoader(myGridID);

		// ajax (XMLHttpRequest) 로 그리드 데이터 요청
// 	ajax( {
// 		url : url,
// 		type : "POST",
// 		onSuccess : function(data) {

// 			console.log(data);

// 			// 그리드에 JSON 데이터 설정
// 			// data 는 JSON 을 파싱한 Array-Object 임
// 			AUIGrid.setGridData(myGridID, data);


// 			// 로더 제거
// 			AUIGrid.removeAjaxLoader(myGridID);
// 		},
// 		onError : function(status, e) {
// 			alert("데이터 요청에 실패하였습니다.\r\n status : " + status + "\r\nWAS 를 IIS 로 사용하는 경우 json 확장자가 web.config 의 handler 에 등록되었는지 확인하십시오.");
// 			// 로더 제거
// 			AUIGrid.removeAjaxLoader(myGridID);
// 		}
// 	});
	};


</script>

<div class="content-wrap">
	<div class="ct_wrap" style="width: 98%;height: 90%">
		<!-- 		<div class="conwrap_tap"> -->
		<!-- 			<ul> -->
		<%-- 				<li id='contManagerTab' ng-if="param.permit=='Y'"><a href="<c:url value="/super/homepage/modifyFrm.do"/>?cms_menu_seq={{param.cms_menu_seq}}&amp;parent_menu_seq={{param.parent_menu_seq }}&amp;permit={{param.permit}}"><span>메뉴관리</span></a></li> --%>
		<%-- 				<li class="on"><a href="${context_path }/super/homepage/bizmanage/index.do?cms_menu_seq={{param.cms_menu_seq}}&amp;parent_menu_seq={{param.parent_menu_seq}}&amp;permit={{param.permit}}" target="_self"><span>프로그램관리</span></a></li> --%>
		<!-- 			</ul> -->
		<!-- 		</div> -->
		<div class="content-head">
			<div class="content-tit f-clear">
				<h3>2023년 경영환경개선 (창업초기) – 1차</h3>
				<p>사업기간 : 2023. 1. 01.(월) ~ 4. 29.(금) 18:00</p>
			</div>

			<ul class="linemap">
				<li><img src="images/ico_home.png" alt=""></li>
				<li>2023년 경영환경개선 (창업초기) – 1차</li>
				<li>심사평가</li>
			</ul>
		</div>

		<div class="content-body">

			<ul class="tab-menu">
				<li><a href="/super/homepage/biz001/indexB01.do" class="active">심사평가</a></li>

			</ul>

			<div class="f-clear mb30">
				<div class="f-left">
					<form name=f1 style=margin:0; onsubmit="return false;" >
						<select name="codeList" id="codeList" onchange="OnChange();">
							<option value="A">1.전체 평가현황</option>
							<option selected value="B">2.정성 평가 결과 업로드</option>
						</select>
						<button type="button" class="btn btn-mint">평가자료 PDF 생성</button>
						<button type="button" class="btn btn-mint">평가결과 업로드</button>
					</form>

				</div>
				<div class="f-right">
					<button type="button" class="btn btn-green" onclick="exportTo('xlsx');" >엑셀 다운로드</button>
					<button type="button" class="btn btn-red">저장</button>
				</div>
			</div>

			<div class="grid-area" style="height: 500px;">

				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="grid_wrap" style="width:100%; height:100%; margin:0 auto;"></div>

			</div>

		</div>
	</div>

</div>



