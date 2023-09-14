package com.tjoeun.Tjoeun_Project;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tjoeun.dao.LoginDAO;
import com.tjoeun.vo.MainVO;

@Controller
public class LoginController {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	// 로그인 페이지 시작(처음 시작 부분)
	@RequestMapping("/")
	public String home(Locale locale, Model model) {
		logger.info("Default Homepage");
		return "redirect:login";
	}
	
	@RequestMapping("/login")
	public String login(Locale locale, Model model) {
		logger.info("login 접속됨");
		return "login";
	}
	
	// 로그인 버튼 눌러서 login.jsp -> loginOK.jsp로 넘기기
	@RequestMapping("/loginOK")
	public String loginOK(HttpServletRequest request, Model model, String cnum) {
		logger.info("loginOK 접속됨");
		logger.info("CNUM : {}", cnum);
		LoginDAO mapper = sqlSession.getMapper(LoginDAO.class);
		
		try {
			MainVO mainVO = mapper.selectbyCnum(Integer.parseInt(cnum));
			logger.info("mainVO : {}", mainVO);
			model.addAttribute("mainVO", mainVO);
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		return "loginOK";
	}

	
}
