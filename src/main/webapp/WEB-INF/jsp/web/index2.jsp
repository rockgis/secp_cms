<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
<%@ taglib uri="/WEB-INF/tlds/FileUtil_fn.tld" prefix="fuf" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>MC@CMS Enterprise eGov V.1.5.0</title>
</head>
<body>

	<!-- banner zone -->
	<c:if test="${fn:length(data.popupzone4) > 0 }">
	<div id="sky_banner_zone" class="sky_banner" style="margin-top:-140px;">
		<div class="inner">
			<div class="con">
				<ul class="sb_slide">
					<c:forEach var="item" items="${data.popupzone4 }">
					<li>
					<c:choose>
						<c:when test="${item.link_yn == 'Y' }">
							<a href="${item.link_url }" target="${item.link_target }"><img src="${item.file_path }" alt="${item.alt }" /></a>
						</c:when>
						<c:otherwise>
							<img src="${item.file_path }" alt="${item.alt }" />
						</c:otherwise>
					</c:choose>	
					</li>
					</c:forEach>				
				</ul>
			</div>
			<div class="sb_footer">
				<div class="chk1">
					<input type="checkbox" id="banner_chk" value="Y">
					<label for="banner_chk">오늘 하루 열지 않기</label>
				</div>
				<button class="">배너 닫기</button>
			</div>
		</div>
	</div>
	</c:if>
	<!-- //banner zone -->
	
	<!-- 레이어팝업 start-->
	<c:if test="${fn:length(data.layer_popup) > 0 }">
		<c:if test="${data.popup_type.popup_type eq 'Y' }"> <!-- 개별레이어팝업 -->
		<script type="text/javascript">
		function closeWin(seq) {
			if($("#chkbox"+seq).is(":checked")){ 
		  		$.cookie("maindiv_"+seq+"_"+$.datepicker.formatDate('ymmdd', new Date()), 'done', {path:"/", expires: 1 });
			}
		 	$('#divpop'+seq).css("visibility","hidden"); 
		}
		$(document).ready(function(){
			//$(".divpop").draggable();
			<c:forEach var="item" items="${data.layer_popup }" varStatus="status">
			if(!$.cookie("maindiv_${item.popupzone_seq}_"+$.datepicker.formatDate('ymmdd', new Date()))){
				$("#divpop${item.popupzone_seq}").css("visibility","visible");
			}
			</c:forEach>
		});
		</script>
		<div class="popup_wrap">
			<c:forEach var="item" items="${data.layer_popup }" varStatus="status">
			<div class="divpop" id="divpop${item.popupzone_seq}" style="z-index:9999; position:absolute; visibility:hidden; top:${item.y_coord}px; left:${item.x_coord}px; width:${fuf:getImageSize(fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, ''), item.file_path).width }px;">
				<div class="divpopt">
					<p>${item.title }</p>
				</div>			
				<div class="divpopa">
					<a <c:choose><c:when test="${item.link_yn == 'Y' }">href="${item.link_url }" target="${item.link_target }"</c:when><c:otherwise>href="#"</c:otherwise></c:choose>><img src="${item.file_path }" alt="${item.alt }"></a>
				</div>
				<div class="divpopb">
					<div>
						<input type="checkbox" name="chkbox" id="chkbox${item.popupzone_seq }" value="${item.popupzone_seq }" onchange="closeWin('${item.popupzone_seq }')">
						<label for="chkbox${item.popupzone_seq }"><span>오늘 하루 열지 않기</span></label>
					</div>
					<a href="javascript:closeWin('${item.popupzone_seq }');">닫기</a>
				</div>
			</div>
			</c:forEach>
		</div>
		</c:if>
		<c:if test="${data.popup_type.popup_type eq 'N' }"> <!-- 슬라이드레이어팝업 -->
		<script type="text/javascript">
		function closeWin(seq) {
			if($("#checkbox").is(":checked")){
		  		$.cookie("slideClose", 'done', {path:"/", expires: 1 });
			}
		 	$('.popup_wrap2').css("display","none"); 
		}
		$(document).ready(function(){
			//$(".divpop").draggable();
			if ($.cookie("slideClose")) {
				$('.popup_wrap2').css("display","none");
			} else {
				$('.popup_wrap2').css("display","block");
			}
		});
		</script>
		<div class="popup_wrap2" style="display: none;">
			<p class="tit">총 <b><span>${fn:length(data.layer_popup)}개</span>의 팝업</b>이 있습니다.</p>
			<div class="divpopb">
				<div>
					<input type="checkbox" id="checkbox" name="checkbox">
					<label for="checkbox"><span>오늘 하루 열지 않기</span></label>
				</div>
				<a href="javascript:closeWin();">닫기</a>
			</div>
			<div class="lp_slide">
				<c:forEach var="item" items="${data.layer_popup }" varStatus="status">
				<div class="divpop" id="divpop${item.popupzone_seq}" style="z-index:9999; width:${fuf:getImageSize(fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, ''), item.file_path).width }px;">		
					<div class="divpopa">
						<a <c:choose><c:when test="${item.link_yn == 'Y' }">href="${item.link_url }" target="${item.link_target }"</c:when><c:otherwise>href="#"</c:otherwise></c:choose>><img src="${item.file_path }" alt="${item.alt }"></a>
					</div>
				</div>
				</c:forEach>
			</div>
		</div>
		</c:if>
	</c:if>
	<div id="container">
		<div class="visual">
			<div class="v_wrap">
				<div class="slide_wrap">
	        		<c:choose>
	        			<c:when test="${empty  data.popupzone1 }">	<!-- 등록된 팝업이 없을경우 ///  -->
							<div class="slide">
								<a href="#">
									<img src="/images/new/main/visual_img01.gif" alt="" />
								</a>
							</div>
	        			</c:when>
	        			<c:otherwise>
	        				<c:forEach var="item" items="${data.popupzone1}">
								<div class="slide">
									<a href="${item.link_url }" target="${item.link_target }">
										<img src="${item.file_path}" alt="${item.title }"  />
									</a>
								</div>
	        				</c:forEach>
	        			</c:otherwise>
	        		</c:choose>
				</div>
			</div>
		</div>
		<div class="con1">
			<div class="inner">
				<div class="direct clearfix">
					<div class="link_box">
						<h2>회사소개</h2>
						<ul>
							<li>
								<a href="/web/lay1/S1T294C296/contents.do">
									<div class="lb_text lb_img01">
										<p class="lb_subTitle">인사말</p>
										<p class="lb_detail">최고의 온라인 마케팅 기업</p>
									</div>
								</a>
							</li>
							<li>
								<a href="/web/lay1/S1T294C298/contents.do">
									<div class="lb_text lb_img02">
										<p class="lb_subTitle">비전</p>
										<p class="lb_detail">함께 성장하는 마케팅 파트너</p>
									</div>
								</a>
							</li>
							<li>
								<a href="/web/lay1/S1T294C306/contents.do">
									<div class="lb_text lb_img03">
										<p class="lb_subTitle">오시는길</p>
										<p class="lb_detail">가벼운 발걸음을 위한 안내</p>
									</div>
								</a>
							</li>
						</ul>
					</div>
					<div class="popup_zone">
						<ul>
			        		<c:choose>
			        			<c:when test="${empty  data.popupzone2 }">	<!-- 등록된 팝업이 없을경우 ///  -->
									<li><a href="#"><img src="/images/main/popup_zone01.jpg" alt="" /></a></li>
			        			</c:when>
			        			<c:otherwise>
			        				<c:forEach var="item" items="${data.popupzone2}">
										<li><a href="${item.link_url }" target="${item.link_target }"><img src="${item.file_path}" alt="${item.title }"  /></a></li>
			        				</c:forEach>
			        			</c:otherwise>
			        		</c:choose>
						</ul>
					</div>
					<div class="notice_box">
						<h2 id="tabNavTitle0101" class="on"><a href="#" onclick="shwoTabNav('01', 3, 1); return false;"
								onfocus="this.onclick();">공지사항</a></h2>
						<div id="tabNav0101">
							<ul>
			                	<c:forEach var="board" items="${data.board1 }" varStatus = "status">
			                 		<li><a href="/web/lay1/bbs/S1T392C310/A/1/view.do?article_seq=${board.article_seq }">${suf:clearXSS(board.title, '')}
			                 			<c:if test="${board.new_yn eq 'Y' }">
											<img src="/images/main/ic_new.gif" alt="new">
										</c:if>
			                 		</a><%-- <span>${dtf:simpleDateFormat(board.reg_dt, 'yyyy-MM-dd HH:mm:ss' , 'yyyy.MM.dd') }</span> --%><span>${board.reg_dt }</span></li>
			                 	</c:forEach>
							</ul>
							<span class="more"><a href="/web/lay1/bbs/S1T392C310/A/1/list.do">더보기+</a></span>
						</div>
						<h2 id="tabNavTitle0102"><a href="#" onclick="shwoTabNav('01', 3, 2); return false;"
								onfocus="this.onclick();">보도자료</a></h2>
						<div id="tabNav0102" style="display: none">
							<ul class="bg">
			                	<c:forEach var="board" items="${data.board2 }" varStatus = "status">
			                 		<li><a href="/web/lay1/bbs/S1T391C448/A/22/view.do?article_seq=${board.article_seq }">${suf:clearXSS(board.title, '')}
			                 			<c:if test="${board.new_yn eq 'Y' }">
											<img src="/images/main/ic_new.gif" alt="new">
										</c:if>
			                 		</a><%-- <span>${dtf:simpleDateFormat(board.reg_dt, 'yyyy-MM-dd HH:mm:ss' , 'yyyy.MM.dd') }</span> --%><span>${board.reg_dt }</span></li>
			                 	</c:forEach>							
							</ul>
							<span class="more"><a href="/web/lay1/bbs/S1T391C448/A/22/list.do">더보기+</a></span>
						</div>
						<h2 id="tabNavTitle0103"><a href="#" onclick="shwoTabNav('01', 3, 3); return false;"
								onfocus="this.onclick();">참고사례</a></h2>
						<div id="tabNav0103" style="display: none">
							<ul>
			                	<c:forEach var="board" items="${data.board3 }" varStatus = "status">
			                 		<li><a href="/web/lay1/bbs/S1T421C442/B/21/view.do?article_seq=${board.article_seq }">${suf:clearXSS(board.title, '')}
			                 			<c:if test="${board.new_yn eq 'Y' }">
											<img src="/images/main/ic_new.gif" alt="new">
										</c:if>
			                 		</a><%-- <span>${dtf:simpleDateFormat(board.reg_dt, 'yyyy-MM-dd HH:mm:ss' , 'yyyy.MM.dd') }</span> --%><span>${board.reg_dt }</span></li>
			                 	</c:forEach>								
							</ul>
							<span class="more"><a href="/web/lay1/bbs/S1T421C442/B/21/list.do">더보기+</a></span>
						</div>
						<script type="text/javascript">
							function shwoTabNav(eName, totalNum, showNum) {
								for (i = 1; i <= totalNum; i++) {
									var zero = (i >= 10) ? "" : "0";
									var e = document.getElementById("tabNav" + eName + zero + i);
									var eTitle = document.getElementById("tabNavTitle" + eName + zero + i);
									e.style.display = "none";
									eTitle.className = "";
								}
	
								var zero = (showNum >= 10) ? "" : "0";
								var e = document.getElementById("tabNav" + eName + zero + showNum);
								var eTitle = document.getElementById("tabNavTitle" + eName + zero + showNum);
								e.style.display = "block";
								eTitle.className = "on";
							}
						</script>
					</div>
				</div> <!-- direct -->
				<div class="press">
					<h3>추천 언론매체</h3>
					<!-- press_slide -->
					<div class="press_slide">
						<div class="slide">
							<p class="offer">추천언론사1</p>
							<div class="pr_info">
								<span class="site">[네이버,네이트]</span>
								<span class="price"><strong>70,000</strong> 원</span>
							</div>
						</div>
						<div class="slide">
							<p class="offer">추천언론사2</p>
							<div class="pr_info">
								<span class="site">[네이버,네이트]</span>
								<span class="price"><strong>70,000</strong> 원</span>
							</div>
						</div>
						<div class="slide">
							<p class="offer">추천언론사3</p>
							<div class="pr_info">
								<span class="site">[네이버,네이트]</span>
								<span class="price"><strong>70,000</strong> 원</span>
							</div>
						</div>
						<div class="slide">
							<p class="offer">추천언론사4</p>
							<div class="pr_info">
								<span class="site">[네이버,네이트]</span>
								<span class="price"><strong>70,000</strong> 원</span>
							</div>
						</div>
						<div class="slide">
							<p class="offer">추천언론사5</p>
							<div class="pr_info">
								<span class="site">[네이버,네이트]</span>
								<span class="price"><strong>70,000</strong> 원</span>
							</div>
						</div>
						<div class="slide">
							<p class="offer">추천언론사6</p>
							<div class="pr_info">
								<span class="site">[네이버,네이트]</span>
								<span class="price"><strong>70,000</strong> 원</span>
							</div>
						</div>
						<div class="slide">
							<p class="offer">추천언론사7</p>
							<div class="pr_info">
								<span class="site">[네이버,네이트]</span>
								<span class="price"><strong>70,000</strong> 원</span>
							</div>
						</div>
						<div class="slide">
							<p class="offer">추천언론사8</p>
							<div class="pr_info">
								<span class="site">[네이버,네이트]</span>
								<span class="price"><strong>70,000</strong> 원</span>
							</div>
						</div>
						<div class="slide">
							<p class="offer">추천언론사9</p>
							<div class="pr_info">
								<span class="site">[네이버,네이트]</span>
								<span class="price"><strong>70,000</strong> 원</span>
							</div>
						</div>
						<div class="slide">
							<p class="offer">추천언론사10</p>
							<div class="pr_info">
								<span class="site">[네이버,네이트]</span>
								<span class="price"><strong>70,000</strong> 원</span>
							</div>
						</div>
						<div class="slide">
							<p class="offer">추천언론사11</p>
							<div class="pr_info">
								<span class="site">[네이버,네이트]</span>
								<span class="price"><strong>70,000</strong> 원</span>
							</div>
						</div>
					</div>
				</div><!-- press -->
			</div>
		</div>
		<div class="con2">
			<div class="inner clearfix">
				<div class="package02">
					<a href="/web/lay1/S1T421C422/contents.do">
						<h3>언론홍보 소개</h3>
						<p>공신력을 가진 언론사를 통해 기업의
							<br />긍정적 이슈를 알리는 마케팅</p>
						<span>더보기</span>
					</a>
				</div>
				<div class="package01">
					<a href="/web/lay1/S1T421C423/contents.do">
						<h3>언론홍보 절차</h3>
						<p>다양한 성공사례와 노하우를 바탕으로
							<br />최적의 가이드 라인을 제시</p>
						<span>더보기</span>
					</a>
				</div>
				<div class="package04">
					<a href="/web/lay1/S1T393C403/contents.do">
						<h3>어워드 소개</h3>
						<p>기업 브랜드 및 제품 가치를 높일 수 잇는
							<br />효과적인 마케팅</p>
						<span>더보기</span>
					</a>
				</div>
				<div class="package03">
					<a href="/web/lay1/S1T393C408/contents.do">
						<h3>어워드 절차</h3>
						<p>가치와 정체성을
							<br />더욱 명확하고 품격있게</p>
						<span>더보기</span>
					</a>
				</div>
			</div><!-- package -->
		</div>	
  		<div class="banner">
  			<div class="inner">
  				<ul id="bannerList">
					<c:forEach var="item" items="${data.popupzone3 }">
						<c:choose>
							<c:when test="${item.link_yn == 'Y'}">
								<li><a href="${item.link_url}" target="${item.link_target}" title="새창열림" style="display:block;"><img src="${item.file_path}" alt="${item.alt}" /></a></li>	
							</c:when>
							<c:otherwise>
								<li><a href="javascript:void(0);" target="${item.link_target}" title="새창열림" style="display:block;"><img src="${item.file_path}" alt="${item.alt}" /></a></li>								
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</ul>
  			</div>
  		</div>
  	</div><!-- container -->
</body>
</html>
