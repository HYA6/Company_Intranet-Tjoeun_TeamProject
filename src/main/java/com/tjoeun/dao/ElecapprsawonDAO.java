package com.tjoeun.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.tjoeun.vo.ElecapprsawonVO;
import com.tjoeun.vo.SearchVO;

public interface ElecapprsawonDAO {
	
	void insert(ElecapprsawonVO ElecapprsawonVO);
	ArrayList<ElecapprsawonVO> selectsawonList(HashMap<String, Integer> hmap);
	int selectsawonCount(ElecapprsawonVO elecapprsawonVO);
	ElecapprsawonVO selectsawonIdx(ElecapprsawonVO elecapprsawonVO);
	void delete(ElecapprsawonVO elecapprsawonVO);
	void update(ElecapprsawonVO elecapprsawonVO);
	void updateFile(ElecapprsawonVO elecapprsawonVO);
	
	// 검색 기능
	int searchPaperCountByEle(ElecapprsawonVO elecapprsawonVO);
	int searchSubjectCountByEle(ElecapprsawonVO elecapprsawonVO);
	int searchContentCountByEle(ElecapprsawonVO elecapprsawonVO);
	ArrayList<ElecapprsawonVO> selectPaperListByEle(SearchVO searchVO);
	ArrayList<ElecapprsawonVO> selectSubjectListByEle(SearchVO searchVO);
	ArrayList<ElecapprsawonVO> selectContentListByEle(SearchVO searchVO);
	
}