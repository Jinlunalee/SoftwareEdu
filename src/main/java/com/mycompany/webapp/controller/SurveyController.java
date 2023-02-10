package com.mycompany.webapp.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.webapp.dto.AnswerVO;
import com.mycompany.webapp.dto.QuestionSetVO;
import com.mycompany.webapp.dto.QuestionVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.IEnrollService;
import com.mycompany.webapp.service.ISubjectService;
import com.mycompany.webapp.service.ISurveyService;

@Controller
@RequestMapping("/survey")
public class SurveyController {
	static final Logger logger = LoggerFactory.getLogger(SurveyController.class);
	
	@Autowired
	IEnrollService enrollService;
	
	@Autowired
	ISubjectService subjectService;
	
	@Autowired
	ISurveyService surveyService;
	
	//목록조회
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String getSurveyList(Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/list";
	}

	//상세조회
	@RequestMapping(value="/details/{surveyId}", method=RequestMethod.GET)
	public String getSurveyDetails(@PathVariable String subjectId, @PathVariable String subjectSeq, Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/details";
	}

	//수정
	@RequestMapping(value="/update/{surveyId}", method=RequestMethod.GET)
	public String updateSurvey(@PathVariable String subjectId, @PathVariable String subjectSeq, Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/update";
	}

	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String updateSurvey(QuestionVO questionVo) {
		return "redirect:/survey/details"+questionVo.getSubjectId();
	}

	//삭제
	@RequestMapping(value="/delete/{surveyId}", method=RequestMethod.POST)
	public String deleteSurvey(@PathVariable String subjectId ,QuestionVO questionVo) {
		return "redirect:/survey/list";
	}

	//입력
	@RequestMapping(value="/insert", method=RequestMethod.GET)
	public String insertSurvey(Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/insert";
	}

	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insertSurvey(QuestionVO questionVo) {
		return "redirect:/survey/details"+questionVo.getSubjectId();
	}
	
	//통계
	@RequestMapping(value="/summary", method=RequestMethod.GET)
	public String getSurveySummary(Model model, QuestionVO questionVo, AnswerVO answerVo) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		
		
		List<SubjectVO> subjectListFinished = surveyService.selectSubjectListByFinishedState();
		logger.info("details/subject: "+ subjectListFinished);
		model.addAttribute("subjectList", subjectListFinished);
		return "survey/summary";
	}
	
	/**
	 * @Description : 만족도 조사 통계 엑셀파일 다운로드
	 * @author KOSA
	 * @date 2023. 1. 17.
	 * @param response
	 * @param subjectId
	 * @param subjectSeq
	 * @param openDt
	 * @throws Exception
	 */
	@GetMapping("/downloadexcel")
	@ResponseBody
	public void downloadExcel(String subjectId, String subjectSeq, String openDt, HttpServletResponse response) throws Exception {
		logger.info("downloadExcel:"+subjectId+subjectSeq+openDt);
		int subjectSeqInt = Integer.parseInt(subjectSeq);
		String subjectTitle = surveyService.getSubjectTitle(subjectId);// 강좌명
				
		Workbook workbook = new HSSFWorkbook();//xls파일로 저장하기위해 생성
		Sheet sheet = workbook.createSheet(subjectTitle + " " + subjectSeqInt + "회차 만족도"); // 하나의 sheet 생성
//		Sheet sheet2 = workbook.createSheet("강좌 만족도");
		int rowNo = 0; // row number 카운팅
		
		//sheet1
		Row headerRow = sheet.createRow(rowNo++);
		headerRow.createCell(0).setCellValue("강좌아이디");
		headerRow.createCell(1).setCellValue("강좌명");
		headerRow.createCell(2).setCellValue("강좌회차");
		headerRow.createCell(3).setCellValue("문항번호");
		headerRow.createCell(4).setCellValue("문항내용");
		headerRow.createCell(5).setCellValue("매우만족");
		headerRow.createCell(6).setCellValue("만족");
		headerRow.createCell(7).setCellValue("보통");
		headerRow.createCell(8).setCellValue("불만족");
		headerRow.createCell(9).setCellValue("매우불만족");
		headerRow.createCell(10).setCellValue("만족도");
		
		List<QuestionSetVO> questionList = surveyService.selectSubjectQuestionSet(subjectId, subjectSeqInt);
		Map<String, Integer> map = new HashMap<>();
		int i=0;
		for(QuestionSetVO question : questionList) {
			i++;
			map = surveyService.pivotAnswerValue(subjectId, subjectSeqInt, i);
			Row row = sheet.createRow(rowNo++);
			row.createCell(0).setCellValue(subjectId);
			row.createCell(1).setCellValue(subjectTitle);
			row.createCell(2).setCellValue(subjectSeqInt);
			row.createCell(3).setCellValue(question.getQuestionNum());
			row.createCell(4).setCellValue(question.getQuestionContent());
			int value5 = Integer.parseInt(String.valueOf(map.get("5")));
			int value4 = Integer.parseInt(String.valueOf(map.get("4")));
			int value3 = Integer.parseInt(String.valueOf(map.get("3")));
			int value2 = Integer.parseInt(String.valueOf(map.get("2")));
			int value1 = Integer.parseInt(String.valueOf(map.get("1")));
			int satisfiedPercent = ((value5*100) + (value4*75) + (value3*50) + (value2*25) + (value1*0)) / (value5+value4+value3+value2+value1);
			String satisfiedPercentStr = String.valueOf(satisfiedPercent) + "%";
			row.createCell(5).setCellValue(value5);
			row.createCell(6).setCellValue(value4);
			row.createCell(7).setCellValue(value3);
			row.createCell(8).setCellValue(value2);
			row.createCell(9).setCellValue(value1);
			row.createCell(10).setCellValue(satisfiedPercentStr);
		}
		
		

//		rowNo = 0;
		
		//sheet2
		//상단 헤더row
//		Row headerRow2 = sheet2.createRow(rowNo++);
//		headerRow2.createCell(0).setCellValue("강좌아이디");
//		headerRow2.createCell(1).setCellValue("강좌시퀀스");
//		headerRow2.createCell(2).setCellValue("만족도 조사 문항 번호");
//		headerRow2.createCell(3).setCellValue("만족도 조사 답변 점수");
//		
//		List<AnswerVO> answerList = surveyService.selectAnswerList(subjectId, subjectSeqInt);
//		for(AnswerVO answer : answerList) {
//			Row row2 = sheet2.createRow(rowNo++);
//			row2.createCell(0).setCellValue(answer.getSubjectId());
//			row2.createCell(1).setCellValue(answer.getSubjectSeq());
//			row2.createCell(2).setCellValue(answer.getQuestionNum());
//			row2.createCell(3).setCellValue(answer.getAnswerValue());
//		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
		Calendar calendar = Calendar.getInstance();
		String todayTitle = sdf.format(calendar.getTime());
		
		String fileName = todayTitle + "_" + subjectTitle + " " + subjectSeqInt + "회차 만족도 통계자료.xls";
		String outputFileName = new String(fileName.getBytes("KSC5601"), "8859_1");
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;fileName=\"" + outputFileName + "\"");
		
		workbook.write(response.getOutputStream());
		workbook.close();
	}
}
