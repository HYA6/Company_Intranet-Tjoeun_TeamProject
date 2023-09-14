<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회의실 예약</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootst ap-responsive.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.js"></script>

<link rel="stylesheet" href="css/main.css"/>
<style>
	* {
	    font-family: 'PuradakGentleGothicR';
	}
	
	body {
	    color: #E53935;
	    overflow-x: hidden;
	    height: 100%;
	    background-color: #FFEBEE !important;
	    background-repeat: no-repeat;
	    padding: 0px !important;
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
	a:hover {
		 text-decoration: none;
	}
	
	.container-fluid {
	    padding-top: 50px !important;
	    padding-bottom: 120px !important;
	}
	
	.card {
	  box-shadow: 0px 2px 8px 0px #E53935;
	}
	
	input {
		display: inline-block;
	    padding: 10px 20px !important;
	    /* border: 1px solid #000 !important; */
	    border-radius: 10px;
	    box-sizing: border-box;
	    /* background-color: #FFEBEE !important; */
	    color: #EF5350 !important;
	    font-size: 16px;
	    letter-spacing: 1px;
	    width: 100px;
	}
	input:focus {
	    -moz-box-shadow: none !important;
	    -webkit-box-shadow: none !important;
	    box-shadow: none !important;
	    border: 1px solid #512DA8;
	    outline-width: 0;
	}
	input[type=button] {
	    height: 3em;
	    border: none;
	    font-size: 16px;
	}
	input[type=button]:hover {
	    height: 3em;
	    border: none;
	    font-size: 16px;
	    background-color: white;
	}
	.input {
		width: 100%;
	    display: inline-block;
	    border: none;
	    text-align: center;
	}
	.input:hover{
		width: 100%;
	    display: inline-block;
	    border: none;
	    text-align: center;
	    cursor: pointer;
	}
	select {
		text-align: center;
	}
	select:hover {
		text-align: center;
		cursor: pointer;
	}
	::placeholder {
	    color: #EF5350;
	    opacity: 1;
	}
	
	:-ms-input-placeholder {
	    color: #EF5350;
	}
	
	::-ms-input-placeholder {
	    color: #EF5350;
	}
	
	button:focus {
	    -moz-box-shadow: none !important;
	    -webkit-box-shadow: none !important;
	    box-shadow: none !important;
	    outline-width: 0;
	    background-color: #FFEBEE;
	}
	
	.datepicker {
	  background-color: #FFFFF !important;
	  color: #E53935 !important;
	  border: none;
	  padding: 10px !important;
	}
	
	/* .datepicker-dropdown:after {
	  border-bottom: 6px solid #FFEBEE;
	} */
	
	thead tr:nth-child(3) th {
	  color: #EF5350 !important;
	  font-weight: bold;
	  padding-top: 20px;
	  padding-bottom: 10px;
	}
	
	.dow, .old-day, .day, .new-day {
	  width: 40px !important;
	  height: 40px !important;
	  border-radius: 0px !important;
	}
	
	.old-day:hover, .day:hover, .new-day:hover, .month:hover, .year:hover, .decade:hover, .century:hover {
	  border-radius: 6px !important;
	  background-color: #E57373 ;
	  color: #EF9A9A;
	}
	
	.active {
	  border-radius: 6px !important;
	  /* background-image: linear-gradient(#90CAF9, #64B5F6) !important; */
	  /* color: #EF9A9A  !important; */
	}
	
	.disabled {
	  color: #FFCDD2 !important;
	}
	
	.prev, .next, .datepicker-switch {
	  border-radius: 0 !important;
	  padding: 20px 10px !important;
	  text-transform: uppercase;
	  font-size: 20px;
	  color: #EF5350 !important;
	  opacity: 0.8;
	}
	
	.prev:hover, .next:hover, .datepicker-switch:hover {
	  background-color: #FFEBEE !important;
	  opacity: 1;
	}
	
	.cell {
	  border: 1px solid #BDBDBD;
	  border-color: #EF5350;
	  margin: 2px;
	  cursor: pointer;
	}
	
	.cell:hover {
	  border: 1px solid #EF5350 
	}
	
	.cell.select {
	  background-color: #EF5350;
	  color: white;
	}
	
	.fa-calendar {
	  color: #EF5350;
	  font-size: 30px;
	  padding-top: 8px;
	  padding-left: 5px;
	  cursor: pointer;
	}
	#menu ul li {
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
							<li><a href="myPage"
								style="font-size: 20px; border-bottom: none;"> <span
									class="label" id="mainName"><b>${mvo.name}</b><b>님</b></span>
							</a></li>
							<li><a href="logoutOK" style="border-bottom: none;"> <span
									class="label" id="logout">로그아웃</span>
							</a></li>
						</ul>
					</div>
				</header>
				<script>
					$(document).ready(function(){
						var isRoomSelected = false;
						var isDateSelected = false;
						var isTimeSelected = true;
						var selectedRoom = ''; // 선택한 회의실을 저장할 변수
						var selectedDate = ''; // 선택한 날짜를 저장할 변수
						var timeSlots = $('.input'); // 시간 슬롯 요소들
						// console.log(selectedRoom);
						// console.log(timeSlots[0].innerText); // AM 09:00
						// console.log("${room_id}");
						
						// 전체보기인지 개별보기인지에 따라 호실 변수 지정
						if ("${room_id}" == null || "${room_id}" == '') {
							selectedRoom = document.querySelector('[name="room_id"]').value;
						} else {
							selectedRoom = "${room_id}";
						}
						// console.log(selectedRoom)
	
						$('.datepicker').datepicker({
							format: 'yyyy-mm-dd',
							autoclose: true,
							startDate: '0d'
						});
						
						if(selectedRoom !== "") isRoomSelected = true;
						
						// 회의실 선택 부분 js
						$('#room_id').change(function() {
							selectedRoom = $(this).val(); // 선택한 회의실 저장
							isRoomSelected = true;
							enableTimeSlots(); // 시간 슬롯 활성화 함수 호출
						});

						// 날짜 선택 부분 js
						$('#dp1').click(function () {
							if (!isRoomSelected) {
							    alert("회의실을 먼저 선택하세요.");
							    return; // 회의실 선택 전에는 클릭 이벤트 무시
							}
							
							$('#dp1').datepicker().on('changeDate', function() {
								
								selectedDate = $(this).val(); // 선택한 날짜 저장
							    
								if (selectedDate !== '') {
									isDateSelected = true;
									enableTimeSlots(); // 시간 슬롯 활성화 함수 호출
									checkTimeSlots(); // 예약되어있는 시간 슬롯 비활성화하는 함수 호출
								} else {
									isDateSelected = false;
									disableTimeSlots(); // 시간 슬롯 비활성화 함수 호출
								}
							})
						})
						
						// 회의실 예약 확인 모달창 부분
						$('.input').click(function(){
							if (!isDateSelected) {
							    alert("날짜를 먼저 선택하세요.");
							    return; // 날짜나 회의실 선택 전에는 클릭 이벤트 무시
							}
							console.log("시간버튼 선택완료");
					
							var selectedTime = $(this).val();
							// console.log(selectedTime);
							$('#selectedDate').text(selectedDate);
							$('#selectedTime').text(selectedTime);
							$('#selectedRoom').text(selectedRoom);
							$('#selectedDateInput').val(selectedDate); // 폼 데이터에 선택한 날짜 설정
							$('#selectedTimeInput').val(selectedTime); // 폼 데이터에 선택한 시간 설정
							$('#selectedRoomInput').val(selectedRoom); // 폼 데이터에 선택한 회의실 설정
							$('#timeModal').modal('show');
						});
						
						// 시간 슬롯을 활성화하는 함수
						function enableTimeSlots() {
							timeSlots.removeAttr('disabled');
						}
						
						// 시간 슬롯을 비활성화하는 함수
						function disableTimeSlots() {
							timeSlots.attr('disabled');
						}
						
						// 예약되어있는 시간인지 확인하고 예약되어 있으면 비활성화하는 함수
						function checkTimeSlots() {
							// console.log(selectedRoom, selectedDate, timeSlots[0].innerText);
							for (var i = 0; i < timeSlots.length; i++) {
								console.log(timeSlots[i].value);
								let a = -1;
								$.ajax({
									type : "POST",
									url : 'oneMeeting',
									async: false,
									data: {
										'room_id': selectedRoom,
										'meetingDate': selectedDate,
										'meetingTime': timeSlots[i].value,
									},
									success : function (data, status) {
										var timeSlots = $('.input');
										console.log('요청 성공');
										// console.log(data);
										if (data != null && data != '') {
											if (data == timeSlots[i].value) {
												console.log('값이 같은거 성공');
												timeSlots.eq(i).attr('disabled', 'disabled');
											}
										}
									},
									error : function (status) {
										console.log('응답 실패');
									}
								});
							}
						}
					});
				</script>
				<!-- 섹션에 모달을 위한 필요한 HTML 코드 -->
				<!-- 팝업창 -->
				<div class="modal fade" id="timeModal" tabindex="-1" role="dialog"
					aria-labelledby="timeModalLabel" aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h3 class="modal-title" id="timeModalLabel">
									<c:if test="${room_id != null && room_id != ''}">${room_id}호 </c:if>
									회의실 예약 확인
								</h3>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<p>
									회의실: <span id="selectedRoom"></span>호
								</p>
								<p>
									예약일자: <span id="selectedDate"></span>
								</p>
								<p>
									예약시간: <span id="selectedTime"></span>
								</p>
								<p>
									부서: ${mvo.team}
								</p>
								<div class="modal-footer">
									<div>
										<!-- 예약 정보를 서버로 전송하는 폼 -->
										<form autocomplete="off" action="submitreservation" 
											method="post" id="reservationForm" style="margin: 0;">
											<input type="hidden" id="selectedDateInput" name="meetingDate"> 
											<input type="hidden" id="selectedTimeInput" name="meetingTime">
											<input type="hidden" id="selectedRoomInput" name="room_id"> <!-- 추가: 선택한 회의실 정보 -->
											<button type="submit" class="btn btn-secondary"
												style="height: 35px;">예약하기</button>
											<c:if test="${not empty room_id}">
												<input type="hidden" value="${room_id}" name="room_id">
											</c:if>
											<input type="hidden" value="${mvo.cnum}" name="cnum"/>
											<input type="hidden" value="${mvo.name}" name="user_Name">
											<input type="hidden" value="${mvo.team}" name="team"> 
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 표시되는 부분 -->
				<div class="container-fluid px-0 px-sm-4 mx-auto">
					<div class="row justify-content-center mx-0">
						<div class="col-lg-10">
							<div class="card border-0">
								<!-- <form autocomplete="off"> -->
									<div class="card-header bg-dark" align="center">
										<c:if test="${empty room_id}">
											<span style="font-size: 30px; color: white; padding-left: 0px;">회의실 예약하기</span>
											<select id="room_id" name="room_id" class="form-control" style="width: 600px; height: 45px; margin-bottom: 1em;">
												<option value="">회의실 선택</option>
												<option value="101">101호 회의실</option>
												<option value="102">102호 회의실</option>
												<option value="103">103호 회의실</option>
											</select>
										</c:if>
										<c:if test="${room_id != null && room_id != ''}">
											<span style="font-size: 25px; color: white; padding-left: 0px;">
												${room_id}호 회의실 예약하기
											</span>
										<br/>
										</c:if>
										<div class="mx-0 mb-0 row justify-content-sm-center justify-content-start px-1">
											<input type="text" id="dp1" class="datepicker" placeholder="Pick Date" name="date" readonly="readonly"
												style="width: 400px; height: 45px; text-align: center; cursor: pointer;">
											<label for="dp1" style="padding-right: 0px; cursor: pointer;">
												<span class="fa fa-calendar" style="padding-left: 10px;"></span>
											</label>
										</div>
									</div>
									<div class="card-body p-3 p-sm-5">
										<div class="row text-center mx-0">
											<div class="col-md-4 col-6 my-1 px-2">
												<div class="cell py-1">
													<input type="button" class="input py-2" value="AM 09:00">
												</div>
											</div>
											<div class="col-md-4 col-6 my-1 px-2">
												<div class="cell py-1">
													<input type="button" class="input py-2" value="AM 10:00"/>
												</div>
											</div>
											<div class="col-md-4 col-6 my-1 px-2">
												<div class="cell py-1">
													<input type="button" class="input py-2" value="AM 11:00"/>
												</div>
											</div>
										</div>
										<div class="row text-center mx-0">
											<div class="col-md-4 col-6 my-1 px-2">
												<div class="cell py-1">
													<input type="button" class="input py-2" value="PM 12:00"/>
												</div>
											</div>
											<div class="col-md-4 col-6 my-1 px-2">
												<div class="cell py-1">
													<input type="button" class="input py-2" value="PM 13:00"/>
												</div>
											</div>
											<div class="col-md-4 col-6 my-1 px-2">
												<div class="cell py-1">
													<input type="button" class="input py-2" value="PM 14:00"/>
												</div>
											</div>
										</div>
										<div class="row text-center mx-0">
											<div class="col-md-4 col-6 my-1 px-2">
												<div class="cell py-1">
													<input type="button" class="input py-2" value="PM 15:00"/>
												</div>
											</div>
											<div class="col-md-4 col-6 my-1 px-2">
												<div class="cell py-1">
													<input type="button" class="input py-2" value="PM 16:00"/>
												</div>
											</div>
											<div class="col-md-4 col-6 my-1 px-2">
												<div class="cell py-1">
													<input type="button" class="input py-2" value="PM 17:00"/>
												</div>
											</div>
										</div>
										<div class="row text-center mx-0">
											<div class="col-md-4 col-6 my-1 px-2">
												<div class="cell py-1">
													<input type="button" class="input py-2" value="PM 18:00"/>
												</div>
											</div>
										</div>
									</div>
								<!-- </form> -->
							</div>
						</div>
					</div>
				</div>
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
	</div><!-- <div id="wrapper"> -->
	

	<!-- Scripts -->
	<!-- <script src="js/jquery.min.js"></script> -->
	<script src="js/browser.min.js"></script>
	<script src="js/breakpoints.min.js"></script>
	<script src="js/util.js"></script>
	<script src="js/menu.js"></script>
	
</body>
</html>