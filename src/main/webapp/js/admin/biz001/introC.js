﻿    function OnChange()
    {
        var gubun = document.getElementById("codeList").options[document.getElementById("codeList").selectedIndex].value;

        switch(gubun) {
            case 'A':  // if (x === 'value1')
                location.href="/super/homepage/biz001/indexC01.do";
                break;

            case 'B':  // if (x === 'value2')
                location.href="/super/homepage/biz001/indexC02.do";
                break;

            case 'C':  // if (x === 'value2')
                location.href="/super/homepage/biz001/indexC03.do";
                break;

            default:
                location.href="/super/homepage/biz001/indexC01.do";
                break;
        }

    };
