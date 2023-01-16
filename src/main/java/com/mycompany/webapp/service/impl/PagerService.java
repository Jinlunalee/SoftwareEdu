package com.mycompany.webapp.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.webapp.dao.IEnrollRepository;
import com.mycompany.webapp.dao.IHomeRepository;
import com.mycompany.webapp.dao.IPagerRepository;
import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.IPagerService;

@Service
public class PagerService implements IPagerService {
	static final Logger logger = LoggerFactory.getLogger(SubjectService.class);

	@Autowired
	IPagerRepository pagerRepository;
	
	@Autowired
	IHomeRepository homeRepository;
	
	@Autowired
	IEnrollRepository enrollRepository;
	
	@Override
	public int getCountStudentRow() {
		return pagerRepository.getCountStudentRow();
	}
	
	@Override
	public List<StudentVO> selectStudentListByPage(Pager pager) {
		return pagerRepository.selectStudentListByPage(pager);
	}

	@Override
	public int getCountOpenCourseRow(String catCourse) {
		return pagerRepository.getCountOpenCourseRow(catCourse);
	}

	@Override
	public List<SubjectVO> selectOpenCourseListByPage(Pager pager, String catCourse) {
		List<SubjectVO> boardList = pagerRepository.selectOpenCourseListByPage(pager.getEndRowNo(), pager.getStartRowNo(), catCourse);
		// catCourse 공통코드로 catCourseTitle 가져와서 set하기
		for(SubjectVO subjectVo : boardList) {
			subjectVo.setCatCourseTitle(homeRepository.getComnCdTitle(subjectVo.getCatCourse()));
		}
		
		//기간에 따라 상태 표현
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd"); // 포맷팅 정의
		int today = Integer.parseInt(formatter.format(new Date()));
		for(int i=0;i<boardList.size();i++) {
			int startDay = Integer.parseInt(boardList.get(i).getStartDay().replaceAll("-", ""));
			int endDay = Integer.parseInt(boardList.get(i).getEndDay().replaceAll("-", ""));
			int recruitStartDay = Integer.parseInt(boardList.get(i).getRecruitStartDay().replaceAll("-", ""));
			int recruitEndDay = Integer.parseInt(boardList.get(i).getRecruitEndDay().replaceAll("-", ""));
			
			if(today < recruitStartDay) {
				boardList.get(i).setComnCdTitle("모집예정");//모집예정 
			}else if(recruitStartDay < today && today < recruitEndDay) { //모집중
				boardList.get(i).setComnCdTitle("모집중");
			}else { //모집마감 1. 진행중  2.진행완료
				if(startDay < today && today < endDay) { //진행중
					boardList.get(i).setComnCdTitle("진행중");
				}else if(endDay < today){ //진행완료
					boardList.get(i).setComnCdTitle("진행완료");
				}else { //모집마감
					boardList.get(i).setComnCdTitle("모집마감");
				}
			}
		}
		return boardList;
	}

	@Override
	public int getCountOpenSubjectRow(String catSubject) {
		return pagerRepository.getCountOpenSubjectRow(catSubject);
	}

	@Override
	public List<SubjectVO> selectOpenSubjectListByPage(Pager pager, String catSubject) {
		List<SubjectVO> boardList = pagerRepository.selectOpenSubjectListByPage(pager.getEndRowNo(), pager.getStartRowNo(), catSubject);
		// catSubject 공통코드로 catSubjectTitle 가져와서 set하기
		for(SubjectVO subjectVo : boardList) {
			subjectVo.setCatSubjectTitle(homeRepository.getComnCdTitle(subjectVo.getCatSubject()));
		}
		return boardList;
	}

	@Override
	public int getCountEnrollRow() {
		return pagerRepository.getCountEnrollRow();
	}

	@Override
	public List<EnrollVO> selectEnrollListByPage(Pager pager) {
		List<EnrollVO> boardList = pagerRepository.selectEnrollListByPage(pager);
		// stateCd, openStateCd 공통코드로 stateCdTitle, openStateCdTitle 가져와서 set하기
		for(EnrollVO enrollVo : boardList) {
			enrollVo.setRatio(enrollRepository.getRatioUsingEnrollId(enrollVo.getEnrollId()));	// 진도율 set
			enrollVo.setStateCdTitle(homeRepository.getComnCdTitle(enrollVo.getStateCd()));
			enrollVo.setOpenStateCdTitle(homeRepository.getComnCdTitle(enrollVo.getOpenStateCd()));
			enrollVo.setOpenStateCdTitle(homeRepository.getComnCdTitle(enrollVo.getOpenStateCd()));
			
			if(enrollVo.getCancelRsCd() != null) {
			enrollVo.setCancelRsTitle(homeRepository.getComnCdTitle(enrollVo.getCancelRsCd()));
			}
		}
		return boardList;
	}

	@Override
	public int getCountSearchRow(EnrollVO enroll) {
		// TODO Auto-generated method stub
		return pagerRepository.getCountSearchRow(enroll);
	}

	@Override
	public List<EnrollVO> selectSearchListByPage(EnrollVO enroll, Pager pager) {
		String applyStartDay = enroll.getApplyStartDay();
		String applyEndDay = enroll.getApplyEndDay();
		String student = enroll.getStudent();
		String course = enroll.getCourse();
		String state = enroll.getState();
		String keyword1 = enroll.getKeyword1();
		String keyword2 = enroll.getKeyword2();
		
		int endRowNo = pager.getEndRowNo();
		int startRowNo = pager.getStartRowNo();
		
		List<EnrollVO> boardList = pagerRepository.selectSearchListByPage(applyStartDay, applyEndDay, student, course, state, endRowNo, startRowNo, keyword1, keyword2);
		// stateCd, openStateCd 공통코드로 stateCdTitle, openStateCdTitle 가져와서 set하기
		for(EnrollVO enrollVo : boardList) {
			enrollVo.setStateCdTitle(homeRepository.getComnCdTitle(enrollVo.getStateCd()));
			enrollVo.setOpenStateCdTitle(homeRepository.getComnCdTitle(enrollVo.getOpenStateCd()));
			
			if(enrollVo.getCancelRsCd() != null) {
				enrollVo.setCancelRsTitle(homeRepository.getComnCdTitle(enrollVo.getCancelRsCd()));
			}
		}
		return boardList;
	}
	
	



}
