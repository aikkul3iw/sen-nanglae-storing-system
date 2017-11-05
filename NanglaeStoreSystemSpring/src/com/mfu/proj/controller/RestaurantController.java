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

import com.proj.ejb.entity.Restaurant;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.RestaurantService;
import com.proj.ejb.face.VillageService;

@Controller
public class RestaurantController {
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//RestaurantServiceBean!com.proj.ejb.face.RestaurantService")
	RestaurantService RestaurantServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;

	@RequestMapping("/listRestaurant")
	public @ResponseBody List<Restaurant> listRestaurant(HttpServletRequest request) {

		List<Restaurant> RestaurantList = null;
		try {
			RestaurantList = RestaurantServ.listAllRestaurant();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return RestaurantList;
	}

	@RequestMapping("/saveRestaurant")
	public @ResponseBody String saveRestaurant(@RequestBody Restaurant Restaurant, HttpServletRequest request) {
		String res = request.getParameter("id");
		
		try {
			if (Restaurant.getRestaurantId() == 0) {
				Restaurant.setLocation(vilServ.findVillageById(Long.parseLong(res)));
				RestaurantServ.save(Restaurant);
			} else {
				Restaurant.setLocation(vilServ.findVillageById(Long.parseLong(res)));
				RestaurantServ.update(Restaurant);
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

	@RequestMapping("/deleteRestaurant")
	public @ResponseBody String deleteRestaurant(@RequestBody Restaurant Restaurant) {

		try {
			if (Restaurant.getRestaurantId() != 0) {
				RestaurantServ.delete(Restaurant.getRestaurantId());
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findRestaurant")
	public @ResponseBody Restaurant findRestaurant(@RequestBody Restaurant Restaurant) {
		Restaurant result = null;
		try {

			result = RestaurantServ.findRestaurantById(Restaurant.getRestaurantId());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}

	@RequestMapping(value = "/userRestaurant", method = RequestMethod.GET)
	public ModelAndView displayuserRestaurant(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		String getsession = "" + session.getAttribute("session");
		System.out.println("getdatasession " + getsession);

		if (!getsession.equals("null")) {
			ModelAndView model = new ModelAndView("userRestaurant");
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

	@RequestMapping(value = "/nonRestaurant", method = RequestMethod.GET)
	public ModelAndView displaynonRestaurant(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {

		
			ModelAndView model = new ModelAndView("nonRestaurant");
			
			return model;

		}
	

	@RequestMapping(value = "/superRestaurant", method = RequestMethod.GET)
	public ModelAndView displaysuperRestaurant(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		String getsession = "" + session.getAttribute("session");
		System.out.println("getdatasession " + getsession);

		if (!getsession.equals("null")) {
			ModelAndView model = new ModelAndView("superRestaurant");
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

	@RequestMapping(value = "/userCopyRestaurant", method = RequestMethod.GET)
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

	@RequestMapping(value = "/superCopyRestaurant", method = RequestMethod.GET)
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
