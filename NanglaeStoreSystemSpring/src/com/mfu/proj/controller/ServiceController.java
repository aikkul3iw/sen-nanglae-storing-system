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
import com.proj.ejb.entity.Service;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.ActivityService;
import com.proj.ejb.face.ServiceService;
import com.proj.ejb.face.UserService;

@Controller
public class ServiceController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ServiceServiceBean!com.proj.ejb.face.ServiceService")
	ServiceService serServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ActivityServiceBean!com.proj.ejb.face.ActivityService")
	ActivityService atvServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//UserServiceBean!com.proj.ejb.face.UserService")
	UserService userServ;

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
	public @ResponseBody String saveService(@RequestBody Service service, HttpServletRequest request) {

		try {
			if (service.getSer_id() == 0) {
				String id = request.getParameter("user");
				serServ.save(service);
				Activity atv = new Activity();
				atv.setUser(userServ.findUserById(Long.parseLong(id)));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String date = sdf.format(new Date());
				atv.setAtv_date(date);
				atv.setAtv_action("เพิ่ม");
				atv.setAtv_data("ศูนย์บริการประชาชน");
				atvServ.save(atv);

			} else {
				String editid = request.getParameter("editUserId");
				serServ.update(service);
				Activity atv2 = new Activity();
				atv2.setUser(userServ.findUserById(Long.parseLong(editid)));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String date = sdf.format(new Date());
				atv2.setAtv_date(date);
				atv2.setAtv_action("แก้ไข");
				atv2.setAtv_data("ศูนย์บริการประชาชน");
				atvServ.save(atv2);
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
		
					ModelAndView model = new ModelAndView("nonService");
					return model;
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
