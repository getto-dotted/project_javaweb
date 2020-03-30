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

import dao.ProductDAO;
import dto.DTO;
import util.EnvFileReader;
import util.PagingUtil;

@Controller
public class MarketController {

	@RequestMapping("/market/sub01")
	public String sub01() {
		return "/market/sub01";
	}
	@RequestMapping("/market/sub02")
	public String sub02() {
		return "/market/sub02";
	}	
	@RequestMapping("/market/sub03")
	public String sub03() {
		return "/market/sub03";
	}	
	@RequestMapping("/market/sub04")
	public String sub04() {
		return "/market/sub04";
	}	
	@RequestMapping("/market/sub05")
	public String sub05() {
		return "/market/sub05";
	}	
	@RequestMapping("/market/market_view")
	public String market_view() {
		return "/market/market_view";
	}	
	
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
	@RequestMapping("/market/write")
	public String market_write() {
		return "/market/market_write";
	}	
	
	
	//글 삭제하기
	@RequestMapping("/market/delete")
	public String delete(Model model, HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String idx = req.getParameter("idx");
		
		sqlSession.getMapper(ProductDAO.class).delete(idx);
				
		return "redirect:/market/market";		
	}	
	//페이지 상세보기
	@RequestMapping("/market/View")
	public String market_view(HttpServletRequest req, Model model) {
		
		String idx = req.getParameter("idx");
		
		//sqlSession.getMapper(ProductDAO.class).scnt(idx);
		
		ArrayList<DTO> lists = sqlSession.getMapper(ProductDAO.class).view(idx);
			
		//내용에 대한 줄바꿈 처리 부분
		for(DTO dto : lists) {
			String temp = dto.getInfo().replace("\r\n", "<br/>");
			dto.setInfo(temp);
		}
		
		
		model.addAttribute("lists", lists);	
				
		return "/market/market_view";
	}

	//글쓰기
	@RequestMapping(value="/market/writePrc", method=RequestMethod.POST)
	public String market_write(HttpServletRequest req, Model model) {
		//서버의 물리적경로 가져오기
		String path = req.getSession().getServletContext().getRealPath("/resources/Upload");
		
		//View로 전달할 데이터 저장용 맵 컬렉션 생성
		Map returnObj = new HashMap();
		Map file = new HashMap();
		String backURL = req.getParameter("backURL");
		
		//파일외 폼값 받아오기
		String name = req.getParameter("name");
		String info = req.getParameter("info");
		String price = req.getParameter("price");
		String dispoint = req.getParameter("dispoint");
		String stock = req.getParameter("stock");
		String deli = req.getParameter("deli");
		String dprice = req.getParameter("dprice");
		String etc = req.getParameter("etc");
		
		if(dprice==null||dprice.equals("")) {
			dprice="0";
		}
		
		file.put("name", name);
		file.put("info", info);
		file.put("price", price);
		file.put("dispoint", dispoint);
		file.put("stock", stock);
		file.put("deli", deli);
		file.put("dprice", dprice);
		file.put("etc", etc);
		
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
			
			sqlSession.getMapper(ProductDAO.class).WritePage(file);
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
		
		int idx = sqlSession.getMapper(ProductDAO.class).currval();
		
		model.addAttribute("returnObj", returnObj);
				
		return "redirect:"+backURL+(idx-1);
	}
	
	//게시물 리스트
	@RequestMapping("/market/market")
	public String marketlist(Model model, HttpServletRequest req) {
		
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
				req.getContextPath()+"/market/market?"+addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalCount", totalRecordCount);	
		model.addAttribute("Column", searchColumn);	
		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
			
		return "/market/market";
	}
	//글수정 페이지
	@RequestMapping("/market/modify")
	public String marketModify(Model model, HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("user_id")==null) {
			return "redirect:/member/login";
		}
		
		String idx = req.getParameter("idx");
		String backURL = req.getParameter("backURL");
		
		ArrayList<DTO> lists = sqlSession.getMapper(ProductDAO.class).view(idx);
		
		model.addAttribute("lists", lists);	
		
		return "/market/market_modify";		
	}	
	
	//글수정하기
	@RequestMapping(value="/market/modifyPrc", method=RequestMethod.POST)
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
		String name = req.getParameter("name");
		String info = req.getParameter("info");
		String price = req.getParameter("price");
		String dispoint = req.getParameter("dispoint");
		String stock = req.getParameter("stock");
		String deli = req.getParameter("deli");
		String dprice = req.getParameter("dprice");
		String etc = req.getParameter("etc");
		String dbofile = req.getParameter("ofile");
		String dbnfile = req.getParameter("nfile");
		
		if(dprice==null||dprice.equals("")) {
			dprice="0";
		}
		
		file.put("idx", idx);
		file.put("name", name);
		file.put("info", info);
		file.put("price", price);
		file.put("dispoint", dispoint);
		file.put("stock", stock);
		file.put("deli", deli);
		file.put("dprice", dprice);
		file.put("etc", etc);	
		
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
									
			sqlSession.getMapper(ProductDAO.class).edit(file);			
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
		
	
	//---------------------------------------------------------------------------------------------------------------
}
