package com.mfu.proj.controller;

import java.util.Date;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.proj.ejb.entity.Activity;
import com.proj.ejb.entity.Pipeline;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.ActivityService;
import com.proj.ejb.face.PipelineService;
import com.proj.ejb.face.UserService;
import com.proj.ejb.face.VillageService;

@Controller
public class PipelineController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//PipelineServiceBean!com.proj.ejb.face.PipelineService")
	PipelineService pilineServ;

	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ActivityServiceBean!com.proj.ejb.face.ActivityService")
	ActivityService atvServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//UserServiceBean!com.proj.ejb.face.UserService")
	UserService userServ;

	@RequestMapping("/listPipeline")
	public @ResponseBody List<Pipeline> listPipeline(HttpServletRequest request) {

		List<Pipeline> pilineList = null;
		try {
			pilineList = pilineServ.listAllPipeline();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return pilineList;
	}

	@RequestMapping("/savePipeline")
	public @ResponseBody String savePipeline(@RequestBody Pipeline pipeline, HttpServletRequest request) {

		String piline = request.getParameter("id");

		try {

			if (pipeline.getPipe_id() == 0) {
				String id = request.getParameter("user");
				pipeline.setLocation(vilServ.findVillageById(Long.parseLong(piline)));
				pilineServ.save(pipeline);
				Activity atv = new Activity();
				atv.setUser(userServ.findUserById(Long.parseLong(id)));
				atv.setAtv_date(new Date());
				atv.setAtc_action("เพิ่ม");
				atv.setAtv_data("ระบบประปา");
				atvServ.save(atv);

			} else {
				String editid = request.getParameter("editUserId");
				pipeline.setLocation(vilServ.findVillageById(Long.parseLong(piline)));
				pilineServ.update(pipeline);
				Activity atv2 = new Activity();
				atv2.setUser(userServ.findUserById(Long.parseLong(editid)));
				atv2.setAtv_date(new Date());
				atv2.setAtc_action("แก้ไข");
				atv2.setAtv_data("ระบบประปา");
				atvServ.save(atv2);
			}
		} catch (Exception e) {

			e.printStackTrace();
			return "-1";
		}

		return "1";
	}

	@RequestMapping("/deletePipeline")
	public @ResponseBody String deletePipeline(@RequestBody Pipeline pipeline) {

		try {
			if (pipeline.getPipe_id() != 0) {
				pilineServ.delete(pipeline.getPipe_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findPipeline")
	public @ResponseBody Pipeline findPipeline(@RequestBody Pipeline pipeline) {
		Pipeline result = null;
		try {

			result = pilineServ.findPipelineById(pipeline.getPipe_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/userPipeline",method=RequestMethod.GET)
	public ModelAndView displayuserPipeline(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("userPipeline");
					User loginBean = new User();
					model.addObject("loginBean", loginBean);
					return model;
				}else{
					
					System.out.println("Hello World 2");
					ModelAndView model = new ModelAndView("loginUser");
					User loginBean = new User();
					model.addObject("loginBean", loginBean);
					return model;	
				}
		}
	@RequestMapping(value="/nonPipeline",method=RequestMethod.GET)
	public ModelAndView displaynonPipeline(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		
					ModelAndView model = new ModelAndView("nonPipeline");
					return model;
		}
	@RequestMapping(value="/superPipeline",method=RequestMethod.GET)
	public ModelAndView displaysuperPipeline(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superPipeline");
					User loginBean = new User();
					model.addObject("loginBean", loginBean);
					return model;
				}else{
					
					System.out.println("Hello World 2");
					ModelAndView model = new ModelAndView("loginUser");
					User loginBean = new User();
					model.addObject("loginBean", loginBean);
					return model;	
				}
		}
}
