<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- <link rel="stylesheet" type="text/css" href="/css/secp/common.css"> -->


<style type="text/css">

	/* 커스텀 칼럼 스타일 정의 */
	.my-column {
		text-align:right;
	}

</style>

<script type="text/javascript" src="<c:url value="/js/admin/common.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/admin/check_box.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/admin/biz002/introA.js"/>"></script>


<script type="text/javascript">

	// AUIGrid 생성 후 반환 ID
	var myGridID;

	// document ready (jQuery 의 $(document).ready(function() {}); 과 같은 역할을 합니다.
	function documentReady() {
		return false;
	};


	$(document).ready(function () {

		$("#btn_save").click(function(){
			updateDataToServer("/biz001/save","new");
		});

		$("#btn_del").click(function(){
			updateDataToServer("/biz001/del","del");
		});

		$("#btn_export").click(function(){
			exportTo('xlsx');
		});

		// 최초 그리드 생성함.
		createInitGrid(columnLayout);

		// IE10, 11은 readAsBinaryString 지원을 안함. 따라서 체크함.
		var rABS = typeof FileReader !== "undefined" && typeof FileReader.prototype !== "undefined" && typeof FileReader.prototype.readAsBinaryString !== "undefined";

		// HTML5 브라우저인지 체크 즉, FileReader 를 사용할 수 있는지 여부
		function checkHTML5Brower() {
			var isCompatible = false;
			if (window.File && window.FileReader && window.FileList && window.Blob) {
				isCompatible = true;
			}
			return isCompatible;
		};

		// 파일 선택하기
		$('#fileSelector').on('change', function (evt) {
			if (!checkHTML5Brower()) {
				alert("브라우저가 HTML5 를 지원하지 않습니다.\r\n서버로 업로드해서 해결하십시오.");
				return;
			} else {
				var data = null;
				var file = evt.target.files[0];
				if (typeof file == "undefined") {
					alert("파일 선택 시 오류 발생!!");
					return;
				}
				var reader = new FileReader();

				reader.onload = function (e) {
					var data = e.target.result;

					/* 엑셀 바이너리 읽기 */

					var workbook;

					if (rABS) { // 일반적인 바이너리 지원하는 경우
						workbook = XLSX.read(data, {type: 'binary'});
					} else { // IE 10, 11인 경우
						var arr = fixdata(data);
						workbook = XLSX.read(btoa(arr), {type: 'base64'});
					}

					var jsonObj = process_wb(workbook);

					createAUIGrid(jsonObj[Object.keys(jsonObj)[0]]);
				};

				if (rABS) reader.readAsBinaryString(file);
				else reader.readAsArrayBuffer(file);

			}
		});
	});



	// 데이터 서버로 보내기
	function updateDataToServer( url,type ) {

		// AUIGrid 에서 추가, 삭제, 수정된 행들 얻기
		var addList;

		if(type == "new"){
			// 추가된 행 아이템들(배열)
			addList = AUIGrid.getGridData(myGridID);

		}else{
			// 추가된 행 아이템들(배열)
			addList = AUIGrid.getAddedRowItems(myGridID);

		}

        // 수정된 행 아이템들(배열)
        var updateList = AUIGrid.getEditedRowColumnItems(myGridID);
        // 삭제된 행 아이템들(배열)
        var removeList = AUIGrid.getRemovedItems(myGridID);

        var data = {};

        if(addList.length > 0) data.add = addList;
        else data.add = [];

        if(updateList.length > 0) data.update = updateList;
        else data.update = [];

        if(removeList.length > 0) data.remove = removeList;
        else data.remove = [];

		console.log(data)

		// 위 코드를 하드 코딩하면 다음과 같습니다.
		// 위와 같은 Object 에 add, update, remove 키에 각각 배열을 갖는 구조 입니다.

		ajax({
			url: url,
			dataType : "json",
			type : "POST",
			contentType: "application/json; charset=utf-8",
			data : JSON.stringify(data),
			onSuccess: function (data) {
				console.log("data:::"+data);
				// 그리드에 데이터 세팅
				// data 는 JSON 을 파싱한 Array-Object 입니다.
				//AUIGrid.setGridData(myGridID, data);
				alert("성공:"+data.success);

				//data = "-";
				//createAUIGrid(data);

				// 로더 제거
				//AUIGrid.removeAjaxLoader(myGridID);
			},
			onError: function (status, e) {
				alert("데이터 요청에 실패하였습니다.\r\n status : " + status + "\r\nWAS 를 IIS 로 사용하는 경우 json 확장자가 web.config 의 handler 에 등록되었는지 확인하십시오.");
				// 로더 제거
				//AUIGrid.removeAjaxLoader(myGridID);
			}
		});

	};

	// 엑셀 파일 시트에서 파싱한 JSON 데이터 기반으로 그리드 동적 생성
	function createAUIGrid(csvStr) {

		if (AUIGrid.isCreated(myGridID)) {
			AUIGrid.destroy(myGridID);
			myGridID = null;
		}

		var jsonData = parseCsv(csvStr);

		var gridProps = {
			selectionMode: "multipleCells"
		};

		// 현재 엑셀 파일의 0번째 행을 기준으로 컬럼을 작성함.
		// 만약 상단에 문서 제목과 같이 있는 경우
		// 조정 필요.
		var firstRow = jsonData[4];

		if (typeof firstRow == "undefined") {
			alert("Grid 로 변환할 수 없는 엑셀 파일입니다.");
			return;
		}

		// 그리드 생성
		myGridID = AUIGrid.create("#grid_wrap", columnLayout_temp, gridProps);

		// 그리드에 CSV 데이터 삽입
		//AUIGrid.setCsvGridData(myGridID, csvStr, false);
		// 그리드에 Array 데이터 삽입
		AUIGrid.setGridData(myGridID, jsonData, false);

	};

	function reloadAUIGrid() {
		// AUIGrid 그리드를 생성합니다.
		if (AUIGrid.isCreated(myGridID)) {
			AUIGrid.destroy(myGridID);
			myGridID = null;
		}

		console.log("########################### columnLayoutTemp #######################");
		//console.log(columnLayoutTemp);

		var headerUrl = "/super/bizmanage/getHeader.do";

		ajax({
			url: headerUrl,

			onSuccess: function (data) {
				//console.log("data:::"+data);
				// 그리드에 데이터 세팅
				// data 는 JSON 을 파싱한 Array-Object 입니다.
				//AUIGrid.setGridData(myGridID, data);

				//data = "-";
				createAUIGrid(data);

				// 로더 제거
				//AUIGrid.removeAjaxLoader(myGridID);
			},
			onError: function (status, e) {
				alert("데이터 요청에 실패하였습니다.\r\n status : " + status + "\r\nWAS 를 IIS 로 사용하는 경우 json 확장자가 web.config 의 handler 에 등록되었는지 확인하십시오.");
				// 로더 제거
				//AUIGrid.removeAjaxLoader(myGridID);
			}
		});
	}


	//최초 그리드 생성..
	function createInitGrid(columnLayout) {

				// 그리드 속성 설정
		var gridPros = {
			noDataMessage: "PC의 일괄자료 생성 표준 서식 엑셀 파일을 선택하십시오."
		};

		// 실제로 #grid_wrap 에 그리드 생성
		myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);

		// 그리드 최초에 빈 데이터 넣음.
		AUIGrid.setGridData(myGridID, []);
	};



	var columnLayout_temp = [{
		"headerText" : "사업체 신청 정보",
		"children": [{
			"dataField" : "0",
			"headerText" : "신청분야",
			"editable": false
		}, {
			"dataField" : "1",
			"headerText" : "지역",
			"editable": false
		}, {
			"dataField" : "2",
			"headerText" : "업체명",
			"editable": false
		}, {
			"dataField" : "3",
			"headerText" : "사업자 번호",
			"editable": false,
			"width" : 120
		},{
			"dataField" : "4",
			"headerText" : "과세유형",
			"editable": false
		},{
			"dataField" : "5",
			"headerText" : "업태",
			"editable": false
		},{
			"dataField" : "6",
			"headerText" : "종목",
			"editable": false
		},{
			"dataField" : "7",
			"headerText" : "개업일자",
			"editable": false,
			"dataType": "date",
			"formatString": "yyyy. mm. dd "
		},{
			"dataField" : "8",
			"headerText" : "사업장 주소",
			"editable": false,
			"width" : 200
		},{
			"dataField" : "9",
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
			"dataField" : "10",
			"headerText" : "대표자명",
			"editable": false
		}, {
			"dataField" : "11",
			"headerText" : "생년월일",
			"editable": false,
			"dataType": "date",
			"formatString": "yyyy. mm. dd"
		}, {
			"dataField" : "12",
			"headerText" : "성별",
			"editable": false
		},{
			"dataField" : "13",
			"headerText" : "연락처",
			"editable": false,
			"width" : 120
		}] // end of 대표자 정보 "children"
	}, {
		"headerText" : "2021년 부가세과세 증명",
		"children": [{
			"dataField" : "14",
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
			"dataField" : "15",
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
			"dataField" : "16",
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
			"dataField" : "17",
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
			"dataField" : "18",
			"headerText" : "비고"
		}] // end of 2021년 부가세과세 증명 "children"

	},{
		"headerText" : "2022년 부가세과세 증명",
		"children": [{
			"dataField" : "19",
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
			"dataField" : "20",
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
			"dataField" : "21",
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
			"dataField" : "22",
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
			"dataField" : "23",
			"headerText" : "비고"
		}] // end of 2022년 부가세과세 증명 "children"

	}, {
		"headerText" : "견적서 1",
		"children": [{
			"dataField" : "24",
			"headerText" : "시공업체",
			"editable": false
		}, {
			"dataField" : "25",
			"headerText" : "사업자 번호"
		}, {
			"dataField" : "26",
			"headerText" : "전화",
			"editable": false,
			"width" : 100
		}, {
			"dataField" : "27",
			"headerText" : "신청분야 세부내역",
			"editable": false,
			"width" : 120
		}, {
			"dataField" : "28",
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
			"dataField" : "29",
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
			"dataField" : "30",
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
			"dataField" : "31",
			"headerText" : "시공업체",
			"editable": false
		}, {
			"dataField" : "32",
			"headerText" : "사업자 번호",
			"editable": false,
		}, {
			"dataField" : "33",
			"headerText" : "전화",
			"editable": false,
			"width" : 100
		}, {
			"dataField" : "34",
			"headerText" : "신청분야 세부내역",
			"editable": false,
			"width" : 120

		}, {
			"dataField" : "35",
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
			"dataField" : "36",
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
			"dataField" : "37",
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
	}, {
		"headerText" : "서류메모",
		"children": [{
			"dataField" : "38",
			"headerText" : "심사참고"
		}, {
			"dataField" : "39",
			"headerText" : "입력메모"
		}, {
			"dataField" : "40",
			"headerText" : "추가,미비서류"
		}, {
			"dataField" : "41",
			"headerText" : "검수입력"
		}] // end of 서류메모 "children"
	} ];

	var columnLayout = [{
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
	},{
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
	}];



	// AUIGrid 를 생성합니다.
	function reloadAUIGrid(columnLayout) {

		// 그리드 속성 설정
		var gridPros = {

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

			// 그룹핑 패널 사용
			useGroupingPanel: true,

			// 상태 칼럼 사용
			showStateColumn: true,

			// 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
			displayTreeOpen: true,

			fixedColumnCount:7,

			noDataMessage: "출력할 데이터가 없습니다.",

			//groupingMessage: "여기에 칼럼을 드래그하면 그룹핑이 됩니다."

			// rowIdField 설정
			rowIdField: "id",

			// 엑스트라 체크박스 표시 설정
			showRowCheckColumn: true,

			// 엑스트라 체크박스에 shiftKey + 클릭으로 다중 선택 할지 여부 (기본값 : false)
			enableRowCheckShiftKey: true,

			// 전체 체크박스 표시 설정
			showRowAllCheckBox: true,

			// 엑스트라 체크박스 체커블 함수
			// 이 함수는 사용자가 체크박스를 클릭 할 때 1번 호출됩니다.
			rowCheckableFunction: function (rowIndex, isChecked, item) {
				if (item.RCEPT_SE == "온라인") { // 제품이 온라인 인 경우 사용자 체크 못하게 함.
					return false;
				}
				return true;
			},

			// 엑스트라 체크박스 disabled 함수
			// 이 함수는 렌더링 시 빈번히 호출됩니다. 무리한 DOM 작업 하지 마십시오. (성능에 영향을 미침)
			// rowCheckDisabledFunction 이 아래와 같이 간단한 로직이라면, 실제로 rowCheckableFunction 정의가 필요 없습니다.
			// rowCheckDisabledFunction 으로 비활성화된 체크박스는 체크 반응이 일어나지 않습니다.(rowCheckableFunction 불필요)
			rowCheckDisabledFunction: function (rowIndex, isChecked, item) {
				if (item.RCEPT_SE == "온라인") { // 제품이 온라인 인 경우 체크박스 disabeld 처리함
					return false; // false 반환하면 disabled 처리됨
				}
				return true;
			}
		};

		// 실제로 #grid_wrap 에 그리드 생성
		myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);

		// ready 이벤트 바인딩
		AUIGrid.bind(myGridID, "ready", function (event) {
			setCheckedRowsByIds(); // 시작 시 체크된 상태로 표시
		});

		// 체크박스 클린 이벤트 바인딩
		AUIGrid.bind(myGridID, "rowCheckClick", function (event) {
			alert("rowIndex : " + event.rowIndex + ", id : " + event.item.id + ", name : " + event.item.name + ", checked : " + event.checked + ", shiftKey : " + event.shiftKey + ", shiftIndex : " + event.shiftIndex);
		});

		// 전체 체크박스 클릭 이벤트 바인딩
		AUIGrid.bind(myGridID, "rowAllChkClick", function (event) {
			alert("전체 선택  checked : " + event.checked);
		});

		// 데이터 요청, 요청 성공 시 AUIGrid 에 데이터 삽입합니다.
		requestJsonData();

	};

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
				<li>신청접수</li>
			</ul>
		</div>

		<div class="content-body">

			<ul class="tab-menu">
				<li><a href="/super/homepage/biz001/indexA01.do" class="active">접수목록</a></li>
			</ul>

			<div class="f-clear mb30">
				<div class="f-left">
					<form name=f1 style=margin:0; onsubmit="return false;" >
						<select name="codeList" id="codeList" onchange="OnChange();">
							<option value="A">1.전체 접수현황</option>
							<option selected value="B">2.일괄 자료생성</option>
							<option value="C">3.첨부파일 업로드</option>
						</select>

						<button type="button" class="btn btn-mint" onclick="filedown('biz001_경영환경개선_일괄자료생성_표준서식')">표준 서식 다운로드</button>
						<!-- button type="button" class="btn btn-darkblue">신청자료 업로드</button -->
						<input type="file" id="fileSelector" name="files" accept=".xlsx" class="btn btn-darkblue">
					</form>
				</div>
				<div class="f-right">
					<button type="button" id="btn_export" class="btn btn-green">엑셀 다운로드</button>
					<button type="button" id="btn_del" class="btn btn-black">삭제</button>
					<button type="button" id="btn_save" class="btn btn-red">저장</button>
				</div>
			</div>

			<div class="grid-area" style="height: 590px;">

				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="grid_wrap" style="width:100%; height:100%; margin:0 auto;"></div>

			</div>

		</div>
	</div>

</div>



