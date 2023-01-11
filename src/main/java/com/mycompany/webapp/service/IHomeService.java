package com.mycompany.webapp.service;

import org.apache.ibatis.annotations.Param;

public interface IHomeService {
	String getComnCdTitle(@Param("comnCd") String comnCd);
}
