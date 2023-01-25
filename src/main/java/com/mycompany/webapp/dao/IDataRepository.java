package com.mycompany.webapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.StudentVO;

@Mapper
public interface IDataRepository {

	List<StudentVO> getDataList(@Param("startDay")String startDay, @Param("endDay")String endDay);  // 연계자료 목록 조회
	List<OpenVO> getSbjDataList(@Param("startDay")String startDay, @Param("endDay")String endDay);  //연계자료 강좌정보  조회

}
