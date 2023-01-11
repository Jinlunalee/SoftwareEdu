package com.mycompany.webapp.dao;

import org.apache.ibatis.annotations.Param;

public interface IHomeRepository {
	String getComnCdTitle(@Param("comnCd") String comnCd);
}
