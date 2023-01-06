package com.mycompany.webapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.StudentVO;

@Mapper
public interface IPagerRepository {
	int getCountStudentRow();
	List<StudentVO> selectStudentListByPage(Pager pager);

}
