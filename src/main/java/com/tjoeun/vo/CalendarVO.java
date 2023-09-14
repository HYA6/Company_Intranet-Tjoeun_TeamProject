package com.tjoeun.vo;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

public class CalendarVO {

	String year = ""; // 스케줄 등록한 년도
	String month = ""; // 스케줄 등록한 월
	String date = ""; // 스케줄 등록한 날짜
	String value = ""; // 스케줄 값
	//추가된 부분
	String db_startDate = ""; // DB 조건문에 쓰일 시작 날짜
	String db_endDate = "";	// DB 조건문에 쓰일 끝 날짜
	String holiday = ""; // 공휴일
	ScheduleDto[] schedule_data_arr = new ScheduleDto[4];

	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}

	//추가된 부분
	public String getDb_startDate() {
		return db_startDate;
	}
	public void setDb_startDate(String db_startDate) {
		this.db_startDate = db_startDate;
	}
	public String getDb_endDate() {
		return db_endDate;
	}
	public void setDb_endDate(String db_endDate) {
		this.db_endDate = db_endDate;
	}
	public String getHoliday() {
		return holiday;
	}
	public void setHoliday(String holiday) {
		this.holiday = holiday;
	}
	public ScheduleDto[] getSchedule_data_arr() {
		return schedule_data_arr;
	}
	public void setSchedule_data_arr(ScheduleDto[] schedule_data_arr) {
		this.schedule_data_arr = schedule_data_arr;
	}
	
	
	// 날짜에 관련된 달력정보를 가지는 메서드
	public Map<String, Integer> today_info(CalendarVO dateData) {
		// 날짜 캘린더 함수에 삽입.
		Map<String, Integer> today_Data = new HashMap<String, Integer>();
		
		Calendar cal = Calendar.getInstance();
		
		int search_year = Integer.parseInt(dateData.getYear()); // 컨트롤러에서 넘겨받은 년도
		int search_month = Integer.parseInt(dateData.getMonth()); // 컨트롤러에서 넘겨받은 월
		cal.set(search_year, search_month, 1);

		int startDay = cal.getMinimum(Calendar.DATE); // 컨트롤러에서 넘겨받은 월의 첫번째 날(일)
		
		// 컨트롤러에서 넘겨받은 월의 마지막날(일) 계산
		int[] m = {31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}; // 마지막 날짜
		m[1] = search_year%4==0 && search_year%100!=0 || search_year%400==0 ? 29 : 28; // 윤년, 평년에 따라 마지막 날짜 지정
		int endDay = m[search_month-1]; // 마지막 날(일)
		
		// 컨트롤러에서 넘겨받은 월의 첫번째 날 요일 계산
		int sum = (search_year -1) * 365 + (search_year - 1) / 4 - (search_year - 1) / 100 + (search_year - 1) / 400;
		for (int i = 1; i < search_month; i++) {
			sum += m[i-1]; // 컨트롤러에서 넘겨받은 년도의 이전달까지의 날짜 합계
		}
		int start = (sum+1) % 7; // 첫번째 날 요일
		
		Calendar todayCal = Calendar.getInstance();
		SimpleDateFormat ysdf = new SimpleDateFormat("yyyy"); // 년도 형식
		SimpleDateFormat msdf = new SimpleDateFormat("M"); // 월 형식
		SimpleDateFormat dsdf = new SimpleDateFormat("dd"); // 일 형식

		int today_year = Integer.parseInt(ysdf.format(todayCal.getTime())); // 현재 년도
		int today_month = Integer.parseInt(msdf.format(todayCal.getTime())); // 현재 월
		int today_day = Integer.parseInt(dsdf.format(todayCal.getTime())); // 현재 날짜(일)

		int today = -1; // 현재 페이지가 현재 달이 아닐 경우 오늘 날짜를 없앤다.(-1로 만든다.)
		if (today_year == search_year && today_month == search_month) {
			today = today_day; // 오늘 날짜(일)
		}
		
		// 이전달 다음달 및 이전년도 다음년도
		Map<String, Integer> before_after_calendar = before_after_calendar(search_year,search_month); 
		
		// 날짜 관련
//		System.out.println("search_month : " + search_month); // 현재 전달
		System.out.println("현재 달의 첫째날: " + startDay + ", 현재 달의 마지막날: " + endDay + 
				", 현재 달의 첫요일: " + start + ", 현재 년도: " + today_year + ", 현재 월: " + 
				today_month + ", 컨트롤러에서 넘겨받은 년도: " + search_year + 
				", 컨트롤러에서 넘겨받은 월: " + search_month + ", 오늘 날짜: " + today);
		// 캘린더 함수 end
		today_Data.put("start", start); // 첫번째 날 요일
		today_Data.put("startDay", startDay); // 첫번째 날(일)
		today_Data.put("endDay", endDay); // 마지막 날(일)
		today_Data.put("today", today); // 오늘 날짜(일)
		today_Data.put("sum", sum); // 이전달까지의 날짜 전체 합계
		today_Data.put("search_year", search_year); // 계산 후 보여질 년도
		today_Data.put("search_month", search_month); // 계산 후 보여질 달
		today_Data.put("before_year", before_after_calendar.get("before_year")); // 이전년도
		today_Data.put("before_month", before_after_calendar.get("before_month")); // 이전달
		today_Data.put("after_year", before_after_calendar.get("after_year")); // 다음년도
		today_Data.put("after_month", before_after_calendar.get("after_month")); // 다음달
		
		// DB에 넣기 위해 날짜 데이터 편집
		String db_year = String.valueOf(search_year).substring(2);
		String db_month = "";
		if (search_month < 10) {
			db_month = "0" + String.valueOf(search_month);
		} else {
			db_month = String.valueOf(search_month);
		}
		this.db_startDate = db_year+"/"+db_month+"/0"+String.valueOf(startDay);
		this.db_endDate = db_year+"/"+db_month+"/"+String.valueOf(endDay);
		
		return today_Data;
	}
	
	//이전달 다음달 및 이전년도 다음년도
	private Map<String, Integer> before_after_calendar(int search_year, int search_month){
		Map<String, Integer> before_after_data = new HashMap<String, Integer>();
		int before_year = search_year-1; // 이전년도 계산하기 위한 객체
		int before_month = search_month-1; // 이전달
		int after_year = search_year+1; // 다음년도 계산하기 위한 객체
		int after_month = search_month+1; // 다음달

		if(before_month <= 0){ // 이전달이 0보다 작으면 작년, 12월 저장
			before_month=12;
			before_year=search_year-1;
		}
		
		if(after_month >= 13){ // 다음달이 13보다 크면 내년, 1월 저장
			after_month=1;
			after_year=search_year+1;
		}
		
		before_after_data.put("before_year", before_year); // 이전년도
		before_after_data.put("before_month", before_month); // 이전달
		before_after_data.put("after_year", after_year); // 다음년도
		before_after_data.put("after_month", after_month); // 다음달
		
		return before_after_data;
	}
	
	// 스케줄 사용시 사용될 생성자
	public CalendarVO(String year, String month, String date, String value, String holiday, ScheduleDto[] schedule_data_arr) {
		if ((month != null && month != "") && (date != null && date != "")) {
			this.year = year;
			this.month = month;
			this.date = date;
			this.value = value;
			this.holiday = holiday;
			this.schedule_data_arr = schedule_data_arr;
		}

	}

//	// 달력만 사용시 사용될 생성자
//	public CalendarVO(String year, String month, String date, String value) {
//		if ((month != null && month != "") && (date != null && date != "")) {
//			this.year = year;
//			this.month = month;
//			this.date = date;
//			this.value = value;
//		}
//	}
	
	public CalendarVO() {
	}
	
	@Override
	public String toString() {
		return "CalendarVO [year=" + year + ", month=" + month + ", date=" + date + ", value=" + value
				+ ", db_startDate=" + db_startDate + ", db_endDate=" + db_endDate + ", holiday=" + holiday
				+ ", schedule_data_arr=" + Arrays.toString(schedule_data_arr) + "]";
	}
	
}

