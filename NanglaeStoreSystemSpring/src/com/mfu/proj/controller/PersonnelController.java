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

import com.proj.ejb.entity.Personnel;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.PersonnelService;

@Controller
public class PersonnelController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//PersonnelServiceBean!com.proj.ejb.face.PersonnelService")
	PersonnelService perServ;

	@RequestMapping("/listPersonnel")
	public @ResponseBody List<Personnel> listPersonnel(HttpServletRequest request) {

		List<Personnel> perList = null;
		try {
			perList = perServ.listAllPersonnel();

		} catch (Exception e) {

			e.printStackTrace();
		}

		return perList;
	}

	@RequestMapping("/savePersonnel")
	public @ResponseBody String savePersonnel(@RequestBody Personnel personnel) {
		try {
			if (personnel.getPer_id() == 0) {
				perServ.save(personnel);
			} else {
				perServ.update(personnel);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deletePersonnel")
	public @ResponseBody String deletePersonnel(@RequestBody Personnel personnel) {

		try {
			if (personnel.getPer_id() != 0) {
				perServ.delete(personnel.getPer_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findPersonnel")
	public @ResponseBody Personnel findPersonnel(@RequestBody Personnel personnel) {
		Personnel result = null;
		try {

			result = perServ.findPersonnelById(personnel.getPer_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	@RequestMapping(value="/non-personel",method=RequestMethod.GET)
	public ModelAndView displayLogin(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("non-personel");
		return model;
	}
	
	@RequestMapping(value="/personnel",method=RequestMethod.GET)
	public ModelAndView displayPersonnel(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("personnel");
		
		return model;
	}
}
