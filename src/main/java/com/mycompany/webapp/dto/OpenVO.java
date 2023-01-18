package com.mycompany.webapp.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OpenVO {
	private String subjectId; //강좌아이디
	private int subjectSeq; //강좌시퀀스
	private String subjectTitle; //강좌명
	private String courseId; //과정아이디 
	private String courseTitle; //과정명
	private String startDay; //연수 시작 일자
	private String endDay; //연수 종료 일자
	private String startTime; //연수 시작 시간
	private String endTime; //연수 종료 시간
	private String recruitStartDay; //모집 시작 일자
	private String recruitEndDay; //모집 종료 일자
	private int recruitPeople; //모집 인원
	private String content;//개설 강좌 내용
	
	private String openState;
//	private String openStateCd;//개설 상태 코드
//	private String openStateCdTitle; //개설 상태 코드명
	
	private String courseOpenYear; //과정 개설 년도
	private String openDt; //개설 등록 일자
	
	//수강에서 강좌검색후 추가할 때 사용
	private String subCor;
	private String kw; //키워드
	
	//첨부파일 
	private MultipartFile file;
	private String fileId;
	private String fileName;
	private long fileSize;
	private String fileContentType;

}
