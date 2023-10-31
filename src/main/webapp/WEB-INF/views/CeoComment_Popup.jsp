<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재 확인 팝업창</title>
<link rel="stylesheet" href="css/main.css"/>
<style type="text/css">
	#header { /* 맨 위의 띄어진 부분 */
		padding-top: 3em;
	}
	table tr th { /* 제일 큰 글씨 */
		font-size: 30px; 
		text-align:center; 
		padding-top: 0.6em;
	}
	table { /* 테이블 */
		width: 700px; 
		margin-left: auto; 
		margin-right: auto;
	}
	label { /* 반려 사유 */
		font-weight: 300;
	}
	.actions .button { /* 버튼들 */
		width: 80px;
		font-size: 13px;
		border: none;
		margin-left: 5px;
	}
</style>
<script type="text/javascript">
	function commentSave(){
		var reasonForm = document.reason_form;
		if(reasonForm.reason.value == "" || reasonForm.reason.value == null){
			alert("반려 사유를 입력해주세요.");
			reasonForm.reason.focus();
			return false;
		}
		reasonForm.submit();
	};
	
	function closePopup() {
		window.close();
	}

</script>
</head>
<body class="is-preload">
	<div id="wrapper">
		<div id="main">
			<div class="inner">
				<!-- Header -->
				<header id="header">
				</header>
				<!-- 코멘트 -->
				<form name="reason_form" action="CeoCommentSend" method="post">
					<table>
						<tr style="border-bottom: none;">
							<th>반려 사유 입력</th>
						</tr>
						<tr style="border-top: none; border-bottom: none;">
							<td>
								<textarea id="reason" name="reason"
									style="height: 150px; resize: none; padding: 5px;">${co.reason}</textarea>
							</td>
						</tr>
						<tr class="actions" style="border-top: none; border-bottom: none;">
							<td align="right">
								<!-- 코멘트 저장 -->
								<input class="button big" type="button" id="button" value="코멘트 저장" onclick="commentSave()"/>
								<input class="button big" type="reset" value="다시 쓰기"/>
								<!-- 그냥 창 닫기 -->
								<input class="button big" type="button" value="닫기" onclick="closePopup()"/>
							</td>
						</tr>
						<tr style="display: none;">
						<!-- <tr> -->
							<td colspan="4">
								idx: <input type="text" name="idx" value="${co.idx}" size="1"/>&nbsp;
								status: <input type="text" name="status" value="${co.status}" size="1"/>&nbsp;
								currentPage: <input type="text" name="currentPage" value="${currentPage}" size="1"/>&nbsp;
							</td>
						</tr>
					</table>
				</form>
			</div> <!-- <div class="inner"> -->
		</div> <!-- <div id="main"> -->
	</div> <!-- <div id="wrapper"> -->
</body>
</html>