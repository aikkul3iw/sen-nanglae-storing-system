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

import com.proj.ejb.entity.Electricity;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.ElectricityService;
import com.proj.ejb.face.VillageService;

@Controller
public class ElectricityController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ElectricityServiceBean!com.proj.ejb.face.ElectricityService")
	ElectricityService elecServ;

	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;

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
				electricity.setLocation(vilServ.findVillageById(Long.parseLong(elec)));
				elecServ.save(electricity);

			} else {
				electricity.setLocation(vilServ.findVillageById(Long.parseLong(elec)));
				elecServ.update(electricity);
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
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("nonElectric");
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
