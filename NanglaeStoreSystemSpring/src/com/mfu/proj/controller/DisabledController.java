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

import com.proj.ejb.entity.Disabled;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.DisabledService;

@Controller
public class DisabledController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//DisabledServiceBean!com.proj.ejb.face.DisabledService")
	DisabledService disServ;

	@RequestMapping("/listDisabled")
	public @ResponseBody List<Disabled> listDisabled(HttpServletRequest request) {

		List<Disabled> disList = null;
		try {
			disList = disServ.listAllDisabled();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return disList;
	}

	@RequestMapping("/saveDisabled")
	public @ResponseBody String saveDisabled(@RequestBody Disabled Disabled) {
		try {
			if (Disabled.getDisabledId() == 0) {
				disServ.save(Disabled);
			} else {
				disServ.update(Disabled);
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

	@RequestMapping("/deleteDisabled")
	public @ResponseBody String deleteDisabled(@RequestBody Disabled Disabled) {

		try {
			if (Disabled.getDisabledId() != 0) {
				disServ.delete(Disabled.getDisabledId());
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findDisabled")
	public @ResponseBody Disabled findDisabled(@RequestBody Disabled Disabled) {
		Disabled result = null;
		try {

			result = disServ.findDisabledById(Disabled.getDisabledId());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}

	@RequestMapping(value = "/userDisabled", method = RequestMethod.GET)
	public ModelAndView displayuserDisabled(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		String getsession = "" + session.getAttribute("session");
		System.out.println("getdatasession " + getsession);

		if (!getsession.equals("null")) {
			ModelAndView model = new ModelAndView("userDisabled");
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

	@RequestMapping(value = "/nonDisabled", method = RequestMethod.GET)
	public ModelAndView displaynonDisabled(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {

		ModelAndView model = new ModelAndView("nonDisabled");

		return model;

	}

	@RequestMapping(value = "/superDisabled", method = RequestMethod.GET)
	public ModelAndView displaysuperDisabled(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		String getsession = "" + session.getAttribute("session");
		System.out.println("getdatasession " + getsession);

		if (!getsession.equals("null")) {
			ModelAndView model = new ModelAndView("superDisabled");
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

	@RequestMapping(value = "/userCopyDisabled", method = RequestMethod.GET)
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

	@RequestMapping(value = "/superCopyDisabled", method = RequestMethod.GET)
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
