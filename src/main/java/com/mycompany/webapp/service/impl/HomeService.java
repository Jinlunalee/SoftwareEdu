package com.mycompany.webapp.service.impl;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.webapp.dao.IHomeRepository;
import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.CourseVO;
import com.mycompany.webapp.dto.StudentVO;
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
	public List<CourseVO> searchCourse(CourseVO courseVo) {
		List<CourseVO> boardList = homeRepository.searchCourse(courseVo);
		for(CourseVO courseVoReturn : boardList) {
			courseVoReturn.setCatCourseCdTitle(homeRepository.getComnCdTitle(courseVoReturn.getCatCourseCd()));
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

	@Override
	public List<CourseVO> searchOpenCourse(CourseVO courseVo) {
		List<CourseVO> boardList = homeRepository.searchOpenCourse(courseVo);
		
		
		for(CourseVO courseVoReturn : boardList) {
			// state, catSubject 공통코드로 가져와서 set 하기
			courseVoReturn.setCatCourseCdTitle(homeRepository.getComnCdTitle(courseVoReturn.getCatCourseCd()));
			
			//기간에 따라 상태 표현
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd"); // 포맷팅 정의
			int today = Integer.parseInt(formatter.format(new Date()));
			for(int i=0;i<boardList.size();i++) {
				int startDay = Integer.parseInt(boardList.get(i).getStartDay().replaceAll("-", ""));
				int endDay = Integer.parseInt(boardList.get(i).getEndDay().replaceAll("-", ""));
				int recruitStartDay = Integer.parseInt(boardList.get(i).getRecruitStartDay().replaceAll("-", ""));
				int recruitEndDay = Integer.parseInt(boardList.get(i).getRecruitEndDay().replaceAll("-", ""));
				
				if(today < recruitStartDay) {
					boardList.get(i).setStateCd("OPN01");//모집예정 
				}else if(recruitStartDay < today && today < recruitEndDay) { //모집중
					boardList.get(i).setStateCd("OPN02");
				}else { //모집마감 1. 진행중  2.진행완료
					if(startDay < today && today < endDay) { //진행중
						boardList.get(i).setStateCd("OPN04");
					}else if(endDay < today){ //진행완료
						boardList.get(i).setStateCd("OPN05");
					}else { //모집마감
						boardList.get(i).setStateCd("OPN03");
					}
				}
			}
			
			courseVoReturn.setStateCdTitle(homeRepository.getComnCdTitle(courseVoReturn.getStateCd()));
			// 여기에서 상태 검색 적용어떻게 하지?

		}
		return boardList;
	}

	public List<StudentVO> searchStudentList(StudentVO studentVo) {
		return homeRepository.searchStudentList(studentVo);
	}


}
