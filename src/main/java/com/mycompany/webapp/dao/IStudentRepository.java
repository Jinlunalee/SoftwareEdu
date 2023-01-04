package com.mycompany.webapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;


import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.StudentVO;

@Mapper
public interface IStudentRepository {
	List<StudentVO> getStudentList();// 수강생 목록 조회
	
	
	// 밑에 추가
	/*
	public List<StudentVO> selectByPage(Pager pager);
	public int count();
	public StudentVO selectByBno(int bno);
	*/
}
