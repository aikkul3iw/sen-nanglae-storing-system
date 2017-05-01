package com.mfu.proj.controller;

import java.util.List;

import javax.ejb.EJB;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.proj.ejb.entity.Education;
import com.proj.ejb.face.EducationService;
import com.proj.ejb.face.VillageService;

@Controller
public class EducationController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//EducationServiceBean!com.proj.ejb.face.EducationService")
	EducationService eduServ;

	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;

	@RequestMapping("/listEducation")
	public @ResponseBody List<Education> listEducation(HttpServletRequest request) {

		List<Education> eduList = null;
		try {
			eduList = eduServ.listAllEducation();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return eduList;
	}

	@RequestMapping("/saveEducation")
	public @ResponseBody String saveEducation(@RequestBody Education education, HttpServletRequest request) {

		String edu = request.getParameter("id");

		try {

			if (education.getEdu_id() == 0) {
				education.setLocation(vilServ.findVillageById(Long.parseLong(edu)));
				eduServ.save(education);

			} else {
				education.setLocation(vilServ.findVillageById(Long.parseLong(edu)));
				eduServ.update(education);
			}
		} catch (Exception e) {

			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteEducation")
	public @ResponseBody String deleteEducation(@RequestBody Education education) {

		try {
			if (education.getEdu_id() != 0) {
				eduServ.delete(education.getEdu_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findEducation")
	public @ResponseBody Education findCommerce(@RequestBody Education education) {
		Education result = null;
		try {

			result = eduServ.findEducationById(education.getEdu_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/userEducation",method=RequestMethod.GET)
	public ModelAndView displayuserEducation(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("userEducation");
		
		return model;
	}
	@RequestMapping(value="/nonEducation",method=RequestMethod.GET)
	public ModelAndView displaynonEducation(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("nonEducation");
		
		return model;
	}
	@RequestMapping(value="/superEducation",method=RequestMethod.GET)
	public ModelAndView displaysuperEducation(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("superEducation");
		
		return model;
	}
}
