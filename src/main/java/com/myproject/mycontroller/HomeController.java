package com.myproject.mycontroller;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dao.ManagerDAO;
import dto.DTO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	private SqlSession sqlSession;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
		System.out.println("@Autowired->DB연결성공");
	}
	@RequestMapping("/404")
	public String M404() {
		return "404";
	}
	@RequestMapping("/blank")
	public String blank() {
		return "blank";
	}
	@RequestMapping("/charts")
	public String charts() {
		return "charts";
	}
	@RequestMapping("/forgot-pass")
	public String forgotPass() {
		return "forgot-pass";
	}
	@RequestMapping("/emailSend")
	public String emailSend() {
		return "emailSend";
	}
	@RequestMapping("/index")
	public String index(HttpSession session) {
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String id = (String) session.getAttribute("user_id");
		
		DTO dto = sqlSession.getMapper(ManagerDAO.class).idCheck(id);
		
		int grade = dto.getGrade();
		
		if(grade==0) {
			return "redirect:/";
		}
		
		return "index";
	}
	@RequestMapping("/login")
	public String login() {
		return "login";
	}
	@RequestMapping("/register")
	public String register() {
		return "register";
	}
	@RequestMapping("/tables")
	public String tables() {
		return "tables";
	}
	
	//메일전송
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	@RequestMapping(value = "/EmailSend.do", method = RequestMethod.POST)
	public String EmailSend(HttpServletRequest req, Model model) {
				
		final String fromEmail = "ejrl123@naver.com";
		final String toEmail = "ejrl123@gmail.com";
		final String subject = req.getParameter("subject");
		final String contents = req.getParameter("contents").replace("\r\n", "<br/>");
		
		final MimeMessagePreparator preparator = new MimeMessagePreparator() {			
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {

				final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
				helper.setFrom(fromEmail); 
				helper.setTo(toEmail); 
				helper.setSubject(subject);  
				/*
				 * http://localhost:8080/SpringSMTP/emailAuth.do?id=nakja&pass=1234&user_auth=1
				 * 
				 * <a href='http://localhost:8080/SpringSMTP/emailAuth.do?id=nakja&pass=1234&rndNum=112635489874'>여기를클릭하면인증됨</a>
				 * 
				 * */
				helper.setText(contents, true); 
			}
		};		
		
		try {
			mailSender.send(preparator);
			model.addAttribute("mailResult","메일이 정상발송 되었습니다");
		}
		catch (Exception e) {
			System.out.println("예외발생");
			model.addAttribute("mailResult","메일발송오류");
			e.printStackTrace();
		}
		
		return "emailSend";
	}
	
}
