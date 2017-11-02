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

import com.proj.ejb.entity.AIDSpatients;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.AIDSpatientsService;
import com.proj.ejb.face.VillageService;

@Controller
public class AIDSpatientsController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//AIDSpatientsServiceBean!com.proj.ejb.face.AIDSpatientsService")
	AIDSpatientsService comServ;

	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;

	@RequestMapping("/listAIDSpatients")
	public @ResponseBody List<AIDSpatients> listAIDSpatients(HttpServletRequest request) {

		List<AIDSpatients> comList = null;
		try {
			comList = comServ.listAllAIDSpatients();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return comList;
	}

	@RequestMapping("/saveAIDSpatients")
	public @ResponseBody String saveAIDSpatients(@RequestBody AIDSpatients AIDSpatients, HttpServletRequest request) {
		String mer = request.getParameter("id");
		try {
			if (AIDSpatients.getAIDSpatientsId() == 0) {
				AIDSpatients.setLocation(vilServ.findVillageById(Long.parseLong(mer)));
				comServ.save(AIDSpatients);

			} else {
				AIDSpatients.setLocation(vilServ.findVillageById(Long.parseLong(mer)));
				comServ.update(AIDSpatients);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteAIDSpatients")
	public @ResponseBody String deleteAIDSpatients(@RequestBody AIDSpatients AIDSpatients) {

		try {
			if (AIDSpatients.getAIDSpatientsId() != 0) {
				comServ.delete(AIDSpatients.getAIDSpatientsId());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findAIDSpatients")
	public @ResponseBody AIDSpatients findAIDSpatients(@RequestBody AIDSpatients AIDSpatients) {
		AIDSpatients result = null;
		try {

			result = comServ.findAIDSpatientsById(AIDSpatients.getAIDSpatientsId());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/userAIDSpatients",method=RequestMethod.GET)
	public ModelAndView displayuserAIDSpatients(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("userAIDSpatients");
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
	@RequestMapping(value="/nonAIDSpatients",method=RequestMethod.GET)
	public ModelAndView displaynonAIDSpatients(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		
					ModelAndView model = new ModelAndView("nonAIDSpatients");
					
					return model;
				
		}
	@RequestMapping(value="/superAIDSpatients",method=RequestMethod.GET)
	public ModelAndView displaysuperAIDSpatients(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superAIDSpatients");
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
