package com.myproject.mycontroller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import dao.BoardDAO;
import dao.MemberDAO;
import dto.DTO;
import mybatis.MemberVO;
import mybatis.MyBoardDTO;
import mybatis.MybatisDAO;
import util.EnvFileReader;
import util.PagingUtil;

@Controller
public class BoardController {

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
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpServletRequest req) {
		
		Map param = new HashMap();
		Map param2 = new HashMap();
		Map param3 = new HashMap();
				
		int start = 1;
		int end = 6;
		param.put("start", start);
		param.put("end", end);	
		
		param2.put("start", start);
		param2.put("end", end);	
		
		param3.put("start", start);
		param3.put("end", end);	
		
		
		param.put("tname", "notice");		
		param2.put("tname", "free");		
		param3.put("tname", "pic");		
		
		
		
		ArrayList<DTO> listsN = sqlSession.getMapper(BoardDAO.class).listPage(param);
		ArrayList<DTO> listsF = sqlSession.getMapper(BoardDAO.class).listPage(param2);
		ArrayList<DTO> listsP = sqlSession.getMapper(BoardDAO.class).listPage(param3);
		
		for(DTO dto : listsN) {			
			java.sql.Date sqlDate = new java.sql.Date(dto.getPday().getTime()); 			
			dto.setPday(sqlDate);
		}
		for(DTO dto : listsF) {			
			java.sql.Date sqlDate = new java.sql.Date(dto.getPday().getTime()); 			
			dto.setPday(sqlDate);
		}
		for(DTO dto : listsP) {			
			java.sql.Date sqlDate = new java.sql.Date(dto.getPday().getTime()); 			
			dto.setPday(sqlDate);
		}		
		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("listsN", listsN);			
		model.addAttribute("listsF", listsF);			
		model.addAttribute("listsP", listsP);			
				
		return "home";
	}
	@RequestMapping("/free/write")
	public String space_write() {
		return "/space/free_write";
	}	
	
	//글수정 페이지
	@RequestMapping("/free/modify")
	public String freeModify(Model model, HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String idx = req.getParameter("idx");
		String backURL = req.getParameter("backURL");
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).view(idx);
		
		model.addAttribute("lists", lists);	
		
		return "/space/free_modify";		
	}	
	
	//글수정하기
	@RequestMapping(value="/modifyPrc", method=RequestMethod.POST)
	public String modifyPrc(Model model, HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}		
		String idx = req.getParameter("idx");
		String id = (String) session.getAttribute("user_id");
		String backURL = req.getParameter("backURL");		
		
		//서버의 물리적경로 가져오기
		String path = req.getSession().getServletContext().getRealPath("/resources/Upload");
		
		//View로 전달할 데이터 저장용 맵 컬렉션 생성
		Map returnObj = new HashMap();
		Map file = new HashMap();		

		//파일외 폼값 받아오기
		String title = req.getParameter("title");
		String name2 = req.getParameter("name2");
		String email2 = req.getParameter("email2");
		String content = req.getParameter("content");
		String tname = req.getParameter("tname");
		String dbofile = req.getParameter("ofile");
		String dbnfile = req.getParameter("nfile");
		int pass2 = Integer.parseInt(req.getParameter("pass2"));		
		
		file.put("idx", idx);
		file.put("title", title);
		file.put("name2", name2);
		file.put("email2", email2);
		file.put("content", content);
		file.put("tname", tname);
		file.put("pass2", pass2);
		file.put("id", id);
		file.put("backURL", backURL);
		
		String ofile ="";
		String nfile ="";
		
		try {			
			MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) req;
			//업로드폼의 file속성 필드의 이름을 모두 읽어온다.
			Iterator itr = mhsr.getFileNames();			
			//업로드된 파일명 처리를 위한 변수와 컬렉션 생성
			MultipartFile mfile = null;
			String fileName ="";
			List resultList = new ArrayList();
			
			//업로드폼의 file속성 필드갯수만큼 반복함(여러개의 파일이 업로드된 경우)
			while(itr.hasNext()) {
				fileName = (String)itr.next();
				
				//서버로 업로드된 임시파일명 가져오기
				mfile = mhsr.getFile(fileName);
				System.out.println("mfile="+mfile);
				
				//한글깨짐방지 처리후 업로드된 파일명을 가져옴
				ofile = new String(mfile.getOriginalFilename().getBytes(),"UTF-8");
				if("".equals(ofile)) {
					/*
					만약 업로드된 파일명이 공백문자라면 업로드가 되지 않은 것으로 간주하고
					반복의 처음으로 이동한다.
					 */
					continue;
				}
				//파일의 확장자 가져오기
				String ext = ofile.substring(ofile.lastIndexOf('.'));
				//UUID를 통해 생성된 문자열과 확장자 결합
				nfile = getUuid() +ext;
				/*
				File.separator : 윈도우와 리눅스는 서로 디렉토리를 구분하는
				기호가 다르므로, 해당 OS에 맞는 기호를 자동으로 붙여준다.
				윈도우는 \(역슬러시), 리눅스는 /(슬러시)를 사용하게 된다.
				 */
				File serverFullName = new File(path+File.separator+nfile);
				//조립된 경로에 해당 파일 저장
				mfile.transferTo(serverFullName);
				file.put("ofile", ofile);//원본파일명
				file.put("nfile", nfile);//저장된파일명
				file.put("serverFullName", serverFullName);//서버에 저장된 전체 경로 및 파일명
				
				
				//Map에 저장된 파일정보를 List에 추가한다.
				resultList.add(file);
				
			}
			if(ofile.equals("") || nfile.equals("")) {					
				
				file.put("ofile", dbofile);
				file.put("nfile", dbnfile);
				
			}
						
			sqlSession.getMapper(BoardDAO.class).edit(file);			
			returnObj.put("files", resultList);			
		} 
		catch (IOException e) {
			e.printStackTrace();
			System.out.println("파일업로드 관련 오류");
		}
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("알 수 없는 오류");
		}
				
		model.addAttribute("returnObj", returnObj);		
		
		return "redirect:"+backURL+idx;
	}	
	
	//글 삭제하기
	@RequestMapping("/delete")
	public String delete(Model model, HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String idx = req.getParameter("idx");
		String id = (String) session.getAttribute("user_id");
		String backURL = req.getParameter("backURL");
		
		sqlSession.getMapper(BoardDAO.class).delete(idx, id);
				
		return "redirect:"+backURL;
	}	
	//페이지 상세보기
	@RequestMapping("/free/View")
	public String free_view(HttpServletRequest req, Model model) {
		
		String idx = req.getParameter("idx");
		
		sqlSession.getMapper(BoardDAO.class).vcnt(idx);
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).view(idx);
			
		//내용에 대한 줄바꿈 처리 부분
		for(DTO dto : lists) {
			String temp = dto.getContent().replace("\r\n", "<br/>");
			dto.setContent(temp);
			
			java.sql.Date sqlDate = new java.sql.Date(dto.getPday().getTime()); 			
			dto.setPday(sqlDate);
		}
		
		
		model.addAttribute("lists", lists);	
				
		return "/space/free_view";
	}

	//글쓰기
	@RequestMapping(value="/space/writePrc", method=RequestMethod.POST)
	public String free_write(HttpServletRequest req, Model model) {
		//서버의 물리적경로 가져오기
		String path = req.getSession().getServletContext().getRealPath("/resources/Upload");
		
		//View로 전달할 데이터 저장용 맵 컬렉션 생성
		Map returnObj = new HashMap();
		Map file = new HashMap();
		String backURL = req.getParameter("backURL");

		//파일외 폼값 받아오기
		String title = req.getParameter("title");
		String name2 = req.getParameter("name2");
		String email2 = req.getParameter("email2");
		String content = req.getParameter("content");
		String tname = req.getParameter("tname");
		int pass2 = Integer.parseInt(req.getParameter("pass2"));
		String id = req.getParameter("id");
		
		file.put("title", title);
		file.put("name2", name2);
		file.put("email2", email2);
		file.put("content", content);
		file.put("tname", tname);
		file.put("pass2", pass2);
		file.put("id", id);
		file.put("backURL", backURL);
		
		try {			
			MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) req;
			//업로드폼의 file속성 필드의 이름을 모두 읽어온다.
			Iterator itr = mhsr.getFileNames();			
			//업로드된 파일명 처리를 위한 변수와 컬렉션 생성
			MultipartFile mfile = null;
			String fileName ="";
			List resultList = new ArrayList();
			
			//업로드폼의 file속성 필드갯수만큼 반복함(2회)
			while(itr.hasNext()) {
				fileName = (String)itr.next();
				
				//서버로 업로드된 임시파일명 가져오기
				mfile = mhsr.getFile(fileName);
				System.out.println("mfile="+mfile);
				
				//한글깨짐방지 처리후 업로드된 파일명을 가져옴
				String ofile = new String(mfile.getOriginalFilename().getBytes(),"UTF-8");
				if("".equals(ofile)) {
					/*
					만약 업로드된 파일명이 공백문자라면 업로드가 되지 않은 것으로 간주하고
					반복의 처음으로 이동한다.
					 */
					continue;
				}
				//파일의 확장자 가져오기
				String ext = ofile.substring(ofile.lastIndexOf('.'));
				//UUID를 통해 생성된 문자열과 확장자 결합
				String nfile = getUuid() +ext;
				/*
				File.separator : 윈도우와 리눅스는 서로 디렉토리를 구분하는
				기호가 다르므로, 해당 OS에 맞는 기호를 자동으로 붙여준다.
				윈도우는 \(역슬러시), 리눅스는 /(슬러시)를 사용하게 된다.
				 */
				File serverFullName = new File(path+File.separator+nfile);
				//조립된 경로에 해당 파일 저장
				mfile.transferTo(serverFullName);
				file.put("ofile", ofile);//원본파일명
				file.put("nfile", nfile);//저장된파일명
				file.put("serverFullName", serverFullName);//서버에 저장된 전체 경로 및 파일명
				
				
				//Map에 저장된 파일정보를 List에 추가한다.
				resultList.add(file);
			}
			
			sqlSession.getMapper(BoardDAO.class).WritePage(file);
			returnObj.put("files", resultList);			
		} 
		catch (IOException e) {
			e.printStackTrace();
			System.out.println("파일업로드 관련 오류");
		}
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("알 수 없는 오류");
		}
				
		model.addAttribute("returnObj", returnObj);
				
		return "redirect:"+backURL;
	}
	
	//게시물 리스트
	@RequestMapping("/space/free")
	public String freelist(Model model, HttpServletRequest req) {
		
		Map param = new HashMap();
		
		//테이블명 명시!!
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
		int nowPage = req.getParameter("nowPage")==null? 1 : Integer.parseInt(req.getParameter("nowPage"));
		//쿼리의 start, end값 구하기
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		param.put("start", start);
		param.put("end", end);		
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath()+"/space/free?"+addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);	
		model.addAttribute("Column", searchColumn);		
		
		//날짜변경
		for(DTO dto : lists) {			
			java.sql.Date sqlDate = new java.sql.Date(dto.getPday().getTime()); 			
			dto.setPday(sqlDate);
		}
		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
			
		return "/space/free";
	}
	
	
	//---------------------------------------------------------------------------------------------------------------
	//게시물 리스트
	@RequestMapping("/space/info")
	public String infolist(Model model, HttpServletRequest req) {
		
		Map param = new HashMap();
		
		//테이블명 명시!!
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
		int nowPage = req.getParameter("nowPage")==null? 1 : Integer.parseInt(req.getParameter("nowPage"));
		//쿼리의 start, end값 구하기
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		param.put("start", start);
		param.put("end", end);		
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath()+"/space/info?"+addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);	
		model.addAttribute("Column", searchColumn);		
		
		//날짜변경
		for(DTO dto : lists) {			
			java.sql.Date sqlDate = new java.sql.Date(dto.getPday().getTime()); 			
			dto.setPday(sqlDate);
		}
		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
			
		return "/space/info";
		}
	
	//글수정 페이지
	@RequestMapping("/info/modify")
	public String infoModify(Model model, HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String idx = req.getParameter("idx");
		String backURL = req.getParameter("backURL");
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).view(idx);
		
		model.addAttribute("lists", lists);	
		
		return "/space/info_modify";		
	}	
		
	
	//페이지 상세보기
	@RequestMapping("/info/View")
	public String info_view(HttpServletRequest req, Model model) {
		
		String idx = req.getParameter("idx");
		
		sqlSession.getMapper(BoardDAO.class).vcnt(idx);
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).view(idx);
			
		//내용에 대한 줄바꿈 처리 부분
		for(DTO dto : lists) {
			String temp = dto.getContent().replace("\r\n", "<br/>");
			dto.setContent(temp);
			
			java.sql.Date sqlDate = new java.sql.Date(dto.getPday().getTime()); 			
			dto.setPday(sqlDate);
		}
		
		
		model.addAttribute("lists", lists);	
				
		return "/space/info_view";
	}
	
	@RequestMapping("/info/write")
	public String info_write() {
		return "/space/info_write";
	}	
	
	@RequestMapping("/info_Download")
	public ModelAndView info_Download(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		
		String nfile = req.getParameter("nfile");
		String ofile = req.getParameter("ofile");
		
		String saveDirectory = req.getSession().getServletContext().getRealPath("/resources/Upload");
		
		File downloadFile = new File(saveDirectory+"/"+nfile);
		
		if(!downloadFile.canRead()) {
			throw new Exception("파일을 찾을 수 없습니다");
		}
		ModelAndView mv = new ModelAndView();
		//servlet-context.xml에서 생성한 다운로드 관련 빈을
		//View로 지정하여 파일을 다운로드 처리한다.
		mv.setViewName("fileDownloadView");
		mv.addObject("downloadFile", downloadFile);
		mv.addObject("ofile", ofile);
		
		System.out.println(ofile+"///"+nfile+"///"+saveDirectory+"///");
		return mv;
	}	
	
	//---------------------------------------------------------------------------------------------------------------
	//게시물 리스트
	@RequestMapping("/space/pic")
	public String piclist(Model model, HttpServletRequest req) {
		
		Map param = new HashMap();
		
		//테이블명 명시!!
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
		int nowPage = req.getParameter("nowPage")==null? 1 : Integer.parseInt(req.getParameter("nowPage"));
		//쿼리의 start, end값 구하기
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		param.put("start", start);
		param.put("end", end);		
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath()+"/space/pic?"+addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);	
		model.addAttribute("Column", searchColumn);		
		
		//날짜변경
		for(DTO dto : lists) {
			String temp = dto.getContent().replace("\r\n", "<br/>");
			dto.setContent(temp);
			
			java.sql.Date sqlDate = new java.sql.Date(dto.getPday().getTime()); 			
			dto.setPday(sqlDate);
		}
		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
			
		return "/space/pic";
		}
	
	//글수정 페이지
	@RequestMapping("/pic/modify")
	public String picModify(Model model, HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String idx = req.getParameter("idx");
		String backURL = req.getParameter("backURL");
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).view(idx);
		
		model.addAttribute("lists", lists);	
		
		return "/space/pic_modify";		
	}	
		
	
	//페이지 상세보기
	@RequestMapping("/pic/View")
	public String pic_view(HttpServletRequest req, Model model) {
		
		String idx = req.getParameter("idx");
		
		sqlSession.getMapper(BoardDAO.class).vcnt(idx);
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).view(idx);
			
		//내용에 대한 줄바꿈 처리 부분
		for(DTO dto : lists) {
			String temp = dto.getContent().replace("\r\n", "<br/>");
			dto.setContent(temp);
			
			java.sql.Date sqlDate = new java.sql.Date(dto.getPday().getTime()); 			
			dto.setPday(sqlDate);
		}
		
		
		model.addAttribute("lists", lists);	
				
		return "/space/pic_view";
	}
	
	@RequestMapping("/pic/write")
	public String pic_write() {
		return "/space/pic_write";
	}	
	
	@RequestMapping("/pic_Download")
	public ModelAndView pic_Download(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		
		String nfile = req.getParameter("nfile");
		String ofile = req.getParameter("ofile");
		
		String saveDirectory = req.getSession().getServletContext().getRealPath("/resources/Upload");
		
		File downloadFile = new File(saveDirectory+"/"+nfile);
		
		if(!downloadFile.canRead()) {
			throw new Exception("파일을 찾을 수 없습니다");
		}
		ModelAndView mv = new ModelAndView();
		//servlet-context.xml에서 생성한 다운로드 관련 빈을
		//View로 지정하여 파일을 다운로드 처리한다.
		mv.setViewName("fileDownloadView");
		mv.addObject("downloadFile", downloadFile);
		mv.addObject("ofile", ofile);
		
		System.out.println(ofile+"///"+nfile+"///"+saveDirectory+"///");
		return mv;
	}
	
	//---------------------------------------------------------------------------------------------------------------
	//---------------------------------------------------------------------------------------------------------------
	//게시물 리스트
	@RequestMapping("/space/program")
	public String programlist(Model model, HttpServletRequest req) {
		
		Map param = new HashMap();
		
		//테이블명 명시!!
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
		int nowPage = req.getParameter("nowPage")==null? 1 : Integer.parseInt(req.getParameter("nowPage"));
		//쿼리의 start, end값 구하기
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		param.put("start", start);
		param.put("end", end);		
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath()+"/space/program?"+addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);	
		model.addAttribute("Column", searchColumn);		
		
		//날짜변경
		for(DTO dto : lists) {
			java.sql.Date sqlDate = new java.sql.Date(dto.getPday().getTime()); 			
			dto.setPday(sqlDate);
		}
		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
		
		return "/space/program";
	}
	
	//글수정 페이지
	@RequestMapping("/program/modify")
	public String programModify(Model model, HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String idx = req.getParameter("idx");
		String backURL = req.getParameter("backURL");
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).view(idx);
		
		model.addAttribute("lists", lists);	
		
		return "/space/program_modify";		
	}	
	
	
	//페이지 상세보기
	@RequestMapping("/program/View")
	public String program_view(HttpServletRequest req, Model model) {
		
		String idx = req.getParameter("idx");
		
		sqlSession.getMapper(BoardDAO.class).vcnt(idx);
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).view(idx);
		
		//내용에 대한 줄바꿈 처리 부분
		for(DTO dto : lists) {
			String temp = dto.getContent().replace("\r\n", "<br/>");
			dto.setContent(temp);
			
			java.sql.Date sqlDate = new java.sql.Date(dto.getPday().getTime()); 			
			dto.setPday(sqlDate);
		}
		
		
		model.addAttribute("lists", lists);	
		
		return "/space/program_view";
	}
	
	@RequestMapping("/program/write")
	public String program_write() {
		return "/space/program_write";
	}	
	
	@RequestMapping("/program_Download")
	public ModelAndView program_Download(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		
		String nfile = req.getParameter("nfile");
		String ofile = req.getParameter("ofile");
		
		String saveDirectory = req.getSession().getServletContext().getRealPath("/resources/Upload");
		
		File downloadFile = new File(saveDirectory+"/"+nfile);
		
		if(!downloadFile.canRead()) {
			throw new Exception("파일을 찾을 수 없습니다");
		}
		ModelAndView mv = new ModelAndView();
		//servlet-context.xml에서 생성한 다운로드 관련 빈을
		//View로 지정하여 파일을 다운로드 처리한다.
		mv.setViewName("fileDownloadView");
		mv.addObject("downloadFile", downloadFile);
		mv.addObject("ofile", ofile);
		
		System.out.println(ofile+"///"+nfile+"///"+saveDirectory+"///");
		return mv;
	}
	//---------------------------------------------------------------------------------------------------------------
	//게시물 리스트
	@RequestMapping("/space/notice")
	public String noticelist(Model model, HttpServletRequest req) {
		
		Map param = new HashMap();
		
		//테이블명 명시!!
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
		int nowPage = req.getParameter("nowPage")==null? 1 : Integer.parseInt(req.getParameter("nowPage"));
		//쿼리의 start, end값 구하기
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		param.put("start", start);
		param.put("end", end);		
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath()+"/space/notice?"+addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);	
		model.addAttribute("Column", searchColumn);		
		
		//날짜변경
		for(DTO dto : lists) {
			java.sql.Date sqlDate = new java.sql.Date(dto.getPday().getTime()); 			
			dto.setPday(sqlDate);
		}
		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
		
		return "/space/notice";
	}
	
	//글수정 페이지
	@RequestMapping("/notice/modify")
	public String noticeModify(Model model, HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String idx = req.getParameter("idx");
		String backURL = req.getParameter("backURL");
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).view(idx);
		
		model.addAttribute("lists", lists);	
		
		return "/space/notice_modify";		
	}	
	
	
	//페이지 상세보기
	@RequestMapping("/notice/View")
	public String notice_view(HttpServletRequest req, Model model) {
		
		String idx = req.getParameter("idx");
		
		sqlSession.getMapper(BoardDAO.class).vcnt(idx);
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).view(idx);
		
		//내용에 대한 줄바꿈 처리 부분
		for(DTO dto : lists) {
			String temp = dto.getContent().replace("\r\n", "<br/>");
			dto.setContent(temp);
			
			java.sql.Date sqlDate = new java.sql.Date(dto.getPday().getTime()); 			
			dto.setPday(sqlDate);
		}

		
		model.addAttribute("lists", lists);	
		
		return "/space/notice_view";
	}
	
	@RequestMapping("/notice/write")
	public String notice_write() {
		return "/space/notice_write";
	}	
	
	@RequestMapping("/notice_Download")
	public ModelAndView notice_Download(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		
		String nfile = req.getParameter("nfile");
		String ofile = req.getParameter("ofile");
		
		String saveDirectory = req.getSession().getServletContext().getRealPath("/resources/Upload");
		
		File downloadFile = new File(saveDirectory+"/"+nfile);
		
		if(!downloadFile.canRead()) {
			throw new Exception("파일을 찾을 수 없습니다");
		}
		ModelAndView mv = new ModelAndView();
		//servlet-context.xml에서 생성한 다운로드 관련 빈을
		//View로 지정하여 파일을 다운로드 처리한다.
		mv.setViewName("fileDownloadView");
		mv.addObject("downloadFile", downloadFile);
		mv.addObject("ofile", ofile);
		
		System.out.println(ofile+"///"+nfile+"///"+saveDirectory+"///");
		return mv;
	}
	
	//---------------------------------------------------------------------------------------------------------------
	//게시물 리스트
	@RequestMapping("/space/crew")
	public String crewlist(Model model, HttpServletRequest req) {
		
		Map param = new HashMap();
		
		//테이블명 명시!!
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
		int nowPage = req.getParameter("nowPage")==null? 1 : Integer.parseInt(req.getParameter("nowPage"));
		//쿼리의 start, end값 구하기
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		param.put("start", start);
		param.put("end", end);		
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath()+"/space/crew?"+addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);	
		model.addAttribute("Column", searchColumn);		
		
		//날짜변경
		for(DTO dto : lists) {
			java.sql.Date sqlDate = new java.sql.Date(dto.getPday().getTime()); 			
			dto.setPday(sqlDate);
		}
		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
		
		return "/space/crew";
	}
	
	//글수정 페이지
	@RequestMapping("/crew/modify")
	public String crewModify(Model model, HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String idx = req.getParameter("idx");
		String backURL = req.getParameter("backURL");
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).view(idx);
		
		model.addAttribute("lists", lists);	
		
		return "/space/crew_modify";		
	}	
	
	
	//페이지 상세보기
	@RequestMapping("/crew/View")
	public String crew_view(HttpServletRequest req, Model model) {
		
		String idx = req.getParameter("idx");
		
		sqlSession.getMapper(BoardDAO.class).vcnt(idx);
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).view(idx);
		
		//내용에 대한 줄바꿈 처리 부분
		for(DTO dto : lists) {
			String temp = dto.getContent().replace("\r\n", "<br/>");
			dto.setContent(temp);
			
			java.sql.Date sqlDate = new java.sql.Date(dto.getPday().getTime()); 			
			dto.setPday(sqlDate);
		}
		
		
		model.addAttribute("lists", lists);	
		
		return "/space/crew_view";
	}
	
	@RequestMapping("/crew/write")
	public String crew_write() {
		return "/space/crew_write";
	}	
	
	@RequestMapping("/crew_Download")
	public ModelAndView crew_Download(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		
		String nfile = req.getParameter("nfile");
		String ofile = req.getParameter("ofile");
		
		String saveDirectory = req.getSession().getServletContext().getRealPath("/resources/Upload");
		
		File downloadFile = new File(saveDirectory+"/"+nfile);
		
		if(!downloadFile.canRead()) {
			throw new Exception("파일을 찾을 수 없습니다");
		}
		ModelAndView mv = new ModelAndView();
		//servlet-context.xml에서 생성한 다운로드 관련 빈을
		//View로 지정하여 파일을 다운로드 처리한다.
		mv.setViewName("fileDownloadView");
		mv.addObject("downloadFile", downloadFile);
		mv.addObject("ofile", ofile);
		
		System.out.println(ofile+"///"+nfile+"///"+saveDirectory+"///");
		return mv;
	}
	
	//---------------------------------------------------------------------------------------------------------------
	//게시물 리스트
	@RequestMapping("/space/fam")
	public String famlist(Model model, HttpServletRequest req) {
		
		Map param = new HashMap();
		
		//테이블명 명시!!
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
		int nowPage = req.getParameter("nowPage")==null? 1 : Integer.parseInt(req.getParameter("nowPage"));
		//쿼리의 start, end값 구하기
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		param.put("start", start);
		param.put("end", end);		
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath()+"/space/fam?"+addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);	
		model.addAttribute("Column", searchColumn);		
		
		//날짜변경
		for(DTO dto : lists) {
			java.sql.Date sqlDate = new java.sql.Date(dto.getPday().getTime()); 			
			dto.setPday(sqlDate);
		}
		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
		
		return "/space/fam";
	}
	
	//글수정 페이지
	@RequestMapping("/fam/modify")
	public String famModify(Model model, HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String idx = req.getParameter("idx");
		String backURL = req.getParameter("backURL");
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).view(idx);
		
		model.addAttribute("lists", lists);	
		
		return "/space/fam_modify";		
	}	
	
	
	//페이지 상세보기
	@RequestMapping("/fam/View")
	public String fam_view(HttpServletRequest req, Model model) {
		
		String idx = req.getParameter("idx");
		
		sqlSession.getMapper(BoardDAO.class).vcnt(idx);
		
		ArrayList<DTO> lists = sqlSession.getMapper(BoardDAO.class).view(idx);
		
		//내용에 대한 줄바꿈 처리 부분
		for(DTO dto : lists) {
			String temp = dto.getContent().replace("\r\n", "<br/>");
			dto.setContent(temp);
			
			java.sql.Date sqlDate = new java.sql.Date(dto.getPday().getTime()); 			
			dto.setPday(sqlDate);
		}
		
		
		model.addAttribute("lists", lists);	
		
		return "/space/fam_view";
	}
	
	@RequestMapping("/fam/write")
	public String fam_write() {
		return "/space/fam_write";
	}	
	
	@RequestMapping("/fam_Download")
	public ModelAndView fam_Download(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		
		String nfile = req.getParameter("nfile");
		String ofile = req.getParameter("ofile");
		
		String saveDirectory = req.getSession().getServletContext().getRealPath("/resources/Upload");
		
		File downloadFile = new File(saveDirectory+"/"+nfile);
		
		if(!downloadFile.canRead()) {
			throw new Exception("파일을 찾을 수 없습니다");
		}
		ModelAndView mv = new ModelAndView();
		//servlet-context.xml에서 생성한 다운로드 관련 빈을
		//View로 지정하여 파일을 다운로드 처리한다.
		mv.setViewName("fileDownloadView");
		mv.addObject("downloadFile", downloadFile);
		mv.addObject("ofile", ofile);
		
		System.out.println(ofile+"///"+nfile+"///"+saveDirectory+"///");
		return mv;
	}
	
	//---------------------------------------------------------------------------------------------------------------
}
