package com.mycompany.webapp.dto;

import com.google.gson.annotations.Expose;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StudentVO {
	
	
	
	private String studentId;  // 수강생 아이디
	
	@Expose
	private String name;		// 수강생 이름
	
	private String password;	// 수강생 비밀번호
	
	private String birth;		// 수강생 생년월일
	
	private String genderCd;	// 수강생 성별 코드* 얘 수정
	
	private String email;		// 수강생 메일
	
	private String phone;		// 수강생 전화번호
	
	private String addDoCd;		// 수강생 주소 도 코드  *얘 수정
	
	private String addEtc;		// 수강생 주소 기타  * 얘 수정

	private String position;
	//	private String positionCd;		// 수강생 지위

	private int cntStd;		//전체수강생 수 * 얘 수정
	
	private String supportYn;  // 교육비 지원 여부
	
	private String comnCdTitle; // 공통코드명  
	
	private String stateCd;
	
	// 위의 공통코드를 얘로 수정해야 함 
	//  카멜표기법, _표기법 섞여있으니까 하나로 통일하기
	@Expose
	private String sendDt;
	
	@Expose
	private String agentId;
	
	@Expose
	private String stdSbj;
	
	private String rate;
	
	@Expose
	private String completeHours;
	
	private String type; // 검색 타입
	
	private String keyword; // 검색 내용
	
}
