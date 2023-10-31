<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
<title>캘린더</title>
<!-- jquery datepicker -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<!-- jquery datepicker 끝 -->
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link href="css/main.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/Schedule.js"></script>
<style TYPE="text/css">
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
	
	body {
		scrollbar-face-color: #F6F6F6;
		scrollbar-highlight-color: #bbbbbb;
		scrollbar-3dlight-color: #FFFFFF;
		scrollbar-shadow-color: #bbbbbb;
		scrollbar-darkshadow-color: #FFFFFF;
		scrollbar-track-color: #FFFFFF;
		scrollbar-arrow-color: #bbbbbb;
		margin-left:"0px"; margin-right:"0px"; margin-top:"0px"; margin-bottom:"0px";
	}

	.day{ /* 요일 */
		width:100px; 
		height:30px;
		font-weight: bold;
		font-size:15px;
		font-weight:bold;
		text-align: center;
	}
	.sat{ /* 토요일 */
		color:#529dbc;
	}
	.sun{ /* 일요일 */
		color: #f56a6a;
	}
	.calendar{ /* 날짜 네비게이션 첫 div */
		width:80%;
		margin:auto;
	}
	.navigation{ /* 날짜 네비게이션 두번째 div */
		margin-top:20px;
		margin-bottom:30px;
		text-align: center;
		font-size: 25px;
		vertical-align: middle;
	}
	.before_after_month{ /* 이전달, 다음달 */
		margin: 10px;
		font-weight: bold;
	}
	.before_after_year{ /* 이전해, 다음해 */
		font-weight: bold;
	}
	.this_month{ /* 이번달 */
		margin: 10px;
	}
	.calendar_body{ /* 요일, 날짜 출력 부분 */
		width:100%;
		background-color: #FFFFFF;
		border:1px solid white;
		margin-bottom: 50px;
		border-collapse: collapse;
	}
	.calendar_body .today{ /* 오늘 날짜 */
		border:1px solid white;
		height:120px;
		background-color:#c9c9c9;
		text-align: left;
		vertical-align: top;
	}
	.calendar_body .date{ /* 일반 날짜 */
		font-size: 15px;
		padding-left: 3px;
		padding-top: 3px;
	}
	.date{ /* 일반 날짜 모두 */
		margin-bottom:10px;
	}
	.sat{ /* 토요일 */
		margin-bottom:10px;
	}
	.sun{ /* 일요일 */
		margin-bottom:10px;
	}
	.holiday{ /* 공휴일 */
		margin-bottom:10px;
	}
	.calendar_body .sat_day{ /* 토요일 */
		border:1px solid white;
		height:120px;
		background-color:#EFEFEF;
		text-align:left;
		vertical-align: top;
	}
	.calendar_body .sat_day .sat{ /* 토요일의 div */
		color: #529dbc; 
		width: 0.5em !important;
		font-size: 15px;
		padding-left: 3px;
		padding-top: 3px;
	}
	.calendar_body .sun_day{ /* 일요일 */
		border:1px solid white;
		height:120px;
		background-color:#EFEFEF;
		text-align: left;
		vertical-align: top;
	}
	.calendar_body .sun_day .sun{ /* 일요일의 div */
		color: #f56a6a; 
		width: 0.5em !important;
		font-size: 15px;
		padding-left: 3px;
		padding-top: 3px;
	}
	.calendar_body .holiday_day{ /* 공휴일 */
		border:1px solid white;
		height:120px;
		background-color:#EFEFEF;
		text-align: left;
		vertical-align: top;
	}
	.calendar_body .holiday_day .holiday{ /* 공휴일의 div */
		color: #f56a6a; 
		width: 7em !important;
		font-size: 15px;
		padding-left: 3px;
		padding-top: 3px;
	}
	.calendar_body .normal_day{ /* 일반 날짜 */
		border:1px solid white;
		width: 0.5em !important;
		height:120px;
		background-color:#EFEFEF;
		vertical-align: top;
		text-align: left;
	}
	.calendar_body .today_content{ /* 오늘+공휴일 내용 */
	    color: #f56a6a;
	    width: 6em !important;
		font-size: 13px;
		padding-left: 3px;
		padding-top: 3px;
	}
	.calendar_body .holiday_content{ /* 공휴일 내용 */
	    color: #f56a6a;
	    width: 6em !important;
		font-size: 13px;
		padding-left: 3px;
		padding-top: 3px;
	}
	.date_subject{ /* 제목 */
		display: inline-block;
		width: 10em;
		color: #3d4449;
		font-size:13px; 
		text-align: left;
		overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        line-height: 1.2;
		margin:0px; 
		margin-bottom:5px; 
		margin-left:12px; 
	}
	fieldset { /* 스케줄 날짜 선택 부분 */
		display: inline;
	}
	.schudule_button_tr .schudule_select1 { /* 스케줄 날짜 선택1 */
		width: 7em;
		height: 2em;
		display: inline-block;
	}
	.schudule_button_tr .schudule_select2 { /* 스케줄 날짜 선택2 */
		width: 5.5em;
		height: 2em;
		display: inline-block;
	}
	.schudule_button_tr .schudule_select_button { /* 스케줄 날짜 보기 버튼 */
		width: 50px;
		height: 25px;
		border: none;
		background-color: #f56a6a;
		color: white;
		margin-left: 10px;
	}
	.schudule_button_tr .schudule_select_button:hover { /* 스케줄 날짜 보기 버튼 */
		width: 50px;
		height: 25px;
		border: none;
		background-color: #f56a6a;
		color: white;
		margin-left: 10px;
	}
	.schudule_button_tr { /* 일정 추가 버튼 tr */
		border-bottom: none;
		text-align: right;
	}
	.schudule_button_tr .board_move { /* 일정 추가 버튼 */
		width: 80px;
		height: 30px;
		border: none;
		background-color: #f56a6a;
		color: white;
	}
	/* 게시판 이동 모달 - 스케줄 등록 */
	.normal_move_board_modal { /* 가장 밖 div */
		display: none;
		position: fixed;
		z-index: 10000;
		left: 42% !important;
		top: 30% !important;
		margin-left: -250px !important;
		margin-top: -100px !important;
		width: 50% !important;
		height: 37em !important;
		border-radius: 12px !important;
		background-color: white !important;
	}
	
	.normal_move_board_modal .top{ /* 스케줄 등록 */
		background-color: #3d4449; 
		width:100%; 
		height:13%; 
		border-radius:12px 12px 0px 0px;
	}
	
	.normal_move_board_modal .top .subject{ /* 스케줄 등록 */
		float:left;
		margin-left:10px;
		margin-top:20px;
		font-size:20px;
		font-weight:bold;
		color:white;
		padding-left: 20px;
	}
	
	.normal_move_board_modal .bottom{ /* 본문 내용 */
		width:100%; 
		height:15%; 
		vertical-align: middle;
	}
	
	.normal_move_board_modal .bottom .info{ /* 안내 부분 <div class="info"> */
		padding: 10px 15px 0px 15px;
	    text-align: left;
	    font-size: 12px;
	    color: red;
	    margin-left: 50px;
	}
	
	.normal_move_board_modal .bottom .contents{ /* 입력 부분 <div class="contents"> */
		margin:20px 50px 20px 50px;
		text-align: center;
	}
	.normal_move_board_modal ul{ /* ul 부분 */
	    padding: 0;
	    margin: 0;
	    list-style: none;
	}
	.normal_move_board_modal ul li{ /* li 부분 */
	    text-align: left;
	    padding: 5px;
	    height: 30px;
	}
	.normal_move_board_modal ul li .text_subject{ /* 순번, 날짜, 제목, 내용 */
        width: 10%;
	    height: 100%;
	    float: left;
	    font-size: 18px;
	    vertical-align: middle;
	    margin-top: 3px;
	}
	.normal_move_board_modal ul li .text_desc{ /* 순번, 날짜, 제목 입력 부분 div */
		height:25px;
		width:90%;
		float: left;
	}
	.normal_move_board_modal ul li .text_area_desc{ /* 내용 입력 부분 div */
		width:90%;
		float: left;
	}
	.normal_move_board_modal ul li .text_type1{ /* 제목 입력 부분 input */
		height: 100% !important;
   		width: 100%;
	}
	.normal_move_board_modal ul li .textarea_type1{ /* 내용 입력 부분 textarea */
   		width: 100%;
   		font-size:18px;
	}
	.normal_move_board_modal ul .button_li{ /* 버튼 부분 */
   		width: 100%;
		padding-top: 130px;
		text-align: right;
	}
	.normal_move_board_modal .bottom .contents .board_move_go { /* 버튼들 */
		border: none;
	    height: 30px;
	    font-size: 13px;
	    background-color: gray;
	    color: white;
		margin-top: 10px;
	}
	/* 게시판 이동 모달 - 스케줄 확인 */
	.normal_move_board_modal_check { /* 가장 밖 div */
		display: none;
		position: fixed;
		z-index: 10000;
		left: 42% !important;
		top: 30% !important;
		margin-left: -250px !important;
		margin-top: -100px !important;
		width: 50% !important;
		height: 35em !important;
		border-radius: 12px !important;
		background-color: white !important;
	}
	
	.normal_move_board_modal_check .top{ /* 스케줄 확인 */
		background-color: #3d4449; 
		width:100%; height:13%; 
		border-radius:12px 12px 0px 0px;
	}
	
	.normal_move_board_modal_check .top .subject{ /* 스케줄 확인 */
		float:left;
		margin-left:10px;
		margin-top:20px;
		font-size:20px;
		font-weight:bold;
		color:white;
		padding-left: 20px;
	}
	
	.normal_move_board_modal_check .bottom{ /* 본문 내용 */
		width:100%; 
		height:15%; 
		vertical-align: middle;
	}
	
	.normal_move_board_modal_check .bottom .info{ /* 안내 부분 <div class="info"> */
		padding: 10px 15px 0px 15px;
	    text-align: left;
	    font-size: 12px;
	    color: red;
	    margin-left: 50px;
	}
	
	.normal_move_board_modal_check .bottom .contents{ /* 입력 부분 <div class="contents"> */
		margin:20px 50px 20px 50px;
		text-align: center;
	}
	.normal_move_board_modal_check ul{ /* ul 부분 */
	    padding: 0;
	    margin: 0;
	    list-style: none;
	}
	.normal_move_board_modal_check ul li{ /* li 부분 */
	    text-align: left;
	    padding: 5px;
	    height: 30px;
	}
	.normal_move_board_modal_check ul li .text_subject{ /* 순번, 날짜, 제목, 내용 */
        width: 10%;
	    height: 100%;
	    float: left;
	    font-size: 18px;
	    vertical-align: middle;
	    margin-top: 3px;
	}
	.normal_move_board_modal_check ul li .text_desc{ /* 순번, 날짜, 제목 입력 부분 div */
		height:25px;
		width:90%;
		float: left;
	}
	.normal_move_board_modal_check ul li .text_area_desc{ /* 내용 입력 부분 div */
		width:90%;
		float: left;
	}
	.normal_move_board_modal_check ul li .text_type1{ /* 제목 입력 부분 input */
		height: 100% !important;
   		width: 100%;
	}
	.normal_move_board_modal_check ul li .textarea_type1{ /* 내용 입력 부분 textarea */
   		width: 100%;
   		font-size:18px;
	}
	.normal_move_board_modal_check ul .button_li{ /* 버튼 부분 */
   		width: 100%;
		padding-top: 130px;
		text-align: right;
	}
	.normal_move_board_modal_check .bottom .contents .board_move_go { /* 버튼들 */
		border: none;
	    height: 30px;
	    font-size: 13px;
	    background-color: gray;
	    color: white;
		margin-top: 10px;
	}
	/* 모달창의 날짜 선택 부분 */
	.ui-datepicker select.ui-datepicker-month, .ui-datepicker select.ui-datepicker-year {
		display: inline-block;
	}
	.ui-datepicker {
		width: 20em;
	}
	#menu ul li { /* Sidebar의 menu들 */
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
				<form name="calendarFrm" id="calendarFrm" action="" method="post">
					<input type="hidden" name="year" value="${today_info.search_year}" />
					<input type="hidden" name="month" value="${today_info.search_month}" />
					<script>
						var message = "${message}";
						console.log(message);
						if(message!=""){
							alert(message);
						}
					</script>
					<div class="calendar" >
						<!--날짜 네비게이션  -->
						<div class="navigation">
							<!-- 이전해 -->
							<a class="before_after_year" href="ScheduleView?year=${today_info.before_year}&month=${today_info.search_month}">
								&lt;&lt;
							</a> 
							<!-- 1월이 아닐 경우 이전달 -->
							<c:if test="${today_info.search_month != 1}">
								<a class="before_after_month" href="ScheduleView?year=${today_info.search_year}&month=${today_info.before_month}">
									&lt;
								</a> 
							</c:if>
							<!-- 1월일 경우 이전달 -->
							<c:if test="${today_info.search_month == 1}">
								<a class="before_after_month" href="ScheduleView?year=${today_info.before_year}&month=${today_info.before_month}">
									&lt;
								</a> 
							</c:if>
							<span class="this_month">
								&nbsp;${today_info.search_year}. 
								<c:if test="${today_info.search_month<10}">0</c:if>${today_info.search_month}
							</span>
							<!-- 12월이 아닐 경우 다음달 -->
							<c:if test="${today_info.search_month != 12}">
								<a class="before_after_month" href="ScheduleView?year=${today_info.search_year}&month=${today_info.after_month}">
									&gt;
								</a>
							</c:if>
							<!-- 12월일 경우 다음달 -->
							<c:if test="${today_info.search_month == 12}">
								<a class="before_after_month" href="ScheduleView?year=${today_info.after_year}&month=${today_info.after_month}">
									&gt;
								</a>
							</c:if>
							<!-- 다음해 -->
							<a class="before_after_year" href="ScheduleView?year=${today_info.after_year}&month=${today_info.search_month}">
								&gt;&gt;
							</a>
						</div>
					</div>
					<table class="calendar_body">
						<!-- 요일 출력 -->
						<thead>
							<tr bgcolor="#CECECE">
								<td class="day sun">일</td>
								<td class="day">월</td>
								<td class="day">화</td>
								<td class="day">수</td>
								<td class="day">목</td>
								<td class="day">금</td>
								<td class="day sat">토</td>
							</tr>
						</thead>
						<!-- 날짜 출력 -->
						<tbody>
							<tr>
								<c:forEach var="dateList" items="${dateList}" varStatus="date_status"> 
									<c:choose>
										<c:when test="${dateList.value=='today'}">
											<c:if test="${date_status.index%7==0}">
												<tr>
											</c:if>
											<td class="today">
												<div class="date">
										</c:when>
										<c:when test="${dateList.value=='holiday'}">
											<c:if test="${date_status.index%7==0}">
												<tr>
											</c:if>
											<td class="holiday_day">
												<div class="holiday">
										</c:when>
										<c:when test="${date_status.index%7==6}">
											<td class="sat_day">
												<div class="sat">
										</c:when>	
										<c:when test="${date_status.index%7==0}">
											</tr>
											<tr>	
											<td class="sun_day">
												<div class="sun">
										</c:when>
										<c:otherwise>
											<td class="normal_day">
												<div class="date">
										</c:otherwise>
									</c:choose>
											${dateList.date} <!-- 날짜^^ -->
											<c:if test="${dateList.value=='holiday'}">
												<span class="holiday_content">${dateList.holiday}</span>
											</c:if>
											<c:if test="${dateList.holiday ne 'null' && dateList.value=='today'}">
												<span class="today_content">${dateList.holiday}</span>
											</c:if>
										</div>
										<div>
											<c:forEach var="scheduleList" items="${dateList.schedule_data_arr}" varStatus="schedule_data_arr_status"> 
												<a data-toggle="modal" href="#normal_move_board_modal_check"
													data-idx="${scheduleList.schedule_idx}"
													data-num="${scheduleList.schedule_num}"
													data-date="${scheduleList.schedule_date}"
													data-subject="${scheduleList.schedule_subject}"
													data-desc="${scheduleList.schedule_desc}"
													class="date_subject">${scheduleList.schedule_num}
													<c:if test="${scheduleList.schedule_num != null}">. </c:if>${scheduleList.schedule_subject}</a>
											</c:forEach>
										</div>
									</td>
								</c:forEach>
							</tr>
							<tr class="schudule_button_tr">
								<td id="choice" colspan="2" align="left">
									<fieldset>
										<select class="schudule_select1" id="year">
											<%
												Calendar calendar = Calendar.getInstance();
												for (int i = 1900 ; i <= 2100 ; i++){
													if (i == calendar.get(Calendar.YEAR)) { out.println("<option selected='selected'>" + i + "</option>");
													} else { out.println("<option>" + i + "</option>"); }
												}
											%>
										</select>
										년
									</fieldset>
									<fieldset>
										<select class="schudule_select2" id="month">
											<%
												for (int i = 1 ; i <= 12 ; i++){
													if (i == calendar.get(Calendar.MONTH)+1) { out.println("<option selected='selected'>" + i + "</option>");
													} else { out.println("<option>" + i + "</option>"); }
												}
											%>
										</select>
										월
									</fieldset>
									<input class="schudule_select_button" type="button" onclick="scheduleSelect()" value="보기"/>
								</td>
								<c:if test="${mvo.team == '경영진' || mvo.team == '총무'}">
									<td colspan="5">
										<button type="button" class="board_move openMask_board_move pointer" onclick="scheduleOpen()">일정추가</button>
									</td>
								</c:if>
							</tr>		
						</tbody>
					</table>
				</form>
				<!-- 스케줄 등록 모달 부분 -->
				<div class="normal_move_board_modal">
					<div class="top">
						<div class="subject">
							스케줄 등록
						</div>
					</div>
					<div class="bottom">
						<div class="info">
							* 순번은 중복될 수 없습니다.<br/>
							* 하루에 최대 4개의 스케줄만 등록할 수 있습니다.
						</div>
						<form name="schedule_add" action="scheduleAdd">
							<input type="hidden" name="year" value="${today_info.search_year}" />
							<input type="hidden" name="month" value="${today_info.search_month-1}" />
							<div class="contents">
								<ul>
									<li>
										<div class="text_subject">순번 :</div> 
										<div class="text_desc">
											<input type="text" name="schedule_num"  class="text_type1" />
										</div>
									</li>
									<li>
										<div class="text_subject">날짜 :</div> 
										<div class="text_desc">
											<input type="text" name="schedule_date" class="text_type1" id="testDatepicker" readonly="readonly"/>
										</div>
									</li>
									<li>	
										<div class="text_subject">제목 :</div> 
										<div class="text_desc">
											<input type="text" name="schedule_subject" class="text_type1" />
										</div>
									</li>	
									<li>
										<div class="text_subject">내용 :</div> 
										<div class="text_area_desc">
											<textarea name="schedule_desc" class="textarea_type1" rows="7" style="resize: none;"></textarea>
										</div>
									</li>
									<li class="button_li">
										<button type="button" class="board_move_go pointer" onclick="scheduleAdd();">일정등록</button>
										<button type="button" class="board_move_go pointer" onclick="scheduleClose();">닫기</button>
									</li>
								</ul>
							</div>
						</form>
					</div>
				</div>
				<!-- 스케줄 확인 모달 부분 -->
				<div id="normal_move_board_modal_check" class="normal_move_board_modal_check">
					<div class="top">
						<div class="subject">
							스케줄 확인
						</div>
					</div>
					<div class="bottom">
						<div class="info">
							* 순번은 중복될 수 없습니다.
						</div>
						<form name="schedule_update" action="scheduleUpdate">
							<input type="hidden" id="schedule_idx" name="schedule_idx"/>
							<input type="hidden" name="year" value="${today_info.search_year}"/>
							<input type="hidden" name="month" value="${today_info.search_month-1}"/>
							<input type="hidden" name="orginScheduleNum" id="orginScheduleNum"/>
							<div class="contents">
								<ul>
									<li>
										<div class="text_subject">순번 :</div> 
										<div class="text_desc">
											<input type="text" id="schedule_num" name="schedule_num" class="text_type1"/>
										</div>
									</li>
									<li>
										<div class="text_subject">날짜 :</div> 
										<div class="text_desc">
											<input type="text" id="schedule_date" name="schedule_date" class="text_type1" readonly="readonly"/>
										</div>
									</li>
									<li>	
										<div class="text_subject">제목 :</div> 
										<div class="text_desc">
											<input type="text" id="schedule_subject" name="schedule_subject" class="text_type1"/>
										</div>
									</li>	
									<li>
										<div class="text_subject">내용 :</div> 
										<div class="text_area_desc">
											<textarea id="schedule_desc" name="schedule_desc" class="textarea_type1" rows="7" style="resize: none;"></textarea>
										</div>
									</li>
									<li class="button_li">
										<c:if test="${mvo.team == '총무' || mvo.team == '경영진'}">
											<button type="button" class="board_move_go pointer" onclick="scheduleUpdate()">일정수정</button>
											<button type="button" class="board_move_go pointer" onclick="scheduleDelete()">일정삭제</button>
										</c:if>
										<button type="button" class="board_move_go pointer" onclick="scheduleClose()">닫기</button>
									</li>
								</ul>
							</div>
						</form>
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
	</div>


	<!-- Scripts -->
	<!-- <script src="js/jquery.min.js"></script> -->
	<script src="js/browser.min.js"></script>
	<script src="js/breakpoints.min.js"></script>
	<script src="js/util.js"></script>
	<script src="js/menu.js"></script>
	
</body>
</html>
