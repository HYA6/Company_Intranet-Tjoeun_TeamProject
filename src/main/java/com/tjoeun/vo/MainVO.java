package com.tjoeun.vo;

public class MainVO {
	
	private int cnum;
	private String name;
	private String joiningDate;
	private String team;
	private String role;
	private String email;
	private String phone;
	private String birthDay;
	private int dayoff;
	private String password;
	private String imagefile;
	
	public MainVO() {
		// TODO Auto-generated constructor stub
	}
	
	public MainVO(int cnum, String name, String joiningDate, String team, String role, String email, String phone,
			String birthDay, int dayoff, String password, String imagefile) {
		super();
		this.cnum = cnum;
		this.name = name;
		this.joiningDate = joiningDate;
		this.team = team;
		this.role = role;
		this.email = email;
		this.phone = phone;
		this.birthDay = birthDay;
		this.dayoff = dayoff;
		this.password = password;
		this.imagefile = imagefile;
	}
	public int getCnum() {
		return cnum;
	}
	public void setCnum(int cnum) {
		this.cnum = cnum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getJoiningDate() {
		return joiningDate;
	}
	public void setJoiningDate(String joiningDate) {
		this.joiningDate = joiningDate;
	}
	public String getTeam() {
		return team;
	}
	public void setTeam(String team) {
		this.team = team;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getBirthDay() {
		return birthDay;
	}
	public void setBirthDay(String birthDay) {
		this.birthDay = birthDay;
	}
	public int getDayoff() {
		return dayoff;
	}
	public void setDayoff(int dayoff) {
		this.dayoff = dayoff;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getImagefile() {
		return imagefile;
	}
	public void setImagefile(String imagefile) {
		this.imagefile = imagefile;
	}
	
	@Override
	public String toString() {
		return "MainVO [cnum=" + cnum + ", name=" + name + ", joiningDate=" + joiningDate + ", team=" + team + ", role="
				+ role + ", email=" + email + ", phone=" + phone + ", birthDay=" + birthDay + ", dayoff=" + dayoff
				+ ", password=" + password + ", imagefile=" + imagefile + "]";
	}
	
	
	
	
}