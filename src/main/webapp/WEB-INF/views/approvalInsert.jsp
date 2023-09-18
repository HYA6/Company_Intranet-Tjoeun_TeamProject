<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재안 올리기</title>
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
		padding: 10px;
		width: 97%;
	}
	/* 파일 */
	.filebox {
		font-weight: normal;
		vertical-align: middle;
	}
	.filebox .file {
	    display: inline-block;
	    border: none;
	    width: 50%;
	    color: #999999;
	    font-size: 15px;
	}
	.filebox .file::file-selector-button {
		display: none;
	}
	.filebox label {
	    display: inline-block;
		width: 100px;
	    font-size: 15px;
		text-align: center;
	    cursor: pointer;
	    font-weight: normal;
	}
	.actions .button { /* 버튼들 */
		width: 80px;
		font-size: 13px;
		border: none;
		margin-left: 5px;
		margin-right: 5px;
	}
	#menu ul li { /* 사이드바 */
		font-size: 16px;
	}
</style>
<script type="text/javascript">
	/* 결재안 저장 */
	function approvalAdd(){
		console.log('approvalAdd() 실행')
		var approvalAddForm = document.approvalForm;
		if(approvalAddForm.paper.value == "" || approvalAddForm.paper.value == null){
			alert("결재 종류를 선택해주세요.");
			return false;
		} else if(approvalAddForm.subject.value == "" || approvalAddForm.subject.value == null){
			alert("제목을 입력해주세요.");
			approvalAddForm.subject.focus();
			return false;
		} else if(approvalAddForm.content.value == "" || approvalAddForm.content.value == null){
			alert("내용을 입력해주세요.");
			approvalAddForm.content.focus();
			return false;
		}
		approvalAddForm.submit();
	}
</script>
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
				<form action="insert" method="post" name="approvalForm" enctype="multipart/form-data">
					<table style="width: 1000px; margin-left: auto; margin-right: auto;">
						<tr align="center">
							<th colspan="2"><c:if test="${paper ne null}">[${paper}] </c:if>결재 올리기</th>
						</tr>
						<c:if test="${paper eq null}"> <!-- 개별 목록에서 글 작성 할 경우 -->
							<tr>
								<td align="center" style="width: 150px;">
									<label for="gubun">종류</label>
									<input type="hidden" name="each" value="each"/>
								</td>
								<td>
								    <input id="paper1" type="radio" name="paper" value="지출결의서">
									<label for="paper1">지출결의서</label>
									<input id="paper2" type="radio" name="paper" value="휴가근태서">
									<label for="paper2">휴가근태서</label>
								    <input id="paper3" type="radio" name="paper" value="제안서">
								    <label for="paper3">제안서</label>
								    <input id="paper4" type="radio" name="paper" value="공문">
								    <label for="paper4">공문</label>
								    <input id="paper5" type="radio" name="paper" value="사직서">
								    <label for="paper5">사직서</label>
								</td>
							</tr>
						</c:if>
						<tr>
							<td align="center" style="width: 150px;">
								<label for="subject">제목</label>
							</td>
							<td>
								<input id="subject" type="text" name="subject"/>
							</td>
						</tr>
						<tr>
							<td align="center" style="vertical-align: middle;">
								<label for="content">내용</label>
							</td>
							<td>
								<textarea id="content" rows="12" name="content" style="resize: none;"></textarea>
							</td>
						</tr>
						<tr class="actions">
							<td colspan="2">
								<div class="filebox">
									<label for="filename">파일 첨부</label>
									<input class="file" type="file" id="filename" name="approvalFile"/>
								</div>
							</td>
						</tr>
						<tr class="actions" style="border-bottom: none;">
							<td colspan="2" align="center">
								<input class="button big" type="button" value="제출하기" onclick="approvalAdd()"/>
								<input class="button big" type="reset" value="다시쓰기"/>
								<input class="button big" type="button" value="돌아가기" onclick="history.back()"/>
								<c:if test="${mvo.cnum != 220}"> <!-- 사원 -->
									<input class="button big" type="button" value="전체목록" 
										onclick="location.href='elecapprsawonList?cnum=${mvo.cnum}'"/>
								</c:if>
								<c:if test="${mvo.cnum == 220}"> <!-- 사장 -->
									<input class="button big" type="button" value="전체목록" 
										onclick="location.href='Ceo'"/>
								</c:if>
							</td>
						</tr>
					</table>
					<input type="hidden" name="cnum" value="${mvo.cnum}"/>
					<input type="hidden" name="name" value="${mvo.name}"/>
					<c:if test="${paper ne null}"> <!-- 전체 목록에서 글 작성 할 경우 -->
						<input type="hidden" name="paper" value="${paper}"/>
					</c:if>
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