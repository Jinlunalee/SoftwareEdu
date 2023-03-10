package com.mycompany.webapp.controller;

import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mycompany.webapp.dto.CourseVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.QuestionSetVO;
import com.mycompany.webapp.dto.QuestionVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.dto.UploadfileVO;
import com.mycompany.webapp.service.IEnrollService;
import com.mycompany.webapp.service.IPagerService;
import com.mycompany.webapp.service.ISubjectService;
import com.mycompany.webapp.service.ISurveyService;

@Controller
@RequestMapping("/subject")
public class SubjectController {
	static final Logger logger = LoggerFactory.getLogger(SubjectController.class);

	@Autowired
	ISubjectService subjectService;

	@Autowired
	ISurveyService surveyService;

	@Autowired
	IEnrollService enrollService;

	@Autowired
	IPagerService pagerService;

	// 개설 강좌 상세조회 (open)
	@RequestMapping(value="/details/{subjectId}/{subjectSeq}", method=RequestMethod.GET)
	public String getSubjectDetails(@PathVariable String subjectId, @PathVariable int subjectSeq, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");

		// 만족도 조사 항목
		List<QuestionSetVO> questionSet = surveyService.selectSubjectQuestionSet(subjectId, subjectSeq);
		model.addAttribute("questionSet", questionSet);

		OpenVO openVo = subjectService.selectSubjectDetails(subjectId, subjectSeq);
		int totalPeople = enrollService.recruitTotalPeople(subjectId, subjectSeq, openVo.getOpenStateCd());//subject의 상태에 따라 카운드할 수강생 상태가 달라짐
		openVo.setTotalPeople(totalPeople);
		model.addAttribute("open", openVo);

		logger.info("details/subject: "+ openVo);
		logger.info("details/subject: "+ totalPeople);
		logger.info("details/subject: "+ questionSet);

		return "subject/details";
	}
	
	/**
	 * @Description : paging 개설 과정 검색 (open course)
	 * @author KOSA
	 * @date 2023. 2. 3.
	 * @param catCourseCd
	 * @param course
	 * @param keyword
	 * @param pageNo
	 * @param rowsPerPage
	 * @param model
	 * @return
	 */
	@GetMapping(value="/searchCourseBoardlist")
	public String searchCourse(@RequestParam(defaultValue="all") String catCourseCd, @RequestParam(defaultValue="crseTitle") String course, @RequestParam(defaultValue="") String keyword, 
			@RequestParam(defaultValue="1") int pageNo, @RequestParam(defaultValue="10") int rowsPerPage, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		model.addAttribute("check", "openCourse");
		
		// 페이징 대상이 되는 전체 검색 행수
		int totalRows = pagerService.getCountSearchOpenCourseRow(catCourseCd, course, keyword);
		
		// 페이저 정보가 담긴 Pager 객체 생성
		Pager pager = new Pager(rowsPerPage, 5, totalRows, pageNo);
		
		// 해당 페이지의 행을 가져오기
		List<OpenVO> boardList = pagerService.selectSearchOpenCourseListByPage(pager, catCourseCd, course, keyword);
		
		//JSP에서 사용할 데이터를 저장
		model.addAttribute("catId", catCourseCd);
		model.addAttribute("course", course);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pager", pager);
		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListSize", boardList.size()); // 페이지 상단 좌측 "전체 목록" 수
		model.addAttribute("rowsPerPage", rowsPerPage);
		logger.info("searchOpenCourseBoardList: " + boardList);
		
		return "subject/courselist";
	}
	
	/**
	 * @Description : paging 개설 강좌 검색 (open subject)
	 * @author KOSA
	 * @date 2023. 2. 3.
	 * @param catSubjectCd
	 * @param subject
	 * @param keyword
	 * @param pageNo
	 * @param rowsPerPage
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/searchSubjectBoardlist", method=RequestMethod.GET)
	public String searchSubject(@RequestParam(defaultValue="all") String catSubjectCd, @RequestParam(defaultValue="subjTitle") String subject, @RequestParam(defaultValue="") String keyword, 
			@RequestParam(defaultValue="1") int pageNo, @RequestParam(defaultValue="10") int rowsPerPage, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		model.addAttribute("check", "openSubject");
		
		// 페이징 대상이 되는 전체 검색 행수
		int totalRows = pagerService.getCountSearchOpenSubjectRow(catSubjectCd, subject, keyword);
		
		// 페이저 정보가 담긴 Pager 객체 생성
		Pager pager = new Pager(rowsPerPage, 5, totalRows, pageNo);
		
		// 해당 페이지의 행을 가져오기
		List<OpenVO> boardList = pagerService.selectSearchOpenSubjectListByPage(pager, catSubjectCd, subject, keyword);
		
		//JSP에서 사용할 데이터를 저장
		model.addAttribute("catId", catSubjectCd);
		model.addAttribute("subject", subject);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pager", pager);
		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListSize", boardList.size()); // 페이지 상단 좌측 "전체 목록" 수
		model.addAttribute("rowsPerPage", rowsPerPage);
		logger.info("searchOpenSubjectBoardList: " + boardList);
		
		return "subject/subjectlist";
	}

	// 개설 강좌 수정 (open)
	@RequestMapping(value="/update/{subjectId}/{subjectSeq}", method=RequestMethod.GET)
	public String updateSubject(@PathVariable String subjectId, @PathVariable int subjectSeq, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");

		OpenVO openVo = subjectService.selectSubjectDetails(subjectId, subjectSeq);
		if(!"".equals(openVo.getCourseId()) && openVo.getCourseId() != null) {
			OpenVO openCourseVo = subjectService.infoOpenCourse(openVo.getCourseId(), openVo.getCourseOpenYear());// 과정에 대한 정보 가져오기
			model.addAttribute("openCourse", openCourseVo);
			logger.info("aaaaaaaaaaaaaaaaaaaaaaaaaaaa:"+openCourseVo);
		}
		model.addAttribute("open", openVo);

		return "subject/update";
	}

	// 개설 강좌 수정 (open)
	@RequestMapping(value="/update/{subjectId}/{subjectSeq}", method=RequestMethod.POST)
	public String updateSubject(OpenVO openVo) {
		logger.info("subject/update:"+openVo);

		try {
			MultipartFile mf = openVo.getFile();
			if(mf!=null && !mf.isEmpty()) { // 첨부파일 있을 때
				UploadfileVO file = new UploadfileVO();
				file.setFileName(mf.getOriginalFilename());
				file.setFileSize(mf.getSize());
				file.setFileContentType(mf.getContentType());
				file.setFileData(mf.getBytes());

				subjectService.updateFileData(openVo, file);
			}else { // 첨부파일 없을 때
				subjectService.updateSubject(openVo);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/subject/details/"+openVo.getSubjectId()+"/"+openVo.getSubjectSeq();
	}

	// 이미지 첨부파일 보여주기
	@RequestMapping("/file/{fileId}")
	public ResponseEntity<byte[]> getFile(@PathVariable String fileId){
		UploadfileVO file = subjectService.getFile(fileId);
		logger.info("getFile: "+file.toString());
		final HttpHeaders headers = new HttpHeaders();
		String[] mtypes = file.getFileContentType().split("/");
		headers.setContentType(new MediaType(mtypes[0], mtypes[1]));
		headers.setContentLength(file.getFileSize());
		headers.setContentDispositionFormData("attachment", file.getFileName(), Charset.forName("UTF-8"));
		return new ResponseEntity<byte[]>(file.getFileData(), headers, HttpStatus.OK);
	}

	// 개설 강좌 논리 삭제 (open)
	@RequestMapping(value="/del/{subjectId}/{subjectSeq}")
	public String clickDelete(@PathVariable String subjectId, @PathVariable int subjectSeq, @RequestParam(value="fileId", required=false) String fileId) {
		logger.info("del/open/:"+subjectId+"/"+subjectSeq+"/"+fileId);
		// enroll 논리 삭제
		enrollService.clickDeleteEnrollByOpen(subjectId, subjectSeq);
		// answer 논리 삭제
		surveyService.clickDeleteAnswer(subjectId, subjectSeq);
		// question 논리 삭제
		surveyService.clickDeleteQuestion(subjectId, subjectSeq);
		// open 논리 삭제
		subjectService.clickDeleteOpen(subjectId, subjectSeq);
		// upload file 논리 삭제
		if(fileId != null && !"".equals(fileId)) { //파일id가 있는 경우
			logger.info("del/uploadfile:"+fileId);
			subjectService.clickDeleteUploadFile(fileId);
		}
		return "redirect:/subject/searchSubjectBoardlist";
	}

	// 개설 강좌 입력 (open)
	@RequestMapping(value="/insert", method=RequestMethod.GET)
	public String insertSubject(@RequestParam(defaultValue="") String check, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		model.addAttribute("openVo", new OpenVO());
		model.addAttribute("check", check); // 개설 과정 목록을 통해 들어왔는지 확인

		List<CourseVO> allCourseList = subjectService.selectAllCourse();
		List<SubjectVO> allSubjectList = subjectService.selectAllSubject();
		model.addAttribute("allCourseList", allCourseList);
		model.addAttribute("allSubjectList", allSubjectList);

		return "subject/insert";
	}

	// 개설 강좌 입력 (open)
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insertSubject(OpenVO openVo, @ModelAttribute(value="QuestionVO") QuestionVO questionVo, HttpServletRequest request) {	
		logger.info("subject/insert:"+openVo);
		logger.info("subject/insert:"+questionVo);
		
		//현재년도 셋팅
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
		String year = formatter.format(new Date());
		openVo.setCourseOpenYear(year);
		
		logger.info("subject/insert/aaaaaaaaaaaaaaaaaaaaaaaaaa:"+openVo);
		
		try {
			MultipartFile mf = openVo.getFile();
			if(mf!=null && !mf.isEmpty()) { // 첨부파일 있을 때
				UploadfileVO file = new UploadfileVO();
				file.setFileName(mf.getOriginalFilename());
				file.setFileSize(mf.getSize());
				file.setFileContentType(mf.getContentType());
				file.setFileData(mf.getBytes());

				// subjectSeq 넣고 fileData, subject insert
				int subjectSeq = surveyService.getMaxSubjectSeq(openVo.getSubjectId()) + 1;
				openVo.setSubjectSeq(subjectSeq);
				subjectService.insertFileData(openVo, file);

				//subjectSeq quesitonVo에 set
				questionVo.setSubjectSeq(subjectSeq);
				surveyService.insertQuestion(questionVo);
			}else { // 첨부파일 없을 때
				// subjectSeq 넣고 subject insert
				int subjectSeq = surveyService.getMaxSubjectSeq(openVo.getSubjectId()) + 1;
				openVo.setSubjectSeq(subjectSeq);
				subjectService.insertSubject(openVo);

				//subjectSeq quesitonVo에 set
				questionVo.setSubjectSeq(subjectSeq);
				surveyService.insertQuestion(questionVo);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		logger.info("check ?? :" + request.getParameter("check"));
		
		if("openCourse".equals(request.getParameter("check"))) {
			return "redirect:/subject/searchCourseBoardlist"; // 개설 과정 목록을 통해서 개설햇으면 개설 과정 목록으로 돌아오게
		} else {
			return "redirect:/subject/searchSubjectBoardlist";
		}
	}

	// 개설 강좌 입력 폼 비동기 출력
	@RequestMapping(value="/ajax", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> ajaxTest(String courseId, String subjectId, String year) {
		logger.info("test/subjectId: " + subjectId +", courseId: "+courseId + ", year: "+year);
		return subjectService.infoSubjectCourse(courseId, subjectId, year);
	}
	
	//개설강좌 폐강처리
	@RequestMapping(value="/closesubject/{subjectId}/{subjectSeq}")
	public String closeSubject(@PathVariable String subjectId, @PathVariable int subjectSeq, @RequestParam(value="fileId", required=false) String fileId) {
		subjectService.closeSubject(subjectId, subjectSeq);
		//개설강좌가 폐강 되면 수강생 수강취소도 함께
		logger.info("closeSubject:");
		return "redirect:/subject/searchSubjectBoardlist";
	}	
	
	/**
	 * @Description : paging 개설 과정 목록 조회 (course) 게시물 개수 변경  - ajax
	 * @author KOSA
	 * @date 2023. 1. 17.
	 * @param strPageNo
	 * @param strRowsPerPage
	 * @param catSubject
	 * @param model
	 * @return
	 */
	@PostMapping("/ajaxcourseboardlist")
	public String ajaxCourseList(@RequestParam(defaultValue="1") String strPageNo, @RequestParam(defaultValue="10") String strRowsPerPage, 
			@RequestParam(defaultValue="all") String catCourseCd, @RequestParam(defaultValue="crseTitle") String course, @RequestParam(defaultValue="") String keyword, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		
		int pageNo = Integer.parseInt(strPageNo);
		int rowsPerPage = Integer.parseInt(strRowsPerPage);
		
		// 페이징 대상이 되는 전체 행수
		int totalRows = pagerService.getCountSearchOpenCourseRow(catCourseCd, course, keyword);

		// 페이저 정보가 담긴 Pager 객체 생성
		Pager pager = new Pager(rowsPerPage, 5, totalRows, pageNo);  // (int rowsPerPage, int pagesPerGroup, int totalRows, int pageNo)

		// 해당 페이지의 행을 가져오기
		List<OpenVO> boardList = pagerService.selectSearchOpenCourseListByPage(pager, catCourseCd, course, keyword);

		//JSP에서 사용할 데이터를 저장
		model.addAttribute("catId", catCourseCd); 
		model.addAttribute("course", course);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pager", pager);
		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListSize", boardList.size()); // 페이지 상단 좌측 "전체 목록" 수
		model.addAttribute("rowsPerPage", rowsPerPage);	
		logger.info("searchOpenCourseBoardList: " + boardList);
		
		return "subject/boardlist-result";
	}

	/**
	 * @Description : paging 강좌 목록 조회 (subject) 게시물 개수 변경 - ajax
	 * @author KOSA
	 * @date 2023. 1. 16.
	 * @param strPageNo
	 * @param strRowsPerPage
	 * @param catSubject
	 * @param model
	 * @return
	 */
	@PostMapping("/ajaxsubjectboardlist")
	public String ajaxSubjectList(@RequestParam(defaultValue="1") String strPageNo, @RequestParam(defaultValue="10") String strRowsPerPage, 
			@RequestParam(defaultValue="all") String catSubjectCd, @RequestParam(defaultValue="subjTitle") String subject, @RequestParam(defaultValue="") String keyword, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		model.addAttribute("check", "openSubject");
		
		logger.info("strRowPerPage:"+strRowsPerPage);
		
		int pageNo = Integer.parseInt(strPageNo);
		int rowsPerPage = Integer.parseInt(strRowsPerPage);
		
		// 페이징 대상이 되는 전체 행수
		int totalRows = pagerService.getCountSearchOpenSubjectRow(catSubjectCd, subject, keyword);

		// 페이저 정보가 담긴 Pager 객체 생성
		Pager pager = new Pager(rowsPerPage, 5, totalRows, pageNo);  // (int rowsPerPage, int pagesPerGroup, int totalRows, int pageNo)

		// 해당 페이지의 행을 가져오기
		List<OpenVO> boardList = pagerService.selectSearchOpenSubjectListByPage(pager, catSubjectCd, subject, keyword);

		//JSP에서 사용할 데이터를 저장
		model.addAttribute("catId", catSubjectCd);
		model.addAttribute("subject", subject);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pager", pager);
		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListSize", boardList.size()); // 페이지 상단 좌측 "전체 목록" 수
		model.addAttribute("rowsPerPage", rowsPerPage);
		logger.info("searchOpenSubjectBoardList: " + boardList);
		
		return "subject/boardlist-result";
	}
	
	
	/**
	 * @Description : 연수 끝나는 날 지정해줄때 휴일인 경우 고려
	 * @author KOSA
	 * @date 2023. 1. 26.
	 * @param startDay
	 * @param endDay
	 * @return
	 */
	@RequestMapping(value="/ajaxcheckholiday", method=RequestMethod.GET)
	@ResponseBody
	public int ajaxCheckHoliday(String startDay, String endDay) {
		logger.info("checkHoliday:"+startDay+endDay);
		logger.info("checkHoliday:"+subjectService.checkHoliday(startDay, endDay));
		return subjectService.checkHoliday(startDay, endDay);
	}
	
}
