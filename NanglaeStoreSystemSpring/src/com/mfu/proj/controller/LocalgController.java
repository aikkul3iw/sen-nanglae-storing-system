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

import com.proj.ejb.entity.Localg;
import com.proj.ejb.face.LocalgService;

@Controller
public class LocalgController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//LocalgServiceBean!com.proj.ejb.face.LocalgService")
	LocalgService grpServ;

	@RequestMapping("/listLocalg")
	public @ResponseBody List<Localg> listLocalg(HttpServletRequest request) {

		List<Localg> grpList = null;
		try {
			grpList = grpServ.listAllLocalg();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return grpList;
	}

	@RequestMapping("/saveLocalg")
	public @ResponseBody String saveLocalg(@RequestBody Localg localg) {
		try {
			if (localg.getGrp_id() == 0) {
				grpServ.save(localg);

			} else {
				grpServ.update(localg);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteLocalg")
	public @ResponseBody String deleteLocalg(@RequestBody Localg localg) {

		try {
			if (localg.getGrp_id() != 0) {
				grpServ.delete(localg.getGrp_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findLocalg")
	public @ResponseBody Localg findLocalg(@RequestBody Localg localg) {
		Localg result = null;
		try {

			result = grpServ.findLocalgById(localg.getGrp_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/group",method=RequestMethod.GET)
	public ModelAndView displayGroup(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("group");
		
		return model;
	}
}
