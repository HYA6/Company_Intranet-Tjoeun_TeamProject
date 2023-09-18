package com.tjoeun.vo;

// 검색 기능을 위한 VO
public class SearchVO {
	
	private int cnum = 0;       // 사원번호
	private int startNo = 0;
	private int endNo = 0; 
	private String item = ""; // 검색 내용
	private String paper = ""; // 결재 종류 
	
	
	public int getCnum() {
		return cnum;
	}
	public void setCnum(int cnum) {
		this.cnum = cnum;
	}
	public int getStartNo() {
		return startNo;
	}
	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}
	public int getEndNo() {
		return endNo;
	}
	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public String getPaper() {
		return paper;
	}
	public void setPaper(String paper) {
		this.paper = paper;
	}
	
	
	@Override
	public String toString() {
		return "SearchVO [cnum=" + cnum + ", startNo=" + startNo + ", endNo=" + endNo + ", item=" + item + ", paper="
				+ paper + "]";
	}
	
}