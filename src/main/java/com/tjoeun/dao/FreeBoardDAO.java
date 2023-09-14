package com.tjoeun.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.tjoeun.vo.FreeBoardVO;

public interface FreeBoardDAO {

	int selfoCount();
	ArrayList<FreeBoardVO> selfoList(HashMap<String, Integer> hmap);
	ArrayList<FreeBoardVO> selfoList2();
	void fboardinsert(FreeBoardVO freeBoardVO);
	FreeBoardVO fboardByIdx(FreeBoardVO freeBoardVO);
	void fboardDelete(FreeBoardVO freeBoardVO);
	void fboardUpdate(FreeBoardVO freeBoardVO);


}