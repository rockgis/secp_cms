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
<script type="text/javascript" src="<c:url value="/js/admin/biz001/introA.js"/>"></script>

<script type="text/javascript">

// AUIGrid 생성 후 반환 ID
var myGridID;
var columnLayoutTemp;

// document ready (jQuery 의 $(document).ready(function() {}); 과 같은 역할을 합니다.
function documentReady() {  
	
	// AUIGrid 그리드를 생성합니다.
	
	//columnLayoutTemp = createColumnData();
	
	console.log("########################### columnLayoutTemp #######################");
	//console.log(columnLayoutTemp);
	
	var headerUrl = "/super/bizmanage/getHeader.do";
	
	//requestHeader(headerUrl);
	//createAUIGrid(columnLayoutTemp);
	//console.log(columnLayoutTemp);
	
	
	
	
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
			createAUIGrid(data);
			
			
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


var columnLayoutTemp = [{
	headerText: "접수정보",
	children: [{
		dataField: "SN",
		headerText: "순번"
	}, {
		dataField: "RCEPT_NO",
		headerText: "접수번호",
		width: 130
	}, {
		dataField: "RCEPT_SE",
		headerText: "접수구분"
	}, {
		dataField: "DSTRCT",
		headerText: "권역"
	}, {
		dataField: "RCEPT_DT",
		headerText: "접수일시",
		dataType: "date",
		formatString: "yyyy. mm. dd"
	}, {
		dataField: "변경일시",
		headerText: "변경일시",
		dataType: "date",
		formatString: "yyyy. mm. dd"
	}]
}, {
	headerText: "진행상태",
	children: [{
		dataField: "단계",
		headerText: "단계"
	}, {
		dataField: "상태",
		headerText: "상태"
	}]
}, {
	headerText: "사업체 신청 정보",
	children: [{
		dataField: "신청분야",
		headerText: "신청분야"
	}, {
		dataField: "지역",
		headerText: "지역"
	}, {
		dataField: "업체명",
		headerText: "업체명"
	}, {
		dataField: "사업자 번호",
		headerText: "사업자 번호",
		width: 120
	}, {
		dataField: "과세유형",
		headerText: "과세유형"
	}, {
		dataField: "업태",
		headerText: "업태"
	}, {
		dataField: "종목",
		headerText: "종목"
	}, {
		dataField: "개업일자",
		headerText: "개업일자",
		dataType: "date",
		formatString: "yyyy. mm. dd"
	}, {
		dataField: "사업장 주소",
		headerText: "사업장 주소",
		width: 200
	}, {
		dataField: "종업원 수",
		headerText: "종업원 수",
		dataType: "numeric",
		style: "my-column",
		editRenderer: {
			type: "InputEditRenderer",
			onlyNumeric: true,
			textAlign: "right",
			autoThousandSeparator: true
		}
	}]
}, {
	headerText: "대표자 정보",
	children: [{
		dataField: "대표자명",
		headerText: "대표자명"
	}, {
		dataField: "생년월일",
		headerText: "생년월일",
		dataType: "date",
		formatString: "yyyy. mm. dd"
	}, {
		dataField: "성별",
		headerText: "성별"
	}, {
		dataField: "연락처",
		headerText: "연락처",
		width: 120
	}]
}, {
	headerText: "2021년 부가세과세 증명",
	children: [{
		dataField: "상반기1",
		headerText: "상반기",
		dataType: "numeric",
		style: "my-column",
		width: 100,
		editRenderer: {
			type: "InputEditRenderer",
			onlyNumeric: true,
			textAlign: "right",
			autoThousandSeparator: true
		}
	}, {
		dataField: "하반기1",
		headerText: "하반기",
		dataType: "numeric",
		style: "my-column",
		width: 100,
		editRenderer: {
			type: "InputEditRenderer",
			onlyNumeric: true,
			textAlign: "right",
			autoThousandSeparator: true
		}
	}, {
		dataField: "1년 계1",
		headerText: "1년 계",
		dataType: "numeric",
		style: "my-column",
		width: 100,
		editRenderer: {
			type: "InputEditRenderer",
			onlyNumeric: true,
			textAlign: "right",
			autoThousandSeparator: true
		}
	}, {
		dataField: "매출월1",
		headerText: "매출월",
		dataType: "numeric",
		style: "my-column",
		width: 100,
		editRenderer: {
			type: "InputEditRenderer",
			onlyNumeric: true,
			textAlign: "right",
			autoThousandSeparator: true
		}
	}, {
		dataField: "비고1",
		headerText: "비고"
	}]

}, {
	headerText: "2022년 부가세과세 증명",
	children: [{
		dataField: "상반기2",
		headerText: "상반기",
		dataType: "numeric",
		style: "my-column",
		width: 100,
		editRenderer: {
			type: "InputEditRenderer",
			onlyNumeric: true,
			textAlign: "right",
			autoThousandSeparator: true
		}
	}, {
		dataField: "하반기2",
		headerText: "하반기",
		dataType: "numeric",
		style: "my-column",
		width: 100,
		editRenderer: {
			type: "InputEditRenderer",
			onlyNumeric: true,
			textAlign: "right",
			autoThousandSeparator: true
		}
	}, {
		dataField: "1년 계2",
		headerText: "1년 계",
		dataType: "numeric",
		style: "my-column",
		width: 100,
		editRenderer: {
			type: "InputEditRenderer",
			onlyNumeric: true,
			textAlign: "right",
			autoThousandSeparator: true
		}
	}, {
		dataField: "매출월2",
		headerText: "매출월",
		dataType: "numeric",
		style: "my-column",
		width: 100,
		editRenderer: {
			type: "InputEditRenderer",
			onlyNumeric: true,
			textAlign: "right",
			autoThousandSeparator: true
		}
	}, {
		dataField: "비고2",
		headerText: "비고"
	}]

}, {
	headerText: "(월환산) 매출액",
	children: [{
		dataField: "21년 매출",
		headerText: "21년 매출",
		dataType: "numeric",
		style: "my-column",
		width: 100,
		editRenderer: {
			type: "InputEditRenderer",
			onlyNumeric: true,
			textAlign: "right",
			autoThousandSeparator: true
		}
	}, {
		dataField: "22년 매출",
		headerText: "22년 매출",
		dataType: "numeric",
		style: "my-column",
		width: 100,
		editRenderer: {
			type: "InputEditRenderer",
			onlyNumeric: true,
			textAlign: "right",
			autoThousandSeparator: true
		}
	}]

}, {
	headerText: "견적서 1",
	children: [{
		dataField: "시공업체1",
		headerText: "시공업체"
	}, {
		dataField: "사업자 번호1",
		headerText: "사업자 번호"
	}, {
		dataField: "전화1",
		headerText: "전화",
		width: 100
	}, {
		dataField: "신청분야 세부내역1",
		headerText: "신청분야 세부내역"
	}, {
		dataField: "공급가1",
		headerText: "공급가",
		dataType: "numeric",
		style: "my-column",
		width: 100,
		editRenderer: {
			type: "InputEditRenderer",
			onlyNumeric: true,
			textAlign: "right",
			autoThousandSeparator: true
		}
	}, {
		dataField: "부가세1",
		headerText: "부가세 ",
		dataType: "numeric",
		style: "my-column",
		width: 100,
		editRenderer: {
			type: "InputEditRenderer",
			onlyNumeric: true,
			textAlign: "right",
			autoThousandSeparator: true
		}
	}, {
		dataField: "소계1",
		headerText: "소계",
		dataType: "numeric",
		style: "my-column",
		width: 100,
		editRenderer: {
			type: "InputEditRenderer",
			onlyNumeric: true,
			textAlign: "right",
			autoThousandSeparator: true
		}
	}]
}, {
	headerText: "견적서 2",
	children: [{
		dataField: "시공업체2",
		headerText: "시공업체"
	}, {
		dataField: "사업자 번호2",
		headerText: "사업자 번호"
	}, {
		dataField: "전화2",
		headerText: "전화"
	}, {
		dataField: "신청분야 세부내역2",
		headerText: "신청분야 세부내역"
	}, {
		dataField: "공급 가액2",
		headerText: "공급 가액",
		dataType: "numeric",
		style: "my-column",
		width: 100,
		editRenderer: {
			type: "InputEditRenderer",
			onlyNumeric: true,
			textAlign: "right",
			autoThousandSeparator: true
		}
	}, {
		dataField: "부가세2",
		headerText: "부가세 ",
		dataType: "numeric",
		style: "my-column",
		width: 100,
		editRenderer: {
			type: "InputEditRenderer",
			onlyNumeric: true,
			textAlign: "right",
			autoThousandSeparator: true
		}
	}, {
		dataField: "소계2",
		headerText: "소계",
		dataType: "numeric",
		style: "my-column",
		width: 100,
		editRenderer: {
			type: "InputEditRenderer",
			onlyNumeric: true,
			textAlign: "right",
			autoThousandSeparator: true
		}
	}]
}, {
	headerText: "견적합계",
	children: [{
		dataField: "견적 총 합계",
		headerText: "견적 총 합계",
		dataType: "numeric",
		style: "my-column",
		width: 100,
		editRenderer: {
			type: "InputEditRenderer",
			onlyNumeric: true,
			textAlign: "right",
			autoThousandSeparator: true
		}
	}]
}, {
	headerText: "필수 서류",
	children: [{
		dataField: "지원신청서",
		headerText: "지원신청서"
	}, {
		dataField: "개인정보 동의서",
		headerText: "개인정보 동의서"
	}, {
		dataField: "확약서",
		headerText: "확약서"
	}, {
		dataField: "추진계획서",
		headerText: "추진계획서"
	}, {
		dataField: "사업자 등록증",
		headerText: "사업자 등록증"
	}, {
		dataField: "부가세 증명",
		headerText: "부가세 증명"
	}, {
		dataField: "법인추가 서류",
		headerText: "법인추가 서류"
	}]
}, {
	headerText: "①교육, 컨설팅 ",
	children: [{
		dataField: "교육, 컨설팅",
		headerText: "내용"
	}]
}, {
	headerText: "②사회 배려자",
	children: [{
		dataField: "사회 배려자",
		headerText: "내용"
	}]
}, {
	headerText: "③4대보험 고용",
	children: [{
		dataField: "4대보험 고용",
		headerText: "인원",
		dataType: "numeric",
		style: "my-column",
		width: 100,
		editRenderer: {
			type: "InputEditRenderer",
			onlyNumeric: true,
			textAlign: "right",
			autoThousandSeparator: true
		}
	}]
}, {
	headerText: "④탄소포인트",
	children: [{
		dataField: "탄소포인트",
		headerText: "내용"
	}]
}];



function createColumnData() {

	var obj;
	var columnLayout = [
		{
			dataField : "id",
			headerText : "ID",
			width : 120
		}
		
	];
	
	columnLayout.push({
		dataField : "date",
		headerText : "Date"
	});
	
	for (var i = 1; i < 87; i++) { 
		obj = {
			width: 140,
			dataField: "name"+i,
			headerText: "Name"+i
		};
		columnLayout.push(obj);
	}
	
	columnLayout.push({
			dataField : "country",
			headerText : "Country",
			width : 140
		});
	columnLayout.push({
			dataField : "product",
			headerText : "Product",
			width : 140
		});	
	columnLayout.push({
			dataField : "color",
			headerText : "Color",
			width : 100
		});
	columnLayout.push({
		dataField : "quantity",
		headerText : "Quantity",
		dataType : "numeric",
		style : "my-column",
		width : 100,
		editRenderer : {
			type : "InputEditRenderer",
			onlyNumeric : true, // 0~9만 입력가능
			textAlign : "right", // 오른쪽 정렬로 입력되도록 설정
			autoThousandSeparator : true // 천단위 구분자 삽입 여부
		}
	});
	columnLayout.push({
			dataField : "price",
			headerText : "Price",
			dataType : "numeric",
			style : "my-column",
			width : 120,
			editRenderer : {
				type : "InputEditRenderer",
				onlyNumeric : true, // 0~9만 입력가능
				textAlign : "right", // 오른쪽 정렬로 입력되도록 설정
				autoThousandSeparator : true // 천단위 구분자 삽입 여부
			}
		});
	

	
	return columnLayout;
}	





// AUIGrid 를 생성합니다.
function createAUIGrid(columnLayout) {
	
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

			groupingMessage: "여기에 칼럼을 드래그하면 그룹핑이 됩니다."
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
	            <li>신청접수</li>
	        </ul>
    	</div>

    <div class="content-body">

        <ul class="tab-menu">
            <li><a href="#" class="active">접수목록</a></li>
<!--             <li><a href="#">심사평가</a></li> -->
<!--             <li><a href="#">선정대상관리</a></li> -->
<!--             <li><a href="#">변경신청관리</a></li> -->
<!--             <li><a href="#">포기내역관리</a></li> -->
<!--             <li><a href="#">완료보고</a></li> -->
            
        </ul>
        
        <div class="f-clear mb30">
            <div class="f-left">
                <form name=f1 style=margin:0; onsubmit="return false;" >
	                <select name="codeList" id="codeList" onchange="OnChange();">
						<option selected="selected" value="A">1.전체 접수현황</option>
						<option value="B">2.일괄 자료생성</option>
						<option value="C">3.첨부파일 업로드</option>
	                </select>
                </form>
<!--                 <button type="button" class="btn btn-mint">표준 서식 다운로드</button> -->
<!--                 <button type="button" class="btn btn-darkblue">신청자료 업로드</button> -->
            </div>
            <div class="f-right">
                <button type="button" class="btn btn-green">엑셀 다운로드</button>
<!--                 <button type="button" class="btn btn-black">삭제</button> -->
<!--                 <button type="button" class="btn btn-red">저장</button> -->
            </div>
        </div>
        
        <div class="grid-area" style="height: 590px;">
        
        <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		<div id="grid_wrap" style="width:100%; height:100%; margin:0 auto;"></div>
        
        </div>
        
    </div>
	</div>

</div>



