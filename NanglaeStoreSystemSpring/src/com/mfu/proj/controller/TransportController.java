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

import com.proj.ejb.entity.Transport;
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
	public ModelAndView displayuserTransport(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("userTransport");
		
		return model;
	}
	@RequestMapping(value="/nonTransport",method=RequestMethod.GET)
	public ModelAndView displaynonTransport(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("nonTransport");
		
		return model;
	}
	@RequestMapping(value="/superTransport",method=RequestMethod.GET)
	public ModelAndView displaysuperTransport(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("superTransport");
		
		return model;
	}
}
