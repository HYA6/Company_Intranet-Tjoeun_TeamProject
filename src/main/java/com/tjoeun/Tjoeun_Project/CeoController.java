package com.tjoeun.Tjoeun_Project;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tjoeun.dao.CeoDao;
import com.tjoeun.vo.CeoList;
import com.tjoeun.vo.CeoVO;
import com.tjoeun.vo.SearchVO;

@Controller
public class CeoController {
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(CeoController.class);
	
	// 사장이 보는 결재 목록 불러오기(CeoView.jsp)
	@RequestMapping("/Ceo")
	public String Ceo(HttpServletRequest request, Model model, CeoVO ceoVO) {
		logger.info("CeoController의 CeoView");
		
		CeoDao mapper = sqlSession.getMapper(CeoDao.class);
		
//		logger.info("{}", ceoVO);
		String category = "";
		try {
			category = request.getParameter("category");
		} catch (NullPointerException e) { }
		int pageSize = 10;
		int currentPage = 1;
		int totalCount = 0;
		CeoList ceoList = new CeoList(pageSize, totalCount, currentPage);
		
		if (category == null) {
			// 사장이 보는 결재글 전체 개수 불러오기
			try {
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			} catch (NumberFormatException e){}
			totalCount = mapper.selectsawonCountByCeo(ceoVO);
//			logger.info("{}", totalCount);
			
			ceoList = new CeoList(pageSize, totalCount, currentPage);
			
			// 사장이 보는 결재글 목록 불러오기
			HashMap<String, Integer> hmap = new HashMap<String, Integer>();
			hmap.put("startNo", ceoList.getStartNo());
			hmap.put("endNo", ceoList.getEndNo());
			ceoList.setList(mapper.selectsawonListByCeo(hmap));
		} else {
			// 카테고리가 있으면 검색어에 따른 결재글 개수 불러오기
			if (category.equals("결재 종류")) {
				totalCount = mapper.searchPaperCountByCeo(ceoVO);
//				logger.info("{}", totalCount);
			} else if (category.equals("제목")) {
				totalCount = mapper.searchSubjectCountByCeo(ceoVO);
//				logger.info("{}", totalCount);
			} else if (category.equals("내용")) {
				totalCount = mapper.searchContentCountByCeo(ceoVO);
//				logger.info("{}", totalCount);
			} else if (category.equals("이름")) {
				totalCount = mapper.searchNameCountByCeo(ceoVO);
//				logger.info("{}", totalCount);
			}
			
			ceoList = new CeoList(pageSize, totalCount, currentPage);
			
			// 카테고리가 있으면 검색어에 따른 결재글 목록 불러오기
			SearchVO searchVO = new SearchVO();
			searchVO.setStartNo(ceoList.getStartNo());
			searchVO.setEndNo(ceoList.getEndNo());
			searchVO.setItem(ceoVO.getItem());
			if (category.equals("결재 종류")) {
				ceoList.setList(mapper.selectPaperListByCeo(searchVO));
			} else if (category.equals("제목")) {
				ceoList.setList(mapper.selectSubjectListByCeo(searchVO));
			} else if (category.equals("내용")) {
				ceoList.setList(mapper.selectContentListByCeo(searchVO));
			} else if (category.equals("이름")) {
				ceoList.setList(mapper.selectNameListByCeo(searchVO));
			}
		}
		
		// 결재 목록이 전체인지 개별인지 구분하는 변수에 전체 목록이므로 "NO" 삽입
		ceoVO.setApproval("NO");
		
		model.addAttribute("ceoList", ceoList);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("approval", ceoVO.getApproval());
		
		return "CeoView";
	}
	
}