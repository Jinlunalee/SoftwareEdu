package com.mycompany.webapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.StudentVO;

@Mapper
public interface IStudentRepository {
	List<StudentVO> getStudentList();
	
}
