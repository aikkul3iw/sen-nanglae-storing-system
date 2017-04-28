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

import com.proj.ejb.entity.LandResource;
import com.proj.ejb.face.LandResourceService;

@Controller
public class LandResourceController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//LandResourceServiceBean!com.proj.ejb.face.LandResourceService")
	LandResourceService agrServ;

	@RequestMapping("/listLandResource")
	public @ResponseBody List<LandResource> listLandResource(HttpServletRequest request) {

		List<LandResource> agrList = null;
		try {
			agrList = agrServ.listAllLandResource();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return agrList;
	}

	@RequestMapping("/saveLandResource")
	public @ResponseBody String saveLandResource(@RequestBody LandResource LandResource) {
		try {
			if (LandResource.getLand_id() == 0) {
				agrServ.save(LandResource);
			} else {
				agrServ.update(LandResource);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "-1";
		}
		// 1 = sucess
		// -1 = failure
		return "1";
	}

	@RequestMapping("/deleteLandResource")
	public @ResponseBody String deleteLandResource(@RequestBody LandResource LandResource) {

		try {
			if (LandResource.getLand_id() != 0) {
				agrServ.delete(LandResource.getLand_id());
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findLandResource")
	public @ResponseBody LandResource findLandResource(@RequestBody LandResource LandResource) {
		LandResource result = null;
		try {

			result = agrServ.findLandResourceById(LandResource.getLand_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/landresource",method=RequestMethod.GET)
	public ModelAndView displayLandResource(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("landresource");
		
		return model;
	}
	@RequestMapping(value="/nonLandresource",method=RequestMethod.GET)
	public ModelAndView displaynonLandResource(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("nonLandresource");
		
		return model;
	}
}
