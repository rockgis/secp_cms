<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>사이트 관리</title>
<script type="text/javascript">
</script>
</head>
<body>
<div class="titlebar">
	<h2>대시보드</h2>
	<div>
		<span>사이트 관리</span>&gt;
		<span class="bar_tx">대시보드</span>
	</div>
</div>
<div class="contents_wrap" style="margin-bottom:60px;" data-ng-cloak>
	<div class="contents" style="top:0; padding:0; border:none; background:none; min-height:0;">
	    <div class="site_dash">
	    	<div class="sd_wrap">
	    		<div class="sd1">
	    			<h3 class="dash_title">사이트 설정 현황</h3>
	    			<div>
		    			<table class="dash2">
		    			<caption></caption>
		    			<colgroup>
		    				<col />
		    				<col />
		    				<col />
		    			</colgroup>
		    				<tr>
		    					<td rowspan="4" class="left">
		    						<h4>${suf:clearXSS(data.security_status.title, '')}</h4>
			    					<p>홈페이지 이름/명칭<BR />
			    					(홈페이지 기본 설정에서 변경 할 수 있습니다.)</p>
		    					</td>
		    					<td class="left" style="padding:15px 0;"><h4 style="margin:0;">관리자</h4></td>
		    					<td class="left" style="padding:15px 0;"><h4 style="margin:0;">일반회원</h4></td>
		    				</tr>
		    				<tr>		    				
		    					<td class="right">
		    						<p>로그아웃 설정 시간</p>
		    						<span><b>${data.security_status.adm_logout_time }</b>분</span>
		    					</td>
		    					<td class="right">
		    						<p>로그아웃 설정 시간</p>
		    						<span style="width:81px; line-height:normal;"><b>${data.security_status.logout_time }</b>분</span>
		    					</td>		    					 
		    				</tr>
		    				<tr>
		    					<td class="right">
		    						<p>비밀번호 변경 주기</p>
		    						<span><b>${data.security_status.adm_pw_change_cycle }</b>일</span>
		    					</td>
		    					<td class="right">
		    						<p>비밀번호 변경 주기</p>
		    						<span style="width:81px;"><b>${data.security_status.pw_change_cycle }</b>일</span>
		    					</td>
		    				</tr>
		    				<tr>
		    					<td class="right">
		    						<p>휴면계정 설정 기간</p>
		    						<span><b>${data.security_status.adm_dormancy_day }</b>일</span>
		    					</td>
		    					<td class="right">
		    						<p>휴면계정 설정 기간</p>
		    						<span style="width:81px;"><b>${data.security_status.dormancy_day }</b>일</span>
		    					</td>
		    				</tr>
		    			</table>
		    			<c:if test="${cms_member.group_seq eq '1' }">
		    			<a class="more" href="/super/system/basic_setting/index.do?cms_menu_seq=933#!/modify">보안 설정 바로가기</a>
		    			</c:if>
		    			<c:if test="${cms_member.group_seq > '1' }">
		    			<span style="display:block; text-align:center; padding:30px 0; font-size:15px;">보안설정 변경은 총괄 관리자만 가능 합니다.</span>
		    			</c:if>
	    			</div>
	    		</div>
	    		<div class="sd2">
	    			<h3 class="dash_title">예약업데이트 현황</h3>
	    			<div>
	    				<ul>
	    					<li>
	    						<h4><b>${data.reserve_count.cnt1 }</b>개</h4>
	    						<p>콘텐츠</p>
	    					</li>
	    					<li>
	    						<h4><b>${data.reserve_count.cnt2 }</b>개</h4>
	    						<p>게시물</p>
	    					</li>
	    				</ul>
	    				<a class="more" href="/super/site/reserve/index.do?cms_menu_seq=804#!/list">예약업데이트 현황</a>
	    			</div>
	    		</div>
	    	</div>
	    	<div class="sd_wrap">
	    		<div class="sd3">
	    			<h3 class="dash_title">메인 이미지/팝업/배너 현황</h3>
	    			<div>
	    				<ul class="using">
	    					<c:forEach var="item" items="${data.banner_status }" varStatus="status">
	    					<li>
	    						<div class="left type_${status.count }">
	    							<p>${item.selecter_nm }</p>
	    							<h4><b>${item.cnt1 }</b>개</h4>
	    							<span>사용중</span>
	    						</div>
	    						<ul class="right">
	    							<li>
	    								<p>전체</p>
	    								<span><b>${item.cnt2 }</b>개</span>
	    							</li>
	    							<li>
	    								<p>미사용/종료</p>
	    								<span><b>${item.cnt3 }</b>개</span>
	    							</li>
	    						</ul>
	    					</li>
	    					</c:forEach>
	    				</ul>
	    				<div class="end_schedule">
	    					<p>사용종료 예정</p>
	    					<ul>
	    						<c:if test="${empty data.banner_end_schedule }">
	    						<li style="text-align:center; padding:12px 0; background:#f26c4f; color:#fff; font-size:15px;">종료예정인 메인배너/팝업이 없습니다.</li>
	    						</c:if>
	    						<c:forEach var="item" items="${data.banner_end_schedule }">
	    						<li>
	    							<span class="type_${item.selecter }">${item.selecter_nm }</span>
	    							<p><b>[${item.title }]</b><span>${item.start_dt } ~ ${item.end_dt }</span></p>
	    						</li>
	    						</c:forEach>
	    					</ul>
	    				</div>
	    			</div>
	    		</div>
	    	</div>
	    </div>
	</div>
</div>
</body>
</html>