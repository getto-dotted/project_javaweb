package dao;

import java.util.ArrayList;
import java.util.Map;

import dto.DTO;

public interface BoardDAO {

	public int getTotalCount(Map param);
	
	public ArrayList<DTO> listPage(Map param);
	
	public int WritePage(Map param);
	
	public int edit(Map param);
	
	public int delete(String idx, String id);
	
	public ArrayList<DTO> view(String idx);
	
	public int vcnt(String idx);
}
