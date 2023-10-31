
function scheduleSelect() {
	console.log('날짜 선택 버튼 클릭');
	var year = $("#year").val();
	var month = $("#month").val();
//	console.log(year, month);
	location.assign('ScheduleView?year='+ year+ '&month=' + month)
};

function scheduleOpen() {
	console.log('일정 추가 버튼 클릭');
	$(".normal_move_board_modal").show();
};

/* 일정 제목 클릭했을 때 */
$(document).ready(function(){
    $(".date_subject").click(function(){
		console.log('일정 확인 버튼 클릭');
		var idx = $(this).data('idx');
		var num = $(this).data('num');
		var date = $(this).data('date');
		var subject = $(this).data('subject');
		var desc = $(this).data('desc');
	    $("#schedule_idx").val(idx);
	    $("#orginScheduleNum").val(num);
	    $("#schedule_num").val(num);
	    $("#schedule_date").val(date);
	    $("#schedule_subject").val(subject);
	    $("#schedule_desc").html(desc);
        $(".normal_move_board_modal_check").show();
    });
});

/* 일정 등록 모달창 데이터피커 날짜 선택 */
$(function() {
    $( "#testDatepicker" ).datepicker({
        dateFormat: "yy-mm-dd",
    	changeMonth: true, 
        changeYear: true,
        dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
        monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12']
    });
});

/* 일정 확인 모달창 데이터피커 날짜 선택 */
$(function() {
    $( "#schedule_date" ).datepicker({
        dateFormat: "yy-mm-dd",
    	changeMonth: true, 
        changeYear: true,
        dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
        monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12']
    });
});

/* 일정 등록 */
function scheduleAdd(){
	var schedule_add_form = document.schedule_add;
	if(schedule_add_form.schedule_num.value == "" || schedule_add_form.schedule_num.value == null){
		alert("순번을 입력해주세요.");
		schedule_add_form.schedule_num.focus();
		return false;
	}else if(schedule_add_form.schedule_date.value==""||schedule_add_form.schedule_date.value==null){
		alert("날짜를 입력해주세요.");
		schedule_add_form.schedule_date.focus();
		return false;
	} else if(schedule_add_form.schedule_subject.value==""||schedule_add_form.schedule_subject.value==null){
		alert("제목을 입력해주세요.");
		schedule_add_form.schedule_subject.focus();
		return false;
	} else if(schedule_add_form.schedule_desc.value == "" || schedule_add_form.schedule_desc.value == null){
		alert("내용을 입력해주세요.");
		schedule_add_form.schedule_desc.focus();
		return false;
	} 
	schedule_add_form.submit();
};

/* 일정 수정 */
function scheduleUpdate(){
	var schedule_update_form = document.schedule_update;
	if(schedule_update_form.schedule_num.value == "" || schedule_update_form.schedule_num.value == null){
		alert("순번을 입력해주세요.");
		schedule_update_form.schedule_num.focus();
		return false;
	}else if(schedule_update_form.schedule_date.value=="" || schedule_update_form.schedule_date.value==null){
		alert("날짜를 입력해주세요.");
		schedule_update_form.schedule_date.focus();
		return false;
	} else if(schedule_update_form.schedule_subject.value==""||schedule_update_form.schedule_subject.value==null){
		alert("제목을 입력해주세요.");
		schedule_update_form.schedule_date.focus();
		return false;
	} else if(schedule_update_form.schedule_desc.value == "" || schedule_update_form.schedule_desc.value == null){
		alert("내용을 입력해주세요.");
		schedule_add_form.schedule_desc.focus();
		return false;
	} 
	schedule_update_form.submit();
};

/* 일정 삭제 */
function scheduleDelete() {
	console.log('scheduleDelete() 메소드 실행');
	var schedule_idx = $("#schedule_idx").val();
	var schedule_num = $("#schedule_num").val();
	var schedule_date = $("#schedule_date").val();
	var schedule_subject = $("#schedule_subject").val().trim();
	var schedule_desc = $("#schedule_desc").val().trim();
	console.log(schedule_num, schedule_date, schedule_subject, schedule_desc);
	var scheduleDelete_url = 'scheduleDelete';
	$.ajax({
		type : "POST",  // ★필수★, 서버에 데이터를 요청하는 방식
		url : scheduleDelete_url, // ★필수★, 호출할 페이지 주소(요청) 또는 읽어올 xml 파일명
		asyn: true, // ★필수★, 비동기 방식 사용 여부(false는 동기 방식)
		data: { // method가 post로 지정된 경우 서버로 전송할 데이터 목록
			'schedule_idx': schedule_idx,
			'schedule_num': schedule_num,
			'schedule_date': schedule_date,
			'schedule_subject': schedule_subject,
			'schedule_desc': schedule_desc
		},
		// success는 Ajax 요청이 성공했을 때 실행할 콜백 함수
		// Ajax 요청이 성공하면 응답받는 데이터가 콜백 함수의 인수로 넘어온다.
		success : function (data, status) {
			alert("스케줄이 삭제되었습니다.");
			location.reload();
		},
		error : function (status) {
			alert("스케줄 삭제 실패");
		}
	});
};

function scheduleClose() {
	console.log('닫기 버튼 클릭');
	$(".normal_move_board_modal").hide();
	$(".normal_move_board_modal_check").hide();
};