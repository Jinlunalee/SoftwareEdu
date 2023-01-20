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
    * @description 연계 자료 조회 페이지
    * @date 2023. 1. 12.
    * @param model
    * @return
    * ------------------------------
    */
   @RequestMapping(value="/download", method=RequestMethod.GET)
   public String getDataList(Model model) {
      model.addAttribute("menu", "data");
      model.addAttribute("menuKOR", "연계 자료 관리");      
      
//      List<StudentVO> dataList = dataService.getDataList();
//      model.addAttribute("dataList", dataList);
//      model.addAttribute("dataListSize", dataList.size());
      
      return "data/download";
   }
   
   

   /**
    * @description 학생 정보 json 형식 
	* @date		2023. 1. 20.
	* @param startDay
	* @param endDay
	* @return
 */
@RequestMapping(value="/getjson", method=RequestMethod.GET, produces = "application/json; charset=UTF-8")
   public @ResponseBody String getjson(@RequestParam("sDay") String startDay,@RequestParam("eDay") String endDay){
      
      // 파라메터 잘 받아왔는지 테스트
      // System.out.println("eslee" + startDay + ", " + endDay);
      
      String resultJsonStr = dataService.getDataGson(startDay, endDay);
      
      return resultJsonStr;
   }   
   
   

   /**
    * @description 학생 정보 xml형식
    * @date		2023. 1. 20.
	* @param model
	* @param startDay
	* @param endDay
	* @return
 */
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
   
   
   
   /**
    * @description 강좌 정보 json
	* @date		2023. 1. 20.
	* @param startDay
	* @param endDay
	* @return
 */
@RequestMapping(value="/getjsonSbj", method=RequestMethod.GET, produces = "application/json; charset=UTF-8" )
   public @ResponseBody String getjsonSbj(@RequestParam("sDay") String startDay, @RequestParam("eDay") String endDay){
      
      String resultJsonSbjStr = dataService.getSbjDataGson(startDay, endDay);
      
      return resultJsonSbjStr;
   }   
   
  

   /**
    * @description 강좌 정보 xml
	* @date		2023. 1. 20.
	* @param subjectVo
	* @param startDay
	* @param endDay
	* @return
 */
@RequestMapping(value="/getxmlSbj", method=RequestMethod.GET, produces = "application/text; charset=UTF-8")
   public @ResponseBody String getxmlSbj(SubjectVO subjectVo, @RequestParam("sDay") String startDay, @RequestParam("eDay") String endDay) {
      

      return dataService.getSbjDataList(startDay, endDay);
   }
}