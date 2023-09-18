package com.tjoeun.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.tjoeun.vo.CeoVO;
import com.tjoeun.vo.ElecapprsawonVO;
import com.tjoeun.vo.SearchVO;

public interface ApprovalDAO {

	void CeoInsert(CeoVO ceoVO);
	void elecapprsawonInsert(ElecapprsawonVO elecapprsawonVO);
	int selectApprovalCountByCeo(CeoVO ceoVO);
	ArrayList<CeoVO> selectApprovalListByCeo(HashMap<String, Object> hmap);
	int selectApprovalCount(ElecapprsawonVO elecapprsawonVO);
	ArrayList<ElecapprsawonVO> selectApprovalList(HashMap<String, Object> hmap);
	
	// 검색 기능 - 사장
	int searchApprovalSubjectCountByCeo(CeoVO ceoVO);
	int searchApprovalContentCountByCeo(CeoVO ceoVO);
	int searchApprovalNameCountByCeo(CeoVO ceoVO);
	ArrayList<CeoVO> selectApprovalSubjectListByCeo(SearchVO searchVO);
	ArrayList<CeoVO> selectApprovalContentListByCeo(SearchVO searchVO);
	ArrayList<CeoVO> selectApprovalNameListByCeo(SearchVO searchVO);
	// 검색 기능 - 사원
	int searchApprovalSubjectCountByEle(CeoVO ceoVO);
	int searchApprovalContentCountByEle(CeoVO ceoVO);
	ArrayList<ElecapprsawonVO> selectApprovalSubjectListByEle(SearchVO searchVO);
	ArrayList<ElecapprsawonVO> selectApprovalContentListByEle(SearchVO searchVO);

}
