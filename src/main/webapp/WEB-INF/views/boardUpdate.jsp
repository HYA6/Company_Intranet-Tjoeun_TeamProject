<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 수정</title>
<link rel="stylesheet" href="css/main.css"/>
<script type="text/javascript">
	/* 공지 수정 */
	function boardUpdate(){
		console.log('boardUpdate() 실행')
		var boardUpForm = document.boardUp;
		if(boardUpForm.subject.value == "" || boardUpForm.subject.value == null){
			alert("제목을 입력해주세요.");
			boardUpForm.subject.focus();
			return false;
		} else if(boardUpForm.content.value == "" || boardUpForm.content.value == null){
			alert("내용을 입력해주세요.");
			boardUpForm.content.focus();
			return false;
		}
		boardUpForm.submit();
	}
</script>
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
	table tr td {
		font-size: 20px; 
	}
	label { /* 제목, 내용 */
		font-size: 20px;
		opacity: 85%;
	}
	input[type=text], textarea { /* 입력칸 */
		font-size: 16px;
		padding: 10px;
		width: 97%;
	}
	.actions .button { /* 버튼들 */
		width: 80px;
		font-size: 13px;
		border: none;
		margin-left: 10px;
		margin-right: 10px;
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
			<form action="boardUpdateOK" name="boardUp" method="post">
				<table style="width: 900px; margin-left: auto; margin-right: auto;">
					<tr>
						<th colspan="2">공지사항 수정</th>
					</tr>
					<tr>
						<td align="center" style="width: 150px;">
							<label for="gubun">종류</label>
						</td>
						<td>
							<c:if test="${bo.gubun eq '알림'}">
						    	<input id="gubun1" type="radio" name="gubun" value="알림" checked="checked">
						    </c:if>
							<c:if test="${bo.gubun ne '알림'}">
						    	<input id="gubun1" type="radio" name="gubun" value="알림">
						    </c:if>
							<label for="gubun1">알림</label>
							<c:if test="${bo.gubun eq '언론보도'}">
						    	<input id="gubun2" type="radio" name="gubun" value="언론보도" checked="checked">
						    </c:if>
							<c:if test="${bo.gubun ne '언론보도'}">
								<input id="gubun2" type="radio" name="gubun" value="언론보도">
						    </c:if>
							<label for="gubun2">언론보도</label>
							<c:if test="${bo.gubun eq '주요공지'}">
						    	<input id="gubun3" type="radio" name="gubun" value="주요공지" checked="checked">
						    </c:if>
							<c:if test="${bo.gubun ne '주요공지'}">
								<input id="gubun3" type="radio" name="gubun" value="주요공지">
						    </c:if>
						    <label for="gubun3">주요공지</label>
						</td>
					</tr>
					<tr>
						<td align="center" style="width: 150px;">
							<label for="subject">제목</label>
						</td>
						<td>
							<input id="subject" type="text" name="subject" value="${bo.subject}"/>
						</td>
					</tr>
					<tr>
						<td align="center" style="vertical-align: middle;">
							<label for="content">내용</label>
						</td>
						<td>
							<textarea id="content" rows="10" name="content" style="resize: none;">${bo.content}</textarea>
						</td>
					</tr>
					<tr class="actions" style="border-bottom: none;">
						<td colspan="2" align="center">
							<div>
								<input class="button big" type="button" value="수정하기" onclick="boardUpdate()"/>
								<input class="button big" type="reset" value="원래대로"/>
								<input class="button big" type="button" value="돌아가기" 
									onclick="history.back()"/>
								<input class="button big" type="button" value="목록보기" 
									onclick="location.href='boardList?currentPage=${currentPage}'"/>
							</div>
						</td>
					</tr>
				</table>
				<input type="hidden" name="idx" value="${bo.idx}"/>
				<input type="hidden" name="currentPage" value="${currentPage}"/>
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

