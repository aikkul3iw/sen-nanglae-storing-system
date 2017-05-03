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

import com.proj.ejb.entity.Polution;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.PolutionService;

@Controller
public class PolutionController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//PolutionServiceBean!com.proj.ejb.face.PolutionService")
	PolutionService agrServ;

	@RequestMapping("/listPolution")
	public @ResponseBody List<Polution> listPolution(HttpServletRequest request) {

		List<Polution> agrList = null;
		try {
			agrList = agrServ.listAllPolution();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return agrList;
	}

	@RequestMapping("/savePolution")
	public @ResponseBody String savePolution(@RequestBody Polution Polution) {
		try {
			if (Polution.getPol_id() == 0) {
				agrServ.save(Polution);
			} else {
				agrServ.update(Polution);
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

	@RequestMapping("/deletePolution")
	public @ResponseBody String deletePolution(@RequestBody Polution Polution) {

		try {
			if (Polution.getPol_id() != 0) {
				agrServ.delete(Polution.getPol_id());
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findPolution")
	public @ResponseBody Polution findPolution(@RequestBody Polution Polution) {
		Polution result = null;
		try {

			result = agrServ.findPolutionById(Polution.getPol_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/userPolution",method=RequestMethod.GET)
	public ModelAndView displayuserPolution(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("userPolution");
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
	@RequestMapping(value="/nonPolution",method=RequestMethod.GET)
	public ModelAndView displaynonPolution(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		
					ModelAndView model = new ModelAndView("nonPolution");
					return model;
		}
	@RequestMapping(value="/superPolution",method=RequestMethod.GET)
	public ModelAndView displaysuperPolution(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superPolution");
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
