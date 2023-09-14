package com.tjoeun.Tjoeun_Project;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tjoeun.dao.AttendanceDAO;
import com.tjoeun.dao.BoardDAO;
import com.tjoeun.dao.MealDAO;
import com.tjoeun.dao.MeetingRoomDAO;
import com.tjoeun.dao.ScheduleDao;
import com.tjoeun.vo.AttendanceVO;
import com.tjoeun.vo.BoardList;
import com.tjoeun.vo.Board_MealList;
import com.tjoeun.vo.MainVO;
import com.tjoeun.vo.MeetingVO;
import com.tjoeun.vo.ScheduleDto;

@Controller
public class MainController {
	
	// 모든 컨트롤러에 다 넣기 ======================================================
	@Autowired
	private SqlSession sqlSession;
	// ==============================================================================
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	// Session이 남아있는지 확인하는 메소드
	public boolean verification(HttpSession session) {
		MainVO mvo = (MainVO) session.getAttribute("mvo");
		
		if (mvo != null ) {
			return false;
		} else return true;
	}
	
	
	// main.jsp 초기화
	@RequestMapping("/main")
	public String index(HttpServletRequest request, HttpSession session, Model model) {
		logger.info("MainController의 index 진입");
		
		// 만약 사원 정보가 없을 경우 login창으로 리턴
		MainVO mvo = (MainVO) session.getAttribute("mvo");
		if ( verification(session) ) return "redirect:logoutOK";
		
		// 출석 SQL문, 회의실 SQL문 사용 위해 mapper 뽑아옴.
		AttendanceDAO attendance_Mapper = sqlSession.getMapper(AttendanceDAO.class);
		MeetingRoomDAO meetingRoom_Mapper = sqlSession.getMapper(MeetingRoomDAO.class);
		BoardDAO board_Mapper = sqlSession.getMapper(BoardDAO.class);
		MealDAO meal_Mapper = sqlSession.getMapper(MealDAO.class);
		ScheduleDao scheduleDao = sqlSession.getMapper(ScheduleDao.class);
		
		String SERVER_IMAGES_DIR = request.getSession().getServletContext().getRealPath("resources");
	    
		// 출/퇴근 시간이 찍혀 있는지에 대한 변수들 
		String Atten_date = "";
		String Atten_Check = null;
		
		String Leave_date = "";
		String Leave_Check = null;
		
		// 오늘 날짜를 가져올 변수
		Date today = new Date();
		
		// 출퇴근에 관한 객체 뽑아옴
		AttendanceVO ao = new AttendanceVO();
		
		// 날짜를 각 쓰임에 맞게 사용하기 위한 Format 객체
		SimpleDateFormat date_N_hour = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat date_Format = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat hour_Format = new SimpleDateFormat("HH");
		
		// 오늘 날짜 / 시간을 문자열 형식으로 받기 위한 변수
		String Today_String = date_Format.format(today);
		String Hour_String = hour_Format.format(today);
		
		
//		logger.info("MainController에서 하는 mvo : {}", session.getAttribute("mvo"));
		
		
		// 출퇴근 객체에 사원번호(CNUM), 출근시간(Worktime), 퇴근시간(Hometime) 삽입
		ao.setCnum(mvo.getCnum());
		ao.setWorktime(Today_String);
		ao.setHometime(Today_String);
		
		// 출퇴근 객체를 토대로 DB에 출퇴근 시간이 있나 조회
		Atten_Check = attendance_Mapper.selectbyCnum_Atten(ao);
		Leave_Check = attendance_Mapper.selectbyCnum_Leave(ao);
		// logger.info("Atten_Check : {}, Leave_Check : {}", Atten_Check, Leave_Check);
		
		
		// 출퇴근 시간이 있을경우 String 타입인 '오늘'을 
		// 원하는 Date 타입의 Format으로 변환 후
		// 다시 String 타입으로 바꿔 원하는 형식의 String문을 뽑아 Atten_date, Leave_date에 삽입
		try {
			Atten_date = date_N_hour.format(date_N_hour.parse(Atten_Check));
			Leave_date = date_N_hour.format(date_N_hour.parse(Leave_Check));
			if(Atten_date.equals(Leave_date)) {
				Leave_date = "";
			}
		} catch ( Exception e ) { }
		
		// 형식에 맞는 String 타입 날짜를 request에 삽입
		request.setAttribute("Atten_date", Atten_date);
		request.setAttribute("Leave_date", Leave_date);
		
		
		
		// 예약 현황 출력
		// 예약 현황을 뽑기 위해 Hashmap 객체 생성
		HashMap<String, String> date_Hmap = new HashMap<String, String>();
		
		// 오늘 날짜, 시간을 Hashmap 객체(date_Hmap)에 삽입
		date_Hmap.put("today", Today_String);
		date_Hmap.put("hour", Hour_String);
		
		logger.info("today , hour : {}, {}", Today_String, Hour_String);
		logger.info(date_Hmap.toString());
		
		// 오늘 날짜, 시간을 토대로 DB에 가장 가까운 시간의 예약이 뭐가 있나 조회 
		ArrayList<MeetingVO> nearest_TodayMeeting = meetingRoom_Mapper.getTodayMeetings(date_Hmap);
		logger.info("today : {}", nearest_TodayMeeting);
		
	
		// 예약 현황 전체를 넣어놓을 새로운 HashMap 객체 생성 
		HashMap<String, MeetingVO> Room_Value = new HashMap<String, MeetingVO>();
	
		// 예약 현황을 삽입할 변수
		MeetingVO Room_101 = null;
		MeetingVO Room_102 = null;
		MeetingVO Room_103 = null;
				
		
		// 만약 가까운 시간의 예약이 있으면 ( null 이 아니면 ) 
		if ( nearest_TodayMeeting != null ) {
		
			// 예약의 수만큼 for문 돌림.
			for ( int i = 0; i < nearest_TodayMeeting.size(); i++ ) {
				
				// 각 예약의 방 번호를 switch문으로 분류
				switch (nearest_TodayMeeting.get(i).getRoom_id()) {
					
					// 101호일 경우
					case 101:
						// 만약 101호 변수가 null이면 ( 가장 가까운 시간대 예약이라면 )
						if ( Room_101 == null ) {
							Room_101 = nearest_TodayMeeting.get(i);
							Room_Value.put("101", Room_101);
						}
						break;
						
					// 102호일 경우
					case 102:
						// 만약 102호 변수가 null이면 ( 가장 가까운 시간대 예약이라면 )
						if ( Room_102 == null ) {
							Room_102 = nearest_TodayMeeting.get(i);
							Room_Value.put("102", Room_102);
						}
						break;
					
					// 103호일 경우
					case 103:
						// 만약 103호 변수가 null이면 ( 가장 가까운 시간대 예약이라면 )
						if ( Room_103 == null ) {
							Room_103 = nearest_TodayMeeting.get(i);
							Room_Value.put("103", Room_103);
						}
						break;
				
				}
				
			}
		
		}
		
		// 가장 가까운 예약 현황을 넣어놓은 HashMap 객체를 request에 넣음
		request.setAttribute("Room_Value", Room_Value);
		
		logger.info("server : {}", SERVER_IMAGES_DIR);
		
		
		
		// 공지 출력
		BoardList list = new BoardList();
		list.setList2(board_Mapper.selboList2());
		logger.info("mainBoardList : {}", list);	
		
		model.addAttribute("mainBoardList", list);

		
		
		
		// 식단표 출력
		Board_MealList mealList = new Board_MealList();
		mealList.setList(meal_Mapper.selectMealTopList());
		
		model.addAttribute("mealList", mealList);
		
		
		
		// 사내일정 출력
		Calendar cal = Calendar.getInstance();
		String shedule_date = "";
		String year = String.valueOf(cal.get(Calendar.YEAR));
		String month = String.valueOf(cal.get(Calendar.MONTH)+1);
		String day = String.valueOf(cal.get(Calendar.DATE));
		logger.info("년도: {}", year);
		logger.info("월: {}", month);
		logger.info("일: {}", day);
		// DB에 넣기 위해 날짜 데이터 편집
		String db_year = year.substring(2);
		String db_month = "";
		if (Integer.parseInt(month) < 10) {
			db_month = "0" + month;
		} else {
			db_month = month;
		}
		if (Integer.parseInt(day) < 10) {
			shedule_date = db_year+"/"+db_month+"/0"+day;
		} else {
			shedule_date = db_year+"/"+db_month+"/"+day;
		}
		logger.info("디비에 확인될 오늘 날짜: {}", shedule_date);
		ArrayList<ScheduleDto> Schedule_list = scheduleDao.scheduleMain(shedule_date);
		logger.info("Schedule_list: {}", Schedule_list);
		
		model.addAttribute("Schedule_list", Schedule_list);
		
		return "main";
	}
	
	// 출퇴근 버튼(main.jsp -> attendanceOK.jsp)
	@RequestMapping("/attendanceOK")
	public String attendanceOK(Model model, HttpSession session) {
		AttendanceDAO mapper = sqlSession.getMapper(AttendanceDAO.class);
		
		// 만약 사원 정보가 없을 경우 login창으로 리턴
		if ( verification(session) ) return "redirect:logoutOK";
		
		// 출퇴근 현황을 넣을 변수
		String Atten_Check = null;
		String Leave_Check = null;
		
		
		Date today = new Date();
		AttendanceVO ao = new AttendanceVO();
		
		SimpleDateFormat date_format = new SimpleDateFormat("yyyy-MM-dd");

		MainVO mvo = (MainVO) session.getAttribute("mvo");
		logger.info("mvo : {}", mvo);
		
		ao.setCnum(mvo.getCnum());
		ao.setWorktime(date_format.format(today));
		ao.setHometime(date_format.format(today));
		
		// DB에 출퇴근 시간이 있나 조회
		Atten_Check = mapper.selectbyCnum_Atten(ao);
		Leave_Check = mapper.selectbyCnum_Leave(ao);
		// logger.info("Atten_Check : {}, Leave_Check : {}", Atten_Check, Leave_Check);
			
		model.addAttribute("Atten_check", Atten_Check);
		model.addAttribute("Leave_check", Leave_Check);
		model.addAttribute("ao", ao);
		
		return "attendanceOK";
		
	}
	
	
	
	
	// 출근 완료(attendanceOK.jsp -> mainBoardList.jsp -> main.jsp)
	@RequestMapping("/attendance_Atten")
	public String attendance_Atten(Model model, HttpSession session) { 
		
		AttendanceDAO mapper = sqlSession.getMapper(AttendanceDAO.class);
		
		// 만약 사원 정보가 없을 경우 login창으로 리턴
		if ( verification(session) ) return "redirect:logoutOK";
		
		
		MainVO mainVO = (MainVO) session.getAttribute("mvo");
		
		mapper.insertTime(mainVO.getCnum());
		
		logger.info("출근 성공");
		
		return "redirect:main";
	}
	
	
	
	
	// 퇴근 처리(attendanceOK.jsp -> mainBoardList.jsp -> main.jsp)
	@RequestMapping("/attendance_Leave")
	public String attendance_Leave(HttpServletRequest request, Model model, HttpSession session) { 
		
		AttendanceDAO mapper = sqlSession.getMapper(AttendanceDAO.class);
		
		// 만약 사원 정보가 없을 경우 login창으로 리턴
		if ( verification(session) ) return "redirect:logoutOK";
		

		// cnum 을 얻기 위해 mainVO 불러옴
		MainVO mvo = (MainVO) session.getAttribute("mvo");
		
		// sql 업데이트 위해 조건 중 하나인 출근시간 불러옴
		String worktime = request.getParameter("worktime");

		logger.info("worktime : {}", worktime);
		logger.info("mvo : {}", mvo);
		
		// cnum과 출근 시간을 VO에 담아 넣기 위해 AttendanceVO(ao) 생성
		AttendanceVO ao = new AttendanceVO();

		// 퇴근 시간을 ao에 삽입하기 위해 SimpleDateFormat 클래스 생성
		SimpleDateFormat date_N_hour = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		// 현재 시간을 불러오기 위해 Date 클래스 생성
		Date today = new Date();
		
		// 시간에 맞는 형식 찍어보기
		logger.info("time : {}", date_N_hour.format(today));
		
		String now = date_N_hour.format(today);

		// ao에 사원번호(cnum) 삽입
		ao.setCnum(mvo.getCnum());
		ao.setWorktime(worktime);
		ao.setHometime(now);
		
		logger.info("ao : {}", ao);
		
		mapper.UpdateLeaveTime(ao);
		
		return "redirect:main";
	}
	
	
	
	
	// 로그아웃(index.jsp -> logoutOK.jsp -> login.jsp)
	@RequestMapping("/logoutOK")
	public String logoutOK(HttpServletRequest request, HttpSession session) {
		
		// 세션에 있는 속성들 raw(날것) 타입인 Enumeration 타입으로 뽑아오기
		@SuppressWarnings("rawtypes")
		Enumeration list = session.getAttributeNames();
		
		// 만약 세션에 있는 속성들이 있으면 다 삭제
		while ( list.hasMoreElements() ) {
			session.removeAttribute((String)list.nextElement());
		}
		
		// 로그인 창의 error 속성 바꾸기 ( 권장 X, js로 가능할 듯 )
		request.setAttribute("error", null);
		return "redirect:login";
	}

	
	
}
