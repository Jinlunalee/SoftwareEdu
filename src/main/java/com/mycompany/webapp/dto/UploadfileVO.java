package com.mycompany.webapp.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UploadfileVO {
	private String fileId;
	private String fileName;
	private long fileSize;
	private String fileContentType;
	private byte[] fileData;
}
