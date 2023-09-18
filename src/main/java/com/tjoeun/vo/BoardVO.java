package com.tjoeun.vo;

import java.util.Date;

public class BoardVO {

	private int idx;
	private int cnum;       // 사원번호
	private String name;
	private String subject;       // 제목
	private String content;		  // 내용
	private Date writeDate;
	private String gubun;		  // 공지사항 구분(종류)
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
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
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	
	@Override
	public String toString() {
		return "BoardVO [idx=" + idx + ", cnum=" + cnum + ", name=" + name + ", subject=" + subject + ", content="
				+ content + ", writeDate=" + writeDate + ", gubun=" + gubun + "]";
	}

	
	
	
}
