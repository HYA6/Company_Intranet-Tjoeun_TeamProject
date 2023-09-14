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

import com.tjoeun.dao.FreeBoardDAO;
import com.tjoeun.vo.FreeBoardList;
import com.tjoeun.vo.FreeBoardVO;


@Controller
public class FreeboardController {
	private static final Logger logger = LoggerFactory.getLogger(FreeboardController.class);

	@Autowired
	private SqlSession sqlSession;	
	
	// 자유게시판 글 목록
	@RequestMapping("/freeboardList")
	public String freeboardList(HttpServletRequest request, Model model) { 
		logger.info("freeboardList");
		FreeBoardDAO mapper = sqlSession.getMapper(FreeBoardDAO.class); 
		
		int pageSize = 10;
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) { }
		
		int totalCount = mapper.selfoCount();
		logger.info("{}", totalCount);
		
		FreeBoardList list = new FreeBoardList(pageSize, totalCount, currentPage);
		
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("startNo", list.getStartNo());
		hmap.put("endNo", list.getEndNo());
		list.setList3(mapper.selfoList(hmap));
		logger.info("{}", list);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("freeboardList", list);
		
		return "freeboardListView"; 
	}	
	
	   //자유게시판 글 쓰는 페이지 열기
	  @RequestMapping("/freeboardInsert") 
	  public String freeboardInsert(HttpServletRequest request, Model model, FreeBoardVO freeBoardVO) { 
		  return "freeboardInsert"; 
	 }
	  
	  
	  // 자유게시판 내용 저장
	  @RequestMapping("/freeboardInsertOK") 
	  public String freeboardInsertOK(HttpServletRequest request, Model model, FreeBoardVO freeBoardVO) { 
		  FreeBoardDAO mapper = sqlSession.getMapper(FreeBoardDAO.class); 
		  mapper.fboardinsert(freeBoardVO);
		  return "redirect:freeboardList"; 
	}
	  
	  
	  
	  // 자유게시판 글 한 건 얻어오기.
	  @RequestMapping("/freeboardIdx") 
	  public String freeboardIdx(HttpServletRequest request, Model model, FreeBoardVO freeBoardVO) { 
		  logger.info("freeboardIdx"); 
		  FreeBoardDAO mapper = sqlSession.getMapper(FreeBoardDAO.class); 
		  FreeBoardVO fo = mapper.fboardByIdx(freeBoardVO); 
		  logger.info("{}",fo);
		  model.addAttribute("fo", fo);
		  model.addAttribute("currentPage", request.getParameter("currentPage"));
		  return "freeboardContentView"; 
	}
	  
	  
	  // 자유게시판 수정 페이지 열기
	  @RequestMapping("/freeboardUpdate") 
	  public String freeboardUpdate(HttpServletRequest request, Model model, FreeBoardVO freeBoardVO) { 
		  logger.info("freeboardUpdate"); 
		  model.addAttribute("fo", freeBoardVO);
		  model.addAttribute("currentPage", request.getParameter("currentPage"));
		  return "freeboardUpdate"; 
	}
	  
	  
	  // 자유게시판 수정할 내용 저장
	  @RequestMapping("/freeboardUpdateOK") 
	  public String freeboardUpdateOK(HttpServletRequest request, Model model, FreeBoardVO freeBoardVO) {
		  logger.info("fupdateOK"); 
		  FreeBoardDAO mapper = sqlSession.getMapper(FreeBoardDAO.class); 
		  mapper.fboardUpdate(freeBoardVO);
		  model.addAttribute("currentPage", request.getParameter("currentPage"));
		  model.addAttribute("cnum", request.getParameter("cnum")); 
		  return "redirect:freeboardList"; 
	}

	  
	  // 자유게시판 삭제
	  @RequestMapping("/freeboardDelete") 
	  public String freeboardDelete(HttpServletRequest request, Model model, FreeBoardVO freeBoardVO) { 
		  logger.info("fboardDelete");
		  FreeBoardDAO mapper = sqlSession.getMapper(FreeBoardDAO.class);
		  mapper.fboardDelete(freeBoardVO); 
		  model.addAttribute("currentPage", request.getParameter("currentPage")); 
		  model.addAttribute("cnum",request.getParameter("cnum")); 
		  return "redirect:freeboardList"; 
	}
	  
	  
	 
	
	
}
