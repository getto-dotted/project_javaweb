package com.myproject.mycontroller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import dao.BasketDAO;
import dto.DTO;
import util.EnvFileReader;
import util.PagingUtil;

@Controller
public class BasketController {

	private SqlSession sqlSession;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
		System.out.println("@Autowired->DB연결성공");
	}	
	
	public static String getUuid() {
		String uuid = UUID.randomUUID().toString();
		System.out.println("UUID:"+uuid);
		uuid = uuid.replaceAll("-", "");
		System.out.println("생성된 UUID:"+uuid);
		return uuid;
	}				

	//글 삭제하기
	@RequestMapping("/market/basketDelete")
	public String delete(Model model, HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String pid = req.getParameter("pid");
		sqlSession.getMapper(BasketDAO.class).delete(pid);
				
		return "redirect:/market/basket";		
	}		

	//글쓰기
	@RequestMapping("/market/basketWritePrc")	
	public String basket_write(HttpServletRequest req, Model model, HttpSession session) {		
		
		if(session.getAttribute("user_id")==null) {
			
			return "redirect:/member/login";
		}
		String id = (String) session.getAttribute("user_id");
		
		//View로 전달할 데이터 저장용 맵 컬렉션 생성		
		Map file = new HashMap();		
		
		//파일외 폼값 받아오기
		String[] idx = req.getParameterValues("idx");		
		String[] bprice = req.getParameterValues("bprice");		
		String[] onum = req.getParameterValues("cstock2");		
		String[] nowPage = req.getParameterValues("nowpage");		
		
		for(int i=0; i<idx.length; i++) {
			
			file.put("idx", idx[i]);
			file.put("id", id);
			file.put("bprice", bprice[i]);
			file.put("onum", onum[i]);
			
			System.out.println(idx[i]);
			
			sqlSession.getMapper(BasketDAO.class).WritePage(file);	
		}
			
		model.addAttribute("file", file);
				
		return "redirect:/market/market?nowPage="+nowPage[0];
	}
	//글쓰기2
	@RequestMapping("/market/basketWritePrc2")	
	public String basket_write2(HttpServletRequest req, Model model, HttpSession session) {		
		
		if(session.getAttribute("user_id")==null) {
			
			return "redirect:/member/login";
		}
		
		String id = (String) session.getAttribute("user_id");
		
		//View로 전달할 데이터 저장용 맵 컬렉션 생성		
		Map file = new HashMap();		
		
		//파일외 폼값 받아오기
		String[] idx = req.getParameterValues("idx");		
		String[] bprice = req.getParameterValues("bprice");		
		String onum = "1";		
		String[] nowPage = req.getParameterValues("nowpage");		
				
		for(int i=0; i<idx.length; i++) {
			
			file.put("idx", idx[i]);
			file.put("id", id);
			file.put("bprice", bprice[i]);
			file.put("onum", onum);
			
			sqlSession.getMapper(BasketDAO.class).WritePage(file);	
		}
		
		model.addAttribute("file", file);
		
		return "redirect:/market/basket02";
	}
	//글수정
	@RequestMapping("/market/basketUpdatePrc")	
	public String basket_update(HttpServletRequest req, Model model, HttpSession session) {		
		
		if(session.getAttribute("user_id")==null) {
			
			return "redirect:/member/login";
		}
		
		//View로 전달할 데이터 저장용 맵 컬렉션 생성		
		Map file = new HashMap();		
		
		//파일외 폼값 받아오기
		String[] pid = req.getParameterValues("pid");			
		String[] idx = req.getParameterValues("idx");			
		String[] onum = req.getParameterValues("onum");				
		String ptype = req.getParameter("pay");
		String name = req.getParameter("name");
		String zipcode = req.getParameter("zipcode");
		String addr = req.getParameter("addr1") +":"+ req.getParameter("addr2");
		String mobile = req.getParameter("mobile1") +"-"+ req.getParameter("mobile2") +"-"+ req.getParameter("mobile3");
		String email = req.getParameter("email1") +"@"+ req.getParameter("email2");
		String msg = req.getParameter("msg");
								
		file.put("name", name);		
		file.put("zipcode", zipcode);		
		file.put("addr", addr);		
		file.put("mobile", mobile);		
		file.put("email", email);		
		file.put("msg", msg);		
		file.put("ptype", ptype);		
		
		for(int i=0; i<pid.length; i++) {
			
			file.put("idx", idx[i]);		
			file.put("pid", pid[i]);		
			file.put("onum", onum[i]);
			
			sqlSession.getMapper(BasketDAO.class).scnt(idx[i]);
			sqlSession.getMapper(BasketDAO.class).conf(pid[i]);
			sqlSession.getMapper(BasketDAO.class).pay(pid[i]);	
			sqlSession.getMapper(BasketDAO.class).UpdatePage(file);	
			
		}	
		
		model.addAttribute("file", file);
		
		return "redirect:/market/market";
	}
	//글수정2
	@RequestMapping("/market/basketUpdatePrc2")	
	public String basket_update2(HttpServletRequest req, Model model, HttpSession session) {		
		
		if(session.getAttribute("user_id")==null) {
			
			return "redirect:/member/login";
		}
		
		//View로 전달할 데이터 저장용 맵 컬렉션 생성		
		Map file = new HashMap();		
		
		//파일외 폼값 받아오기
		String[] pid = req.getParameterValues("pid");			
		String[] idx = req.getParameterValues("idx");			
		String[] onum = req.getParameterValues("onum");	
		
		for(int i=0; i<pid.length; i++) {
			
			file.put("idx", idx[i]);		
			file.put("pid", pid[i]);		
			file.put("onum", onum[i]);
			
			sqlSession.getMapper(BasketDAO.class).scnt(idx[i]);
			sqlSession.getMapper(BasketDAO.class).conf(pid[i]);
			sqlSession.getMapper(BasketDAO.class).pay(pid[i]);	
			sqlSession.getMapper(BasketDAO.class).UpdatePage(file);	
			
		}	
		
		model.addAttribute("file", file);
		
		return "redirect:/market/basket02";
	}
	
	//게시물 리스트
	@RequestMapping("/market/basket")
	public String marketlist(Model model, HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String id = (String) session.getAttribute("user_id");
		
		Map param = new HashMap();
					
		String startIdx = req.getParameter("startIdx");
		String endIdx = req.getParameter("endIdx");
		//검색결과가 많아서 페이지가 넘어가도 검색상태 유지
		String addQueryString = "";		
		
		if(startIdx!=null) {
			param.put("startIdx", startIdx);
			addQueryString += String.format("startIdx=%s&", startIdx);
		}
		if(endIdx!=null) {
			param.put("endIdx", endIdx);
			addQueryString += String.format("endIdx=%s&", endIdx);
		}
		param.put("id", id);
		param.put("startIdx", startIdx);
		param.put("endIdx", endIdx);
		
		int totalRecordCount = sqlSession.getMapper(BasketDAO.class).getTotalCount(param);
		
		//페이지 처리를 위한 설정값
		int pageSize = 
				Integer.parseInt(EnvFileReader.getValue("BasketPaging.properties", "pageSize")); 				
		int blockPage = 
				Integer.parseInt(EnvFileReader.getValue("BasketPaging.properties", "blockPage")); 
		//전체 페이지수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		//현재 페이지번호 파라미터로 받기
		int nowPage = req.getParameter("nowPage")==null? 1 : Integer.parseInt(req.getParameter("nowPage"));
		//쿼리의 start, end값 구하기
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		param.put("start", start);
		param.put("end", end);		
		
		ArrayList<DTO> lists = sqlSession.getMapper(BasketDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath() + "/market/basket?" +addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);			
		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
			
		return "/market/basket";
	}
	//게시물 리스트2
	@RequestMapping("/market/basket02")
	public String marketlist2(Model model, HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String id = (String) session.getAttribute("user_id");
		
		Map param = new HashMap();
		
		String startIdx = req.getParameter("startIdx");
		String endIdx = req.getParameter("endIdx");
		//검색결과가 많아서 페이지가 넘어가도 검색상태 유지
		String addQueryString = "";		
		
		if(startIdx!=null) {
			param.put("startIdx", startIdx);
			addQueryString += String.format("startIdx=%s&", startIdx);
		}
		if(endIdx!=null) {
			param.put("endIdx", endIdx);
			addQueryString += String.format("endIdx=%s&", endIdx);
		}
		param.put("id", id);
		param.put("startIdx", startIdx);
		param.put("endIdx", endIdx);
		
		int totalRecordCount = sqlSession.getMapper(BasketDAO.class).getTotalCount(param);
		
		//페이지 처리를 위한 설정값
		int pageSize = 
				Integer.parseInt(EnvFileReader.getValue("BasketPaging2.properties", "pageSize")); 				
		int blockPage = 
				Integer.parseInt(EnvFileReader.getValue("BasketPaging2.properties", "blockPage")); 
		//전체 페이지수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		//현재 페이지번호 파라미터로 받기
		int nowPage = req.getParameter("nowPage")==null? 1 : Integer.parseInt(req.getParameter("nowPage"));
		//쿼리의 start, end값 구하기
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		param.put("start", start);
		param.put("end", end);		
		
		ArrayList<DTO> lists = sqlSession.getMapper(BasketDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg2(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath() + "/market/basket02?" +addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);			
		
		ArrayList<DTO> lists2 = sqlSession.getMapper(BasketDAO.class).order(id);
						
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
		model.addAttribute("lists2", lists2);	
		
		return "/market/basket02";
	}
	
	//게시물 리스트3 ajax
	@RequestMapping("/market/basket03")
	public String marketlist3(Model model, HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String id = (String) session.getAttribute("user_id");
		
		Map param = new HashMap();
		
		String startIdx = req.getParameter("startIdx");
		String endIdx = req.getParameter("endIdx");
		//검색결과가 많아서 페이지가 넘어가도 검색상태 유지
		String addQueryString = "";		
		
		if(startIdx!=null) {
			param.put("startIdx", startIdx);
			addQueryString += String.format("startIdx=%s&", startIdx);
		}
		if(endIdx!=null) {
			param.put("endIdx", endIdx);
			addQueryString += String.format("endIdx=%s&", endIdx);
		}
		param.put("id", id);
		param.put("startIdx", startIdx);
		param.put("endIdx", endIdx);
		
		int totalRecordCount = sqlSession.getMapper(BasketDAO.class).getTotalCount(param);
		
		//페이지 처리를 위한 설정값
		int pageSize = 
				Integer.parseInt(EnvFileReader.getValue("BasketPaging2.properties", "pageSize")); 				
		int blockPage = 
				Integer.parseInt(EnvFileReader.getValue("BasketPaging2.properties", "blockPage")); 
		//전체 페이지수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		//현재 페이지번호 파라미터로 받기
		int nowPage = req.getParameter("nowPage")==null? 1 : Integer.parseInt(req.getParameter("nowPage"));
		//쿼리의 start, end값 구하기
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		param.put("start", start);
		param.put("end", end);		
		
		ArrayList<DTO> lists = sqlSession.getMapper(BasketDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg2(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath() + "/market/basket02?" +addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);			
		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);			
		
		return "/market/basket03";
	}
	
	
	
	
}
