package com.mc.web.programs.front.board.Pager;

public class Criteria {

	private int page;
	private int perPageNum;
	private int stPageVol;
	private int type;
	private int sch;
	private String keyword;

	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
	}
	
	
	public int getStPageVol() {
		return stPageVol;
	}

	public void setStPageVol() {
		this.stPageVol = (this.page - 1) * perPageNum;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
	
	public int getSch() {
		return sch;
	}

	public void setSch(int sch) {
		this.sch = sch;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getPageStart() {
		return (this.page - 1) * perPageNum;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		if (page <= 0) {
			this.page = 1;
		} else {
			this.page = page;
		}
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int pageCount) {
		int cnt = this.perPageNum;
		if (pageCount != cnt) {
			this.perPageNum = cnt;
		} else {
			this.perPageNum = pageCount;
		}
	}

}
