package com.mfu.proj.controller;

import java.util.List;

import javax.ejb.EJB;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.proj.ejb.entity.LandResource;
import com.proj.ejb.entity.User;
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
	
	@RequestMapping(value="/userLandresource",method=RequestMethod.GET)
	public ModelAndView displayuserLandresource(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("userLandresource");
					User loginBean = new User();
					model.addObject("loginBean", loginBean);
					return model;
				}else{
					
					System.out.println("Hello World 2");
					ModelAndView model = new ModelAndView("loginUser");
					User loginBean = new User();
					model.addObject("loginBean", loginBean);
					return model;	
				}
		}
	@RequestMapping(value="/nonLandresource",method=RequestMethod.GET)
	public ModelAndView displaynonLandResource(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		
					ModelAndView model = new ModelAndView("nonLandresource");
					return model;
		}
	@RequestMapping(value="/superLandresource",method=RequestMethod.GET)
	public ModelAndView displaysuperLandresource(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superLandresource");
					User loginBean = new User();
					model.addObject("loginBean", loginBean);
					return model;
				}else{
					
					System.out.println("Hello World 2");
					ModelAndView model = new ModelAndView("loginUser");
					User loginBean = new User();
					model.addObject("loginBean", loginBean);
					return model;	
				}
		}
}
