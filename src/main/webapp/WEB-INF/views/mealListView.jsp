<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식단표 목록</title>
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
	.actions .button { /* 처음, 이전, 다음, 마지막 버튼 */
		font-size: 13px;
		width: 60px;
		height: 30px;
		border: none;
		margin: 3px;
	}
	.btn { /* 페이지 이동 버튼 */
		font-size: 13px;
		width: 30px;
		height: 30px;
		border: none;
		margin: 5px;
	}
	.write .button { /* 글쓰기 버튼 */
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
				<form action="?" method="post">
					<table class="table" style="width: 1000px; margin-left: auto; margin-right: auto;">
						<tr style="border-bottom: none;">
							<th colspan="4" style="padding-bottom: 0;">식단표</th> 
						</tr>
						<tr style="border-top: none;">
							<td colspan="4" align="right" style="font-size: 13px; padding-top: 0;">
								${mealList.totalCount} (${mealList.currentPage}/${mealList.totalPage})
							</td>
						</tr>
						<tr class="tr">
							<td style="width: 150px; text-align: center;">글번호</td>
							<td style="width: 500px; text-align: center;">제목</td>
							<td style="width: 150px; text-align: center;">작성자</td>
							<td style="width: 200px; text-align: center;">작성일</td>
						</tr>

						<jsp:useBean id="date" class="java.util.Date"/>
						
						<c:set var="list" value="${mealList.list}"/>						
						<c:if test="${list.size() == 0}">
							<tr>
								<td colspan="4" align="center">
									식단표가 없습니다.
								</td>
							</tr>
						</c:if>
						<c:if test="${list.size() != 0}">
							<c:forEach var="bmo" items="${list}">
								<tr>
									<td align="center">${bmo.idx}</td>
									<td style="padding-left: 15px;">
										<c:set var="subject" value="${fn:replace(bo.subject, '<', '&lt;')}"/>
										<c:set var="subject" value="${fn:replace(subject, '>', '&gt;')}"/>
										<a href="mealContentView?idx=${bmo.idx}&currentPage=${currentPage}">
											${bmo.subject}
										</a>	
									</td>
									<td align="center">${bmo.name}</td>
									<td align="center" style="font-size: 13px;">
										<c:if test="${date.year == bmo.writeDate.year && date.month == bmo.writeDate.month &&
											date.date == bmo.writeDate.date}">
											TODAY <fmt:formatDate value="${bmo.writeDate}" pattern="HH:mm"/>
										</c:if>			
										<c:if test="${date.year != bmo.writeDate.year || date.month != bmo.writeDate.month ||
											date.date != bmo.writeDate.date}">
											<fmt:formatDate value="${bmo.writeDate}" pattern="yyyy-MM-dd(E) a h:mm"/>
										</c:if>				
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<!-- 페이지 이동 버튼 -->
						<tr class="actions" style="border-bottom: none;">
							<td colspan="4" align="center" style="padding-bottom: 0;">
								<!-- 처음으로 -->
								<c:if test="${mealList.currentPage > 1}">
									<button 
										class='button' 
										type="button" 
										title="첫 페이지로 이동합니다." 
										onclick="location.href='?currentPage=1'"
									>처음</button>
								</c:if>
								<c:if test="${mealList.currentPage <= 1}">
									<button 
										class='button' 
										type="button" 
										disabled="disabled" 
										title="이미 첫 페이지 입니다."
									>처음</button>
								</c:if>
								<!-- 10페이지 앞으로 -->
								<c:if test="${mealList.startPage > 1}">
									<button 
										class='button' 
										type="button" 
										title="이전 10페이지로 이동합니다." 
										onclick="location.href='?currentPage=${mealList.startPage - 1}'"
									>이전</button>
								</c:if>
								<c:if test="${mealList.startPage <= 1}">
									<button 
										class='button' 
										type="button" 
										disabled="disabled" 
										title="이미 첫 10페이지 입니다."
									>이전</button>
								</c:if>
								
								<!-- 페이지 이동 버튼 -->
								<c:forEach var="i" begin="${mealList.startPage}" end="${mealList.endPage}" step="1">
									<c:if test="${mealList.currentPage == i}">
										<button class='btn' type='button' disabled='disabled'>${i}</button>
									</c:if>
									<c:if test="${mealList.currentPage != i}">
										<button 
											class='btn' 
											type='button' 
											title="${i}페이지로 이동합니다."
											onclick="location.href='?currentPage=${i}'"
										>${i}</button>
									</c:if>
								</c:forEach>
								
								<!-- 10페이지 뒤로 -->
								<c:if test="${mealList.endPage < mealList.totalPage}">
									<button 
										class='button' 
										type="button" 
										title="다음 10페이지로 이동합니다." 
										onclick="location.href='?currentPage=${mealList.endPage + 1}'"
									>다음</button>
								</c:if>
								<c:if test="${mealList.endPage >= mealList.totalPage}">
									<button 
										class='button' 
										type="button" 
										disabled="disabled" 
										title="이미 마지막 10페이지 입니다."
									>다음</button>
								</c:if>
								
								<!-- 마지막으로 -->
								<c:if test="${mealList.currentPage < mealList.totalPage}">
									<button
										class='button'  
										type="button" 
										title="마지막 페이지로 이동합니다." 
										onclick="location.href='?currentPage=${mealList.totalPage}'"
									>마지막</button>
								</c:if>
								<c:if test="${mealList.currentPage >= mealList.totalPage}">
									<button 
										class='button' 
										type="button" 
										disabled="disabled" 
										title="이미 마지막 페이지 입니다."
									>마지막</button>
								</c:if>
							</td>
						</tr>
						<!-- 글쓰기 버튼 -->
						<c:if test="${mvo.team == '경영진' || mvo.team == '식당 운영' || mvo.team == '총무'}">
							<tr class="write" style="border-bottom: none; border-top: none;">
								<td colspan="4" align="right">
									<input class="button" type="button" value="글쓰기"
										onclick="location.href='mealInsert'"/>
								</td>
							</tr>
						</c:if>
					</table>
				</form>
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