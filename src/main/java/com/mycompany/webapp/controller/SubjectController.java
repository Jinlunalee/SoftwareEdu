package com.mycompany.webapp.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mycompany.webapp.dto.QuestionVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.dto.UploadfileVO;
import com.mycompany.webapp.service.IEnrollService;
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
	
	//과정목록조회 (course)
	@RequestMapping(value="/courselist", method=RequestMethod.GET)
	public String getCourseList(Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		
		List<SubjectVO> courseList = subjectService.selectCourseList();
		model.addAttribute("courseList", courseList);
		model.addAttribute("courseListSize", courseList.size());
		logger.info("courseList: " + courseList);
		
		return "subject/courselist";
	}

	// 개설 강좌 목록조회 (open)
	@RequestMapping(value="/subjectlist", method=RequestMethod.GET)
	public String getSubjectList(Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		
		List<SubjectVO> subjectList = subjectService.selectSubjectList();
		model.addAttribute("subjectList", subjectList);
		model.addAttribute("subListSize", subjectList.size());
		logger.info("subjectlist: " + subjectList);
		
		return "subject/subjectlist";
	}

	// 개설 강좌 상세조회 (open)
	@RequestMapping(value="/details/{subjectId}/{subjectSeq}", method=RequestMethod.GET)
	public String getSubjectDetails(@PathVariable String subjectId, @PathVariable int subjectSeq, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		
		SubjectVO subject = subjectService.selectSubjectDetails(subjectId, subjectSeq);
		int totalPeople = subjectService.recruitTotalPeople(subjectId, subjectSeq, subject.getState());//subject에 있는 state가 아니라 enroll에 있는거 가져와야함
		model.addAttribute("subject", subject);
		model.addAttribute("totalPeople", totalPeople);
		
		logger.info("details/subject: "+ subject);
		logger.info("details/subject: "+ totalPeople);
		
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
	public String updateSubject(@PathVariable String subjectId, @PathVariable int subjectSeq,Model model) {
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

	// 개설 강좌 삭제 (open)
	@RequestMapping(value="/delete/{subjectId}")
	public String deleteSubject(@PathVariable String subjectId ,SubjectVO subjectVo, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		return "redirect:/subject/subjectlist";
	}
	
	// 개설 강좌 논리 삭제 (open)
	@RequestMapping(value="/del/{subjectId}/{subjectSeq}")
	public void clickDelete(@PathVariable String subjectId, @PathVariable int subjectSeq) {
		// enroll 논리 삭제
		enrollService.clickDeleteEnrollByOpen(subjectId, subjectSeq);
		// answer 논리 삭제
		surveyService.clickDeleteAnswer(subjectId, subjectSeq);
		// question 논리 삭제
		surveyService.clickDeleteQuestion(subjectId, subjectSeq);
		// open 논리 삭제
		subjectService.clickDeleteOpen(subjectId, subjectSeq);
		// upload file 논리 삭제
		subjectService.clickDeleteUploadFile(subjectId, subjectSeq);
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
		logger.info("subject/insert:"+questionVo); // surveyVO 받기
		
		try {
			MultipartFile mf = subject.getFile();
			if(mf!=null && !mf.isEmpty()) { // 첨부파일 있을 때
				UploadfileVO file = new UploadfileVO();
				file.setFileName(mf.getOriginalFilename());
				file.setFileSize(mf.getSize());
				file.setFileContentType(mf.getContentType());
				file.setFileData(mf.getBytes());
				
				subjectService.insertFileData(subject, file);
			}else { // 첨부파일 없을 때
				subjectService.insertSubject(subject);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/subject/subjectlist";
	}
	
	// 개설 강좌 입력 폼 비동기 출력
	@RequestMapping(value="/ajax", method=RequestMethod.GET)
	public @ResponseBody List<SubjectVO> ajaxTest(String courseId, String subjectId) {
		logger.info("test/subjectId: " + subjectId +", courseId: "+courseId);
		return subjectService.infoSubjectCourse(courseId, subjectId);
		
		
	}

}
