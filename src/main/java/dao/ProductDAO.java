package dao;

import java.util.ArrayList;
import java.util.Map;

import dto.DTO;

public interface ProductDAO {

	public int getTotalCount(Map param);
	
	public ArrayList<DTO> listPage(Map param);
	
	public int WritePage(Map param);
	
	public int edit(Map param);
	
	public int delete(String idx);
	
	public ArrayList<DTO> view(String idx);	
	
	public int currval();
}
