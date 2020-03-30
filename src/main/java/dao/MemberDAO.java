package dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import dto.DTO;

public interface MemberDAO {
	public int joinMember(
			@Param("id") String id,
			@Param("pass") String pass,
			@Param("name") String name,
			@Param("tel") String tel,
			@Param("mobile") String mobile,
			@Param("email") String email,
			@Param("zipcode") int zipcode,
			@Param("addr") String addr,
			@Param("admail") int admail,
			@Param("grade") int grade);		
	
	public int idCheck(String id);
	
	public DTO login(String id, String pass);
	
	public DTO findId(String name, String email);
	
	public DTO findPass(String id, String name, String email);
	
	public int getTotalCount(Map param);
	
	public ArrayList<DTO> listPage(Map param);
	
	public ArrayList<DTO> view(String id);
}
