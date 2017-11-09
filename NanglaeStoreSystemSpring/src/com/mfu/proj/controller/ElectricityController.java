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
import com.proj.ejb.entity.Electricity;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.ActivityService;
import com.proj.ejb.face.ElectricityService;
import com.proj.ejb.face.UserService;
import com.proj.ejb.face.VillageService;

@Controller
public class ElectricityController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ElectricityServiceBean!com.proj.ejb.face.ElectricityService")
	ElectricityService elecServ;

	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ActivityServiceBean!com.proj.ejb.face.ActivityService")
	ActivityService atvServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//UserServiceBean!com.proj.ejb.face.UserService")
	UserService userServ;

	@RequestMapping("/listElectricity")
	public @ResponseBody List<Electricity> listElectricity(HttpServletRequest request) {

		List<Electricity> elecList = null;
		try {
			elecList = elecServ.listAllElectricity();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return elecList;
	}

	@RequestMapping("/saveElectricity")
	public @ResponseBody String saveElectricity(@RequestBody Electricity electricity, HttpServletRequest request) {

		String elec = request.getParameter("id");

		try {

			if (electricity.getElec_id() == 0) {
				String id = request.getParameter("user");
				electricity.setLocation(vilServ.findVillageById(Long.parseLong(elec)));
				elecServ.save(electricity);
				Activity atv = new Activity();
				atv.setUser(userServ.findUserById(Long.parseLong(id)));
				atv.setAtv_date(new Date());
				atv.setAtc_action("เพิ่ม");
				atv.setAtv_data("ระบบไฟฟ้า");
				atvServ.save(atv);

			} else {
				String editid = request.getParameter("editUserId");
				electricity.setLocation(vilServ.findVillageById(Long.parseLong(elec)));
				elecServ.update(electricity);
				Activity atv2 = new Activity();
				atv2.setUser(userServ.findUserById(Long.parseLong(editid)));
				atv2.setAtv_date(new Date());
				atv2.setAtc_action("แก้ไข");
				atv2.setAtv_data("ระบบไฟฟ้า");
				atvServ.save(atv2);
			}
		} catch (Exception e) {

			e.printStackTrace();
			return "-1";
		}

		return "1";
	}

	@RequestMapping("/deleteElectricity")
	public @ResponseBody String deleteCommerce(@RequestBody Electricity electricity) {

		try {
			if (electricity.getElec_id() != 0) {
				elecServ.delete(electricity.getElec_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findElectricity")
	public @ResponseBody Electricity findElectricity(@RequestBody Electricity electricity) {
		Electricity result = null;
		try {

			result = elecServ.findElectricityById(electricity.getElec_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/userElectric",method=RequestMethod.GET)
	public ModelAndView displayuserElectric(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("userElectric");
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
	@RequestMapping(value="/nonElectric",method=RequestMethod.GET)
	public ModelAndView displaynonElectricity(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		
					ModelAndView model = new ModelAndView("nonElectric");
					return model;
		}
	@RequestMapping(value="/superElectric",method=RequestMethod.GET)
	public ModelAndView displaysuperElectric(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superElectric");
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
