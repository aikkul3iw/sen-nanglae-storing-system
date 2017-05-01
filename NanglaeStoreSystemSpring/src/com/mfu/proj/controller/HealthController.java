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

import com.proj.ejb.entity.Health;
import com.proj.ejb.face.HealthService;
import com.proj.ejb.face.VillageService;

@Controller
public class HealthController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//HealthServiceBean!com.proj.ejb.face.HealthService")
	HealthService eduServ;

	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;

	@RequestMapping("/listHealth")
	public @ResponseBody List<Health> listHealth(HttpServletRequest request) {

		List<Health> eduList = null;
		try {
			eduList = eduServ.listAllHealth();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return eduList;
	}

	@RequestMapping("/saveHealth")
	public @ResponseBody String saveHealth(@RequestBody Health Health, HttpServletRequest request) {

		String edu = request.getParameter("id");

		try {

			if (Health.getHlt_id() == 0) {
				Health.setLocation(vilServ.findVillageById(Long.parseLong(edu)));
				eduServ.save(Health);

			} else {
				Health.setLocation(vilServ.findVillageById(Long.parseLong(edu)));
				eduServ.update(Health);
			}
		} catch (Exception e) {

			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteHealth")
	public @ResponseBody String deleteHealth(@RequestBody Health Health) {

		try {
			if (Health.getHlt_id() != 0) {
				eduServ.delete(Health.getHlt_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findHealth")
	public @ResponseBody Health findCommerce(@RequestBody Health Health) {
		Health result = null;
		try {

			result = eduServ.findHealthById(Health.getHlt_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/userHealth",method=RequestMethod.GET)
	public ModelAndView displayuserHealth(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("userHealth");
		
		return model;
	}
	@RequestMapping(value="/nonHealth",method=RequestMethod.GET)
	public ModelAndView displaynonHealth(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("nonHealth");
		
		return model;
	}
	@RequestMapping(value="/superHealth",method=RequestMethod.GET)
	public ModelAndView displaysuperHealth(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("superHealth");
		
		return model;
	}
}
