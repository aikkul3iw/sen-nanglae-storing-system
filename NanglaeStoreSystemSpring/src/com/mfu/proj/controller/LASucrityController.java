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

import com.proj.ejb.entity.LASucrity;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.LASucrityService;

@Controller
public class LASucrityController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//LASucrityServiceBean!com.proj.ejb.face.LASucrityService")
	LASucrityService secServ;


	@RequestMapping("/listLASucrity")
	public @ResponseBody List<LASucrity> listLASucrity(HttpServletRequest request) {

		List<LASucrity> secList = null;
		try {
			secList = secServ.listAllLASucrity();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return secList;
	}

	@RequestMapping("/saveLASucrity")
	public @ResponseBody String saveLASucrity(@RequestBody LASucrity LASucrity) {
		try {
			if (LASucrity.getSec_id() == 0) {
				secServ.save(LASucrity);

			} else {
				secServ.update(LASucrity);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteLASucrity")
	public @ResponseBody String deleteLASucrity(@RequestBody LASucrity LASucrity) {

		try {
			if (LASucrity.getSec_id() != 0) {
				secServ.delete(LASucrity.getSec_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findLASucrity")
	public @ResponseBody LASucrity findLASucrity(@RequestBody LASucrity LASucrity) {
		LASucrity result = null;
		try {

			result = secServ.findLASucrityById(LASucrity.getSec_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/userSecurity",method=RequestMethod.GET)
	public ModelAndView displayuserSecurity(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("userSecurity");
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
	@RequestMapping(value="/nonSecurity",method=RequestMethod.GET)
	public ModelAndView displaynonSecurity(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		
					ModelAndView model = new ModelAndView("nonSecurity");
					return model;
		}
	@RequestMapping(value="/superSecurity",method=RequestMethod.GET)
	public ModelAndView displaysuperSecurity(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superSecurity");
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
