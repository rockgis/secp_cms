<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf"%>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>

<c:set var="color_class"/>
<c:choose>
	<c:when test="${sessionScope.social_session.main_sns_account eq 'twt' }"><c:set var="color_class" value="twitter_color"/></c:when>
	<c:when test="${sessionScope.social_session.main_sns_account eq 'face' }"><c:set var="color_class" value="facebook_color"/></c:when>
	<c:when test="${sessionScope.social_session.main_sns_account eq 'nav' }"><c:set var="color_class" value="naver_color"/></c:when>
	<c:when test="${sessionScope.social_session.main_sns_account eq 'google' }"><c:set var="color_class" value="google_color"/></c:when>
	<c:when test="${sessionScope.social_session.main_sns_account eq 'kao' }"><c:set var="color_class" value="kakao_color"/></c:when>
	<c:when test="${sessionScope.social_session.main_sns_account eq 'insta' }"><c:set var="color_class" value="insta_color"/></c:when>
	<c:otherwise><c:set var="color_class" value="no_color"/></c:otherwise>
</c:choose>

<%--
<div class="comment_tab">
	<a class="on">최신순</a>
	<a href="">추천순</a>
</div>
 --%>
<div class="cmt_contents">
	<ul>
		<c:forEach var="item" items="${list }">
			<c:choose>
				<c:when test="${item.main_account eq 'twt'}"></c:when>
				<c:when test="${item.main_account eq 'face'}"></c:when>
				<c:when test="${item.main_account eq 'nav'}"></c:when>
				<c:when test="${item.main_account eq 'kao'}"></c:when>
				<c:when test="${item.main_account eq 'google'}"></c:when>
				<c:when test="${item.main_account eq 'insta'}"></c:when>
			</c:choose>
			<li class="comment_line re_comment${item.lv }">
				<div class="profile_img2">
					<img src="${empty item.profile_img ? '/images/board/profile_defalut.gif' : item.profile_img }" alt="프로필이미지">
				</div>
				<div class="comment_txt2">
					<div class="name_date">
						<p>
							<c:choose>
								<c:when test="${item.main_account eq 'twt'}">
								<a href="${item.sns_link }" target="_blank" title="트위터 바로가기"><img src="/images/board/re_twitter.gif" alt="트위터" class="share_sns" /></a>
								</c:when>
								<c:when test="${item.main_account eq 'face'}">
								<a href="${item.sns_link }" target="_blank" title="페이스북 바로가기"><img src="/images/board/re_facebook.gif" alt="페이스북" class="share_sns" /></a>
								</c:when>
								<c:when test="${item.main_account eq 'nav'}">
								<img src="/images/board/re_naver.gif" alt="네이버" class="share_sns" />
								</c:when>
								<c:when test="${item.main_account eq 'kao'}">
								<a href="${item.sns_link }" target="_blank" title="카카오스토리 바로가기"><img src="/images/board/re_kakao.gif" alt="카카오" class="share_sns" /></a>
								</c:when>
								<c:when test="${item.main_account eq 'google'}">
								<img src="/images/board/re_google.gif" alt="구글" class="share_sns" />
								</c:when>
								<c:when test="${item.main_account eq 'insta'}">
								<img src="/images/board/re_insta.gif" alt="인스타그램" class="share_sns" />
								</c:when>
							</c:choose>
						</p>
						<p><strong>${item.reg_nm }</strong> <span>${dtf:simpleDateFormat(item.reg_dt, 'yyyy-MM-dd HH:mm:ss.s', 'yyyy-MM-dd HH:mm') }</span></p>
					</div>
					<c:choose>
						<c:when test="${item.del_yn eq 'Y' }">
							<p>삭제된 댓글입니다.</p>
						</c:when>
						<c:otherwise>
						<div class="c_comment_btn">
							<a href="#" class="b_btn_4" onclick="reComment(event, '${item.comment_seq}')">댓글</a>
							<c:if test="${cms_member.group_seq eq '1' 
								|| member.member_id eq item.reg_id
								|| social_session.user_id eq item.reg_id }">
							<a href="#" class="b_btn_4" onclick="modifyComment(event, this, '${item.comment_seq}')">수정</a>
							<a href="#" class="b_btn_5"	onclick="deleteComment(event, '${item.comment_seq}')">삭제</a>
							</c:if>
						</div>
						<p class="comment_body" style="white-space:pre-wrap;"><strong>${item.parent_nm }</strong> ${suf:clearXSS(item.conts, '')}</p>
						<div class="modify_form" style="clear:both;">
							<textarea title="댓글 수정 입력">${suf:clearXSS(item.conts, '')}></textarea>
							<div>
								<a href="#" onclick="modifyCommentProc(event, this, '${item.comment_seq}')">수정</a>
								<a href="#" class="cancel"	onclick="cancelModify(event, this)">취소</a>
							</div>
						</div>
						<div class="re_insert ${color_class }" id="re_comment_${item.comment_seq }" style="display: none;">
							<div class="re_insert_txt2">
								<c:choose>
									<c:when test="${!empty member }">
										<span class="profile_img"><img src="/images/board/profile_defalut.gif" alt="프로필이미지"></span>
										<span class="user_name">${member.member_nm }</span>
									</c:when>
									<c:when test="${!empty social_session }">
										<span class="profile_img"><img src="${social_session.profile_img }" alt="${social_session.name } 프로필 이미지" /></span>
										<span class="social_icon">
										<c:choose>
											<c:when test="${item.main_account eq 'twt'}">
											<img src="/images/board/re_twitter.gif" alt="트위터" />
											</c:when>
											<c:when test="${item.main_account eq 'face'}">
											<img src="/images/board/re_facebook.gif" alt="페이스북" />
											</c:when>
											<c:when test="${item.main_account eq 'nav'}">
											<img src="/images/board/re_naver.gif" alt="네이버" />
											</c:when>
											<c:when test="${item.main_account eq 'kao'}">
											<img src="/images/board/re_kakao.gif" alt="카카오" />
											</c:when>
											<c:when test="${item.main_account eq 'google'}">
											<img src="/images/board/re_google.gif" alt="구글" />
											</c:when>
											<c:when test="${item.main_account eq 'insta'}">
											<img src="/images/board/re_insta.gif" alt="인스타그램" />
											</c:when>
										</c:choose>
										</span>
										<span class="user_name">${social_session.name }</span>
									</c:when>
								</c:choose>
								<textarea name="conts"></textarea>
							</div>
							<div>
								<span class="count_box"><b>0</b></span>/300
								<span class="re_register"><a href="#" class="b_btn_3" onclick="re_comment_reg(event, '${item.comment_seq}')">등록</a></span>
							</div>
						</div>
						</c:otherwise>
					</c:choose>
				</div>
			</li>
		</c:forEach>
	</ul>
</div>

<jsp:include page="/share/paging_js.do">
	<jsp:param name="cpage" value="${param.cpage }" />
	<jsp:param name="rows" value="${empty param.rows ? 12 : param.rows }" />
	<jsp:param name="totalpage" value="${pagination.totalpage }" />
	<jsp:param name="fn_list" value="comment_list" />
	<jsp:param name="focusid" value="comment_list" />
</jsp:include>
<script>
	//총 카운트 갯수 업뎃
	$("#total_count").text("${pagination.totalcount }");
</script>