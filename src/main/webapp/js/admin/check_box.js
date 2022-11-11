//전체 체크/해제 하기
var allChecked = false;
function setAllCheckedRows() {
    allChecked = !allChecked;
    AUIGrid.setAllCheckedRows(myGridID, allChecked);
};

//체크된 행 삭제 하기
function deleteCheckedRows() {
    // 체크된 행 삭제 처리
    AUIGrid.removeCheckedRows(myGridID);
}

//삭제 행들 보기
function getRemovedItems() {
    // 삭제된 행들 보기
    var removedRowItems = AUIGrid.getRemovedItems(myGridID); // 삭제된 행 아이템들(배열)
    if (removedRowItems.length <= 0) {
        alert("삭제된 행 없음!");
        return;
    }

    var str = "삭제된 행들 ID\r\n";
    for (var i = 0, len = removedRowItems.length; i < len; i++) {
        str += "id : " + removedRowItems[i].id + ", name : " + removedRowItems[i].name + "\r\n";
    }
    alert(str);
}

// 체크된 아이템 얻기
function getCheckedRowItems() {
    var checkedItems = AUIGrid.getCheckedRowItems(myGridID);
    if (checkedItems.length <= 0) {
        alert("없음");
        return;
    }
    var str = "";
    var rowItem;
    for (var i = 0, len = checkedItems.length; i < len; i++) {
        rowItem = checkedItems[i];
        str += "row : " + rowItem.rowIndex + ", id :" + rowItem.item.id + ", name : " + rowItem.item.name + "\n";
    }
    alert(str);
}

// rowIdField 값으로 체크하기 (기존 제거)
function setCheckedRowsByIds() {

    // rowIdField 을 고객 ID로 설정했기 때문에 고객 ID ["#Cust0",  "#Cust6",  "#Cust9"] 를 체크함.
    // 기존 체크된 항목은 체크해제되고 0,6,9로만 체크됨
    var items = ["#Cust0", "#Cust6", "#Cust9"];
    AUIGrid.setCheckedRowsByIds(myGridID, items);
};
//rowIdField 값으로 체크하기 (기존 더하기)
function addCheckedRowsByIds() {
    // rowIdField 을 고객 ID로 설정했기 때문에 고객 ID ["#Cust1",  "#Cust2",  "#Cust3"] 를 체크함.
    // 기존 체크된 항목이 있다면, 유지하고 1,2,3 이 더해져서 체크됨
    var items = ["#Cust1", "#Cust2", "#Cust3"];
    AUIGrid.addCheckedRowsByIds(myGridID, items);
};
//rowIdField 값으로 체크 해제 하기
function addUncheckedRowsByIds() {
    // 기존 체크된 항목이 있다면, 1,2,3 이 더해져서 체크해제됨
    var items = ["#Cust1", "#Cust2", "#Cust3"];
    AUIGrid.addUncheckedRowsByIds(myGridID, items);
};



// 특정 칼럼 값으로 체크하기 (기존 제거)
function setCheckedRowsByValue() {

    // rowIdField 와 상관없이 행 아이템의 특정 값에 체크함
    // 행아이템의 name 필드 중 Anna 라는 사람을 모두 체크함
    AUIGrid.setCheckedRowsByValue(myGridID, "name", "Anna");

    // 만약 복수 값(Anna, Steve) 체크 하고자 한다면 다음과 같이 배열로 삽입
    //AUIGrid.setCheckedRowsByValue(myGridID, "name", ["Anna", "Steve"]);
};
//특정 칼럼 값으로 체크하기 (기존 더하기)
function addCheckedRowsByValue() {

    // rowIdField 와 상관없이 행 아이템의 특정 값에 체크함
    // 행아이템의 name 필드 중 Emma 라는 사람을 모두 체크함
    AUIGrid.addCheckedRowsByValue(myGridID, "name", "Emma");

    // 만약 복수 값(Emma, Steve) 체크 하고자 한다면 다음과 같이 배열로 삽입
    //AUIGrid.addCheckedRowsByValue(myGridID, "name", ["Emma", "Steve"]);
};
//특정 칼럼 값으로 체크 해제 하기
function addUncheckedRowsByValue() {
    // 행아이템의 name 필드 중 Emma 라는 사람을 모두 체크 해제함
    AUIGrid.addUncheckedRowsByValue(myGridID, "name", "Emma");
};