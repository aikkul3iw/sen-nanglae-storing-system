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

import com.proj.ejb.entity.Religion;
import com.proj.ejb.face.ReligionService;
import com.proj.ejb.face.VillageService;

@Controller
public class ReligionController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ReligionServiceBean!com.proj.ejb.face.ReligionService")
	ReligionService relServ;

	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;

	@RequestMapping("/listReligion")
	public @ResponseBody List<Religion> listReligion(HttpServletRequest request) {

		List<Religion> relList = null;
		try {
			relList = relServ.listAllReligion();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return relList;
	}

	@RequestMapping("/saveReligion")
	public @ResponseBody String saveReligion(@RequestBody Religion religion, HttpServletRequest request) {
		String rel = request.getParameter("id");
		try {
			if (religion.getRel_id() == 0) {
				religion.setLocation(vilServ.findVillageById(Long.parseLong(rel)));
				relServ.save(religion);

			} else {
				religion.setLocation(vilServ.findVillageById(Long.parseLong(rel)));
				relServ.update(religion);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteReligion")
	public @ResponseBody String deleteReligion(@RequestBody Religion religion) {

		try {
			if (religion.getRel_id() != 0) {
				relServ.delete(religion.getRel_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findReligion")
	public @ResponseBody Religion findReligion(@RequestBody Religion religion) {
		Religion result = null;
		try {

			result = relServ.findReligionById(religion.getRel_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/religion",method=RequestMethod.GET)
	public ModelAndView displayReligion(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("religion");
		
		return model;
	}
	@RequestMapping(value="/nonReligion",method=RequestMethod.GET)
	public ModelAndView displaynonReligion(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("nonReligion");
		
		return model;
	}
	@RequestMapping(value="/superReligion",method=RequestMethod.GET)
	public ModelAndView displaysuperReligion(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("superReligion");
		
		return model;
	}
}
