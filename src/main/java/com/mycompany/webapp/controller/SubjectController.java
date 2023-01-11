package com.mycompany.webapp.controller;

import java.nio.charset.Charset;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.QuestionSetVO;
import com.mycompany.webapp.dto.QuestionVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.dto.UploadfileVO;
import com.mycompany.webapp.service.IEnrollService;
import com.mycompany.webapp.service.IHomeService;
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
	
//	//개설 과정 목록조회 (course)
//	@RequestMapping(value="/courselist", method=RequestMethod.GET)
//	public String getCourseList(Model model) {
//		model.addAttribute("menu", "subject");
//		model.addAttribute("menuKOR", "강좌 관리");
//		
//		List<SubjectVO> boardList = subjectService.selectCourseList();
//		model.addAttribute("boardList", boardList);
//		model.addAttribute("boardListSize", boardList.size());
//		logger.info("courseList: " + boardList);
//		
//		return "subject/courselist";
//	}
	
	// paging 개설 과정 목록 조회 (course)
	@GetMapping("/courseboardlist")
	public String courseList(@RequestParam(defaultValue="1") int pageNo, @RequestParam(defaultValue="10") int rowsPerPage, Model model, @RequestParam(defaultValue="all") String catCourse) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");

		// 페이징 대상이 되는 전체 행수
		int totalRows = pagerService.getCountOpenCourseRow(catCourse);
		
		// 페이저 정보가 담긴 Pager 객체 생성
		Pager pager = new Pager(rowsPerPage, 5, totalRows, pageNo);  // (int rowsPerPage, int pagesPerGroup, int totalRows, int pageNo)
		
		// 해당 페이지의 행을 가져오기
		List<SubjectVO> boardList = pagerService.selectOpenCourseListByPage(pager, catCourse);
				
		//JSP에서 사용할 데이터를 저장
		model.addAttribute("catId", catCourse);
		model.addAttribute("pager", pager);
		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListSize", boardList.size()); // 페이지 상단 좌측 "전체 목록" 수
		logger.info("OpenCourseBoardList: " + boardList);

		return "subject/courselist";
	}

//	// 개설 강좌 목록조회 (open)
//	@RequestMapping(value="/subjectlist", method=RequestMethod.GET)
//	public String getSubjectList(Model model) {
//		model.addAttribute("menu", "subject");
//		model.addAttribute("menuKOR", "강좌 관리");
//		
//		List<SubjectVO> boardList = subjectService.selectSubjectList();
//		model.addAttribute("boardList", boardList);
//		model.addAttribute("boardListSize", boardList.size());
//		logger.info("subjectlist: " + boardList);
//		
//		return "subject/subjectlist";
//	}
	
	// paging 강좌 목록 조회 (open)
	@GetMapping("/subjectboardlist")
	public String subjectList(@RequestParam(defaultValue="1") int pageNo, @RequestParam(defaultValue="10") int rowsPerPage, Model model, @RequestParam(defaultValue="all") String catSubject) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");

		// 페이징 대상이 되는 전체 행수
		int totalRows = pagerService.getCountOpenSubjectRow(catSubject);

		// 페이저 정보가 담긴 Pager 객체 생성
		Pager pager = new Pager(rowsPerPage, 5, totalRows, pageNo);  // (int rowsPerPage, int pagesPerGroup, int totalRows, int pageNo)
		
		// 해당 페이지의 행을 가져오기
		List<SubjectVO> boardList = pagerService.selectOpenSubjectListByPage(pager, catSubject);
		
		//JSP에서 사용할 데이터를 저장
		model.addAttribute("catId", catSubject);
		model.addAttribute("pager", pager);
		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListSize", boardList.size()); // 페이지 상단 좌측 "전체 목록" 수
		logger.info("boardList: " + boardList);
		
		return "subject/subjectlist";
	}

	// 개설 강좌 상세조회 (open)
	@RequestMapping(value="/details/{subjectId}/{subjectSeq}", method=RequestMethod.GET)
	public String getSubjectDetails(@PathVariable String subjectId, @PathVariable int subjectSeq, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		
		// 만족도 조사 항목
		List<QuestionSetVO> questionSet = surveyService.selectSubjectQuestionSet(subjectId, subjectSeq);
		model.addAttribute("questionSet", questionSet);

		SubjectVO subject = subjectService.selectSubjectDetails(subjectId, subjectSeq);
		int totalPeople = subjectService.recruitTotalPeople(subjectId, subjectSeq, subject.getState());//subject에 있는 state가 아니라 enroll에 있는거 가져와야함
		model.addAttribute("subject", subject);
		model.addAttribute("totalPeople", totalPeople);
		
		logger.info("details/subject: "+ subject);
		logger.info("details/subject: "+ totalPeople);
		logger.info("details/subject: "+ questionSet);
		
		return "subject/details";
	}

	// 개설 강좌 검색 (open)
	@RequestMapping(value="/search", method=RequestMethod.GET)
	public String searchSubject(@RequestParam String subjectTitle, @RequestParam String subjectId, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		return "subject/search";
	}
	
	// 개설 강좌 수정 (open)
	@RequestMapping(value="/update/{subjectId}/{subjectSeq}", method=RequestMethod.GET)
	public String updateSubject(@PathVariable String subjectId, @PathVariable int subjectSeq, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		
		SubjectVO subject = subjectService.selectSubjectDetails(subjectId, subjectSeq);
		model.addAttribute("subject", subject);
		
		return "subject/update";
	}
	
	// 개설 강좌 수정 (open)
	@RequestMapping(value="/update/{subjectId}/{subjectSeq}", method=RequestMethod.POST)
	public String updateSubject(SubjectVO subject) {
		logger.info("subject/update:"+subject);
		
		//time,date format
		subject.setStartDay(subject.getStartDay().replaceAll("-", ""));
		subject.setEndDay(subject.getEndDay().replaceAll("-", ""));
		subject.setRecruitStartDay(subject.getRecruitStartDay().replaceAll("-", ""));
		subject.setRecruitEndDay(subject.getRecruitEndDay().replaceAll("-", ""));
		subject.setStartTime(subject.getStartTime().replaceAll(":", ""));
		subject.setEndTime(subject.getEndTime().replaceAll(":", ""));
				
		try {
			MultipartFile mf = subject.getFile();
			if(mf!=null && !mf.isEmpty()) { // 첨부파일 있을 때
				UploadfileVO file = new UploadfileVO();
				file.setFileName(mf.getOriginalFilename());
				file.setFileSize(mf.getSize());
				file.setFileContentType(mf.getContentType());
				file.setFileData(mf.getBytes());
				
				subjectService.updateFileData(subject, file);
			}else { // 첨부파일 없을 때
				subjectService.updateSubject(subject);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/subject/details/"+subject.getSubjectId()+"/"+subject.getSubjectSeq();
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

	// 개설 강좌 삭제 (open)
	@RequestMapping(value="/delete/{subjectId}")
	public String deleteSubject(@PathVariable String subjectId ,SubjectVO subjectVo, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		return "redirect:/subject/subjectlist";
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
		return "redirect:/subject/subjectlist";
	}

	// 개설 강좌 입력 (open)
	@RequestMapping(value="/insert", method=RequestMethod.GET)
	public String insertSubject(Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		
		List<SubjectVO> allCourseList = subjectService.selectAllCourse();
		List<SubjectVO> allSubjectList = subjectService.selectAllSubject();
		model.addAttribute("allCourseList", allCourseList);
		model.addAttribute("allSubjectList", allSubjectList);
		
		return "subject/insert";
	}

	// 개설 강좌 입력 (open)
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insertSubject(SubjectVO subject, @ModelAttribute(value="QuestionVO") QuestionVO questionVo) {
		
		//time,date format
		subject.setStartDay(subject.getStartDay().replaceAll("-", ""));
		subject.setEndDay(subject.getEndDay().replaceAll("-", ""));
		subject.setRecruitStartDay(subject.getRecruitStartDay().replaceAll("-", ""));
		subject.setRecruitEndDay(subject.getRecruitEndDay().replaceAll("-", ""));
		subject.setStartTime(subject.getStartTime().replaceAll(":", ""));
		subject.setEndTime(subject.getEndTime().replaceAll(":", ""));
		
		logger.info("subject/insert:"+subject);
		logger.info("subject/insert:"+questionVo);
		
		try {
			MultipartFile mf = subject.getFile();
			if(mf!=null && !mf.isEmpty()) { // 첨부파일 있을 때
				UploadfileVO file = new UploadfileVO();
				file.setFileName(mf.getOriginalFilename());
				file.setFileSize(mf.getSize());
				file.setFileContentType(mf.getContentType());
				file.setFileData(mf.getBytes());
				
				subjectService.insertFileData(subject, file);
				
				//subjectId 중 subjectSeq가 max인 것을 찾아 quesitonVo에 set
				questionVo.setSubjectSeq(surveyService.getMaxSubjectSeq(subject.getSubjectId()));
				System.out.println("subjectSeq" + surveyService.getMaxSubjectSeq(subject.getSubjectId()));
				surveyService.insertQuestion(questionVo);
			}else { // 첨부파일 없을 때
				subjectService.insertSubject(subject);
				
				//subjectId 중 subjectSeq가 max인 것을 찾아 quesitonVo에 set
				questionVo.setSubjectSeq(surveyService.getMaxSubjectSeq(subject.getSubjectId()));
				System.out.println("subjectSeq" + surveyService.getMaxSubjectSeq(subject.getSubjectId()));
				surveyService.insertQuestion(questionVo);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/subject/subjectlist";
	}
	
	// 개설 강좌 입력 폼 비동기 출력
	@RequestMapping(value="/ajax", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> ajaxTest(String courseId, String subjectId) {
		logger.info("test/subjectId: " + subjectId +", courseId: "+courseId);
		return subjectService.infoSubjectCourse(courseId, subjectId);
	}
	
	//개설강좌 폐강처리
	@RequestMapping(value="/closesubject/{subjectId}/{subjectSeq}")
	public String closeSubject(@PathVariable String subjectId, @PathVariable int subjectSeq, @RequestParam(value="fileId", required=false) String fileId) {
		subjectService.closeSubject(subjectId, subjectSeq);
		//폐강하면 첨부파일은 어떻게 해야할가(삭제안해도 될듯?)
		//개설강좌가 폐강 되면 수강생 수강취소도 함께
		
		return "redirect:/subject/subjectlist";
	}
	
	//모집마감된 강좌 추가모집
	
	
}
