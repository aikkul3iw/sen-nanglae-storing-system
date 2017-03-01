package com.mfu.proj.controller;

import java.util.List;

import javax.ejb.EJB;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proj.ejb.entity.Village;
import com.proj.ejb.face.VillageService;

@Controller
public class VillageController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;

	@RequestMapping("/listVillage")
	public @ResponseBody List<Village> listVillage(HttpServletRequest request) {

		List<Village> vilList = null;
		try {
			vilList = vilServ.listAllVillage();

		} catch (Exception e) {

			e.printStackTrace();
		}

		return vilList;
	}

	@RequestMapping("/saveVillage")
	public @ResponseBody String saveVillage(@RequestBody Village village) {
		try {

			if (village.getVil_id() == 0) {
				vilServ.save(village);

			} else {
				vilServ.update(village);
			}
		} catch (Exception e) {

			e.printStackTrace();
			return "-1";
		}

		return "1";
	}

	@RequestMapping("/deleteVillage")
	public @ResponseBody String deleteVillage(@RequestBody Village village) {

		try {
			if (village.getVil_id() != 0) {
				vilServ.delete(village.getVil_id());
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findVillage")
	public @ResponseBody Village findVillage(@RequestBody Village village) {
		Village result = null;
		try {

			result = vilServ.findVillageById(village.getVil_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
}
