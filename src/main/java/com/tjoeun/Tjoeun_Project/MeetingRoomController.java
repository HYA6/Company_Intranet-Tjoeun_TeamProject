package com.tjoeun.Tjoeun_Project;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tjoeun.dao.MeetingRoomDAO;
import com.tjoeun.vo.MeetingRoomList;
import com.tjoeun.vo.MeetingVO;

@Controller
public class MeetingRoomController {

	@Autowired
	private SqlSession sqlSession;
	private static final Logger logger = LoggerFactory.getLogger(MeetingRoomController.class);
	
	// 회의실 페이지로 가기
    @RequestMapping("/meetingrooms")
    public String meetingrooms(HttpServletRequest request, Model model) {
    	logger.info("MeetingController의 meetingrooms");
        
    	String room_id = request.getParameter("room_id");
    	logger.info("{}", room_id);
    	model.addAttribute("room_id", room_id);
    	return "datepicker/webapp/datepicker";
    }
    
    // 회의실 예약 정보 저장
    @RequestMapping("/submitreservation")
    public String submitreservation(HttpServletRequest request, Model model, MeetingVO meetingVO) {
    	logger.info("submitreservation");
    	
    	MeetingRoomDAO mapper = sqlSession.getMapper(MeetingRoomDAO.class);
//    	logger.info("{}",meetingVO);
    	mapper.meetingInsert(meetingVO);
    	
    	model.addAttribute("room_id", meetingVO.getRoom_id());
    	return "redirect:getAllMeetingRooms";
    }
    
 // 회의실 개별 예약현황 불러오기 
    @RequestMapping("/getAllMeetingRooms")
    public String getAllMeetingRooms(HttpServletRequest request, Model model, MeetingVO meetingVO) {
        logger.info("MeetingRoomController의 getAllMeetingRooms");
        logger.info("meetingVO : {}", meetingVO);
        MeetingRoomDAO mapper = sqlSession.getMapper(MeetingRoomDAO.class);

        // 예약글 전체 개수 불러오기
        int pageSize = 10;
        int currentPage = 1;
        try {
            String currentPageParam = request.getParameter("currentPage");
            if (currentPageParam != null && !currentPageParam.isEmpty()) {
                currentPage = Integer.parseInt(currentPageParam);
            }
        } catch (NumberFormatException e) {
            // 예외 처리
            currentPage = 1; // 기본 페이지를 1로 설정하거나 원하는 값으로 변경하세요.
        }
        int totalCount = mapper.countMeetingRoomById(meetingVO);
        logger.info("{}", totalCount);

        MeetingRoomList meetingRoomList = new MeetingRoomList(pageSize, totalCount, currentPage);

        // 예약글 전체 목록 불러오기
        HashMap<String, Integer> hmap = new HashMap<String, Integer>();
        String roomIdParam = null;
        try {
            roomIdParam = request.getParameter("room_id");
            if (roomIdParam != null && !roomIdParam.isEmpty()) {
                hmap.put("room_id", Integer.parseInt(roomIdParam));
            }
        } catch (NumberFormatException e) {
            // 예외 처리
            
        }
        hmap.put("startNo", meetingRoomList.getStartNo());
        hmap.put("endNo", meetingRoomList.getEndNo());
        meetingRoomList.setList(mapper.getMeetingRoomById(hmap));
        model.addAttribute("room_id", request.getParameter("room_id"));
        model.addAttribute("MeetingRoomList", meetingRoomList);
        model.addAttribute("currentPage", currentPage);

        return "meetingroomList";
    }
    
//  회의실 모든 예약 현황 가져오기  
    @RequestMapping("/countAllMeetingRooms")
    public String countAllMeetingRooms(HttpServletRequest request, Model model, MeetingVO meetingVO) {
        logger.info("MeetingRoomController의 getAllMeetingRooms");
        logger.info("전체 예약 meetingVO : {}", meetingVO);
        
        MeetingRoomDAO mapper = sqlSession.getMapper(MeetingRoomDAO.class);

        // 예약글 전체 개수 불러오기
        int pageSize = 30;
        int currentPage = 1;
        try {
            String currentPageParam = request.getParameter("currentPage");
            if (currentPageParam != null && !currentPageParam.isEmpty()) {
                currentPage = Integer.parseInt(currentPageParam);
            }
        } catch (NumberFormatException e) {
            // 예외 처리
            currentPage = 1; // 기본 페이지를 1로 설정하거나 원하는 값으로 변경하세요.
        }
        int totalCount = mapper.countAllMeetingRooms(meetingVO);
        logger.info("{}", totalCount);

        MeetingRoomList meetingRoomList = new MeetingRoomList(pageSize, totalCount, currentPage);

        // 예약글 전체 목록 불러오기
        HashMap<String, Integer> hmap = new HashMap<String, Integer>();
        try {
            String roomIdParam = request.getParameter("room_id");
            if (roomIdParam != null && !roomIdParam.isEmpty()) {
                hmap.put("room_id", Integer.parseInt(roomIdParam));
            }
        } catch (NumberFormatException e) {
            // 예외 처리
          
        }
        hmap.put("startNo", meetingRoomList.getStartNo());
        hmap.put("endNo", meetingRoomList.getEndNo());
        meetingRoomList.setList(mapper.getAllMeetingRooms(hmap));
        logger.info("{}", meetingRoomList.getList());
        model.addAttribute("room_id", request.getParameter("room_id"));
        model.addAttribute("MeetingRoomList", meetingRoomList);
        model.addAttribute("currentPage", currentPage);

        return "meetingList";
    }
    
    //	중복 예약 검사 예약현황 불러오기 
    @ResponseBody
    @RequestMapping("/oneMeeting")
    public String oneMeeting(HttpServletRequest request, MeetingVO meetingVO, Model model) {
    	logger.info("MeetingRoomController의 oneMeeting");
    	MeetingRoomDAO mapper = sqlSession.getMapper(MeetingRoomDAO.class);
    	String time = mapper.getoneMeeting(meetingVO);
//   	logger.info("time: {}", time);
    	return time;
    }
    
 
    
}