package com.tjoeun.dao;

import com.tjoeun.vo.MainVO;

// LoginController => LoginDAO => login.xml (xml의 mapper namespace에서 DAO 매핑해야 작동 )
// xml의 sql명령으로 얻어온 데이터 => DAO => Controller => Model 혹은 request로 데이터 넣어 jsp로

public interface LoginDAO {
	
	MainVO selectbyCnum(int cnum);

}