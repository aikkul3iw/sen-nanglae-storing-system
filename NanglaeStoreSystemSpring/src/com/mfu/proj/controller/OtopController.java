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
import com.proj.ejb.entity.Otop;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.ActivityService;
import com.proj.ejb.face.OtopService;
import com.proj.ejb.face.UserService;

@Controller
public class OtopController {
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//OtopServiceBean!com.proj.ejb.face.OtopService")
	OtopService otopServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ActivityServiceBean!com.proj.ejb.face.ActivityService")
	ActivityService atvServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//UserServiceBean!com.proj.ejb.face.UserService")
	UserService userServ;

	@RequestMapping("/listOtop")
	public @ResponseBody List<Otop> listOtop(HttpServletRequest request) {

		List<Otop> otopList = null;
		try {
			otopList = otopServ.listAllOtop();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return otopList;
	}

	@RequestMapping("/saveOtop")
	public @ResponseBody String saveOtop(@RequestBody Otop Otop, HttpServletRequest request) {
		try {
			if (Otop.getOtopId() == 0) {
				String id = request.getParameter("user");
				otopServ.save(Otop);
				Activity atv = new Activity();
				atv.setUser(userServ.findUserById(Long.parseLong(id)));
				atv.setAtv_date(new Date());
				atv.setAtc_action("เพิ่ม");
				atv.setAtv_data("Otop");
				atvServ.save(atv);
			} else {
				String editid = request.getParameter("editUserId");
				otopServ.update(Otop);
				Activity atv2 = new Activity();
				atv2.setUser(userServ.findUserById(Long.parseLong(editid)));
				atv2.setAtv_date(new Date());
				atv2.setAtc_action("แก้ไข");
				atv2.setAtv_data("Otop");
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

	@RequestMapping("/deleteOtop")
	public @ResponseBody String deleteOtop(@RequestBody Otop Otop) {

		try {
			if (Otop.getOtopId() != 0) {
				otopServ.delete(Otop.getOtopId());
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findOtop")
	public @ResponseBody Otop findOtop(@RequestBody Otop Otop) {
		Otop result = null;
		try {

			result = otopServ.findOtopById(Otop.getOtopId());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}

	@RequestMapping(value = "/userOtop", method = RequestMethod.GET)
	public ModelAndView displayuserOtop(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		String getsession = "" + session.getAttribute("session");
		System.out.println("getdatasession " + getsession);

		if (!getsession.equals("null")) {
			ModelAndView model = new ModelAndView("userOtop");
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

	@RequestMapping(value = "/nonOtop", method = RequestMethod.GET)
	public ModelAndView displaynonOtop(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {

		
			ModelAndView model = new ModelAndView("nonOtop");
			
			return model;

		}
	

	@RequestMapping(value = "/superOtop", method = RequestMethod.GET)
	public ModelAndView displaysuperOtop(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		String getsession = "" + session.getAttribute("session");
		System.out.println("getdatasession " + getsession);

		if (!getsession.equals("null")) {
			ModelAndView model = new ModelAndView("superOtop");
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

	@RequestMapping(value = "/userCopyOtop", method = RequestMethod.GET)
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

	@RequestMapping(value = "/superCopyOtop", method = RequestMethod.GET)
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
