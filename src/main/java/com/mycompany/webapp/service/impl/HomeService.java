package com.mycompany.webapp.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import com.mycompany.webapp.dao.IHomeRepository;
import com.mycompany.webapp.service.IHomeService;

public class HomeService implements IHomeService {

	@Autowired
	IHomeRepository homeRepository;
	
	@Override
	public String getComnCdTitle(String comnCd) {
		return homeRepository.getComnCdTitle(comnCd);
	}

}
