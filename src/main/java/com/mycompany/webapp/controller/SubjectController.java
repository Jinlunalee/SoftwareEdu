package com.mycompany.webapp.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
import org.springframework.web.multipart.MultipartFile;

import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.dto.SurveyVO;
import com.mycompany.webapp.dto.UploadfileVO;
import com.mycompany.webapp.service.ISubjectService;

@Controller
@RequestMapping("/subject")
public class SubjectController {
	static final Logger logger = LoggerFactory.getLogger(SubjectController.class);
	
	@Autowired
	ISubjectService subjectService;
	
	//과정목록조회
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

	//강좌목록조회
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

	//상세조회
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

	//검색
	@RequestMapping(value="/search", method=RequestMethod.GET)
	public String searchSubject(@RequestParam String subjectTitle, @RequestParam String subjectId, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		return "subject/search";
	}

	//수정
	@RequestMapping(value="/update/{subjectId}/{subjectSeq}", method=RequestMethod.GET)
	public String updateSubject(@PathVariable String subjectId, @PathVariable int subjectSeq,Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		
		SubjectVO subject = subjectService.selectSubjectDetails(subjectId, subjectSeq);
		model.addAttribute("subject", subject);
		
		return "subject/update";
	}

	@RequestMapping(value="/update/{subjectId}", method=RequestMethod.POST)
	public String updateSubject(SubjectVO subjectVo) {
		return "redirect:/subject/details/"+subjectVo.getSubjectId();
	}

	//삭제
	@RequestMapping(value="/delete/{subjectId}")
	public String deleteSubject(@PathVariable String subjectId ,SubjectVO subjectVo, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		return "redirect:/subject/subjectlist";
	}

	//입력
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

	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insertSubject(SubjectVO subject, @ModelAttribute(value="SurveyVO") SurveyVO surveyVo) {
		System.out.println(surveyVo); // 리스트 테스트 받기
		
		//time,date format
		subject.setStartDay(subject.getStartDay().replaceAll("-", ""));
		subject.setEndDay(subject.getEndDay().replaceAll("-", ""));
		subject.setRecruitStartDay(subject.getRecruitStartDay().replaceAll("-", ""));
		subject.setStartDay(subject.getRecruitEndDay().replaceAll("-", ""));
		subject.setStartTime(subject.getStartTime().replaceAll(":", ""));
		subject.setEndTime(subject.getEndTime().replaceAll(":", ""));
		
		logger.info("subject/insert:"+subject);
		
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
		
		return "redirect:/subject/details/"+subject.getSubjectId()+"/"+subject.getSubjectSeq();
	}

}
