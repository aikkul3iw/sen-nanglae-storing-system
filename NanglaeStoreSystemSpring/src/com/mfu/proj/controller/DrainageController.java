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

import com.proj.ejb.entity.Drainage;
import com.proj.ejb.face.DrainageService;
import com.proj.ejb.face.VillageService;

@Controller
public class DrainageController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//DrainageServiceBean!com.proj.ejb.face.DrainageService")
	DrainageService daiServ;

	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;

	@RequestMapping("/listDrainage")
	public @ResponseBody List<Drainage> listDrainage(HttpServletRequest request) {

		List<Drainage> daiList = null;
		try {
			daiList = daiServ.listAllDrainage();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return daiList;
	}

	@RequestMapping("/saveDrainage")
	public @ResponseBody String saveDrainage(@RequestBody Drainage drainage, HttpServletRequest request) {

		String dai = request.getParameter("id");

		try {

			if (drainage.getDrain_id() == 0) {
				drainage.setLocation(vilServ.findVillageById(Long.parseLong(dai)));
				daiServ.save(drainage);

			} else {
				drainage.setLocation(vilServ.findVillageById(Long.parseLong(dai)));
				daiServ.update(drainage);
			}
		} catch (Exception e) {

			e.printStackTrace();
			return "-1";
		}

		return "1";
	}

	@RequestMapping("/deleteDrainage")
	public @ResponseBody String deleteDrainage(@RequestBody Drainage drainage) {

		try {
			if (drainage.getDrain_id() != 0) {
				daiServ.delete(drainage.getDrain_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findDrainage")
	public @ResponseBody Drainage findDrainage(@RequestBody Drainage drainage) {
		Drainage result = null;
		try {

			result = daiServ.findDrainageById(drainage.getDrain_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/drainage",method=RequestMethod.GET)
	public ModelAndView displayDrainage(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("drainage");
		
		return model;
	}
}
