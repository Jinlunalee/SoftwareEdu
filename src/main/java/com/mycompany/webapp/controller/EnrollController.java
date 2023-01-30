package com.mycompany.webapp.controller;

import java.io.IOException;
import java.util.List;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.service.IEnrollService;
import com.mycompany.webapp.service.IHomeService;
import com.mycompany.webapp.service.IPagerService;

@Controller
@RequestMapping("/enroll")
public class EnrollController {
	static final Logger logger = LoggerFactory.getLogger(EnrollController.class);

	@Autowired
	IEnrollService enrollService;

	@Autowired
	IPagerService pagerService;

	/**
	 * @description	수강 목록
	 * @date	2023. 1. 17.
	 * @param pageNo
	 * @param rowsPerPage
	 * @param model
	 * @return
	 */
	@GetMapping("/boardlist")
	public String enrollList(@RequestParam(defaultValue="1") int pageNo, @RequestParam(defaultValue="10") int rowsPerPage, Model model) {
		model.addAttribute("menu", "enroll");
		model.addAttribute("menuKOR", "수강 관리");

		// 페이징 대상이 되는 전체 행수
		int totalRows = pagerService.getCountEnrollRow();
		int rowsPerPages = rowsPerPage;

		// 페이저 정보가 담긴 Pager 객체 생성
		Pager pager = new Pager(rowsPerPage, 5, totalRows, pageNo);  // (int rowsPerPage, int pagesPerGroup, int totalRows, int pageNo)

		// 해당 페이지의 행을 가져오기
		List<EnrollVO> boardList = pagerService.selectEnrollListByPage(pager);

		//JSP에서 사용할 데이터를 저장
		model.addAttribute("rowsPerPages", rowsPerPages);
		model.addAttribute("pager", pager);
		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListSize", boardList.size()); // 페이지 상단 좌측 "전체 목록" 수
		logger.info("EnrollBoardList: " + boardList);

		// cancel list
		List<CommonCodeVO> cancelList = enrollService.getCancelList();
		model.addAttribute("cancelList", cancelList);

		return "enroll/list";
	}

	/**
	 * @description	수강 검색
	 * @date	2023. 1. 17.
	 * @param enroll
	 * @param pageNo
	 * @param rowsPerPage
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/searchlist", method=RequestMethod.GET)
	public String getSearchList(EnrollVO enroll, @RequestParam(defaultValue="1") int pageNo, @RequestParam(defaultValue="10") int rowsPerPage, Model model) {
		model.addAttribute("menu", "enroll");
		model.addAttribute("menuKOR", "수강 관리");

		List<CommonCodeVO> cancelList = enrollService.getCancelList();
		model.addAttribute("cancelList", cancelList);

		String applyStartDay = enroll.getApplyStartDay();
		String applyEndDay = enroll.getApplyEndDay();

		enroll.setApplyStartDay(enroll.getApplyStartDay().replaceAll("-", ""));
		enroll.setApplyEndDay(enroll.getApplyEndDay().replaceAll("-", ""));

		int totalRows = pagerService.getCountSearchRow(enroll);
		int rowsPerPages = rowsPerPage;

		Pager pager = new Pager(rowsPerPage, 5, totalRows, pageNo);

		enroll.setApplyStartDay(applyStartDay);
		enroll.setApplyEndDay(applyEndDay);

		List<EnrollVO> searchList = pagerService.selectSearchListByPage(enroll, pager);
		logger.info("EnrollSearchList : " + searchList);
		model.addAttribute("rowsPerPages", rowsPerPages);
		model.addAttribute("enroll", enroll);
		model.addAttribute("pager", pager);
		model.addAttribute("boardList", searchList);
		model.addAttribute("boardListSize", searchList.size());

		return "enroll/search";
	}
	
	/**
	 * @description	수강 상세
	 * @date	2023. 1. 17.
	 * @param enrollId
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/details/{enrollId}", method=RequestMethod.GET)
	public String getEnrollDetails(@PathVariable String enrollId, Model model) {
		model.addAttribute("menu", "enroll");
		model.addAttribute("menuKOR", "수강 관리");
		EnrollVO enrollVo = enrollService.getEnrollDetails(enrollId);
		model.addAttribute("enroll", enrollVo);
		return "enroll/details";
	}

	/**
	 * @description	수강 추가
	 * @date	2023. 1. 17.
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/insert", method=RequestMethod.GET)
	public String insertEnroll(Model model) {
		model.addAttribute("menu", "enroll");
		model.addAttribute("menuKOR", "수강 관리");
		return "enroll/insert";
	}

	/**
	 * @description	취소 버튼 누르면 수강 취소 상태로 됨
	 * @date	2023. 1. 17.
	 * @param enroll
	 * @param studentId
	 * @param subjectId
	 * @param subjectSeq
	 * @return
	 */
	@RequestMapping(value="/cancel/{studentId}/{subjectId}/{subjectSeq}", method=RequestMethod.POST)
	public String clickCancel(EnrollVO enroll, @PathVariable String studentId, @PathVariable String subjectId, @PathVariable int subjectSeq) {
		enrollService.clickCancel(enroll, studentId, subjectId, subjectSeq);
		return "redirect:/enroll/boardlist";
	}

	/**
	 * @description	논리 삭제
	 * @date	2023. 1. 17.
	 * @param studentId
	 * @param subjectId
	 * @param subjectSeq
	 * @return
	 */
	@RequestMapping(value="/del/{studentId}/{subjectId}/{subjectSeq}")
	public String clickDelete(@PathVariable String studentId, @PathVariable String subjectId, @PathVariable int subjectSeq) {
		enrollService.clickDelete(studentId, subjectId, subjectSeq);
		return "redirect:/enroll/boardlist";
	}

	/**
	 * @description	수강 완료 시간 입력
	 * @date	2023. 1. 17.
	 * @param enroll
	 * @return
	 */
	@RequestMapping(value="/addhours", method=RequestMethod.POST)
	public String addHours(EnrollVO enroll) {
		System.out.println(enroll);
		enrollService.addHours(enroll.getAddHours(), enroll.getEnrollId());
		return "redirect:/enroll/details/" + enroll.getEnrollId();
	}

	/**
	 * @description	수강 입력 수강생 목록 ajax
	 * @date	2023. 1. 17.
	 * @param type
	 * @param keyword
	 * @return
	 */
	@RequestMapping(value="/studentlist")
	public @ResponseBody List<StudentVO> getStudentList(@RequestParam("type") String type, @RequestParam("keyword") String keyword) {
		StudentVO studentVO = new StudentVO();
		studentVO.setType(type);
		studentVO.setKeyword(keyword);
		return enrollService.getStudentList(studentVO);
	}

	/**
	 * @description	수강 입력 강좌 과정 목록 ajax
	 * @date	2023. 1. 17.
	 * @param openState
	 * @param subCor
	 * @param kw
	 * @return
	 */
	@RequestMapping(value="/openlist")
	public @ResponseBody List<OpenVO> getOpenList(@RequestParam("openState") String openState, @RequestParam("subCor") String subCor, @RequestParam("kw") String kw) {
		OpenVO openVO = new OpenVO();
		openVO.setOpenStateCd(openState);
		openVO.setSubCor(subCor);
		openVO.setKw(kw);
		return enrollService.getOpenList(openVO);
	}

	/**
	 * @description	승인 버튼 누르면 수강 예정 상태로 됨
	 * @date	2023. 1. 17.
	 * @param studentId
	 * @param subjectId
	 * @param subjectSeq
	 * @return
	 */
	@RequestMapping(value="/approval/{studentId}/{subjectId}/{subjectSeq}")
	public String approval(@PathVariable String studentId, @PathVariable String subjectId, @PathVariable int subjectSeq) {
		enrollService.approval(studentId, subjectId, subjectSeq);
		return "redirect:/enroll/boardlist";
	}

	/**
	 * @description	수강 입력
	 * @date	2023. 1. 17.
	 * @param studentId
	 * @param subjectId
	 * @param subjectSeq
	 * @return
	 */
	@RequestMapping(value="/addenroll/{studentId}/{subjectId}/{subjectSeq}", method=RequestMethod.POST)
	public String addEnroll(@PathVariable String studentId, @PathVariable String subjectId, @PathVariable int subjectSeq) {
		System.out.println(studentId);
		logger.info("addEnroll: "+studentId+subjectId+subjectSeq);
		enrollService.addEnroll(studentId, subjectId, subjectSeq);
		return "redirect:/enroll/boardlist";
	}

	/**
	 * @description	수강 입력에서 과정 입력
	 * @date	2023. 1. 17.
	 * @param studentId
	 * @param courseId
	 * @return
	 */
	@RequestMapping(value="/addcourse/{studentId}/{courseId}/{courseOpenYear}", method=RequestMethod.POST)
	public String addCourse(@PathVariable String studentId, @PathVariable String courseId, @PathVariable String courseOpenYear) {
		System.out.println(courseId);
		enrollService.addCourse(studentId, courseId, courseOpenYear);
		return "redirect:/enroll/boardlist";
	}

	/**
	 * @description	수강 목록 엑셀 다운로드
	 * @date	2023. 1. 24.
	 * @param response
	 * @param pageNo
	 * @param rowsPerPage
	 * @throws IOException
	 */
	@RequestMapping(value="/enrollexcel", method=RequestMethod.GET)
	public void downloadEnroll(HttpServletResponse response, @RequestParam(defaultValue="1") int pageNo, @RequestParam(defaultValue="10") int rowsPerPage) throws IOException {
		Workbook workbook = new HSSFWorkbook();
		Sheet sheet = workbook.createSheet("수강 목록");
		int rowNo = 0;

		Row headerRow = sheet.createRow(rowNo++);
		headerRow.createCell(0).setCellValue("강좌 명");
		headerRow.createCell(1).setCellValue("과정 명");
		headerRow.createCell(2).setCellValue("수강생 명");
		headerRow.createCell(3).setCellValue("수강생 아이디");
		headerRow.createCell(4).setCellValue("신청일자");
		headerRow.createCell(5).setCellValue("현재 상태");
		headerRow.createCell(6).setCellValue("진도율");
		
		int totalRows = rowsPerPage;
		Pager pager = new Pager(rowsPerPage, 5, totalRows, pageNo);
		
		List<EnrollVO> list = pagerService.selectEnrollListByPage(pager);
			for (EnrollVO enroll : list) {
				Row row = sheet.createRow(rowNo++);
				row.createCell(0).setCellValue(enroll.getSubjectTitle());
				row.createCell(1).setCellValue(enroll.getCourseTitle());
				row.createCell(2).setCellValue(enroll.getName());
				row.createCell(3).setCellValue(enroll.getStudentId());
				row.createCell(4).setCellValue(enroll.getEnrollDt());
				row.createCell(5).setCellValue(enroll.getStateCdTitle());
				row.createCell(6).setCellValue(enroll.getRatio() + "%");
			}
		
		String fileName = "수강 목록.xls";
		String outputFileName = new String(fileName.getBytes("KSC5601"), "8859_1");
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;fileName=\"" + outputFileName + "\"");

		workbook.write(response.getOutputStream());
		workbook.close();
	}
	
	/**
	 * @description	수강 검색한 결과 목록 엑셀 다운로드
	 * @date	2023. 1. 24.
	 * @param enrollVo
	 * @param response
	 * @param pageNo
	 * @param rowsPerPage
	 * @throws IOException
	 */
	@RequestMapping(value="/enrollsearchexcel", method=RequestMethod.GET)
	public void downloadEnroll(EnrollVO enrollVo, HttpServletResponse response, @RequestParam(defaultValue="1") int pageNo, @RequestParam(defaultValue="10") int rowsPerPage) throws IOException {
		Workbook workbook = new HSSFWorkbook();
		Sheet sheet = workbook.createSheet("수강 목록");
		int rowNo = 0;

		Row headerRow = sheet.createRow(rowNo++);
		headerRow.createCell(0).setCellValue("강좌 명");
		headerRow.createCell(1).setCellValue("과정 명");
		headerRow.createCell(2).setCellValue("수강생 명");
		headerRow.createCell(3).setCellValue("수강생 아이디");
		headerRow.createCell(4).setCellValue("신청일자");
		headerRow.createCell(5).setCellValue("현재 상태");
		headerRow.createCell(6).setCellValue("진도율");
		
		int totalRows = rowsPerPage;
		Pager pager = new Pager(rowsPerPage, 5, totalRows, pageNo);
		
			List<EnrollVO> searchList = pagerService.selectSearchListByPage(enrollVo, pager);
			for (EnrollVO enroll : searchList) {
				Row row = sheet.createRow(rowNo++);
				row.createCell(0).setCellValue(enroll.getSubjectTitle());
				row.createCell(1).setCellValue(enroll.getCourseTitle());
				row.createCell(2).setCellValue(enroll.getName());
				row.createCell(3).setCellValue(enroll.getStudentId());
				row.createCell(4).setCellValue(enroll.getEnrollDt());
				row.createCell(5).setCellValue(enroll.getStateCdTitle());
				row.createCell(6).setCellValue(enroll.getRatio() + "%");
			}
		
		String fileName = "검색 수강 목록.xls";
		String outputFileName = new String(fileName.getBytes("KSC5601"), "8859_1");
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;fileName=\"" + outputFileName + "\"");

		workbook.write(response.getOutputStream());
		workbook.close();
	}
}
