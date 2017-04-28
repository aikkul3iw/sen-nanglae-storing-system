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

import com.proj.ejb.entity.Industry;
import com.proj.ejb.face.IndustryService;
import com.proj.ejb.face.VillageService;

@Controller
public class IndustryController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//IndustryServiceBean!com.proj.ejb.face.IndustryService")
	IndustryService insServ;

	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;

	@RequestMapping("/listIndustry")
	public @ResponseBody List<Industry> listIndustry(HttpServletRequest request) {

		List<Industry> insList = null;
		try {
			insList = insServ.listAllIndustry();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return insList;
	}

	@RequestMapping("/saveIndustry")
	public @ResponseBody String saveCommerce(@RequestBody Industry industry, HttpServletRequest request) {
		String ins = request.getParameter("id");
		try {
			if (industry.getIns_id() == 0) {
				industry.setLocation(vilServ.findVillageById(Long.parseLong(ins)));
				insServ.save(industry);

			} else {
				industry.setLocation(vilServ.findVillageById(Long.parseLong(ins)));
				insServ.update(industry);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteIndustry")
	public @ResponseBody String deleteIndustry(@RequestBody Industry industry) {

		try {
			if (industry.getIns_id() != 0) {
				insServ.delete(industry.getIns_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findIndustry")
	public @ResponseBody Industry findCommerce(@RequestBody Industry industry) {
		Industry result = null;
		try {

			result = insServ.findIndustryById(industry.getIns_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/industry",method=RequestMethod.GET)
	public ModelAndView displayIndustry(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("industry");
		
		return model;
	}
	@RequestMapping(value="/nonIndustry",method=RequestMethod.GET)
	public ModelAndView displaynonIndustry(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("nonIndustry");
		
		return model;
	}
}
