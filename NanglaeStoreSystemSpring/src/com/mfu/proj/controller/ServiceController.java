package com.mfu.proj.controller;

import java.util.List;

import javax.ejb.EJB;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.proj.ejb.entity.Service;
import com.proj.ejb.face.ServiceService;

@Controller
public class ServiceController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ServiceServiceBean!com.proj.ejb.face.ServiceService")
	ServiceService serServ;

	@RequestMapping("/listService")
	public @ResponseBody List<Service> listService(HttpServletRequest request) {

		List<Service> serList = null;
		try {
			serList = serServ.listAllService();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return serList;
	}

	@RequestMapping("/saveService")
	public @ResponseBody String saveService(@RequestBody Service service) {

		try {
			if (service.getSer_id() == 0) {
				serServ.save(service);

			} else {
				serServ.update(service);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteService")
	public @ResponseBody String deleteService(@RequestBody Service service) {

		try {
			if (service.getSer_id() != 0) {
				serServ.delete(service.getSer_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findService")
	public @ResponseBody Service findService(@RequestBody Service service) {
		Service result = null;
		try {

			result = serServ.findServiceById(service.getSer_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/service",method=RequestMethod.GET)
	public ModelAndView displayService(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("service");
		
		return model;
	}
	@RequestMapping(value="/nonService",method=RequestMethod.GET)
	public ModelAndView displaynonService(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("nonService");
		
		return model;
	}
}
