package com.tjoeun.vo;

import java.util.Date;

public class CeoVO {
	
	private int idx;
	private int cnum;       // 사원번호
	private String name;
	private String subject;       // 제목
	private String content;		  // 내용
	private Date writeDate;
	private String status;		// 결재상태
	private String reason;		// 반려 이유
	private String paper;
	private String filename; // 파일 이름
	private String item = ""; // 검색 내용
	private String approval = ""; // 결재 목록이 전체인지 개별인지 구분하는 변수
	
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public final String getPaper() {
		return paper;
	}
	public final void setPaper(String paper) {
		this.paper = paper;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public String getApproval() {
		return approval;
	}
	public void setApproval(String approval) {
		this.approval = approval;
	}
	
	@Override
	public String toString() {
		return "CeoVO [idx=" + idx + ", cnum=" + cnum + ", name=" + name + ", subject=" + subject + ", content="
				+ content + ", writeDate=" + writeDate + ", status=" + status + ", reason=" + reason + ", paper="
				+ paper + ", filename=" + filename + ", item=" + item + ", approval=" + approval + "]";
	}
	
}