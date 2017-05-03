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

import com.proj.ejb.entity.Service;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.ServiceService;

@Controller
public class ServiceController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ServiceServiceBean!com.proj.ejb.face.ServiceService")
	ServiceService serServ;

	@RequestMapping("/listService")
	public @ResponseBody List<Service> listService(HttpServletRequest request) {

		List<Service> serList = null;
		try {
			serList = serServ.listAllService();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return serList;
	}

	@RequestMapping("/saveService")
	public @ResponseBody String saveService(@RequestBody Service service) {

		try {
			if (service.getSer_id() == 0) {
				serServ.save(service);

			} else {
				serServ.update(service);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteService")
	public @ResponseBody String deleteService(@RequestBody Service service) {

		try {
			if (service.getSer_id() != 0) {
				serServ.delete(service.getSer_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findService")
	public @ResponseBody Service findService(@RequestBody Service service) {
		Service result = null;
		try {

			result = serServ.findServiceById(service.getSer_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/userService",method=RequestMethod.GET)
	public ModelAndView displayuserService(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("userService");
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
	@RequestMapping(value="/nonService",method=RequestMethod.GET)
	public ModelAndView displaynonService(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("nonService");
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
	@RequestMapping(value="/superService",method=RequestMethod.GET)
	public ModelAndView displaysuperService(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superService");
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
