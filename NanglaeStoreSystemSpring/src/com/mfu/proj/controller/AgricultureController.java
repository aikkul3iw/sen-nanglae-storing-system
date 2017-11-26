package com.mfu.proj.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
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
import com.proj.ejb.entity.Agriculture;
import com.proj.ejb.entity.User;
import com.proj.ejb.entity.Village;
import com.proj.ejb.face.ActivityService;
import com.proj.ejb.face.AgricultureService;
import com.proj.ejb.face.UserService;

@Controller
public class AgricultureController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//AgricultureServiceBean!com.proj.ejb.face.AgricultureService")
	AgricultureService agrServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ActivityServiceBean!com.proj.ejb.face.ActivityService")
	ActivityService atvServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//UserServiceBean!com.proj.ejb.face.UserService")
	UserService userServ;

	@RequestMapping("/listAgriculture")
	public @ResponseBody List<Agriculture> listAgriculture(HttpServletRequest request) {

		List<Agriculture> agrList = null;
		try {
			agrList = agrServ.listAllAgriculture();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return agrList;
	}

	@RequestMapping("/saveAgriculture")
	public @ResponseBody String saveAgriculture(@RequestBody Agriculture agriculture, HttpServletRequest request) {
		try {
			if (agriculture.getAgi_id() == 0) {
				String logStringNew = agriculture.getAgi_name()+", "+agriculture.getAgi_area()+", "+agriculture.getAgi_description();
				String id = request.getParameter("user");
				agrServ.save(agriculture);
				Activity atv = new Activity();
				atv.setUser(userServ.findUserById(Long.parseLong(id)));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String date = sdf.format(new Date());
				atv.setAtv_date(date);
				atv.setAtv_action("เพิ่ม");
				atv.setAtv_data("การเกษตรกรรม");
				atv.setAtv_old("-");
				atv.setAtv_new(logStringNew);
				atvServ.save(atv);
			} else {
				String editid = request.getParameter("editUserId");
				Agriculture agrOld = agrServ.findAgricultureById(agriculture.getAgi_id());
				String logStringOld = agrOld.getAgi_name()+", "+agrOld.getAgi_area()+", "+agrOld.getAgi_description();
				String logStringNew = agriculture.getAgi_name()+", "+agriculture.getAgi_area()+", "+agriculture.getAgi_description();
				agrServ.update(agriculture);
				Activity atv2 = new Activity();
				atv2.setUser(userServ.findUserById(Long.parseLong(editid)));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String date = sdf.format(new Date());
				atv2.setAtv_date(date);
				atv2.setAtv_action("แก้ไข");
				atv2.setAtv_data("การเกษตรกรรม");
				atv2.setAtv_old(logStringOld);
				atv2.setAtv_new(logStringNew);
				atvServ.save(atv2);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "-1";
		}
		// 1 = sucess
		// -1 = failure
		return "1";
	}

	@RequestMapping("/deleteAgriculture")
	public @ResponseBody String deleteAgriculture(@RequestBody Agriculture agriculture, HttpServletRequest request) {

		try {
			String id = request.getParameter("userdelete");
			if (agriculture.getAgi_id() != 0) {
				Agriculture agrOld = agrServ.findAgricultureById(agriculture.getAgi_id());
				String logStringOld = agrOld.getAgi_name()+", "+agrOld.getAgi_area()+", "+agrOld.getAgi_description();
				agrServ.delete(agriculture.getAgi_id());
				Activity atv3 = new Activity();
				atv3.setUser(userServ.findUserById(Long.parseLong(id)));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String date = sdf.format(new Date());
				atv3.setAtv_date(date);
				atv3.setAtv_action("ลบ");
				atv3.setAtv_data("การเกษตรกรรม");
				atv3.setAtv_old(logStringOld);
				atv3.setAtv_new("-");
				atvServ.save(atv3);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findAgriculture")
	public @ResponseBody Agriculture findAgriculture(@RequestBody Agriculture agriculture) {
		Agriculture result = null;
		try {

			result = agrServ.findAgricultureById(agriculture.getAgi_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}

	@RequestMapping(value = "/userAgriculture", method = RequestMethod.GET)
	public ModelAndView displayuserAgriculture(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		String getsession = "" + session.getAttribute("session");
		System.out.println("getdatasession " + getsession);

		if (!getsession.equals("null")) {
			ModelAndView model = new ModelAndView("userAgriculture");
			User loginBean = new User();
			model.addObject("loginBean", loginBean);
			return model;
		} else {

			System.out.println("Hello World 2");
			ModelAndView model = new ModelAndView("loginUser");
			User loginBean = new User();
			model.addObject("loginBean", loginBean);
			return model;
		}
	}

	@RequestMapping(value = "/nonAgriculture", method = RequestMethod.GET)
	public ModelAndView displaynonAgriculture(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {

		
			ModelAndView model = new ModelAndView("nonAgriculture");
			
			return model;

		}
	

	@RequestMapping(value = "/superAgriculture", method = RequestMethod.GET)
	public ModelAndView displaysuperAgriculture(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		String getsession = "" + session.getAttribute("session");
		System.out.println("getdatasession " + getsession);

		if (!getsession.equals("null")) {
			ModelAndView model = new ModelAndView("superAgriculture");
			User loginBean = new User();
			model.addObject("loginBean", loginBean);
			return model;
		} else {

			System.out.println("Hello World 2");
			ModelAndView model = new ModelAndView("loginUser");
			User loginBean = new User();
			model.addObject("loginBean", loginBean);
			return model;
		}
	}

	@RequestMapping(value = "/userCopy", method = RequestMethod.GET)
	public ModelAndView displayuserCopy(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String getsession = "" + session.getAttribute("session");
		System.out.println("getdatasession " + getsession);

		if (!getsession.equals("null")) {
			ModelAndView model = new ModelAndView("userCopy");
			User loginBean = new User();
			model.addObject("loginBean", loginBean);
			return model;
		} else {

			System.out.println("Hello World 2");
			ModelAndView model = new ModelAndView("loginUser");
			User loginBean = new User();
			model.addObject("loginBean", loginBean);
			return model;
		}
	}

	@RequestMapping(value = "/superCopy", method = RequestMethod.GET)
	public ModelAndView displaysuperCopy(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		String getsession = "" + session.getAttribute("session");
		System.out.println("getdatasession " + getsession);

		if (!getsession.equals("null")) {
			ModelAndView model = new ModelAndView("superCopy");
			User loginBean = new User();
			model.addObject("loginBean", loginBean);
			return model;
		} else {

			System.out.println("Hello World 2");
			ModelAndView model = new ModelAndView("loginUser");
			User loginBean = new User();
			model.addObject("loginBean", loginBean);
			return model;
		}
	}

}
