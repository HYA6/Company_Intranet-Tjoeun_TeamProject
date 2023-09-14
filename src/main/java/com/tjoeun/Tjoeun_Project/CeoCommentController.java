package com.tjoeun.Tjoeun_Project;

import java.io.File;
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

import com.tjoeun.dao.CeoCommentDAO;
import com.tjoeun.vo.CeoVO;

@Controller
public class CeoCommentController {
	
	private static final Logger logger = LoggerFactory.getLogger(CeoCommentController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	// 사장 결재 확인 페이지 열기
	@RequestMapping("/CeoComment")
	public String CeoComment(HttpServletRequest request, Model model, CeoVO ceoVO) {
		logger.info("CeoCommentController 클래스의 CeoComment() 메소드 실행");
		// mapper 만들기
		CeoCommentDAO mapper = sqlSession.getMapper(CeoCommentDAO.class);
		
		// 코멘트를 달 결재글 1건 얻어오는 메소드 호출
		CeoVO co = mapper.selectByIdxCeoComment(ceoVO);
		logger.info("co: {}", co);
		// 코멘트를 달 결재글 1건이 저장된 VO와 목록창의 현재 페이지, 엔터 지정
		model.addAttribute("co", co);
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		model.addAttribute("approval", ceoVO.getApproval());
		model.addAttribute("enter", "\r\n");
		return "CeoComment";
	}
	
	// 사장이 본인이 쓴 글 수정하는 페이지
	@RequestMapping("/CeoUpdate")
	public String CeoUpdate(HttpServletRequest request, Model model, CeoVO ceoVO) {
		logger.info("CeoCommentController 클래스의 CeoUpdate() 메소드 실행");
		CeoCommentDAO mapper = sqlSession.getMapper(CeoCommentDAO.class);
		CeoVO co = mapper.selectByIdxCeoComment(ceoVO);
		logger.info("co: {}", co);
		model.addAttribute("co", co);
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		model.addAttribute("enter", "\r\n");
		return "CeoUpdate";
	}
	
	// 사장이 수정할 정보 저장 후 목록으로 가기
	@RequestMapping("/CeoUpdateOK")
	public String CeoUpdateOK(MultipartHttpServletRequest request, Model model, CeoVO ceoVO) {
		logger.info("CeoCommentController 클래스의 CeoUpdateOK() 메소드 실행");
		CeoCommentDAO mapper = sqlSession.getMapper(CeoCommentDAO.class);
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
		
//		logger.info("{}", multipartFile.getOriginalFilename());
		
		if (multipartFile.getOriginalFilename().equals("")) {
			mapper.update(ceoVO);
		} else {
			ceoVO.setFilename(originalName);
//			logger.info("{}", elecapprsawonVO);
			mapper.updateFileCeo(ceoVO);
		}
		
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		model.addAttribute("enter", "\r\n");
		// 결재 목록 확인 정보가 "YES"로 넘어왔으면 결재 종류에 따른 목록 불러오기
		if (ceoVO.getApproval().equals("YES")) {
			model.addAttribute("cnum", ceoVO.getCnum());
			model.addAttribute("paper", ceoVO.getPaper());
			return "redirect:approvalList";
		} else {
			return "redirect:Ceo";
		}
	}
	
	// 사장이 쓴 글 삭제 후 목록으로 가기
	@RequestMapping("/CeoDelete")
	public String CeoDelete(HttpServletRequest request, Model model, CeoVO ceoVO) {
		logger.info("CeoCommentController 클래스의 CeoDelete() 메소드 실행");
		CeoCommentDAO mapper = sqlSession.getMapper(CeoCommentDAO.class);
		mapper.delete(ceoVO);
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		if (ceoVO.getApproval().equals("YES")) {
			model.addAttribute("cnum", ceoVO.getCnum());
			model.addAttribute("paper", ceoVO.getPaper());
			return "redirect:approvalList";
		} else {
			return "redirect:Ceo";
		}
	}
	
	// 결재 상태를 승인으로 바꾸기
	@RequestMapping("/CeoCommentUpdate")
	public String CeoCommentUpdate(HttpServletRequest request, Model model, CeoVO ceoVO) {
		logger.info("CeoCommentController 클래스의 CeoCommentUpdate() 메소드 실행");
		CeoCommentDAO mapper = sqlSession.getMapper(CeoCommentDAO.class);
		mapper.updateStatus(ceoVO);
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		if (ceoVO.getApproval().equals("YES")) {
			model.addAttribute("cnum", ceoVO.getCnum());
			model.addAttribute("paper", ceoVO.getPaper());
			return "redirect:approvalList";
		} else {
			return "redirect:Ceo";
		}
	}
	
	// 팝업창 열기
	@RequestMapping("/CeoComment_Popup")
	public String CeoComment_Popup(HttpServletRequest request, Model model, CeoVO ceoVO) {
		logger.info("CeoCommentController 클래스의 CeoComment_Popup() 메소드 실행");
		
		// mapper 만들기
		CeoCommentDAO mapper = sqlSession.getMapper(CeoCommentDAO.class);
		// 코멘트를 달 결재글 1건 얻어오는 메소드 호출
		CeoVO co = mapper.selectByIdxCeoComment(ceoVO);
		// 코멘트를 달 결재글 1건이 저장된 VO 지정
		model.addAttribute("co", co);
		model.addAttribute("enter", "\r\n");
		
		return "CeoComment_Popup";
	}
	
	// 코멘트 입력(수정) 후 팝업창 닫기
	@RequestMapping("/CeoCommentSend")
	public String CeoCommentSend(HttpServletRequest request, Model model, CeoVO ceoVO) {
		logger.info("CeoCommentController 클래스의 CeoCommentSend() 메소드 실행");
		
		// mapper 만들기
		CeoCommentDAO mapper = sqlSession.getMapper(CeoCommentDAO.class);
		// 코멘트 저장하기
		mapper.ceoCommentinsert(ceoVO);
		model.addAttribute("enter", "\r\n");
		
		// 팝업창 닫으러 ㄱㄱ
		return "CeoComment_PopupClose";
	}
	
}
