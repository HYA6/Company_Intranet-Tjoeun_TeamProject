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

import com.tjoeun.dao.ElecapprsawonDAO;
import com.tjoeun.vo.ElecapprsawonList;
import com.tjoeun.vo.ElecapprsawonVO;
import com.tjoeun.vo.SearchVO;

@Controller
public class SawonController {

	private static final Logger logger = LoggerFactory.getLogger(SawonController.class);

	@Autowired
	private SqlSession sqlSession;
	
	// 사원이 보는 결재 목록 불러오기(elecapprsawonListView.jsp)
	@RequestMapping("/elecapprsawonList")
	public String elecapprsawonList(HttpServletRequest request, Model model, ElecapprsawonVO elecapprsawonVO) { 
		logger.info("SawonController의 elecapprsawonList()");
		
		ElecapprsawonDAO mapper = sqlSession.getMapper(ElecapprsawonDAO.class); 
		
		int cnum = Integer.parseInt(request.getParameter("cnum"));
		String category = "";
		try {
			category = request.getParameter("category");
		} catch (NullPointerException e) { }
		int pageSize = 10;
		int currentPage = 1;
		int totalCount = 0;
		ElecapprsawonList list = new ElecapprsawonList(pageSize, totalCount, currentPage);
		
		if (category == null) {
			// 테이블의 전체 글 개수 얻어오기
			try {
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			} catch (NumberFormatException e) { }
			totalCount = mapper.selectsawonCount(elecapprsawonVO);
//			logger.info("{}", totalCount);
			
			list = new ElecapprsawonList(pageSize, totalCount, currentPage);
			
			HashMap<String, Integer> hmap = new HashMap<String, Integer>();
			hmap.put("cnum", Integer.parseInt(request.getParameter("cnum")));
			hmap.put("startNo", list.getStartNo());
			hmap.put("endNo", list.getEndNo());
			list.setList(mapper.selectsawonList(hmap));
		} else {
			// 카테고리가 있으면 검색어에 따른 결재글 개수 불러오기
			if (category.equals("결재 종류")) {
				totalCount = mapper.searchPaperCountByEle(elecapprsawonVO);
//				logger.info("{}", totalCount);
			} else if (category.equals("제목")) {
				totalCount = mapper.searchSubjectCountByEle(elecapprsawonVO);
//				logger.info("제목 검색 개수: {}", totalCount);
			} else if (category.equals("내용")) {
				totalCount = mapper.searchContentCountByEle(elecapprsawonVO);
//				logger.info("{}", totalCount);
			}
			
			list = new ElecapprsawonList(pageSize, totalCount, currentPage);
			
			// 카테고리가 있으면 검색어에 따른 결재글 목록 불러오기
			SearchVO searchVO = new SearchVO();
			searchVO.setCnum(cnum);
			searchVO.setStartNo(list.getStartNo());
			searchVO.setEndNo(list.getEndNo());
			searchVO.setItem(elecapprsawonVO.getItem());
			if (category.equals("결재 종류")) {
				list.setList(mapper.selectPaperListByEle(searchVO));
			} else if (category.equals("제목")) {
				list.setList(mapper.selectSubjectListByEle(searchVO));
			} else if (category.equals("내용")) {
				list.setList(mapper.selectContentListByEle(searchVO));
			}
		}
		
		// 결재 목록이 전체인지 개별인지 구분하는 변수에 전체 목록이므로 "NO" 삽입
		elecapprsawonVO.setApproval("NO");
		
		model.addAttribute("elecapprsawonList", list);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("approval", elecapprsawonVO.getApproval());
		
		return "elecapprsawonListView"; 
	}
	  
	// 사원이 보는 글 한건 얻어오기(sawonContentView.jsp)
	@RequestMapping("/selectsawonIdx")
    public String selectsawonIdx(HttpServletRequest request, Model model, ElecapprsawonVO elecapprsawonVO) {
        logger.info("SawonController의 selectsawonIdx()");
        ElecapprsawonDAO mapper = sqlSession.getMapper(ElecapprsawonDAO.class);
        ElecapprsawonVO eo = mapper.selectsawonIdx(elecapprsawonVO);
        logger.info("eo: {}", eo);
        model.addAttribute("eo", eo);
        model.addAttribute("currentPage", request.getParameter("currentPage"));
        model.addAttribute("approval", elecapprsawonVO.getApproval());
		model.addAttribute("enter", "\r\n");
        return "elecapprsawonContentView";
	}
	
	// 사원이 본인이 쓴 글 수정하는 페이지
	@RequestMapping("/elecapprsawonUpdate")
	public String update(HttpServletRequest request, Model model, ElecapprsawonVO elecapprsawonVO) {
		logger.info("SawonController의 elecapprsawonUpdate()");
		ElecapprsawonDAO mapper = sqlSession.getMapper(ElecapprsawonDAO.class);
        ElecapprsawonVO eo = mapper.selectsawonIdx(elecapprsawonVO);
        logger.info("eo: {}", eo);
        model.addAttribute("eo", eo);
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		model.addAttribute("enter", "\r\n");
		return "elecapprsawonUpdate";
	}
	
	// 사원이 수정할 정보 저장 후 목록으로 가기
	@RequestMapping("/elecapprsawonUpdateOK")
	public String updateOK(MultipartHttpServletRequest request, Model model, ElecapprsawonVO elecapprsawonVO) {
		logger.info("SawonController의 elecapprsawonUpdateOK()");
		ElecapprsawonDAO mapper = sqlSession.getMapper(ElecapprsawonDAO.class);
		
		// 업로드하는 파일이 저장될 업로드 디렉토리(폴더)를 지정한다.
//		logger.info("{}", File.separator);
		String rootUploadDir = "C:/Tjoeun_Data/Upload"; // C:/Tjoeun_Data/Upload
//		logger.info("{}", rootUploadDir);
		File dir = new File(rootUploadDir + File.separator);
		
		// 업로드 디렉토리가 존재하지 않을 경우 업로드 디렉토리를 만든다.
		// File 클래스 객체 dir에 디렉토리가 존재하지 않을 경우 mkdirs() 메소드로 디렉토리를 만든다.
//		logger.info("{}", dir.exists());
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
			mapper.update(elecapprsawonVO);
		} else {
			elecapprsawonVO.setFilename(originalName);
//			logger.info("{}", elecapprsawonVO);
			mapper.updateFile(elecapprsawonVO);
		}
		
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		model.addAttribute("cnum", request.getParameter("cnum"));
		model.addAttribute("enter", "\r\n");
		// 결재 목록 확인 정보가 "YES"로 넘어왔으면 결재 종류에 따른 목록 불러오기
		if (elecapprsawonVO.getApproval().equals("YES")) {
			model.addAttribute("paper", elecapprsawonVO.getPaper());
			return "redirect:approvalList";
		} else {
			return "redirect:elecapprsawonList";
		}
	}
	
	// 사원이 쓴 글 삭제하기
	@RequestMapping("/elecapprsawonDelete")
	public String delete(HttpServletRequest request, Model model, ElecapprsawonVO elecapprsawonVO) {
		logger.info(request.getParameter("SawonController의 elecapprsawonDelete()"));
		ElecapprsawonDAO mapper = sqlSession.getMapper(ElecapprsawonDAO.class);
		mapper.delete(elecapprsawonVO);
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		model.addAttribute("cnum", request.getParameter("cnum"));
		// 결재 종류가 넘어왔으면 결재 종류에 따른 목록 불러오기
		if (elecapprsawonVO.getApproval().equals("YES")) {
			model.addAttribute("paper", elecapprsawonVO.getPaper());
			return "redirect:approvalList";
		} else {
			return "redirect:elecapprsawonList";
		}
	}
	
}