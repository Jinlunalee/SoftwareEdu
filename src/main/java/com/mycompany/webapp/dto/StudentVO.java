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
	
}
