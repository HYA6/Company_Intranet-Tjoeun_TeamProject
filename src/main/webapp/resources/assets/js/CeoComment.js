function comment() { /* 밑에 코멘트 입력 부분이 나오는 메소드 */
	document.getElementsByTagName('div')[1].style.display = '';
}
function closeComment() { /* 밑에 코멘트 입력 부분을 안보이게 만드는 메소드 */
	document.getElementsByTagName('div')[1].style.display = 'none';
}

function reasonComment() { /* 입력,수정하기 위해 코멘트 팝업창(CeoComment_Popup.jsp)으로 넘어가는 메소드 */
	console.log('reason() 메소드 실행');
	let idx = document.getElementsByName('idx')[0].value;
	let status = document.getElementsByName('status')[0].value;
	let currentPage = document.getElementsByName('currentPage')[0].value;
	let reason = document.getElementsByName('reason')[0].value;
	let url = 'CeoComment_Popup?idx=' + idx + '&status=' + status + '&currentPage' + currentPage + '&reason' + reason;
	let title = '코멘트 팝업창';
	let option = 'top=50px, left=100px, width=1000px, height=600px';
	window.open(url, title, option);
}