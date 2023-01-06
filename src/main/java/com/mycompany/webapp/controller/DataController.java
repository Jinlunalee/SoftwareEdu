package com.mycompany.webapp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.webapp.dto.StudentVO;

import com.mycompany.webapp.service.IStudentService;

@Controller
@RequestMapping("/data")
public class DataController {

	
	
	@Autowired
	IStudentService studentService;
	
	//통계
	@RequestMapping(value="/download", method=RequestMethod.GET)
	public String getDataList(Model model) {
		model.addAttribute("menu", "data");
		model.addAttribute("menuKOR", "연계 자료 관리");		
		
		List<StudentVO> dataList = studentService.getDataList();
		
		model.addAttribute("dataList", dataList);
		model.addAttribute("dataListSize", dataList.size());
		
		return "data/download";
	}
	
	
	@RequestMapping(value="/getjson", method=RequestMethod.GET, produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String getjson(Model model) {
		
		// 1. 조회
		List<StudentVO> dataList = studentService.getDataList();
		
		// 2. JSON배열 선언
		JSONArray jsonDataList = new JSONArray();
		
		// 3. 조회 결과의 사이즈만큼 루프, 각 데이터는 vo라는 이름으로 사용
		for (StudentVO vo : dataList) {
			
			// 3.1. 각 vo에서 데이터 추출
			String studentId = vo.getStudentId();
			String name = vo.getName();
			String supportYn = vo.getSupportYn();
			String comnCdTitle = vo.getComnCdTitle();
			
			// 3.2. HashMap으로 변환 (Key<String>, Value<String>)
			HashMap<String, String> map = new HashMap();
			map.put("수강생아이디", studentId);
			map.put("수강생이름", name);
			map.put("강좌비지원여부", supportYn);
			map.put("진행상황", comnCdTitle);
			 
			// 3.3. 변환된 HashMap을 JSON배열에 추가
			jsonDataList.put(map);
			
			// 3.1 ~ 3.3이 반복.
		}
		// jsonDataList가 완성. 문자열로 바꿔서 리턴.
		String result = jsonDataList.toString();
		
		return result;
	}	
	
	
	
	
	@RequestMapping(value="/getxml", method=RequestMethod.GET, produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String getxml(Model model) {
		List<StudentVO> dataList = studentService.getDataList();
		
		String result = "";  // for문 밖에서 결과값을 받을 result를 선언 
		for (StudentVO vo : dataList) {	
			String studentId = vo.getStudentId();
			String name = vo.getName();
			String supportYn = vo.getSupportYn();
			String comnCdTitle = vo.getComnCdTitle();
		
			// 밑의 문자열에 "\n" 넣어도 엔터처리 안 됨
			// +=로 문자열을 이어붙이기
        result += "<student>";
        result += "<studentId>"+ studentId +"</studentId>";
        result += "<name>" + name + "</name>";
        result +=  "<supportYn>" + supportYn +"</suppotyYn>";
        result +=  "<comnCdTitle>" + comnCdTitle +"</comnCdTitle>";
        result +=  "</student>";

		}
		
	return result;
	}
}
