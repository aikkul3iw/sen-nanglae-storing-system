package com.mfu.proj.controller;

import java.util.List;

import javax.ejb.EJB;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proj.ejb.entity.Resource;
import com.proj.ejb.face.ResourceService;

@Controller
public class ResourceController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ResourceServiceBean!com.proj.ejb.face.ResourceService")
	ResourceService rscServ;

	@RequestMapping("/listResource")
	public @ResponseBody List<Resource> listResource(HttpServletRequest request) {

		List<Resource> rscList = null;
		try {
			rscList = rscServ.listAllResource();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return rscList;
	}

	@RequestMapping("/saveResource")
	public @ResponseBody String saveResource(@RequestBody Resource resource) {
		try {
			if (resource.getRsc_id() == 0) {
				rscServ.save(resource);

			} else {
				rscServ.update(resource);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteResource")
	public @ResponseBody String deleteResource(@RequestBody Resource resource) {

		try {
			if (resource.getRsc_id() != 0) {
				rscServ.delete(resource.getRsc_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findResource")
	public @ResponseBody Resource findResource(@RequestBody Resource resource) {
		Resource result = null;
		try {

			result = rscServ.findResourceById(resource.getRsc_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
}
