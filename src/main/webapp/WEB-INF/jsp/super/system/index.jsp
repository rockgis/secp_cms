<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>시스템관리</title>
<script type="text/javascript">
$(function(){
	$("#keyword").on("keyup", function(e){
		if(e.keyCode==13){
			searchMember();
		}
	});
	$("#searchBtn").on("click", function(){
		searchMember();
	});
});
function searchMember(){
	location.href="/super/system/member/index.do?cms_menu_seq=900&condition="+$("#condition").val()+"&keyword="+$("#keyword").val();
}
</script>
</head>
<body>
<div class="titlebar">
	<h2>대시보드</h2>
	<div>
		<span>시스템관리</span>&gt;
		<span class="bar_tx">대시보드</span>
	</div>
</div>
<div class="contents_wrap" style="margin-bottom:60px;" data-ng-cloak>
	<div class="contents" style="top:0; padding:0; border:none; background:none; min-height:0;">
		<div class="system_dash">
			<div class="sd_wrap">
				<div class="sd1 left">
					<h3 class="dash_title">실시간 접속 현황</h3>
					<span class="today_date">${dtf:getTime('yyyy-MM-dd') } ${data.standard_time } 기준</span>
					<div class="left">
						<h4><b>${data.realtime_admin1_count + data.realtime_admin2_count }</b>명</h4>
						<p>관리자</p>
						<ul>
							<li>
								<p>최고관리자</p>
								<span><b>${data.realtime_admin1_count }</b>명</span>
							</li>
							<li>
								<p>일반관리자</p>
								<span><b>${data.realtime_admin2_count }</b>명</span>
							</li>
						</ul>
						<a class="more" href="/super/system/current_user/index.do?cms_menu_seq=904#!/list?gubun=admin">관리자 접속현황</a>
					</div>
					<div class="right">
						<h4><b>${data.realtime_user_count }</b>명</h4>
						<p>일반사용자<br />(로그인 회원 기준)</p>
						<a class="more" href="/super/system/current_user/index.do?cms_menu_seq=904#!/list?gubun=user">사용자 접속현황</a>
					</div>
				</div>
				<div class="sd2 right">
					<h3 class="dash_title">관리자 접속 통계(누적)</h3>
					<div>
						<h4><b>${data.admin_total_cnt }</b></h4>
						<ul>
							<li>
								<p>어제</p>
								<span><b>${data.admin_yesterday_cnt }</b></span>
							</li>
							<li>
								<p>이번 주</p>
								<span><b>${data.admin_week_cnt }</b></span>
							</li>
							<li>
								<p>이번 달</p>
								<span><b>${data.admin_month_cnt }</b></span>
							</li>
						</ul>
						<a class="more" href="/super/system/tracking/index.do?cms_menu_seq=902">관리자 접속 로그</a>
					</div>
				</div>
			</div>
			<div class="sd_wrap">
				<div class="sd3 left">
					<h3 class="dash_title">일반회원 현황</h3>
					<span class="today_date">${dtf:getTime('yyyy-MM-dd') } ${data.standard_time } 기준</span>
					<div>
						<ul>
							<li class="left">
								<div>
									<h4><b>${data.users_status.cnt1 }</b>명</h4>
									<ul>
										<li class="withdraw">탈퇴 : ${data.users_status.cnt2 }명</li>
										<li class="sleep">휴면 : ${data.users_status.cnt3 }명</li>
									</ul>
									<span>전체 회원은 탈퇴회원 미포함</span>
								</div>
							</li>
							<li class="right">
								<ul>
									<li>
										<h4><b>${data.users_status.cnt4 }</b>명</h4>
										<p>오늘 가입</p>
									</li>
									<li>
										<h4><b>${data.users_status.cnt5 }</b>명</h4>
										<p>오늘 탈퇴</p>
									</li>
								</ul>
							</li>
						</ul>
						<a class="more" href="/super/system/member_user/index.do?cms_menu_seq=903#!/list?group_seq=1">회원 보기</a>
					</div>
				</div>
				<div class="sd4 right">
					<h3 class="dash_title">시스템 보안 설정(관리자 보안)</h3>
					<div>
						<ul>
							<li><p>로그아웃 시간</p><span><b>${data.security_status.adm_logout_time }</b>분</span></li>
							<li><p>비밀번호 변경기간</p><span><b>${data.security_status.adm_pw_change_cycle }</b>일</span></li> 
							<li><p>장기 미접속 설정</p><span><b>${data.security_status.adm_dormancy_day }</b>일</span></li>
						</ul>
						<!-- 
						<p>설정일 : yyyy.mm.dd hh:mm:ss</p> 
						 -->
						<a class="more" href="/super/system/basic_setting/index.do?cms_menu_seq=933#!/modify">보안 설정 바로가기</a>
					</div>
				</div>
			</div>
			<div class="sd_wrap">
				<div class="sd5">
					<h3 class="dash_title">게시판 사용 현황</h3>
					<div>
						<ul>
							<li class="left">
								<c:set var="A" value="${data.board_count[0]}" />
								<c:set var="B" value="${data.board_count[1]}" />
								<c:set var="C" value="${data.board_count[2]}" />
								<c:set var="D" value="${data.board_count[3]}" />
								<c:set var="E" value="${data.board_count[4]}" />
								<c:set var="F" value="${data.board_count[5]}" />
								<c:set var="totalUseCnt" value="${A.use_cnt + B.use_cnt + C.use_cnt + D.use_cnt + E.use_cnt + F.use_cnt}" />
								<c:set var="totalUnUseCnt" value="${A.un_use_cnt + B.un_use_cnt + C.un_use_cnt + D.un_use_cnt + E.un_use_cnt + F.un_use_cnt}" />
								<h4><b>${totalUseCnt}</b>개 <span class="block">사용중</span></h4>
								<ul>
									<li class="use">전체 : ${totalUseCnt + totalUnUseCnt}</li>
									<li class="unuse">미사용 : ${totalUnUseCnt}</li>
								</ul>
							</li>
							<li class="right">
								<table>
									<colgroup>
										<col style="width:18%;"/>
										<col style="width:16%;"/>
										<col style="width:16%;"/>
										<col style="width:18%;"/>
										<col style="width:16%;"/>
										<col style="width:16%;"/>
									</colgroup>
									<thead>
										<tr>
											<th scope="col">구분</th>
											<th scope="col">사용</th>
											<th scope="col" class="bdr">미사용</th>
											<th scope="col">구분</th>
											<th scope="col">사용</th>
											<th scope="col">미사용</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>${A.board_type_nm}</td>
											<td>${A.use_cnt}개</td>
											<td class="bdr">${A.un_use_cnt}개</td>
											<td>${B.board_type_nm}</td>
											<td>${B.use_cnt}개</td>
											<td>${B.un_use_cnt}개</td>
										</tr>
										<tr>
											<td>${C.board_type_nm}</td>
											<td>${C.use_cnt}개</td>
											<td class="bdr">${C.un_use_cnt}개</td>
											<td>${D.board_type_nm}</td>
											<td>${D.use_cnt}개</td>
											<td>${D.un_use_cnt}개</td>
										</tr>
										<tr>
											<td>${E.board_type_nm}</td>
											<td>${E.use_cnt}개</td>
											<td class="bdr">${E.un_use_cnt}개</td>
											<td>${F.board_type_nm}</td>
											<td>${F.use_cnt}개</td>
											<td>${F.un_use_cnt}개</td>
										</tr>
									</tbody>
								</table>
								<p>메뉴에 연결되는 게시판은 게시판관리에서 확인 가능</p>
								<%--<ul>
									<c:forEach var="item" items="${data.board_status }" begin="0" end="6">
									<li>
										<p class="tit">${item.name }</p>
										<p class="cnt">
											<b>${item.cnt1 }</b> <span>/ ${item.cnt2 }</span>개
										</p>
									</li>
									</c:forEach>
								</ul>
								<div class="board_etc">
									<p>기타</p>
									<span><b>${empty data.board_status[6] ? 0 : data.board_status[6].cnt}</b>개</span>
								</div>--%>
							</li>
							
							
						</ul>
					</div>
					<a class="more" class="board_manage" href="/super/system/board/index.do?cms_menu_seq=941#!/list">게시판 관리 바로가기</a>
				</div>
			</div>
			<div class="sd_wrap">
				<div class="sd6 left">
					<h3 class="dash_title bdb">시스템 현황</h3>
					<ul>
						<li>
							<p>등록 사이트</p>
							<span><b>${data.system_status.cnt1 }</b>개</span>
							<a href="/super/system/site/index.do?cms_menu_seq=944#!/list">설정</a>
						</li>
						<li>
							<p>등록 프로그램</p>
							<span><b>${data.system_status.cnt2 }</b>개</span>
							<a href="/super/system/program/index.do?cms_menu_seq=943#!/list">설정</a>
						</li>
						<li>
							<p>메일 발송</p>
							<span>미설정</span>
							<a href="/super/system/email/index.do?cms_menu_seq=924#!/list">설정</a>
						</li>
						<li>
							<p>SNS 댓글 계정</p>
							<span><b>${data.system_status.cnt3 }/6</b>개</span>
							<a href="/super/system/sns_account/index.do?cms_menu_seq=945#!/modify/1">설정</a>
						</li>
						<li>
							<p>시스템접근 IP</p>
							<span><b>${data.system_status.cnt4 }</b>개</span>
							<a href="/super/system/ipcheck/index.do?cms_menu_seq=931#!/list">설정</a>
						</li>
					</ul>
				</div>
				<div class="sd7 right">
					<h3 class="dash_title">개인정보 필터링</h3>
					<span class="today_date">${dtf:getTime('yyyy-MM-dd') } 기준</span>
					<p>개인정보 필터링 설정 이후 등록된<br /> 게시물에 개인정보로 의심되는 항목<br />(비속어 필터링은 제외)</p>
					<div>
						<ul>
							<li>
								<p>게시물 수</p>
								<h4><b>${data.filter_row }</b>건</h4>
							</li>
							<li>
								<p>의심 항목</p>
								<h4><b>${data.filter_count }</b>개</h4>
							</li>
						</ul>
					</div>
					<a class="more" href="/super/system/filter/index.do?cms_menu_seq=932#!/dashboard">내역 확인하기</a>
				</div>
			</div>
		</div>		
    	
	</div>
</div>
<%-- <div class="info_bg">
	<img src="<c:url value="/images/super/system_bg.png"/>" alt="시스템관리" />
</div> --%>
</body>
</html>