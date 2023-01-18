package com.mycompany.webapp.dto;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import oracle.sql.DATE;

@Getter
@Setter
@ToString
public class SubjectVO {
	
	private String subjectId; //강좌아이디
	private String subjectTitle; //강좌명
	private int subjectSeq;
	private String supportYn; //지원여부
	private String catSubject;
	private String catSubjectTitle;
	private String catSubjectCd;//강좌 분류 코드
	private String catSubjectCdTitle;//강좌 분류 코드명
	private int days; //일수
	private int hours; //시수
	private String level;
	private String levelTitle;
	private String levelCd; //레벨 코드
	private String levelCdTitle; // 레벨 코드명
	private String levelEtc; // 기타
	private int cost; //수강비
	private int regYear;//등록년도
	
//	->CourseVo
	private String courseId; //과정 아이디
	private String courseTitle; // 과정명
	private String catCourse; // 과s정 분류 코드
	private String catCourseTitle; // 과정 분류 코드명
	
//	->OpenVo
	private String content; //개설 강좌 내용
	private String startTime; //개설 강좌 시작 시간
	private String endTime; //개설 강좌 종료 시간
	private String startDay; //개설 강좌 시작 일자
	private String endDay; //개설 강좌 종료 일자
	private String recruitStartDay; //모집 시작 일자
	private String recruitEndDay; //모집 마감 일자
	private int recruitPeople; // 모집인원
	
//	->OpenVO openStateCd/openStateCdTitle
	private String state; //강좌 상태 코드
	private String comnCdTitle; // 강좌 상태 코드명
	
//	->OpenVO openDt
	private String regDt;// 강좌 등록 일자
	
//	->OpenVo
	private MultipartFile file; //첨부파일 
	private String fileId;
	private String fileName;
	private long fileSize;
	private String fileContentType;
	
	private String sbjIdSeq;	// subjectId와 subjectSeq를 합쳐놓은 값
	private int cntStd;   // 학생 수
	private String sendDt;	// 전송시간
	
	
	}
