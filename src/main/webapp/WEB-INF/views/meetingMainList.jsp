<%@page import="com.tjoeun.vo.MeetingRoomList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title> 
</head>
<body>

<%
request.setCharacterEncoding("UTF-8");

// 메인에 표시할 당일 예약환황 
MeetingRoomList meetingRoomList = (MeetingRoomList) request.getAttribute("mainMeetingList");
session.setAttribute("mainMeetingList", meetingRoomList);
response.sendRedirect("main");

%>

</body>
</html>