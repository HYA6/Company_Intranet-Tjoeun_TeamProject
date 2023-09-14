<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.tjoeun.dao.AttendanceDAO"%>
<%@page import="com.tjoeun.vo.AttendanceVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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

	int cnum = Integer.parseInt(request.getParameter("cnum"));
	int flag = Integer.parseInt(request.getParameter("flag"));
	String Atten_Check = (String)request.getAttribute("Atten_check");
	String Leave_Check = (String)request.getAttribute("Leave_check");
	AttendanceVO ao = (AttendanceVO)request.getAttribute("ao");
	
//	out.println(ao);
//	out.println(Atten_Check + " and " + Leave_Check);
//	out.println(cnum + " and " + flag);

	// 출근 버튼
 	if ( Atten_Check != null && flag == 1 ) {
		out.println("<script>");
		out.println("alert('출근 되어있음')");
		out.println("location.href='main'");
		out.println("</script>");
	} else if ( flag == 1 ) {
		out.println("<script>");
		out.println("alert('출근 완료')");

		out.println("location.href='attendance_Atten'");
		out.println("</script>");
	}
	
 	// 퇴근 버튼
	if ( Leave_Check != null && flag == 2 ) {
		out.println("<script>");
		out.println("alert('퇴근 되어있음')");
		out.println("location.href='main'");
		out.println("</script>");
	} else if ( Atten_Check != null && Leave_Check == null && flag == 2 ) {
		out.println("<script>");
		out.println("alert('퇴근 완료')");
		
		out.println("location.href='attendance_Leave?worktime=" + ao.getWorktime() + "&hometime=" + ao.getHometime() + "'");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('출근 체크 안함')");
		out.println("location.href='main'");
		out.println("</script>");
	}    
%>

</body>
</html>