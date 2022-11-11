
    function filedown( filedown) {
        alert("( " + filedown + ".xlsx)   010_경영환경개선_일괄자료생성_표준서식 다운로드 합니다.");

        location.href="/auigrid/fileDown.do?originalFileName="+ filedown +".xlsx"


    };

    function goto() {

        location.href="/auigrid/fileDown.do?originalFileName="+ filedown +".xlsx"


    };

    function OnChange()
    {
        var gubun = document.getElementById("codeList").options[document.getElementById("codeList").selectedIndex].value;

        switch(gubun) {
            case 'A':  // if (x === 'value1')
                location.href="/super/homepage/biz006/indexA01.do";
                break;

            case 'B':  // if (x === 'value2')
                location.href="/super/homepage/biz006/indexA02.do";
                break;

            case 'C':  // if (x === 'value2')
                location.href="/super/homepage/biz006/indexA03.do";
                break;

            default:
                location.href="/super/homepage/biz006/indexA01.do";
                break;
        }

    };

