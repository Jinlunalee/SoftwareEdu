package com.mycompany.webapp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
		
		List<StudentVO> dataList = dataService.getDataList();
		
		model.addAttribute("dataList", dataList);
		model.addAttribute("dataListSize", dataList.size());
		
		return "data/download";
	}
	
	
	
	@RequestMapping(value="/getjson")
	public @ResponseBody List<StudentVO> getjson(){
	/*	@RequestMapping(value="/getjson", method=RequestMethod.GET, produces = "application/text; charset=UTF-8")
	 * public String getjson(Model model) {
			
		// 1. 조회
		List<StudentVO> dataList = studentService.getDataList();
		
		// 2. JSON배열 선언
		JSONArray jsonDataList = new JSONArray();
		
		// 3. 조회 결과의 사이즈만큼 루프, 각 데이터는 vo라는 이름으로 사용
		for (StudentVO vo : dataList) {
			
			// 3.1. 각 vo에서 데이터 추출
			String agentId = "KOSA01";
			String stdSbj = vo.getStdSbj();

			String name = vo.getName();
			String rate = vo.getRate();
			String stateCd = vo.getStateCd();
			String sendDt = vo.getSendDt();

			
			
			// 3.2. HashMap으로 변환 (Key<String>, Value<String>)
			HashMap<String, String> map = new HashMap();
			map.put("훈련기관아이디", agentId);
			map.put("수강생,강좌정보", stdSbj);
			map.put("수강생이름", name);
			map.put("이수율", rate);
			map.put("진행상태", stateCd);
			map.put("전송시간", sendDt);
			
			
			// 여기에 추가해야 할 것
			//수강생 아이디에 교육연도, 강좌아이디, 강좌시퀀스, 수강아이디, 연수생아이디 추가하기
			// 강좌비 지원여부는 제외하기 그냥 어차피 지금도 매퍼에서 그 조건으로 조회해서 가지고 오는 거라서
			
			
			// 3.3. 변환된 HashMap을 JSON배열에 추가
			jsonDataList.put(map);
			
			// 3.1 ~ 3.3이 반복.
		}
		// jsonDataList가 완성. 문자열로 바꿔서 리턴.
		String result = jsonDataList.toString();    */
		
		return dataService.getDataList();
	}	
	
	
	
	
	@RequestMapping(value="/getxml", method=RequestMethod.GET, produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String getxml(Model model) {
		List<StudentVO> dataList = dataService.getDataList();
		
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
	
	@RequestMapping(value="/getjsonSbj")
	public @ResponseBody List<SubjectVO> getjsonSbj() {
		return dataService.getSbjDataList();
	}
	
	
	
	@RequestMapping(value="/getxmlSbj")
	public @ResponseBody List<SubjectVO> getxmlSbj() {
		return dataService.getSbjDataList();
	}
}
