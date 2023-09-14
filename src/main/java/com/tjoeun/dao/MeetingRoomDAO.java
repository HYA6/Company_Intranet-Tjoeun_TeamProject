package com.tjoeun.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.tjoeun.vo.MeetingVO;

public interface MeetingRoomDAO {

	ArrayList<MeetingVO> getAllMeetingRooms(HashMap<String, Integer> hmap);

	ArrayList<MeetingVO> getMeetingRoomById(HashMap<String, Integer> hmap);
	
	int countMeetingRoomById(MeetingVO meetingVO);

	int countAllMeetingRooms(MeetingVO meetingVO);

	void meetingInsert(MeetingVO meetingVO);
	
	int selectmeetingCount(MeetingVO meetingVO);

	int countAllMeetingRooms();

	ArrayList<MeetingVO> getTodayMeetings(HashMap<String, String> hmap);
	
	Object countAllMeetingRooms(HashMap<String, Integer> hmap);

	String getoneMeeting(MeetingVO meetingVO);

}
