package com.myproject.mycontroller;

import java.util.HashMap;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dao.MemberDAO;
import dto.DTO;
import mybatis.MemberVO;
import mybatis.MybatisMember;

@Controller
public class MemberController {
	
	private SqlSession sqlSession;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
		System.out.println("@Autowired->DB연결성공");
	}
	@RequestMapping("/member/sub01")
	public String sub01() {
		return "/member/sub01";
	}
	@RequestMapping("/member/sub02")
	public String sub02() {
		return "/member/sub02";
	}	
	@RequestMapping("/member/join01")
	public String join01() {
		return "/member/join01";
	}	
	@RequestMapping("/member/join02")
	public String join02() {
		return "/member/join02";
	}	
	@RequestMapping("/member/id_pw")
	public String id_pw() {
		return "/member/id_pw";
	}	
	@RequestMapping("/member/login")
	public String login() {
		return "/member/login";
	}	
	@RequestMapping("/member/sitemap")
	public String sitemap() {
		return "/member/sitemap";
	}	
	@RequestMapping("/member/findId")
	@ResponseBody
	public Map<String, Object> findId(HttpServletRequest req) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		
		DTO dto = sqlSession.getMapper(MemberDAO.class).findId(name, email);
		
		if(dto==null) {
			map.put("rs", 0);
			map.put("id", "회원이 아니십니다.");
		}
		else {
			map.put("rs", 1);
			map.put("id", dto.getId());
		}
		
		return map;
	}
	/*
	@RequestMapping("/member/findPass")
	@ResponseBody
	public Map<String, Object> findPass(HttpServletRequest req) {
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String id = req.getParameter("id");
				
		DTO dto = sqlSession.getMapper(MemberDAO.class).findPass(id, name, email);
		
		if(dto==null) {
			map.put("rs", 0);
			map.put("pass", "아이디와 이름을 확인해 주세요");
		}
		else {
			map.put("rs", 1);	
			map.put("pass", dto.getPass());
		}
		
		return map;			
	}*/
	
	//메일전송
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	@RequestMapping(value = "/member/findPass", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> findPass(HttpServletRequest req, Model model) {
				
		Map<String, Object> map = new HashMap<String, Object>();
		
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String id = req.getParameter("id");
				
		DTO dto = sqlSession.getMapper(MemberDAO.class).findPass(id, name, email);
		
		if(dto==null) {
			map.put("rs", 0);
			map.put("pass", "아이디와 이름을 확인해 주세요");
		}
		else {
			
			final String fromEmail = "ejrl123@naver.com";
			final String toEmail = "ejrl123@gmail.com";
			final String subject = "센터 비밀번호 안내";
			final String contents = "회원님의 비밀번호는 "+dto.getPass()+"입니다.";
			
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
			map.put("rs", 1);
			map.put("pass", "이메일이 발송되었습니다. 이메일을 확인해 주세요");
		}		
		
		return map;
	}
	
	
	
	
	
	
	
	
	
	
	@RequestMapping("/loginPrc")
	public ModelAndView login(HttpServletRequest req, HttpSession session) {
				
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
				
		//Mapper의 id="login"인 엘리먼트를 인터페이스를 통해 호출한다.
		DTO dto = sqlSession.getMapper(MemberDAO.class).login(id, pass);
		
		ModelAndView mv = new ModelAndView();
		
		if(dto==null) {
			//로그인에 실패한 경우
			mv.addObject("LoginNg", "아이디/패스워드가 틀렸습니다.");
			//로그인 페이지로 다시이동
			mv.setViewName("redirect:/member/login");
			System.out.println("로그인 실패");
			return mv;
		}
		else {
			session.setAttribute("user_info", dto);
			session.setAttribute("user_id", dto.getId());
			session.setAttribute("user_name", dto.getName());
			session.setAttribute("user_grade", dto.getGrade());
			System.out.println("로그인 성공");
			System.out.println(dto.getId());
			
			if(dto.getGrade()==0) {				
				//일반유저가 로그인에 성공한 경우 Session영역에 속성저장
				mv.setViewName("redirect:/");				
				
			}
			else {
				//관리자가 로그인 한 경우 관리자 페이지로 보냄				
				mv.setViewName("redirect:index");				
			}
		}	
		
		return mv;
		
	}
	@RequestMapping("/member/loginPrc")
	public ModelAndView sublogin(HttpServletRequest req, HttpSession session) {
		
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		
		//Mapper의 id="login"인 엘리먼트를 인터페이스를 통해 호출한다.
		DTO dto = sqlSession.getMapper(MemberDAO.class).login(id, pass);
		
		ModelAndView mv = new ModelAndView();
		
		if(dto==null) {
			//로그인에 실패한 경우
			mv.addObject("LoginNg", "아이디/패스워드가 틀렸습니다.");
			//로그인 페이지로 다시이동
			mv.setViewName("redirect:/member/login");
			System.out.println("로그인 실패");
			return mv;
		}
		else {
			session.setAttribute("user_info", dto);
			session.setAttribute("user_id", dto.getId());
			session.setAttribute("user_name", dto.getName());
			session.setAttribute("user_grade", dto.getGrade());
			System.out.println("로그인 성공");
			System.out.println(dto.getId());
			
			if(dto.getGrade()==0) {				
				//일반유저가 로그인에 성공한 경우 Session영역에 속성저장
				mv.setViewName("redirect:/");	
				
			}
			else {
				//관리자가 로그인 한 경우 관리자 페이지로 보냄				
				mv.setViewName("redirect:index");				
			}
		}		
		
		return mv;
		
	}
	//로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		//세션영역을 비운 후 메인페이지로 이동한다.
		session.setAttribute("user_info", null);
		session.setAttribute("user_id", null);
		session.setAttribute("user_name", null);
		return "redirect:/";
	}
	
	//회원가입 폼
	@RequestMapping("/member/joinPrc")
	public String list(Model model, HttpServletRequest req) {
		
		String id = "";
		String pass = "";
		String name = "";
		String tel = "";
		String mobile = "";
		String email = "";
		int zipcode = 0;
		String addr = "";
		int admail = 0;
		int grade = 0;
		
		try {
			id = req.getParameter("id");
			pass = req.getParameter("pass");
			name = req.getParameter("name");
			tel = req.getParameter("tel1")+"-"+req.getParameter("tel2")+"-"+req.getParameter("tel3");
			mobile = req.getParameter("mobile1")+"-"+req.getParameter("mobile2")+"-"+req.getParameter("mobile3");		 
			email = req.getParameter("email1")+"@"+req.getParameter("email2");
			zipcode = Integer.parseInt(req.getParameter("zipcode"));
			addr = req.getParameter("addr1")+"@"+req.getParameter("addr2");
			admail = Integer.parseInt(req.getParameter("admail"));
			grade = Integer.parseInt(req.getParameter("grade"));
			
		} 
		catch (Exception e) {
		}
		
		System.out.println(id+pass+name+mobile+zipcode+addr+admail+grade);
		
		int rs = sqlSession.getMapper(MemberDAO.class).joinMember(id, pass, name, tel, mobile, email, zipcode, addr, admail, grade);
		
		if(rs==0) {
			System.out.println("회원가입 실패");
		}
		else {
			System.out.println("회원가입 성공");
		}
		
		return "home";
	}	
	
	@RequestMapping("/member/idcheck")
	@ResponseBody
	public Map<String, Object> idcheck(HttpServletRequest req, HttpSession session){
	
		Map<String, Object> map = new HashMap<String, Object>();
		
		String id = req.getParameter("id");
		
		int rs = sqlSession.getMapper(MemberDAO.class).idCheck(id);
		
		if(rs==0) {			
			map.put("Result", 0);
			
		}
		else {
			map.put("Result", 1);					
		}		
		return map;
	}
}
