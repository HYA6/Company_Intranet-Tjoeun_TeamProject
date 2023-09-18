package com.tjoeun.vo;

import java.text.SimpleDateFormat;

public class AttendanceVO {
	
	SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");
	
	private int cnum;
	private String worktime;
	private String hometime;
	
	
	public int getCnum() {
		return cnum;
	}
	public void setCnum(int cnum) {
		this.cnum = cnum;
	}	
	public String getWorktime() {
		return worktime;
	}
	public void setWorktime(String worktime) {
		this.worktime = worktime;
	}
	public String getHometime() {
		return hometime;
	}
	public void setHometime(String hometime) {
		this.hometime = hometime;
	}
	@Override
	public String toString() {
		return "AttendanceVO [cnum=" + cnum + ", worktime=" + worktime + ", hometime=" + hometime + "]";
	}
	
	
	
}
