package com.mycompany.webapp.service.impl;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.webapp.dao.IHomeRepository;
import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.IHomeService;
@Service
public class HomeService implements IHomeService {
	@Autowired
	IHomeRepository homeRepository;
	
	@Override
	public List<SubjectVO> selectSubjectList(String catSubject) {

		return homeRepository.selectSubjectList(catSubject); 
	}

	@Override
	public List<SubjectVO> selectCourseList(String catCourse) {
		return homeRepository.selectCourseList(catCourse); 
	}

	@Override
	public String getComnCdTitle(String comnCd) {
		return homeRepository.getComnCdTitle(comnCd);
	}

	@Override
	public List<CommonCodeVO> getComnCdList(String comnCdType) {
		return homeRepository.getComnCdList(comnCdType);
	}

	@Override
	public List<SubjectVO> searchSubject(SubjectVO subjectVo) {
		List<SubjectVO> boardList = homeRepository.searchSubject(subjectVo);
		for(SubjectVO subjectVoReturn : boardList) {
			subjectVoReturn.setLevelTitle(homeRepository.getComnCdTitle(subjectVoReturn.getLevel()));
			subjectVoReturn.setCatSubjectTitle(homeRepository.getComnCdTitle(subjectVoReturn.getCatSubject()));
		}
		return boardList;
	}
	@Override
	public List<SubjectVO> searchOpenSubject(SubjectVO subjectVo) {
		List<SubjectVO> boardList = homeRepository.searchOpenSubject(subjectVo);
		// level, state, catSubject 공통코드로 가져와서 set 하기
		for(SubjectVO subjectVoReturn : boardList) {
			subjectVoReturn.setLevelTitle(homeRepository.getComnCdTitle(subjectVoReturn.getLevel()));
			subjectVoReturn.setComnCdTitle(homeRepository.getComnCdTitle(subjectVoReturn.getState()));
			subjectVoReturn.setCatSubjectTitle(homeRepository.getComnCdTitle(subjectVoReturn.getCatSubject()));
		}
		return boardList;
	}


}
