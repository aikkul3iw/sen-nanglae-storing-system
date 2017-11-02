package com.mfu.proj.controller;

import java.util.Date;
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
import com.proj.ejb.entity.Village;
import com.proj.ejb.face.ActivityService;
import com.proj.ejb.face.UserService;
import com.proj.ejb.face.VillageService;

@Controller
public class VillageController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ActivityServiceBean!com.proj.ejb.face.ActivityService")
	ActivityService atvServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//UserServiceBean!com.proj.ejb.face.UserService")
	UserService userServ;
	
	@RequestMapping(value="/userVillage",method=RequestMethod.GET)
	public ModelAndView displayuserVillage(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("userVillage");
		
		return model;
	}

	@RequestMapping("/listVillage")
	public @ResponseBody List<Village> listVillage(HttpServletRequest request) {

		List<Village> vilList = null;
		try {
			vilList = vilServ.listAllVillage();

		} catch (Exception e) {

			e.printStackTrace();
		}

		return vilList;
	}

	@RequestMapping("/saveVillage")
	public @ResponseBody String saveVillage(@RequestBody Village village, HttpServletRequest request) {
		try {
			
			if (village.getVil_id() == 0) {
				String id = request.getParameter("user");
				vilServ.save(village);
				
				Activity atv = new Activity();
				atv.setUser(userServ.findUserById(Long.parseLong(id)));
				atv.setAtv_date(new Date());
				atv.setAtc_action("เพิ่ม");
				atv.setAtv_data("หมู่บ้าน");
				atvServ.save(atv);

			} else {
				String editid = request.getParameter("editUserId");
				vilServ.update(village);
				
				Activity atv2 = new Activity();
				atv2.setUser(userServ.findUserById(Long.parseLong(editid)));
				atv2.setAtv_date(new Date());
				atv2.setAtc_action("แก้ไข");
				atv2.setAtv_data("หมู่บ้าน");
				atvServ.save(atv2);
			}
		} catch (Exception e) {

			e.printStackTrace();
			return "-1";
		}

		return "1";
	}

	@RequestMapping("/deleteVillage")
	public @ResponseBody String deleteVillage(@RequestBody Village village) {

		try {
			if (village.getVil_id() != 0) {
				vilServ.delete(village.getVil_id());
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findVillage")
	public @ResponseBody Village findVillage(@RequestBody Village village) {
		Village result = null;
		try {

			result = vilServ.findVillageById(village.getVil_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	@RequestMapping(value="/nonVillage",method=RequestMethod.GET)
	public ModelAndView displaynonVillage(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
	
					ModelAndView model = new ModelAndView("nonVillage");
					return model;
		}
	@RequestMapping(value="/superVillage",method=RequestMethod.GET)
	public ModelAndView displaysuperVillage(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superVillage");
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
