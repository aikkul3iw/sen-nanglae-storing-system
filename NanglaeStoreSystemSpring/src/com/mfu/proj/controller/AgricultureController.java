package com.mfu.proj.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
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

import com.proj.ejb.entity.Agriculture;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.AgricultureService;

@Controller
public class AgricultureController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//AgricultureServiceBean!com.proj.ejb.face.AgricultureService")
	AgricultureService agrServ;

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
	public @ResponseBody String saveAgriculture(@RequestBody Agriculture agriculture) {
		try {
			if (agriculture.getAgi_id() == 0) {
				agrServ.save(agriculture);
			} else {
				agrServ.update(agriculture);
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
	public @ResponseBody String deleteAgriculture(@RequestBody Agriculture agriculture) {

		try {
			if (agriculture.getAgi_id() != 0) {
				agrServ.delete(agriculture.getAgi_id());
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
		String getsession = "" + session.getAttribute("session");
		System.out.println("getdatasession " + getsession);

		if (!getsession.equals("null")) {
			ModelAndView model = new ModelAndView("nonAgriculture");
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
