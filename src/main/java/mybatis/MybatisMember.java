package mybatis;

import dto.DTO;

public interface MybatisMember {

	//로그인 처리
	public DTO login(String id, String pass);
}
