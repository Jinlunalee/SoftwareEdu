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
		
		List<StudentVO> dataList = dataService.getDataList(startDay, endDay);
		
		String result = "";  // for문 밖에서 결과값을 받을 result를 선언 
		for (StudentVO vo : dataList) {	
			String agentId = vo.getAgentId();
			String stdSbj = vo.getStdSbj();
			String name = vo.getName();
			String completeHours = vo.getCompleteHours();
			String sendDt = vo.getSendDt();
		
			// 밑의 문자열에 "\n" 넣어도 엔터처리 안 됨
			// +=로 문자열을 이어붙이기
        result += "<student>";
        result += "<agent_id>" + "KOSA01" + "</agent_id>";
        result += "<std_sbj>"+ stdSbj +"</std_sbj>";
        result += "<name>" + name + "</name>";
        result +=  "<complete_hours>" + completeHours + "</complete_hours>";
        result +=  "<send_dt>" + sendDt + "<send_dt>";
        result +=  "</student>"; 
//        넣어야 할 정보 : 수강생 아이디에 교육연도, 강좌아이디, 강좌시퀀스, 수강아이디, 연수생아이디 추가하기
//        교육비 지원여부는 어차피 지원되는 것만 조회되는 거니까 넣지 말기
		}
		
	return result;
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
