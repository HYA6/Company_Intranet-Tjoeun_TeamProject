package com.tjoeun.Tjoeun_Project;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.tjoeun.dao.ApprovalDAO;
import com.tjoeun.vo.CeoList;
import com.tjoeun.vo.CeoVO;
import com.tjoeun.vo.ElecapprsawonList;
import com.tjoeun.vo.ElecapprsawonVO;
import com.tjoeun.vo.SearchVO;

@Controller
public class ApprovalController {

	private static final Logger logger = LoggerFactory.getLogger(ApprovalController.class);

	@Autowired
	private SqlSession sqlSession;
	
	// 결재안에 따른 목록 불러오기
	@RequestMapping("/approvalList")
	public String approvalList(HttpServletRequest request, Model model, ElecapprsawonVO elecapprsawonVO, CeoVO ceoVO) {
		logger.info("ApprovalController 클래스의 approvalList() 메소드 실행");
		
		ApprovalDAO mapper = sqlSession.getMapper(ApprovalDAO.class);
		
//		logger.info("{}", ceoVO);
		int cnum = Integer.parseInt(request.getParameter("cnum"));
		String category = "";
		String paper = "";
		try {
			paper = request.getParameter("paper");
			category = request.getParameter("category");
		} catch (NullPointerException e) { }
		
		int pageSize = 10;
		int currentPage = 1;
		int totalCount = 0;
		CeoList ceoList = new CeoList(pageSize, totalCount, currentPage);
		ElecapprsawonList list = new ElecapprsawonList(pageSize, totalCount, currentPage);
		
		if (category == null) {
			// 사장이 보는 결재 종류별로 결재글 전체 개수 불러오기
			try {
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			} catch (NumberFormatException e){}
			totalCount = mapper.selectApprovalCountByCeo(ceoVO);
//			logger.info("{}", totalCount);
			
			// 사장이 보는 결재글 목록 불러오기
			ceoList = new CeoList(pageSize, totalCount, currentPage);
			HashMap<String, Object> hmap = new HashMap<String, Object>();
			hmap.put("startNo", ceoList.getStartNo());
			hmap.put("endNo", ceoList.getEndNo());
			hmap.put("paper", paper);
			ceoList.setList(mapper.selectApprovalListByCeo(hmap));
			
			// 사원이 보는 결재 종류별로 결재글 전체 개수 불러오기
			pageSize = 10;
			currentPage = 1;
			try {
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			} catch (NumberFormatException e) { }
			totalCount = mapper.selectApprovalCount(elecapprsawonVO);
	//		logger.info("{}", totalCount);
			
			// 사원이 보는 결재글 목록 불러오기
			list = new ElecapprsawonList(pageSize, totalCount, currentPage);
			HashMap<String, Object> hmap_e = new HashMap<String, Object>();
			hmap_e.put("cnum", cnum);
			hmap_e.put("startNo", list.getStartNo());
			hmap_e.put("endNo", list.getEndNo());
			hmap_e.put("paper", paper);
			list.setList(mapper.selectApprovalList(hmap_e));
//			logger.info("{}", list);

		} else {
			if (cnum == 220) {
				// 사장이면
				// 카테고리가 있으면 검색어에 따른 결재글 개수 불러오기
				if (category.equals("제목")) {
					totalCount = mapper.searchApprovalSubjectCountByCeo(ceoVO);
//					logger.info("제목 검색 개수: {}", totalCount);
				} else if (category.equals("내용")) {
					totalCount = mapper.searchApprovalContentCountByCeo(ceoVO);
//					logger.info("{}", totalCount);
				} else if (category.equals("이름")) {
					totalCount = mapper.searchApprovalNameCountByCeo(ceoVO);
//					logger.info("{}", totalCount);
				}
				
				ceoList = new CeoList(pageSize, totalCount, currentPage);
				
				// 카테고리가 있으면 검색어에 따른 결재글 목록 불러오기
				SearchVO searchVO = new SearchVO();
				searchVO.setStartNo(ceoList.getStartNo());
				searchVO.setEndNo(ceoList.getEndNo());
				searchVO.setItem(ceoVO.getItem());
				searchVO.setPaper(paper);
				if (category.equals("제목")) {
					ceoList.setList(mapper.selectApprovalSubjectListByCeo(searchVO));
				} else if (category.equals("내용")) {
					ceoList.setList(mapper.selectApprovalContentListByCeo(searchVO));
				} else if (category.equals("이름")) {
					ceoList.setList(mapper.selectApprovalNameListByCeo(searchVO));
				}
			} else {
				// 사원이면
				// 카테고리가 있으면 검색어에 따른 결재글 개수 불러오기
				if (category.equals("제목")) {
					totalCount = mapper.searchApprovalSubjectCountByEle(ceoVO);
//					logger.info("제목 검색 개수: {}", totalCount);
				} else if (category.equals("내용")) {
					totalCount = mapper.searchApprovalContentCountByEle(ceoVO);
//					logger.info("{}", totalCount);
				}
				
				list = new ElecapprsawonList(pageSize, totalCount, currentPage);
				
				// 카테고리가 있으면 검색어에 따른 결재글 목록 불러오기
				SearchVO searchVO = new SearchVO();
				searchVO.setCnum(cnum);
				searchVO.setStartNo(list.getStartNo());
				searchVO.setEndNo(list.getEndNo());
				searchVO.setItem(elecapprsawonVO.getItem());
				searchVO.setPaper(paper);
				if (category.equals("제목")) {
					list.setList(mapper.selectApprovalSubjectListByEle(searchVO));
				} else if (category.equals("내용")) {
					list.setList(mapper.selectApprovalContentListByEle(searchVO));
				}
			}
		}
		
		// 결재 목록이 전체인지 개별인지 구분하는 변수에 개별 목록이므로 "YES" 삽입
		ceoVO.setApproval("YES");
		elecapprsawonVO.setApproval("YES");
		
		// 결재안에 따라 보여지는 페이지 별로 return하기
		model.addAttribute("paper", paper);
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		if (cnum == 220) {
			model.addAttribute("ceoList", ceoList);
			model.addAttribute("approval", ceoVO.getApproval());
			return "CeoApprovalList";
		} else {
			model.addAttribute("elecapprsawonList", list);
			model.addAttribute("approval", elecapprsawonVO.getApproval());
			return "approvalList";
		}
		
	}
	
	// 결재안 쓰는 페이지 불러오기(approvalInsert.jsp)
	@RequestMapping("/approvalInsert")
	public String approvalInsert(HttpServletRequest request, Model model) {
		logger.info("ApprovalController 클래스의 approvalInsert() 메소드 실행");
		try {
			String paper = request.getParameter("paper").trim();
			model.addAttribute("paper", paper);
		} catch (Exception e) { }
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		return "approvalInsert";
	}
	
	// 결재안 저장
	@RequestMapping("/insert")
	public String insert(MultipartHttpServletRequest request, Model model, ElecapprsawonVO elecapprsawonVO, CeoVO ceoVO) {
		logger.info("ApprovalController 클래스의 insert() 메소드 실행");
		ApprovalDAO mapper = sqlSession.getMapper(ApprovalDAO.class);
		
		String paper = request.getParameter("paper").trim();
		String each = "";
		try {
			each = request.getParameter("each").trim();
			logger.info(each);
		} catch (Exception e) { }
		
		// 업로드하는 파일이 저장될 업로드 디렉토리(폴더)를 지정한다.
//			logger.info("{}", File.separator);
		String rootUploadDir = "C:/Tjoeun_Data/Upload"; // C:/Tjoeun_Data/Upload
//			logger.info("{}", rootUploadDir);
		File dir = new File(rootUploadDir + File.separator);
		
		// 업로드 디렉토리가 존재하지 않을 경우 업로드 디렉토리를 만든다.
		// File 클래스 객체 dir에 디렉토리가 존재하지 않을 경우 mkdirs() 메소드로 디렉토리를 만든다.
//			logger.info("{}", dir.exists());
		if (!dir.exists()) {
			dir.mkdirs();
		}
		
		// 업로드되는 파일 정보 수집(2개: file1, file2)
		Iterator<String> iterator = request.getFileNames();
		String uploadFilename = "";
		MultipartFile multipartFile = null;
		String originalName = "";
		
		while (iterator.hasNext()) {
			uploadFilename = iterator.next();
			multipartFile = request.getFile(uploadFilename);
			originalName = System.currentTimeMillis() + "_" + multipartFile.getOriginalFilename();
//			logger.info("파일 시스템 이름?: {}",multipartFile);
//			logger.info("파일 이름: {}",originalName);
			
			if (originalName != null && originalName.length() != 0) {
				// MultipartFile 인터페이스 객체에서 transferTo() 메소드로 File 객체를 만들어 업로드한다.
				try {
					// C:\Upload\testfile\originalName(파일이름)
					multipartFile.transferTo(new File(dir + File.separator + originalName));
				} catch (Exception e) {
					System.out.println("파일 업로드 중 에러 발생");
				}
			}
		}
		
		if (multipartFile.getOriginalFilename().equals("")) {
			if (ceoVO.getCnum() == 220) {
				ceoVO.setFilename("");
//				logger.info("{}", ceoVO);
				mapper.CeoInsert(ceoVO);
			} else {
				elecapprsawonVO.setFilename("");
//				logger.info("{}", elecapprsawonVO);
				mapper.elecapprsawonInsert(elecapprsawonVO);
			}
		} else {
			if (ceoVO.getCnum() == 220) {
				ceoVO.setFilename(originalName);
//				logger.info("{}", ceoVO);
				mapper.CeoInsert(ceoVO);
			} else {
				elecapprsawonVO.setFilename(originalName);
//				logger.info("{}", elecapprsawonVO);
				mapper.elecapprsawonInsert(elecapprsawonVO);
			}
			
		}
		model.addAttribute("cnum", request.getParameter("cnum"));
		model.addAttribute("paper", paper);
		if (each != "") {
			if (ceoVO.getCnum() == 220) {
				return "redirect:Ceo";
			} else {
				return "redirect:elecapprsawonList";
			}
		} else {
			return "redirect:approvalList";
		}
	}
	
}