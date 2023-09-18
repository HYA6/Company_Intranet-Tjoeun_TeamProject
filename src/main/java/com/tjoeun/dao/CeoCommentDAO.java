package com.tjoeun.dao;

import com.tjoeun.vo.CeoVO;

public interface CeoCommentDAO {

	CeoVO selectByIdxCeoComment(CeoVO ceoVO);

	void ceoCommentinsert(CeoVO ceoVO);

	void updateStatus(CeoVO ceoVO);

	void update(CeoVO ceoVO);

	void delete(CeoVO ceoVO);

	void updateFileCeo(CeoVO ceoVO);
	
}
