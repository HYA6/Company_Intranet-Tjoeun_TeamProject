<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원이 보는 결재 목록</title>
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
	select { /* 카테고리 */
		font-size: 13px;
		display: inline-block;
		width: 130px;
		height: 30px;
		border: none;
	}
	select:hover { 
		cursor: pointer;
	}
	input[type=text] { /* 검색 내용 입력 */
		font-size: 13px;
		display: inline-block;
		width: 250px; 
		height: 30px; 
		border: none;
		border-bottom: 1.5px solid #7f888f;
		border-radius: 0;
		padding: 5px;
	}
	input[type=submit] { /* 검색 버튼 */
		font-size: 13px;
		font-weight: normal;
		width: 50px;
		height: 25px;
		color: #7f888f;
		border: none;
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
				<table class="table" style="width: 1200px; margin-left: auto; margin-right: auto;">
					<tr style="border-bottom: none;">
						<th colspan="5" style="padding-bottom: 0;">결재 목록</th>
					</tr>
					<tr style="border-top: none;">
						<td colspan="5" align="right" style="font-size: 13px; padding-top: 0;">
							${elecapprsawonList.totalCount} (${elecapprsawonList.currentPage} / ${elecapprsawonList.totalPage})
						</td>
					</tr>
					<tr class="tr">
						<td style="width: 100px; text-align: center;">글번호</td>
						<td style="width: 100px; text-align: center;">결재 종류</td>
						<td style="width: 550px; text-align: center;">제목</td>
						<td style="width: 250px; text-align: center;">작성일</td>
						<td style="width: 100px; text-align: center;">결재 상태</td>
					</tr>
					
					<!-- 오늘 날짜를 기억하는 Date 클래스 객체를 useBean으로 만든다. -->
					<jsp:useBean id="date" class="java.util.Date"/>
					
					<!-- 메인글을 출력한다. -->
					<c:set var="list" value="${elecapprsawonList.list}"/>
					<!-- 메인글이 1건도 없으면 글이 없다고 출력한다. -->
					<c:if test="${list.size() == 0}">
						<tr align="center">
							<td colspan="5">
								글이 존재하지 않습니다.
							</td>
						</tr>
					</c:if>
					<!-- 메인글이 있으면 메인글의 개수만큼 반복하며 글 제목을 출력한다. -->
					<c:if test="${list.size() != 0}">
						<c:forEach var="eo" items="${list}">
							<tr>
								<td align="center" style="font-size: 13px;">${eo.idx}</td>
								<td align="center">${eo.paper}</td>
								<td style="padding-left: 30px;">
									<!-- 제목에 태그 적용 불가 -->
									<c:set var="subject" value="${fn:replace(eo.subject, '<', '&lt;')}"/>
									<c:set var="subject" value="${fn:replace(subject, '>', '&gt;')}"/>
									<!-- 제목에 하이퍼링크를 걸어준다. -->
									<a href="selectsawonIdx?idx=${eo.idx}&currentPage=${currentPage}&approval=${approval}">
										${subject}
									</a>	
								</td>
								<!-- 오늘 글, 어제 글 다르게 표시 -->
								<td align="center" style="font-size: 13px;">
									<c:if test="${date.year == eo.writeDate.year && date.month == eo.writeDate.month &&
										date.date == eo.writeDate.date}">
										TODAY <fmt:formatDate value="${eo.writeDate}" pattern="HH:mm"/>
									</c:if>			
									
									<c:if test="${date.year != eo.writeDate.year || date.month != eo.writeDate.month ||
										date.date != eo.writeDate.date}">
										<fmt:formatDate value="${eo.writeDate}" pattern="yyyy-MM-dd(E) a h:mm"/>
									</c:if>				
								</td>
								<td align="center">
									<c:if test="${eo.status.equals('반려')}">
										<span style="color: #DF0101;">${eo.status}</span>
									</c:if>
									<c:if test="${eo.status.equals('승인')}">
										<span style="color: #04B4AE;">${eo.status}</span>
									</c:if>
								</td>
							</tr>
						</c:forEach>	
					</c:if>
					<!-- 페이지 이동 버튼 -->
					<tr class="actions" style="border-bottom: none;">
						<td colspan="5" align="center" style="padding-bottom: 0;">
							<!-- 처음으로 -->
							<c:if test="${elecapprsawonList.currentPage > 1}">
								<button 
									class='button' 
									type="button" 
									title="첫 페이지로 이동합니다." 
									onclick="location.href='?cnum=${mvo.cnum}&currentPage=1'"
								>처음</button>
							</c:if>
							<c:if test="${elecapprsawonList.currentPage <= 1}">
								<button 
									class='button' 
									type="button" 
									disabled="disabled" 
									title="이미 첫 페이지 입니다."
								>처음</button>
							</c:if>
							<!-- 10페이지 앞으로 -->
							<c:if test="${elecapprsawonList.startPage > 1}">
								<button 
									class='button' 
									type="button" 
									title="이전 10페이지로 이동합니다." 
									onclick="location.href='?cnum=${mvo.cnum}&currentPage=${elecapprsawonList.startPage - 1}'"
								>이전</button>
							</c:if>
							<c:if test="${elecapprsawonList.startPage <= 1}">
								<button 
									class='button' 
									type="button" 
									disabled="disabled" 
									title="이미 첫 10페이지 입니다."
								>이전</button>
							</c:if>
							
							<!-- 페이지 이동 버튼 -->
							<c:forEach var="i" begin="${elecapprsawonList.startPage}" end="${elecapprsawonList.endPage}" step="1">
								<c:if test="${elecapprsawonList.currentPage == i}">
									<button class='btn' type='button' disabled='disabled'>${i}</button>
								</c:if>
								<c:if test="${elecapprsawonList.currentPage != i}">
									<button 
										class='btn' 
										type='button' 
										title="${i}페이지로 이동합니다."
										onclick="location.href='?cnum=${mvo.cnum}&currentPage=${i}'"
									>${i}</button>
								</c:if>
							</c:forEach>
							
							<!-- 10페이지 뒤로 -->
							<c:if test="${elecapprsawonList.endPage < elecapprsawonList.totalPage}">
								<button 
									class='button' 
									type="button" 
									title="다음 10페이지로 이동합니다." 
									onclick="location.href='?cnum=${mvo.cnum}&currentPage=${elecapprsawonList.endPage + 1}'"
								>다음</button>
							</c:if>
							<c:if test="${elecapprsawonList.endPage >= elecapprsawonList.totalPage}">
								<button 
									class='button' 
									type="button" 
									disabled="disabled" 
									title="이미 마지막 10페이지 입니다."
								>다음</button>
							</c:if>
							
							<!-- 마지막으로 -->
							<c:if test="${elecapprsawonList.currentPage < elecapprsawonList.totalPage}">
								<button
									class='button'  
									type="button" 
									title="마지막 페이지로 이동합니다." 
									onclick="location.href='?cnum=${mvo.cnum}&currentPage=${elecapprsawonList.totalPage}'"
								>마지막</button>
							</c:if>
							<c:if test="${elecapprsawonList.currentPage >= elecapprsawonList.totalPage}">
								<button 
									class='button' 
									type="button" 
									disabled="disabled" 
									title="이미 마지막 페이지 입니다."
								>마지막</button>
							</c:if>
						</td>
					</tr>
					
					<!-- 카테고리별 검색어를 입력받는다. -->
					<tr style="border-bottom: none; border-top: none;">
						<td colspan="7" align="center" style="padding: 0;">
							<form action="elecapprsawonList" method="post" style="margin-bottom: 0;">
								<select name="category">
									<option>결재 종류</option>
									<option>제목</option>
									<option>내용</option>
								</select>
								<input type="text" name="item" value="${item}"/>
								<input class="button" type="submit" value="검색"/>
								<input type="hidden" name="cnum" value="${mvo.cnum}"/>
								<input type="hidden" name="paper" value="${paper}"/>
								<input type="hidden" name="currentPage" value="${currentPage}"/>
							</form>
						</td>
					</tr>
					
					<tr class="actions" style="border-bottom: none; border-top: none;">
						<td colspan="5" align="right" style="padding-top: 0;">
							<input class="button big" type="button" value="글쓰기"
								onclick="location.href='approvalInsert?currentPage=${currentPage}'">
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