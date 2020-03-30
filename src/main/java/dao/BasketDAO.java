package dao;

import java.util.ArrayList;
import java.util.Map;

import dto.DTO;

public interface BasketDAO {

	public int getTotalCount(Map param);
	
	public ArrayList<DTO> listPage(Map param);
	
	public ArrayList<DTO> order(String id);
	
	public int WritePage(Map param);
	
	public int UpdatePage(Map param);
	
	public int delete(String pid);
	
	public int scnt(String idx);
	
	public int pay(String pid);
	
	public int conf(String pid);
	
}
