package com.mfu.proj.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
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

import com.proj.ejb.entity.Agriculture;
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

	@RequestMapping(value = "/agriculture", method = RequestMethod.GET)
	public ModelAndView displayAgriculture(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("agriculture");

		return model;
	}

	@RequestMapping(value = "/nonAgriculture", method = RequestMethod.GET)
	public ModelAndView displaynonAgriculture(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("nonAgriculture");

		return model;
	}

	@RequestMapping(value = "/superAgriculture", method = RequestMethod.GET)
	public ModelAndView displaysuperAgriculture(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("superAgriculture");

		return model;
	}

	@RequestMapping(value = "/copy", method = RequestMethod.GET)
	public ModelAndView displaycopy(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("copy");

		return model;
	}

	

	
}
