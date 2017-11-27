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
import com.proj.ejb.entity.ElderlyPeople;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.ActivityService;
import com.proj.ejb.face.ElderlyPeopleService;
import com.proj.ejb.face.UserService;

@Controller
public class ElderlyPeopleController {
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ElderlyPeopleServiceBean!com.proj.ejb.face.ElderlyPeopleService")
	ElderlyPeopleService ElderlyPeopleServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ActivityServiceBean!com.proj.ejb.face.ActivityService")
	ActivityService atvServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//UserServiceBean!com.proj.ejb.face.UserService")
	UserService userServ;

	@RequestMapping("/listElderlyPeople")
	public @ResponseBody List<ElderlyPeople> listElderlyPeople(HttpServletRequest request) {

		List<ElderlyPeople> ElderlyPeopleList = null;
		try {
			ElderlyPeopleList = ElderlyPeopleServ.listAllElderlyPeople();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return ElderlyPeopleList;
	}

	@RequestMapping("/saveElderlyPeople")
	public @ResponseBody String saveElderlyPeople(@RequestBody ElderlyPeople ElderlyPeople, HttpServletRequest request) {
		try {
			if (ElderlyPeople.getElderPeId() == 0) {
				ElderlyPeopleServ.save(ElderlyPeople);
				String id = request.getParameter("user");
				Activity atv = new Activity();
				atv.setUser(userServ.findUserById(Long.parseLong(id)));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String date = sdf.format(new Date());
				atv.setAtv_date(date);
				atv.setAtv_action("เพิ่ม");
				atv.setAtv_data("ผู้สูงอายุ");
				atvServ.save(atv);
			} else {
				ElderlyPeopleServ.update(ElderlyPeople);
				String editid = request.getParameter("editUserId");
				Activity atv2 = new Activity();
				atv2.setUser(userServ.findUserById(Long.parseLong(editid)));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String date = sdf.format(new Date());
				atv2.setAtv_date(date);
				atv2.setAtv_action("แก้ไข");
				atv2.setAtv_data("ผู้สูงอายุ");
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

	@RequestMapping("/deleteElderlyPeople")
	public @ResponseBody String deleteElderlyPeople(@RequestBody ElderlyPeople ElderlyPeople) {

		try {
			if (ElderlyPeople.getElderPeId() != 0) {
				ElderlyPeopleServ.delete(ElderlyPeople.getElderPeId());
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findElderlyPeople")
	public @ResponseBody ElderlyPeople findElderlyPeople(@RequestBody ElderlyPeople ElderlyPeople) {
		ElderlyPeople result = null;
		try {

			result = ElderlyPeopleServ.findElderlyPeopleById(ElderlyPeople.getElderPeId());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}

	@RequestMapping(value = "/userElderlyPeople", method = RequestMethod.GET)
	public ModelAndView displayuserElderlyPeople(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		String getsession = "" + session.getAttribute("session");
		System.out.println("getdatasession " + getsession);

		if (!getsession.equals("null")) {
			ModelAndView model = new ModelAndView("userElderlyPeople");
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

	@RequestMapping(value = "/nonElderlyPeople", method = RequestMethod.GET)
	public ModelAndView displaynonElderlyPeople(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {

		
			ModelAndView model = new ModelAndView("nonElderlyPeople");
			
			return model;

		}
	

	@RequestMapping(value = "/superElderlyPeople", method = RequestMethod.GET)
	public ModelAndView displaysuperElderlyPeople(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		String getsession = "" + session.getAttribute("session");
		System.out.println("getdatasession " + getsession);

		if (!getsession.equals("null")) {
			ModelAndView model = new ModelAndView("superElderlyPeople");
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

	@RequestMapping(value = "/userCopyElderlyPeople", method = RequestMethod.GET)
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

	@RequestMapping(value = "/superCopyElderlyPeople", method = RequestMethod.GET)
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
