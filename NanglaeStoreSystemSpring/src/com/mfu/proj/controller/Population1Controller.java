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

import com.proj.ejb.entity.Population1;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.Population1Service;
import com.proj.ejb.face.VillageService;

@Controller
public class Population1Controller {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//Population1ServiceBean!com.proj.ejb.face.Population1Service")
	Population1Service pop1Serv;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;

	@RequestMapping("/listPopulation1")
	public @ResponseBody List<Population1> listPopulation1(HttpServletRequest request) {

		List<Population1> pop1List = null;
		try {
			pop1List = pop1Serv.listAllPopulation1();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return pop1List;
	}

	@RequestMapping("/savePopulation1")
	public @ResponseBody String savePopulation1(@RequestBody Population1 population1, HttpServletRequest request) {
		String pop = request.getParameter("id");
		try {
			if (population1.getPop_id() == 0) {
				population1.setLocation(vilServ.findVillageById(Long.parseLong(pop)));
				pop1Serv.save(population1);

			} else {
				population1.setLocation(vilServ.findVillageById(Long.parseLong(pop)));
				pop1Serv.update(population1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deletePopulation1")
	public @ResponseBody String deletePopulation1(@RequestBody Population1 population1) {

		try {
			if (population1.getPop_id() != 0) {
				pop1Serv.delete(population1.getPop_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findPopulation1")
	public @ResponseBody Population1 findPopulation1(@RequestBody Population1 population1) {
		Population1 result = null;
		try {

			result = pop1Serv.findPopulation1ById(population1.getPop_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/userPopulation",method=RequestMethod.GET)
	public ModelAndView displayuserPopulation(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("userPopulation");
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
	@RequestMapping(value="/nonPopulation",method=RequestMethod.GET)
	public ModelAndView displaynonPopulation(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		
					ModelAndView model = new ModelAndView("nonPopulation");
					return model;
		}
	@RequestMapping(value="/superPopulation",method=RequestMethod.GET)
	public ModelAndView displaysuperPopulation(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superPopulation");
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
