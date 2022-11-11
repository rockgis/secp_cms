<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div ng-controller="resultCtrl" title="결과보기">

		<table class="type1">
          	<colgroup>
          		<col />
          		<col />
          		<col />
          		<col />
          		<col />
          		<col />
          		<col />
          	</colgroup>
          	<tr>
          		<th scope="row" class="center">메뉴명</th>
          		<td colspan="6">{{model.title}}</td>
          	</tr>
          	<!-- 
          	<tr>
          		<th scope="row" class="center">참여자</th>
          		<td colspan="5">{{model.total_count}} 명</td>
          	</tr>
          	<tr>
          		<th scope="row" class="center">평균</th>
          		<td colspan="5">{{model.avg_score}} 점</td>
          	</tr>
          	 -->
          	<tr>
            	<th scope="col" class="center">매우만족</th>
            	<th scope="col" class="center">만족</th>
            	<th scope="col" class="center">보통</th>
            	<th scope="col" class="center">불만족</th>
            	<th scope="col" class="center">매우불만족</th>
            	<th scope="col" class="center">기타</th>
            	<th scope="col" class="center">합계</th>
          	</tr>
          	<tr>
            	<td class="center">{{model.sum_score5}}</td>
            	<td class="center">{{model.sum_score4}}</td>
            	<td class="center">{{model.sum_score3}}</td>
            	<td class="center">{{model.sum_score2}}</td>
            	<td class="center">{{model.sum_score1}}</td>
            	<td class="center">{{model.sum_score0}}</td>
            	<td class="center">{{model.total_count}}</td>
          	</tr>
        </table>
        
        <p style="margin-top:20px; font-size:15px; font-family:"NanumBarunGothicB";">상세내용</p>	
		<table class="type1">
          	<colgroup>
          		<col style="width:60px;" />
          		<col style="width:130px;" />
          		<col style="width:100px;" />
          		<col />
          	</colgroup>
          	<tr>
            	<th scope="col" class="center">번호</th>
            	<th scope="col" class="center">일자</th>
            	<th scope="col" class="center">만족도</th>
            	<th scope="col" class="center">기타의견</th>
          	</tr>
          	<tr data-ng-if="result.list.length==0"><td colspan="4" class="center">의견이 없습니다.</td></tr>
          	<tr data-ng-repeat="item in result.list">
          		<td class="center">{{(result.totalCount|num) + 1 - (item.rn|num)}}</td>
            	<td class="center">{{item.reg_dt|myDate:'yyyy-MM-dd HH:mm'}}</td>
            	<td class="center" data-ng-switch="item.score">
            		<any data-ng-switch-when="1">매우불만족</any>
            		<any data-ng-switch-when="2">불만족</any>
            		<any data-ng-switch-when="3">보통</any>
            		<any data-ng-switch-when="4">만족</any>
            		<any data-ng-switch-when="5">매우만족</any>
            		<any data-ng-switch-default>기타</any>
            	</td>
            	<td class="left">{{item.etc}}</td>
          	</tr>
        </table>
		<pagination total-page="result.totalPage" current-page="result.currentPage" on-select-page="result.go(page)"></pagination>
	
		<div class="btn_bottom">
	    	<div class="r_btn">
	    		<a style="display:inline-block; overflow:hidden; height:32px;" href="">
					<input type="button" value="" class="bt_big_bt1_2" data-ng-click="excel_down()"/>
					<input type="button" value="엑셀다운로드" class="bt_big_bt1" data-ng-click="excel_down()"/>
				</a>
	          	<input type="button" value="닫기" class="bt_big_bt4" data-ng-click="close()"/>
	        </div>
	    </div>
	</div>