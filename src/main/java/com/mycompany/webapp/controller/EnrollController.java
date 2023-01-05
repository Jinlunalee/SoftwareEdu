package com.mycompany.webapp.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	@RequestMapping(value="/cancel/{studentId}/{subjectId}/{subjectSeq}", method=RequestMethod.POST)
	public String clickCancel(EnrollVO enroll, @PathVariable String studentId, @PathVariable String subjectId, @PathVariable String subjectSeq) {
		enrollService.clickCancel(enroll, studentId, subjectId, subjectSeq);
		return "redirect:/enroll/list";
	}
	
	// 논리 삭제
	@RequestMapping(value="/del/{studentId}/{subjectId}/{subjectSeq}")
	public String clickDelete(@PathVariable String studentId, @PathVariable String subjectId, @PathVariable String subjectSeq) {
		System.out.println("컨트롤 체크");
		enrollService.clickDelete(studentId, subjectId, subjectSeq);
		System.out.println("컨트롤러 체크");
		return "redirect:/enroll/list";
	}
	
	@ResponseBody
	@RequestMapping(value="/ratio/{studentId}/{subjectId}/{subjectSeq}")
	public String getRatio(@PathVariable String studentId, @PathVariable String subjectId, @PathVariable String subjectSeq) {
		System.out.println("값" + enrollService.getRatio(studentId, subjectId, subjectSeq));
		return enrollService.getRatio(studentId, subjectId, subjectSeq);
	}
	
	@RequestMapping(value="/addhours/{studentId}/{subjectId}/{subjectSeq}", method=RequestMethod.POST)
	public String addHours(EnrollVO enroll, @PathVariable String studentId, @PathVariable String subjectId, @PathVariable String subjectSeq) {
		enrollService.addHours(enroll, studentId, subjectId, subjectSeq);
		return "redirect:/enroll/list";
	}
	
	
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
	
	@RequestMapping(value="/approval/{studentId}/{subjectId}/{subjectSeq}")
	public String approval(@PathVariable String studentId, @PathVariable String subjectId, @PathVariable String subjectSeq) {
		enrollService.approval(studentId, subjectId, subjectSeq);
		return "redirect:/enroll/list";
	}
	
	
	//상세조회
	@RequestMapping(value="/details/{enrollId}", method=RequestMethod.GET)
	public String getEnrollDetails(@PathVariable String enrollId, Model model) {
		model.addAttribute("menu", "enroll");
		model.addAttribute("menuKOR", "수강 관리");
		return "enroll/details";
	}

	//검색
	@RequestMapping(value="/search", method=RequestMethod.GET)
	public String searchEnroll(@RequestParam Date enrollDate, @RequestParam String studentName, @RequestParam String courseName, Model model) {
		model.addAttribute("menu", "enroll");
		model.addAttribute("menuKOR", "수강 관리");
		return "enroll/search";
	}
	
	//엑셀파일 다운로드
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
	
	//수정
	@RequestMapping(value="/update/{enrollId}", method=RequestMethod.GET)
	public String updateEnroll(@PathVariable String enrollId, Model model) {
		model.addAttribute("menu", "enroll");
		model.addAttribute("menuKOR", "수강 관리");
		return "enroll/update";
	}

	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String updateEnroll(EnrollVO enrollVo) {
		return "redirect:/enroll/details"+enrollVo.getEnrollId();
	}

	//삭제
	@RequestMapping(value="/delete/{enrollId}", method=RequestMethod.POST)
	public String deleteEnroll(@PathVariable String studentId ,EnrollVO enrollVo) {
		return "redirect:/enroll/list";
	}

	//입력
	@RequestMapping(value="/insert", method=RequestMethod.GET)
	public String insertEnroll(Model model) {
		model.addAttribute("menu", "enroll");
		model.addAttribute("menuKOR", "수강 관리");
		return "enroll/insert";
	}

	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insertEnroll(EnrollVO enrollVo) {
		return "redirect:/enroll/details"+enrollVo.getEnrollId();
	}
}
