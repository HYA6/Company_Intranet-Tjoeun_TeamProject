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

import com.tjoeun.dao.BoardDAO;
import com.tjoeun.vo.BoardList;
import com.tjoeun.vo.BoardVO;

@Controller
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(SawonController.class);

	@Autowired
	private SqlSession sqlSession;		
		
	
	// 공지사항 글 목록
	@RequestMapping("/boardList")
	public String boardList(HttpServletRequest request, Model model) { 
		logger.info("boardList");
		BoardDAO mapper = sqlSession.getMapper(BoardDAO.class); 
		
		int pageSize = 10;
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) { }
		
		int totalCount = mapper.selboCount();
		logger.info("{}", totalCount);
		
		BoardList list = new BoardList(pageSize, totalCount, currentPage);
		BoardList slist = new BoardList(pageSize, totalCount, 1);
		
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("startNo", list.getStartNo());
		hmap.put("endNo", list.getEndNo());
		list.setList2(mapper.selboList(hmap));
		logger.info("{}", list);
		
		HashMap<String, Integer> shmap = new HashMap<String, Integer>();
		shmap.put("startNo", slist.getStartNo());
		shmap.put("endNo", slist.getEndNo());
		slist.setList2(mapper.spcselboList(shmap));
		logger.info("{}", slist);
		
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("boardList", list);
		model.addAttribute("sboardList", slist);
		
		return "boardListView"; 
	}
	
	// 공지사항 쓰는 페이지 열기
	@RequestMapping("/boardInsert")
	public String boardInsert(HttpServletRequest request, Model model, BoardVO boardVO) {
		return "boardInsert";
	}
	
	// 공지사항 내용 저장
	@RequestMapping("/boardInsertOK")
	public String boardInsertOK(HttpServletRequest request, Model model, BoardVO boardVO) {
		BoardDAO mapper = sqlSession.getMapper(BoardDAO.class);
		mapper.boardinsert(boardVO);
		return "redirect:boardList";
	}	

	// 공지사항 글 한 건 얻어오기.
	@RequestMapping("/boardIdx")
	public String boardByIdx(HttpServletRequest request, Model model, BoardVO boardVO) {
	    logger.info("boardByIdx");
	    BoardDAO mapper = sqlSession.getMapper(BoardDAO.class);
	    BoardVO bo = mapper.boardByIdx(boardVO);
	    model.addAttribute("bo", bo);
	    model.addAttribute("currentPage", request.getParameter("currentPage"));
	    return "boardContentView";
	}
	
	// 공지사항 수정 페이지 열기
	@RequestMapping("/boardUpdate")
	public String boardUpdate(HttpServletRequest request, Model model, BoardVO boardVO) {
		logger.info("boardUpdate");
		model.addAttribute("bo", boardVO);
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		return "boardUpdate";
	}
	
	// 공지사항 수정할 내용 저장
	@RequestMapping("/boardUpdateOK")
	public String updateOK(HttpServletRequest request, Model model, BoardVO boardVO) {
		logger.info("updateOK");
		BoardDAO mapper = sqlSession.getMapper(BoardDAO.class);
		mapper.boardUpdate(boardVO);
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		model.addAttribute("cnum", request.getParameter("cnum"));
		return "redirect:boardList";
	}
	
	// 공지사항 삭제
	@RequestMapping("/boardDelete")
	public String boardDelete(HttpServletRequest request, Model model, BoardVO boardVO) {
		logger.info("boardDelete");
		BoardDAO mapper = sqlSession.getMapper(BoardDAO.class);
		mapper.boardDelete(boardVO);
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		model.addAttribute("cnum", request.getParameter("cnum"));
		return "redirect:boardList";
	}
	
	
	
	
}




