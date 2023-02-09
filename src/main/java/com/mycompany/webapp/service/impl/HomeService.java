package com.mycompany.webapp.service.impl;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.webapp.dao.IEnrollRepository;
import com.mycompany.webapp.dao.IHomeRepository;
import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.CourseVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.IHomeService;
@Service
public class HomeService implements IHomeService {
	@Autowired
	IHomeRepository homeRepository;
	
	@Autowired
	IEnrollRepository enrollRepository;

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
			subjectVoReturn.setLevelCdTitle(homeRepository.getComnCdTitle(subjectVoReturn.getLevelCd()));
			subjectVoReturn.setCatSubjectCdTitle(homeRepository.getComnCdTitle(subjectVoReturn.getCatSubjectCd()));
		}
		return boardList;
	}
	
	@Transactional
	@Override
	public List<CourseVO> searchCourse(CourseVO courseVo) {
		List<CourseVO> boardList = homeRepository.searchCourse(courseVo);
		for(CourseVO courseVoReturn : boardList) {
			courseVoReturn.setCatCourseCdTitle(homeRepository.getComnCdTitle(courseVoReturn.getCatCourseCd()));
			courseVoReturn.setCheckFirst(homeRepository.checkCourseByYearandState(courseVoReturn.getCourseId()));
		}
		return boardList;
	}
	
	@Override
	public List<OpenVO> searchOpenSubject(OpenVO openVo) {
		List<OpenVO> boardList = homeRepository.searchOpenSubject(openVo);
		// level, state, catSubject 공통코드로 가져와서 set 하기, totalPeople set하기
		for(OpenVO openVoReturn : boardList) {
			openVoReturn.setTotalPeople(enrollRepository.recruitTotalPeople(openVoReturn.getSubjectId(), openVoReturn.getSubjectSeq(), openVoReturn.getOpenStateCd())); //subject의 상태에 따라 카운드할 수강생 상태가 달라짐
			openVoReturn.setLevelCdTitle(homeRepository.getComnCdTitle(openVoReturn.getLevelCd()));
			openVoReturn.setOpenStateCdTitle(homeRepository.getComnCdTitle(openVoReturn.getOpenStateCd()));
			openVoReturn.setCatSubjectCdTitle(homeRepository.getComnCdTitle(openVoReturn.getCatSubjectCd()));
		}
		return boardList;
	}

	@Override
	public List<OpenVO> searchOpenCourse(OpenVO openVo) {
		List<OpenVO> boardList = homeRepository.searchOpenCourse(openVo);
		System.out.println(boardList);
		
		for(OpenVO openVoReturn : boardList) {
			// state, catSubject 공통코드로 가져와서 set 하기
			openVoReturn.setCatCourseCdTitle(homeRepository.getComnCdTitle(openVoReturn.getCatCourseCd()));
			openVoReturn.setOpenStateCdTitle(homeRepository.getComnCdTitle(openVoReturn.getOpenStateCd()));
		}
		return boardList;
	}

	@Override
	public List<StudentVO> searchStudentList(StudentVO studentVo) {
		
		List<StudentVO> searchStudentList = homeRepository.searchStudentList(studentVo);
		
		for(StudentVO student : searchStudentList) {
			student.setGenderTitle(homeRepository.getComnCdTitle(student.getGenderCd()));
			student.setAddDoTitle(homeRepository.getComnCdTitle(student.getAddDoCd()));
			student.setPositionTitle(homeRepository.getComnCdTitle(student.getPositionCd()));
		}
		
		return searchStudentList;
	}
	
	public List<OpenVO> selectSubjectListByCourseId(OpenVO openVo) {
		List<OpenVO> list = homeRepository.selectSubjectListByCourseId(openVo);
		for(OpenVO open : list) {
			open.setLevelCdTitle(homeRepository.getComnCdTitle(open.getLevelCd()));
		}
		return list;
	}

	@Override
	public List<String> selectYearListByPop(String pop) {
		List<String> yearList = homeRepository.selectYearListByPop(pop);
		return yearList;
	}

}
