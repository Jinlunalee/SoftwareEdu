package com.mycompany.webapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;

@Mapper
public interface IDataRepository {

	List<StudentVO> getDataList();  // 연계자료 목록 조회
	List<SubjectVO> getSbjDataList();
	
	// 밑에 추가
	/*
	public List<StudentVO> selectByPage(Pager pager);
	public int count();
	public StudentVO selectByBno(int bno);
	*/
}
