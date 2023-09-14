<%@page import="com.tjoeun.vo.AttendanceVO"%>
<%@page import="com.tjoeun.vo.MainVO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>마이 페이지 수정</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
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
	h2 { /* 제일 큰 글씨 */
		font-size: 40px; 
		text-align:center; 
		padding-top: 0.6em;
	}
	.pic { /* 사진들 */
		display: inline-block;
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
	.userInfo { /* 테이블 */
		font-size: 20px;
	}
	table tr td {
		padding: 20px;
		font-size: 16px;
	}
	.actions .button { /* 버튼들 */
		width: 80px;
		font-size: 15px;
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
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- Main -->
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
				
				
				<div align="center">
					<h2 align="center">나의 정보</h2>
					<form action="myPageUpdateOK" method="POST" enctype="multipart/form-data">
						<div class="pic" align="left" >
							<img id="preImage"  name="preImage" alt="이미지" 
								src="/Tjoeun_Data/empImages/${mvo.imagefile}" onerror="this.src='images/user.png'"  
								style="width: 300px; height: 400px;"/>
							<div class="filebox" style="display: block; width: 350px;">
								<div style="display: flex;">
									<label for="filename" style="width: 100px;">이미지 첨부</label>
									<label onclick="resetImage();" style="width: 100px;">이미지 초기화</label>
									<label onclick="resetDefaultImage();" style="width: 100px;">기본 이미지</label>
								</div>
								<div style="display: flex;">
									<input class="file" type="file" id="filename" name="imageFile" value="${mvo.imagefile}" onchange="readImage(this);" 
										style="width: 150px;"/>							
									<a id="imageName" href="/Tjoeun_Data/empImages/${mvo.imagefile}" download="${mvo.imagefile}" style="width: 200px;">
										<span id="imageNameSpan" style="font-size: 12px; color: #f56a6a;">
											<input type="hidden" name="imageNameSpanValue" id="imageNameSpanValue" value="${mvo.imagefile}"/>
											${mvo.imagefile}
										</span>
									</a>
								</div>
							</div>
						</div>
						<table class="userInfo" style="float: right; width: 700px; margin-right: 10%;">
							<tr>
								<th width="150px">이름</th>
								<td width="250px">${mvo.name}</td>
								<th width="150px">생년월일</th>
								<td width="250px">${B_Day}</td>
							</tr>
							
							<tr>
								<th>사원번호</th>
								<td>${mvo.cnum}</td>
								<th>부서 / 직급</th>
								<td>${mvo.team} / ${mvo.role}</td>
							</tr>
	
							<tr>
								<th>입사일</th>
								<td>${J_Date}</td>
								<th>남은 연차</th>
								<td>${mvo.dayoff}일</td>
							</tr>
							
							<tr>
								<th>이메일</th>
								<td colspan="3"><input type="text" name="email" value="${mvo.email}"/></td>
							</tr>
							
							<tr>
								<th>전화번호</th>
								<td colspan="3"><input type="text" name="phone" value="${mvo.phone}"/></td>
							</tr>
							<tr class="actions" style="border-bottom: none;">
								<td colspan="4" align="right" style="padding-top: 15px;">
									<input class="button big" type='reset' value="리셋"/>
									<input class="button big" type="submit" value="완료"/>		
								</td>
							</tr>
						</table>
					</form>
				</div>
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
	<script src="js/imageFunction.js"></script>
	
</body>
</html>