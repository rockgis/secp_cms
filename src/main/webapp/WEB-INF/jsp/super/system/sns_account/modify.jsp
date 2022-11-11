<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<div class="contents" data-ng-cloak>
			<form id="wFrm" name="wFrm" method="post" novalidate="novalidate">
		    <table class="type1" style="margin-top:0;">
			    <colgroup>
			    	<col style="width:140px;" />
			    	<col style="width:220px;" />
			    	<col />
			    </colgroup>
		    	<caption>SNS계정 관리</caption>
		    	<tr>
					<th scope="row" rowspan="2"><img src="/images/super/sns_title_03.png" alt="트위터" /></th>
					<th scope="row">TWT_CONSUMER_KEY</th>
					<td>
						<input type="text" class="normal" data-ng-model="form.twt_consumer_key" style="width:100%;"/>
					</td>
				</tr>
		    	<tr>
					<th scope="row">TWT_CONSUMER_SECRET</th>
					<td>
						<input type="text" class="normal" data-ng-model="form.twt_consumer_secret" style="width:100%;"/>
					</td>
				</tr>
		    	<tr>
					<th scope="row" rowspan="3"><img src="/images/super/sns_title_06.png" alt="페이스북" /></th>
					<th scope="row">FACE_APPID</th>
					<td>
						<input type="text" class="normal" data-ng-model="form.face_appid" style="width:100%;"/>
					</td>
				</tr>
		    	<tr>
					<th scope="row">FACE_ACCESS_TOKEN</th>
					<td>
						<input type="text" class="normal" data-ng-model="form.face_access_token" style="width:100%;"/>
					</td>
				</tr>
		    	<tr>
					<th scope="row">FACE_APP_SECRET</th>
					<td>
						<input type="text" class="normal" data-ng-model="form.face_app_secret" style="width:100%;"/>
					</td>
				</tr>
		    	<tr>
					<th scope="row" rowspan="2"><img src="/images/super/sns_title_08.png" alt="네이버" /></th>
					<th scope="row">NAV_CLIENT_ID</th>
					<td>
						<input type="text" class="normal" data-ng-model="form.nav_client_id" style="width:100%;"/>
					</td>
				</tr>
		    	<tr>
					<th scope="row">NAV_CLIENT_SECRET</th>
					<td>
						<input type="text" class="normal" data-ng-model="form.nav_client_secret" style="width:100%;"/>
					</td>
				</tr>
		    	<tr>
					<th scope="row" rowspan="2"><img src="/images/super/sns_title_13.png" alt="구글 " /></th>
					<th>GOOGLE_CLIENT_ID</th>
					<td>
						<input type="text" class="normal" data-ng-model="form.google_client_id" style="width:100%;"/>
					</td>
				</tr>
		    	<tr>
					<th scope="row">GOOGLE_CLIENT_SECRET</th>
					<td>
						<input type="text" class="normal" data-ng-model="form.google_client_secret" style="width:100%;"/>
					</td>
				</tr>
		    	<tr>
					<th scope="row"><img src="/images/super/sns_title_12.png" alt="카카오" /></th>
					<th scope="row">KAO_REST_API </th>
					<td>
						<input type="text" class="normal" data-ng-model="form.kao_client_id" style="width:100%;"/>
					</td>
				</tr>
		    	<tr>
					<th scope="row" rowspan="2"><img src="/images/super/sns_title_14.png" alt="인스티그램 " /></th>
					<th>INSTA_CLIENT_ID</th>
					<td>
						<input type="text" class="normal" data-ng-model="form.insta_client_id" style="width:100%;"/>
					</td>
				</tr>
		    	<tr>
					<th scope="row">INSTA_CLIENT_SECRET</th>
					<td>
						<input type="text" class="normal" data-ng-model="form.insta_client_secret" style="width:100%;"/>
					</td>
				</tr>
		    </table>
		    
		    <div class="btn_bottom">
		    	<div class="r_btn">
					<input type="button" value="저장" class="bt_big_bt4" data-ng-click="save()"/>
					<input type="button" value="취소" class="bt_big_bt3" data-ng-click="list()"/>
		        </div>
		    </div>
		    
			</form>
		</div>
