package com.mfu.proj.controller;

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
import com.proj.ejb.entity.Commerce;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.ActivityService;
import com.proj.ejb.face.CommerceService;
import com.proj.ejb.face.UserService;
import com.proj.ejb.face.VillageService;

@Controller
public class CommerceController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//CommerceServiceBean!com.proj.ejb.face.CommerceService")
	CommerceService comServ;

	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ActivityServiceBean!com.proj.ejb.face.ActivityService")
	ActivityService atvServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//UserServiceBean!com.proj.ejb.face.UserService")
	UserService userServ;

	@RequestMapping("/listCommerce")
	public @ResponseBody List<Commerce> listCommerce(HttpServletRequest request) {

		List<Commerce> comList = null;
		try {
			comList = comServ.listAllCommerce();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return comList;
	}

	@RequestMapping("/saveCommerce")
	public @ResponseBody String saveCommerce(@RequestBody Commerce commerce, HttpServletRequest request) {
		String mer = request.getParameter("id");
		try {
			if (commerce.getCom_id() == 0) {
				String id = request.getParameter("user");
				commerce.setLocation(vilServ.findVillageById(Long.parseLong(mer)));
				comServ.save(commerce);
				Activity atv = new Activity();
				atv.setUser(userServ.findUserById(Long.parseLong(id)));
				atv.setAtv_date(new Date());
				atv.setAtc_action("เพิ่ม");
				atv.setAtv_data("การพาณิชย์");
				atvServ.save(atv);

			} else {
				String editid = request.getParameter("editUserId");
				commerce.setLocation(vilServ.findVillageById(Long.parseLong(mer)));
				comServ.update(commerce);
				Activity atv2 = new Activity();
				atv2.setUser(userServ.findUserById(Long.parseLong(editid)));
				atv2.setAtv_date(new Date());
				atv2.setAtc_action("แก้ไข");
				atv2.setAtv_data("การพาณิชย์");
				atvServ.save(atv2);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteCommerce")
	public @ResponseBody String deleteCommerce(@RequestBody Commerce commerce) {

		try {
			if (commerce.getCom_id() != 0) {
				comServ.delete(commerce.getCom_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findCommerce")
	public @ResponseBody Commerce findCommerce(@RequestBody Commerce commerce) {
		Commerce result = null;
		try {

			result = comServ.findCommerceById(commerce.getCom_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/userCommerce",method=RequestMethod.GET)
	public ModelAndView displayuserCommerce(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("userCommerce");
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
	@RequestMapping(value="/nonCommerce",method=RequestMethod.GET)
	public ModelAndView displaynonCommerce(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		
					ModelAndView model = new ModelAndView("nonCommerce");
					
					return model;
				
		}
	@RequestMapping(value="/superCommerce",method=RequestMethod.GET)
	public ModelAndView displaysuperCommerce(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superCommerce");
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
