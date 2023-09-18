<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 회의실 예약 목록</title>
<link rel="stylesheet" href="css/main.css"/>
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
		text-align: center;
		padding: 0.6em;
	}
	.tr { /* 제일 위의 줄 (글번호, 제목, 작성일) */
		font-size: 16px;
		color: #3d4449;
	}
	.room_td { /* 회의실 부분 */
		width: 500px; 
		text-align: center; 
		font-size: 22px; 
	}
	.td { /* 예약 현황 목록 부분 */
		text-align: center;
	}
	.scroll { /* scroll div */
		height: 500px;
		overflow-y: scroll;
	}
	.scroll::-webkit-scrollbar {
		display: none; 
	}
	.meeting_td { /* 예약 현황 내용 */
		font-size: 14px;
		color: #7f888f;
	}
	.actions .button { /* 예약하기 버튼 */
		font-size: 14px;
		width: 70px;
		height: 30px;
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
                <table class="table" style="width: 1500px; margin-left: auto; margin-right: auto;">
					<tr style="border-bottom: none;">
						<th colspan="5">전체 회의실 예약 현황</th>
					</tr>
					<tr class="tr" style="border-top: none; border-bottom: none;">
						<td class="room_td">101호 회의실</td>
						<td class="room_td">102호 회의실</td>
						<td class="room_td">103호 회의실</td>
					</tr>
					
					<!-- 오늘 날짜를 기억하는 Date 클래스 객체를 useBean으로 만든다. -->
					<jsp:useBean id="date" class="java.util.Date"/>
					
					<!-- 글목록을 출력한다. -->
					<c:set var="list" value="${MeetingRoomList.list}"/>
					<c:if test="${list.size() == 0}">
						<tr class="tr" style="border-top: none; border-bottom: none;">
							<td class="td" style="border-right: 1px solid rgba(210, 215, 217, 0.75);">
								<div class="scroll">
									<table style="width: 100%;">
										<tr style="border-top: none;">
											<td style="width: 150px; text-align: center;">날짜</td>
											<td style="width: 150px; text-align: center;">시간</td>
											<td style="width: 100px; text-align: center;">부서</td>
											<td style="width: 100px; text-align: center;">이름</td>
										</tr>
										<tr style="border-bottom: none;">
											<td colspan="4" class="meeting_td">
												예약 내역이 존재하지 않습니다.
											</td>
										</tr>
									</table>
								</div>
							</td>
							<c:set var="list" value="${MeetingRoomList.list}"/>
							<td class="td" style="border-right: 1px solid rgba(210, 215, 217, 0.75);">
								<div class="scroll">
									<table style="width: 100%;">
										<tr style="border-top: none;">
											<td style="width: 150px; text-align: center;">날짜</td>
											<td style="width: 150px; text-align: center;">시간</td>
											<td style="width: 100px; text-align: center;">부서</td>
											<td style="width: 100px; text-align: center;">이름</td>
										</tr>
										<tr style="border-bottom: none;">
											<td colspan="4" class="meeting_td">
												예약 내역이 존재하지 않습니다.
											</td>
										</tr>
									</table>
								</div>
							</td>
							<c:set var="list" value="${MeetingRoomList.list}"/>
							<td class="td">
								<div class="scroll">
									<table style="width: 100%; border-bottom: none;">
										<tr style="border-top: none;">
											<td style="width: 150px; text-align: center;">날짜</td>
											<td style="width: 150px; text-align: center;">시간</td>
											<td style="width: 100px; text-align: center;">부서</td>
											<td style="width: 100px; text-align: center;">이름</td>
										</tr>
										<tr style="border-bottom: none;">
											<td colspan="4" class="meeting_td">
												예약 내역이 존재하지 않습니다.
											</td>
										</tr>
									</table>
								</div>
							</td>
						</tr>
					</c:if>
					<c:if test="${list.size() != 0}">
						<tr class="tr" style="border-top: none; border-bottom: none;">
							<td class="td" style="border-right: 1px solid rgba(210, 215, 217, 0.75);">
								<div class="scroll">
									<table style="width: 100%;">
										<tr style="border-top: none;">
											<td style="width: 150px; text-align: center;">날짜</td>
											<td style="width: 150px; text-align: center;">시간</td>
											<td style="width: 100px; text-align: center;">부서</td>
											<td style="width: 100px; text-align: center;">이름</td>
										</tr>
										<c:forEach var="mro" items="${list}">
											<c:choose>
												<c:when test="${mro.room_id == 101}">
													<tr>
														<td class="meeting_td">${mro.meetingDate}</td>
														<td class="meeting_td">${mro.meetingTime}</td>
														<td class="meeting_td">${mro.team}</td>
														<td class="meeting_td">${mro.user_Name}</td>
													</tr>
												</c:when>
											</c:choose>
										</c:forEach>
									</table>
								</div>
							</td>
							<td class="td" style="border-right: 1px solid rgba(210, 215, 217, 0.75);">
								<div class="scroll">
									<table style="width: 100%;">
										<tr style="border-top: none;">
											<td style="width: 150px; text-align: center;">날짜</td>
											<td style="width: 150px; text-align: center;">시간</td>
											<td style="width: 100px; text-align: center;">부서</td>
											<td style="width: 100px; text-align: center;">이름</td>
										</tr>
										<c:forEach var="mro" items="${list}">
											<c:choose>
												<c:when test="${mro.room_id == 102}">
													<tr>
														<td class="meeting_td">${mro.meetingDate}</td>
														<td class="meeting_td">${mro.meetingTime}</td>
														<td class="meeting_td">${mro.team}</td>
														<td class="meeting_td">${mro.user_Name}</td>
													</tr>
												</c:when>
											</c:choose>
										</c:forEach>
									</table>
								</div>
							</td>
							<td class="td">
								<div class="scroll">
									<table style="width: 100%;">
										<tr style="border-top: none;">
											<td style="width: 150px; text-align: center;">날짜</td>
											<td style="width: 150px; text-align: center;">시간</td>
											<td style="width: 100px; text-align: center;">부서</td>
											<td style="width: 100px; text-align: center;">이름</td>
										</tr>
										<c:forEach var="mro" items="${list}">
											<c:choose>
												<c:when test="${mro.room_id == 103}">
													<tr>
														<td class="meeting_td">${mro.meetingDate}</td>
														<td class="meeting_td">${mro.meetingTime}</td>
														<td class="meeting_td">${mro.team}</td>
														<td class="meeting_td">${mro.user_Name}</td>
													</tr>
												</c:when>
											</c:choose>
										</c:forEach>
									</table>
								</div>
							</td>
						</tr>
					</c:if>
					<tr class="actions" style="border-top: none; border-bottom: none;">
						<td colspan="3" align="right">
							<input class="button big" type="button" value="예약하기" style="width: 80px;"
									onclick="location.href='meetingrooms?room_id=${room_id}'"> 
						</td>
					</tr>
				</table>
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