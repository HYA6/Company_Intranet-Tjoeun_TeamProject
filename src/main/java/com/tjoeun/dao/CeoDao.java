 package com.tjoeun.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.tjoeun.vo.CeoVO;
import com.tjoeun.vo.SearchVO;

public interface CeoDao {
	
	int selectsawonCountByCeo(CeoVO ceoVO);
	ArrayList<CeoVO> selectsawonListByCeo(HashMap<String, Integer> hmap); 
	int searchPaperCountByCeo(CeoVO ceoVO);
	int searchSubjectCountByCeo(CeoVO ceoVO);
	int searchContentCountByCeo(CeoVO ceoVO);
	int searchNameCountByCeo(CeoVO ceoVO);
	ArrayList<CeoVO> selectPaperListByCeo(SearchVO searchVO);
	ArrayList<CeoVO> selectSubjectListByCeo(SearchVO searchVO);
	ArrayList<CeoVO> selectContentListByCeo(SearchVO searchVO);
	ArrayList<CeoVO> selectNameListByCeo(SearchVO searchVO);
	
};