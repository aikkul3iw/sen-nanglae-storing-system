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

import com.proj.ejb.entity.ElderlyPeople;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.ElderlyPeopleService;

@Controller
public class ElderlyPeopleController {
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ElderlyPeopleServiceBean!com.proj.ejb.face.ElderlyPeopleService")
	ElderlyPeopleService ElderlyPeopleServ;

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
	public @ResponseBody String saveElderlyPeople(@RequestBody ElderlyPeople ElderlyPeople) {
		try {
			if (ElderlyPeople.getElderPeId() == 0) {
				ElderlyPeopleServ.save(ElderlyPeople);
			} else {
				ElderlyPeopleServ.update(ElderlyPeople);
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
