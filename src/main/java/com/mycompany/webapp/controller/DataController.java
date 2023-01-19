package com.mycompany.webapp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.IDataService;

/**
 * @author KOSA
 *
 */
@Controller
@RequestMapping("/data")
public class DataController {
	
	@Autowired
	IDataService dataService;
	
	//통계
	/**

	 * 연계 자료 통계 조회
	 * @date 2023. 1. 12.
	 * @param model
	 * @return
	 * ------------------------------
	 * 2023. 1. 13. modify.......

	 */
	@RequestMapping(value="/download", method=RequestMethod.GET)
	public String getDataList(Model model) {
		model.addAttribute("menu", "data");
		model.addAttribute("menuKOR", "연계 자료 관리");		
		
//		List<StudentVO> dataList = dataService.getDataList();
//		model.addAttribute("dataList", dataList);
//		model.addAttribute("dataListSize", dataList.size());
		
		return "data/download";
	}
	

	

	
	
	@RequestMapping(value="/getjson", method=RequestMethod.GET, produces = "application/json; charset=UTF-8")
	public @ResponseBody String getjson(@RequestParam("sDay") String startDay,@RequestParam("eDay") String endDay){
		
		// 파라메터 잘 받아왔는지 테스트
		// System.out.println("eslee" + startDay + ", " + endDay);
		
		String resultJsonStr = dataService.getDataGson(startDay, endDay);
		
		return resultJsonStr;
	}	
	
	
	
	
	@RequestMapping(value="/getxml", method=RequestMethod.GET, produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String getxml(Model model, @RequestParam("sDay") String startDay,@RequestParam("eDay") String endDay) {
		
	return dataService.getDataList(startDay, endDay);
	}
/*	
	@RequestMapping(value="/getjsonSbj")
	public @ResponseBody List<SubjectVO> getjsonSbj() {
		return dataService.getSbjDataList();
	}
	*/
	
	
	
	@RequestMapping(value="/getjsonSbj", method=RequestMethod.GET, produces = "application/json; charset=UTF-8" )
	public @ResponseBody String getjsonSbj(@RequestParam("sDay") String startDay, @RequestParam("eDay") String endDay){
		
		String resultJsonSbjStr = dataService.getSbjDataGson(startDay, endDay);
		
		return resultJsonSbjStr;
	}	
	

	
	
// 수정중 2023.01.19  오후 2시 30분 
	@RequestMapping(value="/getxmlSbj", method=RequestMethod.GET, produces = "application/json; charset=UTF-8")
	public @ResponseBody List<SubjectVO> getxmlSbj(SubjectVO subjectVo, @RequestParam("sDay") String startDay, @RequestParam("eDay") String endDay) {
		List<SubjectVO> sbjDataList = dataService.getSbjDataList(startDay, endDay);
		
//		String resultXmlStr = "";
		System.out.println("controller : " + sbjDataList);
		
		return sbjDataList;
	}
}
