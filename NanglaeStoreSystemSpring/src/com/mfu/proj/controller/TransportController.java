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

import com.proj.ejb.entity.Transport;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.TransportService;

@Controller
public class TransportController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//TransportServiceBean!com.proj.ejb.face.TransportService")
	TransportService tranServ;

	@RequestMapping("/listTransport")
	public @ResponseBody List<Transport> listTransport(HttpServletRequest request) {

		List<Transport> tranList = null;
		try {
			tranList = tranServ.listAllTransport();

		} catch (Exception e) {

			e.printStackTrace();
		}

		return tranList;
	}

	@RequestMapping("/saveTransport")
	public @ResponseBody String saveTransport(@RequestBody Transport transport) {
		try {
			if (transport.getTran_id() == 0) {
				tranServ.save(transport);
			} else {
				tranServ.update(transport);
			}
		} catch (Exception e) {

			e.printStackTrace();
			return "-1";
		}

		return "1";
	}

	@RequestMapping("/deleteTransport")
	public @ResponseBody String deleteTransport(@RequestBody Transport transport) {

		try {
			if (transport.getTran_id() != 0) {
				tranServ.delete(transport.getTran_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findTransport")
	public @ResponseBody Transport findTransport(@RequestBody Transport transport) {
		Transport result = null;
		try {

			result = tranServ.findTransportById(transport.getTran_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/userTransport",method=RequestMethod.GET)
	public ModelAndView displayuserTransport(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("userTransport");
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
	@RequestMapping(value="/nonTransport",method=RequestMethod.GET)
	public ModelAndView displaynonTransport(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("nonTransport");
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
	@RequestMapping(value="/superTransport",method=RequestMethod.GET)
	public ModelAndView displaysuperTransport(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superTransport");
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
