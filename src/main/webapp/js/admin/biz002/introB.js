﻿    function OnChange()
    {
        var gubun = document.getElementById("codeList").options[document.getElementById("codeList").selectedIndex].value;

        switch(gubun) {
            case 'A':  // if (x === 'value1')
                location.href="/super/homepage/biz002/indexB01.do";
                break;

            case 'B':  // if (x === 'value2')
                location.href="/super/homepage/biz002/indexB02.do";
                break;
                
            case 'C':  // if (x === 'value3')
                location.href="/super/homepage/biz002/indexB03.do";
                break;

            default:
                location.href="/super/homepage/biz002/indexB01.do";
                break;
        }

    };
