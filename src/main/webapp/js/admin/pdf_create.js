function createPdfServer( url,bizid ) {

    var checkedItems = AUIGrid.getCheckedRowItems(myGridID);
    if (checkedItems.length <= 0) {
        alert("없음");
        return;
    }
    var str = "";
    var rowItem;
    for (var i = 0, len = checkedItems.length; i < len; i++) {
        rowItem = checkedItems[i];
        str += "bizid: "+bizid+", row : " + rowItem.rowIndex + ", id :" + rowItem.item.id + ", name : " + rowItem.item.name + "\n";
    }
    console.log(str);


    var data = {};

    if(addList.length > 0) data.add = str;
    else data.add = [];

    console.log(data)

    // 위 코드를 하드 코딩하면 다음과 같습니다.
    // 위와 같은 Object 에 add, update, remove 키에 각각 배열을 갖는 구조 입니다.

/*
    $.ajax({
        url : url,
        dataType : "json",
        type : "POST",
        contentType: "application/json; charset=utf-8",
        data : JSON.stringify(data),
        success: function(data) {

            alert("code:"+request.status+"\n"+"error:"+error);

        },
        error:function(request, status, error){
            alert("code:"+request.status+"\n"+"error:"+error);
        }
    });
*/

};