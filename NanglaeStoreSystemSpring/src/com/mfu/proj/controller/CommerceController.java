package com.mfu.proj.controller;

import java.util.List;

import javax.ejb.EJB;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proj.ejb.entity.Commerce;
import com.proj.ejb.face.CommerceService;
import com.proj.ejb.face.VillageService;

@Controller
public class CommerceController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//CommerceServiceBean!com.proj.ejb.face.CommerceService")
	CommerceService comServ;

	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;

	@RequestMapping("/listCommerce")
	public @ResponseBody List<Commerce> listCommerce(HttpServletRequest request) {

		List<Commerce> comList = null;
		try {
			comList = comServ.listAllCommerce();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return comList;
	}

	@RequestMapping("/saveCommerce")
	public @ResponseBody String saveCommerce(@RequestBody Commerce commerce, HttpServletRequest request) {
		String mer = request.getParameter("id");
		try {
			if (commerce.getCom_id() == 0) {
				commerce.setLocation(vilServ.findVillageById(Long.parseLong(mer)));
				comServ.save(commerce);

			} else {
				commerce.setLocation(vilServ.findVillageById(Long.parseLong(mer)));
				comServ.update(commerce);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteCommerce")
	public @ResponseBody String deleteCommerce(@RequestBody Commerce commerce) {

		try {
			if (commerce.getCom_id() != 0) {
				comServ.delete(commerce.getCom_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findCommerce")
	public @ResponseBody Commerce findCommerce(@RequestBody Commerce commerce) {
		Commerce result = null;
		try {

			result = comServ.findCommerceById(commerce.getCom_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
}
