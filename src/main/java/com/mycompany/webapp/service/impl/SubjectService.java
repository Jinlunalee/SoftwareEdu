package com.mycompany.webapp.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.webapp.controller.SubjectController;
import com.mycompany.webapp.dao.ISubjectRepository;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.dto.UploadfileVO;
import com.mycompany.webapp.service.ISubjectService;

@Service
public class SubjectService implements ISubjectService{
	static final Logger logger = LoggerFactory.getLogger(SubjectService.class);
	
	@Autowired
	ISubjectRepository subjectRepository;
	
	@Override
	public List<SubjectVO> selectCourseList() {
		return subjectRepository.selectCourseList();
	}

	@Override
	public List<SubjectVO> selectSubjectList() {
		return subjectRepository.selectSubjectList();
	}

	@Override
	public SubjectVO selectSubjectDetails(String subjectId, int subjectSeq) {
		return subjectRepository.selectSubjectDetails(subjectId, subjectSeq);
	}

	@Override
	public int recruitTotalPeople(String subjectId, int subjectSeq, String state) {
		return subjectRepository.recruitTotalPeople(subjectId, subjectSeq, state);
	}
	
	@Transactional
	@Override
	public int insertSubject(SubjectVO subject) {
		int check = subjectRepository.checkOpenCourse(subject.getCourseId()); //과정 개설 여부 확인
		subjectRepository.insertSubject(subject);
		if(check != 0) { // 같은 과정 존재
			subjectRepository.updateRecruitSameCourse(subject);
		}
		return 0;
	}
	
	@Transactional
	@Override
	public int insertFileData(SubjectVO subject, UploadfileVO file) {
		subjectRepository.insertSubject(subject);
		if(file != null && file.getFileName() != null && file.getFileName().equals("")) {
			file.setSubjectId(subject.getSubjectId());
			subjectRepository.insertFileData(file);
		}
		return 0;
	}

	@Override
	public List<SubjectVO> selectAllCourse() {
		return subjectRepository.selectAllCourse();
	}

	@Override
	public List<SubjectVO> selectAllSubject() {
		return subjectRepository.selectAllSubject();
	}

	@Override
	public int updateSubject(SubjectVO subject) {
		return subjectRepository.updateSubject(subject);
	}
	
	@Transactional
	@Override
	public int updateFileData(SubjectVO subject, UploadfileVO file) {
		subjectRepository.updateSubject(subject);
		if(file != null && file.getFileName() != null && file.getFileName().equals("")) {
			file.setSubjectId(subject.getSubjectId());
			subjectRepository.updateFileData(file);
		}
		return 0;
	}
	
	@Transactional
	@Override
	public List<SubjectVO> infoSubjectCourse(String courseId, String subjectId) {
		List<SubjectVO> list = new ArrayList<>(); //이렇게 초기화해주기 꼭 
		int check = subjectRepository.checkOpenCourse(courseId); //과정 개설 여부 확인
		
		logger.info("service/infoSubjectCourse/check : " + check);
		
		if("none".equals(courseId)) { // 과정 입력 X
			logger.info("coursId X");
			list.add(subjectRepository.infoSubject(subjectId)); // 강좌에 대한 정보만 가져옴
		}else { //coursId 있는경우 - open테이블에 있는경우와 없는 경우(개설한 경우와 최초개설인 경우)
			logger.info("coursId O");
			if(check == 0) { //최초개설
				list.add(subjectRepository.infoSubject(subjectId));// 신청일자를 가져올 필요없으므로 강좌에 대한 정보만 가져옴
			}else { //개설되어있는 경우
				list.add(subjectRepository.infoOpenCourse(courseId)); //신청일자 연동위해 데이터 가져오기
				list.add(subjectRepository.infoSubject(subjectId)); //강좌에 대한 정보 가져오기
			}
		}
		logger.info("service/infoSubjectCourse/list: " + list);
		return list;
		
		////////////////////////////////////
//		VO로 데이터 전송
//		SubjectVO subject = null;
//		logger.info("service/infoSubjectCourse/courseId : " + courseId.getClass().getName());
//		
//		if("none".equals(courseId)) {
//			return subjectRepository.infoSubject(subjectId);
//		}else { //coursId 있는경우
//			subject = subjectRepository.infoSubject(subjectId);
//			subjectRepository.infoOpenCourse(courseId);
//			logger.info("service/infoSubjectCourse/subject: " + subject);
//			return subject;
//		}
		
		
	}
}
