package com.mycompany.webapp.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.service.IEnrollService;

@Controller
@RequestMapping("/enroll")
public class EnrollController {
	
	@Autowired
	IEnrollService enrollService;
	
	//목록조회
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String getEnrollList(Model model) {
		model.addAttribute("menu", "enroll");
		model.addAttribute("menuKOR", "수강 관리");
		
		List<EnrollVO> list = enrollService.getEnrollList();
		model.addAttribute("list", list);
		
		List<CommonCodeVO> cancelList = enrollService.getCancelList();
		model.addAttribute("cancelList", cancelList);
		
		return "enroll/list";
	}
	
	// 입력
	@RequestMapping(value="/insert", method=RequestMethod.GET)
	public String insertEnroll(Model model) {
		model.addAttribute("menu", "enroll");
		model.addAttribute("menuKOR", "수강 관리");
		return "enroll/insert";
	}
	
	// 취소 누르면 수강 취소 상태
	@RequestMapping(value="/cancel/{studentId}/{subjectId}/{subjectSeq}", method=RequestMethod.POST)
	public String clickCancel(EnrollVO enroll, @PathVariable String studentId, @PathVariable String subjectId, @PathVariable String subjectSeq) {
		enrollService.clickCancel(enroll, studentId, subjectId, subjectSeq);
		return "redirect:/enroll/list";
	}
	
	// 논리 삭제
	@RequestMapping(value="/del/{studentId}/{subjectId}/{subjectSeq}")
	public String clickDelete(@PathVariable String studentId, @PathVariable String subjectId, @PathVariable String subjectSeq) {
		enrollService.clickDelete(studentId, subjectId, subjectSeq);
		return "redirect:/enroll/list";
	}
	
	// 진행률
	@ResponseBody
	@RequestMapping(value="/ratio/{studentId}/{subjectId}/{subjectSeq}")
	public String getRatio(@PathVariable String studentId, @PathVariable String subjectId, @PathVariable String subjectSeq) {
		return enrollService.getRatio(studentId, subjectId, subjectSeq);
	}
	
	// 수강 완료한 시간 입력
	@RequestMapping(value="/addhours/{studentId}/{subjectId}/{subjectSeq}", method=RequestMethod.POST)
	public String addHours(EnrollVO enroll, @PathVariable String studentId, @PathVariable String subjectId, @PathVariable String subjectSeq) {
		enrollService.addHours(enroll, studentId, subjectId, subjectSeq);
		return "redirect:/enroll/list";
	}
	
	// 완료 시간 ajax
//	@ResponseBody
//	@RequestMapping(value="/gethours/{enrollId}")
//	public int getHours(@PathVariable String enrollId) {
//		return enrollService.getHours(enrollId);
//	}
	
	// 수강 추가 수강생 ajax
	@RequestMapping(value="/studentlist")
	public @ResponseBody List<StudentVO> getStudentList(@RequestParam("type") String type, @RequestParam("keyword") String keyword) {
		StudentVO studentVO = new StudentVO();
		studentVO.setType(type);
		studentVO.setKeyword(keyword);
		return enrollService.getStudentList(studentVO);
	}
	
	// 수강 추가 강좌 과정 ajax
	@RequestMapping(value="/openlist")
	public @ResponseBody List<OpenVO> getOpenList(@RequestParam("subcor") String subCor, @RequestParam("kw") String kw) {
		OpenVO openVO = new OpenVO();
		openVO.setSubCor(subCor);
		openVO.setKw(kw);
		return enrollService.getOpenList(openVO);
	}
	
	// 승인하면 수강 예정 상태
	@RequestMapping(value="/approval/{studentId}/{subjectId}/{subjectSeq}")
	public String approval(@PathVariable String studentId, @PathVariable String subjectId, @PathVariable String subjectSeq) {
		enrollService.approval(studentId, subjectId, subjectSeq);
		return "redirect:/enroll/list";
	}
	
	// 수강 추가
	@RequestMapping(value="/addenroll/{studentId}/{subjectId}/{subjectSeq}", method=RequestMethod.POST)
	public String addEnroll(@PathVariable String studentId, @PathVariable String subjectId, @PathVariable int subjectSeq) {
		enrollService.addEnroll(studentId, subjectId, subjectSeq);
		return "redirect:/enroll/list";
	}
	
	// 과정 추가
	@RequestMapping(value="/addcourse/{studentId}", method=RequestMethod.POST)
	public String addCourse(@RequestBody Map<String, Object> addCourse, @PathVariable String studentId) {
		System.out.println(addCourse);
		enrollService.addCourse(addCourse, studentId);
		return "redirect:/enroll/list";
	}
	
	//엑셀 파일 다운로드
	@RequestMapping(value="/download", method=RequestMethod.GET)
	public void downloadEnroll(HttpServletResponse response) throws IOException {
		Workbook workbook = new HSSFWorkbook();
        Sheet sheet = workbook.createSheet("테스트");
        int rowNo = 0;
 
        Row headerRow = sheet.createRow(rowNo++);
        headerRow.createCell(0).setCellValue("수강 아이디");
        headerRow.createCell(1).setCellValue("강좌 아이디");
        headerRow.createCell(2).setCellValue("강좌 시퀀스");
        headerRow.createCell(3).setCellValue("수강생 아이디");
        headerRow.createCell(4).setCellValue("수강 완료 시간");
 
        List<EnrollVO> list = enrollService.getEnrollList();
        for (EnrollVO enroll : list) {
            Row row = sheet.createRow(rowNo++);
            row.createCell(0).setCellValue(enroll.getEnrollId());
            row.createCell(1).setCellValue(enroll.getSubjectId());
            row.createCell(2).setCellValue(enroll.getSubjectSeq());
            row.createCell(3).setCellValue(enroll.getStudentId());
            row.createCell(4).setCellValue(enroll.getCompleteHours());
        }
 
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename=test.xls");
 
        workbook.write(response.getOutputStream());
        workbook.close();
	}
	
}
