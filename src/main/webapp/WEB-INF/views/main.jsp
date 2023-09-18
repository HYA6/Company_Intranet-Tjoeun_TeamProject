<%@page import="com.tjoeun.vo.AttendanceVO"%>
<%@page import="com.tjoeun.vo.MainVO"%>
<%@page import="com.tjoeun.vo.MeetingVO" %>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>메인</title>
<meta charset="utf-8"/>
<script type="text/javascript" src="js/main.js"></script>
<link rel="stylesheet" href="css/main.css"/>
<style type="text/css">
	#header { /* Header */
		padding-top: 1em;
	}
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
	.actions { /* 버튼들 */
		padding: 0;
		margin: 0;
	}
	.actions .button { /* 출근, 퇴근 */
		width: 50px;
		height: 25px;
		font-size: 13px;
		color: #3d4449;
		border-color: rgba(210, 215, 217, 0.75);
		margin: 5px;
	}
	.actions .button:hover {
		width: 50px;
		height: 25px;
		font-size: 13px;
		color: #3d4449;
		border-color: rgba(210, 215, 217, 0.75);
		background-color: rgba(210, 215, 217, 0.75);
		margin: 5px;
	}
	#button_group1 .time { /* 출근 시간, 퇴근 시간 */
		width:220px;
		font-size: 13px;
		text-align: left;
		display: inline-block;
		background-color: white;
		border: none;
		border-bottom: 2px solid rgba(210, 215, 217, 0.75);
		cursor: auto;
	}
	.table { /* 공지 */
		padding: 10px;
		border: 2px solid rgba(210, 215, 217, 0.75);
	}
	div #RoomValue { /* 회의실 */
		display: inline;
	}
	#menu ul li { /* Sidebar의 menu들 */
		font-size: 16px;
	}
	.img { /* 행사 이미지들 */
		height: 250px;
		vertical-align: middle;
		margin: 5px;
	}
</style>
</head>

<body class="is-preload">
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- Main -->
		<div id="main">
			<div class="inner">
				<!-- Header -->
				<header id="header">
					<div style="padding-top: 9em;">
						<a href="main" class="logo" style="font-size: 20px;"><strong style="font-size: 25px;">더조은</strong> 상사</a>
					</div>
					<div style="text-align: center; padding-top: 1em;">
						<img alt="로고사진" src="images/logo2.png" style="max-width: 250px; opacity: 70%; /* margin-left: 3em; */">
					</div>
					<div align="right" style="padding-top: 2em;">
						<div style="display: inline-block; padding: 0px; margin: 0px;">
							<ul class="icons">
								<li>
									<a href="myPage" style="font-size: 20px; border-bottom: none;">
										<span class="label" id="mainName"><b>${mvo.name}</b><b>님 환영합니다.</b></span>
									</a>
								</li>
								<li>
									<a href="logoutOK" style="border-bottom: none;">
										<span class="label" id="logout">로그아웃</span>
									</a>
								</li>
							</ul>
						</div>
						<div id="button_group1" class="actions">
							<input id="time" class="time" name="time" disabled="disabled" value="출근 시간: ${Atten_date}"/>
							<button 
								id="work" 
								class="button big"
								onclick="location.href='attendanceOK?cnum=${mvo.cnum}&flag=1';"
							>출근</button><br/>
							<input id="date" class="time"  name="date" disabled="disabled" value="퇴근 시간: ${Leave_date}"/>			
							<button 
								id="home"
								class="button big"
								onclick="location.href='attendanceOK?cnum=${mvo.cnum}&flag=2';"
							>퇴근</button>
						</div> <!-- <div id="button_group1"> -->
					</div>
				</header>
				
				<!-- Banner -->
				<section id="banner">
					<div align="center" class="content">
						<div align="left" style="display: inline-block; width: 40%;">
							<table class="table" style="height: 240px;">
								<tr>
									<th colspan="3" style="padding: 13px; text-align: left; height: 57.19px;">
										<a href="boardList" style="font-size: 18px; color: #3d4449; border-bottom: none;">공지사항</a>
									</th>
								</tr>
								<!-- 오늘 날짜를 기억하는 Date 클래스 객체를 useBean으로 만든다. -->
								<jsp:useBean id="date" class="java.util.Date"/>
								<!-- 메인에 표시될 공지사항 출력한다. -->
								<c:set var="list2" value="${mainBoardList.list2}"/>						
								<!-- 공지사항이 1건도 없으면 글이 없다고 출력한다. -->
								<c:if test="${list2.size() == 0}">
									<tr>
										<td colspan="2" style="text-align: left; vertical-align: middle;">
											공지사항이 없습니다.
										</td>
									</tr>
								</c:if>
								<!-- 공지사항이 있으면 공지사항의 개수만큼 반복하며 글 제목을 출력한다. -->
								<c:if test="${list2.size() != 0}">
									<c:forEach var="bo" items="${list2}">
										<tr>
											<td align="center" width="15%" style="font-size: 14px; border-right: 1px solid rgba(210, 215, 217, 0.75);">
												<span style="color: #7f888f;">${bo.idx}</span>
											</td>
											<td width="62%" style="font-size: 14px; padding-left: 20px; border-right: 1px solid rgba(210, 215, 217, 0.75);">
												<!-- 제목에 태그 적용 불가 -->
												<c:set var="subject" value="${fn:replace(bo.subject, '<', '&lt;')}"/>
												<c:set var="subject" value="${fn:replace(subject, '>', '&gt;')}"/>
												<!-- 제목에 하이퍼링크를 걸어준다. -->
												<a href="boardIdx?idx=${bo.idx}&currentPage=${1}">
													${subject}
												</a>	
											</td>
											<!-- 오늘 글, 어제 글 다르게 표시 -->
											<td align="center" width="23%" style="font-size: 13px;">
												<c:if test="${date.year == bo.writeDate.year && date.month == bo.writeDate.month &&
													date.date == bo.writeDate.date}">
													TODAY <fmt:formatDate value="${bo.writeDate}" pattern="HH:mm"/>
												</c:if>			
												
												<c:if test="${date.year != bo.writeDate.year || date.month != bo.writeDate.month ||
													date.date != bo.writeDate.date}">
													<fmt:formatDate value="${bo.writeDate}" pattern="yy.MM.dd(E)"/>
												</c:if>				
											</td>
										</tr>
									</c:forEach>
								</c:if>
							</table>
						</div>
						<div align="right" style="display: inline-block; width: 40%; margin-left: 50px; vertical-align: top;">
							<table class="table" style="height: 240px;">
								<tr>
									<th colspan="2" style="font-size: 18px; padding: 13px; text-align: left;">
										<a href="countAllMeetingRooms" style="font-size: 18px; color: #3d4449; border-bottom: none;">오늘의 회의실 예약 현황  
										</a>
									</th>
								</tr>
								<tr style="height: 75.41px;">
									<td style="width: 25%; padding: 13px; text-align: left; vertical-align: middle; border-right: 1px solid rgba(210, 215, 217, 0.75);">
										<a href="getAllMeetingRooms?room_id=101">101호 회의실</a>
									</td>
									<td style="padding: 13px; text-align: left; vertical-align: middle;">
										<c:choose>
											<c:when test="${Room_Value['101'] eq null}">
												해당 회의실의 예약이 없습니다.
											</c:when>
											<c:otherwise>
												예약자 : ${Room_Value.get("101").getUser_Name()}<br/>
												시간 : ${Room_Value.get("101").getMeetingTime()}
											</c:otherwise>
										</c:choose>			
									</td>
								</tr>
								<tr style="height: 75.41px;">
									<c:set var="list3" value="${mainMeetingList.list3}"/>					
									<td style="width: 25%; padding: 13px; text-align: left; vertical-align: middle; border-right: 1px solid rgba(210, 215, 217, 0.75);">
										<a href="getAllMeetingRooms?room_id=102">102호 회의실</a>
									</td>
									<td style="padding: 13px; text-align: left; vertical-align: middle;">
										<c:choose>
											<c:when test="${Room_Value['102'] eq null}">
												해당 회의실의 예약이 없습니다.
											</c:when>
											<c:otherwise>
												예약자 : ${Room_Value.get("102").getUser_Name()}<br/>
												시간 : ${Room_Value.get("102").getMeetingTime()}
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								<tr style="height: 75.41px;">
									<td style="width: 25%; padding: 13px; text-align: left; vertical-align: middle; border-right: 1px solid rgba(210, 215, 217, 0.75);">
										<a href="getAllMeetingRooms?room_id=103">103호 회의실</a>
									</td>
									<td style="padding: 13px; text-align: left; vertical-align: middle;">
										<c:choose>
											<c:when test="${Room_Value['103'] eq null}">
												해당 회의실의 예약이 없습니다.
											</c:when>
											<c:otherwise>
												예약자 : ${Room_Value.get("103").getUser_Name()}<br/>
												시간 : ${Room_Value.get("103").getMeetingTime()}
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</table>
						</div>
						<br/>
						<div align="left" style="display: inline-block; width: 40%;">
							<table class="table" style="height: 240px;">
								<tr>
									<th colspan="3" style="padding: 13px; text-align: left; height: 57.19px;">
										<a href="ScheduleView" style="font-size: 18px; color: #3d4449; border-bottom: none;">오늘의 사내 일정</a>
									</th>
								</tr>
								<!-- 메인에 표시될 식단표 출력한다. -->
								<c:set var="ScheduleList" value="${Schedule_list}"/>						
								<!-- 식단표가 1건도 없으면 글이 없다고 출력한다. -->
								<c:if test="${ScheduleList.size() == 0}">
									<tr>
										<td colspan="3" style="text-align: left; vertical-align: middle;">
											오늘의 사내 일정은 없습니다.
										</td>
									</tr>
								</c:if>
								<c:if test="${ScheduleList.size() != 0}">
									<c:forEach var="so" items="${ScheduleList}">
										<tr>
											<td align="center" width="15%" style="font-size: 14px; border-right: 1px solid rgba(210, 215, 217, 0.75);">
												<span style="color: #7f888f;">${so.schedule_num}</span>
											</td>
											<td style="font-size: 14px; padding-left: 20px; border-right: 1px solid rgba(210, 215, 217, 0.75);">
												<!-- 제목에 태그 적용 불가 -->
												<c:set var="subject" value="${fn:replace(so.schedule_subject, '<', '&lt;')}"/>
												<c:set var="subject" value="${fn:replace(so.schedule_subject, '>', '&gt;')}"/>
												<!-- 제목에 하이퍼링크를 걸어준다. -->
												<a href="ScheduleView">
													${so.schedule_subject}
												</a>		
											</td>
										</tr>
									</c:forEach>
								</c:if>
							</table>
						</div>
						<div align="left" style="display: inline-block; width: 40%; margin-left: 50px;">
							<table class="table" style="height: 240px;">
								<tr>
									<th colspan="3" style="padding: 13px; text-align: left; height: 57.19px;">
										<a href="mealListView" style="font-size: 18px; color: #3d4449; border-bottom: none;">식단표</a>
									</th>
								</tr>
								<!-- 메인에 표시될 식단표 출력한다. -->
								<c:set var="list" value="${mealList.list}"/>						
								<!-- 식단표가 1건도 없으면 글이 없다고 출력한다. -->
								<c:if test="${list.size() == 0}">
									<tr>
										<td colspan="3" style="text-align: left; vertical-align: middle;">
											식단표가 없습니다.
										</td>
									</tr>
								</c:if>
								<!-- 식단표가 있으면 식단표의 개수만큼 반복하며 글 제목을 출력한다. -->
								<c:if test="${list.size() != 0}">
									<c:forEach var="bmo" items="${list}">
										<tr>
											<td align="center" width="15%" style="font-size: 14px; border-right: 1px solid rgba(210, 215, 217, 0.75);">
												<span style="color: #7f888f;">${bmo.idx}</span>
											</td>
											<td width="62%" style="font-size: 14px; padding-left: 20px; border-right: 1px solid rgba(210, 215, 217, 0.75);">
												<!-- 제목에 태그 적용 불가 -->
												<c:set var="subject" value="${fn:replace(bmo.subject, '<', '&lt;')}"/>
												<c:set var="subject" value="${fn:replace(bmo.subject, '>', '&gt;')}"/>
												<!-- 제목에 하이퍼링크를 걸어준다. -->
												<a href="mealContentView?idx=${bmo.idx}&currentPage=${currentPage}">
													${bmo.subject}
												</a>		
											</td>
											<!-- 오늘 글, 어제 글 다르게 표시 -->
											<td align="center" width="23%" style="font-size: 13px;">
												<c:if test="${date.year == bmo.writeDate.year && date.month == bmo.writeDate.month &&
													date.date == bmo.writeDate.date}">
													TODAY <fmt:formatDate value="${bmo.writeDate}" pattern="HH:mm"/>
												</c:if>			
												
												<c:if test="${date.year != bmo.writeDate.year || date.month != bmo.writeDate.month ||
													date.date != bmo.writeDate.date}">
													<fmt:formatDate value="${bmo.writeDate}" pattern="yy.MM.dd(E)"/>
												</c:if>				
											</td>
										</tr>
									</c:forEach>
								</c:if>
							</table>
						</div>
						<br/>
						<a onclick="firstClick()" style="font-size: 40px; color: #f56a6a; text-decoration: none; border-bottom: none; cursor: pointer; display: inline-block;">◀</a>
						<div style="width: 60em; margin-bottom: 100px; font-size: 18px; display: inline-block;">
							<b style="text-align: center; color: #3d4449;">행사 사진 </b><br/>
							<div style="display: inline-block;">
								<img class="img" src="images/1.jpg"/>
							</div>
							<div style="display: inline-block;">
								<img class="img" src="images/2.jpg"/>
							</div>
							<div style="display: inline-block;">
								<img class="img" src="images/3.jpg"/>
							</div>
						</div>
						<a onclick="endClick()" style="font-size: 40px; color: #f56a6a; text-decoration: none; border-bottom: none; cursor: pointer; display: inline-block;">▶</a>
					</div> <!-- <div class="content"> -->
				</section>
			</div>
		</div>

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