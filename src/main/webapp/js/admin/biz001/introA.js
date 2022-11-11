
    function filedown(filedown) {

       location.href="/biz001/fileDown.do?originalFileName="+ filedown +".xlsx"

    };


    function OnChange()
    {
        var gubun = document.getElementById("codeList").options[document.getElementById("codeList").selectedIndex].value;

        switch(gubun) {
            case 'A':  // if (x === 'value1')
                location.href="/super/homepage/biz001/indexA01.do";
                break;

            case 'B':  // if (x === 'value2')
                location.href="/super/homepage/biz001/indexA02.do";
                break;

            case 'C':  // if (x === 'value2')
                location.href="/super/homepage/biz001/indexA03.do";
                break;

            default:
                location.href="/super/homepage/biz001/indexA01.do";
                break;
        }

    };

