package com.mfu.proj.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
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

import com.proj.ejb.entity.Activity;
import com.proj.ejb.entity.Drainage;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.ActivityService;
import com.proj.ejb.face.DrainageService;
import com.proj.ejb.face.UserService;
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
	
	@RequestMapping(value="/userDrainage",method=RequestMethod.GET)
	public ModelAndView displayuserDrainage(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("userDrainage");
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
	@RequestMapping(value="/nonDrainage",method=RequestMethod.GET)
	public ModelAndView displaynonDrainage(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		
					ModelAndView model = new ModelAndView("nonDrainage");
					
					return model;
				
		}
	@RequestMapping(value="/superDrainage",method=RequestMethod.GET)
	public ModelAndView displaysuperDrainage(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superDrainage");
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
