<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재 확인</title>
<link rel="stylesheet" href="css/main.css"/>
<script type="text/javascript" src="js/CeoComment.js"></script>
<style type="text/css">
	.icons { /* 이름, 로그아웃 */
		height: 20px;
	}
	.icons #mainName { /* header 이름 span 태그 */
		font-size: 20px;
	}
	.icons #mainName:hover {
		font-size: 20px;
	}
	b:first-child { /* 이름 */
		font-size: 26px;
		color: #f56a6a;
	}
	b:last-child { /* 님 감사합니다. */
		font-size: 18px;
		font-weight: normal;
	}
	.icons #logout { /* 로그아웃 */
		font-size: 14px; 
		color: rgba(210, 215, 217, 0.75);
	}
	.icons #logout:hover {
		font-size: 14px; 
		color: #3d4449;
		transition: 0.2s;
	}
	table tr th { /* 제일 큰 글씨 */
		font-size: 30px; 
		text-align:center; 
		padding-top: 0.6em;
	}
	table td { /* 테이블 행들 */
		padding-top: 15px;
		padding-bottom: 15px;
	}
	.text { /* 글번호, 결재 종류, 이름, 작성일, 제목, 내용 */
		padding: 10px;
		font-size: 18px;
		color: #3d4449;
	}
	span { /* 내용들 */
		font-size: 18px;
	}
	.actions .button { /* 버튼들 */
		width: 80px;
		font-size: 13px;
		border: none;
		margin-left: 5px;
	}
	.actions .btn { /* 코멘트 수정하기 버튼 */
		width: 140px;
		font-size: 13px;
		border: none;
	}
	#menu ul li { /* 사이드바 */
		font-size: 16px;
	}
</style>
</head>
<body class="is-preload">
	<div id="wrapper">
		<div id="main">
			<div class="inner">
				<!-- Header -->
				<header id="header">
					<div align="right">
						<ul class="icons">
							<li>
								<a href="myPage" style="font-size: 20px; border-bottom: none;">
									<span class="label" id="mainName"><b>${mvo.name}</b><b>님</b></span>
								</a>
							</li>
							<li>
								<a href="logoutOK" style="border-bottom: none;">
									<span class="label" id="logout">로그아웃</span>
								</a>
							</li>
						</ul>
					</div>
				</header>
				<form action="CeoUpdate" method="post">
					<table style="width: 1100px; margin-left: auto; margin-right: auto;">
						<tr>
							<th colspan="8" style="text-align: left;">결재 확인</th>
						</tr>
						<tr>
							<td class="text" style="width: 150px;" align="center">사원번호</td>
							<td style="width: 100px;">${co.cnum}</td>
							<td class="text" style="width: 100px;" align="center">이름</td>
							<td style="width: 150px;">
								<c:set var="name" value="${fn:replace(co.name, '<', '&lt;')}"/>
								<c:set var="name" value="${fn:replace(name, '>', '&gt;')}"/>
								${name}
							</td>
							<td class="text" style="width: 100px;" align="center">결재 종류</td>
							<td style="width: 300px;">${co.paper}</td>
							<td class="text" style="width: 100px;" align="center">결재 상태</td>
							<td style="width: 150px; text-align: center;">
								<c:if test="${co.status.equals('반려')}">
									<span style="color: #DF0101; font-size: 16px;">${co.status}</span>
								</c:if>
								<c:if test="${co.status.equals('승인')}">
									<span style="color: #04B4AE; font-size: 16px;">${co.status}</span>
								</c:if>
							</td>
						</tr>
						<jsp:useBean id="date" class="java.util.Date"/>
						<tr>
							<td class="text" align="center">제목</td>
							<td colspan="5" style="padding-left: 50px;">
								<c:set var="subject" value="${fn:replace(co.subject, '<', '&lt;')}"/>
								<c:set var="subject" value="${fn:replace(subject, '>', '&gt;')}"/>
								<span>${subject}</span>
							</td>
							<td colspan="2" align="right">
								<fmt:formatDate value="${co.writeDate}" pattern="yyyy.MM.dd(E) a h:mm"/>
							</td>
						</tr>
						<tr style="height: 400px;">
							<td class="text" align="center" style="vertical-align: middle;">내용</td>
							<td colspan="8" style="padding-left: 50px;">
								<c:set var="content" value="${fn:replace(co.content, '<', '&lt;')}"/>
								<c:set var="content" value="${fn:replace(content, '>', '&gt;')}"/>
								<c:set var="content" value="${fn:replace(content, enter, '<br/>')}"/>
								<span>${content}</span>
							</td>
						</tr>
						<tr>
							<td class="content" align="center" style="color: #3d4449; font-size: 18px;">파일</td>
							<td class="content" colspan="8">
								<c:if test="${co.filename ne null}">
									<c:set var="filename" value="${fn:replace(co.filename, '<', '&lt;')}"/>
									<c:set var="filename" value="${fn:replace(co.filename, '>', '&gt;')}"/>
									<a href="/Tjoeun_Data/Upload/${co.filename}" download="${co.filename}">
										<span style="font-size: 15px; color: #f56a6a;">${co.filename}</span>
									</a>
								</c:if>
								<c:if test="${co.filename eq null}">
									<span style="font-size: 15px;">파일 없음</span>
								</c:if>
							</td>
						</tr>
						<tr class="actions" style="border-bottom: none;">
							<td colspan="8" align="right">
								<c:if test="${co.cnum == 220}">
									<input class="button big" type="submit" value="수정"/>
									<input class="button big" type="button" value="삭제"
										onclick="location.href='CeoDelete?idx=${co.idx}&cnum=${mvo.cnum}&currentPage=${currentPage}&paper=${co.paper}&approval=${approval}'"/>
								</c:if>
								<input class="button big" type="button" value="승인" 
									onclick="location.href='CeoCommentUpdate?idx=${co.idx}&cnum=${mvo.cnum}&status=${co.status}&currentPage=${currentPage}&paper=${co.paper}&approval=${approval}'"/>
								<input class="button big" type="button" value="반려" onclick="reasonComment()"/>
								<input class="button big" type="button" value="돌아가기" onclick="history.back()"/>
								<input class="button big" type="button" value="전체목록"
									onclick="location.href='Ceo?currentPage=${currentPage}'"/>
							</td>
						</tr>
						<tr style="display: none;">
							<td colspan="8">
								<input type="text" name="idx" value="${co.idx}"/>
								<input type="text" name="currentPage" value="${currentPage}"/>
								<input type="text" name="subject" value="${co.subject}"/>
								<input type="text" name="content" value="${co.content}"/>
								<input type="text" name="status" value="${co.status}"/>
								<input type="text" name="reason" value="${co.reason}"/>
								<input type="text" name="cnum" value="${mvo.cnum}"/>
								<input type="text" name="paper" value="${co.paper}"/>
								<input type="text" name="approval" value="${approval}"/>
							</td>
						</tr>
					</table>
				</form>
				<c:if test="${co.reason != null}">
					<table style="width: 1100px; margin-left: auto; margin-right: auto;">
						<tr class="tr" style="height: 150px;">
							<th style="width: 150px; font-size: 20px; vertical-align: middle;">반려 사유</th>
							<td style="padding-left: 30px; vertical-align: middle;">
								<c:set var="reason" value="${fn:replace(co.reason, '<', '&lt;')}"/>
								<c:set var="reason" value="${fn:replace(reason, '>', '&gt;')}"/>
								<c:set var="reason" value="${fn:replace(reason, enter, '<br/>')}"/>
								<span>${reason}</span>
							</td>
						</tr>
						<tr class="actions" style="border-bottom: none;">
							<td colspan="2" align="right">
								<input class="btn" type="button" value="코멘트 수정하기" onclick="reasonComment()"/>
							</td>
						</tr>
					</table>
				</c:if>
			</div> <!-- <div class="inner"> -->
		</div> <!-- <div id="main"> -->
		
		<!-- Sidebar -->
		<div id="sidebar">
			<div class="inner">
				<!-- Menu -->
				<nav id="menu">
					<header class="major">
						<h2>Menu</h2>
					</header>
					<ul>
						<li><a href="main">홈</a></li>
						<li><a href="boardList">공지사항</a></li>
						<li><a href="ScheduleView">사내 일정</a></li>
						<li>
							<span class="opener">전자 결재</span>
							<ul>
							<!-- 사장이면 전체 보기를 눌렀을 때 사장이 보는 페이지로 넘어가는 if문 만들기 -->
								<c:if test="${mvo.cnum != 220}"> <!-- 사원 -->
									<li><a href="elecapprsawonList?cnum=${mvo.cnum}">전체보기</a></li>
								</c:if>
								<c:if test="${mvo.cnum == 220}"> <!-- 사장 -->
									<li><a href="Ceo">전체보기</a></li>
								</c:if>
								<li><a href="approvalList?cnum=${mvo.cnum}&paper=지출결의서"> -지출결의서</a></li>
								<li><a href="approvalList?cnum=${mvo.cnum}&paper=휴가근태서"> -휴가근태서</a></li>
								<li><a href="approvalList?cnum=${mvo.cnum}&paper=제안서"> -제안서</a></li>
								<li><a href="approvalList?cnum=${mvo.cnum}&paper=공문"> -공문</a></li>
								<li><a href="approvalList?cnum=${mvo.cnum}&paper=사직서"> -사직서</a></li>
							</ul>
						</li>
						<li>
							<span class="opener">회의실 예약</span>
							<ul>
								<li><a href="countAllMeetingRooms">전체보기</a></li>
								<li><a href="getAllMeetingRooms?room_id=101"> -101호 회의실</a></li>
								<li><a href="getAllMeetingRooms?room_id=102"> -102호 회의실</a></li>
								<li><a href="getAllMeetingRooms?room_id=103"> -103호 회의실</a></li>
							</ul>
						</li>
						<li><a href="freeboardList">대나무 숲</a></li>
						<li><a href="mealListView">식단표</a></li>
					</ul>
				</nav>
				<!-- Footer -->
				<footer id="footer">
				</footer>
			</div>
		</div>
	</div>


	<!-- Scripts -->
	<script src="js/jquery.min.js"></script>
	<script src="js/browser.min.js"></script>
	<script src="js/breakpoints.min.js"></script>
	<script src="js/util.js"></script>
	<script src="js/menu.js"></script>

</body>
</html>