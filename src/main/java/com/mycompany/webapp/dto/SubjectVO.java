package com.mycompany.webapp.dto;

import com.google.gson.annotations.Expose;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SubjectVO {
	private String subjectId; //강좌아이디
	@Expose
	private String subjectTitle; //강좌명
	private int subjectSeq; //강좌시퀀스
	private String supportYn; //지원여부            
	private String catSubjectCd;//강좌 분류 코드
	private String catSubjectCdTitle;//강좌 분류 코드명
	private int days; //일수
	@Expose
	private int hours; //시수
	private String levelCd; //레벨 코드
	private String levelCdTitle; // 레벨 코드명
	private String levelEtc; // 기타
	private int cost; //수강비
	private int regYear;//등록년도
}
