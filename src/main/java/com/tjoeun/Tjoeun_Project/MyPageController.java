package com.tjoeun.Tjoeun_Project;


import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

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

import com.tjoeun.dao.MyPageDAO;
import com.tjoeun.vo.MainVO;

@Controller
public class MyPageController {
	
	private static final Logger logger = LoggerFactory.getLogger(MyPageController.class);
	
	// 이미지 파일이 저장된 경로 설정
    private static final String IMAGE_UPLOAD_DIR = "C:/Tjoeun_Data/empImages/";
	
	// MainController 내 함수 사용 위해 의존성 주입 ( 권장 방법 X )
	private final MainController mainController;
	@Autowired
    public MyPageController(MainController mainController) {
        this.mainController = mainController;
    }
	
	@Autowired
	private SqlSession sqlSession;
	
    
	
	@RequestMapping("myPage")
	public String myPage(HttpServletRequest request, Model model, HttpSession session) {
		
		// 만약 사원 정보가 없을 경우 login창으로 리턴
		if ( mainController.verification(session) ) return "redirect:loginOK";
		
		// 사원 정보 session에서 불러옴
		MainVO mvo = (MainVO)session.getAttribute("mvo");
		
		// 사원 정보에서 String 타입으로 생일, 입사일을 뽑아올 변수 생성 
		String rawBirthDay = mvo.getBirthDay();
		String rawJoiningDate = mvo.getJoiningDate();
		
		// 원하는 Format으로 만들기 위해 새로운 SimpleDateFormat 객체 생성
		SimpleDateFormat inputDate = new SimpleDateFormat("yyMMdd");
		SimpleDateFormat outputDate = new SimpleDateFormat("yyyy-MM-dd"); 
		
		// String 타입인 생일, 입사일을 Date로 변환할 변수 생성 
		Date input_BirthDay = null;
		Date input_JoiningDate = null;
		
		// String 타입인 생일 날짜, 입사일을 원하는 Format의 Date 변수로 변환
		try {
			input_BirthDay = inputDate.parse(rawBirthDay);
			input_JoiningDate = inputDate.parse(rawJoiningDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// 원하는 Format의 생일 날짜, 입사일을 String 변수로 변환
		String B_Day = outputDate.format(input_BirthDay);
		String J_Date = outputDate.format(input_JoiningDate);
		
		model.addAttribute("B_Day", B_Day);
		model.addAttribute("J_Date", J_Date);
		return "myPage";
	}
	
	@RequestMapping("myPageUpdate")
	public String myPageUpdate(HttpServletRequest request, Model model, HttpSession session) {
		
		// 만약 사원 정보가 없을 경우 login창으로 리턴
		if ( mainController.verification(session) ) return "redirect:logoutOK";
		
		MainVO mvo = (MainVO)session.getAttribute("mvo");
		
		String rawBirthDay = mvo.getBirthDay();
		String rawJoiningDate = mvo.getJoiningDate();
		
		SimpleDateFormat inputDate = new SimpleDateFormat("yyMMdd");
		SimpleDateFormat outputDate = new SimpleDateFormat("yyyy-MM-dd"); 
		
		Date input_BirthDay = null;
		Date input_JoiningDate = null;
		try {
			input_BirthDay = inputDate.parse(rawBirthDay);
			input_JoiningDate = inputDate.parse(rawJoiningDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String B_Day = outputDate.format(input_BirthDay);
		String J_Date = outputDate.format(input_JoiningDate);
		
		model.addAttribute("B_Day", B_Day);
		model.addAttribute("J_Date", J_Date);
		
		logger.info(" update 전 mvo : {}", mvo);
		
		return "myPageUpdate";
	}
	
	@RequestMapping("myPageUpdateOK")
	public String myPageUpdateOK(HttpServletRequest request, HttpSession session, @RequestParam("imageFile") MultipartFile file) {
		MyPageDAO mapper = sqlSession.getMapper(MyPageDAO.class);
		
		// 만약 사원 정보가 없을 경우 login창으로 리턴
		if ( mainController.verification(session)) return "redirect:logoutOK";
		
		MainVO mvo = (MainVO)session.getAttribute("mvo");		
		
		// 현재 사원정보 불러오고(mvo), 새로 넣을 이메일, 전화번호 불러옴 
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		
		String beforeImage = request.getParameter("imageNameSpanValue");
		
		
		mvo.setEmail(email);
		mvo.setPhone(phone);

		
		// 이미지 삽입 / 갱신할 경우
		if (!file.isEmpty()) {
			try {
				// 들어온 파일의 이름을 변수로 설정
				String originalFilename = file.getOriginalFilename();

				// 새로운 이름변수 ( 현재 시간 + 파일 이름 ) 설정
				String newFilename = System.currentTimeMillis() + "_" + mvo.getCnum() + "_" + originalFilename;
				// String absoluteUploadPath = servletContext.getRealPath(UPLOAD_DIR);
				// logger.info(absoluteUploadPath);

				// 경로 변수로 File 타입 목적지 변수 설정
				File destination = new File(IMAGE_UPLOAD_DIR, newFilename);

				// 만약 디렉토리가 존재하지 않다면
				if (!destination.getParentFile().exists()) {

				// 디렉토리 만들기, 목적지로 파일 보내기
					destination.getParentFile().mkdirs();
					file.transferTo(destination);
					logger.info("디렉토리 만들어서 보낸 최종 목적지 : {}", destination);
				} else {
					// 파일 디렉토리 존재한다면
					logger.info("디렉토리 이미 존재, 최종 목적지 : {}", destination);
					file.transferTo(destination);
				}
				// 파일 서버 or 외부 저장소에 전송 후
				logger.info("DB에 filename 넣기 전 mainVO : {}", mvo);
				
				mvo.setImagefile(newFilename); // 업로드된 파일명을 mainVO에 설정
				
			} catch (IOException e) {
				// 파일 전송 도중 오류 발생시
				e.printStackTrace();
				logger.info("파일 전송에 실패했습니다.");
			}
			
		} 
		
		// 갱신/삽입 할 이미지 없을 때 
		else {
			
			// View에서 넘어오는 기존 사진도 없을 때 / 기본 이미지로 돌릴 때
			if ( beforeImage == null ) {
				File deleteFile = new File(IMAGE_UPLOAD_DIR, mvo.getImagefile());
				deleteFile.delete();
				mvo.setImagefile("");
			}
			
			// 그 외의 상황은 저장
			mapper.updateinfo(mvo);
			return "redirect:myPage";
		}
		
	
	// 실행한 if문 토대로 DB Update
	mapper.updateinfo(mvo);
	return "redirect:myPage";
	}
}
	

