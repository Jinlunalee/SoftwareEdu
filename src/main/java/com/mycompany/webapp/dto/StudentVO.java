package com.mycompany.webapp.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StudentVO {
	private String studentId;  // 수강생 아이디
	private String name;		// 수강생 이름
	private String password;	// 수강생 비밀번호
	private String birth;		// 수강생 생년월일
	private String gender_cd;	// 수강생 성별 코드
	private String email;		// 수강생 메일
	private String phone;		// 수강생 전화번호
	private String add_do_cd;		// 수강생 주소 도 코드
	private String add_etc;		// 수강생 주소 기타
	private String position;		// 수강생 지위
	private int std_cnt;		//전체수강생 수
	
	private String supportYn;  // 교육비 지원 여부
	private String comnCdTitle; // 공통코드명  
	private String stateCd;
	// 위의 공통코드를 얘로 수정해야 함 
	
	
	private String type; // 검색 타입
	private String keyword; // 검색 내용
	
}
