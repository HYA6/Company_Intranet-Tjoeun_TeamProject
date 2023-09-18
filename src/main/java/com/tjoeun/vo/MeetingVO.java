package com.tjoeun.vo;

public class MeetingVO {


	    private int room_id;
	    private String user_Name;
	    private String meetingDate;
	    private String meetingTime;
	    private String status;
	    private String team;
	    private int cnum;
	    
		public int getRoom_id() {
			return room_id;
		}
		public void setRoom_id(int room_id) {
			this.room_id = room_id;
		}
		public String getUser_Name() {
			return user_Name;
		}
		public void setUser_Name(String user_Name) {
			this.user_Name = user_Name;
		}
		public String getMeetingDate() {
			return meetingDate;
		}
		public void setMeetingDate(String meetingDate) {
			this.meetingDate = meetingDate;
		}
		public String getMeetingTime() {
			return meetingTime;
		}
		public void setMeetingTime(String meetingTime) {
			this.meetingTime = meetingTime;
		}
		public String getStatus() {
			return status;
		}
		public void setStatus(String status) {
			this.status = status;
		}
		
		
		public String getTeam() {
			return team;
		}
		public void setTeam(String team) {
			this.team = team;
		}
		
		
		
		public int getCnum() {
			return cnum;
		}
		public void setCnum(int cnum) {
			this.cnum = cnum;
		}
		
		@Override
		public String toString() {
			return "MeetingVO [room_id=" + room_id + ", user_Name=" + user_Name + ", meetingDate=" + meetingDate
					+ ", meetingTime=" + meetingTime + ", status=" + status + ", team=" + team + ", cnum=" + cnum + "]";
		}
		
		
}
