package com.mycompany.webapp.dto;

import org.springframework.web.multipart.MultipartFile;

import com.google.gson.annotations.Expose;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OpenVO {
	//강좌 관련
	private String subjectId; //강좌아이디
	private int subjectSeq; //강좌시퀀스
	@Expose
	private String subjectTitle; //강좌명
	private String supportYn; //지원여부
	private String catSubjectCd;//강좌 분류 코드
	private String catSubjectCdTitle;//강좌 분류 코드명
	private int days; //일수
	@Expose
	private int hours; //시수
	private String levelCd; //레벨 코드
	private String levelCdTitle; // 레벨 코드명
	private String levelEtc; // 기타
	@Expose
	private int cost; //수강비
	private int regYear;//등록년도
	
	//과정 관련
	private String courseId; //과정아이디 
	private String courseTitle; //과정명
	public String catCourseCd;	// 과정 분류 코드
	public String catCourseCdTitle;	// 과정 분류 코드명
	
	//개설 관련
	@Expose
	private String startDay; //연수 시작 일자
	@Expose
	private String endDay; //연수 종료 일자
	private String startTime; //연수 시작 시간
	private String endTime; //연수 종료 시간
	private String recruitStartDay; //모집 시작 일자
	private String recruitEndDay; //모집 종료 일자
	private int recruitPeople; //모집 인원
	private String content;//개설 강좌 내용
	private String openStateCd;//개설 상태 코드
	private String openStateCdTitle; //개설 상태 코드명
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
	
	//연계자료 전송 관련
	@Expose
	private String sbjIdSeq;	// subjectId와 subjectSeq를 합쳐놓은 값
	@Expose
	private int cntStd;   // 학생 수
	@Expose
	private String sendDt;	// 전송시간
	
	// 개설강좌 검색팝업 관련
	private String cases; // 개설강좌의 쓰임 목적에 따라 리스트 조회 조건을 다르게 하기 위함
	private String openDtYear; // openDt를 년도로 조회하기 위함 

}
