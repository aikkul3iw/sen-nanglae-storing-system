package com.mfu.proj.controller;

import java.util.List;

import javax.ejb.EJB;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
}
