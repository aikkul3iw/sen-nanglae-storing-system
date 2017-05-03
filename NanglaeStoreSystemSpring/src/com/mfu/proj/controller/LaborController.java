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

import com.proj.ejb.entity.Labor;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.LaborService;

@Controller
public class LaborController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//LaborServiceBean!com.proj.ejb.face.LaborService")
	LaborService labServ;

	@RequestMapping("/listLabor")
	public @ResponseBody List<Labor> listLabor(HttpServletRequest request) {

		List<Labor> labList = null;
		try {
			labList = labServ.listAllLabor();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return labList;
	}

	@RequestMapping("/saveLabor")
	public @ResponseBody String saveLabor(@RequestBody Labor labor) {
		try {
			if (labor.getLab_id() == 0) {
				labServ.save(labor);

			} else {
				labServ.update(labor);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteLabor")
	public @ResponseBody String deleteLabor(@RequestBody Labor labor) {

		try {
			if (labor.getLab_id() != 0) {
				labServ.delete(labor.getLab_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findLabor")
	public @ResponseBody Labor findCommerce(@RequestBody Labor labor) {
		Labor result = null;
		try {

			result = labServ.findLaborById(labor.getLab_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/userLabor",method=RequestMethod.GET)
	public ModelAndView displayuserLabor(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("userLabor");
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
	@RequestMapping(value="/nonLabor",method=RequestMethod.GET)
	public ModelAndView displaynonLabor(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		
					ModelAndView model = new ModelAndView("nonLabor");
					return model;
		}
	@RequestMapping(value="/superLabor",method=RequestMethod.GET)
	public ModelAndView displaysuperLabor(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superLabor");
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
