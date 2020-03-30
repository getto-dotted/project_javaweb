package com.myproject.mycontroller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import dao.BasketDAO;
import dao.BoardDAO;
import dao.ManagerDAO;
import dao.MemberDAO;
import dao.ProductDAO;
import dto.DTO;
import util.EnvFileReader;
import util.PagingUtil;

@Controller
public class ManagerController {
	
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
	//게시물 리스트	
	@RequestMapping("/manager/notice")
	public String notice(HttpServletRequest req, Model model, HttpSession session) {

		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String id = (String) session.getAttribute("user_id");
		
		DTO dto = sqlSession.getMapper(ManagerDAO.class).idCheck(id);
		
		int grade = dto.getGrade();
		
		if(grade==0) {
			return "redirect:/";
		}
		 
		Map param = new HashMap();
		
		String tname = "notice";
		param.put("tname", tname);
		String searchColumn = req.getParameter("searchColumn");
		String searchWord = req.getParameter("searchWord");
		String startIdx = req.getParameter("startIdx");
		String endIdx = req.getParameter("endIdx");
		//검색결과가 많아서 페이지가 넘어가도 검색상태 유지
		String addQueryString = "";
		
		if(searchColumn!=null) {
			//전달된 파라미터가 있을때만 아래 문장 수행
			addQueryString = String.format("searchColumn=%s&searchWord=%s&", searchColumn, searchWord);
			param.put("searchColumn", searchColumn);
			param.put("searchWord", searchWord);
		}
		if(startIdx!=null) {
			param.put("startIdx", startIdx);
			addQueryString += String.format("startIdx=%s&", startIdx);
		}
		if(endIdx!=null) {
			param.put("endIdx", endIdx);
			addQueryString += String.format("endIdx=%s&", endIdx);
		}
		
		int totalRecordCount = sqlSession.getMapper(BoardDAO.class).getTotalCount(param);
		
		//페이지 처리를 위한 설정값
		int pageSize = 
				Integer.parseInt(EnvFileReader.getValue("Paging.properties", "pageSize")); 				
		int blockPage = 
				Integer.parseInt(EnvFileReader.getValue("Paging.properties", "blockPage")); 
		//전체 페이지수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		//현재 페이지번호 파라미터로 받기
		int nowPage = (req.getParameter("nowPage")==null || req.getParameter("nowPage").equals(""))
				? 1 : Integer.parseInt(req.getParameter("nowPage"));
		//쿼리의 start, end값 구하기
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		param.put("start", start);
		param.put("end", end);		
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath()+"/manager/notice?"+addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);	
		model.addAttribute("Column", searchColumn);	
		
		//날짜변경
		for(DTO dto2 : lists) {			
			java.sql.Date sqlDate = new java.sql.Date(dto2.getPday().getTime()); 			
			dto2.setPday(sqlDate);
		}
		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
			
		
		return "manager/notice";
	}
	//게시물 리스트	
	@RequestMapping("/manager/program")
	public String program(HttpServletRequest req, Model model, HttpSession session) {
		
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String id = (String) session.getAttribute("user_id");
		
		DTO dto = sqlSession.getMapper(ManagerDAO.class).idCheck(id);
		
		int grade = dto.getGrade();
		
		if(grade==0) {
			return "redirect:/";
		}
		
		Map param = new HashMap();
		
		String tname = "program";
		param.put("tname", tname);
		String searchColumn = req.getParameter("searchColumn");
		String searchWord = req.getParameter("searchWord");
		String startIdx = req.getParameter("startIdx");
		String endIdx = req.getParameter("endIdx");
		//검색결과가 많아서 페이지가 넘어가도 검색상태 유지
		String addQueryString = "";
		
		if(searchColumn!=null) {
			//전달된 파라미터가 있을때만 아래 문장 수행
			addQueryString = String.format("searchColumn=%s&searchWord=%s&", searchColumn, searchWord);
			param.put("searchColumn", searchColumn);
			param.put("searchWord", searchWord);
		}
		if(startIdx!=null) {
			param.put("startIdx", startIdx);
			addQueryString += String.format("startIdx=%s&", startIdx);
		}
		if(endIdx!=null) {
			param.put("endIdx", endIdx);
			addQueryString += String.format("endIdx=%s&", endIdx);
		}
		
		int totalRecordCount = sqlSession.getMapper(BoardDAO.class).getTotalCount(param);
		
		//페이지 처리를 위한 설정값
		int pageSize = 
				Integer.parseInt(EnvFileReader.getValue("Paging.properties", "pageSize")); 				
		int blockPage = 
				Integer.parseInt(EnvFileReader.getValue("Paging.properties", "blockPage")); 
		//전체 페이지수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		//현재 페이지번호 파라미터로 받기
		int nowPage = (req.getParameter("nowPage")==null || req.getParameter("nowPage").equals(""))
				? 1 : Integer.parseInt(req.getParameter("nowPage"));
		//쿼리의 start, end값 구하기
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		param.put("start", start);
		param.put("end", end);		
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath()+"/manager/notice?"+addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);	
		model.addAttribute("Column", searchColumn);	
		//날짜변경
		for(DTO dto2 : lists) {			
			java.sql.Date sqlDate = new java.sql.Date(dto2.getPday().getTime()); 			
			dto2.setPday(sqlDate);
		}
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
		
		
		return "manager/program";
	}
	//게시물 리스트	
	@RequestMapping("/manager/crew")
	public String crew(HttpServletRequest req, Model model, HttpSession session) {

		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String id = (String) session.getAttribute("user_id");
		
		DTO dto = sqlSession.getMapper(ManagerDAO.class).idCheck(id);
		
		int grade = dto.getGrade();
		
		if(grade==0) {
			return "redirect:/";
		}
				
		Map param = new HashMap();
		
		String tname = "crew";
		param.put("tname", tname);
		String searchColumn = req.getParameter("searchColumn");
		String searchWord = req.getParameter("searchWord");
		String startIdx = req.getParameter("startIdx");
		String endIdx = req.getParameter("endIdx");
		//검색결과가 많아서 페이지가 넘어가도 검색상태 유지
		String addQueryString = "";
		
		if(searchColumn!=null) {
			//전달된 파라미터가 있을때만 아래 문장 수행
			addQueryString = String.format("searchColumn=%s&searchWord=%s&", searchColumn, searchWord);
			param.put("searchColumn", searchColumn);
			param.put("searchWord", searchWord);
		}
		if(startIdx!=null) {
			param.put("startIdx", startIdx);
			addQueryString += String.format("startIdx=%s&", startIdx);
		}
		if(endIdx!=null) {
			param.put("endIdx", endIdx);
			addQueryString += String.format("endIdx=%s&", endIdx);
		}
		
		int totalRecordCount = sqlSession.getMapper(BoardDAO.class).getTotalCount(param);
		
		//페이지 처리를 위한 설정값
		int pageSize = 
				Integer.parseInt(EnvFileReader.getValue("Paging.properties", "pageSize")); 				
		int blockPage = 
				Integer.parseInt(EnvFileReader.getValue("Paging.properties", "blockPage")); 
		//전체 페이지수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		//현재 페이지번호 파라미터로 받기
		int nowPage = (req.getParameter("nowPage")==null || req.getParameter("nowPage").equals(""))
				? 1 : Integer.parseInt(req.getParameter("nowPage"));
		//쿼리의 start, end값 구하기
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		param.put("start", start);
		param.put("end", end);		
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath()+"/manager/notice?"+addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);	
		model.addAttribute("Column", searchColumn);	
		//날짜변경
		for(DTO dto2 : lists) {			
			java.sql.Date sqlDate = new java.sql.Date(dto2.getPday().getTime()); 			
			dto2.setPday(sqlDate);
		}		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
		
		
		return "manager/crew";
	}
	//게시물 리스트	
	@RequestMapping("/manager/info")
	public String info(HttpServletRequest req, Model model, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String id = (String) session.getAttribute("user_id");
		
		DTO dto = sqlSession.getMapper(ManagerDAO.class).idCheck(id);
		
		int grade = dto.getGrade();
		
		if(grade==0) {
			return "redirect:/";
		}
				
		Map param = new HashMap();
		
		String tname = "info";
		param.put("tname", tname);
		String searchColumn = req.getParameter("searchColumn");
		String searchWord = req.getParameter("searchWord");
		String startIdx = req.getParameter("startIdx");
		String endIdx = req.getParameter("endIdx");
		//검색결과가 많아서 페이지가 넘어가도 검색상태 유지
		String addQueryString = "";
		
		if(searchColumn!=null) {
			//전달된 파라미터가 있을때만 아래 문장 수행
			addQueryString = String.format("searchColumn=%s&searchWord=%s&", searchColumn, searchWord);
			param.put("searchColumn", searchColumn);
			param.put("searchWord", searchWord);
		}
		if(startIdx!=null) {
			param.put("startIdx", startIdx);
			addQueryString += String.format("startIdx=%s&", startIdx);
		}
		if(endIdx!=null) {
			param.put("endIdx", endIdx);
			addQueryString += String.format("endIdx=%s&", endIdx);
		}
		
		int totalRecordCount = sqlSession.getMapper(BoardDAO.class).getTotalCount(param);
		
		//페이지 처리를 위한 설정값
		int pageSize = 
				Integer.parseInt(EnvFileReader.getValue("Paging.properties", "pageSize")); 				
		int blockPage = 
				Integer.parseInt(EnvFileReader.getValue("Paging.properties", "blockPage")); 
		//전체 페이지수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		//현재 페이지번호 파라미터로 받기
		int nowPage = (req.getParameter("nowPage")==null || req.getParameter("nowPage").equals(""))
				? 1 : Integer.parseInt(req.getParameter("nowPage"));
		//쿼리의 start, end값 구하기
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		param.put("start", start);
		param.put("end", end);		
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath()+"/manager/notice?"+addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);	
		model.addAttribute("Column", searchColumn);	
		//날짜변경
		for(DTO dto2 : lists) {			
			java.sql.Date sqlDate = new java.sql.Date(dto2.getPday().getTime()); 			
			dto2.setPday(sqlDate);
		}		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
		
		
		return "manager/info";
	}
	//게시물 리스트	
	@RequestMapping("/manager/fam")
	public String fam(HttpServletRequest req, Model model, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String id = (String) session.getAttribute("user_id");
		
		DTO dto = sqlSession.getMapper(ManagerDAO.class).idCheck(id);
		
		int grade = dto.getGrade();
		
		if(grade==0) {
			return "redirect:/";
		}
				
		Map param = new HashMap();
		
		String tname = "fam";
		param.put("tname", tname);
		String searchColumn = req.getParameter("searchColumn");
		String searchWord = req.getParameter("searchWord");
		String startIdx = req.getParameter("startIdx");
		String endIdx = req.getParameter("endIdx");
		//검색결과가 많아서 페이지가 넘어가도 검색상태 유지
		String addQueryString = "";
		
		if(searchColumn!=null) {
			//전달된 파라미터가 있을때만 아래 문장 수행
			addQueryString = String.format("searchColumn=%s&searchWord=%s&", searchColumn, searchWord);
			param.put("searchColumn", searchColumn);
			param.put("searchWord", searchWord);
		}
		if(startIdx!=null) {
			param.put("startIdx", startIdx);
			addQueryString += String.format("startIdx=%s&", startIdx);
		}
		if(endIdx!=null) {
			param.put("endIdx", endIdx);
			addQueryString += String.format("endIdx=%s&", endIdx);
		}
		
		int totalRecordCount = sqlSession.getMapper(BoardDAO.class).getTotalCount(param);
		
		//페이지 처리를 위한 설정값
		int pageSize = 
				Integer.parseInt(EnvFileReader.getValue("Paging.properties", "pageSize")); 				
		int blockPage = 
				Integer.parseInt(EnvFileReader.getValue("Paging.properties", "blockPage")); 
		//전체 페이지수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		//현재 페이지번호 파라미터로 받기
		int nowPage = (req.getParameter("nowPage")==null || req.getParameter("nowPage").equals(""))
				? 1 : Integer.parseInt(req.getParameter("nowPage"));
		//쿼리의 start, end값 구하기
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		param.put("start", start);
		param.put("end", end);		
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath()+"/manager/notice?"+addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);	
		model.addAttribute("Column", searchColumn);	
		//날짜변경
		for(DTO dto2 : lists) {			
			java.sql.Date sqlDate = new java.sql.Date(dto2.getPday().getTime()); 			
			dto2.setPday(sqlDate);
		}		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
		
		
		return "manager/fam";
	}
	//게시물 리스트	
	@RequestMapping("/manager/pic")
	public String pic(HttpServletRequest req, Model model, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String id = (String) session.getAttribute("user_id");
		
		DTO dto = sqlSession.getMapper(ManagerDAO.class).idCheck(id);
		
		int grade = dto.getGrade();
		
		if(grade==0) {
			return "redirect:/";
		}
				
		Map param = new HashMap();
		
		String tname = "pic";
		param.put("tname", tname);
		String searchColumn = req.getParameter("searchColumn");
		String searchWord = req.getParameter("searchWord");
		String startIdx = req.getParameter("startIdx");
		String endIdx = req.getParameter("endIdx");
		//검색결과가 많아서 페이지가 넘어가도 검색상태 유지
		String addQueryString = "";
		
		if(searchColumn!=null) {
			//전달된 파라미터가 있을때만 아래 문장 수행
			addQueryString = String.format("searchColumn=%s&searchWord=%s&", searchColumn, searchWord);
			param.put("searchColumn", searchColumn);
			param.put("searchWord", searchWord);
		}
		if(startIdx!=null) {
			param.put("startIdx", startIdx);
			addQueryString += String.format("startIdx=%s&", startIdx);
		}
		if(endIdx!=null) {
			param.put("endIdx", endIdx);
			addQueryString += String.format("endIdx=%s&", endIdx);
		}
		
		int totalRecordCount = sqlSession.getMapper(BoardDAO.class).getTotalCount(param);
		
		//페이지 처리를 위한 설정값
		int pageSize = 
				Integer.parseInt(EnvFileReader.getValue("Paging.properties", "pageSize")); 				
		int blockPage = 
				Integer.parseInt(EnvFileReader.getValue("Paging.properties", "blockPage")); 
		//전체 페이지수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		//현재 페이지번호 파라미터로 받기
		int nowPage = (req.getParameter("nowPage")==null || req.getParameter("nowPage").equals(""))
				? 1 : Integer.parseInt(req.getParameter("nowPage"));
		//쿼리의 start, end값 구하기
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		param.put("start", start);
		param.put("end", end);		
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath()+"/manager/notice?"+addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);	
		model.addAttribute("Column", searchColumn);	
		//날짜변경
		for(DTO dto2 : lists) {			
			java.sql.Date sqlDate = new java.sql.Date(dto2.getPday().getTime()); 			
			dto2.setPday(sqlDate);
		}		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
		
		
		return "manager/pic";
	}
	//게시물 리스트	
	@RequestMapping("/manager/free")
	public String free(HttpServletRequest req, Model model, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String id = (String) session.getAttribute("user_id");
		
		DTO dto = sqlSession.getMapper(ManagerDAO.class).idCheck(id);
		
		int grade = dto.getGrade();
		
		if(grade==0) {
			return "redirect:/";
		}
				
		Map param = new HashMap();
		
		String tname = "free";
		param.put("tname", tname);
		String searchColumn = req.getParameter("searchColumn");
		String searchWord = req.getParameter("searchWord");
		String startIdx = req.getParameter("startIdx");
		String endIdx = req.getParameter("endIdx");
		//검색결과가 많아서 페이지가 넘어가도 검색상태 유지
		String addQueryString = "";
		
		if(searchColumn!=null) {
			//전달된 파라미터가 있을때만 아래 문장 수행
			addQueryString = String.format("searchColumn=%s&searchWord=%s&", searchColumn, searchWord);
			param.put("searchColumn", searchColumn);
			param.put("searchWord", searchWord);
		}
		if(startIdx!=null) {
			param.put("startIdx", startIdx);
			addQueryString += String.format("startIdx=%s&", startIdx);
		}
		if(endIdx!=null) {
			param.put("endIdx", endIdx);
			addQueryString += String.format("endIdx=%s&", endIdx);
		}
		
		int totalRecordCount = sqlSession.getMapper(BoardDAO.class).getTotalCount(param);
		
		//페이지 처리를 위한 설정값
		int pageSize = 
				Integer.parseInt(EnvFileReader.getValue("Paging.properties", "pageSize")); 				
		int blockPage = 
				Integer.parseInt(EnvFileReader.getValue("Paging.properties", "blockPage")); 
		//전체 페이지수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		//현재 페이지번호 파라미터로 받기
		int nowPage = (req.getParameter("nowPage")==null || req.getParameter("nowPage").equals(""))
				? 1 : Integer.parseInt(req.getParameter("nowPage"));
		//쿼리의 start, end값 구하기
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		param.put("start", start);
		param.put("end", end);		
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath()+"/manager/notice?"+addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);	
		model.addAttribute("Column", searchColumn);	
		//날짜변경
		for(DTO dto2 : lists) {			
			java.sql.Date sqlDate = new java.sql.Date(dto2.getPday().getTime()); 			
			dto2.setPday(sqlDate);
		}		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
		
		
		return "manager/free";
	}
	
	//게시물 리스트
	@RequestMapping("/manager/market")
	public String marketlist(Model model, HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String id = (String) session.getAttribute("user_id");
		
		DTO dto = sqlSession.getMapper(ManagerDAO.class).idCheck(id);
		
		int grade = dto.getGrade();
		
		if(grade==0) {
			return "redirect:/";
		}
		
		Map param = new HashMap();
				
		String searchColumn = req.getParameter("searchColumn");
		String searchWord = req.getParameter("searchWord");
		String startIdx = req.getParameter("startIdx");
		String endIdx = req.getParameter("endIdx");
		//검색결과가 많아서 페이지가 넘어가도 검색상태 유지
		String addQueryString = "";
		
		if(searchColumn!=null) {
			//전달된 파라미터가 있을때만 아래 문장 수행
			addQueryString = String.format("searchColumn=%s&searchWord=%s&", searchColumn, searchWord);
			param.put("searchColumn", searchColumn);
			param.put("searchWord", searchWord);
		}
		if(startIdx!=null) {
			param.put("startIdx", startIdx);
			addQueryString += String.format("startIdx=%s&", startIdx);
		}
		if(endIdx!=null) {
			param.put("endIdx", endIdx);
			addQueryString += String.format("endIdx=%s&", endIdx);
		}
		
		int totalRecordCount = sqlSession.getMapper(ProductDAO.class).getTotalCount(param);
		
		//페이지 처리를 위한 설정값
		int pageSize = 
				Integer.parseInt(EnvFileReader.getValue("Paging.properties", "pageSize")); 				
		int blockPage = 
				Integer.parseInt(EnvFileReader.getValue("Paging.properties", "blockPage")); 
		//전체 페이지수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		//현재 페이지번호 파라미터로 받기
		int nowPage = (req.getParameter("nowPage")==null || req.getParameter("nowPage").equals(""))
				? 1 : Integer.parseInt(req.getParameter("nowPage"));
		//쿼리의 start, end값 구하기
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		param.put("start", start);
		param.put("end", end);		
		
		ArrayList<DTO> lists = sqlSession.getMapper(ProductDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath()+"/manager/market?"+addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);	
		model.addAttribute("Column", searchColumn);	
		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
			
		return "manager/market";
	}
	
	//---------------------
	//게시물 리스트
	@RequestMapping("/manager/basket")
	public String basketlist(Model model, HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String id = (String) session.getAttribute("user_id");
		
		DTO dto = sqlSession.getMapper(ManagerDAO.class).idCheck(id);
		
		int grade = dto.getGrade();
		
		if(grade==0) {
			return "redirect:/";
		}
		
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
				req.getContextPath() + "/manager/basket?" +addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);			
		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
			
		return "manager/basket";
	}
	//게시물 리스트2
	@RequestMapping("/manager/basket02")
	public String basketlist2(Model model, HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String id = (String) session.getAttribute("user_id");
		
		DTO dto = sqlSession.getMapper(ManagerDAO.class).idCheck(id);
		
		int grade = dto.getGrade();
		
		if(grade==0) {
			return "redirect:/";
		}
		
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
		param.put("start", 1);
		param.put("end", 3);		
		
		ArrayList<DTO> lists = sqlSession.getMapper(BasketDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath() + "/manager/basket?" +addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);			
		
		ArrayList<DTO> lists2 = sqlSession.getMapper(BasketDAO.class).order(id);
						
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
		model.addAttribute("lists2", lists2);	
		
		return "manager/basket02";
	}
	//게시물 리스트2
	@RequestMapping("/manager/member")
	public String memberList(Model model, HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String id = (String) session.getAttribute("user_id");
		
		DTO dto = sqlSession.getMapper(ManagerDAO.class).idCheck(id);
		
		int grade = dto.getGrade();
		
		if(grade==0) {
			return "redirect:/";
		}
		
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
		
		int totalRecordCount = sqlSession.getMapper(MemberDAO.class).getTotalCount(param);
		
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
		param.put("start", 1);
		param.put("end", 3);		
		
		ArrayList<DTO> lists = sqlSession.getMapper(MemberDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath() + "/manager/member?" +addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);		
		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);			
		
		return "manager/member";
	}
	//-----------------------------------------------------리스트 메소드 끝.
	
	
	

}
