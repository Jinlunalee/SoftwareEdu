package com.mycompany.webapp.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UploadfileVO {
	private String fileId;
	private String subjectId;
	private String fileName;
	private int fileSize;
	private String fileContentType;
	private byte[] fileData;
}
