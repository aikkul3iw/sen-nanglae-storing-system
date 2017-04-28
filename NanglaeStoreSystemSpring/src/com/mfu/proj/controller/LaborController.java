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

import com.proj.ejb.entity.Labor;
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
	
	@RequestMapping(value="/labor",method=RequestMethod.GET)
	public ModelAndView displayLabor(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("labor");
		
		return model;
	}
}
