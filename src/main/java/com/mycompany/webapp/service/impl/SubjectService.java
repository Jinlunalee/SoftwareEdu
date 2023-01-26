package com.mycompany.webapp.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.webapp.dao.IEnrollRepository;
import com.mycompany.webapp.dao.IHomeRepository;
import com.mycompany.webapp.dao.ISubjectRepository;
import com.mycompany.webapp.dto.CourseVO;
import com.mycompany.webapp.dto.OpenVO;
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
	
	@Autowired
	IHomeRepository homeRepository;
	
	@Override
	public List<OpenVO> selectCourseList() {
		return subjectRepository.selectCourseList();
	}

	@Override
	public List<OpenVO> selectSubjectList() {
		return subjectRepository.selectSubjectList();
	}
	
	@Transactional
	@Override
	public OpenVO selectSubjectDetails(String subjectId, int subjectSeq) {
		OpenVO openVo = subjectRepository.selectSubjectDetails(subjectId, subjectSeq);
		openVo.setLevelCdTitle(homeRepository.getComnCdTitle(openVo.getLevelCd()));
		return openVo;
	}
	
	@Transactional
	@Override
	public int insertSubject(OpenVO openVo) {
		int check = subjectRepository.checkOpenCourse(openVo.getCourseId()); //과정 개설 여부 확인
		subjectRepository.insertSubject(openVo);
		if(check > 0) { // 같은 과정 존재
			subjectRepository.updateRecruitSameCourse(openVo);
		}
		return 0;
	}
	
	@Transactional
	@Override
	public int insertFileData(OpenVO openVo, UploadfileVO file) {
		int check = subjectRepository.checkOpenCourse(openVo.getCourseId()); //과정 개설 여부 확인
		if(check > 0) { // 같은 과정 존재
			subjectRepository.updateRecruitSameCourse(openVo);
		}
		String maxFileId = subjectRepository.selectMaxFileId();
		String maxFileId1 = maxFileId.substring(0,4);
		String maxFileId2 = String.format("%04d", Integer.parseInt(maxFileId.substring(4))+1); //4자리수 맞추기
		logger.info("maxFileID: "+maxFileId1+maxFileId2);
		
		openVo.setFileId(maxFileId1+maxFileId2);
		file.setFileId(maxFileId1+maxFileId2);
		
		if(file != null && file.getFileName() != null && !file.getFileName().equals("")) {
			subjectRepository.insertFileData(file);
		}
		subjectRepository.insertSubject(openVo);
		return 0;
	}
	
	@Override
	public UploadfileVO getFile(String fileId) {
		return subjectRepository.getFile(fileId);
	}
	
	@Override
	public List<CourseVO> selectAllCourse() {
		return subjectRepository.selectAllCourse();
	}

	@Override
	public List<SubjectVO> selectAllSubject() {
		return subjectRepository.selectAllSubject();
	}
	
	@Transactional
	@Override
	public int updateSubject(OpenVO openVo) {
		int check = subjectRepository.checkOpenCourse(openVo.getCourseId()); //과정 개설 여부 확인
		subjectRepository.updateSubject(openVo);
		if(check > 0) { // 같은 과정 존재
			subjectRepository.updateRecruitSameCourse(openVo);
		}
		return 0;
	}
	
	@Transactional
	@Override
	public int updateFileData(OpenVO openVo, UploadfileVO file) {
		logger.info("service/updatefiledate/:" + openVo.getFileId() + file.getFileId());
		logger.info("service/update/subject:" +openVo);
		logger.info("service/update/subject:" +file);
		
		int check = subjectRepository.checkOpenCourse(openVo.getCourseId()); //과정 개설 여부 확인
		if(check > 0) { // 같은 과정 존재
			subjectRepository.updateRecruitSameCourse(openVo);
		}
		
		if(openVo.getFileId() == null || openVo.getFileId() == null || openVo.getFileId().equals("")) { //그전에 파일이 없다가 나중에 추가
			String maxFileId = subjectRepository.selectMaxFileId();
			String maxFileId1 = maxFileId.substring(0,4);
			String maxFileId2 = String.format("%04d", Integer.parseInt(maxFileId.substring(4))+1); //4자리수 맞추기
			logger.info("maxFileID: "+maxFileId1+maxFileId2);
			
			openVo.setFileId(maxFileId1+maxFileId2);
			file.setFileId(maxFileId1+maxFileId2);
			
			if(file != null && file.getFileName() != null && !file.getFileName().equals("")) {//첨부파일있을때 
				subjectRepository.insertFileData(file);	
				logger.info("insert filedata:"+file);
			}
			logger.info("update subject:"+openVo);
			subjectRepository.updateSubject(openVo);//fk때문에 나중에 입력되어야 함
		}else { //파일 있다가 수정
			if(file != null && file.getFileName() != null && !file.getFileName().equals("")) {
				file.setFileId(openVo.getFileId());
				subjectRepository.updateFileData(file);
			}
			subjectRepository.updateSubject(openVo);
		}
		
		return 0;
	}
	
	@Transactional
	@Override
	public Map<String, Object> infoSubjectCourse(String courseId, String subjectId) {
		Map<String, Object> map = new HashMap<String, Object>();
		int check = subjectRepository.checkOpenCourse(courseId); //과정 개설 여부 확인
		logger.info("service/infoSubjectCourse/check : " + check);
		
		SubjectVO subjectInfo = subjectRepository.infoSubject(subjectId); //강좌에 대한 정보 가져오기
		subjectInfo.setLevelCdTitle(homeRepository.getComnCdTitle(subjectInfo.getLevelCd())); //level에대한 코드 코드명으로 변경
		if(!"".equals(courseId) && (check != 0)) { // 개설되어있는 경우
			logger.info("개설되어있는경우");
			map.put("courseInfo", subjectRepository.infoOpenCourse(courseId)); //신청일자 연동위해 데이터 가져오기
			map.put("subjectInfo", subjectInfo); //강좌에 대한 정보 가져오기
			map.put("checkList", subjectRepository.selectSubjectByCourseId(courseId)); //과정안에 포함되어있는 강좌이름 가져오기
		}else { //과정이 없거나, 최초개설인 경우
			logger.info("coursId X && courseId O 최초개설");
			map.put("subjectInfo", subjectInfo); // 강좌에 대한 정보만 가져옴
		}
		
		logger.info("service/infoSubjectCourse/list: " + map);
		return map;
	}
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
	public List<OpenVO> selectSubjectByCourseId(String courseId) {
		return subjectRepository.selectSubjectByCourseId(courseId);
	}

	@Override
	public List<OpenVO> selectOpenSubjectByCourseIdAndYear(String courseId, String year) {
		return subjectRepository.selectOpenSubjectByCourseIdAndYear(courseId, year);
	}

	@Override
	public List<OpenVO> selectOpenSubjectByStudentId(String studentId) {
		return subjectRepository.selectOpenSubjectByStudentId(studentId);
	}
	
}
