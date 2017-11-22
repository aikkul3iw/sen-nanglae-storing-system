package com.mfu.proj.controller;

import java.util.List;

import javax.ejb.EJB;
import javax.security.auth.message.callback.PrivateKeyCallback.Request;
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
import com.proj.ejb.entity.User;
import com.proj.ejb.face.ActivityService;

@Controller
public class ActivityController {
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ActivityServiceBean!com.proj.ejb.face.ActivityService")
	ActivityService atcServ;

	
	@RequestMapping(value="/userActivity",method=RequestMethod.GET)
	public ModelAndView displayuserActivity(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("userActivity");
		
		return model;
	}

	@RequestMapping("/listActivity")
	public @ResponseBody List<Activity> listActivity(HttpServletRequest request) {

		List<Activity> atcList = null;
		try {
			atcList = atcServ.listAllActivity();

		} catch (Exception e) {

			e.printStackTrace();
		}

		return atcList;
	}

	@RequestMapping("/findActivity")
	public @ResponseBody Activity findActivity(@RequestBody Activity Activity) {
		Activity result = null;
		try {

			result = atcServ.findActivityById(Activity.getAtv_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	@RequestMapping(value="/nonActivity",method=RequestMethod.GET)
	public ModelAndView displaynonActivity(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
	
					ModelAndView model = new ModelAndView("nonActivity");
					return model;
		}
	@RequestMapping(value="/superActivity",method=RequestMethod.GET)
	public ModelAndView displaysuperActivity(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superActivity");
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
