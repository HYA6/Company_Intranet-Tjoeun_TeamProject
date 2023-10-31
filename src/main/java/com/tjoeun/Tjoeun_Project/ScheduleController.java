package com.tjoeun.Tjoeun_Project;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tjoeun.dao.ScheduleDao;
import com.tjoeun.vo.CalendarVO;
import com.tjoeun.vo.ScheduleDto;

@Controller
public class ScheduleController {

	private static final Logger logger = LoggerFactory.getLogger(SawonController.class);

	@Autowired
	private SqlSession sqlSession;
	
	// 사내 일정 페이지 불러오기
	@RequestMapping("/ScheduleView")
	public String scheduleView(Model model, HttpServletRequest request, CalendarVO calendarVO){
		logger.info("CalendarController의 scheduleView() 메소드 실행");
		
		Calendar cal = Calendar.getInstance();
		CalendarVO calendarData;
		
//		logger.info("calendarVO: {}", calendarVO);
		
//		logger.info("현재 년도: {}", String.valueOf(cal.get(Calendar.YEAR)));
//		logger.info("현재 달: {}", String.valueOf(cal.get(Calendar.MONTH)+1));
//		logger.info("현재 날짜: {}", String.valueOf(cal.get(Calendar.DATE)));
		
		//검색 날짜
		if(calendarVO.getDate().equals("")&&calendarVO.getMonth().equals("")){
			calendarVO = new CalendarVO(String.valueOf(cal.get(Calendar.YEAR)),
					String.valueOf(cal.get(Calendar.MONTH)+1),String.valueOf(cal.get(Calendar.DATE)),null, null, null);
		}
		
		Map<String, Integer> today_info =  calendarVO.today_info(calendarVO);
		List<CalendarVO> dateList = new ArrayList<CalendarVO>();
		
		//검색 날짜 end
		ScheduleDao scheduleDao = sqlSession.getMapper(ScheduleDao.class);
		// 현재 DB에 저장된 스케줄 데이터(날짜, 순번, 글번호 순)
		ArrayList<ScheduleDto> Schedule_list =  scheduleDao.schedule_list(calendarVO); 
		// ========================================================== DB에 날짜가 있는지 검색
		
		// 실질적인 달력 데이터 리스트에 데이터 삽입 시작.
		// 일단 시작 인덱스까지 아무것도 없는 데이터 삽입
		logger.info("today_info.get(\"start\"): {}", today_info.get("start"));
		for(int i=1; i<=today_info.get("start"); i++){
			calendarData = new CalendarVO(null, null, null, null, null, null);
			dateList.add(calendarData);
		}
		
		// 달력데이터에 넣기 위한 배열 추가
		// 행 => 달력 일자 수
		// 열 => 스케줄 저장할 수 있는 개수
		ScheduleDto[][] schedule_data_arr = new ScheduleDto[32][4]; 
		if(dateList.isEmpty()!=true || today_info.get("start") == 0){
			int j = 0;
			for(int i=0; i<Schedule_list.size(); i++){
				// 현재 스케줄 날짜(일)
				int date = Integer.parseInt(String.valueOf(Schedule_list.get(i).getSchedule_date()).substring(String.valueOf(Schedule_list.get(i).getSchedule_date()).length()-2,
						String.valueOf(Schedule_list.get(i).getSchedule_date()).length()));
				logger.info("date: {}", date);
				if(i>0){ // 두번째 스케줄부터 순서대로 저장
					// 이전 스케줄 날짜
					int date_before = Integer.parseInt(String.valueOf(Schedule_list.get(i-1).getSchedule_date()).substring(String.valueOf(Schedule_list.get(i-1).getSchedule_date()).length()-2,
							String.valueOf(Schedule_list.get(i-1).getSchedule_date()).length()));
					logger.info("date_before: {}", date_before);
					if(date_before==date){ // 이전 스케줄과 날짜가 같으면 다음 인덱스에 저장
						j=j+1;
						schedule_data_arr[date][j] = Schedule_list.get(i);
					} else{ // 이전 스케줄과 날짜가 다르면 처음 인덱스에 저장
						j=0;
						schedule_data_arr[date][j] = Schedule_list.get(i);
					}
				} else{ // 처음 스케줄 저장
					schedule_data_arr[date][j] = Schedule_list.get(i);
				}
			}
		}
		// 날짜 삽입
		for (int i = today_info.get("startDay"); i <= today_info.get("endDay"); i++) {
			ScheduleDto[] schedule_data_arr2 = new ScheduleDto[4];
			schedule_data_arr2 = schedule_data_arr[i];

			int month = Integer.parseInt(calendarVO.getMonth());
//			logger.info("{}", month);
			
			int sum = today_info.get("sum");
			sum += i;
			int day = sum % 7;
//			logger.info("{}", day);
			String holiday = ""; // 공휴일
			// 공휴일인지 아닌지
			if ((month == 1 && i == 1) || (month == 3 && i == 1) || (month == 5 && i == 1) || (month == 5 && i == 5) || (month == 5 && i == 27) || 
				(month == 6 && i == 6) || (month == 8 && i == 15) || (month == 10 && i == 3) || (month == 10 && i == 9) || (month == 12 && i == 25)) {
				
				if(month == 1 && i == 1) { holiday = "신정";} 
				else if(month == 3 && i == 1) { holiday = "삼일절";} 
				else if(month == 5 && i == 1) { holiday = "근로자의날";} 
				else if(month == 5 && i == 5) { holiday = "어린이날";} 
				else if(month == 5 && i == 27) { holiday = "부처님오신날";} 
				else if(month == 6 && i == 6) { holiday = "현충일";} 
				else if(month == 8 && i == 15) { holiday = "광복절";} 
				else if(month == 10 && i == 3) { holiday = "개천절";} 
				else if(month == 10 && i == 9) { holiday = "한글날";} 
				else if(month == 12 && i == 25) { holiday = "크리스마스";}
				
				if(i==today_info.get("today")) {
					calendarData = new CalendarVO(String.valueOf(calendarVO.getYear()), 
							String.valueOf(calendarVO.getMonth()), String.valueOf(i), 
							"today", holiday, schedule_data_arr2);
				} else {
					calendarData = new CalendarVO(String.valueOf(calendarVO.getYear()), 
							String.valueOf(calendarVO.getMonth()), String.valueOf(i), 
							"holiday", holiday, schedule_data_arr2);
				}
				
			} else if(i==today_info.get("today")) { // 오늘인지
				calendarData = new CalendarVO(String.valueOf(calendarVO.getYear()), 
						String.valueOf(calendarVO.getMonth()), String.valueOf(i), 
						"today", holiday, schedule_data_arr2);
				
			} else {
				calendarData = new CalendarVO(String.valueOf(calendarVO.getYear()), 
					String.valueOf(calendarVO.getMonth()), String.valueOf(i), 
					"normal_date", holiday, schedule_data_arr2);
			}
			
			// 대체공휴일
			if ((month == 3 && i == 2 && day == 1) || (month == 3 && i == 3 && day == 1) || // 삼일절
				(month == 5 && i == 6 && day == 1) || (month == 5 && i == 7 && day == 1) || // 어린이날
				(month == 5 && i == 28 && day == 1) || (month == 5 && i == 29 && day == 1) || // 부처님오신날
				(month == 8 && i == 16 && day == 1) || (month == 8 && i == 17 && day == 1) || // 광복절
				(month == 10 && i == 4 && day == 1) || (month == 10 && i == 5 && day == 1) || // 개천절
				(month == 10 && i == 10 && day == 1) || (month == 10 && i == 11 && day == 1) || // 한글날
				(month == 12 && i == 26 && day == 1) || (month == 12 && i == 27 && day == 1)) { // 크리스마스
//					logger.info("{}", month);
//					logger.info("{}", i);
//					logger.info("{}", day);
					calendarData = new CalendarVO(String.valueOf(calendarVO.getYear()), 
							String.valueOf(calendarVO.getMonth()), String.valueOf(i), 
							"holiday", "대체공휴일", schedule_data_arr2);
			}
			dateList.add(calendarData);
		}
		
		// 달력 빈곳 빈 데이터로 삽입
		int index = 7-dateList.size()%7;
		
		if(dateList.size()%7!=0){
			for (int i = 0; i < index; i++) {
				calendarData= new CalendarVO(null, null, null, null, null, null);
				dateList.add(calendarData);
			}
		}
		System.out.println(dateList);
//		System.out.println(today_info);
		
		// 배열에 담음
		model.addAttribute("dateList", dateList); // 날짜 데이터 배열
		model.addAttribute("today_info", today_info);
		return "ScheduleView";
	}
	
	@RequestMapping("/scheduleAdd")
	public String scheduleAdd(HttpServletRequest request, ScheduleDto scheduleDto, RedirectAttributes rttr){
		logger.info("CalendarController의 scheduleAdd() 메소드 실행");
		ScheduleDao scheduleDao = sqlSession.getMapper(ScheduleDao.class);
		int countDate = scheduleDao.before_schedule_add_search(scheduleDto);
		int countNum = scheduleDao.before_schedule_add_search_num(scheduleDto);
		String message = "";
		if (countNum == 0) {
			if(countDate>=4){
				message="스케줄은 최대 4개만 등록 가능합니다.";
			}else{
				scheduleDao.schedule_add(scheduleDto);
				message="스케줄이 등록되었습니다";
			}
		} else {
			message="중복된 순번입니다.";
		}
		rttr.addFlashAttribute("message", message);
		return "redirect:ScheduleView";
	}
	
	@RequestMapping("/scheduleUpdate")
	public String scheduleUpdate(HttpServletRequest request, ScheduleDto scheduleDto, RedirectAttributes rttr) {
		logger.info("CalendarController의 scheduleUpdate() 메소드 실행");
		ScheduleDao scheduleDao = sqlSession.getMapper(ScheduleDao.class);
		int countNum = scheduleDao.before_schedule_add_search_num(scheduleDto);
		logger.info("{}", scheduleDto);
		String message = "";
		if (countNum == 0) {
			scheduleDao.scheduleUpdate(scheduleDto);
			message = "스케줄이 수정되었습니다.";
		} else {
			message="중복된 순번입니다.";
		}
		rttr.addFlashAttribute("message", message);
		return "redirect:ScheduleView";
	}
	
	@RequestMapping("/scheduleDelete")
	public String scheduleDelete(HttpServletRequest request, ScheduleDto scheduleDto) {
		logger.info("CalendarController의 scheduleDelete() 메소드 실행");
		ScheduleDao scheduleDao = sqlSession.getMapper(ScheduleDao.class);
//		logger.info(scheduleDto.getSchedule_subject());
		scheduleDao.scheduleDelete(scheduleDto);
//		rttr.addFlashAttribute("message", "스케줄이 삭제되었습니다.");
		return "redirect:ScheduleView";
	}
}
