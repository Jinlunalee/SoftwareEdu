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

	// ?????? ?????? ???????????? (open)
	@RequestMapping(value="/details/{subjectId}/{subjectSeq}", method=RequestMethod.GET)
	public String getSubjectDetails(@PathVariable String subjectId, @PathVariable int subjectSeq, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "?????? ??????");

		// ????????? ?????? ??????
		List<QuestionSetVO> questionSet = surveyService.selectSubjectQuestionSet(subjectId, subjectSeq);
		model.addAttribute("questionSet", questionSet);

		OpenVO openVo = subjectService.selectSubjectDetails(subjectId, subjectSeq);
		int totalPeople = enrollService.recruitTotalPeople(subjectId, subjectSeq, openVo.getOpenStateCd());//subject??? ????????? ?????? ???????????? ????????? ????????? ?????????
		openVo.setTotalPeople(totalPeople);
		model.addAttribute("open", openVo);

		logger.info("details/subject: "+ openVo);
		logger.info("details/subject: "+ totalPeople);
		logger.info("details/subject: "+ questionSet);

		return "subject/details";
	}
	
	/**
	 * @Description : paging ?????? ?????? ?????? (open course)
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
		model.addAttribute("menuKOR", "?????? ??????");
		model.addAttribute("check", "openCourse");
		
		// ????????? ????????? ?????? ?????? ?????? ??????
		int totalRows = pagerService.getCountSearchOpenCourseRow(catCourseCd, course, keyword);
		
		// ????????? ????????? ?????? Pager ?????? ??????
		Pager pager = new Pager(rowsPerPage, 5, totalRows, pageNo);
		
		// ?????? ???????????? ?????? ????????????
		List<OpenVO> boardList = pagerService.selectSearchOpenCourseListByPage(pager, catCourseCd, course, keyword);
		
		//JSP?????? ????????? ???????????? ??????
		model.addAttribute("catId", catCourseCd);
		model.addAttribute("course", course);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pager", pager);
		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListSize", boardList.size()); // ????????? ?????? ?????? "?????? ??????" ???
		model.addAttribute("rowsPerPage", rowsPerPage);
		logger.info("searchOpenCourseBoardList: " + boardList);
		
		return "subject/courselist";
	}
	
	/**
	 * @Description : paging ?????? ?????? ?????? (open subject)
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
		model.addAttribute("menuKOR", "?????? ??????");
		model.addAttribute("check", "openSubject");
		
		// ????????? ????????? ?????? ?????? ?????? ??????
		int totalRows = pagerService.getCountSearchOpenSubjectRow(catSubjectCd, subject, keyword);
		
		// ????????? ????????? ?????? Pager ?????? ??????
		Pager pager = new Pager(rowsPerPage, 5, totalRows, pageNo);
		
		// ?????? ???????????? ?????? ????????????
		List<OpenVO> boardList = pagerService.selectSearchOpenSubjectListByPage(pager, catSubjectCd, subject, keyword);
		
		//JSP?????? ????????? ???????????? ??????
		model.addAttribute("catId", catSubjectCd);
		model.addAttribute("subject", subject);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pager", pager);
		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListSize", boardList.size()); // ????????? ?????? ?????? "?????? ??????" ???
		model.addAttribute("rowsPerPage", rowsPerPage);
		logger.info("searchOpenSubjectBoardList: " + boardList);
		
		return "subject/subjectlist";
	}

	// ?????? ?????? ?????? (open)
	@RequestMapping(value="/update/{subjectId}/{subjectSeq}", method=RequestMethod.GET)
	public String updateSubject(@PathVariable String subjectId, @PathVariable int subjectSeq, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "?????? ??????");

		OpenVO openVo = subjectService.selectSubjectDetails(subjectId, subjectSeq);
		if(!"".equals(openVo.getCourseId()) && openVo.getCourseId() != null) {
			OpenVO openCourseVo = subjectService.infoOpenCourse(openVo.getCourseId(), openVo.getCourseOpenYear());// ????????? ?????? ?????? ????????????
			model.addAttribute("openCourse", openCourseVo);
			logger.info("aaaaaaaaaaaaaaaaaaaaaaaaaaaa:"+openCourseVo);
		}
		model.addAttribute("open", openVo);

		return "subject/update";
	}

	// ?????? ?????? ?????? (open)
	@RequestMapping(value="/update/{subjectId}/{subjectSeq}", method=RequestMethod.POST)
	public String updateSubject(OpenVO openVo) {
		logger.info("subject/update:"+openVo);

		try {
			MultipartFile mf = openVo.getFile();
			if(mf!=null && !mf.isEmpty()) { // ???????????? ?????? ???
				UploadfileVO file = new UploadfileVO();
				file.setFileName(mf.getOriginalFilename());
				file.setFileSize(mf.getSize());
				file.setFileContentType(mf.getContentType());
				file.setFileData(mf.getBytes());

				subjectService.updateFileData(openVo, file);
			}else { // ???????????? ?????? ???
				subjectService.updateSubject(openVo);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/subject/details/"+openVo.getSubjectId()+"/"+openVo.getSubjectSeq();
	}

	// ????????? ???????????? ????????????
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

	// ?????? ?????? ?????? ?????? (open)
	@RequestMapping(value="/del/{subjectId}/{subjectSeq}")
	public String clickDelete(@PathVariable String subjectId, @PathVariable int subjectSeq, @RequestParam(value="fileId", required=false) String fileId) {
		logger.info("del/open/:"+subjectId+"/"+subjectSeq+"/"+fileId);
		// enroll ?????? ??????
		enrollService.clickDeleteEnrollByOpen(subjectId, subjectSeq);
		// answer ?????? ??????
		surveyService.clickDeleteAnswer(subjectId, subjectSeq);
		// question ?????? ??????
		surveyService.clickDeleteQuestion(subjectId, subjectSeq);
		// open ?????? ??????
		subjectService.clickDeleteOpen(subjectId, subjectSeq);
		// upload file ?????? ??????
		if(fileId != null && !"".equals(fileId)) { //??????id??? ?????? ??????
			logger.info("del/uploadfile:"+fileId);
			subjectService.clickDeleteUploadFile(fileId);
		}
		return "redirect:/subject/searchSubjectBoardlist";
	}

	// ?????? ?????? ?????? (open)
	@RequestMapping(value="/insert", method=RequestMethod.GET)
	public String insertSubject(@RequestParam(defaultValue="") String check, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "?????? ??????");
		model.addAttribute("openVo", new OpenVO());
		model.addAttribute("check", check); // ?????? ?????? ????????? ?????? ??????????????? ??????

		List<CourseVO> allCourseList = subjectService.selectAllCourse();
		List<SubjectVO> allSubjectList = subjectService.selectAllSubject();
		model.addAttribute("allCourseList", allCourseList);
		model.addAttribute("allSubjectList", allSubjectList);

		return "subject/insert";
	}

	// ?????? ?????? ?????? (open)
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insertSubject(OpenVO openVo, @ModelAttribute(value="QuestionVO") QuestionVO questionVo, HttpServletRequest request) {	
		logger.info("subject/insert:"+openVo);
		logger.info("subject/insert:"+questionVo);
		
		//???????????? ??????
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
		String year = formatter.format(new Date());
		openVo.setCourseOpenYear(year);
		
		logger.info("subject/insert/aaaaaaaaaaaaaaaaaaaaaaaaaa:"+openVo);
		
		try {
			MultipartFile mf = openVo.getFile();
			if(mf!=null && !mf.isEmpty()) { // ???????????? ?????? ???
				UploadfileVO file = new UploadfileVO();
				file.setFileName(mf.getOriginalFilename());
				file.setFileSize(mf.getSize());
				file.setFileContentType(mf.getContentType());
				file.setFileData(mf.getBytes());

				// subjectSeq ?????? fileData, subject insert
				int subjectSeq = surveyService.getMaxSubjectSeq(openVo.getSubjectId()) + 1;
				openVo.setSubjectSeq(subjectSeq);
				subjectService.insertFileData(openVo, file);

				//subjectSeq quesitonVo??? set
				questionVo.setSubjectSeq(subjectSeq);
				surveyService.insertQuestion(questionVo);
			}else { // ???????????? ?????? ???
				// subjectSeq ?????? subject insert
				int subjectSeq = surveyService.getMaxSubjectSeq(openVo.getSubjectId()) + 1;
				openVo.setSubjectSeq(subjectSeq);
				subjectService.insertSubject(openVo);

				//subjectSeq quesitonVo??? set
				questionVo.setSubjectSeq(subjectSeq);
				surveyService.insertQuestion(questionVo);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		logger.info("check ?? :" + request.getParameter("check"));
		
		if("openCourse".equals(request.getParameter("check"))) {
			return "redirect:/subject/searchCourseBoardlist"; // ?????? ?????? ????????? ????????? ??????????????? ?????? ?????? ???????????? ????????????
		} else {
			return "redirect:/subject/searchSubjectBoardlist";
		}
	}

	// ?????? ?????? ?????? ??? ????????? ??????
	@RequestMapping(value="/ajax", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> ajaxTest(String courseId, String subjectId, String year) {
		logger.info("test/subjectId: " + subjectId +", courseId: "+courseId + ", year: "+year);
		return subjectService.infoSubjectCourse(courseId, subjectId, year);
	}
	
	//???????????? ????????????
	@RequestMapping(value="/closesubject/{subjectId}/{subjectSeq}")
	public String closeSubject(@PathVariable String subjectId, @PathVariable int subjectSeq, @RequestParam(value="fileId", required=false) String fileId) {
		subjectService.closeSubject(subjectId, subjectSeq);
		//??????????????? ?????? ?????? ????????? ??????????????? ??????
		logger.info("closeSubject:");
		return "redirect:/subject/searchSubjectBoardlist";
	}	
	
	/**
	 * @Description : paging ?????? ?????? ?????? ?????? (course) ????????? ?????? ??????  - ajax
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
		model.addAttribute("menuKOR", "?????? ??????");
		
		int pageNo = Integer.parseInt(strPageNo);
		int rowsPerPage = Integer.parseInt(strRowsPerPage);
		
		// ????????? ????????? ?????? ?????? ??????
		int totalRows = pagerService.getCountSearchOpenCourseRow(catCourseCd, course, keyword);

		// ????????? ????????? ?????? Pager ?????? ??????
		Pager pager = new Pager(rowsPerPage, 5, totalRows, pageNo);  // (int rowsPerPage, int pagesPerGroup, int totalRows, int pageNo)

		// ?????? ???????????? ?????? ????????????
		List<OpenVO> boardList = pagerService.selectSearchOpenCourseListByPage(pager, catCourseCd, course, keyword);

		//JSP?????? ????????? ???????????? ??????
		model.addAttribute("catId", catCourseCd); 
		model.addAttribute("course", course);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pager", pager);
		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListSize", boardList.size()); // ????????? ?????? ?????? "?????? ??????" ???
		model.addAttribute("rowsPerPage", rowsPerPage);	
		logger.info("searchOpenCourseBoardList: " + boardList);
		
		return "subject/boardlist-result";
	}

	/**
	 * @Description : paging ?????? ?????? ?????? (subject) ????????? ?????? ?????? - ajax
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
		model.addAttribute("menuKOR", "?????? ??????");
		model.addAttribute("check", "openSubject");
		
		logger.info("strRowPerPage:"+strRowsPerPage);
		
		int pageNo = Integer.parseInt(strPageNo);
		int rowsPerPage = Integer.parseInt(strRowsPerPage);
		
		// ????????? ????????? ?????? ?????? ??????
		int totalRows = pagerService.getCountSearchOpenSubjectRow(catSubjectCd, subject, keyword);

		// ????????? ????????? ?????? Pager ?????? ??????
		Pager pager = new Pager(rowsPerPage, 5, totalRows, pageNo);  // (int rowsPerPage, int pagesPerGroup, int totalRows, int pageNo)

		// ?????? ???????????? ?????? ????????????
		List<OpenVO> boardList = pagerService.selectSearchOpenSubjectListByPage(pager, catSubjectCd, subject, keyword);

		//JSP?????? ????????? ???????????? ??????
		model.addAttribute("catId", catSubjectCd);
		model.addAttribute("subject", subject);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pager", pager);
		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListSize", boardList.size()); // ????????? ?????? ?????? "?????? ??????" ???
		model.addAttribute("rowsPerPage", rowsPerPage);
		logger.info("searchOpenSubjectBoardList: " + boardList);
		
		return "subject/boardlist-result";
	}
	
	
	/**
	 * @Description : ?????? ????????? ??? ??????????????? ????????? ?????? ??????
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
