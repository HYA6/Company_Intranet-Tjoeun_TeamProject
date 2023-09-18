package com.tjoeun.dao;

import java.util.ArrayList;

import com.tjoeun.vo.CalendarVO;
import com.tjoeun.vo.ScheduleDto;

public interface ScheduleDao {
	
	public ArrayList<ScheduleDto> schedule_list(CalendarVO calendarVO);
	public int schedule_add(ScheduleDto scheduleDto);
	public int before_schedule_add_search(ScheduleDto scheduleDto);
	public void scheduleUpdate(ScheduleDto scheduleDto);
	public void scheduleDelete(ScheduleDto scheduleDto);
	public int before_schedule_add_search_num(ScheduleDto scheduleDto);
	public ArrayList<ScheduleDto> scheduleMain(String shedule_date);
	
}
