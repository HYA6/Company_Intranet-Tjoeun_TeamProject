package com.tjoeun.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.tjoeun.vo.BoardVO;

public interface BoardDAO {

	int selboCount();
	ArrayList<BoardVO> selboList(HashMap<String, Integer> hmap);
	ArrayList<BoardVO> selboList2();
	void boardinsert(BoardVO boardVO);
	BoardVO boardByIdx(BoardVO boardVO);
	void boardDelete(BoardVO boardVO);
	void boardUpdate(BoardVO boardVO);
	ArrayList<BoardVO> spcselboList(HashMap<String, Integer> shmap);
 
}