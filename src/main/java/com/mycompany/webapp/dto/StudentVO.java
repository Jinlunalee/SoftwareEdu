package com.mycompany.webapp.dto;

import com.google.gson.annotations.Expose;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StudentVO {
	
	
	
	private String studentId;  // 수강생 관리 아이디
	
	private String userId;  // 수강생 아이디
	
	@Expose
	private String name;		// 수강생 이름
	
	private String password;	// 수강생 비밀번호
	
	private String birth;		// 수강생 생년월일
	
	private String genderCd;	// 수강생 성별 코드* 얘 수정
	
	private String email;		// 수강생 메일
	
	private String phone;		// 수강생 전화번호
	
	private String addDoCd;		// 수강생 주소 도 코드  *얘 수정
	
	private String addEtc;		// 수강생 주소 기타  * 얘 수정

	private String positionCd;	// 수강생 지위
	//	private String positionCd;		

	private int cntStd;		//	전체수강생 수 
	
	private String supportYn;  // 교육비 지원 여부
	
	private String comnCdTitle; // 공통코드명  
	
	@Expose
	private String stateCd;	// 개설강좌 상태코드
	
	@Expose
	private String sendDt;	// 전송시간
	
	@Expose
	private String agentId;	// 기관 아이디
	
	@Expose
	private String stdSbj;	//	수강생, 강좌 정보
	
	private String rate;	// 진행율
	
	@Expose
	private String completeHours;	// 수강 완료 시수
	
	private String type; // 검색 타입
	
	private String keyword; // 검색 내용
	
	private String addDoTitle;	//	수강생 주소 도
	
	private String genderTitle;		// 수강생 성별
	
	private String positionTitle;	// 수강생 지위(ex.직장인, 학생)
	
	private String student; // 수강생 명 아이디 검색
	
	@Expose	
	private String startDay; // 강좌 시작일
	
}
