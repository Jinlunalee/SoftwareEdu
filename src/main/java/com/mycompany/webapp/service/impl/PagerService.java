package com.mycompany.webapp.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.webapp.dao.IEnrollRepository;
import com.mycompany.webapp.dao.IHomeRepository;
import com.mycompany.webapp.dao.IPagerRepository;
import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.StudentVO;
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
	
	//과정 검색
	@Override
	public int getCountSearchOpenCourseRow(String catCourseCd, String course, String keyword) {
		return pagerRepository.getCountSearchOpenCourseRow(catCourseCd, course, keyword);
	}
	
	@Transactional
	@Override
	public List<OpenVO> selectSearchOpenCourseListByPage(Pager pager, String catCourseCd, String course, String keyword) {
		int endRowNo = pager.getEndRowNo();
		int startRowNo = pager.getStartRowNo();
		
		List<OpenVO> boardList = pagerRepository.selectSearchOpenCourseListByPage(endRowNo, startRowNo, catCourseCd, course, keyword);
		
		// catCourse 공통코드로 catCourseTitle 가져와서 set하기
		for(OpenVO openVo : boardList) {
			openVo.setCatCourseCdTitle(homeRepository.getComnCdTitle(openVo.getCatCourseCd()));
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
				boardList.get(i).setOpenStateCdTitle("모집예정");//모집예정 
			}else if(recruitStartDay < today && today < recruitEndDay) { //모집중
				boardList.get(i).setOpenStateCdTitle("모집중");
			}else { //모집마감 1. 진행중  2.진행완료
				if(startDay < today && today < endDay) { //진행중
					boardList.get(i).setOpenStateCdTitle("진행중");
				}else if(endDay < today){ //진행완료
					boardList.get(i).setOpenStateCdTitle("진행완료");
				}else { //모집마감
					boardList.get(i).setOpenStateCdTitle("모집마감");
				}
			}
		}
		
		return boardList;
	}
	
	//강좌 검색
	@Override
	public int getCountSearchOpenSubjectRow(String catSubjectCd, String subject, String keyword) {
		return pagerRepository.getCountSearchOpenSubjectRow(catSubjectCd, subject, keyword);
	}

	@Transactional
	@Override
	public List<OpenVO> selectSearchOpenSubjectListByPage(Pager pager, String catSubjectCd, String subject, String keyword) {
		int endRowNo = pager.getEndRowNo();
		int startRowNo = pager.getStartRowNo();
		
		List<OpenVO> boardList = pagerRepository.selectSearchOpenSubjectListByPage(endRowNo, startRowNo, catSubjectCd, subject, keyword);
		
		// catSubject 공통코드로 catSubjectTitle 가져와서 set하기
		for(OpenVO openVo : boardList) {
			openVo.setCatSubjectCdTitle(homeRepository.getComnCdTitle(openVo.getCatSubjectCd()));
		}
		
		return boardList;
	}

	@Override
	public int getCountSearchStudentRow(String student, String keyword) {
		return pagerRepository.getCountSearchStudentRow(student, keyword);
	}

	@Override
	public List<StudentVO> selectSearchStudentListByPage(Pager pager, String student, String keyword) {
		int endRowNo = pager.getEndRowNo();
		int startRowNo = pager.getStartRowNo();
		return pagerRepository.selectSearchStudentListByPage(endRowNo, startRowNo, student, keyword);
	}

}
