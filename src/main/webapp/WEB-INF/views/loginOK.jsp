<%@page import="com.tjoeun.vo.MainVO"%>
<%@page import="javax.swing.text.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginOK</title>
</head>
<body>

<%
	
	request.setCharacterEncoding("UTF-8");
	
	// 입력받은 사원번호, 비밀번호 변수 설정
	int inserted_cnum = '\0';
	String inserted_password = "";
	String error = "";
	
	// 예외가 이미 발생했는지에 대한 flag 변수 설정
	boolean flag = false;
	
	// 사원번호 입력 받고, 빈 칸일 때의 Exception 처리
	try {
		inserted_cnum = Integer.parseInt(request.getParameter("cnum"));
		inserted_password = request.getParameter("password");
	} catch ( NumberFormatException e ) {
		out.println("<script>");
		error = "사원 번호를 입력해주세요.";
		session.setAttribute("error", error);
		flag = true;
		
		out.println("location.href='login'");
		out.println("</script>");
	}

	MainVO mvo = (MainVO) request.getAttribute("mainVO");
	out.println(mvo);
	
	// 비밀번호가 비어있을 경우
	if ( inserted_password.isEmpty() && !flag ) {
		out.println("<script>");
		error = "비밀번호를 입력해주세요.";
		session.setAttribute("error", error);
		flag = true;
		
		out.println("location.href='login'");
		out.println("</script>");
	}
	
	// DB에서 불러온 데이터 없을 경우 ( 넣은 사원번호가 null 아니고, 비번 null 아니고, vo가 null 일 경우 )
	else if ( inserted_cnum != '\0' && inserted_password != null && mvo == null && !flag ) {
		out.println("<script>");
		error = "존재하지 않는 아이디입니다.";
		session.setAttribute("error", error);
		flag = true;
		
		out.println("location.href='login'");
		out.println("</script>");
	}  

	// vo가 비어있을 경우
	else if ( mvo == null ) {
		out.println("<script>");
		error = "아이디를 입력해주세요.";
		session.setAttribute("error", error);
		flag = true;
		
		out.println("location.href='login'");
		out.println("</script>");
	}
	
	else if ( !mvo.getPassword().equals(inserted_password) && !flag ) {
		out.println("<script>");
		error = "비밀번호가 일치하지 않습니다.";
		session.setAttribute("error", error);
		flag = true;
		
		out.println("location.href='login'");
		out.println("</script>");
	} 

	if ( !flag ){
		session.setAttribute("mvo", mvo);
		response.sendRedirect("main");
	} else if ( flag ) {
		response.sendRedirect("login");
	}
         
%>

</body>
</html>