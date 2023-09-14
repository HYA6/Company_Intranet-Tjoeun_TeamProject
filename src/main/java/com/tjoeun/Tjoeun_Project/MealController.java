package com.tjoeun.Tjoeun_Project;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.tjoeun.dao.MealDAO;
import com.tjoeun.vo.Board_MealList;
import com.tjoeun.vo.Board_MealVO;

@Controller
public class MealController {

	private static final Logger logger = LoggerFactory.getLogger(MealController.class);
	
	// 이미지 파일이 저장된 경로 설정
    private static final String IMAGE_UPLOAD_DIR = "C:/Tjoeun_Data/mealImages/";
	

	@Autowired
	private SqlSession sqlSession;
	
	
	@RequestMapping("/mealListView")
	public String mealListView(HttpServletRequest request, Model model, HttpSession session) {
		
		// 로그인 세션 찾고, 없으면 로그인 컨트롤러 내 로그인으로 퇴출
		Object loginSession = session.getAttribute("mvo");
		if ( loginSession == null ) return "redirect:login";
		
		MealDAO mapper = sqlSession.getMapper(MealDAO.class);
		
		// 전체 임원이 보는 식단표 전체 개수 불러오기
		int pageSize = 10;
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e){}
		int totalCount = mapper.selectMealCount();
		logger.info("{}", totalCount);
						
		Board_MealList mealList = new Board_MealList(pageSize, totalCount, currentPage);
						
		// 전체 임원이 보는 글 목록 불러오기
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("startNo", mealList.getStartNo());
		hmap.put("endNo", mealList.getEndNo());
		mealList.setList(mapper.selectMealList(hmap));
						
		model.addAttribute("mealList", mealList);
		model.addAttribute("currentPage", currentPage);
				
		
		
		return "mealListView";
	}
	
	@RequestMapping("/mealContentView")
	public String mealContentView(HttpSession session, HttpServletRequest request, Model model) {
		
		Object loginSession = session.getAttribute("mvo");
		if ( loginSession == null ) return "redirect:login";
		
		int idx = 1;
		int currentPage = 1;
		try {
			idx = Integer.parseInt(request.getParameter("idx"));
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
			} catch (NumberFormatException e) { }
		
		
		MealDAO mapper = sqlSession.getMapper(MealDAO.class);
		
		// 글 번호에 따른 식단표 글 1건 받아오기
		Board_MealVO bmo = mapper.selectMealbyIdx(idx);
		logger.info("{}", bmo.getFilename());
		
		model.addAttribute("bmo", bmo);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("enter", "\r\n");
		return "mealContentView";
	}
	
	
	
	@RequestMapping("/mealInsert")
	public String mealInsert(HttpServletRequest request, Model model, HttpSession session) {
		
		Object loginSession = session.getAttribute("mvo");
		if ( loginSession == null ) return "redirect:login";
		
		return "mealInsert";
	}
	
	
	@RequestMapping("/mealInsertOK")
	public String mealInsertOK(HttpSession session, @RequestParam("imageFile") MultipartFile file,
			Board_MealVO mealVO) {

		Object loginSession = session.getAttribute("mvo");
		if (loginSession == null)
			return "redirect:login";

		logger.info("mealVO : {}", mealVO);

		MealDAO mapper = sqlSession.getMapper(MealDAO.class);
		if (!file.isEmpty()) {
			try {
				// 들어온 파일의 이름을 변수로 설정
				String originalFilename = file.getOriginalFilename();

				// 새로운 이름변수 ( 현재 시간 + 파일 이름 ) 설정
				String newFilename = System.currentTimeMillis() + "_" + originalFilename;
				// String absoluteUploadPath = servletContext.getRealPath(UPLOAD_DIR);
				// logger.info(absoluteUploadPath);

				// 경로 변수로 File 타입 목적지 변수 설정
				File destination = new File(IMAGE_UPLOAD_DIR, newFilename);

				// 만약 디렉토리가 존재하지 않다면
				if (!destination.getParentFile().exists()) {

				// 디렉토리 만들기, 목적지로 파일 보내기
					destination.getParentFile().mkdirs();
					file.transferTo(destination);
					logger.info("만들어서 보낸 최종 목적지 : {}", destination);
				} else {
					logger.info("있어서 보낸 최종 목적지 : {}", destination);
					file.transferTo(destination);
				}
				logger.info("filename 넣기 전 mealVO : {}", mealVO);
				
				mealVO.setFilename(newFilename); // 업로드된 파일명을 mealVO에 설정

				logger.info("최종 mealVO : {}", mealVO);

				// Mapper를 통한 DB 저장 등 추가 작업 수행
				mapper.mealinsert(mealVO);

				return "redirect:mealListView";
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			// 업로드된 이미지가 없을 때 처리
			mapper.mealinsert(mealVO);

			return "redirect:mealListView";
		}

		return "redirect:mealListView";
	}
	

	@RequestMapping("/mealUpdate")
	public String mealContentUpdate(HttpSession session, Model model, Board_MealVO bmo, int currentPage) {

		Object loginSession = session.getAttribute("mvo");
		if ( loginSession == null ) return "redirect:login";		
		
		logger.info("bmo : {}", bmo);
		
		model.addAttribute("bmo", bmo);
		model.addAttribute("currentPage", currentPage);
		return "mealUpdate";
	}
	
	@RequestMapping("/mealContentDelete")
	public String mealContentDelete(HttpSession session, Board_MealVO bmo) {
		
		Object loginSession = session.getAttribute("mvo");
		if ( loginSession == null ) return "redirect:login";
		
		logger.info(" Delete idx : {}", bmo.getIdx());
		logger.info("bmo : {}", bmo);
		// 이미지가 있을 경로 설정 
		
		// 경로를 포함하는 파일 이름 변수 설정
		File deleteFile = new File(IMAGE_UPLOAD_DIR, bmo.getFilename());
		MealDAO mapper = sqlSession.getMapper(MealDAO.class);
		
		
		// db에 있는 게시물 삭제
		mapper.mealdelete(bmo.getIdx());
		// 만약 파일이 있을경우 파일 삭제.
		if ( deleteFile.exists() ) deleteFile.delete();
				
		
		return "redirect:mealListView";
	}
	
	
}
