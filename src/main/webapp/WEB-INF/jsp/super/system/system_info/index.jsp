<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<spring:eval expression="@config['Globals.SysMode']" var="sysmode"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>시스템정보</title>
<style>
	@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);
</style>
</head>
<body>
	<div class="titlebar">
		<h2>시스템정보</h2>
		<div>
			<span>시스템관리</span>&gt; 
			<span class="bar_tx">시스템정보</span>
		</div>
	</div>
	<div class="contents_wrap">
		<div class="contents" style="padding:0;">
			<div class="mccms">
				<div class="left">
					<c:choose>
						<c:when test="${sysmode eq '0' }">
							<div class="ing">
								<p class="tit">ing...</p>
								<span>데모/개발</span>
								<ul>
									<li><b>${data.buildId }</b></li>
									<li>설치일 : ${data.issuedDt }</li>
									<li>남은기간 : ${dtf:diffOfDate(dtf:getTime('yyyyMMdd'), dtf:getCurrentDateBMonth(data.issuedDt, 'yyyy-MM-dd', -3)) }일</li>
								</ul>
							</div>
						</c:when>
						<c:when test="${sysmode eq '1' }">
						<div class="identify">
							<p class="tit">IDENTIFY</p>
							<span>정상운영</span>
							<ul>
								<li><b>${data.buildId }</b></li>
								<li>설치일 : ${data.issuedDt }</li>
							</ul>
						</div>
						</c:when>
					</c:choose>
				</div>
				<div class="right">
					<p class="tit"><img src="/images/super/MCCMS.gif" alt="MC@CMS eGovFrame" /></p>
					<ul class="certi">
						<li>
							<span>제품버전</span>
							<div>
								<b>${data.version }</b>
							</div>
						</li>
						
						<c:choose>
						<c:when test="${sysmode eq '0' }">
						<li>
							<span>라이선스</span>
							<div>
								<b>데모/개발 [${data.company }]</b>
								<ul>
									<li>데모/개발 라이선스는 발급일(설치일)로부터 <strong>3개월간</strong> 이용할 수 있으며, 이 후 시스템 접근이 차단됩니다.</li>
									<li>라이선스의 상세한 내용은 고객센터를 통해 확인 할 수 있습니다.</li>
								</ul>
							</div>
						</li>
						<li>
							<span>제품보증</span>
							<div>
								<b>데모/개발 라이선스는 별도의 계약 관계에 따라 서비스가 지원 되며, 자세한 내용은 계약관계를 확인하세요.</b>
							</div>
						</li>
						</c:when>
						 
						<c:when test="${sysmode eq '1' }">
						<li>
							<span>라이선스</span>
							<div>
								<b>${data.company }</b>
								<ul>
									<li>${data.version }은 <strong>${data.company }</strong>과 계약 관계에 따라 이용 할 수 있습니다.</li>
									<li>제품의 고유기능을 이용한 추가 및 수정은 가능하나 지정된 서버외 설치는 라이선스에 위배됩니다.</li>
								</ul>
							</div>
						</li>
						<li>
							<span>제품보증</span>
							<div>
								<b>무상서비스(하자보증)</b>
								<ul>
									<li>1. 제품의 하자기간은 납품일(설치일)로부터 <strong>12개월</strong> 입니다.</li>
									<li>2. 시스템의 문제 발생시 보증기간(하자보수기간)동안 무료로 서비스를 받을 수 있습니다.</li>
								</ul>
								<b>유상서비스(하자보증 만료 이후)</b>
								<ul>
									<li>1. 납품된 시스템외 별도의 프로그램 추가, 기존프로그램의 수정등으로 인한 시스템 오작동 및 시스템 다운</li>
									<li>2. 납품 후 H/W(서버교체), S/W(어플리케이션 변경)등으로 인한 재설치 및 구동지원</li>
									<li>3. 기타 사용상의 부주의로 인한 시스템에 문제 발생시</li>
									<li>※ 유상서비스의 범위는 라이센스 계약이나 별도 유지관리 계약에 따라 다르게 적용 됩니다. 자세한 내용은 계약관계를 확인 하세요.</li>
								</ul>
							</div>
						</li>
						</c:when>
						</c:choose>
						<li>
							<span>제품등록 및 확인서</span>
							<div>
								<div class="certi_list">
									<img src="/images/super/certificate01.gif" alt="상표 서비스표등록증" />
									<img src="/images/super/certificate02.gif" alt="전자정부표준프레임워크 호환성 확인서" />
									<img src="/images/super/certificate03.gif" alt="프로그램등록증" />
								</div>
							</div>
						</li>

					</ul>

					<div class="bottom">					
						<p class="txt">문의사항 : 031-225-0272 (주)미디어코어시스템즈<br />MC@CMS는 전자정부 표준프레임워크(eGovFrame) 3.6기반 CMS시스템 입니다.</p>
						<p class="copy">Copyright &copy; 2019. mediacore Company. All rights reserved.</p>
					</div>
				</div>
			</div>
		</div>	
	</div>
</body>
</html>