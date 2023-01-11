package com.mycompany.webapp.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.webapp.controller.SubjectController;
import com.mycompany.webapp.dao.IEnrollRepository;
import com.mycompany.webapp.dao.ISubjectRepository;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.dto.UploadfileVO;
import com.mycompany.webapp.service.ISubjectService;

@Service
public class SubjectService implements ISubjectService{
	static final Logger logger = LoggerFactory.getLogger(SubjectService.class);
	
	@Autowired
	ISubjectRepository subjectRepository;
	
	@Autowired
	IEnrollRepository enrollRepository;
	
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
	
	@Transactional
	@Override
	public int insertSubject(SubjectVO subject) {
		int check = subjectRepository.checkOpenCourse(subject.getCourseId()); //과정 개설 여부 확인
		subjectRepository.insertSubject(subject);
		if(check > 0) { // 같은 과정 존재
			subjectRepository.updateRecruitSameCourse(subject);
		}
		return 0;
	}
	
	@Transactional
	@Override
	public int insertFileData(SubjectVO subject, UploadfileVO file) {
		int check = subjectRepository.checkOpenCourse(subject.getCourseId()); //과정 개설 여부 확인
		if(check > 0) { // 같은 과정 존재
			subjectRepository.updateRecruitSameCourse(subject);
		}
		String maxFileId = subjectRepository.selectMaxFileId();
		String maxFileId1 = maxFileId.substring(0,4);
		String maxFileId2 = String.format("%04d", Integer.parseInt(maxFileId.substring(4))+1); //4자리수 맞추기
		logger.info("maxFileID: "+maxFileId1+maxFileId2);
		
		subject.setFileId(maxFileId1+maxFileId2);
		file.setFileId(maxFileId1+maxFileId2);
		
		if(file != null && file.getFileName() != null && !file.getFileName().equals("")) {
			subjectRepository.insertFileData(file);
		}
		subjectRepository.insertSubject(subject);
		return 0;
	}
	
	@Override
	public UploadfileVO getFile(String fileId) {
		return subjectRepository.getFile(fileId);
	}
	
	@Override
	public List<SubjectVO> selectAllCourse() {
		return subjectRepository.selectAllCourse();
	}

	@Override
	public List<SubjectVO> selectAllSubject() {
		return subjectRepository.selectAllSubject();
	}
	
	@Transactional
	@Override
	public int updateSubject(SubjectVO subject) {
		int check = subjectRepository.checkOpenCourse(subject.getCourseId()); //과정 개설 여부 확인
		subjectRepository.updateSubject(subject);
		if(check > 0) { // 같은 과정 존재
			subjectRepository.updateRecruitSameCourse(subject);
		}
		return 0;
	}
	
	@Transactional
	@Override
	public int updateFileData(SubjectVO subject, UploadfileVO file) {
		logger.info("service/updatefiledate/:" + subject.getFileId() + file.getFileId());
		logger.info("service/update/subject:" +subject);
		logger.info("service/update/subject:" +file);
		
		int check = subjectRepository.checkOpenCourse(subject.getCourseId()); //과정 개설 여부 확인
		if(check > 0) { // 같은 과정 존재
			subjectRepository.updateRecruitSameCourse(subject);
		}
		
		if(subject.getFileId() == null || subject.getFileId() == null || subject.getFileId().equals("")) { //그전에 파일이 없다가 나중에 추가
			String maxFileId = subjectRepository.selectMaxFileId();
			String maxFileId1 = maxFileId.substring(0,4);
			String maxFileId2 = String.format("%04d", Integer.parseInt(maxFileId.substring(4))+1); //4자리수 맞추기
			logger.info("maxFileID: "+maxFileId1+maxFileId2);
			
			subject.setFileId(maxFileId1+maxFileId2);
			file.setFileId(maxFileId1+maxFileId2);
			
			if(file != null && file.getFileName() != null && !file.getFileName().equals("")) {//첨부파일있을때 
				subjectRepository.insertFileData(file);	
				logger.info("insert filedata:"+file);
			}
			logger.info("update subject:"+subject);
			subjectRepository.updateSubject(subject);//fk때문에 나중에 입력되어야 함
		}else { //파일 있다가 수정
			if(file != null && file.getFileName() != null && !file.getFileName().equals("")) {
				file.setFileId(subject.getFileId());
				subjectRepository.updateFileData(file);
			}
			subjectRepository.updateSubject(subject);
		}
		
		return 0;
	}
	
	@Transactional
	@Override
	public Map<String, Object> infoSubjectCourse(String courseId, String subjectId) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int check = subjectRepository.checkOpenCourse(courseId); //과정 개설 여부 확인
		
		logger.info("service/infoSubjectCourse/check : " + check);
		
		if("".equals(courseId)) { // 과정 입력 X
			logger.info("coursId X");
			map.put("subjectInfo", subjectRepository.infoSubject(subjectId)); // 강좌에 대한 정보만 가져옴
		}else { //coursId 있는경우 - open테이블에 있는경우와 없는 경우(개설한 경우와 최초개설인 경우)
			logger.info("coursId O");
			if(check == 0) { //최초개설
				map.put("subjectInfo", subjectRepository.infoSubject(subjectId));// 신청일자를 가져올 필요없으므로 강좌에 대한 정보만 가져옴
			}else { //개설되어있는 경우
				map.put("courseInfo", subjectRepository.infoOpenCourse(courseId)); //신청일자 연동위해 데이터 가져오기
				map.put("subjectInfo", subjectRepository.infoSubject(subjectId));//강좌에 대한 정보 가져오기
				map.put("checkList", subjectRepository.selectSubjectByCourseId(courseId)); //과정안에 포함되어있는 강좌이름 가져오기
			}
		}
		logger.info("service/infoSubjectCourse/list: " + map);
		return map;
	}
//	public List<SubjectVO> infoSubjectCourse(String courseId, String subjectId) {
//		List<SubjectVO> list = new ArrayList<>(); //이렇게 초기화해주기 꼭 
//		int check = subjectRepository.checkOpenCourse(courseId); //과정 개설 여부 확인
//		
//		logger.info("service/infoSubjectCourse/check : " + check);
//		
//		if("".equals(courseId)) { // 과정 입력 X
//			logger.info("coursId X");
//			list.add(subjectRepository.infoSubject(subjectId)); // 강좌에 대한 정보만 가져옴
//		}else { //coursId 있는경우 - open테이블에 있는경우와 없는 경우(개설한 경우와 최초개설인 경우)
//			logger.info("coursId O");
//			if(check == 0) { //최초개설
//				list.add(subjectRepository.infoSubject(subjectId));// 신청일자를 가져올 필요없으므로 강좌에 대한 정보만 가져옴
//			}else { //개설되어있는 경우
//				list.add(subjectRepository.infoOpenCourse(courseId)); //신청일자 연동위해 데이터 가져오기
//				list.add(subjectRepository.infoSubject(subjectId)); //강좌에 대한 정보 가져오기
////				list.add(subjectRepository.selectSubjectByCourseId(courseId)); //과정안에 포함되어있는 강좌이름 가져오기
//			}
//		}
//		logger.info("service/infoSubjectCourse/list: " + list);
//		return list;
////	}
		
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


	@Override
	public void clickDeleteOpen(String subjectId, int subjectSeq) {
		subjectRepository.clickDeleteOpen(subjectId, subjectSeq);
	}

	@Override
	public void clickDeleteUploadFile(String fileId) {
		subjectRepository.clickDeleteUploadFile(fileId);
	}
	
	@Transactional
	@Override
	public int closeSubject(String subjectId, int subjectSeq) {
		logger.info("service/closeSubject");
		subjectRepository.closeSubject(subjectId, subjectSeq); // 폐강처리
		logger.info("setvice/updateEnrollCancel");
		enrollRepository.updateEnrollCancel(); // 강좌 폐강시 해당 강좌 듣는 수강생도 수강취소 처리
		return 0;
	}

	@Override
	public List<SubjectVO> selectSubjectByCourseId(String courseId) {
		return subjectRepository.selectSubjectByCourseId(courseId);
	}
	
}
