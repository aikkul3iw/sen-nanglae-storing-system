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
import com.proj.ejb.entity.Personnel;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.ActivityService;
import com.proj.ejb.face.PersonnelService;
import com.proj.ejb.face.UserService;

@Controller
public class PersonnelController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//PersonnelServiceBean!com.proj.ejb.face.PersonnelService")
	PersonnelService perServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ActivityServiceBean!com.proj.ejb.face.ActivityService")
	ActivityService atvServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//UserServiceBean!com.proj.ejb.face.UserService")
	UserService userServ;

	@RequestMapping("/listPersonnel")
	public @ResponseBody List<Personnel> listPersonnel(HttpServletRequest request) {

		List<Personnel> perList = null;
		try {
			perList = perServ.listAllPersonnel();

		} catch (Exception e) {

			e.printStackTrace();
		}

		return perList;
	}

	@RequestMapping("/savePersonnel")
	public @ResponseBody String savePersonnel(@RequestBody Personnel personnel, HttpServletRequest request) {
		try {
			if (personnel.getPer_id() == 0) {
				String id = request.getParameter("user");
				perServ.save(personnel);
				Activity atv = new Activity();
				atv.setUser(userServ.findUserById(Long.parseLong(id)));
				atv.setAtv_date(new Date());
				atv.setAtc_action("เพิ่ม");
				atv.setAtv_data("บุคลากร");
				atvServ.save(atv);
			} else {
				String editid = request.getParameter("editUserId");
				perServ.update(personnel);
				Activity atv2 = new Activity();
				atv2.setUser(userServ.findUserById(Long.parseLong(editid)));
				atv2.setAtv_date(new Date());
				atv2.setAtc_action("แก้ไข");
				atv2.setAtv_data("บุคลากร");
				atvServ.save(atv2);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deletePersonnel")
	public @ResponseBody String deletePersonnel(@RequestBody Personnel personnel) {

		try {
			if (personnel.getPer_id() != 0) {
				perServ.delete(personnel.getPer_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findPersonnel")
	public @ResponseBody Personnel findPersonnel(@RequestBody Personnel personnel) {
		Personnel result = null;
		try {

			result = perServ.findPersonnelById(personnel.getPer_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	@RequestMapping(value="/nonPersonnel",method=RequestMethod.GET)
	public ModelAndView displaynonPersonnel(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		
					ModelAndView model = new ModelAndView("nonPersonnel");
					return model;
		}
	
	@RequestMapping(value="/userPersonnel",method=RequestMethod.GET)
	public ModelAndView displayuserPersonnel(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("userPersonnel");
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
	@RequestMapping(value="/superPersonnel",method=RequestMethod.GET)
	public ModelAndView displaysuperPersonnel(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superPersonnel");
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
