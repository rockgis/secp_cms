 window.onresize = function () {

        // 크기가 변경되었을 때 AUIGrid.resize() 함수 호출
        if (typeof myGridID !== "undefined") {
            AUIGrid.resize(myGridID);
        }
    };


    // 엑셀 내보내기(Export);
 function exportTo(type) {

     // 내보내기 실행
     switch (type) {
         case "xlsx":
             AUIGrid.exportToXlsx(myGridID);
             break;
         case "csv":
             AUIGrid.exportToCsv(myGridID);
             break;
         case "txt":
             AUIGrid.exportToTxt(myGridID);
             break;
         case "xml":
             AUIGrid.exportToXml(myGridID);
             break;
         case "json":
             AUIGrid.exportToJson(myGridID);
             break;
         case "pdf": // AUIGrid.pdfkit.js 파일을 추가하십시오.
             if (!AUIGrid.isAvailabePdf(myGridID)) {
                 alert("PDF 저장은 HTML5를 지원하는 최신 브라우저에서 가능합니다.(IE는 10부터 가능)");
                 return;
             }
             AUIGrid.exportToPdf(myGridID, {
                 // 폰트 경로 지정 (반드시 지정해야 함)
                 fontPath: "/font/NanumSquare.ttf"
             });
             break;
         case "object": // array-object 는 자바스크립트 객체임
             var data = AUIGrid.exportToObject(myGridID);
             alert(data);
             break;
     }
 };


    // PDF 내보내기(Export), AUIGrid.pdfkit.js 파일을 추가하십시오.
    function exportPdfClick() {

        // 내보내기 실행
        AUIGrid.exportToPdf(myGridID, {
            // 폰트 경로 지정
            fontPath: "/font/NanumSquare.ttf"
        });
    };


 function goto(url)
 {
   location.href=url;
 };


 // IE10, 11는 바이너리스트링 못읽기 때문에 ArrayBuffer 처리 하기 위함.
 function fixdata(data) {
     var o = "", l = 0, w = 10240;
     for (; l < data.byteLength / w; ++l) o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w, l * w + w)));
     o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w)));
     return o;
 };

 // 파싱된 시트의 CDATA 제거 후 반환.
 function process_wb(wb) {
     var output = "";
     output = JSON.stringify(to_json(wb));
     output = output.replace(/<!\[CDATA\[(.*?)\]\]>/g, '$1');
     return JSON.parse(output);
 };

 // 엑셀 시트를 파싱하여 반환
 function to_json(workbook) {
     var result = {};
     workbook.SheetNames.forEach(function (sheetName) {
         // JSON 으로 파싱
         //var roa = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheetName]);

         // CSV 로 파싱
         var roa = XLSX.utils.sheet_to_csv(workbook.Sheets[sheetName]);

         if (roa.length > 0) {
             result[sheetName] = roa;
         }
     });
     return result;
 }

// CSV 파일을 Js Array 로 변환
 function parseCsv(value) {
     var rows = value.split("\n");

     var pData = [];
     for (var i = 0, len = rows.length; i < len - 4 ; i++) {
         pData[i] = rows[i+4].split(",");
     }
     return pData;
 };