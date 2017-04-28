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

import com.proj.ejb.entity.Water;
import com.proj.ejb.face.VillageService;
import com.proj.ejb.face.WaterService;

@Controller
public class WaterController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//WaterServiceBean!com.proj.ejb.face.WaterService")
	WaterService wtServ;

	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;

	@RequestMapping("/listWater")
	public @ResponseBody List<Water> listWater(HttpServletRequest request) {

		List<Water> wtList = null;
		try {
			wtList = wtServ.listAllWater();

		} catch (Exception e) {

			e.printStackTrace();
		}

		return wtList;
	}

	@RequestMapping("/saveWater")
	public @ResponseBody String saveWater(@RequestBody Water water, HttpServletRequest request) {

		String wt = request.getParameter("id");
		try {
			if (water.getWater_id() == 0) {
				water.setLocation(vilServ.findVillageById(Long.parseLong(wt)));
				wtServ.save(water);

			} else {
				water.setLocation(vilServ.findVillageById(Long.parseLong(wt)));
				wtServ.update(water);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteWater")
	public @ResponseBody String deleteWater(@RequestBody Water water) {

		try {
			if (water.getWater_id() != 0) {
				wtServ.delete(water.getWater_id());
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findWater")
	public @ResponseBody Water findWater(@RequestBody Water water) {
		Water result = null;
		try {

			result = wtServ.findWaterById(water.getWater_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/waterresource",method=RequestMethod.GET)
	public ModelAndView displayWaterresource(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("waterresource");
		
		return model;
	}
}
