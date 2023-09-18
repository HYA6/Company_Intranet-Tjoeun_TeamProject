package com.tjoeun.dao;

import com.tjoeun.vo.AttendanceVO;

public interface AttendanceDAO {

   
   String selectbyCnum_Atten(AttendanceVO ao);
   String selectbyCnum_Leave(AttendanceVO ao);
   void insertTime(int cnum);
   void UpdateLeaveTime(AttendanceVO ao);
  
   
   
}