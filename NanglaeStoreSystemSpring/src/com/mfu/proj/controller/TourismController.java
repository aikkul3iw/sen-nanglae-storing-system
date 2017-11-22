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
import com.proj.ejb.entity.Tourism;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.ActivityService;
import com.proj.ejb.face.TourismService;
import com.proj.ejb.face.UserService;
import com.proj.ejb.face.VillageService;

@Controller
public class TourismController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//TourismServiceBean!com.proj.ejb.face.TourismService")
	TourismService tourServ;

	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ActivityServiceBean!com.proj.ejb.face.ActivityService")
	ActivityService atvServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//UserServiceBean!com.proj.ejb.face.UserService")
	UserService userServ;

	@RequestMapping("/listTourism")
	public @ResponseBody List<Tourism> listTourism(HttpServletRequest request) {

		List<Tourism> tourList = null;
		try {
			tourList = tourServ.listAllTourism();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return tourList;
	}

	@RequestMapping("/saveTourism")
	public @ResponseBody String saveTourism(@RequestBody Tourism tourism, HttpServletRequest request) {
		String tour = request.getParameter("id");
		try {
			if (tourism.getTour_id() == 0) {
				String id = request.getParameter("user");
				tourism.setLocation(vilServ.findVillageById(Long.parseLong(tour)));
				tourServ.save(tourism);
				Activity atv = new Activity();
				atv.setUser(userServ.findUserById(Long.parseLong(id)));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String date = sdf.format(new Date());
				atv.setAtv_date(date);
				atv.setAtv_action("เพิ่ม");
				atv.setAtv_data("แหล่งท่องเที่ยว");
				atvServ.save(atv);

			} else {
				String editid = request.getParameter("editUserId");
				tourism.setLocation(vilServ.findVillageById(Long.parseLong(tour)));
				tourServ.update(tourism);
				Activity atv2 = new Activity();
				atv2.setUser(userServ.findUserById(Long.parseLong(editid)));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String date = sdf.format(new Date());
				atv2.setAtv_date(date);
				atv2.setAtv_action("แก้ไข");
				atv2.setAtv_data("แหล่งท่องเที่ยว");
				atvServ.save(atv2);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteTourism")
	public @ResponseBody String deleteTourism(@RequestBody Tourism tourism) {

		try {
			if (tourism.getTour_id() != 0) {
				tourServ.delete(tourism.getTour_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findTourism")
	public @ResponseBody Tourism findTourism(@RequestBody Tourism tourism) {
		Tourism result = null;
		try {

			result = tourServ.findTourismById(tourism.getTour_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/userTourism",method=RequestMethod.GET)
	public ModelAndView displayuserTourism(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("userTourism");
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
	@RequestMapping(value="/nonTourism",method=RequestMethod.GET)
	public ModelAndView displaynonTourism(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
	
					ModelAndView model = new ModelAndView("nonTourism");
					return model;
		}
	@RequestMapping(value="/superTourism",method=RequestMethod.GET)
	public ModelAndView displaysuperTourism(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superTourism");
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
